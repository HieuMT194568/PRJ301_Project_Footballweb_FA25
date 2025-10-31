package Service;

import Dal.TeamDAO;
import Dal.MatchDAO;
import Model.Team;
import java.util.ArrayList;
import java.util.List;

public class TeamService {

    private final TeamDAO teamDAO;
    private final MatchDAO matchDAO;

    public TeamService(TeamDAO teamDAO, MatchDAO matchDAO) {
        this.teamDAO = teamDAO;
        this.matchDAO = matchDAO;
    }

    public List<Team> getAllTeams() {
        return teamDAO.getAllTeams();
    }

    // Tạo class TeamStats để chứa dữ liệu thống kê
    public static class TeamStats {

        public String teamName;
        public int wins;
        public int draws;
        public int losses;
        public double winRate;

        public TeamStats(String teamName, int wins, int draws, int losses, double winRate) {
            this.teamName = teamName;
            this.wins = wins;
            this.draws = draws;
            this.losses = losses;
            this.winRate = winRate;
        }
    }

    // Lấy danh sách thống kê toàn bộ đội bóng
    public List<TeamStats> getTeamStats() {
        List<Team> teams = teamDAO.getAllTeams();
        List<TeamStats> stats = new ArrayList<>();

        for (Team t : teams) {
            int wins = matchDAO.countWins(t.getTeamID());
            int draws = matchDAO.countDraws(t.getTeamID());
            int losses = matchDAO.countLosses(t.getTeamID());

            int total = wins + draws + losses;
            double rate = total == 0 ? 0 : (double) wins / total * 100;

            stats.add(new TeamStats(t.getTeamName(), wins, draws, losses, rate));
        }

        return stats;
    }
}
