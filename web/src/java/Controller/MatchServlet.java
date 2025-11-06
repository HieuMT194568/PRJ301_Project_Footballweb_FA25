package Controller;

import Dal.DBContext;
import Dal.MatchDAO;
import Dal.TeamDAO;
import Model.Match;
import Model.Team;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

@WebServlet(name = "MatchServlet", urlPatterns = {"/MatchServlet"})
public class MatchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try (Connection conn = new DBContext().getConnection()) {
            MatchDAO matchDAO = new MatchDAO(conn);
            TeamDAO teamDAO = new TeamDAO(conn);

            switch (action) {
                // 🟢 Hiển thị form thêm mới
                case "new":
                    request.setAttribute("teamList", teamDAO.getAllTeams());
                    request.getRequestDispatcher("admin/match_form.jsp").forward(request, response);
                    break;

                // ✏️ Hiển thị form sửa
                case "edit":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Match match = matchDAO.getMatchById(id);
                    request.setAttribute("match", match);
                    request.setAttribute("teamList", teamDAO.getAllTeams());
                    request.getRequestDispatcher("admin/match_form.jsp").forward(request, response);
                    break;

                // 🗑️ Xóa trận đấu
                case "delete":
                    int delID = Integer.parseInt(request.getParameter("id"));
                    matchDAO.deleteMatch(delID);
                    response.sendRedirect("MatchServlet?action=list");
                    break;
                case "list":
                default:
                    List<Match> matchList = matchDAO.getAllMatchesWithTeamNames();
                    request.setAttribute("matchList", matchList);
                    request.getRequestDispatcher("match_list.jsp").forward(request, response);
                    break;
                case "admin":
                    matchList = matchDAO.getAllMatchesWithTeamNames();
                    request.setAttribute("matchList", matchList);
                    request.getRequestDispatcher("admin/match_list.jsp").forward(request, response);
                    break;
            }

        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        try (Connection conn = new DBContext().getConnection()) {
            MatchDAO matchDAO = new MatchDAO(conn);

            int homeTeamID = Integer.parseInt(request.getParameter("homeTeamID"));
            int awayTeamID = Integer.parseInt(request.getParameter("awayTeamID"));
            String stadium = request.getParameter("stadium");
            String matchDateStr = request.getParameter("matchDate");
            Timestamp matchDate = Timestamp.valueOf(matchDateStr + " 00:00:00");

            // Nếu người dùng chưa nhập tỉ số thì coi như 0
            int homeScore = 0;
            int awayScore = 0;
            try {
                homeScore = Integer.parseInt(request.getParameter("homeScore"));
                awayScore = Integer.parseInt(request.getParameter("awayScore"));
            } catch (NumberFormatException ignored) {
            }

            Match m = new Match();
            m.setHomeTeamID(homeTeamID);
            m.setAwayTeamID(awayTeamID);
            m.setHomeScore(homeScore);
            m.setAwayScore(awayScore);
            m.setMatchDate(matchDate);
            m.setStadium(stadium);

            if (action.equals("insert")) {
                matchDAO.addMatch(m);
            } else if (action.equals("update")) {
                int matchID = Integer.parseInt(request.getParameter("matchID"));
                m.setMatchID(matchID);
                matchDAO.updateMatch(m);
            }

            response.sendRedirect("MatchServlet?action=list");

        } catch (Exception e) {
            throw new ServletException("Error while saving match: " + e.getMessage(), e);
        }
    }
}
