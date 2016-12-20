package com.zyfz.domain;

import java.util.Date;

public class UserWithdraw {
    private Integer id;

    private Double money;

    private Integer hhUserId;

    private String withdrawAccount;

    private String withdrawAccountType;

    private String withdrawAccountName;

    private Byte isHande;

    private Date createTime;

    private User user;

    public UserWithdraw() {
        super();
    }

    public UserWithdraw(Integer id) {
        this.id = id;
    }

    public UserWithdraw(Double money, Integer hhUserId, String withdrawAccount, String withdrawAccountType, String withdrawAccountName, Byte isHande, Date createTime, User user) {
        this.money = money;
        this.hhUserId = hhUserId;
        this.withdrawAccount = withdrawAccount;
        this.withdrawAccountType = withdrawAccountType;
        this.withdrawAccountName = withdrawAccountName;
        this.isHande = isHande;
        this.createTime = createTime;
        this.user = user;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public Integer getHhUserId() {
        return hhUserId;
    }

    public void setHhUserId(Integer hhUserId) {
        this.hhUserId = hhUserId;
    }

    public String getWithdrawAccount() {
        return withdrawAccount;
    }

    public void setWithdrawAccount(String withdrawAccount) {
        this.withdrawAccount = withdrawAccount;
    }

    public String getWithdrawAccountType() {
        return withdrawAccountType;
    }

    public void setWithdrawAccountType(String withdrawAccountType) {
        this.withdrawAccountType = withdrawAccountType;
    }

    public String getWithdrawAccountName() {
        return withdrawAccountName;
    }

    public void setWithdrawAccountName(String withdrawAccountName) {
        this.withdrawAccountName = withdrawAccountName;
    }

    public Byte getIsHande() {
        return isHande;
    }

    public void setIsHande(Byte isHande) {
        this.isHande = isHande;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}