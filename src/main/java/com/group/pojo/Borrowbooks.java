package com.group.pojo;

import java.util.Date;

public class Borrowbooks extends Page{
    private Integer id;

    private Integer userid;

    private Integer bookid;

    private Date date;

    private Integer state;

    private String appraisal;
    private  Book book;
    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Integer getBookid() {
        return bookid;
    }

    public void setBookid(Integer bookid) {
        this.bookid = bookid;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public String getAppraisal() {
        return appraisal;
    }

    public void setAppraisal(String appraisal) {
        this.appraisal = appraisal;
    }

    @Override
    public String toString() {
        return "Borrowbooks{" +
                "id=" + id +
                ", userid=" + userid +
                ", bookid=" + bookid +
                ", date=" + date +
                ", state=" + state +
                ", appraisal='" + appraisal + '\'' +
                ", book=" + book +
                '}';
    }
}