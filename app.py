import os

from flask import Flask, Response, jsonify, render_template_string
from lxml import etree

from db import connect, init_db
from exporter import build_hotline_xml

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
app = Flask(__name__)
app.json.ensure_ascii = False
init_db()
INDEX_HTML = """<!doctype html>
<html lang="uk">
<head>
<meta charset="utf-8">
<title>{{ shop.firm_name }} — експорт для Hotline.ua</title>
<style>
body { font-family: Arial, sans-serif; margin: 40px; color: #222; }
a.btn { display: inline-block; margin: 6px 8px 6px 0; padding: 10px 16px; background: #1f5fbf; color: #fff; text-decoration: none; border-radius: 6px; }
code { background: #f1f1f1; padding: 2px 6px; border-radius: 4px; }
</style>
</head>
<body>
<h1>{{ shop.firm_name }}: експорт товарів у формат Hotline.ua</h1>
<p>Товарів у базі даних: <b>{{ count }}</b>. Ідентифікатор магазину на Hotline: <b>{{ shop.firm_id }}</b>.</p>
<p>
<a class="btn" href="/export/hotline.xml">XML для Hotline</a>
<a class="btn" href="/export/hotline.html">Перегляд через XSLT</a>
<a class="btn" href="/api/products">REST API (JSON)</a>
</p>
<p>Адреса для підключення прайс-листа в кабінеті Hotline: <code>/export/hotline.xml</code></p>
</body>
</html>
"""
XSLT = etree.XSLT(etree.parse(os.path.join(BASE_DIR, "hotline.xsl")))


@app.route("/")
def index():
    conn = connect()
    shop = conn.execute("SELECT * FROM shop LIMIT 1").fetchone()
    count = conn.execute("SELECT COUNT(*) FROM product").fetchone()[0]
    conn.close()
    return render_template_string(INDEX_HTML, shop=shop, count=count)


@app.route("/export/hotline.xml")
@app.route("/export/")
def export_xml():
    return Response(build_hotline_xml(), mimetype="application/xml")


@app.route("/export/hotline.html")
def export_html():
    doc = etree.fromstring(build_hotline_xml().encode("utf-8"))
    return Response(str(XSLT(doc)), mimetype="text/html")


@app.route("/api/products")
def api_products():
    conn = connect()
    rows = conn.execute(
        "SELECT p.id, p.code, p.vendor, p.name, c.name AS category, p.price_uah, p.stock "
        "FROM product p JOIN category c ON c.id = p.category_id ORDER BY p.id"
    ).fetchall()
    conn.close()
    return jsonify([dict(r) for r in rows])


@app.route("/health")
def health():
    return {"status": "ok"}


if __name__ == "__main__":
    cert = os.path.join(BASE_DIR, "certs", "cert.pem")
    key = os.path.join(BASE_DIR, "certs", "key.pem")
    port = int(os.environ.get("PORT", 8443))
    ssl = (cert, key) if os.path.exists(cert) else None
    app.run(host="0.0.0.0", port=port, ssl_context=ssl)
