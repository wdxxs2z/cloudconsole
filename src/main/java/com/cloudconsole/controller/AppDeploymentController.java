package com.cloudconsole.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.CloudFoundryException;
import org.cloudfoundry.client.lib.UploadStatusCallback;
import org.cloudfoundry.client.lib.domain.Staging;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.cloudconsole.common.UploadFileUtil;

@Controller
public class AppDeploymentController {
	
	private Staging staging = null;
	
	@RequestMapping(value="/appUpload",method=RequestMethod.POST)
	public ModelAndView appUpload(
			
			@RequestParam(value="appname",required=false) String appname,
			@RequestParam(value="frame",required=false) String frame,
			@RequestParam(value="memory",required=false) String memory,
			@RequestParam(value="disk",required=false) String disk,
			@RequestParam(value="instanceNum",required=false) String instanceNum,
			@RequestParam(value="serviceInstances",required=false) String[] serviceInstances,
			@RequestParam(value="subdomain",required=false) String subdomain,
			@RequestParam("file") MultipartFile file,
			HttpServletRequest request,
			HttpServletResponse response
			)throws Exception{
		
		boolean success = true;
		String errMsg= "";
		
		try {
			
			CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
			
			appname = request.getParameter("appname");
			frame = request.getParameter("frame");
			memory = request.getParameter("memory");
			instanceNum = request.getParameter("instanceNum");
			subdomain = request.getParameter("subdomain");
			disk = request.getParameter("disk");
			serviceInstances = request.getParameterValues("serviceInstanceSelect");
			List<String> serviceList = null;
			if (serviceInstances != null) {
				serviceList = new ArrayList<String>();
				for (String service : serviceInstances) {
					serviceList.add(service);
				}
			}
			
			staging = new Staging(null, frame);
			
			List<String> uris = new ArrayList<String>();
			
			MultipartHttpServletRequest r = (MultipartHttpServletRequest) request;
			file = r.getFile("file");
			String realPath = UploadFileUtil.getRealPath(file,request);

			if (StringUtils.isNotBlank(appname) && client != null){
				uris.add(appname + "." +subdomain);
				try {
					if (serviceList != null) {
						client.createApplication(appname, staging, Integer.parseInt(disk), Integer.parseInt(memory), uris, serviceList);
					} else {
						client.createApplication(appname, staging, Integer.parseInt(disk), Integer.parseInt(memory), uris, null);
					}					
					client.getApplication(appname).setInstances(Integer.parseInt(instanceNum));
					client.uploadApplication(appname, new File(realPath), new UploadStatusCallback() {
						
						@Override
						public boolean onProgress(String status) {
							System.out.println("进度为：--" + status);
							return true;
						}
						
						@Override
						public void onProcessMatchedResources(int length) {
							System.out.println("文件匹配长度为：" + length);
							
						}
						
						@Override
						public void onMatchedFileNames(Set<String> matchedFileNames) {
							matchedFileNames.size();			
						}
						
						@Override
						public void onCheckResources() {
							
						}
					});
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
						
		} catch (Exception e) {
			success = false;
			errMsg = e.getMessage();
			if (e instanceof CloudFoundryException) {
				errMsg = errMsg+":"+((CloudFoundryException)e).getDescription();
			}
		}
				
		response.getWriter().write("{success: "+success+", msg: \""+errMsg+"\"}");
		return new ModelAndView(new RedirectView("appView"));
	}
	
	@RequestMapping(value="/uploadApp")
	public ModelAndView appdeployment(){
		return new ModelAndView("uploadApp");
	}
	
	@RequestMapping(value="appDownload")
	public ModelAndView appDownload(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String appName = request.getParameter("name");
		CloudFoundryClient client = (CloudFoundryClient) request.getSession().getAttribute("client");
		if (client != null && StringUtils.isNotBlank(appName)) {
			String fileName = appName + ".zip";
			fileName = URLEncoder.encode(fileName, "UTF-8");
			byte[] data = client.downloadAppWithAppName(appName);
			response.reset();  
		    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");  
		    response.addHeader("Content-Length", "" + data.length);  
		    response.setContentType("application/octet-stream;charset=UTF-8;text/html");
		    OutputStream outputStream = new BufferedOutputStream(response.getOutputStream());  
		    outputStream.write(data);  
		    outputStream.flush();  
		    outputStream.close();
		}		
		return null;
	}

}
