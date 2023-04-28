<%-- 
    Document   : viewSyllabus
    Created on : Apr 16, 2023, 6:46:29 PM
    Author     : admin
--%>
<%@page import="config.AppConfig" %>
<%@page import="java.util.ArrayList" %>
<%@page import="entities.Syllabus" %>
<%@ page import="entities.Subject" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/components/common/head.jspf" %>
    <title>List Syllabus</title>
</head>
<body>
<%
    ArrayList<Subject> lsSubject = (ArrayList<Subject>) request.getAttribute(AppConfig.DASHBOARD_SUBJECT_LIST);
%>
<div class="dashboard-container">
    <%@include file="/components/dashboard/sidebar.jspx" %>
    <main>
        <%@include file="/components/dashboard/header.jspx" %>
        <div class="dashboard-content">
            <div class="container-2xl">
                <table class="table">
                    <thead>
                    <tr>
                        <th scope="col">
                            <input type="checkbox"/>
                        </th>
                        <th scope="col">ID</th>
                        <th scope="col">Name</th>
                        <th scope="col">ViName</th>
                        <th scope="col">Slug</th>
                        <th scope="col">Semester</th>
                        <th scope="col">CreatedAt</th>
                        <th scope="col">UpdatedAt</th>
                        <th scope="col">Edit</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="sub" items="<%= lsSubject%>">
                        <td>${sub.id}</td>
                        <td>${sub.name}</td>
                        <td>${sub.viName}</td>
                        <td>${sub.slug}</td>
                        <td>${sub.semester}</td>
                        <td>${sub.createdAt}</td>
                        <td>${sub.updatedAt}</td>
                        <td>
                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-outline-success btn-sm">Publish</button>
                                <button type="button" class="btn btn-outline-primary btn-sm">Edit</button>
                                <button type="button" class="btn btn-outline-danger btn-sm">Delete</button>
                            </div>
                        </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>
</body>
</html>
