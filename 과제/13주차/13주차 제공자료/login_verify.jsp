<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
	String userID = request.getParameter("userID");
	String userPassword = request.getParameter("userPassword");

	Connection myConn = null;
	Statement stmt = null;
	String mySQL = null;

	String dburl = "jdbc:oracle:thin:@210.94.199.20:1521:dblab";
	String user = "ST2017112138"; // 본인 아이디(ex.STxxxxxxxxxx)
	String passwd = "rntka332"; // 본인 패스워드(ex.STxxxxxxxxxx)
	String dbdriver = "oracle.jdbc.OracleDriver";

	Class.forName(dbdriver);
	myConn = DriverManager.getConnection(dburl, user, passwd);
	stmt = myConn.createStatement();

	mySQL = "select s_id from student where s_id='" + userID + "' and s_pwd='" + userPassword + "'";

	ResultSet myResultSet = stmt.executeQuery(mySQL);

	if (myResultSet.next()) {
		String s_name = myResultSet.getString("s_name");
		session.setAttribute("user_name",s_name);
		session.setAttribute("user", userID);
		response.sendRedirect("main.jsp");
	} else {
%>

<script>
	alert("사용자아이디 혹은 암호가 틀렸습니다.");
	location.href = "login.jsp";
</script>
<%
	}
	stmt.close();
	myConn.close();
%>
