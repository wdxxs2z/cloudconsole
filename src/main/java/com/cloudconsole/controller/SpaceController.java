package com.cloudconsole.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.domain.CloudSpace;
import org.cloudfoundry.client.lib.domain.CloudUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
public class SpaceController {
	
	@RequestMapping(value = "/spaceView", method = RequestMethod.GET)
	public ModelAndView space(HttpServletRequest request, HttpServletResponse response){
		ModelAndView view = new ModelAndView("organization");
		
		String spaceGuid = request.getParameter("spaceGuid");
		String orgName = request.getParameter("orgName");
		
		if(StringUtils.isNotBlank(spaceGuid) && StringUtils.isNotBlank(orgName)){
			CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
			List<CloudSpace> spaces = client.getSpaceFromOrgName(orgName);
			for (CloudSpace space : spaces) {
				if(space.getMeta().getGuid().toString().equals(spaceGuid)){
					if(space != null){
						
						List<CloudUser> managers = client.getUsersBySpaceRole(spaceGuid, "managers");
						List<CloudUser> developers = client.getUsersBySpaceRole(spaceGuid, "developers");
						List<CloudUser> auditors = client.getUsersBySpaceRole(spaceGuid, "auditors");
						Map<String,String> spaceUsers = new HashMap<String,String>();
						
						for(CloudUser manager : managers){
							String managerId = manager.getMeta().getGuid().toString();
							String managerName = manager.getName();
							spaceUsers.put(managerId, managerName);
						}
						for(CloudUser developer : developers){
							String developerId = developer.getMeta().getGuid().toString();
							String developerName = developer.getName();
							spaceUsers.put(developerId, developerName);
						}
						for(CloudUser auditor : auditors){
							String auditorId = auditor.getMeta().getGuid().toString();
							String auditorName = auditor.getName();
							spaceUsers.put(auditorId, auditorName);
						}
						
						request.getSession().setAttribute("spaceUsers", spaceUsers);						
						request.getSession().setAttribute("space", space);
						view.setViewName("spaceView");
					}
				}
			}
			
		}		
		return view;
	}
	

	@RequestMapping(value="/spaceuser")
	public ModelAndView spaceUser(HttpServletRequest request, HttpServletResponse response){		
		return new ModelAndView("spaceuser");
	}
	
	@RequestMapping(value="/editSpaceUser",method=RequestMethod.POST)
	public ModelAndView editSpaceUser(
			@RequestParam(value="managerSpace",required = false) String[] managerSpace,
			@RequestParam(value="developerSpace",required = false) String[] developerSpace,
			@RequestParam(value="testSpace",required = false) String[] testSpace,
			HttpServletRequest request, HttpServletResponse response){
		
		managerSpace = request.getParameterValues("managerSpace");
		developerSpace = request.getParameterValues("developerSpace");
		testSpace = request.getParameterValues("testSpace");
		
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		CloudSpace space = (CloudSpace) request.getSession().getAttribute("space");
		
		//Space 管理者调度
		if(client!=null && managerSpace!=null && space!=null){
			
			List<CloudUser> managers = client.getUsersBySpaceRole(space.getMeta().getGuid().toString(), "managers");
			//移除
			for(CloudUser manager : managers){
				String managerName = manager.getName();
				Boolean isExist = false;
				for(String selectManager : managerSpace){
					if(selectManager.equals(managerName)){
						isExist = true;
					}
				}
				if(isExist==false){
					client.removeUserFromRoleSpace(space, client.findUserByUsername(managerName), "managers");
				}
			}
			//新增
			for(String selectManager : managerSpace){
				Boolean isExist = false;
				for(CloudUser manager : managers){
					String managerName = manager.getName();					
					if(selectManager.equals(managerName)){
						isExist = true;
					}
				}
				if(isExist==false){
					client.associateUserWithSpaceRole(space, client.findUserByUsername(selectManager), "managers");
				}
			}
		}
		if(client!=null && managerSpace == null && space!=null){
			List<CloudUser> managers = client.getUsersBySpaceRole(space.getMeta().getGuid().toString(), "managers");
			for(CloudUser oldManager : managers){
				client.removeUserFromRoleSpace(space, oldManager, "managers");
			}
		}
		
		//Space 开发者调度
		if(client!=null && developerSpace!=null && space!=null){
			List<CloudUser> developers = client.getUsersBySpaceRole(space.getMeta().getGuid().toString(), "developers");
			//移除
			for(CloudUser developer : developers){
				String developerName = developer.getName();
				Boolean isExist = false;
				for(String selectDeveloper : developerSpace){
					if(selectDeveloper.equals(developerName)){
						isExist = true;
					}
				}
				if(isExist==false){
					client.removeUserFromRoleSpace(space, client.findUserByUsername(developerName), "developers");
				}
			}
			//新增
			for(String selectDeveloper : developerSpace){
				Boolean isExist = false;
				for(CloudUser developer : developers){
					String developerName = developer.getName();					
					if(selectDeveloper.equals(developerName)){
						isExist = true;
					}
				}
				if(isExist==false){
					client.associateUserWithSpaceRole(space, client.findUserByUsername(selectDeveloper), "developers");
				}
			}
		}
		if(client!=null && developerSpace==null && space!=null){
			List<CloudUser> developers = client.getUsersBySpaceRole(space.getMeta().getGuid().toString(), "developers");
			for(CloudUser oldDeveloper : developers){
				client.removeUserFromRoleSpace(space, oldDeveloper, "developers");
			}
		}
		
		//Space 测试者调度
		if(client!=null && testSpace!=null && space!=null){
			List<CloudUser> testers = client.getUsersBySpaceRole(space.getMeta().getGuid().toString(), "auditors");
			//移除
			for(CloudUser tester : testers){
				String testerName = tester.getName();
				Boolean isExist = false;
				for(String selectTester : testSpace){
					if(selectTester.equals(testerName)){
						isExist = true;
					}
				}
				if(isExist==false){
					client.removeUserFromRoleSpace(space, client.findUserByUsername(testerName), "auditors");
				}
			}
			//新增
			for(String selectTester : testSpace){
				Boolean isExist = false;
				for(CloudUser tester : testers){
					String testerName = tester.getName();					
					if(selectTester.equals(testerName)){
						isExist = true;
					}
				}
				if(isExist==false){
					client.associateUserWithSpaceRole(space, client.findUserByUsername(selectTester), "auditors");
				}
			}
		}
		if(client!=null && testSpace==null && space!=null){
			List<CloudUser> testers = client.getUsersBySpaceRole(space.getMeta().getGuid().toString(), "auditors");
			for(CloudUser oldTester : testers){
				client.removeUserFromRoleSpace(space, oldTester, "auditors");
			}
		}
		
		return new ModelAndView("spaceView");
	}
	
	@RequestMapping(value="doAddSpace",method=RequestMethod.POST)
	public ModelAndView doAddSpace(HttpServletRequest request, HttpServletResponse response) {
		String spaceName = request.getParameter("spaceName");
		String organization = request.getParameter("organization");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		if (client != null && StringUtils.isNotBlank(organization) && StringUtils.isNotBlank(spaceName)) {
			client.createSpace(spaceName, organization);			
		}
		String urlPath = "orgManager?orgName=" + organization;
		return new ModelAndView(new RedirectView(urlPath));
	}
	
	@RequestMapping(value="spaceServiceInstance")
	public ModelAndView spaceServiceInstance (HttpServletRequest request, HttpServletResponse response) {
		
		
		return new ModelAndView("spaceServiceInstance");
	}
}
