package com.pms;

//사업경험
public class Career {

private Integer careerid;

private String userid;

private String period;

private String careerdesc;

private String task;

//  유사 경력의 근거
private String similarcareer;

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

// Career 모델 복사
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
