CREATE TABLE IF NOT EXISTS shop (
    id INTEGER PRIMARY KEY,
    firm_name TEXT NOT NULL,
    firm_id INTEGER NOT NULL,
    site_url TEXT NOT NULL,
    rate_usd REAL NOT NULL
);
CREATE TABLE IF NOT EXISTS category (
    id INTEGER PRIMARY KEY,
    parent_id INTEGER REFERENCES category(id),
    name TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS product (
    id INTEGER PRIMARY KEY,
    category_id INTEGER NOT NULL REFERENCES category(id),
    code TEXT NOT NULL UNIQUE,
    barcode TEXT,
    vendor TEXT NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    url TEXT NOT NULL,
    image TEXT,
    price_uah REAL NOT NULL CHECK (price_uah > 0),
    stock TEXT NOT NULL CHECK (stock IN ('В наявності', 'Під замовлення', 'Немає')),
    guarantee_months INTEGER NOT NULL DEFAULT 12,
    shipping_days INTEGER,
    condition INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE IF NOT EXISTS product_param (
    id INTEGER PRIMARY KEY,
    product_id INTEGER NOT NULL REFERENCES product(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    value TEXT NOT NULL
);
