import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { BlogService } from '../services/blog.service';
import { BlogSummary } from '../models/blog-summary';
import { CookieService } from "../services/cookie.service";

@Component({
	selector: 'app-fetch-blog',
	templateUrl: './fetch-blog.component.html',
	styleUrls: ['./fetch-blog.component.css']
})
export class FetchBlogComponent implements OnInit {

	public _blogList: BlogSummary[];
	private _message: string;
	private _sessionId: string;
	public _tempId: number = 1;
	public recCount: number;
	public _pageNumber: number;  

	constructor(private _blogService: BlogService, private cookieService: CookieService, private router: Router){
		  //this._sessionId = cookieService.get("sessionId");
		  //this._message = "fetch-blog constructor _sessionId value: " + this._sessionId;
		  //console.log(this._message);
		  //this.cookieService.consent("ngB", 1);		  
	}

	ngOnInit() {
      this._message = "";
		  this._pageNumber = 0;
		  //this.cookieService.consent("ngblg", "pg2",  1);//works
		  this.getBlogSummaries();
	}

	gotoBlogPost(blogId: any) {
		this.router.navigate(['/fetch-post/', blogId]);
	}

	public set sessionId(value: string){
		  this._sessionId = value;
		  //this.cookieService.set("sessionId", value);
	}

// private populateStorage(){
      //	localStorage.setItem('currentIndex', document.getElementById('blogList.blogId');
      //	localStorage.setItem('font', document.getElementById('font').value);
      //	localStorage.setItem('image', document.getElementById('image').value);
      //	setStyles();
//}

	getBlogSummaries(){
		// console.log(this.cookieService.getCookie("ngblg"));//works
		// this.recCount = this._blogService.getReccount(id);//works
		this._pageNumber += 1;
		this._blogService.getAllBlogSummaries(this._pageNumber).subscribe(
			(data: BlogSummary[]) => this._blogList = data);
	}

	delete(blogId){
		const ans = confirm('Do you want to delete blog with Id: ' + blogId);
		if (ans) {
			this._pageNumber = 0;//?
			this._blogService.deleteBlogSummary(blogId).subscribe(() => {
				this.getBlogSummaries();
			}, error => console.error(error));
		}
	}
}
