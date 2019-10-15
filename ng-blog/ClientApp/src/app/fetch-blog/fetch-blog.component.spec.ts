import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { FetchBlogComponent } from './fetch-blog.component';

describe('FetchBlogComponent', () => {
  let component: FetchBlogComponent;
  let fixture: ComponentFixture<FetchBlogComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ FetchBlogComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FetchBlogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
