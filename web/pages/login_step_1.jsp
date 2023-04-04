<%-- 
    Document   : login_step_1
    Created on : Apr 3, 2023, 11:12:22 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <%@include file="/components/common/head.jspf" %>
        <title>Login</title>
    </head>
    <body>
        <div class="container h-100 d-flex justify-content-center align-items-center w-100">
            <div class="d-flex w-100 justify-content-center align-items-center">
                <form action="./login" method="POST">
                        <div class="header col-md-12 col-12 text-center">
                            Sign in with Student ID
                        </div>
                        <div class="col-md-12">
                            <div class="form-group">
                                <label class="mb-2" for="studentID">Student ID</label>
                                <input type="text" name="studentID" id="studentID" class="form-control">
                            </div>
                        </div>
                        <div class="row mb-3 components">
                            <div class="col-md-6 text-center">
                                <input class="form-check-input" type="checkbox" name="" id="rememberMe">
                                <label class="form-check-label" for="rememberMe">Remember me</label>
                            </div>
                            <div class="col-md-6 text-center">
                                <a href="#">Forgot password?</a>
                            </div>
                        </div>
                        <button class="btn-primary btn btn-block col-md-12 col-12" type="submit" >Continue <i
                                class="fa-solid fa-arrow-right-long"></i>
                        </button>
                </form>
            </div>
        </div>
    </div>
    <script>
        async function handleSubmit() {
            const usernameNode = document.getElementById("studentID");
            const passwordNode = document.getElementById("password");
            
            const hasPasswordInput = passwordNode !== null;
            let apiUrl = "${pageContext.request.servletContext.contextPath}/login";
            let params = {
                studentID: usernameNode?.value
            }
            
            if (hasPasswordInput) {
                params.password = passwordNode?.value
            }
            
            const res = await fetch(url, {
                method: "POST",
                body: JSON.stringify(params)
            })
        }
    </script>
</body>
</html>
