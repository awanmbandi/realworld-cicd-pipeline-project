<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
 <div align="center">
  <h1>Congratulations!!</h1>
  <h1>Welcome To Our DevOps Login Portal</h1>
  <p>Please fill out the form below to create an account with us.</p>
  <form action="<%= request.getContextPath() %>/register" method="post">
   <table style="with: 80%">
    <hr>
    <tr>
      <td>Batch Name</td>
      <td><input type="text" name="BatchName" /></td>
      <br>
     </tr>
    <tr>
     <td>First Name</td>
     <td><input type="text" name="firstName" /></td>
    </tr>
    <tr>
     <td>Last Name</td>
     <td><input type="text" name="lastName" /></td>
    </tr>
    <tr>
     <td>UserName</td>
     <td><input type="text" name="username" /></td>
    </tr>
    <tr>
     <td>Password</td>
     <td><input type="password" name="password" /></td>
    </tr>
    <tr>
     <td>Address</td>
     <td><input type="text" name="address" /></td>
    </tr>
    <tr>
     <td>City</td>
     <td><input type="text" name="City" /></td>
    </tr>
    <tr>
     <td>State/Province</td>
     <td><input type="text" name="State" /></td>
    </tr>
    <tr>
     <td>Contact No</td>
     <td><input type="text" name="contact" /></td>
    </tr>
    <tr>
     <td>Home Phone</td>
     <td><input type="text" name="HomePhone" /></td>
    </tr>
    <tr>
     <td>Birth Month</td>
     <td><input type="text" name="BirthMonth" /></td>
    </tr>
    <hr>
   </table>
   <input type="submit" value="Submit" />

   <p>By creating an account you agree to our <a href="#">Terms & Privacy</a>.</p>
    <button type="submit" class="registerbtn">Register</button>
    <div>
      <div class="container signin">
      <p>Already have an account? <a href="#">Sign in</a>.</p>
    </div>

  </form>
 </div>
</body>
</html>