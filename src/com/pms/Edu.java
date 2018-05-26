package com.pms;

//±³À°ÀÌ¼ö
public class Edu {

private Integer eduid;

private String userid;

private String edudesc;

private String edutime;

private String eduperiod;


private String eduagency;

public Integer getEduid() {
    return eduid;
}


public void setEduid(Integer eduid) {
    this.eduid = eduid;
}

public String getUserid() {
    return userid;
}

public void setUserid(String userid) {
    this.userid = userid;
}

public String getEdudesc() {
    return edudesc;
}

public void setEdudesc(String edudesc) {
    this.edudesc = edudesc;
}

public String getEdutime() {
    return edutime;
}

public void setEdutime(String edutime) {
    this.edutime = edutime;
}
public String getEduperiod() {
	return eduperiod;
}

public void setEduperiod(String eduperiod) {
	this.eduperiod = eduperiod;
}

public String getEduagency() {
    return eduagency;
}

public void setEduagency(String eduagency) {
    this.eduagency = eduagency;
}

// Edu ¸ðµ¨ º¹»ç
public void CopyData(Edu param)
{
    this.eduid = param.getEduid();
    this.userid = param.getUserid();
    this.edudesc = param.getEdudesc();
    this.edutime = param.getEdutime();
    this.eduperiod = param.getEduperiod();
    this.eduagency = param.getEduagency();
}
}
