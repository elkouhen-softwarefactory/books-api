DROP TABLE IF EXISTS T_BOOK;

CREATE TABLE T_BOOK (
  ID       INTEGER      NOT NULL PRIMARY KEY,
  TITLE    VARCHAR(128) NOT NULL,
  AUTHORS   VARCHAR(128)
);

INSERT INTO T_BOOK (ID, TITLE, AUTHORS) VALUES (1, 'Design Pattern', 'Erich Gamma, John Vlissides, Ralph E.. Johnson et Richard Helm');

-- INSERT INTO T_BOOK (ID, TITLE, AUTHORS) VALUES (2, 'Effective Java', 'Joshua Bloch');

-- INSERT INTO T_BOOK (ID, TITLE, AUTHORS) VALUES (3, 'Specification by Example', 'Gojko Adzic');

-- INSERT INTO T_BOOK (ID, TITLE, AUTHORS) VALUES (4, 'The Clean Coder: A Code of Conduct for Professional Programmers', 'Robert C. Martin');

-- INSERT INTO T_BOOK (ID, TITLE, AUTHORS) VALUES (5, 'Refactoring', 'Martin Fowler');

-- INSERT INTO T_BOOK (ID, TITLE, AUTHORS) VALUES (6, 'Refactoring Java', 'Martin Fowler');

-- INSERT INTO T_BOOK (ID, TITLE, AUTHORS) VALUES (7, 'Refactoring Java', 'Martin Fowler');