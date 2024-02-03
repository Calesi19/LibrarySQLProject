

-- Someone wants to see what books they have checked out..

USE library;
SELECT book.title
FROM book_copy
INNER JOIN book ON book_copy.book_id = book.book_id
WHERE account_id = 1;

-- A staff member might want to look at any accounts that have checked out more than 2 books.

SELECT account.account_id 'Account ID', account.last_name 'Last Name', 
account.first_name 'First Name', COUNT(*) AS Amount
FROM book_copy
INNER JOIN account ON account.account_id = book_copy.account_id
GROUP BY account.account_id
HAVING Amount > 2;

-- A staff member will want to see which accounts in a specific library have books late in return.


SELECT account.account_id 'Account ID', account.last_name 'Last Name', 
account.first_name 'First Name', book_copy.item_id
FROM book_copy
INNER JOIN account ON account.account_id = book_copy.account_id
WHERE DATEDIFF(CURDATE(), "2017-06-15") > 30 AND library_id = 3;

-- A client wants to see how many libraries are available in a zip code.

SELECT library.name
FROM library
INNER JOIN address ON address.address_id = library.address_id
WHERE address.zip_code = "72954";


