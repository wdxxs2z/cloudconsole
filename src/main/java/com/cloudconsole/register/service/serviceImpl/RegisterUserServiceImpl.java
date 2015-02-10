package com.cloudconsole.register.service.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cloudconsole.model.RegisterUser;
import com.cloudconsole.register.dao.RegisterUserDao;
import com.cloudconsole.register.service.RegisterUserService;

@Service
public class RegisterUserServiceImpl implements RegisterUserService {
	
	@Autowired
	private RegisterUserDao registerUserDao;

	@Override
	public void insertRegisterUser(RegisterUser registerUser) {
		registerUserDao.insertRegisterUser(registerUser);
	}

	@Override
	public List<RegisterUser> getRegisterUsers() {		
		return registerUserDao.getRegisterUsers();
	}

	@Override
	public RegisterUser getRegisterUserByUserName(String registerUserName) {
		return registerUserDao.getRegisterUserByUserName(registerUserName);
	}

	@Override
	public Boolean getRegisterUserStateByUserName(String registerUserName) {
		return registerUserDao.getRegisterUserStateByUserName(registerUserName);
	}

	@Override
	public void updateRegisterUser(RegisterUser registerUser) {
		registerUserDao.updateRegisterUser(registerUser);

	}

	@Override
	public void deleteRegisterUser(String registerUserName) {
		registerUserDao.deleteRegisterUser(registerUserName);
	}

	@Override
	public List<RegisterUser> getRegisterUsersByStat(Boolean isRegister) {
		
		return registerUserDao.getRegisterUsersByStat(isRegister);
	}

}
