-- Queries for series table

INSERT INTO series (series_id, series_name)
VALUES (DEFAULT, @series_name);

SELECT *
FROM series;

DELETE FROM series
WHERE series_id = @series_id;

UPDATE series
SET series_name = @new_series_name
WHERE series_id = @series_id;


-- Queries for book_series table

INSERT INTO book_series(book_id, series_id)
VALUES (@book_id, @series_id);

DELETE FROM book_series
WHERE genre_id = @series_id;

DELETE FROM book_series
WHERE book_id = @series_id;



-- Queries for book_genre table

INSERT INTO book_genre(book_id, genre_id)
VALUES (@book_id, @genre_id);

DELETE FROM book_genre
WHERE genre_id = @genre_id;

DELETE FROM book_genre
WHERE book_id = @book_id;


-- Queries for genre table

INSERT INTO genre (genre_id, genre)
VALUES (DEFAULT, @genre);

SELECT *
FROM genre;

DELETE FROM genre
WHERE genre_id = @genre_id;

UPDATE genre
SET genre = @new_genre_name
WHERE genre_id = @genre_id;


-- Queries for account table

INSERT INTO series (account_id, first_name, last_name, email, password_hash, phone)
VALUES (DEFAULT, @first_name, @last_name, @email, @password_hash, @phone);

SELECT *
FROM account;

UPDATE account
SET first_name = @first_name, last_name = @last_name, email = @email, password_hash = @password_hash, phone = @phone
WHERE account_id = @account_id;


-- Queries for language table

INSERT INTO language (language_id, language)
VALUES (DEFAULT, @language);

DELETE FROM language
WHERE language = @language_id;



-- Queries for format table

INSERT INTO language (format_id, format)
VALUES (DEFAULT, @format);

DELETE FROM format
WHERE format = @format_id;










