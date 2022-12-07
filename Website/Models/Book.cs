using System;
using System.ComponentModel.DataAnnotations;

namespace Website.Models
{
    public class Book
    {
        public uint book_id { get; set; }

        [StringLength(45)]
        [Display(Name = "Title")]
        [Required]
        public string title { get; set; }

        [Display(Name = "Publisher")]
        public uint publisher_id { get; set; }

        [Display(Name = "Popularity")]
        public int? popularity { get; set; }

        [Display(Name = "publish_date")]
        public DateTime publish_date { get; set; }

        [Display(Name = "Author")]
        public uint? author_id { get; set; }
        public string? author_first_name { get; set; }
        public string? author_last_name { get; set; }

        #region Queries

        // Written by Aaron.
        /// <summary>
        /// Parameters:
        ///     <br />
        ///     None
        /// </summary>
        public const string SelectAllQuery = "SELECT b.*, a.first_name author_first_name, a.last_name author_last_name " +
            "FROM book b " +
            "LEFT JOIN book_author ba ON ba.book_id = b.book_id " +
            "LEFT JOIN author a ON a.author_id = ba.author_id";

        /// <summary>
        /// Parameters:
        ///     <br />
        ///     @book_id (uint): Book ID
        /// </summary>
        public const string SelectQuery = "SELECT b.*, a.author_id, a.first_name author_first_name, a.last_name author_last_name " +
            "FROM book b " +
            "LEFT JOIN book_author ba ON ba.book_id = b.book_id " +
            "LEFT JOIN author a ON a.author_id = ba.author_id " +
            "WHERE b.book_id = @book_id";

        /// <summary>
        /// Parameters:
        ///     <br />
        ///     @title (string): Book title
        ///     <br />
        ///     @popularity (int): Book popularity
        ///     <br />
        ///     @publish_date (datetime): Book publish date
        /// </summary>
        public const string InsertQuery = "INSERT INTO book(title, publisher_id, popularity, publish_date) " +
            "VALUES(@title, @publisher_id, @popularity, @publish_date); " +
            "SELECT LAST_INSERT_ID();";

        /// <summary>
        /// Parameters:
        ///     <br />
        ///     @title (string): Book title
        ///     <br />
        ///     @popularity (int): Book popularity
        ///     <br />
        ///     @publish_date (datetime): Book publish date
        /// </summary>
        public const string UpdateQuery = "UPDATE book " +
            "SET title = @title, popularity = @popularity, publish_date=@publish_date, publisher_id=@publisher_id " +
            "WHERE book_id = @book_id";

        /// <summary>
        /// Parameters:
        ///     <br />
        ///     @book_id (uint): Book ID
        /// </summary>
        public const string DeleteQuery = "DELETE FROM book " +
            "WHERE book_id = @book_id";

        /// <summary>
        /// Parameters:
        ///     <br />
        ///     @book_id (uint): Book ID
        /// </summary>
        public const string DeleteBookAuthorQuery = "DELETE FROM book_author " +
            "WHERE book_id = @book_id";

        /// <summary>
        /// Parameters:
        ///     <br />
        ///     @book_id (uint): Book ID
        ///     @author_id (uint): Author ID
        /// </summary>
        public const string InsertBookAuthorQuery = "INSERT INTO book_author(book_id, author_id) VALUES " +
            "(@book_id, @author_id)";

        /// <summary>
        /// Parameters:
        ///     <br />
        ///     @author_id (uint): Author ID
        /// </summary>
        public const string SelectAllByAuthorId = "SELECT b.* FROM book b " +
            "JOIN book_author ba ON b.book_id = ba.book_id " +
            "WHERE ba.author_id = @author_id";

        #endregion

    }
}
