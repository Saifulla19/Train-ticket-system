<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.digitalbd.Helper" %>
<%@ page import="com.digitalbd.User" %>
<%@ include file="header.jsp" %>
 
<%
    // Check if the user is already logged in
    if (session.getAttribute("isUserLogin") != null && (Boolean) session.getAttribute("isUserLogin")) {
        response.sendRedirect("Dashboard.jsp");
    }

    // Initialize necessary variables
    User user = new User();
    String message = "";
    String userName = null, passWord = null;
    long userId = 0;

    // Handle login form submission
    if (request.getParameter("submit") != null) {
        userName = request.getParameter("phone");
        passWord = request.getParameter("password");

        // Validate user input
        if (userName == null || userName.trim().isEmpty() || passWord == null || passWord.trim().isEmpty()) {
            message = "User name and password required!";
        } else {
            // Optionally, add more validation for phone number format
            if (userName.length() < 10) {
                message = "Please enter a valid phone number!";
            } else {
                // Attempt login
                userId = user.doLogin(userName, passWord);
                if (userId > 0) {
                    // Successful login: set session attributes and redirect to the dashboard
                    session.setAttribute("isUserLogin", true);
                    user.SetUserFromId(Long.toString(userId));
                    user.SetUserSession(session);
                    response.sendRedirect("Dashboard.jsp");
                } else {
                    // Login failed: display error message and invalidate session
                    message = "User ID or password not found!";
                    session.invalidate();
                }
            }
        }
    }
%>

<!-- Login form HTML structure -->
<div class="signpage" ; style="margin: 120px 0px 0px  0px; width:100%"; >
    <form name="loginForm" class="register_form form_login" action="Login.jsp" method="post" onsubmit="return validateLoginForm()">
        <div class="row">
        
        
        
        <div>
         <h1 style="color:#e0bc00;padding-right: 100px;padding-left:270px; padding-down:100; font-family: ui-monospace; font-size: 60px;margin:50px -30px">WELCOME TO</h1>
       <h2 style="color:#e0bc00;padding-right: 295px;padding-left:270px; font-family: ui-monospace;font-size: 50px; margin:-60px -15px ;"> Rolling on rails</h2>
  </div>
        
       
           
           
            <div class="col-xs-12 col-sm-4" >
                <% if (!message.isEmpty()) { %>
                    <div class="alert alert-danger"><p><%= message %></p></div>
                <% } %>
                
                <div class="rs_form_box">
                    <div class="input-group">
                     <label>   <strong><b>Mobile  </b>  </strong></label>  
                        <input type="text" name="phone" class="form-controller" value="<%= userName != null ? userName : "" %>">
                    </div>
                    <div class="input-group">
                        <label><b> Password  </b></label>
                        <input type="password" name="password" class="form-controller" value="<%= passWord != null ? passWord : "" %>">
                    </div>
                </div>
                <div class="text-center">
                    <div class="rs_btn_group">
                        <button class="btn btn-default" name="submit" type="submit">Login</button>
                        <a href="<%= Helper.baseUrl %>Register.jsp" class="btn btn-default">Register</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>


<script>
    function validateLoginForm() {
        var phone = document.forms["loginForm"]["phone"].value;
        var password = document.forms["loginForm"]["password"].value;
        
        if (phone == "" || password == "") {
            alert("Both fields are required.");
            return false;
        }
    }
</script>

<%@ include file="footer.jsp" %>
	