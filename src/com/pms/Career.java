package com.pms;

//�������
public class Career {

private Integer careerid;

private String userid;

private String period;

private String careerdesc;

private String task;

//  ���� ����� �ٰ�
private String similarcareer;

//  �������
private String biz;

public String getBiz() {
	return biz;
}

public void setBiz(String biz) {
	this.biz = biz;
}

public String getApp() {
	return app;
}

public void setApp(String app) {
	this.app = app;
}

public String getDb() {
	return db;
}

public void setDb(String db) {
	this.db = db;
}

public String getArchi() {
	return archi;
}

public void setArchi(String archi) {
	this.archi = archi;
}

//  ���밳��
private String app;

//  �����ͺ��̽�
private String db;

//  ��Ű��ó
private String archi;

private String username;

public String getUsername() {
	return username;
}

public void setUsername(String username) {
	this.username = username;
}

public Integer getCareerid() {
    return careerid;
}

public void setCareerid(Integer careerid) {
    this.careerid = careerid;
}

public String getUserid() {
    return userid;
}

public void setUserid(String userid) {
    this.userid = userid;
}

public String getPeriod() {
    return period;
}

public void setPeriod(String period) {
    this.period = period;
}

public String getCareerdesc() {
    return careerdesc;
}

public void setCareerdesc(String careerdesc) {
    this.careerdesc = careerdesc;
}

public String getTask() {
    return task;
}

public void setTask(String task) {
    this.task = task;
}

public String getSimilarcareer() {
    return similarcareer;
}

public void setSimilarcareer(String similarcareer) {
    this.similarcareer = similarcareer;
}

// Career �� ����
public void CopyData(Career param)
{
    this.careerid = param.getCareerid();
    this.userid = param.getUserid();
    this.period = param.getPeriod();
    this.careerdesc = param.getCareerdesc();
    this.task = param.getTask();
    this.similarcareer = param.getSimilarcareer();
}
}
