package com.rfp;

public class Rfp {

    private Integer rfpid;

    //  ���ȿ�û�� ����
    private String rfpname;

    //  ������
    private String duedate;

    //  �¶���,��ǥ
    private String type;
    
    

    public Integer getRfpid() {
        return rfpid;
    }

    public void setRfpid(Integer rfpid) {
        this.rfpid = rfpid;
    }

    public String getRfpname() {
        return rfpname;
    }

    public void setRfpname(String rfpname) {
        this.rfpname = rfpname;
    }

    public String getDuedate() {
        return duedate;
    }

    public void setDuedate(String duedate) {
        this.duedate = duedate;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    // Rfp �� ����
    public void CopyData(Rfp param)
    {
        this.rfpid = param.getRfpid();
        this.rfpname = param.getRfpname();
        this.duedate = param.getDuedate();
        this.type = param.getType();
    }
}