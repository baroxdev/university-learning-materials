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
        <div class="container-fluid h-100" id="add-curriculum-page">
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
                            <form class="mt-4" action="<c:url value="/dashboard/curriculums/add" />" method="POST">

                                <!-- Basic Infomation -->
                                <span>Basic Infomation</span>
                                <div class="row g-3 align-items-center" style="margin-top: 23px;">
                                    <div class="col-2">
                                        <label for="code" class="col-form-label" style="font-size: 16px;">Code</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                        <input type="text" name="code" id="code" class="form-control" placeholder="BIT_SE_K16C">
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="slug" class="col-form-label" style="font-size: 16px;">Slug</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                        <input type="text" name="splug" id="slug" class="form-control" placeholder="bit-se-k16c">
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="englishName" class="col-form-label" style="font-size: 16px;">English
                                            name</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                        <input type="text" id="englishName" name="englishName" class="form-control"
                                               placeholder="Bachelor Program of Information Technology, Software Engineering Major">
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="vietnameseName" class="col-form-label"
                                               style="font-size: 16px;">Vietnamese name</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                        <input type="text" id="vietnameseName" name="vietnameseName" class="form-control"
                                               placeholder="Chương trình cử nhân Công nghệ thông tin, chuyên ngành Kỹ thuật phần mềm">
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="description" class="col-form-label"
                                               style="font-size: 16px;">Description</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 751px; margin-left: -40px;">
                                        <textarea class="form-control" id="description" name="description"></textarea>
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="decisionNo" class="col-form-label" style="font-size: 16px;">Decision
                                            No</label>
                                    </div>
                                    <div class="col-5 basicIn" style="width: 356px; margin-left: -40px;">
                                        <input type="text" id="decisionNo" name="decisionNo" class="form-control" placeholder="BIT_SE_K16C">
                                    </div>
                                </div>
                                <div class="alert alert-danger" id="basic-error" role="alert" style="margin-top: 20px; margin-right: 4px; display: none;">
                                    BASIC_INFO_ERROR_MESSAGE
                                </div>

                                <!-- Objectives -->
                                <span
                                    style="margin-top: 68px; margin-bottom: 23px; display: inline-block;">Objectives</span><br>

                                <!-- Objectives / Program Objectives (PO) -->
                                <span style="font-size: 18px; margin-bottom: 32px; display: inline-block;">Program
                                    Objectives (PO)</span>
                                <table id="poTbl" style="width: 96%; margin-bottom: 32px; display:none;">
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
                                                        <%--<a href="<c:url value="/dashboard/curriculums/add?op=remove_po&nameToDelete=${po.name}" />"><i class="fa-solid fa-trash"></i></a>--%>
                                                    <button type="button" id="btn-delete-po" type="button" style="margin-left: 96%; border: none; background: none; display: none;"><i class="fa-solid fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr style="height: 18px;"></tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <div class="row g-3 align-items-center mt-1">
                                    <div class="row col-7" id="add-po-form">
                                        <div class="col-12">
                                            <label for="poName" class="col-form-label" style="font-size: 16px;">Name</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <input type="text" id="poName" name="poName" class="form-control" placeholder="PO3">
                                        </div>
                                        <div class="row g-3 align-items-center mt-1">
                                            <div class="col-12">
                                                <label for="poDescription" class="col-form-label"
                                                       style="font-size: 16px;">Description</label>
                                            </div>
                                            <div class="col-12" style="width: 751px; margin-top: 8px;">
                                                <textarea id="poDescription" class="form-control" name="poDescription"
                                                          ></textarea>
                                            </div>
                                            <div style="margin-top: 16px;">
                                                <button type="button" class="btn btn-primary" id="btn-add-po" name="op" value="add_po">Add</button>
                                                <button type="button" class="btn btn-secondary" value="">Cancel</button>
                                            </div>
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



                                <div class="alert alert-danger" id="po-error" role="alert" style="margin-top: 20px; margin-right: 4px; display: none;">
                                    PO_ERROR_MESSAGE
                                </div>

                                <!-- Objectives / Program Learning Objectives (PLO) -->
                                <span
                                    style="font-size: 18px; margin-bottom: 32px; margin-top: 55px; display: inline-block;">Program
                                    Program Learning Objectives (PLO)</span>

                                <table id="ploTbl" style="width: 96%; margin-bottom: 32px; display:none;">
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
                                                        <%--<a href="<c:url value="/dashboard/curriculums/add?op=remove_plo&nameToDelete=${plo.name}" />"><i class="fa-solid fa-trash"></i></a>--%>
                                                    <button type="button" id="btn-delete-plo" type="button" style="margin-left: 96%; border: none; background: none; display: none;"><i class="fa-solid fa-trash"></i></button>
                                                </td>
                                            </tr>
                                            <tr style="height: 66px;"></tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <div class="row g-3 align-items-center mt-1" id="add-plo-form"> 
                                    <div class="row col-4" >
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
                                    <div class="row g-3 align-items-center mt-1">
                                        <div class="col-12">
                                            <label for="ploDescription" class="col-form-label"
                                                   style="font-size: 16px;">Description</label>
                                        </div>
                                        <div class="col-12" style="width: 751px; margin-top: 8px;">
                                            <textarea id="ploDescription" class="form-control" name="ploDescription"
                                                      ></textarea>
                                        </div>
                                    </div>
                                    <div style="margin-top: 16px;">
                                        <button type="button" id="btn-add-plo" class="btn btn-primary" name="op" value="add_plo">Add</button>
                                        <button type="submit" class="btn btn-secondary" value="">Cancel</button>
                                    </div>
                                </div>
                                <div class="alert alert-danger" id="plo-error" role="alert" style="margin-top: 20px; margin-right: 4px; display: none;"> 
                                    PLO_ERROR_MESSAGE
                                </div>
                                <!-- Subject -->
                                <span style="font-size: 18px; margin-bottom: 32px; margin-top: 55px; display: inline-block;">Subject</span>
                                <br/>
                                <button id="btn-submit" type="button" class="btn btn-primary" name="confirm">Submit</button>  
                                <div class="alert alert-danger" id="submit-error" role="alert" style="margin-top: 20px; margin-right: 4px; display: none;"> 
                                    PLO_ERROR_MESSAGE
                                </div>
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
                $("#btn-submit").click(function () {
                    handleSubmit();
                });
                $("#poTbl").on("click", "[name='editBtn']", function () {
                    oldName = $(this).closest("tr").find("td").eq(0).text();
                    oldDescription = $(this).closest("tr").find("td").eq(1).text();
//                    var tdList = $(this).closest("tr");
                    var tdList = $(this).closest("tr").find("td");
                    tdList.each(function (index, element) {
                        if (index != tdList.length - 1) {
                            $(this).attr("contenteditable", "true");
                        }
                    });
                    $(this).eq(0).attr("name", "saveBtn");
                    $(this).find("i").eq(0).attr("class", "fa-solid fa-check");
                    $(this).closest("tr").find("#btn-delete-po").eq(0).css("display", "none");
                    $(this).closest("tr").find("[name='cancelBtn']").eq(0).css("display", "block");
                });
                $("#ploTbl").on("click", "[name='editBtn']", function () {
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
                    $(this).closest("tr").find("#btn-delete-plo").eq(0).css("display", "none");
                    $(this).closest("tr").find("[name='cancelBtn']").eq(0).css("display", "block");
                });
                $("table").on("click", "[name='saveBtn']", function () {
                    var newName = $(this).closest("tr").find("td").eq(0).text();
                    var newDescription = $(this).closest("tr").find("td").eq(1).text();
                    var newMapToPO;
                    $(this).eq(0).attr("name", "editBtn");
                    $(this).find("i").eq(0).attr("class", "fa-solid fa-pencil");
                    $(this).closest("tr").find("#btn-delete-po, #btn-delete-plo").eq(0).css("display", "block");
                    $(this).closest("tr").find("[name='cancelBtn']").eq(0).css("display", "none");
                    $(this).closest("tr").find("td:gt(0)").each(function () {
                        $(this).attr("contenteditable", "false");
                    });
                    if (newName.includes('PO')) {
                        handleEditPO(oldName, newName, newDescription);
                    } else {
                        newMapToPO = $(this).closest("tr").find("td").eq(2).text();
                        handleEditPLO(oldName, newName, newDescription, newMapToPO);
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
                    $(this).closest("tr").find("#btn-delete-po, #btn-delete-plo").eq(0).css("display", "block");
                    $(this).closest("tr").find("[name='cancelBtn']").eq(0).css("display", "none");
                });
                $('table').on("click", "#btn-delete-po", function () {
                    const addPOForm = $('#add-po-form');
                    const name = $(this).closest("tr").find("td").eq(0).text();
                    let listPO = getListPOFromLocalStorage();
                    listPO = listPO.filter(po => po.name != name);
                    renderListPO(listPO, addPOForm);
                    localStorage.setItem("list_po", JSON.stringify(listPO));
                    updatePLOMapPOOptions(listPO)
                });
                $('table').on("click", "#btn-delete-plo", function () {
                    const addPLOForm = $('#add-po-form');
                    const name = $(this).closest("tr").find("td").eq(0).text();
                    let listPLO = getListPLOFromLocalStorage();
                    listPLO = listPLO.filter(plo => plo.name != name);
                    renderListPLO(listPLO, addPLOForm);
                    localStorage.setItem("list_plo", JSON.stringify(listPLO));
                });
            });
            window.addEventListener("load", () => {
                let listPO = getListPOFromLocalStorage();
                let listPLO = getListPLOFromLocalStorage();
                renderBasicInf();
                renderListPO(listPO);
                renderListPLO(listPLO);
                updatePLOMapPOOptions(listPO);
            });
            document.getElementById("btn-add-po").addEventListener("click", handleAddPO);
            document.getElementById("btn-add-plo").addEventListener("click", handleAddPLO);
            function getListPOFromLocalStorage() {
                let listPO = JSON.parse(localStorage.getItem("list_po"));
                if (listPO === null) {
                    listPO = [];
                }

                return listPO;
            }

            function getListPLOFromLocalStorage() {
                let listPLO = JSON.parse(localStorage.getItem("list_plo"));
                if (listPLO === null) {
                    listPLO = [];
                }

                return listPLO;
            }

            function handleAddPO() {
                const addPOForm = document.getElementById('add-po-form');
                const namePONode = addPOForm.querySelector("#poName");
                const descriptionPONode = addPOForm.querySelector("#poDescription");
                const name = namePONode.value;
                var errorShow = $('#po-error');
                if (!namePONode) {
                    throw new Error("Missing value");
                }

                if (name == '') {
                    errorShow.css('display', 'block');
                    errorShow.text("Name cannot be left blank, please try again!");
                } else if (!name.includes('PO')) {
                    errorShow.css('display', 'block');
                    errorShow.text("Name is invalid, please try again!");
                } else {                    
                    errorShow.css('display', 'none');
                    let listPO = getListPOFromLocalStorage();
                    const description = descriptionPONode.value;
                    listPO.push({
                        name: name,
                        description: description
                    });
                    console.log({name, description});
                    renderListPO(listPO, addPOForm);
                    localStorage.setItem("list_po", JSON.stringify(listPO));
                    updatePLOMapPOOptions(listPO);
                    resetAddPOForm(addPOForm);
                }
            }

            function handleAddPLO() {
                const addPLOForm = document.getElementById('add-plo-form');
                const namePLONode = addPLOForm.querySelector("#ploName");
                const descriptionPLONode = addPLOForm.querySelector("#ploDescription");
                const mapToPONode = $("#mapToPO option:selected");
                const name = namePLONode.value;
                const description = descriptionPLONode.value;
                const mapToPO = mapToPONode.text();
                var errorShow = $('#plo-error');
                if (!namePLONode || !descriptionPLONode || !mapToPONode) {
                    throw new Error("Missing value");
                }

                if (name == '') {
                    errorShow.css('display', 'block');
                    errorShow.text("Name cannot be left blank, please try again!");
                } else if (!name.includes('PLO')) {
                    errorShow.css('display', 'block');
                    errorShow.text("Name is invalid, please try again!");
                } else if (mapToPO == '') {
                    errorShow.css('display', 'block');
                    errorShow.text("Please create a new PO before!");
                } else {
                    errorShow.css('display', 'none');
                    let listPLO = getListPLOFromLocalStorage();
                    listPLO.push({
                        name: name,
                        description: description,
                        mapToPO: mapToPO
                    })
                    console.log({name, description, mapToPO});
                    renderListPLO(listPLO, addPLOForm);
                    localStorage.setItem("list_plo", JSON.stringify(listPLO));
                    resetAddPLOForm(addPLOForm);
                }
            }

            function handleEditPO(oldName, newName, newDescription) {
                const addPOForm = document.getElementById('add-po-form');
                let listPO = getListPOFromLocalStorage();
                let poElement = listPO.find(po => po.name === oldName);
                poElement.name = newName;
                poElement.description = newDescription;
                renderListPO(listPO, addPOForm);
                localStorage.setItem("list_po", JSON.stringify(listPO));
                updatePLOMapPOOptions(listPO)
            }

            function handleEditPLO(oldName, newName, newDescription, newMapToPO) {
                const addPLOForm = document.getElementById('add-plo-form');
                let listPLO = getListPLOFromLocalStorage();
                let ploElement = listPLO.find(plo => plo.name === oldName);
                ploElement.name = newName;
                ploElement.description = newDescription;
                ploElement.mapToPO = newMapToPO;
                renderListPLO(listPLO, addPLOForm);
                localStorage.setItem("list_plo", JSON.stringify(listPLO));
            }

            function updatePLOMapPOOptions(listPO) {
                const selectNode = document.getElementById("mapToPO");
                if (!selectNode || !listPO)
                    return console.error("Cannot update list PO options");
                const htmls = listPO.map((po, index) => `
                     <option value="\${po.name}">\${po.name}</option>
                `).join("");
                selectNode.innerHTML = htmls;
            }

            function renderListPO(listPO, POFormNode) {
                if (!listPO)
                    throw new Error("Cannot render list PO");
                const POTableBody = document.querySelector("#poTbl tbody");
                const htmls = listPO.map((po, index) => `
                     <tr>
                        <td style="color: #495057;">\${po?.name}</td>
                        <td>\${po?.description}</td>
                        <td>
                            <button name="editBtn" type="button" style="margin-left: 96%; border: none; background: none"><i class="fa-solid fa-pencil"></i></button>
                            <button name="cancelBtn" type="button" style="margin-left: 96%; border: none; background: none; display: none;"><i class="fa-solid fa-x"></i></button>
                            <button type="button" id="btn-delete-po" type="button" style="margin-left: 96%; border: none; background: none; display: block;"><i class="fa-solid fa-trash"></i></button>
                        </td>
                    </tr>
                `).join("");
                POTableBody.parentNode.style.display = 'block';
                POTableBody.innerHTML = htmls;
            }

            function renderListPLO(listPLO, PLOFormNode) {
                if (!listPLO)
                    throw new Error("Cannot render list PLO");
                const PLOTableBody = document.querySelector("#ploTbl tbody");
                const htmls = listPLO.map((plo, index) => `
                     <tr>
                        <td style="color: #495057;">\${plo?.name}</td>
                        <td>\${plo?.description}</td>
                        <td style="text-align: right;">\${plo?.mapToPO}</td>
                        <td>
                            <button name="editBtn" type="button" style="margin-left: 96%; border: none; background: none"><i class="fa-solid fa-pencil"></i></button>
                            <button name="cancelBtn" type="button" style="margin-left: 96%; border: none; background: none; display: none;"><i class="fa-solid fa-x"></i></button>
                            <button type="button" id="btn-delete-plo" type="button" style="margin-left: 96%; border: none; background: none; display: block;"><i class="fa-solid fa-trash"></i></button>
                        </td>
                    </tr>
                `).join("");
                PLOTableBody.parentNode.style.display = 'block';
                PLOTableBody.innerHTML = htmls;
            }

            function renderBasicInf() {
                var basicCode = localStorage.getItem("basicCode");
                var basicSlug = localStorage.getItem("basicSlug");
                var basicEnglishName = localStorage.getItem("basicEnglishName");
                var basicVietnameseName = localStorage.getItem("basicVietnameseName");
                var basicDescription = localStorage.getItem("basicDescription");
                var basicDecisionNo = localStorage.getItem("basicDecisionNo");
                if (basicCode == null) {
                    $('#code').val('');
                } else {
                    $('#code').val(JSON.parse(basicCode));
                }
                if (basicSlug == null) {
                    $('#slug').val('');
                } else {
                    $('#slug').val(JSON.parse(basicSlug));
                }
                if (basicEnglishName == null) {
                    $('#englishName').val('');
                } else {
                    $('#englishName').val(JSON.parse(basicEnglishName));
                }
                if (basicVietnameseName == null) {
                    $('#vietnameseName').val('');
                } else {
                    $('#vietnameseName').val(JSON.parse(basicVietnameseName));
                }
                if (basicDescription == null) {
                    $('#description').val('');
                } else {
                    $('#description').val(JSON.parse(basicDescription));
                }
                if (basicDecisionNo == null) {
                    $('#decisionNo').val('');
                } else {
                    $('#decisionNo').val(JSON.parse(basicDecisionNo));
                }
            }

            function resetAddPOForm(POFormNode) {
                const nameNode = POFormNode.querySelector("#poName");
                const descriptionNode = POFormNode.querySelector("#poDescription");
                nameNode.value = "";
                descriptionNode.value = "";
            }

            function resetAddPLOForm(PLOFormNode) {
                const nameNode = PLOFormNode.querySelector("#ploName");
                const descriptionNode = PLOFormNode.querySelector("#ploDescription");
                nameNode.value = "";
                descriptionNode.value = "";
            }

            function resetBasicInfo(basicCode, basicSlug, basicEnglishName, basicVietnameseName, basicDescription, basicDecisionNo) {
                localStorage.setItem("basicCode", JSON.stringify(basicCode));
                localStorage.setItem("basicEnglishName", JSON.stringify(basicEnglishName));
                localStorage.setItem("basicVietnameseName", JSON.stringify(basicVietnameseName));
                localStorage.setItem("basicDescription", JSON.stringify(basicDescription));
                localStorage.setItem("basicDecisionNo", JSON.stringify(basicDecisionNo));
                localStorage.setItem("basicSlug", JSON.stringify(basicSlug));
            }

            async function handleSubmit() {
                var basicCode = $('#code').val();
                var basicSlug = $('#slug').val();
                var basicEnglishName = $('#englishName').val();
                var basicVietnameseName = $('#vietnameseName').val();
                var basicDescription = $('#description').val();
                var basicDecisionNo = $('#decisionNo').val();
                let listPO = getListPOFromLocalStorage();
                let listPLO = getListPLOFromLocalStorage();
                var errorShow = $('#basic-error');
                var errorShowSubmit = $('#submit-error');
                var invalid = 0;

                resetBasicInfo(basicCode, basicSlug, basicEnglishName, basicVietnameseName, basicDescription, basicDecisionNo);

                if (basicCode == '') {
                    errorShow.css('display', 'block');
                    errorShow.text("Code cannot be left blank, please try again!");
                    invalid++;
                } else {
                    errorShow.css('display', 'none');
                }
                
                if (listPO.length == 0 || listPLO.length == 0) {
                    errorShowSubmit.css('display', 'block');
                    errorShowSubmit.text("Please create a new PO and PLO before!");
                    invalid++;
                } else {
                    errorShowSubmit.css('display', 'none');
                }

                if (invalid == 0) {
                    const jsonSubmit = JSON.stringify({
                        code: basicCode,
                        name: basicEnglishName,
                        description: basicDescription,
                        decisionNo: basicDecisionNo,
                        viName: basicVietnameseName,
                        poList: listPO,
                        ploList: listPLO
                    });

                    var currAPI = '${pageContext.request.servletContext.contextPath}/dashboard/curriculums/add';

                    var options = {
                        method: "POST",
                        headers: {"Content-Type": "application/json"},
                        body: jsonSubmit
                    };

                    try {
                        await fetch(currAPI, options);
                        localStorage.clear();
                        window.location.href = '${pageContext.request.servletContext.contextPath}/dashboard/curriculums';
                    } catch (e) {
                        console.log('error when add new cur');
                    }
                }
            }

        </script>
    </body>

</html>
