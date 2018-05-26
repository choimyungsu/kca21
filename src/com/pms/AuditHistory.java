package com.pms;

import java.sql.Timestamp;

//감리경력
public class AuditHistory {

private Integer audithistoryid;

private Integer projectid;

private String projectname;

private String audityearmonth;

private String auditname;

private String mainclient;

private String maindivision;

private String auditfield;

private String auditrole;

private String joinrate;

private String userid;

private String username;


//  신규
private String auditstartdate;

//  신규
private String auditenddate;

public Integer getAudithistoryid() {
    return audithistoryid;
}

public void setAudithistoryid(Integer audithistoryid) {
    this.audithistoryid = audithistoryid;
}

public Integer getProjectid() {
    return projectid;
}

public void setProjectid(Integer projectid) {
    this.projectid = projectid;
}

public String getProjectname() {
    return projectname;
}

public void setProjectname(String projectname) {
    this.projectname = projectname;
}

public String getAudityearmonth() {
    return audityearmonth;
}

public void setAudityearmonth(String audityearmonth) {
    this.audityearmonth = audityearmonth;
}

public String getAuditname() {
    return auditname;
}

public void setAuditname(String auditname) {
    this.auditname = auditname;
}

public String getMainclient() {
    return mainclient;
}

public void setMainclient(String mainclient) {
    this.mainclient = mainclient;
}

public String getMaindivision() {
    return maindivision;
}

public void setMaindivision(String maindivision) {
    this.maindivision = maindivision;
}

public String getAuditfield() {
    return auditfield;
}

public void setAuditfield(String auditfield) {
    this.auditfield = auditfield;
}

public String getAuditrole() {
    return auditrole;
}

public void setAuditrole(String auditrole) {
    this.auditrole = auditrole;
}

public String getJoinrate() {
    return joinrate;
}

public void setJoinrate(String joinrate) {
    this.joinrate = joinrate;
}

public String getUserid() {
    return userid;
}

public void setUserid(String userid) {
    this.userid = userid;
}

public String getAuditstartdate() {
    return auditstartdate;
}

public void setAuditstartdate(String auditstartdate) {
    this.auditstartdate = auditstartdate;
}

public String getAuditenddate() {
    return auditenddate;
}

public void setAuditenddate(String auditenddate) {
    this.auditenddate = auditenddate;
}

public String getUsername() {
	return username;
}

public void setUsername(String username) {
	this.username = username;
}

// Audithistory 모델 복사
public void CopyData(AuditHistory param)
{
    this.audithistoryid = param.getAudithistoryid();
    this.projectid = param.getProjectid();
    this.projectname = param.getProjectname();
    this.audityearmonth = param.getAudityearmonth();
    this.auditname = param.getAuditname();
    this.mainclient = param.getMainclient();
    this.maindivision = param.getMaindivision();
    this.auditfield = param.getAuditfield();
    this.auditrole = param.getAuditrole();
    this.joinrate = param.getJoinrate();
    this.userid = param.getUserid();
    this.username = param.getUsername();
    this.auditstartdate = param.getAuditstartdate();
    this.auditenddate = param.getAuditenddate();
}
}
