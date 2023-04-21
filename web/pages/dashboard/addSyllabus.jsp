
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
                    <main class="col-form-label">
                        <div class="container-lg" style="margin: 0 auto">
                            <legend>Add Syllabus</legend>
                            <form class="mt-3" id="addSyllabusForm" action="./add" method="POST" style="position: relative">
                                <!--Basic information-->
                                <span>Basic Infomation</span>
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

                                <!--Materials-->
                                <span
                                    style="margin-top: 68px; margin-bottom: 23px; display: inline-block;">Materials</span><br>

                                <div class="input-group mb-3">
                                    <label class="input-group-text" for="inputGroupFile01">Upload</label>
                                    <input type="file" style="display: block;" class="form-control" id="inputGroupFile01">
                                </div>
                                <!-- Objectives -->
                                <span
                                    style="margin-top: 68px; margin-bottom: 23px; display: inline-block;">Objectives</span><br>
                                <!-- Objectives / Course Learning Objectives (CLO)-->
                                <span style="font-size: 18px; margin-bottom: 32px; display: inline-block;">
                                    Course Learning Objectives (CLO)
                                </span>
                                <table id="ploTbl" style="width: 96%; margin-bottom: 32px;">
                                    <thead>
                                        <tr>
                                            <th style="width: 7.6%;">Name</th>
                                            <th style="width: 65%">Description</th>
                                            <th style="width: 22%; text-align: right;">Map to PLO</th>
                                            <th style="width: 5.4%;"></th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                                <div class="row g-3 align-items-center mt-1">
                                    <div class="row col-4">
                                        <div class="col-12">
                                            <label for="" class="col-form-label" style="font-size: 16px;">Name</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <input type="text" id="" name="" class="form-control">
                                        </div>
                                    </div>
                                    <div class="row col-4">
                                        <div class="col-12">
                                            <label for="" class="col-form-label" style="font-size: 16px;">Map to
                                                PLO</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <select style="color: #495057;" name="" id="" class="form-select">
                                                <option selected>Please select</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row col-2">
                                        <div class="col-12">
                                            <label for="" class="col-form-label" style="font-size: 16px;">List
                                                of CLO</label>
                                        </div>
                                        <div class="col-12">
                                            <label id="" class="btn btn-secondary">
                                                <input type="file" />
                                                <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-12">
                                        <label for="" class="col-form-label" style="font-size: 16px;">Description</label>
                                    </div>
                                    <div class="col-12" style="width: 751px; margin-top: 8px;">
                                        <textarea id="" class="form-control" name=""></textarea>
                                    </div>
                                </div>
                                <div style="margin-top: 16px;">
                                    <button type="submit" class="btn btn-primary" name="op" value=""> Add</button>
                                    <button type="submit" class="btn btn-secondary" value=""> Cancel</button>
                                </div>

                                <!--Sessions Table-->
                                <div>
                                    <span
                                        style="margin-top: 68px; margin-bottom: 23px; display: inline-block;">Sessions</span><br>
                                    <div style="margin-top: 16px;">
                                        <button type="submit" class="btn btn-primary" style="background: #0D6EFD;">
                                            <i class="fa-regular fa-square-plus"></i> Add</button>
                                        <label id="" class="btn btn-secondary" style="background: #6C757D;">
                                            <input type="file" />
                                            <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                        </label>
                                    </div>
                                </div>
                                <div class="dashboard-container">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    <input type="checkbox" />
                                                </th>
                                                <th scope="col">No</th>
                                                <th scope="col">Topic</th>
                                                <th scope="col">Learning Type</th>
                                                <th scope="col">LO</th>
                                                <th scope="col">ITU</th>
                                                <th scope="col">Material</th>
                                                <th scope="col">Included</th>
                                                <th scope="col">Edit</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>

                                <!--Questions Table-->
                                <div>
                                    <span
                                        style="margin-top: 68px; margin-bottom: 23px; display: inline-block;">Questions</span><br>
                                    <div style="margin-top: 16px;">
                                        <button type="submit" class="btn btn-primary" style="background: #0D6EFD;">
                                            <i class="fa-regular fa-square-plus"></i> Add</button>
                                        <label id="" class="btn btn-secondary" style="background: #6C757D;">
                                            <input type="file" />
                                            <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                        </label>
                                    </div>
                                </div>
                                <div class="dashboard-container">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    <input type="checkbox" />
                                                </th>
                                                <th scope="col">No</th>
                                                <th scope="col">Category</th>
                                                <th scope="col">Type</th>
                                                <th scope="col">Part</th>
                                                <th scope="col">Weight</th>
                                                <th scope="col">Completion Citerial</th>
                                                <th scope="col">Duration</th>
                                                <th scope="col">Edit</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>

                                <!--Assessents Table-->
                                <div>
                                    <span
                                        style="margin-top: 68px; margin-bottom: 23px; display: inline-block;">Assessents</span><br>
                                    <div style="margin-top: 16px;">
                                        <button type="submit" class="btn btn-primary" style="background: #0D6EFD;">
                                            <i class="fa-regular fa-square-plus"></i> Add</button>
                                        <label id="" class="btn btn-secondary" style="background: #6C757D;">
                                            <input type="file" />
                                            <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                        </label>
                                    </div>
                                </div>
                                <div class="dashboard-container">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    <input type="checkbox" />
                                                </th>
                                                <th scope="col">No</th>
                                                <th scope="col">Category</th>
                                                <th scope="col">Type</th>
                                                <th scope="col">Part</th>
                                                <th scope="col">Weight</th>
                                                <th scope="col">Completion Citerial</th>
                                                <th scope="col">Duration</th>
                                                <th scope="col">Edit</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                        </tbody>
                                    </table>
                                </div>

                                <!--Send to preview-->
                                <div class="fixed-footer">
                                    <div style="margin-left:auto;">
                                        <button type="submit" id="btn-publish" class="btn btn-primary"> Publish</button>
                                        <button type="submit" id="btn-save" class="btn btn-secondary"> Save draft</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </main>
                </div>
            </div>


            <script>

                const descriptionEditor = new Quill('#descriptionEditor', {
                    theme: 'snow'
                });

                document.getElementById("curriculum").addEventListener("change", async (e) => {
                    try {
                        const curId = e.target.value;
                        const subjects = await getSubjects(curId);
                        if (!subjects) throw new Error('');
                        const subjectSelectNode = document.getElementById('subject');
                        const preRequisiteSelectNode = document.getElementById('preRequisite');
                        
                        const htmls = subjects?.data?.map((s) => `
                              <option value="\${s.id.trim()}">\${s.id.trim()} - \${s.name}</option>
                        `).join('');
                        subjectSelectNode.innerHTML = htmls
                        subjectSelectNode.disabled = false;
                        preRequisiteSelectNode.innerHTML = '<option value="none">None</option>' + htmls;
                    } catch (e) {
                        alert('Cannot load subjects from this curriculum');
                    }
                })

                document.getElementById("addSyllabusForm").addEventListener("submit", async (e) => {
                    e.preventDefault();
                    const descriptionInput = document.getElementById("description");
                    descriptionInput.value = JSON.stringify(descriptionEditor.root.innerHTML);
                    const formData = new FormData(document.forms.addSyllabusForm);
                    const submitData = {}
                    for (const [key, value] of formData) {
                        submitData[key] = value
                    }
                    
                    console.log({submitData});
                    try {
                        const res = await fetch('${pageContext.servletContext.contextPath}/dashboard/syllabus/add', {
                            method: 'POST',
                            body: JSON.stringify(submitData)
                        });
                        const responseData = await res.json();
                        console.log({res})
                        
                        if (!res.ok) {
                            throw new Error(responseData.message)
                        }
                        
                            window.location.href= responseData.redirectUrl;
                    }
                    catch (e)  {
                        console.error("Error is " + e.message)
                    }
                    
                })

                async function getSubjects(curId) {
                    const promise = fetch('${pageContext.servletContext.contextPath}/dashboard/syllabus/get-subjects?curId=' + curId);
                    return (await promise).json();
                }
            </script>
    </body>
</html>
