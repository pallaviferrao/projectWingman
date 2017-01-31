<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <title>choose party</title>
</head>
 
<body>
  
   <h2>Thank you for voting...</h2>
 
  <%
    String[] ids = request.getParameterValues("voterid");
    if (ids != null) {
  %>
  <%@ page import = "java.sql.*" %>
  <%
  String JDBC_DRIVER="com.mysql.jdbc.Driver";
  
  Connection conn = null;
     String URL ="jdbc:mysql://localhost:3306/voterlist";
     String USER="pallu";
    		 String PASS="pallu"; // <== Check!
    				 try{
    					 Class.forName(JDBC_DRIVER).newInstance();
    					 conn=DriverManager.getConnection(URL,USER,PASS);
    				 }catch
    				 (SQLException e){
    					 e.printStackTrace();
    				 }
      // Connection conn =
      //    DriverManager.getConnection("jdbc:odbc:eshopODBC");  // Access
      Statement stmt = conn.createStatement();
      String sqlStr;
      int recordUpdated;
      ResultSet rset;
  %>
      <table border=1 cellpadding=3 cellspacing=0>
        <tr>
          <th>voterid</th>
          <th>votername</th>
          <th>party</th>
          <th>votes</th>
        </tr>
  <%
      for (int i = 0; i < ids.length; ++i) {
        
        sqlStr = "UPDATE voterdetails SET votes = votes + 1 WHERE voterid = " + ids[i];
        recordUpdated = stmt.executeUpdate(sqlStr);
        // carry out a query to confirm
        sqlStr = "SELECT * FROM voterdetails WHERE voterid =" + ids[i];
        rset = stmt.executeQuery(sqlStr);
        while (rset.next()) {
  %>
          <tr>
            <td><%= rset.getString("voterid") %></td>
            <td><%= rset.getString("votername") %></td>
            <td><%= rset.getString("party") %></td>
            <td><%= rset.getInt("votes") %></td>
          </tr>
  <%    }
        rset.close();
      }
      stmt.close();
      conn.close();
    }
  %>
  </table>
  <a href="query.jsp"><h3>BACK</h3></a>
</body>
</html>