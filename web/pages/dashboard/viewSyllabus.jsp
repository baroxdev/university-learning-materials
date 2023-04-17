<%-- 
    Document   : viewSyllabus
    Created on : Apr 16, 2023, 6:46:29 PM
    Author     : admin
--%>
<%@page import="config.AppConfig"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Syllabus"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="/components/common/head.jspf" %>
        <title>List Syllabus</title>
    </head>
    <body>
        <%
            ArrayList<Syllabus> lsSyllabus = (ArrayList<Syllabus>) request.getAttribute(AppConfig.DASHBOARD_SYLLABUS_LIST);
        %>
        <div class="dashboard-container">
            <div class="col-md-2" style="background-color: rgba(5, 44, 101, 1); width: 212px;">
                <h2 style="color: #FFFFFF; font-family: 'Inter'; font-size: 20px;">
                    ULM Dashboard
                </h2>
            </div>
            <div class="container-xl">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">
                                <input type="checkbox" />
                            </th>
                            <th scope="col">ID</th>
                            <th scope="col">Name</th>
                            <th scope="col">Credit</th>
                            <th scope="col">Description</th>
                            <th scope="col">Task</th>
                            <th scope="col">ScoringScale</th>
                            <th scope="col">Status</th>
                            <th scope="col">MinScore</th>
                            <th scope="col">CreatedAt</th>
                            <th scope="col">UpdatedAt</th>
                            <th scope="col">isApproved</th>
                            <th scope="col">Edit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="syl" items="<%= lsSyllabus%>">
                            <tr>
                                <th scope="row">
                                    <input type="checkbox" />
                                </th>
                                <td>${syl.id}</td>
                                <td>${syl.name}</td>
                                <td>${syl.credit}</td>
                                <td>${syl.description}</td>
                                <td>${syl.task}</td>
                                <td>${syl.scoringScale}</td>
                                <td>${syl.status}</td>
                                <td>${syl.minScore}</td>
                                <td>${syl.createdAt}</td>
                                <td>${syl.updatedAt}</td>
                                <td>${syl.isApproved}</td>
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
    </body>
</html>
