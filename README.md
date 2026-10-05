# ClassVoice

ClassVoice is a beginner-friendly MCA mini-project for anonymous post-lecture feedback. Students log in so access can be controlled, but teacher-facing feedback results do not display student identity. Feedback is mapped to predefined lecture topics with a simple rule-based keyword matcher; no ML, AI, or NLP API is used.

## Stack

- Java 17+
- JSP + Jakarta Servlets 6
- Apache Tomcat 10.1
- MySQL 8.x
- JDBC
- Bootstrap 5
- MVC + DAO + three-tier architecture
- Maven WAR build

## Project structure

```text
ClassVoice/
├── pom.xml
├── Dockerfile
├── docker-compose.yml
├── database/classvoice_db.sql
├── docs/TEST_CASES.md
├── .github/workflows/build.yml
└── src/main/
    ├── java/com/classvoice/
    │   ├── controller/       # Servlets
    │   ├── dao/              # SQL/data access
    │   ├── model/            # POJOs
    │   ├── service/          # Topic matching
    │   ├── filter/           # Authentication/role filter
    │   └── util/             # DB/password helpers
    └── webapp/
        ├── index.jsp
        ├── login.jsp
        ├── register.jsp
        ├── error.jsp
        ├── css/style.css
        ├── js/app.js
        └── WEB-INF/
            ├── web.xml
            ├── includes/
            └── views/
```

## Fastest run: Docker

Install Docker Desktop, then from the project folder:

```bash
docker compose up --build
```

Open `http://localhost:8080/ClassVoice/`.

The compose file starts MySQL, waits for it to become healthy, initializes the database, builds the WAR with Maven, and deploys it to Tomcat 10.1.

To stop it:

```bash
docker compose down
```

To also remove the database volume and reset demo data:

```bash
docker compose down -v
```

## Run without Docker

### 1. MySQL

Run:

```bash
mysql -u root -p < database/classvoice_db.sql
```

The script creates `classvoice_db`, the `classvoice` application user, tables, and clearly marked demo data. If your local MySQL policy does not allow `CREATE USER`, create the database/tables manually or remove those three account/grant statements from the bottom of the SQL file.

### 2. Configure DB

The application reads these environment variables:

```text
CLASSVOICE_DB_URL=jdbc:mysql://localhost:3306/classvoice_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
CLASSVOICE_DB_USER=classvoice
CLASSVOICE_DB_PASSWORD=ClassVoice@123
```

If they are not set, those demo/local defaults are used. Change them for your own environment.

### 3. Build

Requires Maven and Java 17+:

```bash
mvn clean package
```

WAR output:

```text
target/ClassVoice.war
```

Copy that WAR to Tomcat 10.1 `webapps/` and start Tomcat. Open:

```text
http://localhost:8080/ClassVoice/
```

**Tomcat 10.1 is required. Do not use Tomcat 9**, because this project uses `jakarta.servlet.*`.

## Demo accounts

| Role | Email | Password |
|---|---|---|
| Teacher | teacher1@classvoice.com | Teacher@123 |
| Student | student1@classvoice.com | Student@123 |
| Student | student2@classvoice.com | Student@123 |
| Student | student3@classvoice.com | Student@123 |

These credentials and all seeded feedback are demo/test data only.

## Workflow

Teacher:

1. Register/login.
2. Create lecture.
3. Add topics.
4. Add comma-separated keywords to each topic.
5. Activate lecture.
6. Open Analysis to see counts, percentages, and anonymous feedback text.
7. End lecture when feedback collection should stop.

Student:

1. Register/login.
2. Open an active lecture.
3. Answer “What did you not understand in today's lecture?”
4. Submit.
5. Optionally view personal history.

## Matching algorithm

1. Lowercase feedback.
2. For every topic, compare predefined keywords.
3. Count each keyword at most once when it appears as a standalone word/phrase.
4. Highest score wins.
5. If there is no match, `topic_id` is NULL and the UI shows `Other / Uncategorized`.
6. Ties keep the first topic in database order.

This is deliberately explainable and not semantic NLP.

## Security basics

- Session-based authentication.
- Teacher/student role authorization filter.
- Passwords stored as salted SHA-256 hashes.
- Prepared SQL statements.
- Server-side validation.
- Protected JSP views under `WEB-INF`.
- Logout invalidates the session.
- No teacher-facing query exposes student identity beside feedback.

This is a college mini-project, not enterprise-grade security or a legally guaranteed anonymous system.

## GitHub

```bash
git init
git add .
git commit -m "Build complete ClassVoice MVC application"
git branch -M main
git remote add origin YOUR_GITHUB_REPOSITORY_URL
git push -u origin main
```

GitHub Actions is included at `.github/workflows/build.yml` and builds the WAR on pushes and pull requests.

## Limitations

Keyword matching can miss feedback expressed with unrelated wording. The application reports information; it does not automatically decide that a teacher must reteach a topic. It is a mini-project prototype, not a complete LMS.
