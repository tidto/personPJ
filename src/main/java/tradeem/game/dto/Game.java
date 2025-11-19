package tradeem.game.dto;

import java.util.Date;

public class Game {
    private int gameNo;

    public int getGameNo() {
        return gameNo;
    }

    public void setGameNo(int gameNo) {
        this.gameNo = gameNo;
    }

    public String getGameNm() {
        return gameNm;
    }

    public void setGameNm(String gameNm) {
        this.gameNm = gameNm;
    }

    public String getGameContent() {
        return gameContent;
    }

    public void setGameContent(String gameContent) {
        this.gameContent = gameContent;
    }

    public int getCost_coin() {
        return cost_coin;
    }

    public void setCost_coin(int cost_coin) {
        this.cost_coin = cost_coin;
    }

    public Date getRelDate() {
        return relDate;
    }

    public void setRelDate(Date relDate) {
        this.relDate = relDate;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public int getGenreNo() {
        return genreNo;
    }

    public void setGenreNo(int genreNo) {
        this.genreNo = genreNo;
    }

    private String gameNm;
    private String gameContent;
    private int cost_coin;
    private Date relDate;
    private String genre;
    private int genreNo;


}
