<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shop - FC Bayern Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <style>
        .card-img-top-fixed {
            height: 200px; /* Đặt chiều cao cố định cho ảnh */
            object-fit: cover; /* Đảm bảo ảnh lấp đầy mà không bị méo */
        }

        /* CẢI TIẾN 1: Thêm hiệu ứng hover cho Card
        */
        .card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .card:hover {
            transform: translateY(-5px); /* Nâng card lên 5px */
            box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important; /* Thêm bóng đổ lớn hơn */
        }
    </style>
</head>
<body class="bg-light">

    <header class="navbar navbar-expand-lg navbar-dark bg-danger shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/articles">
                <img src="${pageContext.request.contextPath}/assets/images/bayern-logo.png" alt="Logo" style="height: 40px; width: 40px;" class="rounded-circle bg-white p-1 me-2">
                <span class="fw-bold fs-5">FC Bayern Munich</span>
            </a>

            <div class="d-flex align-items-center ms-auto">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="navbar-text me-3 d-none d-md-block">
                            Welcome, ${sessionScope.user.fullName}!
                        </span>
                        <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-light text-danger fw-semibold me-2">
                            Logout
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-light text-danger fw-semibold me-2">
                            Login
                        </a>
                    </c:otherwise>
                </c:choose>

                <a href="${pageContext.request.contextPath}/CartServlet?action=view" class="btn btn-light text-danger fw-semibold position-relative">
                    🛒
                    <c:if test="${not empty sessionScope.cart}">
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-warning text-dark">
                            ${sessionScope.cart.size()}
                        </span>
                    </c:if>
                </a>
            </div>
        </div>
    </header>

    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm border-bottom sticky-top">
        <div class="container-fluid">
            <div class="navbar-nav">
                <a class="nav-link" href="${pageContext.request.contextPath}/TeamServlet?action=list">👥 Teams</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/MatchServlet?action=list">⚽ Matches</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/articles">📰 News</a>
                <a class="nav-link active fw-bold text-danger" href="${pageContext.request.contextPath}/shop">🛍️ Shop</a>
                
                <c:if test="${sessionScope.user != null && sessionScope.user.role == 'ADMIN'}">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin">⚙️ Admin Panel</a>
                </c:if>
            </div>
        </div>
    </nav>

    <main class="container my-5">
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
            <c:forEach var="p" items="${productList}">
                <div class="col">
                    <div class="card h-100 shadow-sm">
                        <img src="${pageContext.request.contextPath}/assets/${p.imageUrl}" class="card-img-top card-img-top-fixed" alt="${p.productName}">
                        
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title fw-bold text-dark text-truncate" title="${p.productName}">
                                ${p.productName}
                            </h5>
                            <p class="card-text text-muted small">${p.category}</p>
                            
                            <p class="card-text fs-5 fw-semibold text-danger mb-2">
                                <fmt:formatNumber value="${p.price}" pattern="#,##0" /> ₫
                            </p>

                            <div class="mt-auto">
                                <c:choose>
                                    <c:when test="${p.stockQuantity > 0}">
                                        <p class="text-success small mb-2">Còn lại: ${p.stockQuantity}</p>
                                        <a href="${pageContext.request.contextPath}/CartServlet?action=add&id=${p.productID}"
                                           class="btn btn-danger w-100 fw-medium">
                                            🛒 Thêm vào giỏ
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-danger small fw-semibold mb-2">❌ Hết hàng</p>
                                        <button class="btn btn-secondary w-100" disabled>
                                            Hết hàng
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <footer class="text-center py-4 text-muted border-top mt-5">
        © 2025 Bayern Munich. All rights reserved.
    </footer>
    
    <style>
        #chat-bubble {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: #DC052D; /* Màu đỏ Bayern */
            color: white;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            cursor: pointer;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            z-index: 1000; /* Đảm bảo nổi lên trên */
        }
        #chat-window {
            display: none;
            position: fixed;
            bottom: 90px;
            right: 20px;
            width: 350px;
            height: 450px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
            flex-direction: column;
            border: 1px solid #ddd;
            z-index: 1000; /* Đảm bảo nổi lên trên */
        }
        #chat-messages {
            flex-grow: 1;
            padding: 15px;
            overflow-y: auto;
            background: #f9f9f9;
        }
        #chat-input-container {
            border-top: 1px solid #ddd;
            padding: 10px;
            display: flex;
        }
        #chat-input {
            flex-grow: 1;
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 8px;
        }
        #chat-send {
            background: #DC052D;
            color: white;
            border: none;
            padding: 0 12px;
            margin-left: 5px;
            border-radius: 5px;
            cursor: pointer;
        }
        .chat-msg {
            margin-bottom: 10px;
            padding: 8px 12px;
            border-radius: 15px;
            max-width: 80%;
            line-height: 1.4;
        }
        .chat-msg.user {
            background: #007bff;
            color: white;
            margin-left: auto;
        }
        .chat-msg.bot {
            background: #e9e9eb;
            color: black;
            margin-right: auto;
        }
    </style>

    <div id="chat-bubble">🤖</div>

    <div id="chat-window" style="display: none; flex-direction: column;">
        <div style="background: #DC052D; color: white; padding: 10px; font-weight: bold; border-radius: 10px 10px 0 0;">
            Trợ lý AI Bayern
        </div>
        <div id="chat-messages">
            <div class="chat-msg bot">Xin chào! Tôi có thể giúp gì cho bạn về các trận đấu hoặc sản phẩm?</div>
        </div>
        <div id="chat-input-container">
            <input type="text" id="chat-input" placeholder="Hỏi tôi về sản phẩm...">
            <button id="chat-send">Gửi</button>
        </div>
    </div>

    <script>
        // Phải đặt code này trong một hàm để nó không xung đột
        // khi bạn dán vào nhiều trang
        function initializeBayernChatbot() {
            const chatBubble = document.getElementById('chat-bubble');
            const chatWindow = document.getElementById('chat-window');
            const messagesContainer = document.getElementById('chat-messages');
            const chatInput = document.getElementById('chat-input');
            const sendButton = document.getElementById('chat-send');

            // Kiểm tra xem các phần tử có tồn tại không
            if (!chatBubble || !chatWindow || !chatInput || !sendButton) {
                console.error("Lỗi Chatbot: Không tìm thấy các phần tử HTML.");
                return; // Dừng lại nếu không tìm thấy
            }

            // Mở/đóng cửa sổ chat
            chatBubble.addEventListener('click', () => {
                const isHidden = chatWindow.style.display === 'none';
                chatWindow.style.display = isHidden ? 'flex' : 'none';
            });

            // Gửi tin nhắn khi nhấn Enter
            chatInput.addEventListener('keypress', function (e) {
                if (e.key === 'Enter') {
                    sendMessage();
                }
            });

            // Gửi tin nhắn khi nhấn nút
            sendButton.addEventListener('click', sendMessage);

            async function sendMessage() {
                const query = chatInput.value;
                if (!query.trim()) return;

                appendMessage(query, 'user');
                chatInput.value = '';
                sendButton.disabled = true; 
                appendMessage("...", 'bot'); 

                try {
                    const response = await fetch('${pageContext.request.contextPath}/ai-chat', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'text/plain;charset=UTF-8'
                        },
                        body: query
                    });

                    if (!response.ok) {
                        throw new Error('Lỗi máy chủ: ' + response.status);
                    }

                    const data = await response.json();
                    
                    const loadingMsg = messagesContainer.querySelector('.chat-msg.bot:last-child');
                    if (loadingMsg && loadingMsg.textContent === '...') {
                        loadingMsg.remove();
                    }

                    appendMessage(data.reply, 'bot');

                } catch (error) {
                    console.error('Lỗi khi gọi AI:', error);
                    
                    const loadingMsg = messagesContainer.querySelector('.chat-msg.bot:last-child');
                    if (loadingMsg && loadingMsg.textContent === '...') {
                        loadingMsg.remove();
                    }
                    
                    appendMessage('Xin lỗi, tôi không thể kết nối đến máy chủ AI.', 'bot');
                } finally {
                    sendButton.disabled = false; 
                }
            }

            function appendMessage(text, type) {
                if (!messagesContainer) return; // Kiểm tra an toàn
                const msgDiv = document.createElement('div');
                msgDiv.classList.add('chat-msg', type);
                msgDiv.textContent = text;
                messagesContainer.appendChild(msgDiv);
                messagesContainer.scrollTop = messagesContainer.scrollHeight;
            }
        }
        
        // Chạy hàm khởi tạo chatbot
        initializeBayernChatbot();
    </script>
    </body>
</html>