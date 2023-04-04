<%-- 
    Document   : index
    Created on : Apr 4, 2023, 4:54:25 PM
    Author     : quocb
--%>

<%@page import="entities.User"%>
<%@page import="config.AppConfig"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/components/common/head.jspf" %>
        <title>Universe Learning Material</title>
    </head>
    <body>
        <%
            Boolean isForceUpdate = (Boolean) session.getAttribute(AppConfig.AUTH_FORCE_UPDATE_PASSWORD);
            User user = (User) request.getSession().getAttribute(AppConfig.AUTH_USER);

            if (isForceUpdate != null && isForceUpdate && user != null) {
        %>
        <div class="modal fade show in" id="staticBackdropLive" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLiveLabel" aria-modal="true" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLiveLabel">Change Your Password</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                     
                        <form action="${pageContext.request.servletContext.contextPath}/auth/update-password" method="POST" id="update-password-form">
                            <input name="userId" value="<%= user.getId()%>" hidden/>
                            <label for="inputPassword5" class="form-label">Password</label>
                            <input type="password" name="password" required id="inputPassword5" class="form-control" aria-labelledby="passwordHelpBlock">
                            <label for="inputPassword5" class="form-label">Confirm Password</label>
                            <input type="password" name="confirm-password" required id="inputPassword5" class="form-control" aria-labelledby="passwordHelpBlock">
                        </form>
                               <div class="alert alert-warning mt-4" role="alert">
                            For your security, please update your password on your first login.
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">I'll do later</button>
                        <button type="submit" form="update-password-form" class="btn btn-primary">Update password</button>
                    </div>
                </div>
            </div>
        </div>  
        <script>
            window.addEventListener("load", (event) => {
                const myModal = new bootstrap.Modal('#staticBackdropLive', {
                    keyboard: false
                })
                myModal.show();
            });


        </script>
        <%
            }
        %>
        <h1>Hello World!</h1>
    </body>
</html>
