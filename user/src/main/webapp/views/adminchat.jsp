<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
    .chat-card {
        border: none;
        border-radius: 16px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        max-width: 800px;
        margin: 0 auto;
    }

    .chat-header {
        background: linear-gradient(135deg, #2563eb, #1e40af);
        padding: 1.25rem;
        border-radius: 16px 16px 0 0;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .chat-title {
        color: white;
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0;
    }

    .chat-connection-status {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        padding: 0.5rem 1rem;
        border-radius: 20px;
        background: rgba(255, 255, 255, 0.1);
    }

    .status-indicator {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background-color: #ef4444;
        transition: background-color 0.3s ease;
    }

    .status-indicator.connected {
        background-color: #22c55e;
    }

    .status-text {
        color: white;
        font-size: 0.875rem;
    }

    #all {
        height: 200px;
        overflow: auto;
        padding: 1rem;
        background-color: #f8fafc;
    }

    #all::-webkit-scrollbar {
        width: 6px;
    }

    #all::-webkit-scrollbar-track {
        background: #f1f5f9;
    }

    #all::-webkit-scrollbar-thumb {
        background: #cbd5e1;
        border-radius: 3px;
    }

    .user-massage {
        background-color: #2563eb;
        color: white;
        text-align: right;
        padding: 12px 16px;
        border-radius: 16px;
        border-bottom-right-radius: 4px;
        margin: 8px 0;
        max-width: 80%;
        margin-left: auto;
        word-wrap: break-word;
        animation: slideLeft 0.3s ease;
    }

    .admin-message {
        background-color: white;
        color: #1f2937;
        text-align: left;
        padding: 12px 16px;
        border-radius: 16px;
        border-bottom-left-radius: 4px;
        margin: 8px 0;
        max-width: 80%;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        word-wrap: break-word;
        animation: slideRight 0.3s ease;
    }

    @keyframes slideRight {
        from { opacity: 0; transform: translateX(-10px); }
        to { opacity: 1; transform: translateX(0); }
    }

    @keyframes slideLeft {
        from { opacity: 0; transform: translateX(10px); }
        to { opacity: 1; transform: translateX(0); }
    }

    .button-container1212 {
        padding: 1rem;
        display: flex;
        gap: 8px;
    }

    #connect, #disconnect {
        padding: 8px 16px;
        font-size: 0.875rem;
        border-radius: 20px;
        border: none;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    #connect {
        background-color: #2563eb;
        color: white;
    }

    #connect:hover {
        background-color: #1e40af;
    }

    #disconnect {
        background-color: #f1f5f9;
        color: #64748b;
        border: 1px solid #e2e8f0;
    }

    #disconnect:hover {
        background-color: #e2e8f0;
    }

    #inputcontainer {
        padding: 1rem;
        background: white;
        border-top: 1px solid #e2e8f0;
        display: flex;
        gap: 8px;
    }

    #alltext {
        flex: 1;
        padding: 12px;
        border: 1px solid #e2e8f0;
        border-radius: 24px;
        outline: none;
        transition: all 0.3s ease;
    }

    #alltext:focus {
        border-color: #2563eb;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }

    #sendall {
        background-color: #2563eb;
        color: white;
        border: none;
        padding: 12px 24px;
        border-radius: 24px;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    #sendall:hover {
        background-color: #1e40af;
    }
</style>


    <div class="chat-header">
        <h6 class="chat-title">관리자 1:1 채팅</h6>
        <div class="chat-connection-status">
            <div class="status-indicator" id="statusIndicator"></div>
            <span class="status-text" id="status">연결 끊김</span>
        </div>
    </div>

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

<script>
    let adminchat = {
        id: '',
        stompClient: null,
        init: function () {
            $('#connect').click(() => {
                $("#status").text("연결중...");
                $("#statusIndicator").css("background-color", "#eab308"); // 노란색으로 변경
                setTimeout(() => {
                    this.connect();
                }, 2000);
            });
            $('#disconnect').click(() => {
                this.disconnect();
            });
            $('#sendall').click(() => {
                if ($("#alltext").val().trim() !== '') {
                    let msg = JSON.stringify({
                        'content1': $("#alltext").val()
                    });
                    this.stompClient.send("/send/user", {}, msg);
                    $("#alltext").val('');
                }
            });
            $("#alltext").keydown((event) => {
                if (event.key === "Enter") {
                    event.preventDefault();
                    $('#sendall').click();
                }
            });
        },
        connect: function () {
            let sid = this.id;
            let userid = '${sessionScope.loginid.userId}';
            let socket = new SockJS('http://210.119.34.211:82/ws');
            this.stompClient = Stomp.over(socket);

            this.stompClient.connect({}, function (frame) {
                websocket.setConnected(true);
                console.log('Connected: ' + frame);

                this.subscribe('/send/user', function (msg) {
                    $("#all").prepend(
                        "<h5 class='user-massage'>" +
                        JSON.parse(msg.body).content1
                        + "</h5>");
                });

                this.subscribe('/send/admin', function (msg) {
                    $("#all").prepend(
                        "<h5 class='admin-message'>" + "관리자 : " +
                        JSON.parse(msg.body).content1
                        + "</h5>");
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
            const indicator = $("#statusIndicator");
            if (connected) {
                $("#status").text("연결됨");
                indicator.addClass("connected");
                indicator.css("background-color", "#22c55e"); // 초록색
            } else {
                $("#status").text("연결 끊김");
                indicator.removeClass("connected");
                indicator.css("background-color", "#ef4444"); // 빨간색
            }
        }
    };
    $(function () {
        adminchat.init();
    });
</script>