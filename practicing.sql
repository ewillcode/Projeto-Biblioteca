-- Praticando comandos

INSERT INTO authors (first_name, last_name, birth_date)
VALUES ('Eduardo', 'Will', '2005-08-07');
INSERT INTO authors (first_name, last_name, birth_date)
VALUES ('Maria Eduarda', 'Ramos', '2007-02-18');

UPDATE authors
SET last_name = 'Will'
WHERE author_id = 32;

DELETE FROM authors
WHERE author_id = 2;

-- Empréstimos atrasados
SELECT *
FROM loans
WHERE return_date IS NOT null
  AND due_date < current_date;

SELECT *
FROM books
WHERE genre_id <> 1
  AND pub_year between 1900 AND 2000;

SELECT *
FROM members
WHERE membership_end > current_date;

SELECT *
FROM book_copies
WHERE library_id IN (1,4)
  AND status <> 'available';

SELECT *
FROM librarians
WHERE library_id = ANY(ARRAY[2,3,4]);

SELECT *
FROM loans
WHERE EXTRACT(DOW FROM loan_date) IN (0,6);

SELECT r.*, m.full_name
FROM reservations r
JOIN members m USING(member_id)
WHERE r.reservation_date >= (CURRENT_DATE - INTERVAL '5 month')
  AND m.full_name LIKE '%5%';

-- Total de empréstimos por livro
SELECT b.title,
       COUNT(*) AS total_loans
FROM loans AS l
JOIN book_copies AS bc USING(book_copy_id)
JOIN books AS b USING(book_id)
GROUP BY b.title
ORDER BY 2 DESC;

-- Empréstimo mais antigo e mais recente
SELECT MIN(loan_date) AS first_loan,
       MAX(loan_date) AS last_loan
FROM loans;

-- Duração média dos empréstimos
SELECT ROUND(AVG((due_date - loan_date)),2) AS avg_loan_duration_days
FROM loans
WHERE return_date IS NOT NULL;

-- Top 5 livros mais emprestados
SELECT bk.title,
       COUNT(*) AS times_loaned
FROM loans AS l
JOIN book_copies AS bc ON bc.book_copy_id = l.book_copy_id
JOIN books AS bk ON bk.book_id = bc.book_id
GROUP BY bk.title
ORDER BY 2 DESC
LIMIT 5;

-- Bibliotecas com mais cópias 
SELECT lb.name,
       COUNT(*) AS total_copies
FROM book_copies AS bc
JOIN libraries AS lb ON lb.library_id = bc.library_id
GROUP BY lb.name
ORDER BY 2 DESC;

-- Inventário por gênero e filial
SELECT
  g.name AS genre,
  lb.name AS library_name,
  COUNT(bc.*) AS available_copies
FROM genres g
JOIN books b USING(genre_id)
JOIN book_copies bc ON bc.book_id = b.book_id
JOIN libraries lb ON bc.library_id = lb.library_id
WHERE bc.status = 'available'
GROUP BY g.name, lb.name
ORDER BY g.name, lb.name

-- Livros emprestados mais de 0 vezes (praticando subquery)
SELECT *
FROM books b
WHERE (
  SELECT COUNT(*)
  FROM loans l
  JOIN book_copies bc ON bc.book_copy_id = l.book_copy_id
  WHERE bc.book_id = b.book_id
) > 0;

-- Membros que nunca emprestaram livros
SELECT *
FROM members m
WHERE NOT EXISTS (
  SELECT 1
  FROM loans l
  WHERE l.member_id = m.member_id
);

-- Praticando CTE / reservas ativas por membros
WITH active_res AS (
  SELECT member_id
  FROM reservations
  WHERE status = 'active'
),
res_counts AS (
  SELECT member_id, COUNT(*) AS cnt
  FROM active_res
  GROUP BY member_id
)
SELECT m.full_name, rc.cnt
FROM res_counts AS rc
JOIN members m ON m.member_id = rc.member_id
ORDER BY rc.cnt DESC;

-- EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT bk.title,
       COUNT(*) AS times_loaned
FROM loans AS l
JOIN book_copies AS bc ON bc.book_copy_id = l.book_copy_id
JOIN books AS bk ON bk.book_id = bc.book_id
GROUP BY bk.title
ORDER BY 2 DESC
LIMIT 5;