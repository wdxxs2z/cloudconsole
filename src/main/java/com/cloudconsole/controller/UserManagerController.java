package com.cloudconsole.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.CloudFoundryException;
import org.cloudfoundry.client.lib.domain.CloudOrganization;
import org.cloudfoundry.client.lib.domain.CloudSpace;
import org.cloudfoundry.client.lib.domain.CloudUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UserManagerController {

	@RequestMapping(value = "/usermanager")
	public ModelAndView userManager(HttpServletRequest request,
			HttpServletResponse response) {
		
		
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		if(client != null){
			List<CloudUser> allUsers = client.getAllUsers();
			List<CloudUser> activeUsers = new ArrayList<CloudUser>();
			List<CloudUser> notActiveUsers = new ArrayList<CloudUser>();
			for(CloudUser user : allUsers){
				if(user.getOrganizations().size()!=0){
					activeUsers.add(user);
				}else{
					notActiveUsers.add(user);
				}
			}
			request.getSession().setAttribute("allUsers", allUsers);
			request.getSession().setAttribute("registerUsers", activeUsers);
			request.getSession().setAttribute("notRegister", notActiveUsers);
		}

		ModelAndView userModel = new ModelAndView("usermanager");
		return userModel;
	}

	@RequestMapping(value = "/adduserrole", method = RequestMethod.POST)
	public ModelAndView addUserRole(
			@RequestParam(value = "multiUser", required = false) String[] multiUser,
			@RequestParam(value = "orgValue", required = false) String orgValue,
			@RequestParam(value = "teamSelect", required = false) String teamSelect,
			HttpServletRequest request, HttpServletResponse response) {

		String[] usersGuid = request.getParameterValues("multiUser");
		orgValue = request.getParameter("orgValue");
		String spaceGuid = request.getParameter("teamSelect");

		CloudFoundryClient client = (CloudFoundryClient) request.getSession()
				.getAttribute("client");

		for (String userGuid : usersGuid) {
			CloudOrganization organization = client.getOrgByName(orgValue, true);
			client.associateOrgWithUser(userGuid, organization.getMeta().getGuid().toString());
			client.associataSpaceWithUser(userGuid, spaceGuid);
			client.updateGroupMemberByUserGuid(userGuid, "scim.read", "members", false);
		}

		return new ModelAndView("usermanager");
	}

	@RequestMapping(value = "/edituser", method = RequestMethod.GET)
	public ModelAndView userEdit(HttpServletRequest request,
			HttpServletResponse response) {

		String username = request.getParameter("username");

		CloudFoundryClient client = (CloudFoundryClient) request.getSession()
				.getAttribute("client");

		if (StringUtils.isNotBlank(username) && client != null) {
			CloudUser clientUser = client.getUsersummaryFromUserName(username);
			request.getSession().setAttribute("clientUser", clientUser);

			List<CloudOrganization> userorgs = clientUser.getOrganizations();
			List<CloudSpace> userspaces = clientUser.getSpaces();
			List<String> teaminfo = new ArrayList<String>();
			
			for(CloudOrganization userorg : userorgs){				
				for(CloudSpace userspace : userspaces){
					String uspaceuuid = userspace.getMeta().getGuid().toString();
					List<CloudSpace> spaces = userorg.getCloudSpaces();
					for(CloudSpace space : spaces){
						String spaceuuid = space.getMeta().getGuid().toString();
						if(spaceuuid.equalsIgnoreCase(uspaceuuid)){
							String split = userorg.getName() + "--" + userspace.getName();
							teaminfo.add(split);
						}
					}
				}
			}
			request.getSession().setAttribute("teaminfo", teaminfo);
		}
		return new ModelAndView("edituser");
	}
	
	@RequestMapping(value="/editUserPost",method=RequestMethod.POST)
	public ModelAndView editUserPost(
			@RequestParam(value="edituser",required = false) String edituser,
			@RequestParam(value="orgspace",required = false) String[] orgspace,
			HttpServletRequest request, HttpServletResponse response){
		
		edituser = request.getParameter("edituser");
		orgspace = request.getParameterValues("orgspace");
		
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		
		if(StringUtils.isNotBlank(edituser) && orgspace!=null && client!=null){
			
			CloudUser cloudUser = client.getUsersummaryFromUserName(edituser);
			List<CloudOrganization> userOrgs = cloudUser.getOrganizations();
			List<CloudSpace> userSpaces = cloudUser.getSpaces();
		
			//移除
			for(CloudOrganization userOrg : userOrgs){
				for(CloudSpace userSpace : userSpaces){
					String uspaceuuid = userSpace.getMeta().getGuid().toString();
					List<CloudSpace> spaces = userOrg.getCloudSpaces();
					for(CloudSpace space : spaces){
						String spaceuuid = space.getMeta().getGuid().toString();
						if(spaceuuid.equalsIgnoreCase(uspaceuuid)){
							Boolean exitFlag = false;
							String split = userOrg.getName() + "--" + userSpace.getName();
							for(String s : orgspace){
								if(s.equalsIgnoreCase(split)){
									exitFlag = true;
								}
							}
							if(exitFlag==false){
								client.removeSpaceFromUser(cloudUser, userSpace);
								client.removeOrgFromUser(cloudUser, userOrg);
							}
						}
					}
				}
			}
			
			//新增
			for(String newsplit : orgspace){
				Boolean exitFlag = false;
				for(CloudOrganization userorg : userOrgs){				
					for(CloudSpace userspace : userSpaces){
						String uspaceuuid = userspace.getMeta().getGuid().toString();
						List<CloudSpace> spaces = userorg.getCloudSpaces();
						for(CloudSpace space : spaces){
							String spaceuuid = space.getMeta().getGuid().toString();
							if(spaceuuid.equalsIgnoreCase(uspaceuuid)){
								String split = userorg.getName() + "--" + userspace.getName();
								if(newsplit.endsWith(split)){
									exitFlag=true;
								}
							}
						}
					}
				}
				if(exitFlag==false){
					String[] newOrgSpace = newsplit.split("--");
					client.associateOrgWithUser(cloudUser, client.getOrgByName(newOrgSpace[0], true));
					List<CloudSpace> spaces = client.getSpaceFromOrgName(newOrgSpace[0]);
					for (CloudSpace space : spaces) {
						if (space.getName().equals(newOrgSpace[1])) {
							client.associataSpaceWithUser(cloudUser, space);
						}
					}
				}
			}		
		}
		//移除所有,参数为空
		if(StringUtils.isNotBlank(edituser) && orgspace==null && client!=null){
			CloudUser cloudUser = client.getUsersummaryFromUserName(edituser);
			List<CloudOrganization> userOrgs = cloudUser.getOrganizations();
			List<CloudSpace> userSpaces = cloudUser.getSpaces();
			for(CloudOrganization userorg : userOrgs){				
				for(CloudSpace userspace : userSpaces){
					String uspaceuuid = userspace.getMeta().getGuid().toString();
					List<CloudSpace> spaces = userorg.getCloudSpaces();
					for(CloudSpace space : spaces){
						String spaceuuid = space.getMeta().getGuid().toString();
						if(spaceuuid.equalsIgnoreCase(uspaceuuid)){
							client.removeSpaceFromUser(cloudUser, userspace);
						}
					}
				}
				client.removeOrgFromUser(cloudUser, userorg);
			}
		}
		
		return new ModelAndView("usermanager");
	}
	
	@RequestMapping(value="/editUserPrivilege",method = RequestMethod.GET)
	public ModelAndView editOrgUser(HttpServletRequest request, HttpServletResponse response){
		
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		if(client!=null){
			
			List<CloudUser> allUsers = client.getAllUsers();
			request.getSession().setAttribute("allUsers", allUsers);
			
		}
		
		return new ModelAndView("editUserPrivilege");
	}
	
	@RequestMapping(value="/editAllUserPrivilegePost",method=RequestMethod.POST)
	public ModelAndView editOrgUserPost(
			@RequestParam(value="allUserMember",required=true) String[] allUserMember,
			@RequestParam(value="allUserReader",required=true) String[] allUserReader,
			@RequestParam(value="allUserWriter",required=true) String[] allUserWriter,
			HttpServletRequest request, HttpServletResponse response){
		
		
		allUserMember = request.getParameterValues("allUserMember");
		allUserReader = request.getParameterValues("allUserReader");
		allUserWriter = request.getParameterValues("allUserWriter");
		
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		List<CloudUser> allUsers = client.getAllUsers();
		List<String> memberUsers = new ArrayList<String>();
		List<String> readerUsers = new ArrayList<String>();
		List<String> writerUsers = new ArrayList<String>();
		for(CloudUser user : allUsers){
			if(client.isMemberByUserAndDisplayName(user.getMeta().getGuid().toString(), "cloud_controller.admin")){
				memberUsers.add(user.getName());
			}
			if(client.isReaderByUserAndDisplayName(user.getMeta().getGuid().toString(), "cloud_controller.admin")){
				readerUsers.add(user.getName());
			}
			if(client.isWriterByUserAndDisplayName(user.getMeta().getGuid().toString(), "cloud_controller.admin")){
				writerUsers.add(user.getName());
			}
		}
		
		//成员类
		updateOrgUserAuthority(client, memberUsers, allUsers, allUserMember, "members", "cloud_controller.admin");						
		
		//可读类
		updateOrgUserAuthority(client, readerUsers, allUsers, allUserReader, "readers", "cloud_controller.admin");
		
		//可写类
		updateOrgUserAuthority(client, writerUsers, allUsers, allUserWriter, "writers", "cloud_controller.admin");
		
		return new ModelAndView("organization");
	}

	private void updateOrgUserAuthority(CloudFoundryClient client, List<String> requiredUsers, List<CloudUser> orgUsers, 
			String[] membertypeUsers, String member_type, String displayName) {
		
		if(client!=null && membertypeUsers!=null){
			//移除
			for(String requiredUser : requiredUsers){
				Boolean isExist = false;
				for(String orgMember : membertypeUsers){
					if(orgMember.equals(requiredUser)){
						isExist = true;
					}
				}
				if(isExist==false){
					client.updateGroupMember(requiredUser, displayName, member_type, true);
				}
			}
			//新增
			for(String orgMember : membertypeUsers){
				Boolean isExist = false;
				for(String requiredUser : requiredUsers){
					if(requiredUser.endsWith(orgMember)){
						isExist=true;
					}
				}
				if(isExist==false){
					client.updateGroupMember(orgMember, displayName, member_type, false);
				}
			}
			
		}
		if(client!=null && membertypeUsers==null){
			for(String memberUser : requiredUsers){
				client.updateGroupMember(memberUser, displayName, member_type, true);
			}
		}
		
	}
	
	@RequestMapping(value="/userOperation")
	public ModelAndView userOperation(HttpServletRequest request, HttpServletResponse response) throws IOException{
		boolean success = true;
		String errMsg= "";
		
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		String username = request.getParameter("username");
		if (client != null && StringUtils.isNotBlank(username)) {
			try {
				String type = request.getParameter("type");
				if (StringUtils.isNotBlank(type)) {
					if ("delete".equalsIgnoreCase(type)) {
						client.deleteUserWithUserName(username);
					}
				}
			} catch (Exception e) {
				success = false;
				errMsg = e.getMessage();
				if (e instanceof CloudFoundryException) {
					errMsg = errMsg+":"+((CloudFoundryException)e).getDescription();
				}
			}			
		}
		response.getWriter().write("{success: "+success+", msg: \""+errMsg+"\"}");
		return null;
	}

}
