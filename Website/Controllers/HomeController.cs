using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Threading.Tasks;
using Website.Models;
using Website.Models.DB;

namespace Website.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
#pragma warning disable CS8603 // Possible null reference return.
        private LibraryContext Context => HttpContext.RequestServices.GetService(typeof(LibraryContext)) as LibraryContext;
#pragma warning restore CS8603 // Possible null reference return.

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }

        [HttpGet]
        public IActionResult Index()
        {
            return View();
        }

        private const string ERR_Save = "An unknown error occurred while saving.";
        private const string ERR_Delete = "An unknown error occurred while deleting.";

        #region Books

        [HttpGet]
        public async Task<IActionResult> Books()
        {
            var model = await Context.GetAllBooksAsync();
            return View(model);
        }

        [HttpGet]
        public async Task<IActionResult> GetBook(uint? id)
        {
            var model = id == null
                ? new Book()
                : await Context.GetBookAsync(id.Value);

            if (model == null)
                return NotFound();

            ViewBag.IsNew = id == null;

            ViewBag.Authors = await Context.GetAllAuthorsAsync();
            ViewBag.Publishers = await Context.GetAllPublishersAsync();

            return PartialView("BookModal", model);
        }

        [HttpPost]
        public async Task<IActionResult> UpdateBook(Book book)
        {
            if (book == null || !ModelState.IsValid)
                return BadRequest();

            var msg = ERR_Save;

            try
            {
                bool result = book.book_id == 0
                    ? await Context.AddBookAsync(book)
                    : await Context.UpdateBookAsync(book);

                if (result)
                {
                    var author = await Context.GetAuthorAsync(book.author_id.Value);
                    book.author_first_name = author.first_name;
                    book.author_last_name = author.last_name;
                    return PartialView("BookRow", book);
                }
            }
            catch (Exception ex)
            {
                msg = GetErrorMessage("save", ex);
            }

            return Json(new { msg });
        }

        [HttpPost]
        public async Task<IActionResult> DeleteBook(uint? id)
        {
            if (id == null)
                return BadRequest();

            var msg = ERR_Delete;

            try
            {
                bool result = await Context.DeleteBookAsync(id.Value);
                if (result) return Ok();
            }
            catch (Exception ex)
            {
                msg = GetErrorMessage("delete", ex);
            }

            return Json(new { msg });
        }

        #endregion

        #region Authors

        [HttpGet]
        public async Task<IActionResult> Authors()
        {
            var model = await Context.GetAllAuthorsAsync();
            return View(model);
        }

        [HttpGet]
        public async Task<IActionResult> GetAuthor(uint? id)
        {
            var model = id == null
                ? new Author()
                : await Context.GetAuthorAsync(id.Value);

            if (model == null)
                return NotFound();

            ViewBag.IsNew = id == null;

            return PartialView("AuthorModal", model);
        }

        [HttpPost]
        public async Task<IActionResult> UpdateAuthor(Author author)
        {
            if (author == null || !ModelState.IsValid)
                return BadRequest();

            var msg = ERR_Save;

            try
            {
                bool result = author.author_id == 0
                    ? await Context.AddAuthorAsync(author)
                    : await Context.UpdateAuthorAsync(author);

                if (result) return PartialView("AuthorRow", author);
            }
            catch (Exception ex)
            {
                msg = GetErrorMessage("save", ex);
            }

            return Json(new { msg });
        }

        [HttpPost]
        public async Task<IActionResult> DeleteAuthor(uint? id)
        {
            if (id == null)
                return BadRequest();

            var msg = ERR_Delete;

            try
            {
                bool result = await Context.DeleteAuthorAsync(id.Value);
                if (result) return Ok();
            }
            catch (Exception ex)
            {
                msg = GetErrorMessage("delete", ex);
            }

            return Json(new { msg });
        }

        #endregion

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        private static string GetErrorMessage(string action, Exception ex)
        {
            return $"Failed to {action}:{Environment.NewLine}{Environment.NewLine}{ex.Message}";
        }
    }
}