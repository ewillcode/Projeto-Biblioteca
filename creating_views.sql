-- livros disponíveis por filial
CREATE VIEW available_copies_per_branch AS
SELECT
    lb.name AS branch,
    b.title,
    COUNT(*) AS available_count
FROM book_copies bc  
JOIN books b USING(book_id)
JOIN libraries lb USING(library_id)
WHERE bc.status = 'available'
GROUP BY lb.name, b.title