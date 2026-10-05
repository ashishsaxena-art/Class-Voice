CREATE DATABASE IF NOT EXISTS classvoice_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE classvoice_db;

CREATE TABLE IF NOT EXISTS users (
  user_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(190) NOT NULL UNIQUE,
  password VARCHAR(500) NOT NULL,
  role ENUM('teacher','student') NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS lectures (
  lecture_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  teacher_id BIGINT NOT NULL,
  title VARCHAR(180) NOT NULL,
  description VARCHAR(500),
  lecture_date DATE NOT NULL,
  status ENUM('active','inactive') NOT NULL DEFAULT 'inactive',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_lecture_teacher FOREIGN KEY (teacher_id) REFERENCES users(user_id) ON DELETE CASCADE,
  INDEX idx_lecture_teacher (teacher_id), INDEX idx_lecture_status (status)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS topics (
  topic_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  lecture_id BIGINT NOT NULL,
  topic_name VARCHAR(150) NOT NULL,
  description VARCHAR(300),
  CONSTRAINT fk_topic_lecture FOREIGN KEY (lecture_id) REFERENCES lectures(lecture_id) ON DELETE CASCADE,
  CONSTRAINT uq_topic_name UNIQUE (lecture_id, topic_name),
  INDEX idx_topic_lecture (lecture_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS topic_keywords (
  keyword_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  topic_id BIGINT NOT NULL,
  keyword VARCHAR(100) NOT NULL,
  CONSTRAINT fk_keyword_topic FOREIGN KEY (topic_id) REFERENCES topics(topic_id) ON DELETE CASCADE,
  CONSTRAINT uq_topic_keyword UNIQUE (topic_id, keyword),
  INDEX idx_keyword_topic (topic_id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS feedback (
  feedback_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  lecture_id BIGINT NOT NULL,
  student_id BIGINT NOT NULL,
  topic_id BIGINT NULL,
  feedback_text VARCHAR(1000) NOT NULL,
  submitted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_feedback_lecture FOREIGN KEY (lecture_id) REFERENCES lectures(lecture_id) ON DELETE CASCADE,
  CONSTRAINT fk_feedback_student FOREIGN KEY (student_id) REFERENCES users(user_id) ON DELETE CASCADE,
  CONSTRAINT fk_feedback_topic FOREIGN KEY (topic_id) REFERENCES topics(topic_id) ON DELETE SET NULL,
  INDEX idx_feedback_lecture (lecture_id), INDEX idx_feedback_topic (topic_id), INDEX idx_feedback_student (student_id)
) ENGINE=InnoDB;

-- Demo accounts. Password format is salt:SHA-256(salt + password), generated for this demo only.
INSERT INTO users(name,email,password,role) VALUES
('Demo Teacher','teacher1@classvoice.com','6z+Iv9onXnwi6j42H6h2Yw==:e8NL9sGo/Ts3P/0nJXqGuVqG2goktNkA8p4amkVbVWA=','teacher'),
('Demo Student 1','student1@classvoice.com','5+Wrw/rSA4w9Af3KfArZAQ==:KTb1hJnRSVINqtXC8Z5yHXru387E0KNG0TpnLdf4WWE=','student'),
('Demo Student 2','student2@classvoice.com','5+Wrw/rSA4w9Af3KfArZAQ==:KTb1hJnRSVINqtXC8Z5yHXru387E0KNG0TpnLdf4WWE=','student'),
('Demo Student 3','student3@classvoice.com','5+Wrw/rSA4w9Af3KfArZAQ==:KTb1hJnRSVINqtXC8Z5yHXru387E0KNG0TpnLdf4WWE=','student');

INSERT INTO lectures(teacher_id,title,description,lecture_date,status)
SELECT user_id,'Database Management System','Demo lecture for testing ClassVoice topic matching and analytics.',CURDATE(),'active'
FROM users WHERE email='teacher1@classvoice.com';

INSERT INTO topics(lecture_id,topic_name,description)
SELECT lecture_id,'Normalization','Normal forms and reducing redundancy.' FROM lectures WHERE title='Database Management System'
UNION ALL SELECT lecture_id,'SQL Joins','Combining rows from related tables.' FROM lectures WHERE title='Database Management System'
UNION ALL SELECT lecture_id,'Transactions','ACID properties, commit and rollback.' FROM lectures WHERE title='Database Management System'
UNION ALL SELECT lecture_id,'Functional Dependencies','Relationships among attributes used in normalization.' FROM lectures WHERE title='Database Management System';

INSERT INTO topic_keywords(topic_id,keyword)
SELECT t.topic_id,k.keyword FROM topics t JOIN (
  SELECT 'Normalization' topic,'normalization' keyword UNION ALL SELECT 'Normalization','1NF' UNION ALL SELECT 'Normalization','2NF' UNION ALL SELECT 'Normalization','3NF' UNION ALL SELECT 'Normalization','normal form'
  UNION ALL SELECT 'SQL Joins','join' UNION ALL SELECT 'SQL Joins','inner join' UNION ALL SELECT 'SQL Joins','left join' UNION ALL SELECT 'SQL Joins','right join' UNION ALL SELECT 'SQL Joins','outer join'
  UNION ALL SELECT 'Transactions','transaction' UNION ALL SELECT 'Transactions','ACID' UNION ALL SELECT 'Transactions','commit' UNION ALL SELECT 'Transactions','rollback' UNION ALL SELECT 'Transactions','concurrency'
  UNION ALL SELECT 'Functional Dependencies','functional dependency' UNION ALL SELECT 'Functional Dependencies','dependency' UNION ALL SELECT 'Functional Dependencies','determinant' UNION ALL SELECT 'Functional Dependencies','attribute dependency'
) k ON k.topic=t.topic_name JOIN lectures l ON l.lecture_id=t.lecture_id AND l.title='Database Management System';

INSERT INTO feedback(lecture_id,student_id,topic_id,feedback_text)
SELECT l.lecture_id,s.user_id,t.topic_id,'I did not understand normalization and 2NF.' FROM lectures l JOIN users s ON s.email='student1@classvoice.com' JOIN topics t ON t.lecture_id=l.lecture_id AND t.topic_name='Normalization' WHERE l.title='Database Management System'
UNION ALL SELECT l.lecture_id,s.user_id,t.topic_id,'3NF is confusing to me.' FROM lectures l JOIN users s ON s.email='student2@classvoice.com' JOIN topics t ON t.lecture_id=l.lecture_id AND t.topic_name='Normalization' WHERE l.title='Database Management System'
UNION ALL SELECT l.lecture_id,s.user_id,t.topic_id,'I need another explanation of inner join and left join.' FROM lectures l JOIN users s ON s.email='student3@classvoice.com' JOIN topics t ON t.lecture_id=l.lecture_id AND t.topic_name='SQL Joins' WHERE l.title='Database Management System'
UNION ALL SELECT l.lecture_id,s.user_id,t.topic_id,'I do not understand rollback and commit.' FROM lectures l JOIN users s ON s.email='student1@classvoice.com' JOIN topics t ON t.lecture_id=l.lecture_id AND t.topic_name='Transactions' WHERE l.title='Database Management System'
UNION ALL SELECT l.lecture_id,s.user_id,t.topic_id,'Functional dependency and determinant are unclear.' FROM lectures l JOIN users s ON s.email='student2@classvoice.com' JOIN topics t ON t.lecture_id=l.lecture_id AND t.topic_name='Functional Dependencies' WHERE l.title='Database Management System'
UNION ALL SELECT l.lecture_id,s.user_id,NULL,'The last example was difficult but I cannot identify the topic.' FROM lectures l JOIN users s ON s.email='student3@classvoice.com' WHERE l.title='Database Management System';

-- Optional local DB account for non-Docker setup. Remove/comment if your MySQL user policy disallows it.
CREATE USER IF NOT EXISTS 'classvoice'@'%' IDENTIFIED BY 'ClassVoice@123';
GRANT ALL PRIVILEGES ON classvoice_db.* TO 'classvoice'@'%';
FLUSH PRIVILEGES;
