using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ng_blog.Models
{
	public class BlogPost
	{
		public int PostId { get; set; }
		public int BlogId { get; set; }
		public string Title { get; set; }
		public string Author { get; set; }
		public string Image { get; set; }
		public string Body { get; set; }
		public string Created { get; set; }
	}
}
