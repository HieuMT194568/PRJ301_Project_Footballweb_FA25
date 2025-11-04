 <%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>${pageTitle}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
    </style>
</head>
<body class="bg-neutral-100 min-h-screen flex flex-col">

    <header class="bg-red-700 text-white shadow-lg z-20">
        <div class="flex justify-between items-center h-16 px-6 md:px-8">
            
            <h1 class="text-2xl font-bold truncate">⚽ Bayern Munich</h1>
            
            <div class="flex items-center space-x-4">
                <span class="font-medium hidden md:block">Welcome, Vua!</span>
                <div class="w-10 h-10 rounded-full bg-white text-red-700 flex items-center justify-center font-bold text-lg flex-shrink-0">
                    V
                </div>
            </div>
        </div>
    </header>

    <nav class="bg-white shadow-md border-b border-gray-200 sticky top-0 z-10">
        <div class="flex items-center space-x-8 h-12 px-6 md:px-8">
            
            <a href="DashboardServlet" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition-colors duration-200">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 01-1 1h-2a1 1 0 01-1-1v-4z"></path></svg>
                <span>Dashboard</span>
            </a>
            
            <a href="TeamServlet?action=list" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition-colors duration-200">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"></path></svg>
                <span>Teams</span>
            </a>
            
            <a href="MatchServlet?action=list" class="flex items-center text-gray-700 hover:text-red-600 font-medium transition-colors duration-200">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>
                <span>Matches</span>
            </a>
            
        </div>
    </nav>

    <main class="flex-1 p-6 md:p-8">
        
        <h2 class="text-3xl font-semibold text-gray-800 mb-6">${pageTitle}</h2>

        <div class="bg-white p-6 rounded-xl shadow-lg">
            
            <jsp:include page="${contentPage}" />
            
        </div>
        
        <footer class="mt-8 text-center text-gray-500 text-sm">
            Made with ❤️ by Vua
        </footer>
        
    </main>

            
       <div class="grid grid-cols-4 gap-6">
  <c:forEach var="p" items="${productList}">
    <div class="bg-white rounded-xl shadow p-4 hover:shadow-lg transition">
      <img src="${p.imageUrl}" class="h-48 w-full object-cover rounded-md mb-3">
      <h3 class="text-lg font-semibold">${p.productName}</h3>
      <p class="text-gray-600">${p.category}</p>
      <p class="text-red-600 font-bold mt-2">${p.price} đ</p>
      <a href="CartServlet?action=add&id=${p.productID}" 
         class="block bg-red-600 text-white text-center mt-3 py-2 rounded-lg hover:bg-red-700 transition">
         🛒 Thêm vào giỏ
      </a>
    </div>
  </c:forEach>
</div>
         
            
            
</body>
</html>