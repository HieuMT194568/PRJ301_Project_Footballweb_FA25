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
                case "new":
                    request.setAttribute("teamList", teamDAO.getAllTeams());
                    request.getRequestDispatcher("admin/match_form.jsp").forward(request, response);
                    break;

                case "edit":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Match match = matchDAO.getMatchById(id);
                    request.setAttribute("match", match);
                    List<Team> teams = teamDAO.getAllTeams();
                    request.setAttribute("teams", teams);

                    request.getRequestDispatcher("admin/match_form.jsp").forward(request, response);
                    break;

                case "delete":
                    matchDAO.deleteMatch(Integer.parseInt(request.getParameter("id")));
                    response.sendRedirect("MatchServlet?action=list");
                    break;

                default:
                    request.setAttribute("matchList", matchDAO.getAllMatches());
                    request.getRequestDispatcher("match_list.jsp").forward(request, response);
                    break;
            }

        } catch (SQLException e) {
            throw new ServletException("DB error: " + e.getMessage(), e);
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
            int homeScore = Integer.parseInt(request.getParameter("homeScore"));
            int awayScore = Integer.parseInt(request.getParameter("awayScore"));
            String stadium = request.getParameter("stadium");
            String matchDateStr = request.getParameter("matchDate");

            // convert sang Timestamp
            java.sql.Timestamp matchDate = java.sql.Timestamp.valueOf(matchDateStr + " 00:00:00");

            if (action.equals("insert")) {
                Match m = new Match();
                m.setHomeTeamID(homeTeamID);
                m.setAwayTeamID(awayTeamID);
                m.setHomeScore(homeScore);
                m.setAwayScore(awayScore);
                m.setMatchDate(matchDate);
                m.setStadium(stadium);
                matchDAO.addMatch(m);
            } else if (action.equals("update")) {
                int matchID = Integer.parseInt(request.getParameter("matchID"));
                Match m = new Match();
                m.setMatchID(matchID);
                m.setHomeTeamID(homeTeamID);
                m.setAwayTeamID(awayTeamID);
                m.setHomeScore(homeScore);
                m.setAwayScore(awayScore);
                m.setMatchDate(matchDate);
                m.setStadium(stadium);
                matchDAO.updateMatch(m);
            }

            response.sendRedirect("MatchServlet?action=list");

        } catch (Exception e) {
            throw new ServletException("Error while saving match: " + e.getMessage(), e);
        }
    }

}
