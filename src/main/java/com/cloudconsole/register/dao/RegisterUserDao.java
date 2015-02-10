package com.cloudconsole.register.dao;

import java.util.List;

import com.cloudconsole.model.RegisterUser;

public interface RegisterUserDao {
	
	public void insertRegisterUser(RegisterUser registerUser);
	
	public List<RegisterUser> getRegisterUsers();
	
	public RegisterUser getRegisterUserByUserName(String registerUserName);
	
	public Boolean getRegisterUserStateByUserName(String registerUserName);
	
	public void updateRegisterUser(RegisterUser registerUser);
	
	public void deleteRegisterUser(String registerUserName);
	
	public List<RegisterUser> getRegisterUsersByStat(Boolean isRegister);

}
