import { Injectable, Inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { map } from 'rxjs/operators';
import { BlogSummary } from '../models/blog-summary';
import { BlogPost } from '../models/blog-post';

@Injectable({
	providedIn: 'root'
})
export class BlogService {
	myAppUrl = '';

	constructor(private _http: HttpClient, @Inject('BASE_URL') baseUrl: string) {
		this.myAppUrl = baseUrl + 'api/Blog/';
	}

	//getCityList() {
	//	return this._http.get(this.myAppUrl + 'GetCityList')
	//		.pipe(map(
	//			response => {
	//				return response;
	//			}));
	//}

	//getReccount(id: number): number {
		//return this._http.get(this.myAppUrl + 'Reccount/' + id)
		//	.pipe(map(
			  //response => {
				 // return response;
		//	  }));
//	}

	getAllBlogSummaries(pageNumber: number) {
		return this._http.get(this.myAppUrl + 'Index/' + pageNumber)
			.pipe(map(
			  response => {
				  return response;
			  }));
	}

	//getAllBlogSummaries() {
	//	return this._http.get(this.myAppUrl + 'Index').pipe(map(
	//		response => {
	//			return response;
	//		}));
	//}

	getBlogSummaryById(id: number) {
		return this._http.get(this.myAppUrl + 'Details/' + id)
			.pipe(map(
				response => {
					return response;
				}));
	}

	addBlogSummary(blogSummary: BlogSummary) {
		return this._http.post(this.myAppUrl + 'Create', blogSummary)
			.pipe(map(
				response => {
					return response;
				}));
	}

	updateBlogSummary(blogSummary: BlogSummary) {
		return this._http.put(this.myAppUrl + 'Edit', blogSummary)
			.pipe(map(
				response => {
					return response;
				}));
	}

	deleteBlogSummary(id: number) {
		return this._http.delete(this.myAppUrl + 'Delete/' + id)
			.pipe(map(
				response => {
					return response;
				}));
	}

	getBlogPostById(id: number) {
		return this._http.get(this.myAppUrl + 'Readmore/' + id)
			.pipe(map(
				response => {
					return response;
				}));
	}
}

