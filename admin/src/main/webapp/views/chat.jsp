<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 웹소켓 라이브러리--%>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>

<!-- jQuery, Popper, Bootstrap from CDN -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

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
        font-size: 18px;
        font-weight: 500;
    }

    #status {
        display: inline-block;
        font-size: 14px;
        margin: 0;
        padding: 5px 10px;
        background: rgba(255,255,255,0.1);
        border-radius: 15px;
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

    .user-massage {
        background-color: #DCF8C6;
        align-self: flex-start;
        max-width: 70%;
        padding: 10px 15px;
        border-radius: 15px;
        margin: 2px 0;
        font-size: 14px;
        box-shadow: 0 1px 2px rgba(0,0,0,0.1);
        position: relative;
        color: #000000;
    }

    .admin-message {
        background-color: #FFFFFF;
        align-self: flex-end;
        max-width: 70%;
        padding: 10px 15px;
        border-radius: 15px;
        margin: 2px 0;
        font-size: 14px;
        box-shadow: 0 1px 2px rgba(0,0,0,0.1);
        position: relative;
        color: #000000;
    }

    .chat-input-container {
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

    .message-time {
        font-size: 11px;
        color: #999;
        margin-top: 4px;
        text-align: right;
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
</style>

<script>
    let websocket = {
        id: '',
        stompClient: null,
        init: function () {
            this.id = $('#adm_id').text();
            $('#connect').click(() => {
                this.connect();
            });

            $('#disconnect').click(() => {
                this.disconnect();
            });

            $('#alltext').keydown((event) => {
                if (event.key === "Enter") {
                    event.preventDefault();
                    $('#sendall').click();
                    $("#alltext").val("");
                }
            });

            $('#sendall').click(() => {
                let msg = JSON.stringify({
                    'content1': $("#alltext").val()
                });
                $("#alltext").val("");
                this.stompClient.send("/receive/admin", {}, msg);
            });
        },
        connect: function () {
            let sid = this.id;
            let socket = new SockJS('https://210.119.34.211:82/ws');
            this.stompClient = Stomp.over(socket);

            this.stompClient.connect({}, function (frame) {
                websocket.setConnected(true);
                console.log('Connected: ' + frame);
                this.subscribe('/send/user', function (msg) {
                    const time = new Date().toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });
                    $("#all").prepend(
                        `<div class="message-container">
                            <div class="user-massage">
                                \${JSON.parse(msg.body).content1}
                                <div class="message-time">\${time}</div>
                            </div>
                         </div>`);
                    websocket.onNewMessage();
                });

                this.subscribe("/send/admin", function (msg) {
                    const time = new Date().toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });
                    $("#all").prepend(
                        `<div class="message-container">
                            <div class="admin-message">
                                \${JSON.parse(msg.body).content1}
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
        },
        onNewMessage: function () {
            if (window.parent) {
                const chatButton = window.parent.document.querySelector('#chat-button');
                if (chatButton) {
                    chatButton.classList.add('new-message');
                    setTimeout(() => {
                        chatButton.classList.remove('new-message');
                    }, 5000);
                }
            }
        }
    };
    $(function(){
        websocket.init();
        websocket.connect();
    });
</script>

<div class="chat-container">
    <div class="chat-header">
        <h3 id="status">Status</h3>
    </div>
    <div id="all"></div>
    <div class="chat-input-container">
        <input type="text" id="alltext" placeholder="메시지를 입력하세요...">
        <button id="sendall">전송</button>
    </div>
</div>
<%--<%@ page contentType="text/html;charset=UTF-8" language="java" %>--%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>

<%--&lt;%&ndash; 웹소켓 라이브러리&ndash;%&gt;--%>
<%--<script src="/webjars/sockjs-client/sockjs.min.js"></script>--%>
<%--<script src="/webjars/stomp-websocket/stomp.min.js"></script>--%>

<%--<!-- jQuery, Popper, Bootstrap from CDN -->--%>
<%--<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>--%>
<%--<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>--%>
<%--<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>--%>

<%--<style>--%>
<%--    #all {--%>
<%--        height: 280px;--%>
<%--        overflow: auto;--%>
<%--        margin-top: 5px;--%>
<%--        background-color: #f0fafb;--%>
<%--    }--%>

<%--    /* 사용자가 보낸 메시지 */--%>
<%--    .user-massage {--%>
<%--        background-color: #d1f7c4; /* 연한 초록색 */--%>
<%--        text-align: left; /* 오른쪽 정렬 */--%>
<%--        padding: 10px;--%>
<%--        border-radius: 5px;--%>
<%--        color: black;--%>
<%--        margin: 5px 0;--%>
<%--    }--%>

<%--    /* 관리자가 보낸 메시지 */--%>
<%--    .admin-message {--%>
<%--        background-color: #f1f1f1; /* 연한 회색 */--%>
<%--        text-align: right; /* 왼쪽 정렬 */--%>
<%--        padding: 10px;--%>
<%--        border-radius: 5px;--%>
<%--        color: black;--%>
<%--        margin: 5px 0;--%>
<%--    }--%>

<%--    #alltext {--%>
<%--        width: 260px;--%>
<%--    }--%>

<%--    #sendall {--%>
<%--        background-color: black;--%>
<%--        color: white;--%>
<%--        border-radius: 5px;--%>
<%--        margin-left: 5px;--%>
<%--    }--%>



<%--</style>--%>

<%--<script>--%>
<%--    let websocket = {--%>
<%--        id: '',--%>
<%--        stompClient: null,--%>
<%--        init: function () {--%>
<%--            this.id = $('#adm_id').text();--%>
<%--            $('#connect').click(() => {--%>
<%--                this.connect();--%>
<%--            });--%>

<%--            $('#disconnect').click(() => {--%>
<%--                this.disconnect();--%>
<%--            });--%>

<%--            $('#alltext').keydown((event) => {--%>
<%--                if (event.key === "Enter") {--%>
<%--                    event.preventDefault();--%>
<%--                    $('#sendall').click();--%>
<%--                    $("#alltext").val(""); // 입력 필드 텍스트 클리어--%>
<%--                }--%>
<%--            });--%>

<%--            $('#sendall').click(() => {--%>
<%--                let msg = JSON.stringify({--%>
<%--                    'content1': $("#alltext").val()--%>
<%--                });--%>
<%--                $("#alltext").val(""); // 입력 필드 텍스트 클리어--%>
<%--                this.stompClient.send("/receive/admin", {}, msg);--%>
<%--            });--%>
<%--        },--%>
<%--        connect: function () {--%>
<%--            let sid = this.id;--%>
<%--            let socket = new SockJS('https://210.119.34.211:82/ws');--%>
<%--            this.stompClient = Stomp.over(socket);--%>

<%--            this.stompClient.connect({}, function (frame) {--%>
<%--                websocket.setConnected(true);--%>
<%--                console.log('Connected: ' + frame);--%>
<%--                this.subscribe('/send/user', function (msg) {--%>
<%--                    $("#all").prepend(--%>
<%--                        "<h5 class='user-massage'>" + "사용자 : " +--%>
<%--                        JSON.parse(msg.body).content1--%>
<%--                        + "</h5>");--%>
<%--                    websocket.onNewMessage();--%>
<%--                });--%>

<%--                this.subscribe("/send/admin", function (msg) {--%>
<%--                    $("#all").prepend(--%>
<%--                        "<h5 class='admin-message'>" +--%>
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
<%--        },--%>
<%--        onNewMessage: function () {--%>
<%--            if (window.parent) {--%>
<%--                const chatButton = window.parent.document.querySelector('#chat-button');--%>
<%--                if (chatButton) {--%>
<%--                    chatButton.classList.add('new-message');--%>

<%--                    setTimeout(() => {--%>
<%--                        chatButton.classList.remove('new-message');--%>
<%--                    }, 5000);--%>
<%--                }--%>
<%--            }--%>
<%--        }--%>
<%--    };--%>
<%--    $(function(){--%>
<%--        websocket.init();--%>
<%--        websocket.connect();--%>
<%--    });--%>
<%--</script>--%>



<%--<div class="container-fluid">--%>

<%--    <!-- DataTales Example -->--%>
<%--    <div class="card shadow mb-4">--%>
<%--        <div class="card-body">--%>
<%--            <div class="table-responsive">--%>
<%--                <div>--%>
<%--                    <H3 id="status">Status</H3>--%>
<%--&lt;%&ndash;                    <button id="connect">Connect</button>&ndash;%&gt;--%>
<%--&lt;%&ndash;                    <button id="disconnect">Disconnect</button>&ndash;%&gt;--%>

<%--                    <div id="all"></div>--%>
<%--                    <div style="margin-top: 5px">--%>
<%--                    <input type="text" id="alltext"><button id="sendall">전송</button>--%>
<%--                    </div>--%>

<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--</div>--%>


