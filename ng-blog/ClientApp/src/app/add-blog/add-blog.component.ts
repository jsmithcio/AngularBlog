import { Component, OnInit } from '@angular/core';
import { Validators, FormGroup, FormBuilder } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { BlogService } from '../services/blog.service';
import { BlogPost } from '../models/blog-post';
import { BlogSummary } from '../models/blog-summary';

@Component({
	selector: 'app-add-blog',
	templateUrl: './add-blog.component.html',
	styleUrls: ['./add-blog.component.css']
})
export class AddBlogComponent implements OnInit {

	blogForm: FormGroup;
	formtitle = 'Create';
	blogId: number;
	errorMessage: any;
	blogAuthor: string = 'jason';
	//cityList: City[];

	constructor(private _fb: FormBuilder, private _avRoute: ActivatedRoute,
		private _blogService: BlogService, private _router: Router) {
		if (this._avRoute.snapshot.params['id']) {
			this.blogId = this._avRoute.snapshot.params['id'];
		}

		this.blogForm = this._fb.group({
			blogId: 0,
			title: ['', [Validators.required]],
			author: ['', [Validators.required]],
			created: ['', []],
			image: ['', [Validators.required]],
			summary: ['', [Validators.required]],
			link: ['', [Validators.required]],
		})
	}
	ngOnInit() {
		//this._blogService.getCityList().subscribe(
		//	(data: City[]) => this.cityList = data
		//);

		if (this.blogId > 0) {
			this.formtitle = 'Edit';
			this._blogService.getBlogSummaryById(this.blogId)
				.subscribe((response: BlogSummary) => {
					this.blogForm.setValue(response);
				}, error => console.error(error));
		}
	}

	save() {
		if (!this.blogForm.valid) {
			return;
		}
		if (this.formtitle === 'Create') {
			this._blogService.addBlogSummary(this.blogForm.value)
				.subscribe(() => {
					this._router.navigate(['/fetch-blog']);
				}, error => console.error(error));
		} else if (this.formtitle === 'Edit') {
			this._blogService.updateBlogSummary(this.blogForm.value)
				.subscribe(() => {
					this._router.navigate(['/fetch-blog']);
				}, error => console.error(error));
		}
	}

	cancel() {
		this._router.navigate(['/fetch-blog']);
	}

	get title() { return this.blogForm.get('title'); }
	//get author() { return 'jason'; }
  get author() { return this.blogForm.get('author'); }
	get created() { return this.blogForm.get('created'); }
	get image() { return this.blogForm.get('image'); }
	get summary() { return this.blogForm.get('summary'); }
	get link() { return this.blogForm.get('link'); }
}
