package Model;

import java.sql.Timestamp;
public class Match {

    private int matchID;
    private int homeTeamID;
    private int awayTeamID;
    private int homeScore;
    private int awayScore;
    private Timestamp matchDate;
    private String stadium;

    public Match() {
    }

    private String homeTeamName;
    private String awayTeamName;

    public String getHomeTeamName() {
        return homeTeamName;
    }

    public void setHomeTeamName(String homeTeamName) {
        this.homeTeamName = homeTeamName;
    }

    public String getAwayTeamName() {
        return awayTeamName;
    }

    public void setAwayTeamName(String awayTeamName) {
        this.awayTeamName = awayTeamName;
    }

    public Match(int matchID, int homeTeamID, int awayTeamID, int homeScore, int awayScore, Timestamp matchDate, String stadium) {
        this.matchID = matchID;
        this.homeTeamID = homeTeamID;
        this.awayTeamID = awayTeamID;
        this.homeScore = homeScore;
        this.awayScore = awayScore;
        this.matchDate = matchDate;
        this.stadium = stadium;
    }

    // Getters và Setters
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

}
