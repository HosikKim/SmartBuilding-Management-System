<%--
  User: 1
  Date: 2024-11-13
  Time: 오후 4:27
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
</head>

<style>
</style>

<script>
</script>

<body>
<div id="sidebar-wrapper" data-simplebar="" data-simplebar-auto-hide="true">
    <div class="brand-logo">
        <a href="<c:url value="/"/>">
            <img src="<c:url value="/img/gunamul2.jpeg"/>" class="logo-icon" alt="logo icon">
            <h5 class="logo-text">건어물</h5>
        </a>
    </div>
    <ul class="sidebar-menu do-nicescrol">
        <li class="sidebar-header">MAIN NAVIGATION</li>
        <li>
            <a href="<c:url value="/index.html"/>">
                <i class="zmdi zmdi-view-dashboard"></i> <span>Dashboard</span>
            </a>
        </li>

        <li>
            <a href="<c:url value="/icons.html"/>">
                <i class="zmdi zmdi-invert-colors"></i> <span>UI Icons</span>
            </a>
        </li>

        <li>
            <a href="<c:url value="/forms.html"/>">
                <i class="zmdi zmdi-format-list-bulleted"></i> <span>Forms</span>
            </a>
        </li>

        <li>
            <a href="<c:url value="/tables.html"/>">
                <i class="zmdi zmdi-grid"></i> <span>Tables</span>
            </a>
        </li>

        <li>
            <a href="<c:url value="/calendar.html"/>">
                <i class="zmdi zmdi-calendar-check"></i> <span>Calendar</span>
<%-- 수정사항 생기거나 필요하다면 사용할것  <small class="badge float-right badge-light">New</small>--%>
            </a>
        </li>

        <li>
            <a href="<c:url value="/profile.html"/>">
                <i class="zmdi zmdi-face"></i> <span>Profile</span>
            </a>
        </li>

        <li>
            <a href="<c:url value="/login"/>">
                <i class="zmdi zmdi-lock"></i> <span>Login</span>
            </a>
        </li>

        <li>
            <a href="<c:url value="/register.html"/>">
                <i class="zmdi zmdi-account-circle"></i> <span>Registration</span>
            </a>
        </li>

        <li class="sidebar-header">LABELS</li>
        <li><a href="<c:url value="/javaScript:void();"/>"><i class="zmdi zmdi-coffee text-danger"></i> <span>Important</span></a></li>
        <li><a href="<c:url value="/javaScript:void();"/>"><i class="zmdi zmdi-chart-donut text-success"></i> <span>Warning</span></a></li>
        <li><a href="<c:url value="/javaScript:void();"/>"><i class="zmdi zmdi-share text-info"></i> <span>Information</span></a></li>

    </ul>

</div>

</body>
</html>