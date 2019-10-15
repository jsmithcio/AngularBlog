import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RecentsWidgetComponent } from './recents-widget.component';

describe('RecentsWidgetComponent', () => {
  let component: RecentsWidgetComponent;
  let fixture: ComponentFixture<RecentsWidgetComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RecentsWidgetComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RecentsWidgetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
