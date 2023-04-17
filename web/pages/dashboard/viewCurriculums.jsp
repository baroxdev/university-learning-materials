<%@page import="config.AppConfig"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Curriculum"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <%@include file="/components/common/head.jspf" %>
        <title>List Curriculum</title>
    </head>
    <body>
        <%
            ArrayList<Curriculum> lsCur = (ArrayList<Curriculum>) request.getAttribute(AppConfig.DASHBOARD_CURRICULUM_LIST);
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
                            <th scope="col">Description</th>
                            <th scope="col">Decision No</th>
                            <th scope="col">Edit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cur" items="<%= lsCur%>">
                            <tr>
                                <th scope="row">
                                    <input type="checkbox" /> 
                                </th>
                                <td>${cur.id}</td>
                                <td>${cur.name}</td>
                                <td>${cur.description}</td>
                                <td>${cur.decisionNo}</td>
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

