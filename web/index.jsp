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
        <%@include file="/components/common/header.jspf" %>
        <%
            Boolean isForceUpdate = (Boolean) request.getAttribute(AppConfig.AUTH_FORCE_UPDATE_PASSWORD);
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
        <section id="hero">
            <div class="search-box">
                <div class="search-box__icon">
                    <button type="button" class="btn">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                        <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                        </svg>
                    </button>
                </div>
                <div class="search-box__input">
                    <input type="text" placeholder="Search..." class="form-control"/>
                </div>
                <div class="search-box__dropdown">
                    <select class="form-select" id="inputGroupSelect01">
                        <option selected>Choose...</option>
                        <option value="1">One</option>
                        <option value="2">Two</option>
                        <option value="3">Three</option>
                    </select>
                </div>
            </div>
        </section>
        <main class="container">
            <section class="posts-section">
                <p class="posts-section_heading">Last viewed</h3>
                <div class="posts-grid">
                        <article class="post-card">
                            <div class="post-card__header">
                                <a class="post-card__title">
                                    SWE291
                                </a>
                                <span class="badge text-bg-primary">Syllabus</span>
                            </div>
                            <div class="post-card__body">
                                <p class="post-card__description">Text line</p>
                            </div>
                            <div class="post-card_footer">
                                <time class="post-card_time">Updated at March 27, 2023</time>
                            </div>
                        </article>
                    <article class="post-card">
                            <div class="post-card__header">
                                <a class="post-card__title">
                                    SWE291
                                </a>
                                <span class="badge text-bg-primary">Syllabus</span>
                            </div>
                            <div class="post-card__body">
                                <p class="post-card__description">Text line</p>
                            </div>
                            <div class="post-card_footer">
                                <time class="post-card_time">Updated at March 27, 2023</time>
                            </div>
                        </article>
                    <article class="post-card">
                            <div class="post-card__header">
                                <a class="post-card__title">
                                    SWE291
                                </a>
                                <span class="badge text-bg-primary">Syllabus</span>
                            </div>
                            <div class="post-card__body">
                                <p class="post-card__description">Text line</p>
                            </div>
                            <div class="post-card_footer">
                                <time class="post-card_time">Updated at March 27, 2023</time>
                            </div>
                        </article>
                    <article class="post-card">
                            <div class="post-card__header">
                                <a class="post-card__title">
                                    SWE291
                                </a>
                                <span class="badge text-bg-primary">Syllabus</span>
                            </div>
                            <div class="post-card__body">
                                <p class="post-card__description">Text line</p>
                            </div>
                            <div class="post-card_footer">
                                <time class="post-card_time">Updated at March 27, 2023</time>
                            </div>
                        </article>
                    <article class="post-card">
                            <div class="post-card__header">
                                <a class="post-card__title">
                                    SWE291
                                </a>
                                <span class="badge text-bg-primary">Syllabus</span>
                            </div>
                            <div class="post-card__body">
                                <p class="post-card__description">Text line</p>
                            </div>
                            <div class="post-card_footer">
                                <time class="post-card_time">Updated at March 27, 2023</time>
                            </div>
                        </article>
                </div>
            </section>
        </main>
    </body>
</html>
