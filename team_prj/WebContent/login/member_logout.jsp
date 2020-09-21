<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	session.removeAttribute("user_email");
	session.removeAttribute("user_position");
	session.removeAttribute("user_name");
	session.invalidate();
%>
<script type="text/javascript">
window.location.replace("member_login.jsp")
</script>

