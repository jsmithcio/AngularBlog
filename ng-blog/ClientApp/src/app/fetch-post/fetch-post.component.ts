import { Component, OnInit } from '@angular/core';
import { BlogService } from '../services/blog.service';
import { BlogPost } from '../models/blog-post';
import { CookieService } from "../services/cookie.service";
import { ActivatedRoute } from "@angular/router";

@Component({
  selector: 'app-fetch-post',
  templateUrl: './fetch-post.component.html',
  styleUrls: ['./fetch-post.component.css']
})
export class FetchPostComponent implements OnInit {

	private _blogPost: BlogPost;
	private _message: string = "";
	private _blogId: number;

	constructor(private _blogService: BlogService, private cookieService: CookieService, private _avRoute: ActivatedRoute) { }

	ngOnInit() {
		//this._message = "";
		//this._pageNumber = 0;
		//this.cookieService.consent("ngblg", "pg2", 1);//works

		if (this._avRoute.snapshot.params['id']) {
			this._blogId = this._avRoute.snapshot.params['id'];
		}
		else {
			this._blogId = 1;
		}

		this.getBlogPost();
	}

	getBlogPost() {
		this._blogService.getBlogPostById(this._blogId).subscribe(
			(data: BlogPost) => this._blogPost = data);
	}

}
