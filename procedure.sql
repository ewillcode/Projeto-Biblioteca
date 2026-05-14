CREATE PROCEDURE sp_create_loan(
    p_copy_id INT,
    p_member_id INT,
    p_days INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- inicia transaction
    INSERT INTO loans(book_copy_id, member_id, loan_date, due_date)
    VALUES (p_copy_id, p_member_id, NOW(), NOW() + (p_days || ' days')::interval);

    UPDATE book_copies
    SET status = 'loaned'
    WHERE book_copy_id = p_copy_id;
END;
$$;