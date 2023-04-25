
<%@page import="config.AppConfig"%>
<%@page import="entities.Curriculum"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <%@include file="/components/common/head.jspf" %>
        <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
        <script src="https://cdn.quilljs.com/1.3.6/quill.js"></script>
        <script src="https://unpkg.com/read-excel-file@5.x/bundle/read-excel-file.min.js"></script>
        <title>Add Syllabus</title>
    </head>
    <body>
        <div class="container-fluid h-100">
            <div class="row h-100">
                <div class="left col-md-2" style="background-color: rgba(5, 44, 101, 1);">
                    <h2 style="color: #FFFFFF; font-family: 'Inter'; font-size: 20px;">
                        ULM Dashboard
                    </h2>
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
                    <%
                        ArrayList<Curriculum> lsCur = (ArrayList<Curriculum>) request.getAttribute(AppConfig.DASHBOARD_CURRICULUM_LIST);
                    %>
                    <main class="col-form-label" style="margin-bottom: 100px;">
                        <div class="container-lg" style="margin: 0 auto">
                            <legend>Add Syllabus</legend>
                            <form class="mt-3" id="addSyllabusForm" action="./add" method="POST" style="position: relative">
                                <div class="accordion" id="accordionExample">
                                    <div class="accordion-item">
                                        <h2 class="accordion-header">
                                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                                Basic Information
                                            </button>
                                        </h2>
                                        <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group mb-3">
                                                            <label for="curriculum" class="col-form-label" style="font-size: 16px;">
                                                                Curriculum
                                                            </label>
                                                            <select style="color: #495057;" name="curriculum" id="curriculum" class="form-select" required>
                                                                <option value="null" selected>Select Curriculum</option>
                                                                <c:forEach var="cur" items="<%= lsCur%>">
                                                                    <option value="${cur.id}">${cur.code}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group mb-3">
                                                            <label for="subject" class="col-form-label" style="font-size: 16px;">
                                                                Subject
                                                            </label>
                                                            <select style="color: #495057;" name="subject" id="subject" class="form-select" disabled>
                                                                <option selected>Select Subject</option>
                                                            </select>
                                                            <div id="mapToPLO" class="form-text">
                                                                Please select Curriculum first.
                                                            </div>
                                                        </div>
                                                        <div class="form-group mb-3">
                                                            <label for="degreeLevel" class="col-form-label" style="font-size: 16px;">
                                                                Degree Level
                                                            </label>
                                                            <select style="color: #495057;" name="degreeLevel" id="degreeLevel" class="form-select">
                                                                <option selected>Bachelor</option>
                                                                Bachelor
                                                            </select>
                                                        </div>
                                                        <div class="form-group mb-3">
                                                            <label for="timeAllocation" class="col-form-label" style="font-size: 16px;">
                                                                Time allocation
                                                            </label>
                                                            <input type="text" id="timeAllocation" name="timeAllocation" class="form-control" required/>
                                                        </div>
                                                        <div class="form-group mb-3">
                                                            <label for="decisionNo" class="col-form-label" style="font-size: 16px;">
                                                                Decision No
                                                            </label>
                                                            <input type="text" id="decisionNo" name="decisionNo" class="form-control" required/>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group mb-3">
                                                            <label for="credit" class="col-form-label" style="font-size: 16px;">
                                                                Number of Credit
                                                            </label>
                                                            <input type="number" value="1" min="1" max="15" step="1" id="credit" name="credit" class="form-control" required/>
                                                        </div>
                                                        <div class="form-group mb-3">
                                                            <label for="minScore" class="col-form-label" style="font-size: 16px;">
                                                                Min score
                                                            </label>
                                                            <input type="number" value="0" min="0" max="10" step="0.25" id="minScore" name="minScore" class="form-control"/>
                                                        </div>
                                                        <div class="form-group mb-3">
                                                            <label for="maxScore" class="col-form-label" style="font-size: 16px;">
                                                                Max score
                                                            </label>
                                                            <input type="number" min="0" max="10" step="0.25" id="maxScore" name="maxScore" class="form-control" required/>
                                                        </div>
                                                        <div class="form-group mb-3">
                                                            <label for="preRequisite" class="col-form-label" style="font-size: 16px;">
                                                                Pre-Requisite
                                                            </label>
                                                            <select style="color: #495057;" name="preRequisite" id="preRequisite" class="form-select">
                                                                <option value="none">None</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="mb-3">
                                                    <label for="description" class="col-form-label" style="font-size: 16px;">Description</label>
                                                    <input type="hidden" name="description" id="description"/>
                                                    <div id="descriptionEditor"></div>
                                                </div>
                                                <div class="row mb-3">
                                                    <div class="col-md-6">
                                                        <label for="tasks" class="col-form-label" style="font-size: 16px;">Student
                                                            Tasks</label>
                                                        <textarea class="form-control" name="tasks"></textarea>
                                                        <label for="note" class="col-form-label" style="font-size: 16px;">Note</label>
                                                        <textarea class="form-control" name="note"></textarea>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <label for="tools" class="col-form-label" style="font-size: 16px;">Tools</label>
                                                        <textarea class="form-control" name="tools"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                                Materials
                                            </button>
                                        </h2>
                                        <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <div class="input-group mb-3">
                                                    <label class="input-group-text" for="inputGroupFile01">Upload</label>
                                                    <input type="file" style="display: block;" class="form-control" id="material-input-file">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                                Objectives
                                            </button>
                                        </h2>
                                        <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <span style="font-size: 18px; margin-bottom: 32px; display: inline-block;">
                                                    Course Learning Objectives (CLO)
                                                </span>
                                                <table id="cloTbl" width="100%">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Name</th>
                                                            <th scope="col">Description</th>
                                                            <th scope="col">Map to PLO</th>
                                                            <th scope="col">Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                                <div class="form-add row g-3 align-items-center mt-1">
                                                    <div class="row col-6" id="add-clo-form">
                                                        <div class="row" style="padding-right: 0">
                                                            <div class="col-6">
                                                                <label for="cloName" class="col-form-label" style="font-size: 16px;">Name</label>
                                                                <input type="text" id="cloName" name="cloName" class="form-control" placeholder="CLOxx...">
                                                            </div>
                                                            <div class="col-6" style="padding-right: 0">
                                                                <label for="mapToPLO" class="col-form-label" style="font-size: 16px;">Map to
                                                                    PLO</label>
                                                                <select style="color: #495057;" name="mapToPLO" id="mapToPLO" class="form-select" disabled>
                                                                    <option value="none">None</option>
                                                                </select>
                                                                <div id="mapToPLO" class="form-text">
                                                                    Please select Curriculum first.
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="">
                                                            <label for="ploDescription" class="col-form-label"
                                                                   style="font-size: 16px;">Description</label>
                                                            <textarea id="cloDescription" class="form-control" name="cloDescription"
                                                                      ></textarea>
                                                        </div>
                                                        <div style="margin-top: 16px;">
                                                            <button type="button" id="btn-add-plo" class="btn btn-primary" name="op" value="add_plo">Add</button>
                                                            <button type="submit" class="btn btn-outline-secondary" value="">Cancel</button>
                                                        </div>
                                                    </div>

                                                    <div class="row col-4">
                                                        <div class="col-12">
                                                            <label for="PLOList" class="col-form-label" style="font-size: 16px;">List
                                                                of CLO</label>
                                                        </div>
                                                        <div class="col-12">
                                                            <label id="PLOList" class="btn btn-outline-secondary">
                                                                <input type="file" />
                                                                <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="alert alert-danger" id="clo-error" role="alert" style="margin-top: 20px; margin-right: 4px; display: none;"> 
                                                    CLO_ERROR_MESSAGE
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                                Sessions
                                            </button>
                                        </h2>
                                        <div id="collapseFour" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <div>
                                                    <div style="margin-top: 16px;">
                                                        <!--                                                        <button type="submit" class="btn btn-primary" style="background: #0D6EFD;">
                                                                                                                    <i class="fa-regular fa-square-plus"></i> Add</button>-->
                                                        <label id="" class="btn btn-secondary" style="background: #6C757D;">
                                                            <input type="file" id="file-input" accept=".xlsx">
                                                            <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="container-x1">
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th style="width: 30px;" scope="col">
                                                                    <input type="checkbox" />
                                                                </th>
                                                                <th style="width: 50px;" scope="col">No</th>
                                                                <th scope="col">Topic</th>
                                                                <th scope="col">Learning Type</th>
                                                                <th scope="col">LO</th>
                                                                <th scope="col">ITU</th>
                                                                <th scope="col">Material</th>
                                                                <th scope="col">Included</th>
                                                                <th scope="col">Edit</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="excel-table-sessions">
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
                                                Questions
                                            </button>
                                        </h2>
                                        <div id="collapseFive" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <div>
                                                    <div style="margin-top: 16px;">
                                                        <!--                                                        <button type="submit" class="btn btn-primary" style="background: #0D6EFD;">
                                                                                                                    <i class="fa-regular fa-square-plus"></i> Add</button>-->
                                                        <label id="" class="btn btn-secondary" style="background: #6C757D;">
                                                            <input type="file" id="file-input2" accept=".xlsx"/>
                                                            <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="container-x1">
                                                    <table class="table table-striped">
                                                        <thead>
                                                            <tr>
                                                                <th style="width: 30px;" scope="col">
                                                                    <input type="checkbox" />
                                                                </th>
                                                                <th style="width: 50px;" scope="col">No</th>
                                                                <th scope="col">Category</th>
                                                                <th scope="col">Type</th>
                                                                <th scope="col">Part</th>
                                                                <th scope="col">Weight</th>
                                                                <th scope="col">Completion Citerial</th>
                                                                <th scope="col">Duration</th>
                                                                <th scope="col">Edit</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="excel-table-questions">
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header">
                                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
                                                Assessments
                                            </button>
                                        </h2>
                                        <div id="collapseSix" class="accordion-collapse collapse" data-bs-parent="#accordionExample">
                                            <div class="accordion-body">
                                                <div>
                                                    <div style="margin-top: 16px;">
                                                        <!--                                                        <button type="submit" class="btn btn-primary" style="background: #0D6EFD;">
                                                                                                                    <i class="fa-regular fa-square-plus"></i> Add</button>-->
                                                        <label id="" class="btn btn-secondary" style="background: #6C757D;">
                                                            <input type="file" id="file-input3"/>
                                                            <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="container-x1">
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th style="width: 30px;" scope="col">
                                                                    <input type="checkbox" />
                                                                </th>
                                                                <th style="width: 50px;" scope="col">No</th>
                                                                <th scope="col">Category</th>
                                                                <th scope="col">Type</th>
                                                                <th scope="col">Part</th>
                                                                <th scope="col">Weight</th>
                                                                <th scope="col">Completion Citerial</th>
                                                                <th scope="col">Duration</th>
                                                                <th scope="col">Edit</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="excel-table-assessments">

                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--Basic information-->


                                <!--Materials-->

                                <!-- Objectives -->

                                <!-- Objectives / Course Learning Objectives (CLO)-->


                                <!--Sessions Table-->


                                <!--Questions Table-->

                                <!--Assessents Table-->


                                <!--Send to preview-->
                                <div class="fixed-footer">
                                    <div style="margin-left:auto;">
                                        <button type="submit" id="btn-publish" class="btn btn-primary"> Publish</button>
                                        <button type="submit" id="btn-save" class="btn btn-secondary"> Save draft</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
                            <div class="offcanvas-header">
                                <h5 class="offcanvas-title" id="offcanvasExampleLabel">Edit Course Learning Objectives</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                            </div>
                            <div class="offcanvas-body edit-clo-form" id="edit-clo-form">
                                <input type="hidden" id="cloID">
                                <label for="cloName" class="col-form-label" style="font-size: 16px;">Name</label>
                                <input type="text" id="cloName" name="cloName" class="form-control" placeholder="CLOxx...">
                                <label for="mapToPLO" class="col-form-label" style="font-size: 16px;">Map to
                                    PLO</label>
                                <select style="color: #495057;" name="mapToPLO" id="mapToPLO" class="form-select">
                                    <option value="none">None</option>
                                </select>
                                <label for="ploDescription" class="col-form-label"
                                       style="font-size: 16px;">Description</label>
                                <textarea id="cloDescription" class="form-control" name="cloDescription">
                                </textarea>
                                <div class="mt-4">
                                    <button type="button" id="btn-add-plo" class="btn btn-primary" name="op" value="add_plo">Save</button>
                                    <button type="submit" class="btn btn-outline-secondary" value="">Cancel</button>
                                </div>
                            </div>
                        </div>
                    </main>
                </div>
            </div>


            <script>

                const descriptionEditor = new Quill('#descriptionEditor', {
                theme: 'snow'
                });
                $('#btn-add-plo').on('click', handleAddCLO)
                        $(document).ready(() => {
                const listCLO = cloUtils.getListFromLocalStorage();
                renderListCLO(listCLO)
                })

                        $("#cloTbl").on("click", "[name='editBtn']", renderUpdateCLOForm);
                $("#cloTbl").on("click", "[name='saveBtn']", handleSaveEdit);
                document.getElementById("curriculum").addEventListener("change", async (e) => {
                try {
                const curId = e.target.value;
                const subjects = await getSubjects(curId);
                if (!subjects) throw new Error('');
                const subjectSelectNode = document.getElementById('subject');
                const ploSelectNode = document.querySelector('select#mapToPLO');
                const preRequisiteSelectNode = document.getElementById('preRequisite');
                const htmls = subjects?.subjects?.map((s) => `
                                      <option value="\${s.id.trim()}">\${s.id.trim()} - \${s.name}</option>
                                `).join('');
                const ploOptionHtmls = subjects?.list_plo?.map((p) => `
                                      <option value="\${p.id}"  title="\${p.description}">\${p.name}</option>
                                `).join('');
                localStorage.setItem('list_plo_syllabus', JSON.stringify(subjects?.list_plo))
                        subjectSelectNode.innerHTML = htmls
                        subjectSelectNode.disabled = false;
                ploSelectNode.innerHTML = '<option value="none">None</option>' + ploOptionHtmls;
                ploSelectNode.disabled = false;
                preRequisiteSelectNode.innerHTML = '<option value="none">None</option>' + htmls;
                } catch (e) {
                console.error(e);
                alert('Cannot load subjects from this curriculum');
                }
                })

                        document.getElementById("addSyllabusForm").addEventListener("submit", async (e) => {
                e.preventDefault();
                const descriptionInput = document.getElementById("description");
                const materialInput = document.getElementById("material-input-file");
                descriptionInput.value = JSON.stringify(descriptionEditor.root.innerHTML);
                const formData = new FormData(document.forms.addSyllabusForm);
                formData.append('material', materialInput.files[0]);
                const submitData = {}
                for (const [key, value] of formData) {
                submitData[key] = value
                }

                console.log({submitData});
//                    try {
//                        const res = await fetch('${pageContext.servletContext.contextPath}/dashboard/syllabus/add', {
//                            method: 'POST',
//                            body: JSON.stringify(submitData)
//                        });
//                        const responseData = await res.json();
//                        console.log({res})
//                        
//                        if (!res.ok) {
//                            throw new Error(responseData.message)
//                        }
//                        
//                            window.location.href= responseData.redirectUrl;
//                    }
//                    catch (e)  {
//                        console.error("Error is " + e.message)
//                    }
                })

                        async function getSubjects(curId) {
                        const promise = fetch('${pageContext.servletContext.contextPath}/dashboard/syllabus/get-subjects?curId=' + curId);
                        return (await promise).json();
                        }

                function getListPLOFromLocalSyllabus() {
                return JSON.parse(localStorage.getItem('list_plo_syllabus')) || [];
                }

                const cloUtils = {
                getListFromLocalStorage: () => {
                return JSON.parse(localStorage.getItem("list_clo")) || [];
                }
                }

                function showError(message) {
                const errorShowNode = $('#clo-error');
                errorShowNode.css('display', 'block')
                        errorShowNode.text(message);
                }

                function hideError() {
                const errorShowNode = $('#clo-error');
                errorShowNode.css('display', 'none');
                }

                function handleAddCLO() {
                const addCLOForm = document.getElementById('add-clo-form');
                const nameCLONode = addCLOForm.querySelector("#cloName");
                const descriptionCLONode = addCLOForm.querySelector("#cloDescription");
                const mapToPLONode = $("select#mapToPLO option:selected");
                const mapToPLOValue = mapToPLONode.text();
                console.log({mapToPLOValue})
                        const name = nameCLONode.value;
                let listCLO = cloUtils.getListFromLocalStorage();
                if (!nameCLONode || !descriptionCLONode || !mapToPLONode) {
                showError("Missing value");
                throw new Error("Missing value");
                }

                if (!name || name.trim() == '') {

                showError("CLO name cannot be left blank, please try again!");
                } else if (!name.startsWith('CLO')) {
                showError("CLO name must follow format CLOxx, please try again!");
                } else if (mapToPLOValue == '') {
                showError("You must select PLO. Remember to select Curriculum first.!");
                } else {
                let isExist = 0;
                if (listCLO.length > 0) {
                listCLO.find(function (clo) {
                if (clo?.name === name) {
                isExist = 1;
                }
                });
                }
                if (isExist == 1) {
                showError(name + " is exist, please try another!");
                } else {
                hideError()
                        const description = descriptionCLONode.value;
                listCLO.push({
                name: name,
                        description: description,
                        mapToPLO: mapToPLOValue
                });
                renderListCLO(listCLO);
                localStorage.setItem("list_clo", JSON.stringify(listCLO));
                resetForm(addCLOForm);
                }
                }
                }

                function renderListCLO(listCLO) {
                if (!listCLO) throw new Error("Cannot render list PLO");
                const CLOTableBody = document.querySelector("#cloTbl tbody");
                const htmls = listCLO.map((clo, index) => `
                     <tr data-index="\${index}">
                        <td scope="row" style="color: #495057;">\${clo?.name}</td>
                        <td>\${clo?.description}</td>
                        <td>\${clo?.mapToPLO}</td>
                        <td>
                            <button name="editBtn" type="button" style="border: none; background: none" data-bs-toggle="offcanvas" data-bs-target="#offcanvasExample" aria-controls="offcanvasExample"><i class="fa-solid fa-pencil"></i></button>
                            <button name="cancelBtn" type="button" style="border: none; background: none; display: none;"><i class="fa-solid fa-x"></i></button>
                            <button type="button" id="btn-delete-plo" type="button" style="border: none; background: none; display: block;" ><i class="fa-solid fa-trash"></i></button>
                        </td>
                    </tr>
                `).join("");
                CLOTableBody.parentNode.style.display = 'table';
                CLOTableBody.innerHTML = htmls;
                }

                function renderUpdateCLOForm() {

                const oldName = $(this).closest("tr").find("td").eq(0).text();
                const oldDescription = $(this).closest("tr").find("td").eq(1).text();
                const oldMapToPLO = $(this).closest("tr").find("td").eq(2).text();
                const index = $(this).closest("tr").data("index");
                const editForm = document.getElementById('edit-clo-form');
                console.log({index, editForm})
                        const idInput = editForm.querySelector("#cloID")
                        const nameInput = editForm.querySelector("#cloName")
                        const selectPLOInput = editForm.querySelector("select#mapToPLO");
                const cloDescriptionInput = editForm.querySelector("#cloDescription");
                const lisPLO = getListPLOFromLocalSyllabus();
                idInput.value = index;
                nameInput.value = oldName;
                cloDescriptionInput.value = oldDescription;
                const  optionsHtmls = lisPLO.map((p, i) => `
                        <option value="\${p.id}"  title="\${p.description}" \${p.name === oldMapToPLO && 'selected'}>\${p.name}</option>
                    `).join('')
                        selectPLOInput.innerHTML = optionsHtmls
//                        element.html('');
//                        element.append(input);
                }

                function handleEditCLO(index, newName, newDescription, newMapToPLO) {

                }

                function handleSaveEdit () {
                const cloIndex = $(this).closest("tr").data("index");
                console.log({cloIndex})
                        const newName = $(this).closest("tr").find("td").find('input').val();
                const newDescription = $(this).closest("tr").find("td").find('textarea').val();
                const newMapToPLO = $(this).closest("tr").find("td").find('select#mapToPLO option:selected').text();
                const tblIDCheck = $(this).closest('table').attr('id');
                if (newName.includes('CLO') && newDescription) {
                handleEditCLO(cloIndex, newName, newDescription, newMapToPLO);
                } else {
                if (tblIDCheck.includes('plo')) {
                var errorShow = $('#plo-error');
                if (newName == '') {
                errorShow.css('display', 'block');
                errorShow.text("PLO name cannot be left blank, please try again!");
                } else {
                errorShow.css('display', 'block');
                errorShow.text("PLO name must follow format PLOxx, please try again!");
                }
                } else {
                var errorShow = $('#po-error');
                if (newName == '') {
                errorShow.css('display', 'block');
                errorShow.text("PO name cannot be left blank, please try again!");
                } else {
                errorShow.css('display', 'block');
                errorShow.text("PO name must follow format POxx, please try again!");
                }
                }
                }
                }

                function resetForm(form) {
                const formElements = form.querySelectorAll("input, select, textarea");
                for (let i = 0; i < formElements.length; i++) {
                const elementType = formElements[i].type.toLowerCase();
                if (elementType === "text" || elementType === "password" || elementType === "textarea" || elementType === "select-one" || elementType === "select-multiple") {
                formElements[i].value = "";
                } else if (elementType === "checkbox" || elementType === "radio") {
                formElements[i].checked = formElements[i].defaultChecked;
                }
                }

                form.reset();
                }


                // handle sessions-questions-assessments
                const input = document.getElementById("file-input");
                const input2 = document.getElementById("file-input2");
                const input3 = document.getElementById("file-input3");
                const sessionsTable = document.getElementById("excel-table-sessions");
                const questionsTable = document.getElementById("excel-table-questions");
                const assessmentsTable = document.getElementById("excel-table-assessments");
                input.addEventListener("change", handleFileUpload);
                input2.addEventListener("change", handleFileUpload);
                input3.addEventListener("change", handleFileUpload);
                function handleFileUpload(event){
                const file = event.target.files[0];
                console.log(file);
                const sessionsMap = {
                'No': 'no',
                        'Topic': 'topic',
                        'Learning Type': 'learningType',
                        'LO': 'lo',
                        'ITU': 'itu',
                        'Material': 'material',
                        'Included': 'included',
                        'Edit': 'edit'
                };
                const questionsMap = {
                'No': 'no',
                        'Category': 'category',
                        'Type': 'type',
                        'Part': 'part',
                        'Weight': 'weight',
                        'Complement': 'complement',
                        'Duration': 'duration',
                        'Edit': 'edit'
                };
                const assessmentsMap = {
                'No': 'no',
                        'Category': 'category',
                        'Type': 'type',
                        'Part': 'part',
                        'Weight': 'weight',
                        'Complement': 'complement',
                        'Duration': 'duration',
                        'Edit': 'edit'
                };
                readXlsxFile(file, { sheet: "S1", map: sessionsMap }).then(({ rows }) => {
                const jsonData = JSON.stringify(rows);
                console.log(jsonData);
                console.log(rows);
                if (rows) {
                rows.forEach((row) => {
                const tr = document.createElement("tr");
                const tdCheckbox = document.createElement("td");
                const checkbox = document.createElement("input");
                checkbox.type = "checkbox";
                checkbox.checked = true;
                tdCheckbox.appendChild(checkbox);
                tr.appendChild(tdCheckbox);
                const tdNo = document.createElement("td");
                tdNo.textContent = row.no;
                tr.appendChild(tdNo);
                const tdTopic = document.createElement("td");
                tdTopic.textContent = row.topic;
                tr.appendChild(tdTopic);
                const tdLearningType = document.createElement("td");
                tdLearningType.textContent = row.learningType;
                tr.appendChild(tdLearningType);
                const tdLO = document.createElement("td");
                tdLO.textContent = row.lo;
                tr.appendChild(tdLO);
                const tdITU = document.createElement("td");
                tdITU.textContent = row.itu;
                tr.appendChild(tdITU);
                const tdMaterial = document.createElement("td");
                tdMaterial.textContent = row.material;
                tr.appendChild(tdMaterial);
                const tdIncluded = document.createElement("td");
                tdIncluded.textContent = row.included;
                tr.appendChild(tdIncluded);
                const tdEdit = document.createElement("td");
                const editButton = document.createElement("button");
                editButton.textContent = "Edit";
                editButton.classList.add("btn", "btn-sm", "btn-primary");
                tdEdit.appendChild(editButton);
                tr.appendChild(tdEdit);
                sessionsTable.appendChild(tr);
                });
                }
                }).catch((error) => {
                console.log('Error:', error);
                });
                
                
                readXlsxFile(file, { sheet : "S3", map : assessmentsMap }).then(({rows}) => {
                const jsonData = JSON.stringify(rows);
                console.log(jsonData);
                console.log(rows);
                if (rows) {
                rows.forEach((row) => {
                const tr = document.createElement("tr");
                const tdCheckbox = document.createElement("td");
                const checkbox = document.createElement("input");
                checkbox.type = "checkbox";
                checkbox.checked = true;
                tdCheckbox.appendChild(checkbox);
                tr.appendChild(tdCheckbox);
                const tdNo = document.createElement("td");
                tdNo.textContent = row.no;
                tr.appendChild(tdNo);
                const tdCategory = document.createElement("td");
                tdCategory.textContent = row.category;
                tr.appendChild(tdCategory);
                const tdType = document.createElement("td");
                tdType.textContent = row.type;
                tr.appendChild(tdType);
                const tdPart = document.createElement("td");
                tdPart.textContent = row.part;
                tr.appendChild(tdPart);
                const tdWeight = document.createElement("td");
                tdWeight.textContent = row.weight;
                tr.appendChild(tdWeight);
                const tdComplement = document.createElement("td");
                tdComplement.textContent = row.complement;
                tr.appendChild(tdComplement);
                const tdDuration = document.createElement("td");
                tdDuration.textContent = row.duration;
                tr.appendChild(tdDuration);
                const tdEdit = document.createElement("td");
                const editButton = document.createElement("button");
                editButton.textContent = "Edit";
                editButton.classList.add("btn", "btn-sm", "btn-primary");
                tdEdit.appendChild(editButton);
                tr.appendChild(tdEdit);
                questionsTable.appendChild(tr);
                });
                }
                }).catch((error) => {
                console.log('Error:', error);
                });
                
                readXlsxFile(file, { sheet : "S2", map : questionsMap }).then(({rows}) => {
                const jsonData = JSON.stringify(rows);
                console.log(jsonData);
                console.log(rows);
                if (rows) {
                rows.forEach((row) => {
                const tr = document.createElement("tr");
                const tdCheckbox = document.createElement("td");
                const checkbox = document.createElement("input");
                checkbox.type = "checkbox";
                checkbox.checked = true;
                tdCheckbox.appendChild(checkbox);
                tr.appendChild(tdCheckbox);
                const tdNo = document.createElement("td");
                tdNo.textContent = row.no;
                tr.appendChild(tdNo);
                const tdCategory = document.createElement("td");
                tdCategory.textContent = row.category;
                tr.appendChild(tdCategory);
                const tdType = document.createElement("td");
                tdType.textContent = row.type;
                tr.appendChild(tdType);
                const tdPart = document.createElement("td");
                tdPart.textContent = row.part;
                tr.appendChild(tdPart);
                const tdWeight = document.createElement("td");
                tdWeight.textContent = row.weight;
                tr.appendChild(tdWeight);
                const tdComplement = document.createElement("td");
                tdComplement.textContent = row.complement;
                tr.appendChild(tdComplement);
                const tdDuration = document.createElement("td");
                tdDuration.textContent = row.duration;
                tr.appendChild(tdDuration);
                const tdEdit = document.createElement("td");
                const editButton = document.createElement("button");
                editButton.textContent = "Edit";
                editButton.classList.add("btn", "btn-sm", "btn-primary");
                tdEdit.appendChild(editButton);
                tr.appendChild(tdEdit);
                assessmentsTable.appendChild(tr);
                });
                }
                }).catch((error) => {
                console.log('Error:', error);
                });
                };

            </script>
    </body>
</html>
