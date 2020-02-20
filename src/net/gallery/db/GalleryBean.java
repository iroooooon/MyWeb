package net.gallery.db;

import java.sql.Timestamp;

public class GalleryBean {
	private int num;
	private String id;
	private String pass;
	private String subject;
	private String img_name;
	private String content;
	private int readcount;
	private Timestamp reg_date;
	
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getImg_name() {
		return img_name;
	}
	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	@Override
	public String toString() {
		return "GalleryBean [num=" + num + ", id=" + id + ", pass=" + pass + ", subject=" + subject + ", realPath="
				+ ", img_name=" + img_name + ", content=" + content + ", readcount=" + readcount
				+ ", reg_date=" + reg_date + "]";
	}
	
	
}
