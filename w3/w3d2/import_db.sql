DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(100) NOT NULL,
  lname VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS questions;

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS replies;

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_likes;

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Terry', 'OShea'),
  ('John', 'Shade'),
  ('Charles', 'Kinbote'),
  ('Clarissa', 'Dalloway');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('Why', 'is a raven like a writing desk?', (SELECT id FROM users WHERE fname = 'Terry' AND lname = 'OShea')),
  ('How high', 'does the sycamore grow?', (SELECT id FROM users WHERE fname = 'John' AND lname = 'Shade')),
  ('Who', 'is John Galt?', (SELECT id FROM users WHERE fname = 'Charles' AND lname = 'Kinbote')),
  ('To be', 'or not to be?', (SELECT id FROM users WHERE fname = 'Clarissa' AND lname = 'Dalloway'));

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Terry' AND lname = 'OShea'), (SELECT id FROM questions WHERE title = 'Who')),
  ((SELECT id FROM users WHERE fname = 'John' AND lname = 'Shade'), (SELECT id FROM questions WHERE title = 'To be')),
  ((SELECT id FROM users WHERE fname = 'Charles' AND lname = 'Kinbote'), (SELECT id FROM questions WHERE title = 'How high')),
  ((SELECT id FROM users WHERE fname = 'Clarissa' AND lname = 'Dalloway'), (SELECT id FROM questions WHERE title = 'Why')),
  ((SELECT id FROM users WHERE fname = 'John' AND lname = 'Shade'), (SELECT id FROM questions WHERE title = 'Who')),
  ((SELECT id FROM users WHERE fname = 'Charles' AND lname = 'Kinbote'), (SELECT id FROM questions WHERE title = 'Who')),
  ((SELECT id FROM users WHERE fname = 'Clarissa' AND lname = 'Dalloway'), (SELECT id FROM questions WHERE title = 'How high'));

INSERT INTO
  replies (body, question_id, parent_reply_id, user_id)
VALUES
  ('Poe wrote on them.', 1, NULL, 4),
  ('42 feet.', 2, NULL, 3),
  ('That is the question: ', 3, NULL, 2),
  ('Whether tis nobler in the mind to suffer', 3, 3, 1),
  ('The slings and arrows of outrageous fortune...', 3, 4, 2);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (3, 4),
  (2, 4),
  (1, 4),
  (4, 1),
  (2, 3),
  (2, 2);
