# book
	-- Select all books and their author
	SELECT b.*, a.first_name author_first_name, a.last_name author_last_name
	FROM book b
		LEFT JOIN book_author ba ON ba.book_id = b.book_id
		LEFT JOIN author a ON a.author_id = ba.author_id;
	
    -- Select all books by an author
	SELECT b.*
    FROM book b 
		JOIN book_author ba ON b.book_id = ba.book_id
	WHERE ba.author_id = @author_id;
	
    -- Add new book
	INSERT INTO book(title, publisher_id, popularity, publish_date) VALUES(@title, @publisher_id, @popularity, @publish_date);
	
# author
	-- Select all authors and their book count
    SELECT a.*, COUNT(b.author_id) book_count
	FROM author a
		LEFT JOIN book_author b ON b.author_id = a.author_id
	GROUP BY a.author_id;
	
	-- Search by first or last name
    SELECT author_id, first_name, last_name
		FROM author
	WHERE first_name LIKE CONCAT('%', @search_value, '%') OR last_name LIKE CONCAT('%', @search_value, '%');
        
	-- Add new author
    INSERT INTO author(first_name, last_name) VALUES(@first_name, @last_name);
        
# book_author
	-- Delete book author
	DELETE FROM book_author WHERE author_id = @author_id;
    
    -- Add book author
    INSERT INTO book_author VALUES(@book_id, @author_id);
    
# publisher
	-- Select all publishers and their published count
	SELECT p.*, COUNT(b.publisher_id) book_count
	FROM publisher p
		LEFT JOIN book b ON b.publisher_id = p.publisher_id
	GROUP BY p.publisher_id;
        
	-- Add new publisher
	INSERT INTO publisher(name) VALUES(@name);
    
    -- Delete publisher
    DELETE FROM publisher WHERE publisher_id = @publisher_id;
    
# book_copy
	-- Get all copies of a book
    SELECT copy.*, book.title, author.first_name, author.last_name, library.name, lang.language, cond.condition, format.format
	FROM book_copy copy
		JOIN book book ON book.book_id = copy.book_id
        JOIN book_author ba ON ba.book_id = book.book_id
        JOIN author author ON author.author_id = ba.author_id
        JOIN library library ON library.library_id = copy.library_id
        JOIN library.condition cond ON cond.condition_id = copy.condition_id
        JOIN language lang ON lang.language_id = copy.language_id
        JOIN format format ON format.format_id = copy.format_id
	WHERE copy.book_id = @book_id;
    -- or WHERE copy.library_id = @library_id
    
	-- Add new book copy
    INSERT INTO book_copy(ISBN, book_id, language_id, condition_id, availability, format_id, library_id)
	VALUES (@ISBN, @book_id, @language_id, @condition_id, @availability, @format_id, @library_id);
    
    -- Rent/unrent a copy
    UPDATE book_copy SET account_id = @account_id, turn_over = now()
    WHERE item_id = @item_id;
    
# condition
	-- Add a condition
    INSERT INTO library.condition(`condition`) VALUES(@condition);
    
    -- Update a condition
    UPDATE library.condition SET `condition` = @condition
    WHERE condition_id = @condition_id;
    
    -- Delete a condition
    DELETE FROM library.condition WHERE condition_id = @condition_id;