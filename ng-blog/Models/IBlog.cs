using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ng_blog.Models
{
	public interface IBlog
	{
		IEnumerable<BlogSummary> GetAllBlogSummaries(int id);
		int AddBlogSummary(BlogSummary blogSummary);
		int RecCount(int id);
		int UpdateBlogSummary(BlogSummary blogSummary);
		BlogSummary GetBlogSummaryById(int id);
		int DeleteBlogSummary(int id);
		BlogPost GetBlogPostById(int id);

		//Task<List<BlogSummary>> GetPaginatedResult(int currentPage, int pageSize = 3);
	}
}