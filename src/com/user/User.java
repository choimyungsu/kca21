package com.user;

public class User {

    private String userid;

    private String userpassword;

    private String username;

    private String useremail;

    //  �μ�
    private String userdept;

    //  ����
    private String userlevel;

    //  �Ҽ�
    private String org;

    //  0-����,1-���
    private Integer available;

    private String birth;
    
    //  Y-��������
    private String manager;
    
    //  ��������ȣ
    private String  auditno;
    
    public String getCnt() {
		return cnt;
	}

	public void setCnt(String cnt) {
		this.cnt = cnt;
	}

	public String getEdu() {
		return edu;
	}

	public void setEdu(String edu) {
		this.edu = edu;
	}

	//  ����Ƚ�� - �ƿ��� �������� ������
    private String  cnt;
    
    //  �ѱ����ð� - �ƿ��� �������� ������
    private String  edu;
    
    //  ������Ʈ �ð�
    private String  updatedate;
    

    public String getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	}

	public String getAuditno() {
		return auditno;
	}

	public void setAuditno(String auditno) {
		this.auditno = auditno;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUserpassword() {
        return userpassword;
    }

    public void setUserpassword(String userpassword) {
        this.userpassword = userpassword;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUseremail() {
        return useremail;
    }

    public void setUseremail(String useremail) {
        this.useremail = useremail;
    }

    public String getUserdept() {
        return userdept;
    }

    public void setUserdept(String userdept) {
        this.userdept = userdept;
    }

    public String getUserlevel() {
        return userlevel;
    }

    public void setUserlevel(String userlevel) {
        this.userlevel = userlevel;
    }

    public String getOrg() {
        return org;
    }

    public void setOrg(String org) {
        this.org = org;
    }

    public Integer getAvailable() {
        return available;
    }

    public void setAvailable(Integer available) {
        this.available = available;
    }

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth;
    }

    // User �� ����
    public void CopyData(User param)
    {
        this.userid = param.getUserid();
        this.userpassword = param.getUserpassword();
        this.username = param.getUsername();
        this.useremail = param.getUseremail();
        this.userdept = param.getUserdept();
        this.userlevel = param.getUserlevel();
        this.org = param.getOrg();
        this.available = param.getAvailable();
        this.birth = param.getBirth();
    }
}
