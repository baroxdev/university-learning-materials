<%-- 
    Document   : detail
    Created on : Apr 6, 2023, 2:06:43 PM
    Author     : quocb
--%>

<%@page import="config.AppConfig"%>
<%@page import="entities.Curriculum"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            Curriculum cur = (Curriculum) request.getAttribute(AppConfig.CURRICULUM_ITEM);
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/components/common/head.jspf" %>
        <title><%= cur.getName()%></title>
    </head>
    <body>
        <%@include file="/components/common/header.jspf" %>
        <main class="container mt-5" id="main-content">
            <div class="row">
                <div class="col-3 sidebar" style="position:relative">
                    <nav id="navbar" class="h-100 flex-column align-items-stretch pe-4 border-end">
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

                <div class="col-9">
                    <div data-bs-spy="scroll" data-bs-target="#navbar" data-bs-smooth-scroll="true" class="scrollspy-example-2" tabindex="0"
                         >
                        <div id="item-1" style="height:100vh">
                            <span class="badge text-bg-primary">Curriculumn</span>
                            <h4 class="page-title mt-4"><%= cur.getName()%></h4>
                            <div class="d-flex align-items-center gap-5 mt-3">
                                <p class="bold"><%= cur.getCode()%></p>
                                <p><%= cur.getDecisionNo()%></p>
                            </div>
                            <h5>Description</h5>
                        </div>
                        <div id="item-2">
                            <h4 class="page-title">Objectives</h4>
                            <div id="item-2-1">
                                <h5>Program Objectives</h5>
                                <p>...</p>
                            </div>
                            <div id="item-2-2">
                                <h5>Program Learning Objectives</h5>
                                <p>...</p>
                            </div>
                        </div>
                        <div id="item-3">
                            <h4 class="page-title">Subjects</h4>
                            <p>...</p>
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
    </body>
</html>
