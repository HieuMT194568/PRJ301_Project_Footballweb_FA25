<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>Trận đấu gần đây</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-8">
  <h1 class="text-3xl font-bold mb-6">Danh sách trận đấu</h1>

  <table class="min-w-full bg-white shadow-md rounded">
    <thead>
      <tr class="bg-red-600 text-white">
        <th class="py-2 px-4">#</th>
        <th class="py-2 px-4">Home</th>
        <th class="py-2 px-4">Away</th>
        <th class="py-2 px-4">Tỉ số</th>
        <th class="py-2 px-4">Ngày thi đấu</th>
        <th class="py-2 px-4">Sân</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="m" items="${matches}">
        <tr class="border-b hover:bg-gray-50">
          <td class="py-2 px-4">${m.matchID}</td>
          <td class="py-2 px-4">${m.homeTeamID}</td>
          <td class="py-2 px-4">${m.awayTeamID}</td>
          <td class="py-2 px-4">${m.homeScore} - ${m.awayScore}</td>
          <td class="py-2 px-4">${m.matchDate}</td>
          <td class="py-2 px-4">${m.stadium}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</body>
</html>
