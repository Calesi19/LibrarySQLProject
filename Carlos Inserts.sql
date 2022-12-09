
#Populate Book Table

INSERT INTO book(book_id, title, publisher_id, popularity, publish_date) 
VALUES 
(DEFAULT, "Tragic Events From Carlos' Life", 2, 4.5, '2002-06-15'),
(DEFAULT, "The Fellowship of the Ring' Life", 3, 4.8, '1954-07-26'),
(DEFAULT, "The Two Towers' Life", 3, 4.8, '1954-07-26'),
(DEFAULT, "The Return of the King", 3, 4.9, '1954-07-26'),
(DEFAULT, "Harry Potter and the Sorcerer's Stone Life", 1, 4.7, '1997-06-26'),
(DEFAULT, "Harry Potter and the Chamber of Secrets", 1, 4.6, '1998-07-02');



#Populate Series Table

INSERT INTO series (series_id, series_name)
VALUES 
(DEFAULT, 'Harry Potter'),
(DEFAULT, 'The Hobbit'),
(DEFAULT, 'Lord of the Rings');


#Populate Genre Table

INSERT INTO series (genre_id, genre)
VALUES 
(DEFAULT, 'Horror'), #1
(DEFAULT, 'Comedy'), #2
(DEFAULT, 'Self-Help'), #3
(DEFAULT, 'Cooking'), #4
(DEFAULT, 'Educational'),#5
(DEFAULT, 'Adventure'),#6
(DEFAULT, 'Politics'),#7
(DEFAULT, 'Fantasy'),#8
(DEFAULT, 'Fiction'),#9
(DEFAULT, 'Non-Ficiton'),#10
(DEFAULT, 'Based-On-True-Story'),#11
(DEFAULT, 'Historical'),#12
(DEFAULT, 'Science'),#13
(DEFAULT, 'Sci-Fi'),#14
(DEFAULT, 'Medieval'),#15
(DEFAULT, 'Poetry'),#16
(DEFAULT, 'Drama'),#17
(DEFAULT, 'Romance');#18



#Populate Account Table

INSERT INTO series (account_id, first_name, last_name, email, password_hash, phone)
VALUES 
(DEFAULT, 'Carlos', 'Lespin', 'carlos.lespin@gmail.com', 'mypasswordispassword', 7879889347),
(DEFAULT, 'Levi', 'Chudliegh', 'levi.chudliegh@icloud.com', 'qwerty'),
(DEFAULT, 'Aaron', 'Fox', 'aaron.fox@hotmail.com', 'BillieJeanNotMyGirl'),
(DEFAULT, 'Ashley', 'DeMott', 'ashley.demott@yahoo.com', 'channingtatum');

#Populate Language Table

INSERT INTO language (language_id, language)
VALUES 
(DEFAULT, 'Spanish'),
(DEFAULT, 'English'),
(DEFAULT, 'Portuguese'),
(DEFAULT, 'Dothraki'),
(DEFAULT, 'Korean'),
(DEFAULT, 'French'),
(DEFAULT, 'Mandarin'),
(DEFAULT, 'Canadian'),
(DEFAULT, 'Klingon'),
(DEFAULT, 'Japanese'),
(DEFAULT, 'Dovahzul');


# Populate Format Table

INSERT INTO format (format_id, format)
VALUES
(DEFAULT, "Paperback"),
(DEFAULT, "Hardcover"),
(DEFAULT, "AudioBook"),
(DEFAULT, "AudioBook CD"),
(DEFAULT, "AudioBook Tape"),
(DEFAULT, "Golden Plates"),
(DEFAULT, "Scrolls");



#Populate Book_Series Table

INSERT INTO book_series(book_id, series_id)
VALUES 
(2, 2),
(2, 3),
(3, 2),
(3, 3),
(4, 2),
(4, 3),
(5, 1),
(6, 1);


#Populate Book_Genre


INSERT INTO book_genre(book_id, genre_id)
VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,10),
(1,11),
(1,12),
(1,16),
(1,17),
(1,18),
(2,6),
(2,8),
(3,6),
(3,8),
(4,6),
(4,8),
(5,6),
(5,8),
(6,6),
(6,8);