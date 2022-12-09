using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Threading.Tasks;

namespace Website.Models.DB
{
    public class LibraryContext
    {
        public LibraryContext(string connectionString)
        {
            ConnectionString = connectionString;
        }

        public string ConnectionString { get; set; }

        private MySqlConnection GetConnection()
        {
            return new(ConnectionString);
        }

        #region Book

        public async Task<List<Book>> GetAllBooksAsync()
        {
            var result = new List<Book>();

            using (MySqlConnection conn = GetConnection())
            {
                conn.Open();
                var cmd = new MySqlCommand(Book.SelectAllQuery, conn);

                using var reader = await cmd.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                    result.Add(ToBook(reader));
            }
            return result;
        }

        public async Task<Book?> GetBookAsync(uint id)
        {
            Book? result = null;

            using (MySqlConnection conn = GetConnection())
            {
                conn.Open();
                var cmd = new MySqlCommand(Book.SelectQuery, conn);
                cmd.Parameters.AddWithValue("@book_id", id);

                using var reader = await cmd.ExecuteReaderAsync();
                if (await reader.ReadAsync())
                    result = ToBook(reader);
            }

            return result;
        }

        public async Task<bool> AddBookAsync(Book book)
        {
            using (MySqlConnection conn = GetConnection())
            {
                conn.Open();
                var cmd = new MySqlCommand(Book.InsertQuery, conn);
                cmd.Parameters.AddWithValue("@title", book.title);
                cmd.Parameters.AddWithValue("@publish_date", book.publish_date);
                cmd.Parameters.AddWithValue("@rating", book.rating);
                cmd.Parameters.AddWithValue("@publisher_id", book.publisher_id);
                try
                {
                    book.book_id = Convert.ToUInt32(await cmd.ExecuteScalarAsync());
                }
                catch
                {
                    return false;
                }
            }

            if (book.author_id != null)
            {
                using MySqlConnection conn = GetConnection();
                conn.Open();
                var cmd = new MySqlCommand(Book.InsertBookAuthorQuery, conn);
                cmd.Parameters.AddWithValue("@book_id", book.book_id);
                cmd.Parameters.AddWithValue("@author_id", book.author_id);
                try
                {
                    await cmd.ExecuteNonQueryAsync();
                }
                catch
                {
                    return false;
                }
            }

            return true;
        }

        public async Task<bool> UpdateBookAsync(Book book)
        {
            using (MySqlConnection conn = GetConnection())
            {
                conn.Open();
                var cmd = new MySqlCommand(Book.UpdateQuery, conn);
                cmd.Parameters.AddWithValue("@title", book.title);
                cmd.Parameters.AddWithValue("@publish_date", book.publish_date);
                cmd.Parameters.AddWithValue("@rating", book.rating);
                cmd.Parameters.AddWithValue("@publisher_id", book.publisher_id);
                cmd.Parameters.AddWithValue("@book_id", book.book_id);
                try
                {
                    await cmd.ExecuteNonQueryAsync();
                }
                catch
                {
                    return false;
                }
            }

            using (MySqlConnection conn = GetConnection())
            {
                conn.Open();
                var cmd = new MySqlCommand(Book.DeleteBookAuthorQuery, conn);
                cmd.Parameters.AddWithValue("@book_id", book.book_id);

                try
                {
                    await cmd.ExecuteNonQueryAsync();
                }
                catch
                {
                    return false;
                }
            }

            if (book.author_id != null)
            {
                using MySqlConnection conn = GetConnection();
                conn.Open();
                var cmd = new MySqlCommand(Book.InsertBookAuthorQuery, conn);
                cmd.Parameters.AddWithValue("@book_id", book.book_id);
                cmd.Parameters.AddWithValue("@author_id", book.author_id);
                try
                {
                    await cmd.ExecuteNonQueryAsync();
                }
                catch
                {
                    return false;
                }
            }

            return true;
        }

        public async Task<bool> DeleteBookAsync(uint id)
        {
            using MySqlConnection conn = GetConnection();
            conn.Open();
            var cmd = new MySqlCommand(Book.DeleteQuery, conn);
            cmd.Parameters.AddWithValue("@book_id", id);

            return await cmd.ExecuteNonQueryAsync() == 1;
        }

        private static Book ToBook(DbDataReader reader)
        {
            var result = new Book
            {
                book_id = Convert.ToUInt32(reader["book_id"]),
                title = reader["title"].ToString(),
                rating = Convert.ToDecimal(reader["rating"]),
                publish_date = Convert.ToDateTime(reader["publish_date"]),
                publisher_id = Convert.ToUInt32(reader["publisher_id"]),
            };
            if (HasColumn(reader, "author_id"))
                result.author_id = Convert.ToUInt32(reader["author_id"]);
            if (HasColumn(reader, "author_first_name"))
                result.author_first_name = reader["author_first_name"].ToString();
            if (HasColumn(reader, "author_last_name"))
                result.author_last_name = reader["author_last_name"].ToString();
            return result;
        }

        #endregion

        #region Author

        public async Task<List<Author>> GetAllAuthorsAsync()
        {
            var result = new List<Author>();

            using (MySqlConnection conn = GetConnection())
            {
                conn.Open();
                var cmd = new MySqlCommand(Author.SelectAllQuery, conn);

                using var reader = await cmd.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                    result.Add(ToAuthor(reader));
            }
            return result;
        }

        public async Task<Author?> GetAuthorAsync(uint id)
        {
            Author? result = null;

            using (MySqlConnection conn = GetConnection())
            {
                conn.Open();
                var cmd = new MySqlCommand(Author.SelectQuery, conn);
                cmd.Parameters.AddWithValue("@author_id", id);

                using var reader = await cmd.ExecuteReaderAsync();
                if (await reader.ReadAsync())
                {
                    result = ToAuthor(reader);
                }
            }

            if (result != null)
            {
                using (MySqlConnection conn = GetConnection())
                {
                    conn.Open();
                    var bookCmd = new MySqlCommand(Book.SelectAllByAuthorId, conn);
                    bookCmd.Parameters.AddWithValue("@author_id", id);

                    using var bookReader = await bookCmd.ExecuteReaderAsync();
                    while (await bookReader.ReadAsync())
                    {
                        result.books ??= new();
                        result.books.Add(ToBook(bookReader));
                    }
                }
            }

            return result;
        }

        public async Task<bool> AddAuthorAsync(Author author)
        {
            using MySqlConnection conn = GetConnection();
            conn.Open();
            var cmd = new MySqlCommand(Author.InsertQuery, conn);
            cmd.Parameters.AddWithValue("@first_name", author.first_name);
            cmd.Parameters.AddWithValue("@last_name", author.last_name);
            try
            {
                author.author_id = Convert.ToUInt32(await cmd.ExecuteScalarAsync());
                return true;
            }
            catch
            {
                return false;
            }
        }

        public async Task<bool> UpdateAuthorAsync(Author author)
        {
            using MySqlConnection conn = GetConnection();
            conn.Open();
            var cmd = new MySqlCommand(Author.UpdateQuery, conn);
            cmd.Parameters.AddWithValue("@first_name", author.first_name);
            cmd.Parameters.AddWithValue("@last_name", author.last_name);
            cmd.Parameters.AddWithValue("@author_id", author.author_id);

            return await cmd.ExecuteNonQueryAsync() == 1;
        }

        public async Task<bool> DeleteAuthorAsync(uint id)
        {
            using MySqlConnection conn = GetConnection();
            conn.Open();
            var cmd = new MySqlCommand(Author.DeleteQuery, conn);
            cmd.Parameters.AddWithValue("@author_id", id);

            return await cmd.ExecuteNonQueryAsync() == 1;
        }

        public async Task<bool> DeleteBookAuthorAsync(uint id)
        {
            using MySqlConnection conn = GetConnection();
            conn.Open();
            var cmd = new MySqlCommand(Author.DeleteBookAuthorQuery, conn);
            cmd.Parameters.AddWithValue("@author_id", id);

            return await cmd.ExecuteNonQueryAsync() > 0;
        }

        private static Author ToAuthor(DbDataReader reader)
        {
            var result = new Author
            {
                author_id = Convert.ToUInt32(reader["author_id"]),
                first_name = reader["first_name"].ToString(),
                last_name = reader["last_name"].ToString(),
                book_count = Convert.ToInt32(reader["book_count"])
            };
            return result;
        }


        #endregion

        #region Publisher

        public async Task<List<Publisher>> GetAllPublishersAsync()
        {
            var result = new List<Publisher>();

            using (MySqlConnection conn = GetConnection())
            {
                conn.Open();
                var cmd = new MySqlCommand(Publisher.SelectAllQuery, conn);

                using var reader = await cmd.ExecuteReaderAsync();
                while (await reader.ReadAsync())
                    result.Add(ToPublisher(reader));
            }
            return result;
        }

        private static Publisher ToPublisher(DbDataReader reader)
        {
            var result = new Publisher
            {
                publisher_id = Convert.ToUInt32(reader["publisher_id"]),
                name = reader["name"].ToString(),
            };
            return result;
        }

        #endregion

        public static bool HasColumn(IDataRecord dr, string columnName)
        {
            for (int i = 0; i < dr.FieldCount; i++)
            {
                if (dr.GetName(i).Equals(columnName, StringComparison.InvariantCultureIgnoreCase))
                    return true;
            }
            return false;
        }

    }
}
