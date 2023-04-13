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
                            <form class="mt-4">

                                <!-- Basic Infomation -->
                                <span>Basic Infomation</span>
                                <div class="row g-3 align-items-center" style="margin-top: 23px;">
                                    <div class="col-2">
                                        <label for="code" class="col-form-label" style="font-size: 16px;">Code</label>
                                    </div>
                                    <div class="col-5" style="width: 356px; margin-left: -40px;">
                                        <input type="text" id="code" class="form-control" placeholder="code">
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="slug" class="col-form-label" style="font-size: 16px;">Slug</label>
                                    </div>
                                    <div class="col-5" style="width: 356px; margin-left: -40px;">
                                        <input type="text" id="slug" class="form-control" placeholder="bit-set-k16c">
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="englishName" class="col-form-label" style="font-size: 16px;">English
                                            name</label>
                                    </div>
                                    <div class="col-5" style="width: 356px; margin-left: -40px;">
                                        <input type="text" id="englishName" class="form-control"
                                               placeholder="Bachelor Program of Information Technology, Software Engineering Major">
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="vietnameseName" class="col-form-label"
                                               style="font-size: 16px;">Vietnamese name</label>
                                    </div>
                                    <div class="col-5" style="width: 356px; margin-left: -40px;">
                                        <input type="text" id="vietnameseName" class="form-control"
                                               placeholder="Chương trình cử nhân Công nghệ thông tin, chuyên ngành Kỹ thuật phần mềm">
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="description" class="col-form-label"
                                               style="font-size: 16px;">Description</label>
                                    </div>
                                    <div class="col-5" style="width: 751px; margin-left: -40px;">
                                        <textarea class="form-control"></textarea>
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-2">
                                        <label for="decisionNo" class="col-form-label" style="font-size: 16px;">Decision
                                            No</label>
                                    </div>
                                    <div class="col-5" style="width: 356px; margin-left: -40px;">
                                        <input type="text" id="decisionNo" class="form-control" placeholder="BIT_SE_K16C">
                                    </div>
                                </div>

                                <!-- Objectives -->
                                <span
                                    style="margin-top: 68px; margin-bottom: 23px; display: inline-block;">Objectives</span><br>

                                <!-- Objectives / Program Objectives (PO) -->
                                <span style="font-size: 18px; margin-bottom: 32px; display: inline-block;">Program
                                    Objectives (PO)</span>
                                <table style="width: 96%; margin-bottom: 32px;">
                                    <thead>
                                        <tr>
                                            <th style="width: 7.6%;">Name</th>
                                            <th style="width: 72%">Description</th>
                                            <th style="width: 20.4%;"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td style="color: #495057;">PO01</td>
                                            <td>Having basic knowledge of social sciences, politics and law, security and
                                                defense, foundational knowledge of the IT industry & in-depth knowledge of
                                                the specialized training: techniques, methods, technologies, in-depth
                                                application areas; development trends in the world; at the same time
                                                understand the overall market, context, functions and tasks of the
                                                professions in the specialized training.</td>
                                            <td>
                                                <a href=""><i class="fa-solid fa-pencil"></i></i></a>
                                                <a href=""><i class="fa-solid fa-x"></i></a>
                                            </td>
                                        </tr>
                                        <tr style="height: 18px;"></tr>
                                        <tr>
                                            <td style="color: #495057;">PO02</td>
                                            <td>Be able to work as a full member of a professional team in the field of
                                                training: participate in designing, selecting techniques and technologies in
                                                line with development trends, solving technical problems; understand
                                                technology trends and user requirements; can do the complete solution
                                                development plan; performance management and change management in his or her
                                                part of the job; understand state policies in specialized fields.</td>
                                            <td>
                                                <a href=""><i class="fa-solid fa-pencil"></i></i></a>
                                                <a href=""><i class="fa-solid fa-x"></i></a>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="row col-7">
                                        <div class="col-12">
                                            <label for="name" class="col-form-label" style="font-size: 16px;">Name</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <input type="text" id="name" class="form-control" placeholder="PO03">
                                        </div>
                                    </div>
                                    <div class="row col-3">
                                        <div class="col-12">
                                            <label for="vietnameseName" class="col-form-label" style="font-size: 16px;">List
                                                of PO</label>
                                        </div>
                                        <div class="col-12">
                                            <label class="btn btn-secondary">
                                                <input type="file" />
                                                <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-12">
                                        <label for="description" class="col-form-label"
                                               style="font-size: 16px;">Description</label>
                                    </div>
                                    <div class="col-12" style="width: 751px; margin-top: 8px;">
                                        <textarea class="form-control"
                                                  placeholder="Mastering professional skills and soft skills of 21st century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society.)"></textarea>
                                    </div>
                                </div>
                                <div style="margin-top: 16px;">
                                    <button type="submit" class="btn btn-primary">Add</button>
                                    <button type="button" class="btn btn-secondary">Cancel</button>
                                </div>

                                <!-- Objectives / Program Learning Objectives (PLO) -->
                                <span
                                    style="font-size: 18px; margin-bottom: 32px; margin-top: 55px; display: inline-block;">Program
                                    Objectives (PO)</span>
                                <table style="width: 96%; margin-bottom: 32px;">
                                    <thead>
                                        <tr>
                                            <th style="width: 7.6%;">Name</th>
                                            <th style="width: 65%">Description</th>
                                            <th style="width: 22%; text-align: right;">Map to PO</th>
                                            <th style="width: 5.4%;"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td style="color: #495057;">PLO01</td>
                                            <td>Demonstrate basic knowledge of social sciences, politics and law, national
                                                security and defense, contributing to the formation of worldview and
                                                scientific methodology.</td>
                                            <td style="text-align: right;">PO01</td>
                                            <td>
                                                <a href=""><i class="fa-solid fa-pencil"></i></i></a>
                                                <a href=""><i class="fa-solid fa-x"></i></a>
                                            </td>
                                        </tr>
                                        <tr style="height: 66px;"></tr>
                                        <tr>
                                            <td style="color: #495057;">PLO02</td>
                                            <td>Demonstrate an entrepreneurial, creative, critical, and problem-solving
                                                mindset.</td>
                                            <td style="text-align: right;">PO02</td>
                                            <td>
                                                <a href=""><i class="fa-solid fa-pencil"></i></i></a>
                                                <a href=""><i class="fa-solid fa-x"></i></a>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="row col-4">
                                        <div class="col-12">
                                            <label for="name" class="col-form-label" style="font-size: 16px;">Name</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <input type="text" id="name" class="form-control" placeholder="PLO03">
                                        </div>
                                    </div>
                                    <div class="row col-4">
                                        <div class="col-12">
                                            <label for="name" class="col-form-label" style="font-size: 16px;">Map to
                                                PO</label>
                                        </div>
                                        <div class="col-12" style="width: 356px;">
                                            <select style="color: #495057;" id="name" class="form-select">
                                                <option selected>Please select</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row col-2">
                                        <div class="col-12">
                                            <label for="vietnameseName" class="col-form-label" style="font-size: 16px;">List
                                                of PLO</label>
                                        </div>
                                        <div class="col-12">
                                            <label class="btn btn-secondary">
                                                <input type="file" />
                                                <i class="fa-solid fa-arrow-up-from-bracket"></i> Upload
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-3 align-items-center mt-1">
                                    <div class="col-12">
                                        <label for="description" class="col-form-label"
                                               style="font-size: 16px;">Description</label>
                                    </div>
                                    <div class="col-12" style="width: 751px; margin-top: 8px;">
                                        <textarea class="form-control"
                                                  placeholder="Mastering professional skills and soft skills of 21st century citizens (thinking skills, work skills, skills in using work tools, life skills in a global society.)"></textarea>
                                    </div>
                                </div>
                                <div style="margin-top: 16px;">
                                    <button type="submit" class="btn btn-primary">Add</button>
                                    <button type="button" class="btn btn-secondary">Cancel</button>
                                </div>

                                <!-- Subject -->
                                <span
                                    style="font-size: 18px; margin-bottom: 32px; margin-top: 55px; display: inline-block;">Subject</span>
                            </form>
                        </div>
                    </main>
                </div>
            </div>
        </div>

    </body>

</html>
