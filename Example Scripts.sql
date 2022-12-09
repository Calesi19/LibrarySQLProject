# account
	-- Delete account
	DELETE FROM account WHERE account_id = @account_id;

	-- Add new account
	INSERT INTO account(address_id, first_name, last_name, email, phone) VALUES (@address_id, @first_name, @last_name, @email, @phone);

	-- Update account
	UPDATE account SET address_id = @address_id, first_name = @first_name, last_name = @last_name, email = @email, phone = @phone
	WHERE account_id = @account_id;

# library
	-- Delete library
	DELETE FROM library WHERE library_id = library_id;

	-- Add new library
    INSERT INTO library (address_id, name ) VALUES (@address_id, @name );

	-- Update library
	UPDATE library SET address_id = @ address_id, name = @name
    WHERE library_id = @library_id;

# library_account
	-- Delete library account
    DELETE FROM library_account WHERE library_account_id = @library_account_id;

	-- Add new library 
	INSERT INTO library_account(account_account_id) VALUES (@account_account_id);

	-- Update library account
	UPDATE library SET account_account_id = @account_account_id WHERE library_account_id = @library_account_id;

# address

	-- Delete address
    DELETE FROM address WHERE address_id = @address_id;

	-- Add new address
    INSERT INTO address(address_line, state_abbrev, zip_code) VALUES (@address_line, @state_abbrev, @zipcode);

	-- Update address
    UPDATE address SET address_line = @address_line, state_abbrev = @state_abbrev, zip_code = @zipcode
    WHERE address_id = @address_id;

# state
	-- Delete state
    DELETE FROM state WHERE state_abbrev = @state_abbrev;

	-- Add new state
	INSERT INTO state(state_abbrev, name) VALUES
    (@state_abbrev, @name);

	-- Update state
	UPDATE state SET name = @name WHERE state_abbrev = @state_abbrev;
    
# series
	-- Add new series
    INSERT INTO series (series_name)
	VALUES (@series_name);
	
    -- Select all series
    SELECT *
	FROM series;

	-- Delete a series
    DELETE FROM series
	WHERE series_id = @series_id;

	-- Update a series
	UPDATE series
	SET series_name = @new_series_name
	WHERE series_id = @series_id;

# book_series
	-- Add new book series
	INSERT INTO book_series(book_id, series_id)
	VALUES (@book_id, @series_id);

	-- Delete book series by genre
	DELETE FROM book_series
	WHERE genre_id = @genre_id;

	-- Delete from series by book
	DELETE FROM book_series
	WHERE book_id = @book_id;
    
# book_genre
	-- Add new book genre
	INSERT INTO book_genre(book_id, genre_id)
	VALUES (@book_id, @genre_id);
	
    -- Delete book genre by genre
	DELETE FROM book_genre
	WHERE genre_id = @genre_id;
	
	-- Delete book genre by book
	DELETE FROM book_genre
	WHERE book_id = @book_id;

# genre
	-- Add new genre
	INSERT INTO genre (genre)
	VALUES (@genre);
	
    -- Select all genres
	SELECT *
	FROM genre;
	
	-- Delete a genre
	DELETE FROM genre
	WHERE genre_id = @genre_id;
	
	-- Update a genre
	UPDATE genre
	SET genre = @new_genre_name
	WHERE genre_id = @genre_id;

# account
	-- Add new account
	INSERT INTO account (first_name, last_name, email, password_hash, phone)
	VALUES (@first_name, @last_name, @email, @password_hash, @phone);
	
    -- Select all accounts
	SELECT *
	FROM account;
	
	-- Update account
	UPDATE account
	SET first_name = @first_name, last_name = @last_name, email = @email, password_hash = @password_hash, phone = @phone
	WHERE account_id = @account_id;

# language
	-- Add new language
	INSERT INTO language (language)
	VALUES (@language);

	-- Delete language
	DELETE FROM language
	WHERE language = @language_id;

# format
	-- Add new format
	INSERT INTO format (format)
	VALUES (@format);

	-- Delete format
	DELETE FROM format
	WHERE format = @format_id;

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
    INSERT INTO book_copy(ISBN, book_id, language_id, condition_id, format_id, library_id)
	VALUES (@ISBN, @book_id, @language_id, @condition_id, @format_id, @library_id);
    
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