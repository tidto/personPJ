//
//  Created by IntelliJ IDEA.
//  User: tidto
//  Date: 2025. 11. 21.
//  Time: AM 11:51
//  To change this template use File | Settings | File Templates.
//
package tradeem.game.dto;

import java.util.Date;

public class Game {
    private int gameNo;
    private String gameNm;
    private String gameContent;
    private int costCoin;
    private Date relDate;
    private String genre;
    private int genreNo;
    private String gameVideo;

    public Game() {};
    
    public Game(int gameNo, String gameNm, String gameContent, int costCoin, Date relDate, String genre, int genreNo, String gameVideo) {
        this.gameNo = gameNo;
        this.gameNm = gameNm;
        this.gameContent = gameContent;
        this.costCoin = costCoin;
        this.relDate = relDate;
        this.genre = genre;
        this.genreNo = genreNo;
        this.gameVideo = gameVideo;
    }
    
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

    public int getCostCoin() {
        return costCoin;
    }

    public void setCostCoin(int cost_coin) {
        this.costCoin = cost_coin;
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

    public String getGameVideo() {
		return gameVideo;
	}

	public void setGameVideo(String gameVideo) {
		this.gameVideo = gameVideo;
	}

}
