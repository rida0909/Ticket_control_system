<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	

<title>Insert title here</title>
</head>
<style>
html, body { overflow-x: hidden; }
body {
    margin: 0;
    color: #6a6f8c;
    background:rgba(0, 77, 77, .9);
    font: 600 16px/18px 
}
.input{
 	border: none;
    padding: 15px 20px;
    border-radius: 25px;
    background: rgba(255, 255, 255, .1);
    width: 90%; 
}
.group .label,.group .input{
color: #fff;
}

.input{
margin-left: 1%;
}
.group{
 margin-bottom: 25px;
}
.black{
color: black;
}

.button {
    border: none;
    padding: 10px 20px;
    border-radius: 25px;
    background: rgba(255, 255, 255, .1);
    width: 150px;
    height: 40px;
    color: #fff;
    display: block;
    background: #1161ee;
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

ul.topnav {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: #333;
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
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  transition: 0.3s;
  font-size: 17px;
}

ul.topnav li span {
  display: inline-block;
  margin-right: 100px;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  transition: 0.3s;
  font-size: 17px;
}

ul.topnav li a:hover {background-color: #111;}

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

#customers {
  table-layout: absolute;
  width: 100px;
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  margin-top: 20px;
  width: 100%;
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

 <% List des = (List)request.getAttribute("desc"); 
 	List rid = (List)request.getAttribute("rid");
 	List cid = (List)request.getAttribute("custId");
 	Integer uid = (Integer)request.getAttribute("uid");
 	List cName = (List)request.getAttribute("custName");
 	List<String> status = (List)request.getAttribute("sts");
 	List type = (List)request.getAttribute("type");
 	List cat = (List)request.getAttribute("category");
 	List date = (List)request.getAttribute("dt");
 	List allCustomerNames = (List)request.getAttribute("allCustomerNames");
 	List allCustomerIds = (List)request.getAttribute("allCustomerIds");
 	String userName = (String)request.getAttribute("userName");
 %>
 
 <ul class="topnav">
 	  <div  class = "nav-right">
	  <li><a href="/home" style = "font-size:15px;">Logout</a></li>
	  </div>
	  <div  class = "nav-right">
	  <li><span style = "font-size:12px;  padding-right: 0px; color: #A9A9A9;"><%=userName %></span></li>
	  </div>
	  <div  class = "nav-left">
  <li>
		 <!-- Trigger the modal with a button -->
  <a data-toggle="modal" data-target="#myModal2" style = "font-size:15px;  padding-left: 0px;">Create new ticket</a>

  <!-- Modal -->
  <div class="modal fade" id="myModal2" role="dialog">
    <div class="modal-dialog modal-lg modal-dialog-centered">
    
        <form action = "/create-request?action=staff&&uid=<%= uid %>" method="post" encType="multipart/form-data"> 
      <!-- Modal content-->
      <div class="modal-content" style = "background:rgb(0, 77, 77);">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" style = "color: #fff;">&times;</button>
          <h4 class="modal-title"></h4>
        </div>
        <div class="modal-body"  style ="width:700px; padding-left: 60px;">
        
          <div class = "group mt-4 "><label class = "label"> Description:</label><br />
		 <textarea class = "input" style = "height: 300px; color: white;" name = "description" required placeholder = "Write your message..." ></textarea> <br />
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
	
		 <!-- Trigger the modal with a button -->
  <button type="button" class = "modal_button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal1">Filters</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal1" role="dialog"  style = " width: 1500px;">
    <div class="modal-dialog modal-lg modal-dialog-centered" >
    
	<form action = "/support-filter">
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
        <a href = "/user-page?id=<%=uid%>" style = "text-align: center; text-color: #D9D9DB;">Reset Filters</a>
          <button type="submit" class="btn btn-default">Send</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      </form>
      
    </div>
  </div>
 <table class = "table table-sm table-responsive-sm" id="customers">
	  <tr>
	  <th style = "width: 80px;">Id</th>
	    <th>Description</th>
	    <th>Status</th>
	    <th>Issue Type</th>
	    <th>Issue Category</th>
	    <th>Date</th>
	    <th>Customer</th>
	    <th style = "width: 100px;">Mark</th>
	  </tr>
 
 <% int i;
 for(i=0; i<des.size(); i++){ 
	 String sts = status.get(i);
 %>
 
 <form action = "/resolved?id=<%=rid.get(i) %>" method = "post">

	 <tr>
		<td>
	<a style = "color:white;" href ="user-request?id=<%=rid.get(i) %>&&action=staff">
	<% if(rid.get(i) != null){ %><% out.println(rid.get(i)); %><% } else { %> - <% } %></a>
	</td>
	<td>
	<a style = "color:white;" href ="user-request?id=<%=rid.get(i) %>&&action=staff">
	<% if(rid.get(i) != null){ %><% out.println(des.get(i)); %><% } else { %> - <% } %></a>
	</td>
	    <td>
	<% if(status.get(i) != null){ %><% out.println(status.get(i)); %><%}  else { %> - <% } %>
	</td>
	    <td>
	<% if(type.get(i) != null){ %><% out.println(type.get(i)); %><%}  else { %> - <% } %>
	</td>
	    <td>
	<% if(cat.get(i) != null){ %><% out.println(cat.get(i)); %><%}  else { %> - <% } %>
	</td>
	    <td>
	<% out.println(date.get(i)); %>
	</td>
	    <td>
	<% out.println(cName.get(i)); %>
	</td>
	<% if(!sts.contentEquals("resolved")) {%>
	<td><input type="submit" class="button" value="Resolved"></td>
	<% } else { %>
	<td><input type="submit" style = "background: #778899;" class="button" value="Resolved" disabled></td>
	<% } %>
	
	 </tr>
	</form>

 <% } %>

 </table>

</body>
</html>