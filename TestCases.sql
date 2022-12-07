

#Someone wants to see what books they have checked out..

SELECT book.Title
FROM bookCopy
INNER JOIN book ON bookCopy.book_id = book.book_id
WHERE account_id = 1234;

#A staff member might want to look at any accounts that have checked out more than 2 books.

SELECT account_id 'Account ID', accounts.last_name 'Last Name', 
accounts.first_name 'First Name', COUNT(*) AS Amount
FROM bookCopy
INNER JOIN accounts ON accounts.account_id = bookCopy.account_id
GROUP BY account_id
HAVING Amount > 2;

#A staff member will want to see which accounts in a specific library have books late in return.
#(create new withdrawal/checkin table)

SELECT account_id 'Account ID', accounts.last_name 'Last Name', 
accounts.first_name 'First Name', bookCopy.item_id
FROM withdrawals
INNER JOIN accounts ON accounts.account_id = withdrawals.account_id
INNER JOIN bookCopy ON bookCopy.book_id = withdrawals.book_id
WHERE DATEDIFF(CURDATE(), "2017-06-15") > 30 AND library_id = 3;

