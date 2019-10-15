using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ng_blog.Models
{
	public class BlogSummary
	{
		public int BlogId { get; set; }
		public string Title { get; set; }
		public string Author { get; set; }
		public string Created { get; set; }
		public string Image { get; set; }
		public string Summary { get; set; }
		public string Link { get; set; }
	}
}
