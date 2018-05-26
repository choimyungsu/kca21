package com.user;

public class User {

    private String userid;

    private String userpassword;

    private String username;

    private String useremail;

    //  부서
    private String userdept;

    //  직급
    private String userlevel;

    //  소속
    private String org;

    //  0-재직,1-퇴사
    private Integer available;

    private String birth;
    
    //  Y-관리권한
    private String manager;

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

    // User 모델 복사
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
