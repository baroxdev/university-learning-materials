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
    User currentUser = (User) request.getSession().getAttribute(AppConfig.AUTH_USER);
    ArrayList<User> lsAccounts = (ArrayList<User>) request.getAttribute(AppConfig.DASHBOARD_ACCOUNT_LIST);
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
                                    <c:choose>
                                        <c:when test='<%=currentUser!= null ? currentUser.getRoleID().equals("ADM") : false %>'>
                                            <button type="button" class="btn btn-block btn-outline-primary btn-sm"
                                                    data-id="${acc.id}"
                                                    data-active="${acc.active ? "active" : "in-active"}">
                                                    ${acc.active ? "Block" : "Unblock"}
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${acc.active}">
                                                    <span class="badge rounded-pill text-bg-success">active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge rounded-pill text-bg-secondary">in-active</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                    <button type="button" class="btn btn-outline-primary btn-sm"
                                            onclick="window.location.href='${pageContext.servletContext.contextPath}/dashboard/accounts/edit?id=${acc.id.trim()}'">
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

<script src="https://unpkg.com/lucide@latest"></script>
<script>
    <%@ include file="/js/main.js" %>
</script>
<script>
    lucide.createIcons();

    $(document).ready(() => {
        const buttons = document.querySelectorAll('.btn-block');
        console.log({buttons})
        buttons.forEach(btn => {
            btn.addEventListener('click', async (event) => {
                const type = "accounts"; //Remember to edit this one when apply in another route.
                const url = `${pageContext.servletContext.contextPath}/dashboard/\${type}/update-status`;
                const id = event.target.dataset.id;
                console.log({dataset: event.target.dataset.active})
                const active = !Boolean(event.target.dataset.active == 'active');
                const isConfirm = confirm(`Are you sure to \${active ? "UNBLOCK" : "BLOCK"} \${id}?`);

                if (!isConfirm) return;
                const data = {
                    id: id,
                    status: active
                }
                const options = {
                    method: "POST",
                    body: JSON.stringify(data)
                }

                try {
                    startLoading();
                    const res = await fetch(url, options);
                    const result = await res.json();
                    if (!res.ok) {
                        throw new Error(result.message);
                    }
                    alert(result.message + "\n We will reload to update new data.");
                    window.location.reload();
                } catch (e) {
                    console.error(e)
                    alert("Cannot update status of " + id);
                }
                stopLoading();
            });
        });
    })

</script>
</body>
</html>
