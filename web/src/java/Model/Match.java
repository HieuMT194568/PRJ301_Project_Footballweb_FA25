package Model;

import java.sql.Timestamp;

public class Match {

    private int matchID;
    private int homeTeamID;
    private int awayTeamID;
    private Timestamp matchDate;
    private String stadium;
    private int homeScore;
    private int awayScore;

    public Match() {
    }

    public Match(int matchID, int homeTeamID, int awayTeamID, Timestamp matchDate, String stadium, int homeScore, int awayScore) {
        this.matchID = matchID;
        this.homeTeamID = homeTeamID;
        this.awayTeamID = awayTeamID;
        this.matchDate = matchDate;
        this.stadium = stadium;
        this.homeScore = homeScore;
        this.awayScore = awayScore;
    }

    // Getters & Setters
    public int getMatchID() {
        return matchID;
    }

    public void setMatchID(int matchID) {
        this.matchID = matchID;
    }

    public int getHomeTeamID() {
        return homeTeamID;
    }

    public void setHomeTeamID(int homeTeamID) {
        this.homeTeamID = homeTeamID;
    }

    public int getAwayTeamID() {
        return awayTeamID;
    }

    public void setAwayTeamID(int awayTeamID) {
        this.awayTeamID = awayTeamID;
    }

    public Timestamp getMatchDate() {
        return matchDate;
    }

    public void setMatchDate(Timestamp matchDate) {
        this.matchDate = matchDate;
    }

    public String getStadium() {
        return stadium;
    }

    public void setStadium(String stadium) {
        this.stadium = stadium;
    }

    public int getHomeScore() {
        return homeScore;
    }

    public void setHomeScore(int homeScore) {
        this.homeScore = homeScore;
    }

    public int getAwayScore() {
        return awayScore;
    }

    public void setAwayScore(int awayScore) {
        this.awayScore = awayScore;
    }
}
