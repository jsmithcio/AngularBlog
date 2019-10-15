import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { RouterModule } from '@angular/router';

import { AppComponent } from './app.component';
import { NavMenuComponent } from './nav-menu/nav-menu.component';
import { HomeComponent } from './home/home.component';
import { CounterComponent } from './counter/counter.component';
import { FetchDataComponent } from './fetch-data/fetch-data.component';
import { ApiAuthorizationModule } from 'src/api-authorization/api-authorization.module';
import { AuthorizeGuard } from 'src/api-authorization/authorize.guard';
import { AuthorizeInterceptor } from 'src/api-authorization/authorize.interceptor';
import { AddBlogComponent } from './add-blog/add-blog.component';
import { FetchBlogComponent } from './fetch-blog/fetch-blog.component';
import { CookieService } from "./services/cookie.service";
import { FooterComponent } from './footer/footer.component';
import { SearchWidgetComponent } from './search-widget/search-widget.component';
import { CategoriesWidgetComponent } from './categories-widget/categories-widget.component';
import { SideWidgetComponent } from './side-widget/side-widget.component';
import { PaginationWidgetComponent } from './pagination-widget/pagination-widget.component';
import { FetchPostComponent } from './fetch-post/fetch-post.component';
import { NotFoundComponent } from './notfound/notfound.component';
import { RecentsWidgetComponent } from './recents-widget/recents-widget.component';

@NgModule({
  declarations: [
    AppComponent,
    NavMenuComponent,
    HomeComponent,
    CounterComponent,
    FetchDataComponent,
    AddBlogComponent,
    FetchBlogComponent,
    FooterComponent,
    SearchWidgetComponent,
    CategoriesWidgetComponent,
    SideWidgetComponent,
    PaginationWidgetComponent,
    FetchPostComponent,
    NotFoundComponent,
    RecentsWidgetComponent,
  ],
  imports: [
    BrowserModule.withServerTransition({ appId: 'ng-cli-universal' }),
    HttpClientModule,
	  //FormsModule,
    ReactiveFormsModule,
    ApiAuthorizationModule,
    RouterModule.forRoot([
      { path: '', component: HomeComponent, pathMatch: 'full' },
      { path: 'counter', component: CounterComponent },
		  //{ path: 'fetch-data', component: FetchDataComponent, canActivate: [AuthorizeGuard] },
		  { path: 'fetch-blog', component: FetchBlogComponent },
		  { path: 'register-blog', component: AddBlogComponent },
		  { path: 'blogSummary/edit/:id', component: AddBlogComponent },
		  { path: 'fetch-post/:id', component: FetchPostComponent },
		  { path: '**', pathMatch: 'full', component: NotFoundComponent },
    ])
  ],
  providers: [
	  { provide: HTTP_INTERCEPTORS, useClass: AuthorizeInterceptor, multi: true }, CookieService],
	bootstrap: [AppComponent, FooterComponent, CategoriesWidgetComponent, SideWidgetComponent,
		PaginationWidgetComponent, RecentsWidgetComponent, SearchWidgetComponent]
})
export class AppModule { }
