def get_user(conn, name):
    return conn.execute(f"SELECT * FROM users WHERE name = '{name}'").fetchone()
