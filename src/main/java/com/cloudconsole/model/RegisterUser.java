package com.cloudconsole.model;

import java.sql.Timestamp;

public class RegisterUser {
	
	private String id;
	
	private Timestamp createdTime;
	
	private String registerUserName;
	
	private String registerEmail;
	
	private String registerPassword;
	
	private String registerFamilyName;
	
	private String registerGivenName;
	
	private String registerPhoneNumber;
	
	private Boolean isRegisted;
	
	public RegisterUser(){
		
	}

	public RegisterUser(
			String id,
			String registerUserName,
			String registerEmail, String registerPassword,
			String registerFamilyName, String registerGivenName,
			String registerPhoneNumber, Boolean isRegisted) {
		this.id = id;
		this.registerUserName = registerUserName;
		this.registerEmail = registerEmail;
		this.registerPassword = registerPassword;
		this.registerFamilyName = registerFamilyName;
		this.registerGivenName = registerGivenName;
		this.registerPhoneNumber = registerPhoneNumber;
		this.isRegisted = isRegisted;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Timestamp getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Timestamp createdTime) {
		this.createdTime = createdTime;
	}

	public String getRegisterUserName() {
		return registerUserName;
	}

	public void setRegisterUserName(String registerUserName) {
		this.registerUserName = registerUserName;
	}

	public String getRegisterEmail() {
		return registerEmail;
	}

	public void setRegisterEmail(String registerEmail) {
		this.registerEmail = registerEmail;
	}

	public String getRegisterPassword() {
		return registerPassword;
	}

	public void setRegisterPassword(String registerPassword) {
		this.registerPassword = registerPassword;
	}

	public String getRegisterFamilyName() {
		return registerFamilyName;
	}

	public void setRegisterFamilyName(String registerFamilyName) {
		this.registerFamilyName = registerFamilyName;
	}

	public String getRegisterGivenName() {
		return registerGivenName;
	}

	public void setRegisterGivenName(String registerGivenName) {
		this.registerGivenName = registerGivenName;
	}

	public String getRegisterPhoneNumber() {
		return registerPhoneNumber;
	}

	public void setRegisterPhoneNumber(String registerPhoneNumber) {
		this.registerPhoneNumber = registerPhoneNumber;
	}

	public Boolean getIsRegisted() {
		return isRegisted;
	}

	public void setIsRegisted(Boolean isRegisted) {
		this.isRegisted = isRegisted;
	}

}
