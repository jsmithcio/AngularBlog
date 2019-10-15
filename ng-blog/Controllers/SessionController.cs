using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ng_blog.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SessionController : ControllerBase {
        
		// GET: api/Session
        //[HttpGet]
        //public IEnumerable<string> Get()
        //{
        //    return new string[] { "value1", "value2" };
        //}

		// GET: api/Session
		[HttpGet]
		public void Get(){
			var name = "name";
			var seshName = "ngBlogSesh";
			HttpContext.Session.SetString(name,seshName);
			return;
		}

		// GET: api/GetSessionData
		[HttpGet]  
		public string GetSessionData(){  
			return HttpContext.Session.GetString("name");
		}

        // GET: api/Session/5
        [HttpGet("{id}", Name = "Get")] 
        public string Get(int id){
            return "value";
        }

        // POST: api/Session
        //[HttpPost]
        //public void Post([FromBody] string value){
        //}

		// POST: api/Session
		[HttpPost]
		public void Post([FromBody] string value){
			var name = "name";
			var seshName = "ngBlogSesh";
			HttpContext.Session.SetString(name,seshName);
			return;
			//return (name + " " + seshName);  
		}

        // PUT: api/Session/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value){
        }

        // DELETE: api/ApiWithActions/5
        [HttpDelete("{id}")]
        public void Delete(int id){
        }
    }
}
