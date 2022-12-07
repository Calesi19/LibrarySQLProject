using Microsoft.VisualBasic;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Runtime.Intrinsics.X86;

namespace Website.Models
{
    public class Author
    {
        public uint author_id { get; set; }

        [Display(Name = "First Name")]
        public string first_name { get; set; }

        [Display(Name = "Last Name")]
        public string last_name { get; set; }

        [Display(Name = "Books")]
        public int book_count { get; set; }

        public List<Book>? books { get; set; }

        #region Queries

        // Written by Carlos.
        /// <summary>
        /// Parameters:
        ///     <br />
        ///     None
        /// </summary>
        public const string SelectAllQuery = "SELECT a.*, COUNT(b.author_id) book_count " +
            "FROM author a " +
            "LEFT JOIN book_author b ON b.author_id = a.author_id " +
            "GROUP BY a.author_id";

        /// <summary>
        /// Parameters:
        ///     <br />
        ///     @author_id (uint): Author ID
        /// </summary>
        public const string SelectQuery = "SELECT a.*, COUNT(b.author_id) book_count " +
            "FROM author a " +
            "LEFT JOIN book_author b ON b.author_id = a.author_id " +
            "WHERE a.author_id = @author_id";

        // SEARCH by one value
        /// <summary>
        /// Parameters:
        ///     <br />
        ///     @search_value (string): string search keyword
        /// </summary>
        public const string SearchQuery = "SELECT author_id, first_name, last_name " +
            "FROM author " +
            "WHERE first_name LIKE CONCAT('%', @search_value, '%') OR last_name LIKE CONCAT('%', @search_value, '%')";

        // INSERT
        /// <summary>
        /// Parameters:
        ///     <br />
        ///     @first_name (string): Author first name
        ///     <br />
        ///     @last_name (string): Author last name
        /// </summary>
        public const string InsertQuery = "INSERT INTO author(author_id, first_name, last_name) " +
            "VALUES(DEFAULT, @first_name, @last_name); " +
            "SELECT LAST_INSERT_ID();";

        // UPDATE
        /// <summary>
        /// Parameters:
        ///     <br />
        ///     @first_name (string): Author first name
        ///     <br />
        ///     @last_name (string): Author last name
        ///     <br />
        ///     @author_id (uint): Author ID
        /// </summary>
        public const string UpdateQuery = "UPDATE author " +
            "SET first_name = @first_name, last_name = @last_name " +
            "WHERE author_id = @author_id";

        // DELETE {0} stored_author_id
        /// <summary>
        /// Parameters:
        ///     <br />
        ///     @author_id (uint): Author ID
        /// </summary>
        public const string DeleteQuery = "DELETE FROM author " +
            "WHERE author_id = @author_id";

        // DELETE {0} stored_author_id (linking table with books)
        /// <summary>
        /// Parameters:
        ///     <br />
        ///     @author_id (uint): Author ID
        /// </summary>
        public const string DeleteBookAuthorQuery = "DELETE FROM book_author " +
            "WHERE author_id = @author_id";

        #endregion
    }
}
