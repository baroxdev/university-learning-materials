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
<%@ page import="entities.Role" %>
<%@ page import="java.util.Arrays" %>
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
    User currentUser = (User) request.getSession().getAttribute(AppConfig.AUTH_USER);
    ArrayList<User> lsAccounts = (ArrayList<User>) request.getAttribute(AppConfig.DASHBOARD_ACCOUNT_LIST);
    ArrayList<Role> lsRole = (ArrayList<Role>) request.getAttribute(AppConfig.DASHBOARD_ROLE_LIST);
%>
<div class="dashboard-container">
    <%@include file="/components/dashboard/sidebar.jspx" %>
    <main>
        <%@include file="/components/dashboard/header.jspx" %>
        <div class="dashboard-content">
            <div class="container-xl" style="margin-top: 32px">
                <div class="d-flex align-items-center justify-content-between mb-4">
                    <legend>Accounts</legend>
                    <a class="btn btn-primary d-flex align-items-center"
                       href="${pageContext.servletContext.contextPath}/dashboard/accounts/create"><i
                            icon-name="plus"></i>Create</a>
                </div>
                <div id="filter">
                    <div id="filter-section" class="d-flex align-items-center gap-3">
                        Filter
                        <select class="form-select filter-item" id="role-filter" aria-label="Select filter by role">
                            <option value="none" selected>Select role</option>
                            <%
                                for (Role role : lsRole) {
                            %>
                            <option value="<%=role.getId()%>" <%=request.getParameter("role") != null && request.getParameter("role").equals(role.getId()) ? "selected" : ""%>><%=role.getRoleName()%>
                            </option>
                            <%
                                }
                            %>
                        </select>
                        <select class="form-select filter-item" id="status-filter" aria-label="Select filter by status">
                            <option value="none" selected>Select status</option>
                            <%
                                ArrayList<String> lsStatus = new ArrayList<>(Arrays.asList("active", "blocked"));
                                for (String st : lsStatus) {
                            %>
                            <option value="<%=st%>" <%=request.getParameter("status") != null && request.getParameter("status").equals(st) ? "selected" : ""%>
                            ><%=st%>
                            </option>
                            <%
                                }
                            %>
                        </select>
                        <button class="btn btn-secondary" id="btn-apply-filter">
                            Apply
                        </button>
                    </div>
                    <div class="input-group" style="width: fit-content">
                        <input type="text" class="form-control" style="max-width: 170px" placeholder="Name of user..."
                               aria-label="Search by name" aria-describedby="button-addon2">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button"
                                data-bs-toggle="dropdown" aria-expanded="false">Search by
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li>
                                <div class="dropdown-item" data-value="name">name</div>
                            </li>
                            <li>
                                <div class="dropdown-item" data-value="username">username</div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="ulm-table__container">
                    <table class="ulm-table">
                        <thead>
                        <tr>
                            <th scope="col" style="width: 150px;">ID</th>
                            <th scope="col" style="width: 200px">username</th>
                            <th scope="col" style="width: 100px">Role</th>
                            <th scope="col" style="width: 200px;">Created at</th>
                            <th scope="col" style="width: 200px;">Updated at</th>
                            <th scope="col" style="width: 100px;">Status</th>
                            <th scope="col">Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="acc" items="<%= lsAccounts%>">
                            <td>${acc.id}</td>
                            <td>${acc.username}</td>
                            <td>${acc.roleID}</td>

                            <td>${acc.createdAt}</td>
                            <td>${acc.updatedAt}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${acc.active}">
                                        <span class="badge rounded-pill text-bg-success">active</span>
                                    </c:when>
                                    <c:when test="${acc.active == null}">
                                        <span class="badge rounded-pill text-bg-secondary">in-active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge rounded-pill text-bg-danger">blocked</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="d-flex gap-2">
                                    <button type="button" class="btn btn-outline-primary btn-sm"
                                            onclick="window.location.href='${pageContext.servletContext.contextPath}/dashboard/accounts/edit?id=${acc.id.trim()}'">
                                        Edit
                                    </button>
                                    <button type="button" class="btn btn-outline-danger btn-sm">Delete</button>
                                    <c:choose>
                                        <c:when test='<%=currentUser!= null ? currentUser.getRoleID().equals("ADM") : false %>'>
                                            <c:if test="${!acc.roleID.equals('ADM')}">
                                                <button type="button" class="btn btn-block btn-outline-primary btn-sm"
                                                        data-id="${acc.id}"
                                                        data-active="${acc.active ? "active" : "in-active"}">
                                                        ${acc.active ? "Block" : "Unblock"}
                                                </button>
                                            </c:if>
                                        </c:when>
                                    </c:choose>

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

<script src="https://unpkg.com/lucide@latest"></script>
<script>
    <%@ include file="/js/main.js" %>
    <%@ include file="/js/account.js" %>

    lucide.createIcons();

    $(document).ready(() => {
        const buttons = document.querySelectorAll('.btn-block');
        const applyFilterButton = document.getElementById("btn-apply-filter");
        buttons.forEach(btn => {
            btn.addEventListener('click', async (event) => {
                await handleEditStatus(event)
            });
        });

        applyFilterButton.addEventListener("click", handleApplyFilter)
    })

    function handleApplyFilter() {
        const newUrl = getFilterURL();
        console.log({newUrl})
        if (newUrl) window.location.href = newUrl;
    }

    function getFilterURL() {
        const url = new URL(window.location.href);
        const roleFilter = document.getElementById("role-filter");
        const statusFilter = document.getElementById("status-filter");

        const role = roleFilter.value != 'none' ? roleFilter.value : null;
        const status = statusFilter.value != 'none' ? statusFilter.value : null;
        url.searchParams.delete("role");
        url.searchParams.delete("status");

        if (role != null && role.trim() !== '')
            url.searchParams.set("role", role);
        if (status != null && status.trim() != '') url.searchParams.set("status", status);
        if (url.toString() === window.location.href) return null;

        return url.toString();
    }
</script>
</body>
</html>
