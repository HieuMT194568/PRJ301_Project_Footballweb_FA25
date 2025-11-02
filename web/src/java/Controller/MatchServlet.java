package Controller;

import Dal.MatchDAO;
import Dal.TeamDAO;
import Model.Match;
import Model.Team;
import Dal.DBContext;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "MatchServlet", urlPatterns = {"/MatchServlet"})
public class MatchServlet extends HttpServlet {

    private MatchDAO matchDAO;
    private TeamDAO teamDAO;

    @Override
    public void init() throws ServletException {
        try {
            DBContext db = new DBContext();
            matchDAO = new MatchDAO(db.getConnection());
            teamDAO = new TeamDAO(db.getConnection());
        } catch (Exception e) {
            throw new ServletException("Không thể khởi tạo MatchServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action != null ? action : "list") {
                case "new":
                    // Lấy danh sách đội để hiển thị trong dropdown
                    request.setAttribute("teams", teamDAO.getAllTeams());
                    request.getRequestDispatcher("match-form.jsp").forward(request, response);
                    break;

                case "edit":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Match match = matchDAO.getMatchById(id);
                    request.setAttribute("match", match);
                    request.setAttribute("teams", teamDAO.getAllTeams());
                    request.getRequestDispatcher("match-form.jsp").forward(request, response);
                    break;

                case "delete":
                    int delId = Integer.parseInt(request.getParameter("id"));
                    matchDAO.deleteMatch(delId);
                    response.sendRedirect("MatchServlet?action=list");
                    break;

                default:
                    List<Match> matches = matchDAO.getAllMatches();
                    request.setAttribute("matchList", matches);
                    request.getRequestDispatcher("matches-list.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        int homeTeamID = Integer.parseInt(request.getParameter("homeTeamID"));
        int awayTeamID = Integer.parseInt(request.getParameter("awayTeamID"));
        int homeScore = Integer.parseInt(request.getParameter("homeScore"));
        int awayScore = Integer.parseInt(request.getParameter("awayScore"));
        String stadium = request.getParameter("stadium");
        String matchDate = request.getParameter("matchDate");

        Match match = new Match();
        match.setHomeTeamID(homeTeamID);
        match.setAwayTeamID(awayTeamID);
        match.setHomeScore(homeScore);
        match.setAwayScore(awayScore);
        match.setStadium(stadium);
        match.setMatchDate(Date.valueOf(matchDate));

        if ("update".equals(action)) {
            match.setMatchID(Integer.parseInt(request.getParameter("matchID")));
            try {
                matchDAO.updateMatch(match);
            } catch (SQLException ex) {
                Logger.getLogger(MatchServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            try {
                matchDAO.addMatch(match);
            } catch (SQLException ex) {
                Logger.getLogger(MatchServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        response.sendRedirect("MatchServlet?action=list");
    }

    private void listMatches(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Match> matches = matchDAO.getAllMatches();
        request.setAttribute("matchList", matches);
        RequestDispatcher rd = request.getRequestDispatcher("matches_list.jsp");
        rd.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int matchID = Integer.parseInt(request.getParameter("id"));
        Match match = matchDAO.getMatchById(matchID);
        List<Team> teams = teamDAO.getAllTeams();
        request.setAttribute("match", match);
        request.setAttribute("teamList", teams);
        RequestDispatcher rd = request.getRequestDispatcher("match_form.jsp");
        rd.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Team> teams = teamDAO.getAllTeams();
        request.setAttribute("teamList", teams);
        RequestDispatcher rd = request.getRequestDispatcher("match_form.jsp");
        rd.forward(request, response);
    }

    private void deleteMatch(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        matchDAO.deleteMatch(id);
        response.sendRedirect("MatchServlet");
    }

}
