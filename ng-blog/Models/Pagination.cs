using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ng_blog.Models {
	public class Pagination {

		public int currentPage { get; set; } = 1;
		public int count { get; set; }
		public int pageSize { get; set; } = 3;

		public int totalPages => (int)Math.Ceiling(decimal.Divide(count, pageSize));

		List<BlogSummary> Data { get; set; }
	}
}
