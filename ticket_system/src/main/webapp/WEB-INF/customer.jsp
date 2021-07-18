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
    width: 400px; 
}
.group .label,.group .input{
color: #fff;
}

.input{
margin-left: 5%;
}
.group{
 margin-bottom: 25px;
}
.black{
color: black;
}

.button {
    border: none;
    padding: 15px 20px;
    border-radius: 25px;
    background: rgba(255, 255, 255, .1);
    width: 200px;
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
    width: 200px;
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

ul.topnav li {
	float: left;
}

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
<body>
	<% List des = (List)request.getAttribute("des"); 
 	List rid = (List)request.getAttribute("rid");
 	List status = (List)request.getAttribute("sts");
 	List date = (List)request.getAttribute("dt");
 	Integer cid = (Integer)request.getAttribute("cid");
 	String customerName = (String)request.getAttribute("custName");
 %>
 <ul class="topnav">
   <div  class = "nav-right">
	  <li><a href="/home">Logout</a></li>
	  </div>
 <div  class = "nav-right">
  <li><span style = "font-size:12px;  padding-right: 0px; color: #A9A9A9;"><%=customerName %></span></li>
  </div>

</ul>

 <table class = "table table-sm table-responsive-sm" id="customers">
	  <tr>
	  <th style = "width: 80px;">Id</th>
	    <th>Description</th>
	    <th>Status</th>
	    <th>Date</th>
	  </tr>
 <div class = "left" style = "float:left; padding-right: 100px; border-right: 3px solid white">
 <% 
 int i;
 for(i=0; i<des.size(); i++){ %>
 <tr>
 <td>
 <a style = "color:white;" href ="user-request?id=<%=rid.get(i) %>&&action=customer">
	<% out.println(rid.get(i)); %></a>
 </td>
	<td>
	<a style = "color:white;" href ="user-request?id=<%=rid.get(i) %>&&action=customer">
	<%out.println(des.get(i)); %></a>
	</td>
	
	 <td>
	<% out.println(status.get(i)); %>
	</td>
	
	<td>
	<% out.println(date.get(i)); %>
	</td>
	</tr>
	</div>
	 
 
 <% } %>


		<%
			Integer id = (Integer) request.getAttribute("cid");
			request.setAttribute("cid", id);
		%>
		 <!-- Trigger the modal with a button -->
  <button type="button" class = "modal_button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Create new ticket</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-lg modal-dialog-centered">
    
        <form action = "/create-request?cid=<%=cid %>&&action=customer" method="post" encType="multipart/form-data"> 
      <!-- Modal content-->
      <div class="modal-content" style = "background:rgb(0, 77, 77);">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" style = "color: #fff;">&times;</button>
          <h4 class="modal-title"></h4>
        </div>
        <div class="modal-body" style= "width: 600px;">
        
          <div class = "group mt-4 "><label class = "label"> Message area:</label><br />
		 <textarea class = "input" style = "height: 300px; color: white; " name = "description" required placeholder = "Write your message..." ></textarea> <br />
	</div>
	<div class = "group"><label class = "label"> Attachment:</label><br />
	        <input class = "input" type="file" name="files" multiple />
	 </div>
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
</body>
</html>