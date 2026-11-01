-- ClassVoice schema for MySQL 8 and TiDB Cloud Starter (MySQL compatible).
-- Rerunnable, non-destructive schema setup.
-- No CREATE USER / GRANT statements (managed cloud user from TiDB Connect page).
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
