# ClassVoice test cases

## Authentication

| ID | Test | Expected |
|---|---|---|
| A01 | Correct demo teacher login | Teacher dashboard opens |
| A02 | Correct demo student login | Student dashboard opens |
| A03 | Wrong password | Error shown; no session created |
| A04 | Empty login | Validation/error shown |
| A05 | Logout | Session invalidated and landing page shown |
| A06 | Unauthenticated `/teacher/dashboard` | Redirected to login |
| A07 | Student opens teacher URL | Redirected to student dashboard |
| A08 | Teacher opens student URL | Redirected to teacher dashboard |

## Teacher

| ID | Test | Expected |
|---|---|---|
| T01 | Create lecture with valid data | Lecture created as inactive |
| T02 | Empty/short title | Server rejects |
| T03 | Add topic | Topic appears on manage page |
| T04 | Add comma-separated keywords | Keywords appear as chips |
| T05 | Activate lecture | Students can see it |
| T06 | End lecture | Students cannot submit it |
| T07 | Open analysis | Counts and percentages displayed |
| T08 | Try another teacher's lecture by ID | 404/denied |

## Student

| ID | Test | Expected |
|---|---|---|
| S01 | View active lectures | Active lectures shown |
| S02 | Submit valid feedback | Success page and mapped topic shown |
| S03 | Submit empty feedback | Rejected |
| S04 | Submit >1000 chars | Rejected |
| S05 | Submit after lecture ended | Rejected |
| S06 | Submit text with no matching keyword | Stored as Other / Uncategorized |
| S07 | Open own history | Own submitted feedback shown |

## Matching

| ID | Input | Expected |
|---|---|---|
| M01 | `I do not understand 2NF` | Normalization |
| M02 | `inner join and left join are confusing` | SQL Joins, score 2 |
| M03 | `rollback and commit` | Transactions, score 2 |
| M04 | `functional dependency` | Functional Dependencies |
| M05 | `NORMALIZATION` | Normalization (case-insensitive) |
| M06 | unrelated sentence | Other / Uncategorized |

## Database

Check that foreign keys prevent orphan topics/feedback, duplicate emails are rejected, duplicate topic names within one lecture are rejected, and SQL injection-style input is treated as data because DAOs use prepared statements.
