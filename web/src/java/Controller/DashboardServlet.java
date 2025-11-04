package Controller;

import Dal.DBContext;
import Dal.MatchDAO;
import Dal.TeamDAO;
import Model.Match;
import Model.Team;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    private TeamDAO teamDAO;
    private MatchDAO matchDAO;

    @Override
    public void init() throws ServletException {
        try {
            DBContext db = new DBContext();
            matchDAO = new MatchDAO(db.getConnection());
            teamDAO = new TeamDAO(db.getConnection());
        } catch (Exception e) {
            e.printStackTrace(); // log lỗi
            throw new ServletException("Không thể khởi tạo DAO", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // ✅ 1. Lấy danh sách đội
            List<Team> teams = teamDAO.getAllTeams();
            // ✅ 2. Lấy số lượng đội và trận đấu
            int teamCount = teams.size();
            List<Match> matches = matchDAO.getAllMatches();
            int matchCount = matches.size();

            // ✅ 3. Tính trung bình tỷ lệ thắng
            double totalWinRate = 0;
            for (Team t : teams) {
                totalWinRate += t.getWinRate();
            }
            double avgWinRate = teamCount > 0 ? totalWinRate / teamCount : 0;

            // ✅ 4. Gửi sang JSP
            request.setAttribute("teams", teams);
            request.setAttribute("teamCount", teamCount);
            request.setAttribute("matchCount", matchCount);
            request.setAttribute("avgWinRate", Math.round(avgWinRate));

            // ✅ 5. Hiển thị dashboard
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể tải dữ liệu Dashboard: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
