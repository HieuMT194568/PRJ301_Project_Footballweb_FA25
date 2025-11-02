package Controller;

import Dal.DBContext;
import Dal.TeamDAO;
import Dal.MatchDAO;
import Model.Team;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "TeamServlet", urlPatterns = {"/TeamServlet"})
public class TeamServlet extends HttpServlet {

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

        List<Team> teamList = teamDAO.getAllTeams();

        // ✅ Tính tỷ lệ thắng cho từng đội
        for (Team t : teamList) {
            double winRate = matchDAO.calculateWinRate(t.getTeamID());
            t.setWinRate(winRate);
        }

        request.setAttribute("teamList", teamList);

        RequestDispatcher rd = request.getRequestDispatcher("dashboard.jsp");
        rd.forward(request, response);
    }
}
