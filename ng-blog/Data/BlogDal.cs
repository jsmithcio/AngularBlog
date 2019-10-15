using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using ng_blog.Data;
using ng_blog.Models;
using Microsoft.Extensions.Configuration;
using System.Text;
using System.IO;
using Microsoft.AspNetCore.Hosting;
using Newtonsoft.Json;

namespace ng_blog.Data
{
	public class BlogDal : IBlog
	{		
		private readonly string connstr;
		public string ConnectionString {
			get { return this.connstr; }
		}
		
		public BlogDal(IConfiguration configuration)
		{
			connstr = configuration["ConnectionStrings:BlogDbConn"];
		}

		public int RecCount(int blog_id){//for debugging only
			Int32 retval = 0;
			string sproc = "sel_get_rec_count";
			Int32 temp = (Int32)blog_id;
			try{ 
				using (SqlConnection conn = new SqlConnection(this.ConnectionString)){
					using (SqlCommand cmd = new SqlCommand(sproc, conn)){
						cmd.Parameters.Add("@blog_id", SqlDbType.Int).Value = temp;
						cmd.CommandType = CommandType.StoredProcedure;
						conn.Open();
						retval = cmd.ExecuteNonQuery();						
						conn.Close();
					}
				}
				return retval;
			}
			catch{
				throw;
			}
			//return retval;
		}

		//public async Task<List<BlogSummary>> GetPaginatedResult(int currentPage, int pageSize = 3) {
		//	var data = await GetData();
		//	return data.OrderBy(data => data.BlogId).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();
		//}

		//public async Task<int> GetCount() {
		//	var data = await GetData();
		//	return data.Count;
		//}

		//private async Task<List<BlogSummary>> GetData() {
		//	//var json = await File.ReadAllTextAsync(Path.Combine(_webHostEnvironment.ContentRootPath, "Data", "paging.json"));
		//	var json = this.GetAllBlogSummaries();
		//	//return JsonSerializer.Deserialize<List<BlogSummary>>(json);
		//	return JsonConvert.DeserializeObject<List<BlogSummary>>(json);
		//}

		public IEnumerable<BlogSummary> GetAllBlogSummaries(int pageNumber = 1){
			
			string sproc = "sel_get_blog_headers";
			try
			{
				List<BlogSummary> lstBlogSummaries = new List<BlogSummary>();
				using (SqlConnection conn = new SqlConnection(this.ConnectionString))
				{
					using (SqlCommand cmd = new SqlCommand(sproc, conn))
					{
						cmd.CommandType = CommandType.StoredProcedure;
						//cmd.Parameters.Add("@page_number", SqlDbType.Int).Value = pageNumber;
						conn.Open();
						using (SqlDataReader rdr = cmd.ExecuteReader()){
							while (rdr.Read())
							{
								BlogSummary blogSummary = new BlogSummary();
								blogSummary.BlogId = Convert.ToInt32(rdr["BlogID"]);
								blogSummary.Title = rdr["Title"].ToString();
								blogSummary.Author = rdr["Author"].ToString();
								blogSummary.Image = rdr["Image"].ToString();
								blogSummary.Summary = rdr["Summary"].ToString();
								blogSummary.Link = rdr["Link"].ToString();								
								blogSummary.Created = rdr["Created"].ToString();
								lstBlogSummaries.Add(blogSummary);
							}
							conn.Close();
						}
					}
				}

				int pageSize = 3;

				IEnumerable<BlogSummary> result;

				if(pageNumber >= 1) { 
					result = lstBlogSummaries.Skip((pageNumber - 1) * pageSize).Take(pageSize);
				}
				else {
					result = lstBlogSummaries.Skip((pageNumber) * pageSize).Take(pageSize);
				}

				return result;
			}
			catch
			{
				throw;
			}
		}

		public int AddBlogSummary(BlogSummary blogSummary)
		{
			string sproc = "ins_add_blog_header";
			try
			{
				using (SqlConnection conn = new SqlConnection(this.ConnectionString))
				{
					using (SqlCommand cmd = new SqlCommand(sproc, conn))
					{
						cmd.CommandType = CommandType.StoredProcedure;
						cmd.Parameters.Add("@title", SqlDbType.NVarChar).Value = blogSummary.Title;
						cmd.Parameters.Add("@author", SqlDbType.NVarChar).Value = blogSummary.Author;//optional
						cmd.Parameters.Add("@image", SqlDbType.NVarChar).Value = blogSummary.Image;
						cmd.Parameters.Add("@summary", SqlDbType.NVarChar).Value = blogSummary.Summary;
						cmd.Parameters.Add("@link", SqlDbType.NVarChar).Value = blogSummary.Link;
						conn.Open();
						cmd.ExecuteNonQuery();
						conn.Close();
					}
				}
				return 1;
			}
			catch
			{
				throw;
			}
		}

		public void AddTestData(string td) {
			string sproc = "sel_add_test_data";
			try
			{
				using (SqlConnection conn = new SqlConnection(this.ConnectionString))
				{
					using (SqlCommand cmd = new SqlCommand(sproc, conn))
					{
						cmd.CommandType = CommandType.StoredProcedure;
						cmd.Parameters.Add("@td", SqlDbType.NVarChar).Value = td;
						conn.Open();
						cmd.ExecuteNonQuery();
						conn.Close();
					}
				}				
			}
			catch
			{
				throw;
			}
		}

		public int UpdateBlogSummary(BlogSummary blogSummary)
		{
			string sproc = "upd_update_blog_header";
			try
			{
				using (SqlConnection conn = new SqlConnection(this.ConnectionString))
				{
					using (SqlCommand cmd = new SqlCommand(sproc, conn))
					{
						cmd.CommandType = CommandType.StoredProcedure;
						cmd.Parameters.Add("@blog_id", SqlDbType.Int).Value = blogSummary.BlogId;
						cmd.Parameters.Add("@title", SqlDbType.NVarChar).Value = blogSummary.Title;
						if(blogSummary.Author.Length > 0) { 
						cmd.Parameters.Add("@author", SqlDbType.NVarChar).Value = blogSummary.Author; }
						else { cmd.Parameters.Add("@author", SqlDbType.NVarChar).Value = ""; }
						cmd.Parameters.Add("@image", SqlDbType.NVarChar).Value = blogSummary.Image;
						cmd.Parameters.Add("@summary", SqlDbType.NVarChar).Value = blogSummary.Summary;
						cmd.Parameters.Add("@link", SqlDbType.NVarChar).Value = blogSummary.Link;
						conn.Open();
						cmd.ExecuteNonQuery();
						conn.Close();
					}
				}
				return 1;
			}
			catch
			{
				throw;
			}
		}

		public BlogSummary GetBlogSummaryById(int id)
		{
			string sproc = "sel_get_blog_header_by_blog_id";
			try
			{
				BlogSummary blogSummary = new BlogSummary();
				using (SqlConnection conn = new SqlConnection(this.ConnectionString))
				{
					using (SqlCommand cmd = new SqlCommand(sproc, conn))
					{
						cmd.CommandType = CommandType.StoredProcedure;
						cmd.Parameters.Add("@blog_id", SqlDbType.Int).Value = id;
						conn.Open();
						using (SqlDataReader rdr = cmd.ExecuteReader())
						{
							while (rdr.Read())
							{
								blogSummary.BlogId = Convert.ToInt32(rdr["BlogID"]);
								blogSummary.Title = rdr["Title"].ToString();
								blogSummary.Author = rdr["Author"].ToString();								
								blogSummary.Image = rdr["Image"].ToString();
								blogSummary.Summary = rdr["Summary"].ToString();
								blogSummary.Link = rdr["Link"].ToString();
								blogSummary.Created = rdr["Created"].ToString();
							}
						}
					}
				}
				return blogSummary;
			}
			catch
			{
				throw;
			}
		}

		public int DeleteBlogSummary(int id)
		{
			string sproc = "del_delete_blog_header";
			try
			{
				using (SqlConnection conn = new SqlConnection(this.ConnectionString))
				{
					using (SqlCommand cmd = new SqlCommand(sproc, conn))
					{
						cmd.CommandType = CommandType.StoredProcedure;
						cmd.Parameters.Add("@blog_id", SqlDbType.Int).Value = id;
						conn.Open();
						cmd.ExecuteNonQuery();
						conn.Close();
					}
				}
				return 1;
			}
			catch
			{
				throw;
			}
		}

		public BlogPost GetBlogPostById(int id)
		{
			string sproc = "sel_get_blog_post";
			try
			{
				BlogPost blogPost = new BlogPost();
				using (SqlConnection conn = new SqlConnection(this.ConnectionString))
				{
					using (SqlCommand cmd = new SqlCommand(sproc, conn))
					{
						cmd.CommandType = CommandType.StoredProcedure;
						cmd.Parameters.Add("@blog_id", SqlDbType.Int).Value = id;
						conn.Open();
						using (SqlDataReader rdr = cmd.ExecuteReader())
						{
							while (rdr.Read())
							{
								blogPost.PostId = Convert.ToInt32(rdr["PostID"]);
								blogPost.BlogId = Convert.ToInt32(rdr["BlogID"]);
								blogPost.Title = rdr["Title"].ToString();
								blogPost.Author = rdr["Author"].ToString();
								blogPost.Image = rdr["Image"].ToString();
								blogPost.Body = rdr["Body"].ToString();
								blogPost.Created = rdr["Created"].ToString();
							}
						}
					}
				}
				return blogPost;
			}
			catch
			{
				throw;
			}
		}

		//public List<City> GetCities()
		//{
		//	try
		//	{
		//		List<City> lstCity = new List<City>();

		//		using (SqlConnection con = new SqlConnection(this.ConnectionString))
		//		{
		//			SqlCommand cmd = new SqlCommand("spGetCityList", con);
		//			cmd.CommandType = CommandType.StoredProcedure;

		//			con.Open();
		//			SqlDataReader rdr = cmd.ExecuteReader();

		//			while (rdr.Read())
		//			{
		//				City city = new City();

		//				city.CityId = Convert.ToInt32(rdr["CityID"]);
		//				city.CityName = rdr["CityName"].ToString();
		//				lstCity.Add(city);
		//			}
		//			con.Close();
		//		}
		//		return lstCity;
		//	}
		//	catch
		//	{
		//		throw;
		//	}
		//}
	}
}
