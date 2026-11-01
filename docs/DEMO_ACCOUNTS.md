# ClassVoice demo logins

These are **fictional test profiles**, not the personal information of actual students or teachers. The `.example` domain is reserved for demos and cannot receive email. Every account has its own password. **Do not use these credentials for actual staff/student records or enable them in production.**

| Role | Name | Email | Password |
|---|---|---|---|
| Teacher | Dr. Ananya Sharma | `ananya.sharma@classvoice.example` | `Ananya@2026!` |
| Teacher | Prof. Rahul Verma | `rahul.verma@classvoice.example` | `Rahul@2026!` |
| Student | Aditi Gupta | `aditi.gupta@classvoice.example` | `Aditi@2026!` |
| Student | Aarav Mehta | `aarav.mehta@classvoice.example` | `Aarav@2026!` |
| Student | Kavya Singh | `kavya.singh@classvoice.example` | `Kavya@2026!` |
| Student | Rohan Patel | `rohan.patel@classvoice.example` | `Rohan@2026!` |
| Student | Neha Kapoor | `neha.kapoor@classvoice.example` | `Neha@2026!` |

Import `database/01_schema.sql` then `database/02_seed_demo.sql` into the MySQL-compatible database. Or import the one-file `database/classvoice_db.sql`. Running the seed again does not reset passwords for existing users.

Demo teacher **Dr. Ananya Sharma** has an active **Database Management System** lecture; **Prof. Rahul Verma** has an active **Core Java Programming** lecture. Student accounts can submit feedback to either lecture.
