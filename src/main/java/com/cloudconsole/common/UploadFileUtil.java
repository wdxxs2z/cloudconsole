package com.cloudconsole.common;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public class UploadFileUtil {

	public static String getRealPath(MultipartFile file, HttpServletRequest request) {
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy/MM/dd/HH");
		/** 构建文件保存的目录* */
		String cloudPathDir = "/cloudfoundry/tempdir/upload/"
				+ dateformat.format(new Date());
		/** 得到文件保存目录的真实路径* */
		String cloudRealPathDir = request.getSession().getServletContext()
				.getRealPath(cloudPathDir);
		/** 根据真实路径创建目录* */
		File logoSaveFile = new File(cloudRealPathDir);
		if (!logoSaveFile.exists())
			logoSaveFile.mkdirs();
		/** 页面控件的文件流* */

		/** 获取文件的后缀* */
		String suffix = file.getOriginalFilename().substring(
				file.getOriginalFilename().lastIndexOf("."));
		/** 使用UUID生成文件名称* */
		String cloudImageName = UUID.randomUUID() + suffix;// 构建文件名称
		/** 拼成完整的文件保存路径加文件* */
		String fileName = cloudRealPathDir + File.separator + cloudImageName;
		File f = new File(fileName);
		try {
			file.transferTo(f);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return fileName;
	}

}
