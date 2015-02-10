package com.cloudconsole.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.cloudfoundry.client.lib.CloudFoundryClient;

public class FileUtil {
	
	public static Map<String,List<String>> getFiles(CloudFoundryClient client, String appName,int instance, String file) {
		Map<String, List<String>> dirs = getDir(client, appName, instance, file);
		Set<Map.Entry<String,List<String>>> entrySet = dirs.entrySet();
		Map<String,List<String>> maps = new HashMap<String, List<String>>();
		for (Iterator<Map.Entry<String, List<String>>> it =entrySet.iterator();it.hasNext();) {
			Map.Entry<String, List<String>> next = (Map.Entry<String, List<String>>)it.next();
			List<String> files = next.getValue();
			List<String> subFiles = new ArrayList<String>();
			if (files != null) {
				for (String f : files) {
					if (f.contains("/")) {
						getFiles(client, appName, instance, file + f);
					} else {
						subFiles.add(f);
					}
				}
				maps.put(file, subFiles);
			}			
		}
		return maps;
	}
	
	public static Map<String,List<String>> getDir (CloudFoundryClient client, String appName, int instance, String dir) { 
		Map<String,List<String>> files = new HashMap<String, List<String>>();
		List<String> file = new ArrayList<String>();
		String stringLine = client.getFile(appName, instance, dir);
		if (stringLine != null) {
			String[] lines = stringLine.split("\\n");
			for (String line : lines) {
				String[] firstString = line.split(" ");
				String string = firstString[0];
				if (string.startsWith(".")) {			
				} else {
					file.add(string);
				}
			}
			files.put(dir, file);
		} else {
			files.put(dir, null);
		}		
		return files;
	}

}
