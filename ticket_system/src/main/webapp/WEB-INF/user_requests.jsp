<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.List"%>
    <%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
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
    font: 600 16px/18px;
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
.box-tag{
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
    width: 600px;
    color: #ffffe6;
    display: block;
    background: #1161ee;
}

.text{
	display: block; 
	width: 550px;
	overflow: hidden;
	white-space: nowrap;
	text-overflow: ellipsis;
}

::placeholder{
color: #D4E6B5;
opacity: 0.5;
}


ul.topnav {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: #333;
}

ul.topnav li {float: left;}

ul.topnav li a {
  display: inline-block;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  transition: 0.3s;
  font-size: 17px;
}
.nav-right{
	float: right;
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

</style>
  
<body>

 <% String des = (String)request.getAttribute("desc"); 
 	Integer rid = (Integer)request.getAttribute("rid");
 	Integer uid = (Integer)request.getAttribute("uid");
 	Integer cid = (Integer)request.getAttribute("cid");
 	String userName = (String)request.getAttribute("username");
 	String reqDate = (String)request.getAttribute("rqDate");
 	String action = (String)request.getAttribute("action");
 	List<Object> msgs = (List)request.getAttribute("msg");
 	List dates = (List)request.getAttribute("dt");
 	List attachedFiles = (List)request.getAttribute("attFiles");
 	List allUserNames = (List)request.getAttribute("allUserNames");
 	List allUserIds = (List)request.getAttribute("allUserIds");
 	String status = (String)request.getAttribute("sts");
 	String type = (String)request.getAttribute("issueType");
 	String category = (String)request.getAttribute("issueCateg");
 	List<String> whoseMsg = (List)request.getAttribute("whose_msg");
 	boolean isUser = (boolean)request.getAttribute("isUser");
 	JSONArray msgArray = (JSONArray) request.getAttribute("msgArray");
 %>
 
 <ul class="topnav">

 <% if(action.contentEquals("admin")){ %>
	  <li><a class="active" href="/admin">Home</a></li>
	  <% } %>
<% if(action.contentEquals("staff")){ %>
	  <li><a class="active" href="/user-page?id=<%=uid %>">Home</a></li>
	  <% } %>
<% if(action.contentEquals("customer")){ %>
	  <li><a class="active" href="/customer-page?cid=<%=cid %>">Home</a></li>
	  <% } %>
	 <div class = "nav-right">
	  <li><a href="/home">Logout</a></li>
  </div>
	</ul>

 <div class = "row">
 
	 <div class = "col-sm-6 pl-4">
		 <div class = "group mt-2"><label class = "label">Description:</label><br/>
		 <div class = "input" ><% out.println(des); %></div> <br/>
	 </div>
	 
	 <div class = "group mt-2"><label class = "label">Attached Files:</label><br/>
		<div class = "input"><% if(attachedFiles.size() > 0) {
			int f;
			for(f = 0; f < attachedFiles.size(); f++) { %> <% out.println(attachedFiles.get(f)); %> <% }} else { %> no files <% } %> </div>
	 </div>
	 
	 <div class = "group mt-2 pl-3"><label class = "label">Status:</label><br />
	 		<div class = "input"><% out.println(status); %> </div>
	 	</div>
	 	
	 <div class = "group mt-2 pl-3"><label class = "label">Issue Type:</label><br />
	 		<div class = "input"><% if(type != null) { %> <% out.println(type); %> <% } else { %> - <% } %> </div>
	 	</div>
	 	
	 <div class = "group mt-2 pl-3"><label class = "label">Issue Category:</label><br />
	 		<div class = "input"><% if(category != null) { out.println(category); } else { out.println("-"); }%> </div> 
	 	</div>
	 	
	 <div class = "group mt-2 pl-3"><label class = "label">Assigned User:</label><br />
	 		<div class = "input"><% if(uid != null) { %> <% out.println(uid); %> - <% out.println(userName); %> <% } else { %> - <% } %> </div>
	 </div>
	 
	 <div class = "group mt-2 pl-3"><label class = "label">Date Created:</label><br />
	 		<div class = "input"><% out.println(reqDate); %> </div>
	 	</div>
	 
 <% if(action.contentEquals("staff") || action.contentEquals("admin")){ %>	
  <!-- Trigger the modal with a button -->
  <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Assign Another User</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog modal-sm modal-dialog-centered">
    <form action = "/assi-anotheruser?id=<%=rid %>" method="post"> 
      <!-- Modal content-->
      <div class="modal-content" style = "background:rgb(0, 77, 77);">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" style = "color: #fff;">&times;</button>
          <h4 class="modal-title"></h4>
        </div>
        <div class="modal-body" style = "width: 340px;">
        
          <div class = "group mt-2 pl-5"><label class = "label"> Assign another user:</label><br />
			<select name = "assigned_user"  class="input" style = "background-color : #4e8891">
			  	<option value="none" style = "font-color: white;">Select User</option>
			  <% for(int k = 0; k < allUserIds.size(); k++) { %>
			    	<%if(allUserNames.get(k) != "admin") {%>
			      <option value = "<%=allUserIds.get(k)%>"> <%out.println(allUserIds.get(k)); %> : <% out.println(allUserNames.get(k));%>
			      </option>
			      <%}
				}%>
			</select>
	 </div>
        
        <div class="modal-footer">
        	<button type="submit" class="btn btn-default">Assign</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
 </form>
  </div>
  </div>	
  
  <!-- Trigger the modal with a button -->
  <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal2">Issue Type</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal2" role="dialog">
    <div class="modal-dialog modal-sm modal-dialog-centered">
            
      <form action = "/set-type?id=<%=rid %>&&action=<%=action %>" method="post"> 
      <!-- Modal content-->
      <div class="modal-content" style = "background:rgb(0, 77, 77);">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" style = "color: #fff;">&times;</button>
          <h4 class="modal-title"></h4>
        </div>
        <div class="modal-body" style = "width: 340px;">

          <div class = "group mt-2 pl-5"><label class = "label"> Issue Type:</label><br />
		  <select name = "type" class = "input" style = "background-color : #4e8891"> 
		  <option value = "Technical"> Technical </option>
		  <option value = "Non-Technical"> Non-Technical</option>
		  </select>
	 </div>
	 	<div class = "group mt-2 pl-5"><label class = "label"> Issue Category:</label><br />
		 <select name = "cat" class = "input" style = "background-color : #4e8891"> 
		  <option value = "software"> Software </option>
		  <option value = "hardware"> Hardware</option>
		  <option value = "other"> Other</option>
		  </select>
		  </div>
		 
        <div class="modal-footer">
        	<button type="submit" class="btn btn-default">Assign</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
    </form>
  </div>
  </div>	
 <% } %> 

 
 
 	
  <!-- Trigger the modal with a button -->
  <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal1">New Message</button>

  <!-- Modal -->
  <div class="modal fade" id="myModal1" role="dialog">
    <div class="modal-dialog modal-sm modal-dialog-centered">
           <form action = "/store-message?id=<%=rid %>&&uid=<%=uid %>&&action=<%=action %>" method="post" encType="multipart/form-data"> 
    
      <!-- Modal content-->
      <div class="modal-content" style = "background:rgb(0, 77, 77);">
      
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" style = "color: #fff;">&times;</button>
          <h4 class="modal-title"></h4>
        </div>
        <div class="modal-body"  style = "width: 340px;">
        
          <div class = "group mt-4 "><label class = "label"> Message area:</label><br />
		 <textarea class = "input" style = "height: 200px; color: white; " name = "message" placeholder = "Write your message..."></textarea> <br />
	</div>
	<div class = "group"><label class = "label"> Attachment:</label><br />
	        <input class = "input" type="file" name="files" multiple />
	 </div>
        </div>
        <div class="modal-footer">
        <button type="submit" class="btn btn-default">Send</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
        </form> 
    </div>
  </div>
 
 </div>

 	 
 <div class = "col-sm-6">
 
 <div class = "group mt-4 pl-3"><label class = "label"> Messages:</label><br/>
 
<% int j;	for(j = 0; j < msgs.size(); j++){
				 if((whoseMsg.get(j)).equals("c")) {%>
					  <h4 class="input panel-title" style="background: #70af85;">
					          <a class = "text" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=j %>"><% out.println(msgs.get(j)); %></a>
					  </h4>
				      <div id="collapse<%=j %>" class="panel-collapse collapse">
				        <div class="input panel-body mt-1" style="background: #70af85;"><% out.println(msgs.get(j)); %><br />
				       	<%-- <%out.println(msgArray.getJSONObject(j).get("filename")); %> --%>
				         <%
				        JSONArray fileArray = (JSONArray)msgArray.getJSONObject(j).get("filename"); 
				        JSONArray fileId = (JSONArray)msgArray.getJSONObject(j).get("fileid"); 
				        if((fileArray).length() != 0) { 
				        for(int k = 0; k < fileArray.length(); k++) { %>
				        	<a href = "/downloadFile/<%=fileId.get(k)%>"><%out.println(fileArray.get(k)); %></a>,
				        <% } %>
				       <% } %> 
				        
				       <%--  <%out.println(fileNames.get(j)); %>  --%>
				        </div>
				      </div>
				      <div class = "footer text-muted mb-2" style = "font-size: 12px; padding-left:20px">
				      <% out.println(dates.get(j)); %>
				      </div>
				  <%}else { %>
					  <h4 class="input panel-title">
					          <a class = "text" data-toggle="collapse" data-parent="#accordion" href="#collapse<%=j %>"><% out.println(msgs.get(j)); %></a>
					  </h4>
				      <div id="collapse<%=j %>" class="panel-collapse collapse">
				        <div class="input panel-body mt-1"><% out.println(msgs.get(j)); %><br />
				        <%-- some file <%out.println(msgArray.getJSONObject(j).get("filename")); %> --%>
				         <%
					        JSONArray fileArray = (JSONArray)msgArray.getJSONObject(j).get("filename");
					        JSONArray fileId = (JSONArray)msgArray.getJSONObject(j).get("fileid"); 
					        if((fileArray).length() != 0) { 
					        for(int k = 0; k < fileArray.length(); k++) { %>
					        	<a href = "/downloadFile/<%=fileId.get(k)%>"><%out.println(fileArray.get(k)); %></a>,
					        <% } %>
					       <% } %> 
				         
				        <%-- <%out.println(fileNames.get(j)); %>  --%>
				        </div>
				      </div>
				      <div class = "footer text-muted mb-2" style = "font-size: 12px; padding-left:20px">
				      <% out.println(dates.get(j)); %>
				      </div>
			      <%} %>
			<% } %>



  </div>
  
 </div>
  </div>

</body>
</html>