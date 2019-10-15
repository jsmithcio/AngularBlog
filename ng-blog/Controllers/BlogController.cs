using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ng_blog.Models;
using ng_blog.Data;

namespace ng_blog.Controllers
{
	[Route("api/[controller]")]
	[ApiController]
	public class BlogController : ControllerBase
	{
		private readonly IBlog objBlog;
		//private readonly IBlogPost objBlogPost;

		public BlogController(IBlog _objBlog)
		{
			objBlog = _objBlog;
		}

		[HttpGet]
		[Route("Index/{id}")]
		public IEnumerable<BlogSummary> Index(int id)
		{
			return objBlog.GetAllBlogSummaries(id);
		}

		[HttpGet]
		[Route("Reccount/{id}")]
		public int GetReccount(int id){
			return objBlog.RecCount(id);
			//return 1;
		}

		[HttpPost]
		[Route("Create")]
		public int Create([FromBody] BlogSummary blogSummary)
		{
			return objBlog.AddBlogSummary(blogSummary);
			//return 1;
		}

		[HttpGet]
		[Route("Details/{id}")]
		public BlogSummary Details(int id)
		{
			return objBlog.GetBlogSummaryById(id);
		}

		[HttpPut]
		[Route("Edit")]
		public int Edit([FromBody]BlogSummary blogSummary)
		{
			return objBlog.UpdateBlogSummary(blogSummary);
			//return 1;
		}

		[HttpDelete]
		[Route("Delete/{id}")]
		public int Delete(int id)
		{
			return objBlog.DeleteBlogSummary(id);
			//return 1;
		}

		[HttpGet]
		[Route("Readmore/{id}")]
		public BlogPost Readmore(int id)
		{
			return objBlog.GetBlogPostById(id);
			//return objBlogPost.GetBlogPostById(id);
		}


		//[HttpGet]
		//[Route("GetCityList")]
		//public IEnumerable<City> Details()
		//{
		//	return objemployee.GetCities();
		//}

		//// GET: api/Blog
		//[HttpGet]
		//      public IEnumerable<string> Get()
		//      {
		//          return new string[] { "value1", "value2" };
		//      }

		//      // GET: api/Blog/5
		//      [HttpGet("{id}", Name = "Get")]
		//      public string Get(int id)
		//      {
		//          return "value";
		//      }

		//      // POST: api/Blog
		//      [HttpPost]
		//      public void Post([FromBody] string value)
		//      {
		//      }

		//      // PUT: api/Blog/5
		//      [HttpPut("{id}")]
		//      public void Put(int id, [FromBody] string value)
		//      {
		//      }

		//      // DELETE: api/ApiWithActions/5
		//      [HttpDelete("{id}")]
		//      public void Delete(int id)
		//      {
		//      }
	
	}
}
