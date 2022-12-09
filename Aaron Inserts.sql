INSERT INTO publisher(name) VALUES
	("Another publisher"),
    ("The publisher"),
    ("Your publisher"),
    ("A publisher");

INSERT INTO author(first_name, last_name) VALUES
	("Rodney", "Lantern"),
    ("Tim", "Wax"),
    ("Fred", "Sconce"),
    ("Brandon", "Candle");
    
INSERT INTO library.condition(`condition`) VALUES
	("New"),
    ("Good"),
    ("Worn"),
    ("Destroyed");
    
INSERT INTO book(title, publisher_id, popularity, publish_date) VALUES
	("The Buddhist Bible", 2, 196, '1842-07-13'),
    ("The First Yearbook", 4, 1, '0001-12-31'),
    ("My diary", 1, 486513, '2013-2-18'),
    ("YOUR diary", 3, 984632, '2014-1-04');
    
INSERT INTO book_author(book_id, author_id) VALUES
	(1, 3),
    (2, 3),
    (3, 1),
    (4, 2);
    
INSERT INTO book_copy(ISBN, book_id, language_id, condition_id, availability, format_id, library_id) VALUES
	(1325479465132, 1, 1, 1, 1, 1, 1),
    (1344682155223, 1, 2, 2, 1, 1, 2),
    (8621485645586, 2, 3, 4, 2, 1, 1),
    (1478566526632, 1, 1, 3, 2, 1, 3);