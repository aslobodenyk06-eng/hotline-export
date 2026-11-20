import os
import sqlite3

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DB_PATH = os.environ.get("DB_PATH", os.path.join(BASE_DIR, "shop.db"))


def connect():
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA foreign_keys = ON")
    return conn


def init_db(force=False):
    if force and os.path.exists(DB_PATH):
        os.remove(DB_PATH)
    conn = connect()
    with open(os.path.join(BASE_DIR, "schema.sql"), encoding="utf-8") as f:
        conn.executescript(f.read())
    if conn.execute("SELECT COUNT(*) FROM product").fetchone()[0] == 0:
        with open(os.path.join(BASE_DIR, "seed.sql"), encoding="utf-8") as f:
            conn.executescript(f.read())
    conn.commit()
    conn.close()


if __name__ == "__main__":
    init_db(force=True)
    print("База даних створена:", DB_PATH)
