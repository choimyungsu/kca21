package com.pms;


//��������̷�
public class AuditReport {

private Integer auditreportid;

private Integer projectid;

//  ����
private String seq;

//  ������
private String auditname;

//  ���尨���Ⱓ
private String placeauditdate;

//  ���尨��(����,��ġ)
private String auditdate;

//  ����������
private String auditors;

//  ���о�
private String auditfield;

//  �������Ⱓ
private String contractauditdate;

//  ����ó
private String mainclient;

//  �ǰ������
private String developcompany;

//  ������
private String auditcost;

//  �����
private String developcost;

//  ���߹����
private String developmethod;

//  �������(��ǥ)
private String bizoverview;

//  �������(������)
private String bizscope;

//  ����Ⱓ
private String bizperiod;

//  ��ұ��
private String maintechnology;

//  ��������
private Integer auditavailable;

private String auditstartdate;

private String auditenddate;

private String mainauditor;

private String auditstep;

private String createdate;

private String updatedate;

public Integer getAuditreportid() {
    return auditreportid;
}

public void setAuditreportid(Integer auditreportid) {
    this.auditreportid = auditreportid;
}

public Integer getProjectid() {
    return projectid;
}

public void setProjectid(Integer projectid) {
    this.projectid = projectid;
}

public String getSeq() {
    return seq;
}

public void setSeq(String seq) {
    this.seq = seq;
}

public String getAuditname() {
    return auditname;
}

public void setAuditname(String auditname) {
    this.auditname = auditname;
}

public String getPlaceauditdate() {
    return placeauditdate;
}

public void setPlaceauditdate(String placeauditdate) {
    this.placeauditdate = placeauditdate;
}

public String getAuditdate() {
    return auditdate;
}

public void setAuditdate(String auditdate) {
    this.auditdate = auditdate;
}

public String getAuditors() {
    return auditors;
}

public void setAuditors(String auditors) {
    this.auditors = auditors;
}

public String getAuditfield() {
    return auditfield;
}

public void setAuditfield(String auditfield) {
    this.auditfield = auditfield;
}

public String getContractauditdate() {
    return contractauditdate;
}

public void setContractauditdate(String contractauditdate) {
    this.contractauditdate = contractauditdate;
}

public String getMainclient() {
    return mainclient;
}

public void setMainclient(String mainclient) {
    this.mainclient = mainclient;
}

public String getDevelopcompany() {
    return developcompany;
}

public void setDevelopcompany(String developcompany) {
    this.developcompany = developcompany;
}

public String getAuditcost() {
    return auditcost;
}

public void setAuditcost(String auditcost) {
    this.auditcost = auditcost;
}

public String getDevelopcost() {
    return developcost;
}

public void setDevelopcost(String developcost) {
    this.developcost = developcost;
}

public String getDevelopmethod() {
    return developmethod;
}

public void setDevelopmethod(String developmethod) {
    this.developmethod = developmethod;
}

public String getBizoverview() {
    return bizoverview;
}

public void setBizoverview(String bizoverview) {
    this.bizoverview = bizoverview;
}

public String getBizscope() {
    return bizscope;
}

public void setBizscope(String bizscope) {
    this.bizscope = bizscope;
}

public String getBizperiod() {
    return bizperiod;
}

public void setBizperiod(String bizperiod) {
    this.bizperiod = bizperiod;
}

public String getMaintechnology() {
    return maintechnology;
}

public void setMaintechnology(String maintechnology) {
    this.maintechnology = maintechnology;
}

public Integer getAuditavailable() {
    return auditavailable;
}

public void setAuditavailable(Integer auditavailable) {
    this.auditavailable = auditavailable;
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

public String getMainauditor() {
    return mainauditor;
}

public void setMainauditor(String mainauditor) {
    this.mainauditor = mainauditor;
}

public String getAuditstep() {
    return auditstep;
}

public void setAuditstep(String auditstep) {
    this.auditstep = auditstep;
}

public String getCreatedate() {
    return createdate;
}

public void setCreatedate(String createdate) {
    this.createdate = createdate;
}

public String getUpdatedate() {
    return updatedate;
}

public void setUpdatedate(String updatedate) {
    this.updatedate = updatedate;
}

// Auditreport �� ����
public void CopyData(AuditReport param)
{
    this.auditreportid = param.getAuditreportid();
    this.projectid = param.getProjectid();
    this.seq = param.getSeq();
    this.auditname = param.getAuditname();
    this.placeauditdate = param.getPlaceauditdate();
    this.auditdate = param.getAuditdate();
    this.auditors = param.getAuditors();
    this.auditfield = param.getAuditfield();
    this.contractauditdate = param.getContractauditdate();
    this.mainclient = param.getMainclient();
    this.developcompany = param.getDevelopcompany();
    this.auditcost = param.getAuditcost();
    this.developcost = param.getDevelopcost();
    this.developmethod = param.getDevelopmethod();
    this.bizoverview = param.getBizoverview();
    this.bizscope = param.getBizscope();
    this.bizperiod = param.getBizperiod();
    this.maintechnology = param.getMaintechnology();
    this.auditavailable = param.getAuditavailable();
    this.auditstartdate = param.getAuditstartdate();
    this.auditenddate = param.getAuditenddate();
    this.mainauditor = param.getMainauditor();
    this.auditstep = param.getAuditstep();
    this.createdate = param.getCreatedate();
    this.updatedate = param.getUpdatedate();
}
}
