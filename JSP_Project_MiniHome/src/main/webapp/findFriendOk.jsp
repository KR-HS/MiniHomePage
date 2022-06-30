<%@page import="kr.human.member.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.human.member.service.MemberServiceImpl"%>
<%@page import="kr.human.member.service.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
a{
text-decoration:none;
}
a:link{
color:black;
}
a:visited{
color:black;
}
a:active{
color:gray;
}
.gomini
</style>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		if(request.getMethod().equals("GET")){
			response.sendRedirect(request.getContextPath());
			return;
		}
		String name = request.getParameter("name");
		
		if(name!=null){
			List<MemberVO> list = MemberServiceImpl.getInstance().selectList(name,session);
			if(list.size()<=0){
				request.setAttribute("error", "해당 회원이 존재하지 않습니다.");
				pageContext.forward("findFriend.jsp");
			}else{
	%>
			<section >
				<h2 align="center">검색결과</h2>
			
	<%
	/* 
	window.open(\'miniHome/miniHomeConnecter.jsp\', \'popup01\',\'width=950, height=600, left=400, top=150,scrollbars= 0, toolbar=0, menubar=yes\')
	*/
				int i=0;
				out.println("<form action='miniHome/miniHome.jsp'>");
				for(MemberVO vo : list){
					out.println("<h3 align=\"center\">"+
					"<input type=\"radio\" id=\"userid"+i+"\" name=\"userid\" value=\'"+
					vo.getUserid()+"\'/>"+"<label for=\"userid"+i+"\">"+vo.getName()+"("+ vo.getUserid()+")"+"</label></h3>");
					i++;
				}
				out.println("<h3 align='center'><input type='submit' value='자세히 보기' style='background-color: black; color: white;width: 240px;"+
				"height: 54px;margin-top: 20px;border: 1px solid darkgrey;border-radius: 5px;'></h3>");
				out.println("</form>");
			}
		}else{
			request.setAttribute("error", "잘못된 정보입니다.");
			pageContext.forward("findFriend.jsp");
			return;
		}
	%>
			</section>
</body>
</html>