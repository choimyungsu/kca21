package com.calendar;

//���� 
public class Calendar {

 private Integer calendarid;

 // ������ ���� ���� 
 private String id;

 // ������ 
 private String title;

 // ������ 
 private String start;

 // ������ 
 private String end;

 // �����ּ� 
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

 // Calendar �� ����
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
