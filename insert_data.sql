-- Populando o banco
-- =========================
-- AUTHORS (30)
-- =========================
INSERT INTO authors (first_name, last_name, birth_date) VALUES
('Machado','de Assis','1839-06-21'),
('Clarice','Lispector','1920-12-10'),
('George','Orwell','1903-06-25'),
('J.K.','Rowling','1965-07-31'),
('J.R.R.','Tolkien','1892-01-03'),
('Paulo','Coelho','1947-08-24'),
('Monteiro','Lobato','1882-04-18'),
('José','Saramago','1922-11-16'),
('Stephen','King','1947-09-21'),
('Agatha','Christie','1890-09-15'),
('Dan','Brown','1964-06-22'),
('Jane','Austen','1775-12-16'),
('Victor','Hugo','1802-02-26'),
('Fiódor','Dostoiévski','1821-11-11'),
('Ernest','Hemingway','1899-07-21'),
('Cecília','Meireles','1901-11-07'),
('Carlos','Drummond','1902-10-31'),
('Ariano','Suassuna','1927-06-16'),
('Lygia','Fagundes','1923-04-19'),
('Rachel','de Queiroz','1910-11-17'),
('Neil','Gaiman','1960-11-10'),
('Isaac','Asimov','1920-01-02'),
('Arthur','Clarke','1917-12-16'),
('Philip','Dick','1928-12-16'),
('C.S.','Lewis','1898-11-29'),
('Mary','Shelley','1797-08-30'),
('Bram','Stoker','1847-11-08'),
('Jules','Verne','1828-02-08'),
('H.G.','Wells','1866-09-21'),
('Franz','Kafka','1883-07-03');

-- =========================
-- PUBLISHERS (30)
-- =========================
INSERT INTO publishers (address) VALUES
('Rua A, 101 - São Paulo'),
('Rua B, 102 - Rio de Janeiro'),
('Rua C, 103 - Curitiba'),
('Rua D, 104 - Porto Alegre'),
('Rua E, 105 - Joinville'),
('Rua F, 106 - Florianópolis'),
('Rua G, 107 - Campinas'),
('Rua H, 108 - Salvador'),
('Rua I, 109 - Recife'),
('Rua J, 110 - Brasília'),
('Rua K, 111 - Fortaleza'),
('Rua L, 112 - Manaus'),
('Rua M, 113 - Goiânia'),
('Rua N, 114 - Belém'),
('Rua O, 115 - Vitória'),
('Rua P, 116 - Santos'),
('Rua Q, 117 - Londrina'),
('Rua R, 118 - Blumenau'),
('Rua S, 119 - Maringá'),
('Rua T, 120 - Sorocaba'),
('Rua U, 121 - Niterói'),
('Rua V, 122 - Cuiabá'),
('Rua W, 123 - Palmas'),
('Rua X, 124 - Aracaju'),
('Rua Y, 125 - João Pessoa'),
('Rua Z, 126 - Natal'),
('Av. Alpha, 127 - São Luís'),
('Av. Beta, 128 - Teresina'),
('Av. Gama, 129 - Macapá'),
('Av. Delta, 130 - Boa Vista');

-- =========================
-- GENRES (15)
-- =========================
INSERT INTO genres (name) VALUES
('Romance'),
('Fantasia'),
('Ficção Científica'),
('Drama'),
('Suspense'),
('Terror'),
('Aventura'),
('Biografia'),
('Poesia'),
('Infantil'),
('História'),
('Mistério'),
('Acadêmico'),
('Tecnologia'),
('Filosofia');

-- =========================
-- MEMBERS (35)
-- =========================
INSERT INTO members (full_name, email, phone, membership_start, membership_end)
SELECT
    'Membro ' || i,
    'membro' || i || '@email.com',
    '4799999' || LPAD(i::text, 4, '0'),
    DATE '2025-01-01' + (i * 5),
    DATE '2026-12-31'
FROM generate_series(1,35) AS s(i);

-- =========================
-- LIBRARIES (10)
-- =========================
INSERT INTO libraries (name, address) VALUES
('Biblioteca Central','Campus Principal'),
('Biblioteca Norte','Rua Norte 100'),
('Biblioteca Sul','Rua Sul 200'),
('Biblioteca Leste','Rua Leste 300'),
('Biblioteca Oeste','Rua Oeste 400'),
('Biblioteca Saúde','Campus Saúde'),
('Biblioteca Engenharia','Campus Engenharia'),
('Biblioteca Direito','Campus Direito'),
('Biblioteca Comunitária','Centro'),
('Biblioteca Digital','Online');

-- =========================
-- LIBRARIANS (30)
-- =========================
INSERT INTO librarians (full_name, email, library_id)
SELECT
    'Bibliotecário ' || i,
    'bib' || i || '@universidade.com',
    ((i - 1) % 10) + 1
FROM generate_series(1,30) AS s(i);

-- =========================
-- BOOKS (40)
-- =========================
INSERT INTO books (pub_year, title, isbn, genre_id, author_id, publisher_id)
SELECT
    1980 + (i % 40),
    'Livro ' || i,
    LPAD((9780000000000 + i)::text, 13, '0'),
    ((i - 1) % 15) + 1,
    ((i - 1) % 30) + 1,
    ((i - 1) % 30) + 1
FROM generate_series(1,40) AS s(i);

-- =========================
-- BOOK_COPIES (50)
-- =========================
INSERT INTO book_copies (status, library_id, book_id)
SELECT
    CASE
        WHEN i % 3 = 0 THEN 'loaned'
        WHEN i % 5 = 0 THEN 'reserved'
        ELSE 'available'
    END,
    ((i - 1) % 10) + 1,
    ((i - 1) % 40) + 1
FROM generate_series(1,50) AS s(i);

-- =========================
-- LOANS (35)
-- =========================
INSERT INTO loans (loan_date, due_date, return_date, book_copy_id, member_id)
SELECT
    DATE '2026-01-01' + i,
    DATE '2026-01-15' + i,
    DATE '2026-01-10' + i,
    ((i - 1) % 50) + 1,
    ((i - 1) % 35) + 1
FROM generate_series(1,35) AS s(i);

-- =========================
-- RESERVATIONS (30)
-- =========================
INSERT INTO reservations (reservation_date, status, book_copy_id, member_id)
SELECT
    DATE '2026-03-01' + i,
    CASE
        WHEN i % 2 = 0 THEN 'active'
        ELSE 'completed'
    END,
    ((i - 1) % 50) + 1,
    ((i - 1) % 35) + 1
FROM generate_series(1,30) AS s(i);








