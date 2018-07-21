package com.calendar;

//일정 
public class Calendar {

 private Integer calendarid;

 // 동일한 일정 묶음 
 private String id;

 // 일정명 
 private String title;

 // 시작일 
 private String start;

 // 종료일 
 private String end;

 // 연결주소 
 private String url;

 public Integer getCalendarid() {
     return calendarid;
 }

 public void setCalendarid(Integer calendarid) {
     this.calendarid = calendarid;
 }

 public String getId() {
     return id;
 }

 public void setId(String id) {
     this.id = id;
 }

 public String getTitle() {
     return title;
 }

 public void setTitle(String title) {
     this.title = title;
 }

 public String getStart() {
     return start;
 }

 public void setStart(String start) {
     this.start = start;
 }

 public String getEnd() {
     return end;
 }

 public void setEnd(String end) {
     this.end = end;
 }

 public String getUrl() {
     return url;
 }

 public void setUrl(String url) {
     this.url = url;
 }

 // Calendar 모델 복사
 public void CopyData(Calendar param)
 {
     this.calendarid = param.getCalendarid();
     this.id = param.getId();
     this.title = param.getTitle();
     this.start = param.getStart();
     this.end = param.getEnd();
     this.url = param.getUrl();
 }
}
