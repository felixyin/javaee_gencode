package com.jeeplus;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;

public class OutputReplaceFilter implements Filter {

    @Override
    public void destroy() {
        // TODO Auto-generated method stub
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        // TODO Auto-generated method stub
        //自定义的 Response
        HttpCharacterResponseWrapper ref_charResponse = new HttpCharacterResponseWrapper(
                (HttpServletResponse) response);
        chain.doFilter(request, ref_charResponse);

        String output = ref_charResponse.getCharArrayWriter().toString();
        output = output.replaceAll("com\\.jeeplus\\.modules", "com\\.qtrj\\.modules");
        output = output.replaceAll("刘高峰", "尹彬");
        output = output.replace("代码生成会覆盖路径中已经存在的同名文件，请做好备份或选择空白目录生成代码。", "代码生成到ftp服务器(ip:qtrj.i234.me)，请联系管理员（17554153785，尹）索要账号和密码后，登陆ftp下载");
        output = output.replace("<div class=\"col-sm-2\"><a class=\"btn btn-default\" href=\"#\" onclick=\"selectFolder()\">选择生成目录</a></div>", "无需改动路径");
//        output = output.replace("name=\"projectPath\"", "name=\"projectPath\" readonly=\"true\" value=\"/volume1/gencode\"");
        output = output.replace("name=\"projectPath\"", "name=\"projectPath\"  value=\"/volume1/gencode\"");


//        这部分不是特别明白，response是入口参数传递过来的
        PrintWriter out = response.getWriter();
        out.write(output);
        out.flush();
        out.close();
//        chain.doFilter(request,response);
    }

}

