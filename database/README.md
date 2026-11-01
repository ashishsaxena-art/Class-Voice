# Database scripts

- `01_schema.sql`: MySQL / TiDB Cloud Starter schema. Uses `CREATE TABLE IF NOT EXISTS`; no destructive drops.
- `02_seed_demo.sql`: seven realistic *fictional* accounts, two active lectures, topics, keyword matching, and example feedback. Safe to rerun, does not change passwords for existing accounts.
- `03_verify.sql`: run to inspect demo accounts and their lectures.
- `classvoice_db.sql`: combined schema and demo seed for a one-shot import / Docker Compose.

**Cloud DB:** Create a MySQL-compatible TiDB Cloud Starter instance. Create/select `classvoice_db` using the SQL script. Do not run `CREATE USER` or `GRANT` in TiDB Cloud; the database provider gives you the SQL username and password under **Connect**. Configure the app with `CLASSVOICE_DB_URL`, `CLASSVOICE_DB_USER`, and `CLASSVOICE_DB_PASSWORD` in Render. Use `sslMode=VERIFY_IDENTITY` for the TiDB JDBC URL.

**Existing database:** These scripts do not remove old lectures or old demo logins. They add the named demo users. `INSERT IGNORE` means existing demo users keep their passwords if you imported this once before; for a brand-new database, the passwords in `docs/DEMO_ACCOUNTS.md` work.

**Local MySQL:** Docker Compose creates the local user `classvoice` for you. For a manually installed MySQL server, create a MySQL account with privileges on `classvoice_db` as your local administrator (do not run cloud user grants). Never commit hosted SQL credentials to GitHub.
