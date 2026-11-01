-- Run after importing 01_schema.sql and 02_seed_demo.sql.
USE classvoice_db;
SELECT email, name, role FROM users WHERE email LIKE '%@classvoice.example' ORDER BY role, name;
SELECT u.name AS teacher_name, l.title, l.status, COUNT(DISTINCT t.topic_id) AS topics,
  COUNT(DISTINCT f.feedback_id) AS feedback_count
FROM lectures l JOIN users u ON u.user_id=l.teacher_id
LEFT JOIN topics t ON t.lecture_id=l.lecture_id
LEFT JOIN feedback f ON f.lecture_id=l.lecture_id
WHERE u.email IN ('ananya.sharma@classvoice.example', 'rahul.verma@classvoice.example')
GROUP BY u.name, l.lecture_id, l.title, l.status;
