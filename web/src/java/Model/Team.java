package Model;

public class Team {
    private int teamID;
    private String teamName;
    private String coach;
    private String stadium;
    private int foundedYear;
    private String country;

    // ✅ Thuộc tính thống kê
    private double winRate;

    // --- Constructors ---
    public Team() {}

    public Team(int teamID, String teamName, String coach, String stadium, int foundedYear, String country) {
        this.teamID = teamID;
        this.teamName = teamName;
        this.coach = coach;
        this.stadium = stadium;
        this.foundedYear = foundedYear;
        this.country = country;
    }

    // --- Getters & Setters ---
    public int getTeamID() {
        return teamID;
    }

    public void setTeamID(int teamID) {
        this.teamID = teamID;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public String getCoach() {
        return coach;
    }

    public void setCoach(String coach) {
        this.coach = coach;
    }

    public String getStadium() {
        return stadium;
    }

    public void setStadium(String stadium) {
        this.stadium = stadium;
    }

    public int getFoundedYear() {
        return foundedYear;
    }

    public void setFoundedYear(int foundedYear) {
        this.foundedYear = foundedYear;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    // --- WinRate ---
    public double getWinRate() {
        return winRate;
    }

    public void setWinRate(double winRate) {
        this.winRate = winRate;
    }

    // --- Optional: hiển thị nhanh cho debug ---
    @Override
    public String toString() {
        return "Team{" +
                "teamID=" + teamID +
                ", teamName='" + teamName + '\'' +
                ", coach='" + coach + '\'' +
                ", stadium='" + stadium + '\'' +
                ", foundedYear=" + foundedYear +
                ", country='" + country + '\'' +
                ", winRate=" + winRate +
                '}';
    }
}
