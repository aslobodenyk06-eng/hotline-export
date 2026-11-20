from datetime import datetime
from zoneinfo import ZoneInfo
from xml.etree import ElementTree as ET

from db import connect


def _text(parent, tag, value, **attrs):
    el = ET.SubElement(parent, tag, {k: str(v) for k, v in attrs.items()})
    el.text = "" if value is None else str(value)
    return el


def build_hotline_xml():
    conn = connect()
    shop = conn.execute("SELECT * FROM shop LIMIT 1").fetchone()
    categories = conn.execute("SELECT * FROM category ORDER BY id").fetchall()
    products = conn.execute("SELECT * FROM product ORDER BY id").fetchall()
    params = conn.execute("SELECT * FROM product_param ORDER BY product_id, id").fetchall()
    conn.close()

    params_by_product = {}
    for p in params:
        params_by_product.setdefault(p["product_id"], []).append(p)

    root = ET.Element("price")
    _text(root, "date", datetime.now(ZoneInfo("Europe/Kyiv")).strftime("%Y-%m-%d %H:%M"))
    _text(root, "firmName", shop["firm_name"])
    _text(root, "firmId", shop["firm_id"])
    _text(root, "rate", shop["rate_usd"])

    cats = ET.SubElement(root, "categories")
    for c in categories:
        cat = ET.SubElement(cats, "category")
        _text(cat, "id", c["id"])
        if c["parent_id"] is not None:
            _text(cat, "parentId", c["parent_id"])
        _text(cat, "name", c["name"])

    items = ET.SubElement(root, "items")
    for p in products:
        item = ET.SubElement(items, "item")
        _text(item, "id", p["id"])
        _text(item, "categoryId", p["category_id"])
        _text(item, "code", p["code"])
        if p["barcode"]:
            _text(item, "barcode", p["barcode"])
        _text(item, "vendor", p["vendor"])
        _text(item, "name", p["name"])
        _text(item, "description", p["description"])
        _text(item, "url", p["url"])
        _text(item, "image", p["image"])
        _text(item, "priceRUAH", f'{p["price_uah"]:.0f}')
        _text(item, "priceRUSD", f'{p["price_uah"] / shop["rate_usd"]:.2f}')
        _text(item, "stock", p["stock"])
        if p["shipping_days"]:
            _text(item, "shipping", p["shipping_days"])
        _text(item, "guarantee", p["guarantee_months"], type="manufacturer")
        if p["condition"]:
            _text(item, "condition", p["condition"])
        for prm in params_by_product.get(p["id"], []):
            _text(item, "param", prm["value"], name=prm["name"])

    ET.indent(root, space="  ")
    body = ET.tostring(root, encoding="unicode")
    return '<?xml version="1.0" encoding="UTF-8"?>\n' + body + "\n"
