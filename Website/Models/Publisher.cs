namespace Website.Models
{
    public class Publisher
    {
        public uint publisher_id { get; set; }
        public string name { get; set; }

        #region Queries

        // Written by Aaron.
        /// <summary>
        /// Parameters:
        ///     <br />
        ///     None
        /// </summary>
        public const string SelectAllQuery = "SELECT * FROM publisher";

        #endregion
    }
}
