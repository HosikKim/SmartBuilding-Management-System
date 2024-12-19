<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
    .chat-container {
        max-width: 600px;
        margin: 0 auto;
        background: #fff;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }

    .chat-header {
        background: #075e54;
        color: white;
        padding: 15px 20px;
        border-radius: 12px 12px 0 0;
    }

    .chat-header h6 {
        margin: 0;
        color: white !important;
        font-size: 18px;
    }

    #status {
        display: inline-block;
        font-size: 14px;
        margin: 10px 0;
        padding: 5px 10px;
        background: rgba(255,255,255,0.1);
        border-radius: 15px;
        color: #075e54;
    }

    .button-container1212 {
        padding: 10px 20px;
        border-bottom: 1px solid #eee;
    }

    #connect, #disconnect {
        padding: 8px 20px;
        border-radius: 20px;
        border: none;
        font-size: 14px;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-right: 10px;
    }

    #connect {
        background-color: #075e54;
        color: white;
    }

    #connect:hover {
        background-color: #128C7E;
    }

    #disconnect {
        background-color: #f1f1f1;
        color: #333;
        border: 1px solid #ddd;
    }

    #disconnect:hover {
        background-color: #e0e0e0;
    }

    #all {
        height: 400px;
        overflow-y: auto;
        padding: 20px;
        background-color: #ECE5DD;
        display: flex;
        flex-direction: column-reverse;
    }

    .message-container {
        margin: 8px 0;
        display: flex;
        flex-direction: column;
    }

    /* 내가 보낸 메시지 */
    .user-massage {
        background-color: #DCF8C6;
        align-self: flex-end;
        max-width: 70%;
        padding: 10px 15px;
        border-radius: 15px;
        margin: 2px 0;
        font-size: 14px;
        box-shadow: 0 1px 2px rgba(0,0,0,0.1);
        position: relative;
    }

    /* 관리자가 보낸 메시지 */
    .admin-message {
        background-color: #FFFFFF;
        align-self: flex-start;
        max-width: 70%;
        padding: 10px 15px;
        border-radius: 15px;
        margin: 2px 0;
        font-size: 14px;
        box-shadow: 0 1px 2px rgba(0,0,0,0.1);
        position: relative;
    }

    #inputcontainer {
        display: flex;
        align-items: center;
        padding: 15px;
        background: #F0F0F0;
        border-radius: 0 0 12px 12px;
    }

    #alltext {
        flex: 1;
        border: none;
        padding: 12px 15px;
        border-radius: 20px;
        margin-right: 10px;
        background: white;
        font-size: 14px;
    }

    #alltext:focus {
        outline: none;
        box-shadow: 0 0 0 2px rgba(7,94,84,0.2);
    }

    #sendall {
        background-color: #075e54;
        color: white;
        border: none;
        padding: 10px 20px;
        border-radius: 20px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.2s;
    }

    #sendall:hover {
        background-color: #128C7E;
    }

    /* 스크롤바 스타일링 */
    #all::-webkit-scrollbar {
        width: 6px;
    }

    #all::-webkit-scrollbar-track {
        background: rgba(0,0,0,0.1);
    }

    #all::-webkit-scrollbar-thumb {
        background: rgba(0,0,0,0.2);
        border-radius: 3px;
    }

    /*.card {*/
    /*    border: none;*/
    /*    background: transparent;*/
    /*}*/

    .card-body1 {
        padding: 0;
        border: none;
        background: transparent;
    }
</style>

<script>
    let adminchat = {
        id: '',
        stompClient: null,
        init: function () {
            $('#connect').click(() => {
                $("#status").text("관리자에게 요청하는중...");

                setTimeout(() => {
                    $("#status").text("연결성공..곧 관리자와 대화가 시작됩니다.");

                    setTimeout(() => {
                        this.connect();
                    }, 3000);
                }, 3000);
            });
            $('#disconnect').click(() => {
                this.disconnect();
            });
            $('#sendall').click(() => {
                let msg = JSON.stringify({
                    'content1': $("#alltext").val()
                });
                $("#alltext").val("");
                this.stompClient.send('/receive/user', {}, msg);
            });
            $("#alltext").keydown((event) => {
                if (event.key === "Enter") {
                    event.preventDefault();
                    $('#sendall').click();
                    $("#alltext").val("");
                }
            });
        },
        connect: function () {
            let sid = this.id;
            let userid = '\${sessionScope.loginid.userId}';
            let socket = new SockJS('https://210.119.34.211:82/ws');
            this.stompClient = Stomp.over(socket);

            this.stompClient.connect({}, function (frame) {
                websocket.setConnected(true);
                console.log('Connected: ' + frame);

                this.subscribe('/send/userme', function (msg) {
                    const time = new Date().toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });
                    $("#all").prepend(
                        `<div class="message-container">
                            <div class="user-massage">
                                \${JSON.parse(msg.body).content1}
                                <div class="message-time">\${time}</div>
                            </div>
                         </div>`);
                });

                this.subscribe('/send/admin', function (msg) {
                    const time = new Date().toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });
                    $("#all").prepend(
                        `<div class="message-container">
                            <div class="admin-message">
                                관리자 : \${JSON.parse(msg.body).content1}
                                <div class="message-time">\${time}</div>
                            </div>
                         </div>`);
                });
            });
        },
        disconnect: function () {
            if (this.stompClient !== null) {
                this.stompClient.disconnect();
            }
            websocket.setConnected(false);
            console.log("Disconnected");
        },
        setConnected: function (connected) {
            if (connected) {
                $("#status").text("연결됨");
            } else {
                $("#status").text("연결 끊김");
            }
        }
    };
    $(function () {
        adminchat.init();
    });
</script>

<div class="container-fluid">
    <div class="chat-container">
        <div class="chat-header">
            <h6 class="m-0 font-weight-bold">관리자 1:1 채팅</h6>
        </div>

        <div class="card-body1">
            <div class="table-responsive">
                <h6 id="status">Status</h6>

                <div class="button-container1212">
                    <button id="connect">대화연결</button>
                    <button id="disconnect">대화종료</button>
                </div>

                <div id="all"></div>

                <div id="inputcontainer">
                    <input type="text" id="alltext" placeholder="메시지를 입력하세요...">
                    <button id="sendall">전송</button>
                </div>
            </div>
        </div>
    </div>
</div>

<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>

<%--<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>--%>
<%--<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>--%>
<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>--%>
<%--<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>--%>


<%--<style>--%>
<%--    /* 내가 보낸 메시지 */--%>
<%--    .user-massage {--%>
<%--        background-color: #d1f7c4; /* 연한 초록색 */--%>
<%--        text-align: right; /* 오른쪽 정렬 */--%>
<%--        padding: 10px;--%>
<%--        border-radius: 5px;--%>
<%--        margin: 5px 0;--%>
<%--    }--%>

<%--    /* 관리자가 보낸 메시지 */--%>
<%--    .admin-message {--%>
<%--        background-color: #f1f1f1; /* 연한 회색 */--%>
<%--        text-align: left; /* 왼쪽 정렬 */--%>
<%--        padding: 10px;--%>
<%--        border-radius: 5px;--%>
<%--        margin: 5px 0;--%>
<%--    }--%>

<%--    #all {--%>
<%--        height: 200px;--%>
<%--        overflow: auto;--%>
<%--        margin-top: 5px;--%>
<%--        background-color: #f0fafb;--%>
<%--    }--%>

<%--    #alltext {--%>
<%--        width: 275px;--%>
<%--    }--%>

<%--    #sendall {--%>
<%--        background-color: black;--%>
<%--        color: white;--%>
<%--        border-radius: 5px;--%>
<%--        margin-left: 5px;--%>
<%--    }--%>

<%--    #inputcontainer {--%>
<%--        margin-top: 5px;--%>
<%--    }--%>

<%--    #connect, #disconnect {--%>
<%--        display: inline-block;--%>
<%--        font-family: Arial, sans-serif;--%>
<%--        font-size: 14px;--%>
<%--        border-radius: 20px;--%>
<%--        border: none;--%>
<%--        cursor: pointer;--%>
<%--        transition: background-color 0.3s ease, color 0.3s ease;--%>
<%--        margin: 2px;--%>
<%--    }--%>

<%--    #connect {--%>
<%--        background-color: #000;--%>
<%--        color: #fff;--%>
<%--    }--%>

<%--    #connect:hover {--%>
<%--        background-color: #333;--%>
<%--    }--%>

<%--    #disconnect {--%>
<%--        background-color: #f5f5f5;--%>
<%--        color: #000;--%>
<%--        border: 1px solid #ddd;--%>
<%--    }--%>

<%--    #disconnect:hover {--%>
<%--        background-color: #e0e0e0;--%>
<%--    }--%>


<%--    .button-container1212 {--%>

<%--    }--%>

<%--    #connect, #disconnect {--%>
<%--    }--%>
<%--</style>--%>


<%--<script>--%>
<%--    let adminchat = {--%>
<%--        id: '',--%>
<%--        stompClient: null,--%>
<%--        init: function () {--%>
<%--            $('#connect').click(() => {--%>
<%--                // $("#status").text("연결중...");--%>
<%--                // setTimeout(() => {--%>
<%--                //     this.connect();--%>
<%--                // }, 2000);--%>
<%--                // 상태 메시지: "관리자에게 요청하는중..."--%>
<%--                $("#status").text("관리자에게 요청하는중...");--%>

<%--                setTimeout(() => {--%>
<%--                    // 상태 메시지: "연결성공..곧 관리자와 대화가 시작됩니다."--%>
<%--                    $("#status").text("연결성공..곧 관리자와 대화가 시작됩니다.");--%>

<%--                    setTimeout(() => {--%>
<%--                        // 연결 시작--%>
<%--                        this.connect();--%>
<%--                    }, 3000); // 3초 후 connect() 호출--%>
<%--                }, 3000); // 3초 후 첫 번째 상태 변경--%>
<%--            });--%>
<%--            $('#disconnect').click(() => {--%>
<%--                this.disconnect();--%>
<%--            });--%>
<%--            $('#sendall').click(() => {--%>
<%--                let msg = JSON.stringify({--%>
<%--                    'content1': $("#alltext").val()--%>
<%--                });--%>
<%--                $("#alltext").val(""); // 입력 필드 텍스트 클리어--%>
<%--                this.stompClient.send('/receive/user', {}, msg);--%>
<%--            });--%>
<%--            $("#alltext").keydown((event) => {--%>
<%--                if (event.key === "Enter") {--%>
<%--                    event.preventDefault();--%>
<%--                    $('#sendall').click();--%>
<%--                    $("#alltext").val(""); // 입력 필드 텍스트 클리어--%>
<%--                }--%>
<%--            });--%>
<%--        },--%>
<%--        connect: function () {--%>
<%--            let sid = this.id;--%>
<%--            let userid = '\${sessionScope.loginid.userId}';--%>
<%--            let socket = new SockJS('https://210.119.34.211:82/ws');--%>
<%--            this.stompClient = Stomp.over(socket);--%>

<%--            this.stompClient.connect({}, function (frame) {--%>
<%--                websocket.setConnected(true);--%>
<%--                console.log('Connected: ' + frame);--%>

<%--                this.subscribe('/send/userme', function (msg) {--%>
<%--                    $("#all").prepend(--%>
<%--                        "<h5 class='user-massage'>" +--%>
<%--                        JSON.parse(msg.body).content1--%>
<%--                        + "</h5>");--%>
<%--                });--%>

<%--                this.subscribe('/send/admin', function (msg) {--%>
<%--                    $("#all").prepend(--%>
<%--                        "<h5 class='admin-message'>" + "관리자 : " +--%>
<%--                        JSON.parse(msg.body).content1--%>
<%--                        + "</h5>");--%>
<%--                });--%>
<%--            });--%>
<%--        },--%>
<%--        disconnect: function () {--%>
<%--            if (this.stompClient !== null) {--%>
<%--                this.stompClient.disconnect();--%>
<%--            }--%>
<%--            websocket.setConnected(false);--%>
<%--            console.log("Disconnected");--%>
<%--        },--%>
<%--        setConnected: function (connected) {--%>
<%--            if (connected) {--%>
<%--                $("#status").text("연결됨");--%>
<%--            } else {--%>
<%--                $("#status").text("연결 끊김");--%>
<%--            }--%>
<%--        }--%>
<%--    };--%>
<%--    $(function () {--%>
<%--        adminchat.init();--%>
<%--    });--%>
<%--</script>--%>


<%--<div class="container-fluid">--%>


<%--    <!-- DataTales Example -->--%>
<%--    <div class="card shadow mb-4">--%>
<%--        <div class="card-header py-3">--%>
<%--            <h6 class="m-0 font-weight-bold text-primary"> 관리자 1:1 채팅</h6>--%>
<%--        </div>--%>
<%--        <div class="card-body">--%>
<%--            <div class="table-responsive">--%>
<%--                <h6 id="status">Status</h6>--%>

<%--                <div class="button-container1212">--%>
<%--                    <button id="connect">대화연결</button>--%>
<%--                    <button id="disconnect">대화종료</button>--%>
<%--                </div>--%>

<%--                <div id="all"></div>--%>

<%--                <div id="inputcontainer">--%>
<%--                    <input type="text" id="alltext">--%>
<%--                    <button id="sendall">전송</button>--%>
<%--                </div>--%>

<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--</div>--%>