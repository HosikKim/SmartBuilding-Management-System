<%--
  User: 1
  Date: 2024-11-07
  Time: 오전 9:28
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
<div style="align-items: center">
    <div class="card-body" style="width: 300px">
        <form id="update_form">
            <div class="form-group">
                <label for="id">아이디:</label>
                <input type="text" value="${user.userId}" readonly class="form-control" id="id" name="userId">
            </div>

            <button type="button" id="update_btn" class="btn btn-primary">수정</button>
        </form>
    </div>
    <div class="row mt-4">
        <div class="col-lg-7 mb-lg-0 mb-4">
            <div class="card ">
                <div class="card-header pb-0 p-3">
                    <div class="d-flex justify-content-between">
                        <h6 class="mb-2">Sales by Country</h6>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table align-items-center ">
                        <tbody>
                        <tr>
                            <td class="w-30">
                                <div class="d-flex px-2 py-1 align-items-center">
                                    <div>
                                        <img src="<c:url value="/../assets/img/icons/flags/US.png"/>"
                                             alt="Country flag">
                                    </div>
                                    <div class="ms-4">
                                        <p class="text-xs font-weight-bold mb-0">Country:</p>
                                        <h6 class="text-sm mb-0">United States</h6>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="text-center">
                                    <p class="text-xs font-weight-bold mb-0">Sales:</p>
                                    <h6 class="text-sm mb-0">2500</h6>
                                </div>
                            </td>
                            <td>
                                <div class="text-center">
                                    <p class="text-xs font-weight-bold mb-0">Value:</p>
                                    <h6 class="text-sm mb-0">$230,900</h6>
                                </div>
                            </td>
                            <td class="align-middle text-sm">
                                <div class="col text-center">
                                    <p class="text-xs font-weight-bold mb-0">Bounce:</p>
                                    <h6 class="text-sm mb-0">29.9%</h6>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="w-30">
                                <div class="d-flex px-2 py-1 align-items-center">
                                    <div>
                                        <img src="<c:url value="/../assets/img/icons/flags/DE.png"/>"
                                             alt="Country flag">
                                    </div>
                                    <div class="ms-4">
                                        <p class="text-xs font-weight-bold mb-0">Country:</p>
                                        <h6 class="text-sm mb-0">Germany</h6>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="text-center">
                                    <p class="text-xs font-weight-bold mb-0">Sales:</p>
                                    <h6 class="text-sm mb-0">3.900</h6>
                                </div>
                            </td>
                            <td>
                                <div class="text-center">
                                    <p class="text-xs font-weight-bold mb-0">Value:</p>
                                    <h6 class="text-sm mb-0">$440,000</h6>
                                </div>
                            </td>
                            <td class="align-middle text-sm">
                                <div class="col text-center">
                                    <p class="text-xs font-weight-bold mb-0">Bounce:</p>
                                    <h6 class="text-sm mb-0">40.22%</h6>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="w-30">
                                <div class="d-flex px-2 py-1 align-items-center">
                                    <div>
                                        <img src="<c:url value="/../assets/img/icons/flags/GB.png"/>"
                                             alt="Country flag">
                                    </div>
                                    <div class="ms-4">
                                        <p class="text-xs font-weight-bold mb-0">Country:</p>
                                        <h6 class="text-sm mb-0">Great Britain</h6>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="text-center">
                                    <p class="text-xs font-weight-bold mb-0">Sales:</p>
                                    <h6 class="text-sm mb-0">1.400</h6>
                                </div>
                            </td>
                            <td>
                                <div class="text-center">
                                    <p class="text-xs font-weight-bold mb-0">Value:</p>
                                    <h6 class="text-sm mb-0">$190,700</h6>
                                </div>
                            </td>
                            <td class="align-middle text-sm">
                                <div class="col text-center">
                                    <p class="text-xs font-weight-bold mb-0">Bounce:</p>
                                    <h6 class="text-sm mb-0">23.44%</h6>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="w-30">
                                <div class="d-flex px-2 py-1 align-items-center">
                                    <div>
                                        <img src="<c:url value="/../assets/img/icons/flags/BR.png"/>"
                                             alt="Country flag">
                                    </div>
                                    <div class="ms-4">
                                        <p class="text-xs font-weight-bold mb-0">Country:</p>
                                        <h6 class="text-sm mb-0">Brasil</h6>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="text-center">
                                    <p class="text-xs font-weight-bold mb-0">Sales:</p>
                                    <h6 class="text-sm mb-0">562</h6>
                                </div>
                            </td>
                            <td>
                                <div class="text-center">
                                    <p class="text-xs font-weight-bold mb-0">Value:</p>
                                    <h6 class="text-sm mb-0">$143,960</h6>
                                </div>
                            </td>
                            <td class="align-middle text-sm">
                                <div class="col text-center">
                                    <p class="text-xs font-weight-bold mb-0">Bounce:</p>
                                    <h6 class="text-sm mb-0">32.14%</h6>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>