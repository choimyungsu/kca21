package com.rfp;

public class Rfpuserlist {

    private Integer rfpuserlistid;

    //  rfp키
    private Integer rfpid;

    //  유저키
    private String userid;

    //  영역
    private String auditfield;
    
	//  이름
    private String username;
    
    //  감리원번호
    private String auditno;
    
    //  감리총건수
    private String cnt;
    
    //  교육 총시간
    private String eduTime;
    
    public String getEduTime() {
		return eduTime;
	}

	public void setEduTime(String eduTime) {
		this.eduTime = eduTime;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getAuditno() {
		return auditno;
	}

	public void setAuditno(String auditno) {
		this.auditno = auditno;
	}

	public String getCnt() {
		return cnt;
	}

	public void setCnt(String cnt) {
		this.cnt = cnt;
	}


    

    public Integer getRfpuserlistid() {
        return rfpuserlistid;
    }

    public void setRfpuserlistid(Integer rfpuserlistid) {
        this.rfpuserlistid = rfpuserlistid;
    }

    public Integer getRfpid() {
        return rfpid;
    }

    public void setRfpid(Integer rfpid) {
        this.rfpid = rfpid;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getAuditfield() {
        return auditfield;
    }

    public void setAuditfield(String auditfield) {
        this.auditfield = auditfield;
    }

    // Rfpuserlist 모델 복사
    public void CopyData(Rfpuserlist param)
    {
        this.rfpuserlistid = param.getRfpuserlistid();
        this.rfpid = param.getRfpid();
        this.userid = param.getUserid();
        this.auditfield = param.getAuditfield();
    }
}