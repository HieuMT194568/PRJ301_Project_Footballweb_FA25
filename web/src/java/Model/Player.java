package Model;

import java.sql.Date;

public class Player {

    private int playerID;
    private String fullName;
    private String position;
    private String nationality;
    private Date birthDate;
    private int shirtNumber;
    private int teamID;  // Foreign key

    public Player() {
    }

    public Player(int playerID, String fullName, String position, String nationality, Date birthDate, int shirtNumber, int teamID) {
        this.playerID = playerID;
        this.fullName = fullName;
        this.position = position;
        this.nationality = nationality;
        this.birthDate = birthDate;
        this.shirtNumber = shirtNumber;
        this.teamID = teamID;
    }

    // Getters & Setters
    public int getPlayerID() {
        return playerID;
    }

    public void setPlayerID(int playerID) {
        this.playerID = playerID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public int getShirtNumber() {
        return shirtNumber;
    }

    public void setShirtNumber(int shirtNumber) {
        this.shirtNumber = shirtNumber;
    }

    public int getTeamID() {
        return teamID;
    }

    public void setTeamID(int teamID) {
        this.teamID = teamID;
    }
}
