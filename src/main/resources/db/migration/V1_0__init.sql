DROP TABLE IF EXISTS T_BOOK;

CREATE TABLE T_BOOK (
  ID       INTEGER      NOT NULL PRIMARY KEY,
  TITLE    VARCHAR(128) NOT NULL,
  AUTHORS   VARCHAR(128)
);

INSERT INTO T_BOOK (ID, TITLE, AUTHORS) VALUES (1, 'Design Pattern', 'Erich Gamma, John Vlissides, Ralph E.. Johnson et Richard Helm');

INSERT INTO T_BOOK (ID, TITLE, AUTHORS) VALUES (2, 'Effective Java', 'Joshua Bloch');

INSERT INTO T_BOOK (ID, TITLE, AUTHORS) VALUES (3, 'The C++ Programming Language', 'Bjarne Stroustrup');

INSERT INTO T_BOOK (ID, TITLE) VALUES (4, 'Delphi');

INSERT INTO T_BOOK (ID, TITLE) VALUES (5, 'Turbo C++');

INSERT INTO T_BOOK (ID, TITLE) VALUES (6, 'D');