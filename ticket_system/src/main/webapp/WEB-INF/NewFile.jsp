<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
 <div>
     <h3>Upload Multiple Files</h3>
     <form action = "/uploadFiles" method="post"  encType="multipart/form-data">
       <input type="file" name="files" multiple required />
       <button type="submit">Submit</button>
     </form>
   </div>
   
   <div>
     <h3>List of Documents</h3>
     <table>
       <thead>
         <tr>
           <th>Id</th>
           <th>Name</th>
           <th>Download Link</th>
         </tr>
       </thead>
       <tbody>
         <tr th:each="doc:${docs}">
           <td th:text="${doc.Id}" />
           <td th:text="${doc.docName}"/>
           <td><a th:href="@{'/downloadFile/'+${doc.id}}">Download</a></td>
         </tr>
       </tbody>
     </table>
   </div>
</body>
</html>