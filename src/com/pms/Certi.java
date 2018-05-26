package com.pms;

//자격정보
public class Certi {

private Integer certiid;

private String userid;

private String certiname;

private String issuer;

private String certidivision;

private String certifield;

private String issuedate;

public String getIssuedate() {
	return issuedate;
}

public void setIssuedate(String issuedate) {
	this.issuedate = issuedate;
}

public Integer getCertiid() {
    return certiid;
}

public void setCertiid(Integer certiid) {
    this.certiid = certiid;
}

public String getUserid() {
    return userid;
}

public void setUserid(String userid) {
    this.userid = userid;
}

public String getCertiname() {
    return certiname;
}

public void setCertiname(String certiname) {
    this.certiname = certiname;
}

public String getIssuer() {
    return issuer;
}

public void setIssuer(String issuer) {
    this.issuer = issuer;
}

public String getCertidivision() {
    return certidivision;
}

public void setCertidivision(String certidivision) {
    this.certidivision = certidivision;
}

public String getCertifield() {
    return certifield;
}

public void setCertifield(String certifield) {
    this.certifield = certifield;
}

// Certi 모델 복사
public void CopyData(Certi param)
{
    this.certiid = param.getCertiid();
    this.userid = param.getUserid();
    this.certiname = param.getCertiname();
    this.issuer = param.getIssuer();
    this.certidivision = param.getCertidivision();
    this.certifield = param.getCertifield();
}
}