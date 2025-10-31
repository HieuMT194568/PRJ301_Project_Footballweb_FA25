package Controller;

import Dal.MatchDAO;
import Model.Match;
import Service.MatchService;
import Dal.DBContext;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MatchServlet", urlPatterns = {"/Matches"})
public class MatchServlet extends HttpServlet {

    private MatchService matchService;

    @Override
    public void init() throws ServletException {
        try {
            DBContext db = new DBContext();
            MatchDAO matchDAO = new MatchDAO(db.getConnection());
            matchService = new MatchService(matchDAO);
        } catch (Exception e) {
            throw new ServletException("Không thể khởi tạo MatchServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "details" -> showMatchDetails(request, response);
            case "stats" -> showTeamStats(request, response);
            default -> listAllMatches(request, response);
        }
    }

    private void listAllMatches(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Match> matches = matchService.getAllMatches();
        request.setAttribute("matches", matches);
        RequestDispatcher rd = request.getRequestDispatcher("matches.jsp");
        rd.forward(request, response);
    }

    private void showMatchDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Match match = matchService.getMatchById(id);
        request.setAttribute("match", match);
        RequestDispatcher rd = request.getRequestDispatcher("match_detail.jsp");
        rd.forward(request, response);
    }

    private void showTeamStats(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int teamID = Integer.parseInt(request.getParameter("teamID"));
        int wins = matchService.getWins(teamID);
        int draws = matchService.getDraws(teamID);
        int losses = matchService.getLosses(teamID);
        double rate = matchService.getWinRate(teamID);

        request.setAttribute("wins", wins);
        request.setAttribute("draws", draws);
        request.setAttribute("losses", losses);
        request.setAttribute("rate", rate);

        RequestDispatcher rd = request.getRequestDispatcher("team_stats.jsp");
        rd.forward(request, response);
    }
}
