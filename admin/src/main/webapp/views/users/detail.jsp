<%--
  User: 1
  Date: 2024-11-14
  Time: 오후 5:50
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
</head>

<style>
    .info_box {
        margin-left: 25px;
    }

    .info_container {
        width: 400px;
    }

    .info_header {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .info_header a,
    .info_header h2 {
        margin: 0;
        text-align: left;
    }

    .info_header h5 {
        margin: 0;
        text-align: right;
        margin-left: auto;
    }

    .modal {
        display: none; /* 기본 상태에서 숨김 */
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.4);
    }

    .modal_head {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .modal-content {
        color: black;
        background-color: #fff;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 30%;
        border-radius: 8px;
        text-align: center;
    }

    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }

    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }

    .hover-effect {
        transition: all 0.3s ease; /* 부드러운 애니메이션 효과 */
        cursor: pointer; /* 마우스를 손가락 모양으로 변경 */
    }

    .hover-effect:hover {
        transform: scale(0.9); /* 크기를 90%로 줄임 */
    }

    /* modal_form 클래스에만 스타일 적용 */
    .modal_form {
        color: black;
        font-family: Arial, sans-serif;
        font-size: 14px;
        background-color: #f9f9f9; /* 폼 배경색 */
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 약간의 그림자 효과 */
        border: 1px solid #ddd;
    }

    /* modal_form 안의 라벨 스타일 */
    .modal_form label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
        color: #333; /* 라벨 글자 색상 */
    }

    /* modal_form 안의 입력 필드 스타일 */
    .modal_form .form-control {
        color: black;
        width: 100%;
        padding: 10px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
        font-size: 14px;
    }

    /* modal_form 입력 필드 포커스 스타일 */
    .modal_form .form-control:focus {
        color: black;
        border-color: #007bff;
        outline: none;
        box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
    }

    /* modal_form 안의 버튼 스타일 */
    .modal_form .btn {
        padding: 10px 20px;
        font-size: 14px;
        color: white;
        background-color: black;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .modal_form .btn:hover {
        background-color: #333;
    }

    .ct_content {
        margin-left: 25px;
        margin-right: 25px;
    }

    .day_content {
        margin-top: 25px;
        margin-left: 10px;
        border-bottom: 2px solid whitesmoke;
    }

    .included-features {
        font-family: Arial, sans-serif;
        margin-top: 15px;
        margin-left: 10px;
    }

    .included-features h3 {
        font-size: 16px;
        font-weight: bold;
        margin-bottom: 10px;
        color: whitesmoke;
    }

    .features-list {
        display: flex;
        gap: 10px;
        flex-wrap: wrap;
    }

    .feature-item {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 15px;
        color: whitesmoke;
        font-size: 14px;
        border: 1px solid #ccc;
        cursor: default;
    }

    /*.ct_document {*/
    /*    font-family: Arial, sans-serif;*/
    /*    padding: 20px;*/
    /*}*/

    /*.document_list {*/
    /*    border: 1px solid whitesmoke;*/
    /*    font-family: Arial, sans-serif;*/
    /*    padding: 15px;*/
    /*}*/

    .ct_document {
        width: 400px;
        padding: 25px;
        font-family: 'Nanum Gothic', Arial, sans-serif; /* 폰트 설정 */
        color: white; /* 텍스트 색상 */
    }

    .ct_document h1 {
        font-size: 24px; /* 제목 크기 */
        font-weight: bold;
        margin-bottom: 20px; /* 하단 간격 */
    }

    .ct_document .document_list h3 {
        font-size: 18px; /* 문서 항목 텍스트 크기 */
        font-weight: normal;
        margin-left: 10px; /* 아이콘과 텍스트 간격 */
        display: inline-block;
        vertical-align: middle;
    }


</style>

<script>
    let modal = {
        open: function () {
            $("#myModal").fadeIn();
        },

        close: function () {
            $("#myModal").fadeOut();
        },

        init: function () {
            const self = this;

            $("#openModalBtn").on("click", function () {
                self.open();
            });

            $(".close, #closeModalBtn").on("click", function () {
                self.close();
            });

            $(window).on("click", function (event) {
                if ($(event.target).is("#myModal")) {
                    self.close();
                }
            });
        }
    };

    let modal2 = {
        open: function () {
            $("#myModal2").fadeIn();
        },

        close: function () {
            $("#myModal2").fadeOut();
        },

        init: function () {
            const self = this;

            $("#openModalBtn2").on("click", function () {
                self.open();
            });

            $(".close, #closeModalBtn2").on("click", function () {
                self.close();
            });

            $(window).on("click", function (event) {
                if ($(event.target).is("#myModal2")) {
                    self.close();
                }
            });
        }
    };

    let modal3 = {
        open: function () {
            $("#myModal3").fadeIn();
        },

        close: function () {
            $("#myModal3").fadeOut();
        },

        init: function () {
            const self = this;

            $("#openModalBtn3").on("click", function () {
                self.open();
            });

            $(".close, #closeModalBtn3").on("click", function () {
                self.close();
            });

            $(window).on("click", function (event) {
                if ($(event.target).is("#myModal3")) {
                    self.close();
                }
            });
        }
    };

    $(function () {
        modal.init();
        modal2.init();
        modal3.init();
    })
</script>

<body class="bg-theme bg-theme1">

<!-- start loader -->
<div id="pageloader-overlay" class="visible incoming">
    <div class="loader-wrapper-outer">
        <div class="loader-wrapper-inner">
            <div class="loader"></div>
        </div>
    </div>
</div>
<!-- end loader -->

<!-- Start wrapper-->
<div id="wrapper">
    <div class="clearfix"></div>

    <div class="content-wrapper d-flex justify-content-center">
        <div class="container-fluid">
            <div>
                <div class="info_header">
                    <a href="<c:url value="/users"/>" style="font-size: 17px">< 뒤로가기</a>
                    <h2 style="margin-left: 30px">상세 정보</h2>
                    <h5>${ghtlf.room}호</h5>
                </div>
            </div>


            <div class="row" style="margin-left: 50px; margin-top: 50px; min-height: 100vh">

                <div class="row">
                    <div class="info_container">
                        <div class="card">
                            <div class="card-body">
                                <div class="card-title text-center" style="font-size: 29px">입주자 정보</div>
                                <div class="form-group text-center mt-3" style="border-bottom: 2px solid white;">
                                    <img src="/img/edit_icon_white.png" id="openModalBtn" class="hover-effect"
                                         style="width: 30px;  margin-bottom: 10px">
                                </div>

                                <div class="row" style="margin-left: 15px; margin-top: 20px">
                                    <img src="/img/shop_icon_white.png" style="width: 30px; height: 30px">
                                    <div class="info_box">
                                        <h6>상호명</h6>
                                        <h4>${ghtlf.bname}</h4>
                                    </div>
                                </div>


                                <div class="row" style="margin-left: 15px; margin-top: 20px">
                                    <img src="/img/room_icon_white.png" style="width: 30px; height: 30px">
                                    <div class="info_box">
                                        <h6>방번호</h6>
                                        <h4>${ghtlf.room}</h4>
                                    </div>
                                </div>

                                <div class="row" style="margin-left: 15px;  margin-top: 20px">
                                    <img src="/img/human_icon_white.png" style="width:30px; height: 30px">
                                    <div class="info_box">
                                        <h6>입주자 이름</h6>
                                        <h4>${ghtlf.dlfma}</h4>
                                    </div>
                                </div>

                                <div class="row" style="margin-left: 15px;  margin-top: 20px">
                                    <img src="/img/tel_white.png" style="width: 30px; height: 30px">
                                    <div class="info_box">
                                        <h6>전화번호</h6>
                                        <h4>${ghtlf.tel}</h4>
                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>

                <div style="margin-left: 50px">
                    <div class="info_container">
                        <div class="card">
                            <div class="card-body">
                                <div class="card-title text-center" style="font-size: 29px">계약 정보</div>
                                <div class="form-group text-center mt-3" style="border-bottom: 2px solid white;">
                                    <img src="/img/edit_icon_white.png" id="openModalBtn2" class="hover-effect"
                                         style="width: 30px;  margin-bottom: 10px">
                                </div>

                                <img src="/img/deposit_icon_white.png"
                                     style="width: 30px; height: 30px; margin-left: 10px">
                                <div class="row" style="justify-content: space-between; margin-top: 10px">
                                    <div class="ct_content">
                                        <h6>월세</h6>
                                        <h4>${ghtlf.dnjftp}만원</h4>
                                    </div>
                                    <div class="ct_content">
                                        <h6>보읒금</h6>
                                        <h4>${ghtlf.deposit}만원</h4>
                                    </div>
                                </div>

                                <div class="day_content">
                                    <img src="/img/day_icon_white.png" style="width: 30px; height: 30px">

                                    <h6 style="margin-top: 10px">계약기간</h6>
                                    <h4>${ghtlf.stday} ~ ${ghtlf.edday}</h4>
                                </div>

                                <div class="included-features">
                                    <h3>관리 항목</h3>
                                    <div class="features-list">
                                        <span class="feature-item">전기</span>
                                        <span class="feature-item">수도</span>
                                        <span class="feature-item">가스</span>
                                        <span class="feature-item">인터넷</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card h-100 d-flex flex-column" style="margin-left: 50px">
                    <div class="card-header">
                        <h1>계약 서류</h1>
                    </div>
                    <div class="card-body flex-grow-1">
                        <div class="ct_document">
                            <div class="document_list">
                                <div class="row align-items-center mb-3">
                                    <div class="d-flex align-items-center w-100">
                                        <img src="/img/document_icon_white.png" style="width: 30px; height: 30px; margin-right: 8px;">
                                        <h3 style="margin: 0; flex-grow: 1;">임대차 계약서</h3>
                                        <h6 id="openModalBtn3" style="margin: 0; cursor: pointer;">보기</h6>
                                    </div>
                                </div>
                                <div class="row align-items-center mb-3">
                                    <div class="d-flex align-items-center w-100">
                                        <img src="/img/document_icon_white.png" style="width: 30px; height: 30px; margin-right: 8px;">
                                        <h3 style="margin: 0; flex-grow: 1;">건물 등기부 등본</h3>
                                        <h6 style="margin: 0; cursor: pointer;">보기</h6>
                                    </div>
                                </div>
                                <div class="row align-items-center">
                                    <div class="d-flex align-items-center w-100">
                                        <img src="/img/document_icon_white.png" style="width: 30px; height: 30px; margin-right: 8px;">
                                        <h3 style="margin: 0; flex-grow: 1;">신분증 사본</h3>
                                        <h6 style="margin: 0; cursor: pointer;">보기</h6>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>
            <!--End Row-->

            <!--start overlay-->
            <div class="overlay toggle-menu"></div>
            <!--end overlay-->

        </div>

    </div>
    <!--End content-wrapper-->

    <!--Start Back To Top Button-->
    <a href="javaScript:void();" class="back-to-top"><i class="fa fa-angle-double-up"></i> </a>
    <!--End Back To Top Button-->

</div>
<!--End wrapper-->

<%-- 모달창 --%>
<div id="myModal" class="modal" style="display: none;">
    <div class="modal-content">
        <div class="modal_head">
            <h3 style="color: black">입주자 정보 수정</h3>
            <span class="close" style="margin-bottom: 30px">&times;</span>
        </div>

        <form action="/users/updatect" method="post" style="width: 300px; margin: 0 auto;" class="modal_form">
            <input type="hidden" name="ghtlfid" value="${ghtlf.ghtlfid}">

            <div class="form-group">
                <label for="bname">건물명</label>
                <input type="text" id="bname" name="bname" value="${ghtlf.bname}" class="form-control"
                       style="color: black;">
            </div>

            <div class="form-group">
                <label for="room">호실</label>
                <input type="text" id="room" name="room" value="${ghtlf.room}" class="form-control">
            </div>

            <div class="form-group">
                <label for="dlfma">입주자 이름</label>
                <input type="text" id="dlfma" name="dlfma" value="${ghtlf.dlfma}" class="form-control">
            </div>

            <div class="form-group">
                <label for="tel">전화번호</label>
                <input type="text" id="tel" name="tel" value="${ghtlf.tel}" class="form-control">
            </div>

            <div class="form-group text-center">
                <button type="submit" class="btn btn-dark">저장</button>
            </div>
        </form>

    </div>
</div>


<div id="myModal2" class="modal" style="display: none;">
    <div class="modal-content">
        <div class="modal_head">
            <h3 style="color: black">입주자 정보 수정</h3>
            <span class="close" style="margin-bottom: 30px">&times;</span>
        </div>

        <form action="/users/updatect" method="post" style="width: 300px; margin: 0 auto;" class="modal_form">
            <input type="hidden" name="ghtlfid" value="${ghtlf.ghtlfid}">

            <div class="form-group">
                <label for="stday">계약 시작일</label>
                <input type="text" id="stday" name="stday" value="${ghtlf.stday}" class="form-control"
                       style="color: black;">
            </div>

            <div class="form-group">
                <label for="edday">계약 만료일</label>
                <input type="text" id="edday" name="edday" value="${ghtlf.edday}" class="form-control">
            </div>

            <div class="form-group">
                <label for="deposit">보증금</label>
                <input type="text" id="deposit" name="deposit" value="${ghtlf.deposit}" class="form-control">
            </div>

            <div class="form-group">
                <label for="dnjftp">월세</label>
                <input type="text" id="dnjftp" name="dnjftp" value="${ghtlf.dnjftp}" class="form-control">
            </div>

            <div class="form-group text-center">
                <button type="submit" class="btn btn-dark">저장</button>
            </div>
        </form>

    </div>
</div>

<div id="myModal3" class="modal" style="display: none;">
    <div class="modal-content" style="width: 50%; margin: 5% auto; border-radius: 8px; padding: 20px; text-align: left;">
        <div class="modal_head" style="display: flex; justify-content: space-between; align-items: center;">
            <h3 style="color: black; margin: 0;">임대차계약서 미리보기</h3>
            <span class="close" style="font-size: 24px; font-weight: bold; cursor: pointer;">&times;</span>
        </div>
        <div style="margin-top: 20px; padding: 20px; border: 1px solid #ccc; border-radius: 8px; background-color: #f9f9f9;">
            <h3 style="margin: 0; font-weight: bold; text-align: center; margin-bottom: 20px;">임대차계약서</h3>
            <p>임대인 김대표(이하 "갑"이라 한다)과 임차인 ${ghtlf.dlfma}(이하 "을"이라 한다)은 다음과 같이 임대차계약을 체결한다.</p>
            <ol style="margin-left: 20px; padding-left: 20px; line-height: 1.6;">
                <li>같은 을에게 다음 부동산을 임대하고 을은 이를 임차한다.</li>
                <li>임대할 부동산의 표시: 스마트 빌딩 ${ghtlf.room}호</li>
                <li>임대차 기간: 2023-01-01부터 2024-12-31까지</li>
                <li>보증금: 금 ${ghtlf.deposit}만원</li>
                <li>차임: 월 금 ${ghtlf.dnjftp}만원</li>
            </ol>
            <p style="margin-top: 20px;">본 계약을 증명하기 위하여 계약 당사자가 이의 없음을 확인하고 각자 서명 날인 후 1통씩 보관한다.</p>
        </div>
    </div>
</div>

<%-- 모달창 끝 --%>
</body>
</html>