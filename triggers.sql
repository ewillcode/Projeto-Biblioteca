CREATE FUNCTION fn_mark_loaned() RETURN trigger AS $$
BEGIN
    UPDATE book_copies
    SET status = 'loaned'
    WHERE book_copy_id = NEW.book_copy_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_after_insert_loan
    AFTER INSERT ON loans
    FOR EACH ROW
    EXECUTE FUNCTION fn_mark_loaned();