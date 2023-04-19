<%-- 
    Document   : CurriculumAdd
    Created on : Apr 13, 2023, 11:20:49 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            <%@ include file="/css/style.css" %>
        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet">
        <title>Document</title>
    </head>

    <body>
        <div class="container-fluid h-100">
            <div class="row h-100">
                <div class="left col-md-2">

                </div>
                <div class="right col-md-10">
                    <header>
                        <div class="d-flex align-items-center justify-content-between container">
                            <a href="#">
                                <h3></h3>
                            </a>
                            <div class="d-flex align-items-center gap-3">
                                <div class="dropdown">
                                    <div class="dropdown-toggle" type="button" id="menu1" data-bs-toggle="dropdown"
                                         aria-expanded="false" style="margin: 0!important">
                                        <img class="rounded-circle" style="width:40px"
                                             src="https://mdbcdn.b-cdn.net/img/new/avatars/2.webp">
                                        <span class="caret"></span>
                                    </div>
                                    <ul class="dropdown-menu  dropdown-menu-end">
                                        <li><a class="dropdown-item" href="#">Setting</a></li>
                                        <li><a class="dropdown-item" href="#">Logout</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </header>
                    <hr />
                    <main class="row">
                        <div class="xxx row ms-1">
                            <legend>Add Curriculum</legend>
                            <form class="mt-4" action="<c:url value="/dashboard/curriculums/add" />">

                                <!-- Basic Infomation -->
                                <span>Basic Infomation</span>
                                <div class="row g-3 align-items-center" style="margin-top: 23px;">
                                    <div class="col-2">
                                        <label for="code" class="col-form-label" style="font-size: 16px;">Code</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                        <input type="text" name="code" id="code" class="form-control" placeholder="code" required="">
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="slug" class="col-form-label" style="font-size: 16px;">Slug</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                        <input type="text" name="splug" id="slug" class="form-control" placeholder="bit-set-k16c" required="">
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="englishName" class="col-form-label" style="font-size: 16px;">English
                                            name</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                        <input type="text" id="englishName" name="englishName" class="form-control"
                                               placeholder="Bachelor Program of Information Technology, Software Engineering Major" required="">
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="vietnameseName" class="col-form-label"
                                               style="font-size: 16px;">Vietnamese name</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                        <input type="text" id="vietnameseName" name="vietnameseName" class="form-control"
                                               placeholder="Chương trình cử nhân Công nghệ thông tin, chuyên ngành Kỹ thuật phần mềm" required="">
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="description" class="col-form-label"
                                               style="font-size: 16px;">Description</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 751px; margin-left: -40px;">
                                        <textarea class="form-control" name="description" required=""></textarea>
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="decisionNo" class="col-form-label" style="font-size: 16px;">Decision
                                            No</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                        <input type="text" id="decisionNo" name="decisionNo" class="form-control" placeholder="BIT_SE_K16C" required="">
                                    </div>
                                </div>

                                <!-- Objectives -->
                                <span
                                    style="margin-top: 68px; margin-bottom: 23px; display: inline-block;">Objectives</span><br>

                                <!-- Objectives / Program Objectives (PO) -->
                                <span style="font-size: 18px; margin-bottom: 32px; display: inline-block;">Program
                                    Objectives (PO)</span>
                                    <c:if test="${poList != null}">
                                    <table id="poTbl" style="width: 96%; margin-bottom: 32px;">
                                        <thead>
                                            <tr>
                                                <th style="width: 7.6%;">Name</th>
                                                <th style="width: 72%">Description</th>
                                                <th style="width: 20.4%;"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="po" items="${poList}">
                                                <tr>
                                                    <td style="color: #495057;">${po.name}</td>
                                                    <td>${po.description}</td>
                                                    <td>
                                                        <button name="editBtn" type="button" style="margin-left: 96%; border: none; background: none"><i class="fa-solid fa-pencil"></i></button>
                                                        <button name="cancelBtn" type="button" style="margin-left: 96%; border: none; background: none; display: none;"><i class="fa-solid fa-x"></i></button>
                                                        <a href="<c:url value="/dashboard/curriculums/add?op=remove_po&nameToDelete=${po.name}" />"><i class="fa-solid fa-trash"></i></a>
                                                    </td>
                                                </tr>
                                                <tr style="height: 18px;"></tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:if>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="row col-7">
                                        <div class="col-12">
                                            <label for="poName" class="col-form-label" style="font-size: 16px;">Name</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <input type="text" id="poName" name="poName" class="form-control" placeholder="PO3">
                                        </div>
                                    </div>
                                    <div class="row col-3">
                                        <div class="col-12">
                                            <label for="POList" class="col-form-label" style="font-size: 16px;">List
                                                of PO</label>
                                        </div>
                                        <div class="col-12">
                                            <label id="POList" class="btn btn-secondary">
                                                <input type="file" />
                                                <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-12">
                                        <label for="poDescription" class="col-form-label"
                                               style="font-size: 16px;">Description</label>
                                    </div>
                                    <div class="col-12" style="width: 751px; margin-top: 8px;">
                                        <textarea id="poDescription" class="form-control" name="poDescription"
                                                  placeholder="Mastering professional skills and soft skills of 21st century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society.)"></textarea>
                                    </div>
                                </div>
                                <div style="margin-top: 16px;">
                                    <button type="submit" class="btn btn-primary" name="op" value="add_po">Add</button>
                                    <button type="submit" class="btn btn-secondary" value="">Cancel</button>
                                </div>
                                <div class="alert alert-danger" role="alert" style="margin-top: 20px; margin-right: 4px;">
                                    PO_ERROR_MESSAGE
                                </div>

                                <!-- Objectives / Program Learning Objectives (PLO) -->
                                <span
                                    style="font-size: 18px; margin-bottom: 32px; margin-top: 55px; display: inline-block;">Program
                                    Program Learning Objectives (PLO)</span>

                                <c:if test="${ploList != null}">
                                    <table id="ploTbl" style="width: 96%; margin-bottom: 32px;">
                                        <thead>
                                            <tr>
                                                <th style="width: 7.6%;">Name</th>
                                                <th style="width: 65%">Description</th>
                                                <th style="width: 22%; text-align: right;">Map to PO</th>
                                                <th style="width: 5.4%;"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="plo" items="${ploList}" >
                                                <tr>
                                                    <td style="color: #495057;">${plo.name}</td>
                                                    <td>${plo.description}</td>
                                                    <td style="text-align: right;">${plo.mapToPO}</td>
                                                    <td>
                                                        <button name="editBtn" type="button" style="margin-left: 96%; border: none; background: none"><i class="fa-solid fa-pencil"></i></button>
                                                        <button name="cancelBtn" type="button" style="margin-left: 96%; border: none; background: none; display: none;"><i class="fa-solid fa-x"></i></button>
                                                        <a href="<c:url value="/dashboard/curriculums/add?op=remove_plo&nameToDelete=${plo.name}" />"><i class="fa-solid fa-trash"></i></a>
                                                    </td>
                                                </tr>
                                                <tr style="height: 66px;"></tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:if>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="row col-4">
                                        <div class="col-12">
                                            <label for="ploName" class="col-form-label" style="font-size: 16px;">Name</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <input type="text" id="ploName" name="ploName" class="form-control" placeholder="PLO3">
                                        </div>
                                    </div>
                                    <div class="row col-4">
                                        <div class="col-12">
                                            <label for="mapToPO" class="col-form-label" style="font-size: 16px;">Map to
                                                PO</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <select style="color: #495057;" name="mapToPO" id="mapToPO" class="form-select">
                                                <c:if test="${empty poList}" >
                                                    <option selected>Please select</option>
                                                </c:if>
                                                <c:forEach var="po" items="${poList}">
                                                    <option value="${po.name}" >${po.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row col-2">
                                        <div class="col-12">
                                            <label for="PLOList" class="col-form-label" style="font-size: 16px;">List
                                                of PLO</label>
                                        </div>
                                        <div class="col-12">
                                            <label id="PLOList" class="btn btn-secondary">
                                                <input type="file" />
                                                <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-12">
                                        <label for="ploDescription" class="col-form-label"
                                               style="font-size: 16px;">Description</label>
                                    </div>
                                    <div class="col-12" style="width: 751px; margin-top: 8px;">
                                        <textarea id="ploDescription" class="form-control" name="ploDescription"
                                                  placeholder="Mastering professional skills and soft skills of 21st century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society.)"></textarea>
                                    </div>
                                </div>
                                <div style="margin-top: 16px;">
                                    <button type="submit" class="btn btn-primary" name="op" value="add_plo">Add</button>
                                    <button type="submit" class="btn btn-secondary" value="">Cancel</button>
                                </div>
                                <div class="alert alert-danger" role="alert" style="margin-top: 20px; margin-right: 4px;">
                                    PLO_ERROR_MESSAGE
                                </div>
                                <!-- Subject -->
                                <span
                                    style="font-size: 18px; margin-bottom: 32px; margin-top: 55px; display: inline-block;">Subject</span>

                                <button type="submit" class="btn btn-primary" name="confirm" value="yes">Confirm</button>  
                            </form>
                        </div>
                    </main>
                </div>
            </div>
        </div>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
        <script>

            $(document).ready(function () {
                var oldName;
                var oldDescription;

//                var basicCode;
//                var basicSlug;
//                var basicEngName;
//                var basicViName;
//                var basicDescription;
//                var basicDescriptionNo;

//                $("button").click(function () {
//                    basicCode = $(".basicIn").find("input, textarea").eq(0).val();
//                    basicSlug = $(".basicIn").find("input, textarea").eq(1).val();
//                    basicEngName = $(".basicIn").find("input, textarea").eq(2).val();
//                    basicViName = $(".basicIn").find("input, textarea").eq(3).val();
//                    basicDescription = $(".basicIn").find("input, textarea").eq(4).val();
//                    basicDescriptionNo = $(".basicIn").find("input, textarea").eq(5).val();
//
//                    $(".basicIn").find("input, texarea").eq(0).val(basicCode);
//                    $(".basicIn").find("input, texarea").eq(1).attr('value', basicSlug);
//                    $(".basicIn").find("input, texarea").eq(2).attr('value', basicEngName);
//                    $(".basicIn").find("input, texarea").eq(3).attr('value', basicViName);
//                    $(".basicIn").find("input, texarea").eq(4).attr('value', basicDescription);
//                    $(".basicIn").find("input, texarea").eq(5).attr('value', basicDescriptionNo);
//                });

                $("#poTbl").on("click", "[name='editBtn']", function () {
                    oldName = $(this).closest("tr").find("td").eq(0).text();
                    oldDescription = $(this).closest("tr").find("td").eq(1).text();
                    var tdList = $(this).closest("tr").find("td");
                    tdList.each(function (index, element) {
                        if (index != tdList.length - 1) {
                            $(this).attr("contenteditable", "true");
                        }
                    });
                    $(this).eq(0).attr("name", "saveBtn");
                    $(this).find("i").eq(0).attr("class", "fa-solid fa-check");
                    $(this).closest("tr").find("a").eq(0).css("display", "none");
                    $(this).closest("tr").find("[name='cancelBtn']").eq(0).css("display", "block");
                });

                $("#ploTbl").on("click", "[name='editBtn']", function () {
                    oldName = $(this).closest("tr").find("td").eq(0).text();
                    oldDescription = $(this).closest("tr").find("td").eq(1).text();
                    var tdList = $(this).closest("tr").find("td:gt(0)");
                    tdList.each(function (index, element) {
                        if (index != tdList.length - 1) {
                            $(this).attr("contenteditable", "true");
                        }
                    });
                    $(this).eq(0).attr("name", "saveBtn");
                    $(this).find("i").eq(0).attr("class", "fa-solid fa-check");
                    $(this).closest("tr").find("a").eq(0).css("display", "none");
                    $(this).closest("tr").find("[name='cancelBtn']").eq(0).css("display", "block");
                });

                $("table").on("click", "[name='saveBtn']", function () {
                    var newName = $(this).closest("tr").find("td").eq(0).text();
                    var newDescription = $(this).closest("tr").find("td").eq(1).text();

                    $(this).eq(0).attr("name", "editBtn");
                    $(this).find("i").eq(0).attr("class", "fa-solid fa-pencil");
                    $(this).closest("tr").find("a").eq(0).css("display", "inline");
                    $(this).closest("tr").find("[name='cancelBtn']").eq(0).css("display", "none");

                    $(this).closest("tr").find("td:gt(0)").each(function () {
                        $(this).attr("contenteditable", "false");
                    });

                    if (newName.includes('PO')) {
                        $.ajax({
                            url: '/university-learning-materials/dashboard/curriculums/add?op=edit_po',
                            data: {
                                newName: newName,
                                newDescription: newDescription,
                                nameToEdit: oldName
                            },
                            type: 'GET'
                        });
                    } else {
                        $.ajax({
                            url: '/university-learning-materials/dashboard/curriculums/add?op=edit_plo',
                            data: {
                                newName: newName,
                                newDescription: newDescription,
                                nameToEdit: oldName
                            },
                            type: 'GET'
                        });
                    }



                }
                );

                $("table").on("click", "[name='cancelBtn']", function () {
                    $(this).closest("tr").find("td").eq(0).text(oldName);
                    $(this).closest("tr").find("td").eq(1).text(oldDescription);
                    $(this).closest("tr").find("td:gt(0)").each(function () {
                        $(this).attr("contenteditable", "false");
                    });
                    $(this).closest("tr").find("[name='saveBtn']").find("i").eq(0).attr("class", "fa-solid fa-pencil");
                    $(this).closest("tr").find("[name='saveBtn']").eq(0).attr("name", "editBtn");
//                    $(this).find("i").eq(0).attr("class", "fa-solid fa-pencil");
                    $(this).closest("tr").find("a").eq(0).css("display", "inline");
                    $(this).closest("tr").find("[name='cancelBtn']").eq(0).css("display", "none");
                });

            });

            var curriculumAPI = 'https://jsonplaceholder.typicode.com/posts';

            function start() {
                getCurriculums(function (cur) {
                    console.log(cur);
                });
            }

            start();

            //Functions

            function getCurriculums(callback) {
                fetch(curriculumAPI)
                        .then(function (response) {
                            return response.json();
                        })
                        .then(callback);
            }



            function renderCourse(course){
                var listCoursesBlock = document.querySelector('#list-course');
                var htmls = course.map(function(course){
                   return '<li>\n\
                                <h4>${course.name}</h4>\n\
                                <p>${course.description}</p>\n\
                            </li>'; 
                });
                listCoursesBlock.innerHTML = htmls.join('');
            }
            
        </script>
    </body>

</html>
