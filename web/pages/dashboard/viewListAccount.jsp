<%-- 
    Document   : viewSyllabus
    Created on : Apr 16, 2023, 6:46:29 PM
    Author     : admin
--%>
<%@page import="config.AppConfig" %>
<%@page import="java.util.ArrayList" %>
<%@page import="entities.Syllabus" %>
<%@ page import="entities.Subject" %>
<%@ page import="entities.User" %>
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
    ArrayList<User> lsAccounts = (ArrayList<User>) request.getAttribute(AppConfig.DASHBOARD_ACCOUNT_LIST);
%>
<div class="dashboard-container">
    <%@include file="/components/dashboard/sidebar.jspx" %>
    <main>
        <%@include file="/components/dashboard/header.jspx" %>
        <div class="dashboard-content">
            <div class="container-xl" style="margin-top: 32px">
                <div class="ulm-table__container">
                    <table class="ulm-table">
                        <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Full Name</th>
                            <th scope="col">username</th>
                            <th scope="col">Role</th>
                            <th scope="col">Action</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="acc" items="<%= lsAccounts%>">
                            <td>${acc.id}</td>
                            <td>${acc.fullname}</td>
                            <td>${acc.username}</td>
                            <td>${acc.roleid}</td>
                            <td>
                                <div class="d-flex gap-2">
                                    <button type="button" class="btn btn-outline-primary btn-sm"
                                            onclick="window.location.href='${pageContext.servletContext.contextPath}/dashboard/subjects/edit?id=${sub.id.trim()}'">
                                        Edit
                                    </button>
                                    <button type="button" class="btn btn-outline-danger btn-sm">Delete</button>
                                </div>
                            </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>
