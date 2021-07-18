package com.ticket.entity;


import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="request_message", schema="public")
public class Message {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id", columnDefinition="serial")
	private Integer id;
	@Column(name="request_id")
	private Integer rid;
	@Column(name="message")
	private String msg;
	@Column(name="user_id")
	private Integer uid;
	@Column(name="date")
	private Date date = new Date();
	@Column(name = "whose_msg")
	private String whoseMsg;
	
	public String getWhoseMsg() {
		return whoseMsg;
	}

	public void setWhoseMsg(String whoseMsg) {
		this.whoseMsg = whoseMsg;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getRid() {
		return rid;
	}
	public void setRid(Integer rid) {
		this.rid = rid;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	
	
}
