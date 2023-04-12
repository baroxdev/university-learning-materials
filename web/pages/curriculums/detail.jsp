<%-- 
    Document   : detail
    Created on : Apr 6, 2023, 2:06:43 PM
    Author     : quocb
--%>

<%@page import="entities.Subject"%>
<%@page import="java.util.List"%>
<%@page import="com.sun.org.glassfish.external.probe.provider.annotations.Probe"%>
<%@page import="entities.ProgramObjective"%>
<%@page import="config.AppConfig"%>
<%@page import="entities.Curriculum"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <%
            Curriculum cur = (Curriculum) request.getAttribute(AppConfig.CURRICULUM_ITEM);
            List<ProgramObjective> poList = (List) request.getAttribute(AppConfig.PO_LIST);
            List<ProgramObjective> ploList = (List) request.getAttribute(AppConfig.PLO_LIST);
//            List<Subject> subjectList = (List) request.getAttribute(AppConfig.SUBJECT_LIST);
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/components/common/head.jspf" %>
        <title><%= cur.getName()%></title>
    </head>
    <body>
        <%@include file="/components/common/header.jspf" %>
        <main class="container mt-5" id="main-content">
            <div class="row" style="column-gap: 32px;">
                <div class=" over-hamburger d-md-none flex-column d-flex align-items-center justify-content-between">
                    <div class="hamburger flex-column d-flex align-items-center justify-content-between">
                        <div class="bar"></div>
                    </div>
                </div>
                <div class="nav_mobile d-md-none">
                    <nav class="nav nav-pills flex-column">
                        <a class="nav-link" href="#item-1">Description</a>
                        <a id="nav-pa-mobile" class="nav-link" href="#item-2">Objectives</a>
                        <a class="nav-link ms-3 my-1 nav-chi-mobile" href="#item-2-1">Program Objectives</a>
                        <a class="nav-link ms-3 my-1 nav-chi-mobile" href="#item-2-2">Program Learning Objectives</a>
                        <a class="nav-link" href="#item-3">Subjects</a>
                    </nav>
                </div>
                <div class="col-3 sidebar" style="position:relative">
                    <nav id="navbar" class="h-100 flex-column align-items-stretch">
                        <nav class="nav nav-pills flex-column">
                            <a class="nav-link" href="#item-1">Description</a>
                            <a class="nav-link" href="#item-2">Objectives</a>
                            <nav class="nav nav-pills flex-column">
                                <a class="nav-link ms-3 my-1" href="#item-2-1">Program Objectives</a>
                                <a class="nav-link ms-3 my-1" href="#item-2-2">Program Learning Objectives</a>
                            </nav>
                            <a class="nav-link" href="#item-3">Subjects</a>
                        </nav>
                    </nav>
                </div>
                <button class="hamburger_btn">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <div class="col-md-8 col-12 text-content">
                    <div data-bs-spy="scroll" data-bs-target="#navbar" data-bs-smooth-scroll="true" class="scrollspy-example-2" tabindex="0"
                         >
                        <div id="item-1">
                            <span class="badge text-bg-primary">Curriculumn</span>
                            <h4 class="page-title mt-4"><%= cur.getName()%></h4>
                            <div class="d-flex align-items-center gap-5 mt-3">
                                <p class="bold"><%= cur.getCode()%></p>
                                <p><%= cur.getDecisionNo()%></p>
                            </div>
                            <h4 class="page-title">Description</h4>
                            <div class="d-flex align-items-center gap-5 mt-3">
                                <p><%= cur.getDescription()%></p>
                            </div>
                        </div>
                        <div id="item-2">
                            <h4 class="page-title">Objectives</h4>
                            <div id="item-2-1">
                                <h5>1. Program Objectives</h5>
                                <div class="objective-container">
                                    <c:forEach var="po" items="<%= poList%>" varStatus="item">
                                        <div class="objective-card">
                                            <div class="col-md-1 d-flex align-items-center">
                                                <div class="rounded-badge">${item.index + 1}</div>
                                            </div>
                                            <div class="col-md-11">
                                                <div class="card-body">
                                                    ${po.description}
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                            <br/>
                            <div id="item-2-2">
                                <h5>2.Program Learning Objectives</h5>
                                <div class="objective-container">
                                    <c:forEach var="plo" items="<%= ploList%>" varStatus="item">
                                        <div class="objective-card">
                                            <div class="col-md-1 d-flex align-items-center">
                                                <div class="rounded-badge">${item.index + 1}</div>
                                            </div>
                                            <div class="col-md-11">
                                                <div class="card-body">
                                                    ${plo.description}
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <br/>
                        <div id="item-3">
                            <h4 class="page-title">Subjects</h4>
                            <table class="table table-striped table-bordered">
                                <thead class="table-info">
                                    <tr>
                                        <th>Id</th>
                                        <th>Name</th>
                                        <th>CreatedAt</th>
                                        <th>UpdatedAt</th>
                                        <th>PreRequisite</th>
                                        <th>Semester</th>
                                        <th>Credit</th>
                                        <th>KnowlegdeCategoryID</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="sub" items="">
                                        <tr>
                                            <td>${sub.id}</td>
                                            <td>${sub.name}</td>
                                            <td>${sub.createdAt}</td>
                                            <td>${sub.updatedAt}</td>
                                            <td>${sub.preRequisite}</td>
                                            <td>${sub.semester}</td>
                                            <td>${sub.credit}</td>
                                            <td>${sub.knowlegdeCategoryID}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </div>       
        </main>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sticky-sidebar/3.3.1/sticky-sidebar.min.js" integrity="sha512-iVhJqV0j477IrAkkzsn/tVJWXYsEqAj4PSS7AG+z1F7eD6uLKQxYBg09x13viaJ1Z5yYhlpyx0zLAUUErdHM6A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script type="text/javascript">
            var sidebar = new StickySidebar('#navbar', {
                containerSelector: '#main-content',
                innerWrapperSelector: '.sidebar',
                topSpacing: 20,
                bottomSpacing: 20
            });
        </script>

        <!-- Hamburgur button and navbar animation ( open and close) -->
        <script>
            const menu_btn = document.querySelector('.hamburger');
            const nav_mobile = document.querySelector('.nav_mobile');

            menu_btn.addEventListener('click', function () {
                menu_btn.classList.toggle('is-active');
                nav_mobile.classList.toggle('is-active');
            });
        </script>

        <!-- Navbar_mobile click animation -->
        <script type="text/javascript">
            $(document).ready(function () {
                $('.nav_mobile a').on('click', function () {
                    if ($(this).context.className.indexOf('nav-chi-mobile') > 0) {
                        $(this).siblings().removeClass('is-active');
                        $(this).addClass('is-active');
                        const xxx = document.getElementById("nav-pa-mobile");
                        xxx.classList.add('is-active');
                    } else {
                        $(this).siblings().removeClass('is-active');
                        $(this).addClass('is-active');
                    }

                })
            });
        </script>
    </body>
</html>
