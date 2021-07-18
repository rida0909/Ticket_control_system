<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<!--
integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous"  -->
<meta charset="ISO-8859-1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
<title>Admin Panel</title>
</head>

<style>
html, body { overflow-x: hidden; }
body {
    margin: 0;
    color: #6a6f8c;
    background:rgba(0, 77, 77, .9);
    font: 600 16px/18px 
}
ul.topnav {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: #0d3634;
}

ul.topnav li {float: left;}

.nav-right{
	float: right;
}

.nav-left{
	float: left;
}

ul.topnav li a {
  display: inline-block;
  color: #fefefe;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  transition: 0.3s;
  font-size: 17px;
}

ul.topnav li a:hover {background-color: #165955;}

ul.topnav li.icon {display: none;}

@media screen and (max-width:680px) {
  ul.topnav li:not(:first-child) {display: none;}
  ul.topnav li.icon {
    float: right;
    display: inline-block;
  }
}

@media screen and (max-width:680px) {
  ul.topnav.responsive {position: relative;}
  ul.topnav.responsive li.icon {
    position: absolute;
    right: 0;
    top: 0;
  }
  ul.topnav.responsive li {
    float: none;
    display: inline;
  }
  ul.topnav.responsive li a {
    display: block;
    text-align: left;
  }
}
.input{
 	border: none;
    padding: 15px 20px;
    border-radius: 25px;
    width: 90%;
    background: rgba(255, 255, 255, .1);
}
.inputUser{
 	border: none;
    padding: 10px 20px;
    border-radius: 20px;
    width: 90%;
    background: rgba(255, 255, 255, .1);
}
.group .label,.group .input{
color: #fff;
}

.input{
margin-left: 5%;
}
.group{
 margin-top: 20px;
 margin-bottom: 40px;
}
.black{
color: black;
}

.button {
    border: none;
    padding: 15px 20px;
    border-radius: 25px;
    background: rgba(255, 255, 255, .1);
    color: #fff;
    display: block;
    background: #1161ee;
    width: 120px;
}

.modal_button {
    border: none;
    padding: 10px 20px;
    margin: 10px;
    border-radius: 25px;
    background: rgba(255, 255, 255, .1);
    width: 100px;
    height: 40px;
    color: #fff;
    display: block;
    background: #1161ee;
}

.buttonUser {
    border: none;
    padding: 15px 20px;
    border-radius: 25px;
    background: rgba(255, 255, 255, .1);
    color: #fff;
    display: block;
    background: #1161ee;
    justify-content: center;
  	align-items: center;    
}

#customers {
  table-layout: fixed;
  width: 100px;
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  margin-top: 20px;
  width: 100%;
  border-radius: 10px;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
  text-color: white;
  text-align: center;
  
}
 #customers td, #customers a {
  overflow: hidden; 
  text-align: center;
  color: white;
}
 
#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: center;
  background-color: #55949d;
  color: white;
  background: rgba(255, 255, 255, .1);
}
.text{
	display: block;
	width: 550px;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

</style>
<script>
	  $( function() {
	    $( "#fromdatepicker" ).datepicker({
	    	dateFormat: 'yy-mm-dd'
	    }).val();
	  } );
	  
	  $( function() {
		    $( "#todatepicker" ).datepicker({
		    	dateFormat: 'yy-mm-dd'
		    }).val();
		  } );
</script>
<body>
 <%
	 List<?> desc = (List<?>) request.getAttribute("desc");
	 List<?> user = (List<?>) request.getAttribute("user");
	 List<Integer> cust = (List<Integer>) request.getAttribute("cust");
	 List<?> custName = (List<?>) request.getAttribute("custName"); 
	 List<?> rid = (List<?>) request.getAttribute("id");
	 List<?> allUserId = (List<?>) request.getAttribute("allUserId");
	 List<?> allUsername = (List<?>) request.getAttribute("allUsername");
	 List<?> assignedUsername = (List<?>) request.getAttribute("assignedUsername");
	 List<?> issueType = (List<?>) request.getAttribute("issueType");
	 List<?> issueCategory = (List<?>) request.getAttribute("issueCategory");
	 List<?> createdDate = (List<?>) request.getAttribute("createdDate");
	 List<?> closedDate = (List<?>) request.getAttribute("closedDate");
	 List<?> issueStatus = (List<?>) request.getAttribute("issueStatus");
	 List allCustomerNames = (List)request.getAttribute("allCustomerNames");
	 	List allCustomerIds = (List)request.getAttribute("allCustomerIds");
 %>
	<ul class="topnav">
	  <div  class = "nav-right">
	  <li><a href="/home" style = "font-size:15px;">Logout</a></li>
	  </div>
	  <div class = "nav-left">
	  <li style = "padding-right: 10px;">
		 <!-- Trigger the modal with a button -->
  <a data-toggle="modal" data-target="#myModal" style = "font-size:15px; padding-right: 0px;">New User</a>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg modal-dialog-centered"  style = "padding-left:100px;">
    
        <form action = "/sign-up">
      <!-- Modal content-->
      <div class="modal-content" style = "background:rgb(0, 77, 77); width:500px;">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" style = "color: #fff;">&times;</button>
          <h4 class="modal-title"></h4>
        </div>
        <div class="modal-body" style = "padding-left: 60px;">
        
	  	   <div class="group">
	  	   		<input name="username" id="name" type="text" class="inputUser" placeholder="Username"> 
	  	   </div>
           <div class="group"><input name="email" id="add" type="email" class="inputUser" placeholder="Email"> </div>
           <div class="group"><input name="mobile" id="city" type="number" class="inputUser" placeholder="Mobile"></div>
           <div class="group"><input name="password1" id="pass1" type="password" class="inputUser" data-type="password" placeholder="Password"> </div>
           <div class="group">  <input name="password2" id="pass2" type="password" class="inputUser" data-type="password" placeholder="Confirm Password"> </div>
           <div class="group"> <select name="role" class = "inputUser">
           <option value="customer">Customer</option>
           <option value="staff">Staff</option>
           <option value="admin">Admin</option>
           </select> </div>
		<!-- <input type="submit" class="button ml-4" value="Add user" style = "width : 300px;" id = "applyBtn"> -->
 
	<!-- <div class="group"> <input type="submit" class="button" value="Send"> </div> -->
          
          </div>
        
        <div class="modal-footer">
          <button type="submit" class="btn btn-default">Add</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      </form>
      
    </div>
  </div></li>
</div>

<div class = "nav-left">
  <li>
  
		 <!-- Trigger the modal with a button -->
  <a data-toggle="modal" data-target="#myModal2" style = "font-size:15px;  padding-left: 0px;">Create new ticket</a>

  <!-- Modal -->
  <div class="modal fade" id="myModal2" role="dialog">
    <div class="modal-dialog modal-lg modal-dialog-centered"">
    
        <form action = "/create-request?action=admin" method="post" encType="multipart/form-data"> 
      <!-- Modal content-->
      <div class="modal-content" style = "background:rgb(0, 77, 77);">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" style = "color: #fff;">&times;</button>
          <h4 class="modal-title"></h4>
        </div>
        <div class="modal-body" style = "width: 700px;">
        
          <div class = "group mt-4 "><label class = "label"> Message area:</label><br />
		 <textarea class = "input" style = "height: 300px; color: white; " name = "description" required placeholder = "Write your message..." ></textarea> <br />
	</div>
	<div class = "group"><label class = "label"> Attachment:</label><br />
	        <input class = "input" type="file" name="files" multiple />
	 </div>
	 
	 <select name = "cid" >
					  <option value = "none">Select User</option>
					  <% if(allCustomerNames.size() != 0) {
					    	for(int k = 0; k < allCustomerNames.size(); k++) { %>
					      <option value = <%=allCustomerIds.get(k)%>> <%out.println(allCustomerIds.get(k)); %> : <% out.println(allCustomerNames.get(k));%></option>
					      <%}
						}%>
					</select>
	<!-- <div class="group"> <input type="submit" class="button" value="Send"> </div> -->
          
          </div>
        
        <div class="modal-footer">
          <button type="submit" class="btn btn-default">Send</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      </form>
      
    </div>
  </div>
  </li>
</div>
	</ul>
	
	<button type="button" class = "modal_button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal1">Filters</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal1" role="dialog"  style = " width: 1500px;">
    <div class="modal-dialog modal-lg modal-dialog-centered" >
    
        <form action = "/admin">
      <!-- Modal content-->
      <div class="modal-content" style = "background:rgb(0, 77, 77);">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" style = "color: #fff;">&times;</button>
          <h4 class="modal-title"></h4>
        </div>
        <div class="modal-body">
        
          <p>
				    <input type="radio" value = "date" id = "date" name = "filter">
				    From Date : <input type = "text" id = "fromdatepicker" name = "from_date" autocomplete="off" placeholder="YYYY-MM-DD">
				    To Date : <input type = "text" id = "todatepicker" name = "to_date" autocomplete = "off" placeholder="YYYY-MM-DD">
				    </p>				    
				    <p><input type="radio" value = "status" id = "status" name = "filter">Status :
				    	<input type="radio" value = "created" id = "created" name = "filter_status">
				    	<label for="created">Created</label>
				    	<input type="radio" value = "assigned" id = "assigned" name = "filter_status">
				    	<label for="assigned">Assigned</label>
				    	<input type="radio" value = "waiting_for" id = "waiting_for" name = "filter_status">
				    	<label for="waiting_for">Waiting for</label>
				    	<input type="radio" value = "resolved" id = "resolved" name = "filter_status">
				    	<label for="resolved">Resolved</label>
			    	</p>
			    	 <p><input type="radio" value = "user" id = "user" name = "filter">Select User :
			    	 <select name = "filter_user_id" >
					  <option value = "none">Select User</option>
					  <% if(allUserId.size() != 0) {
					    	for(int k = 0; k < allUserId.size(); k++) { %>
					      <option value = <%=allUserId.get(k)%>> <%out.println(allUserId.get(k)); %> : <% out.println(allUsername.get(k));%></option>
					      <%}
						}%>
					</select>
			    	 </p>
			    	 <p>
			    	 <input type="radio" value = "issue" id = "issue" name = "filter">
			    	 Issue Type :
			    	 <select name = "filter_issue_type" >
					  <option value = "none">Select Issue type</option>
					  <option value = "technical">Technical</option>
					  <option value = "non-technical">Non-technical</option>
					</select>
						Issue Category :
			    	 <select name = "filter_issue_category" >
					  <option value = "none">Select Issue category</option>
					  <option value = "hardware">Hardware</option>
					  <option value = "software">Software</option>
					  <option value = "other">Other</option>
					  <option value = "c4">Category 4</option>
					</select>
			    	 </p>
          </div>
        
        <div class="modal-footer">
        <a href = "/admin" style = "text-align: center; text-color: #D9D9DB;">Reset Filters</a>
          <button type="submit" class="btn btn-default">Send</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      </form>
      
    </div>
  </div>

	<table class = "table table-sm table-responsive-sm" id="customers">
	  <tr>
	  <th style = "width: 70px;">Id</th>
	    <th>Description</th>
	    <th>Type</th>
	    <th>Category</th>
	    <th>Created</th>
	    <th>Closed</th>
	    <th>Customer</th>
	    <th>Status</th>
	    <th style = "width: 150px;">User </th>
	    <th>Assign user</th>
	  </tr>
	<% int i;
	 for(i=0; i<desc.size(); i++){
	 %><form action = "/assi-user?id=<%=rid.get(i) %>" method="post" name="assignUser" onsubmit="return validateAssignUser()">
		<tr>
		<td>
	    	<a href="user-request?id=<%=rid.get(i)%>&&action=admin" style = "font-color: #FFFFFF;"> <% out.println(rid.get(i)); %> </a>
	    </td>
	    <td>
	    	<a href="user-request?id=<%=rid.get(i)%>&&action=admin" style = "font-color: #FFFFFF;"><% out.println(desc.get(i)); %> </a>
	    </td>
	    <td><%if(issueType.get(i) != null){ %> <% out.println(issueType.get(i)); %> <% } else { %> - <%} %>    </td>
	    <td> <%if(issueCategory.get(i) != null){ %> <% out.println(issueCategory.get(i)); %> <% } else { %> - <%} %>   </td>
	    <td> <%if(createdDate.get(i) != null){ %> <% out.println(createdDate.get(i)); %> <% } else { %> - <%} %>  </td>
	    <td> <%if(closedDate.get(i) != null){ %> <% out.println(closedDate.get(i)); %> <% } else { %> - <%} %>  </td>
	    <% if(cust.get(i) != 14 ) {%>
	    <td><% out.println(custName.get(i)); %> </td>
	    <% } else { %>
	    <td> - </td>
	    <% } %>
	    
	    <td> <% out.println(issueStatus.get(i)); %> </td>
	    <td>
	    <select name = "user"  class="input" style = "background-color : #4e8891">
			<%if(assignedUsername.get(i) != null) { %>
				<option value="none" style = "font-color: white;"> <%out.println(assignedUsername.get(i));%></option>
			<%}else{ %>
			  	<option value="none" style = "font-color: white;">Select User</option>
			<%} %>
			  <% if(allUserId.size() != 0) {
			    	for(int k = 0; k < allUserId.size(); k++) { %>
			    	<%if(allUsername.get(k) != "admin") {%>
			      <option value = "<%=allUserId.get(k)%>"> <%out.println(allUserId.get(k)); %> : <% out.println(allUsername.get(k));%>
			      </option>
			      	<%} %>
			      <%}
				}%>
			</select>
	    </td>
	    <td> <input type="submit" class="button ml-4" value="Submit">  </td>
	  </tr>
	   </form>	
	   <% } %> 
	</table>

	
	

</body>
</html>