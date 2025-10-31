package Controller;

import Dal.MatchDAO;
import Dal.TeamDAO;
import Service.TeamService;
import Service.TeamService.TeamStats;
import Dal.DBContext;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "TeamServlet", urlPatterns = {"/Teams"})
public class TeamServlet extends HttpServlet {

    private TeamService teamService;

    @Override
    public void init() throws ServletException {
        try {
            DBContext db = new DBContext();
            TeamDAO teamDAO = new TeamDAO(db.getConnection());
            MatchDAO matchDAO = new MatchDAO(db.getConnection());
            teamService = new TeamService(teamDAO, matchDAO);
        } catch (Exception e) {
            throw new ServletException("Không thể khởi tạo TeamServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<TeamStats> stats = teamService.getTeamStats();
        request.setAttribute("teamStats", stats);
        RequestDispatcher rd = request.getRequestDispatcher("team_dashboard.jsp");
        rd.forward(request, response);
    }
}
