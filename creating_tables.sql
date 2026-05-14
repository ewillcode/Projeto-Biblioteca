CREATE TABLE authors (
  author_id       SERIAL PRIMARY KEY,
  first_name      VARCHAR(50) NOT NULL,
  last_name       VARCHAR(50) NOT NULL,
  birth_date      DATE
);

CREATE TABLE publishers (
  publisher_id    SERIAL PRIMARY KEY,
  address         TEXT NOT NULL
);

CREATE TABLE members (
  member_id       SERIAL PRIMARY KEY,
  full_name       VARCHAR(100) NOT NULL,
  email           VARCHAR(100) NOT NUll,
  phone           VARCHAR(20) NOT NULL,
  membership_start DATE NOT NULL,
  membership_end  DATE NOT NULL
);

CREATE TABLE genres (
  genre_id        SERIAL PRIMARY KEY,
  name            VARCHAR(50) NOT NULL
);

CREATE TABLE books (
  book_id         SERIAL PRIMARY KEY,
  pub_year        INT NOT NULL,
  title           VARCHAR(200) NOT NULL,
  isbn            VARCHAR(13) UNIQUE,
  genre_id        INT NOT NULL REFERENCES genres(genre_id),
  author_id       INT NOT NULL REFERENCES authors(author_id) ON DELETE CASCADE,
  publisher_id    INT NOT NULL REFERENCES publishers(publisher_id)
);
  
CREATE TABLE libraries (
  library_id      SERIAL PRIMARY KEY,
  name            VARCHAR(100) NOT NULL,
  address         TEXT NOT NULL
);

CREATE TABLE book_copies (
  book_copy_id    SERIAL PRIMARY KEY,
  status          VARCHAR(20) NOT NULL,
  library_id      INT NOT NULL REFERENCES libraries(library_id),
  book_id         INT NOT NULL REFERENCES books(book_id)
);

CREATE TABLE librarians (
  librarian_id    SERIAL PRIMARY KEY,
  full_name       VARCHAR(100) NOT NULL,
  email           VARCHAR(100) NOT NULL,
  library_id      INT NOT NULL REFERENCES libraries(library_id)
);

CREATE TABLE loans (
  loan_id         SERIAL PRIMARY KEY,
  loan_date       DATE NOT NULL,
  due_date        DATE NOT NULL,
  return_date     DATE,
  book_copy_id    INT NOT NULL REFERENCES book_copies(book_copy_id),
  member_id       INT NOT NULL REFERENCES members(member_id)
);

CREATE TABLE reservations (
  reservation_id  SERIAL PRIMARY KEY,
  reservation_date DATE NOT NULL,
  status          VARCHAR(20) NOT NULL,
  book_copy_id    INT NOT NULL REFERENCES book_copies(book_copy_id),
  member_id       INT NOT NULL REFERENCES members(member_id)
);