import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { FetchPostComponent } from './fetch-post.component';

describe('FetchPostComponent', () => {
  let component: FetchPostComponent;
  let fixture: ComponentFixture<FetchPostComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ FetchPostComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FetchPostComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
