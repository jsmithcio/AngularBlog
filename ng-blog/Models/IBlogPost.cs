using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ng_blog.Models;
using ng_blog.Data;

namespace ng_blog.Models
{
	public interface IBlogPost
	{
		BlogPost GetBlogPostById(int id);
		//int DeleteBlogSummary(int id);
		//BlogPost GetBlogPostById(int postId, int blogId);

		//List<City> GetCities();
	}
}
