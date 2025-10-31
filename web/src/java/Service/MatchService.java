package Service;

import Dal.MatchDAO;
import Model.Match;
import java.util.List;

public class MatchService {

    private final MatchDAO matchDAO;

    public MatchService(MatchDAO matchDAO) {
        this.matchDAO = matchDAO;
    }

    public List<Match> getAllMatches() {
        return matchDAO.getAllMatches();
    }

    public Match getMatchById(int id) {
        return matchDAO.getMatchById(id);
    }

    public boolean addMatch(Match match) {
        return matchDAO.addMatch(match);
    }

    public boolean updateMatch(Match match) {
        return matchDAO.updateMatch(match);
    }

    public boolean deleteMatch(int id) {
        return matchDAO.deleteMatch(id);
    }

    // Thống kê
    public int getWins(int teamID) {
        return matchDAO.countWins(teamID);
    }

    public int getDraws(int teamID) {
        return matchDAO.countDraws(teamID);
    }

    public int getLosses(int teamID) {
        return matchDAO.countLosses(teamID);
    }

    // Dữ liệu cho dashboard
    public double getWinRate(int teamID) {
        int total = getWins(teamID) + getDraws(teamID) + getLosses(teamID);
        return total == 0 ? 0 : (double) getWins(teamID) / total * 100;
    }
}
