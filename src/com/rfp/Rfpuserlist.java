package com.rfp;

public class Rfpuserlist {

    private Integer rfpuserlistid;

    //  rfpŰ
    private Integer rfpid;

    //  ����Ű
    private String userid;

    //  ����
    private String auditfield;
    
	//  �̸�
    private String username;
    
    //  ��������ȣ
    private String auditno;
    
    //  �����ѰǼ�
    private String cnt;
    
    //  ���� �ѽð�
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

    // Rfpuserlist �� ����
    public void CopyData(Rfpuserlist param)
    {
        this.rfpuserlistid = param.getRfpuserlistid();
        this.rfpid = param.getRfpid();
        this.userid = param.getUserid();
        this.auditfield = param.getAuditfield();
    }
}