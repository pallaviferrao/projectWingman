<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <title>voters list</title>
</head>
<body>
  
  <h3>choose candidate</h3>
  <form method="get">
    <input type="checkbox" name="votername" value="padhavi">communist
    <input type="checkbox" name="votername" value="pallavi">BJP
    <input type="checkbox" name="votername" value="rashi">republican
    <input type="checkbox" name="votername" value="palak">democratic
    <input type="checkbox" name="votername" value="tazeen">congress
    <input type="submit" value="voters details ">
  </form>
 
  <%
    String[] votername = request.getParameterValues("votername");
    if (votername != null) {
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
 
      String sqlStr = "SELECT * FROM voterdetails WHERE votername IN (";
      sqlStr += "'" + votername[0] + "'";  // First author
      for (int i = 1; i < votername.length; ++i) {
         sqlStr += ", '" + votername[i] + "'";  // Subsequent authors need a leading commas
      }
      sqlStr += ") AND votes > 0 ORDER BY votername ASC, party ASC";
 
      // for debugging
      System.out.println("Query statement is " + sqlStr);
      ResultSet rset = stmt.executeQuery(sqlStr);
  %>
      <hr>
      <form method="get" action="order.jsp">
        <table border=1 cellpadding=5>
          <tr>
            <th>choose</th>
            <th>voterid</th>
            <th>votername</th>
            <th>party</th>
          </tr>
  <%
      while (rset.next()) {
        int voterid = rset.getInt("voterid");
  %>
          <tr>
            <td><input type="checkbox" name="voterid" value="<%= voterid %>"></td>
            <td><%= rset.getString("voterid") %></td>
            <td><%= rset.getString("votername") %></td>
            <td><%= rset.getString("party") %></td>
            <td><%= rset.getInt("votes") %></td>
          </tr>
  <%
      }
  %>
        </table>
        <br>
        <input type="submit" value="vote">
       
      </form>
      <a href="<%= request.getRequestURI() %>"><h3>Back</h3></a>
  <%
      rset.close();
      stmt.close();
      conn.close();
    }
  %>
</body>
</html>

