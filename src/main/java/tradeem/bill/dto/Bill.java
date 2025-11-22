//
//  Created by IntelliJ IDEA.
//  User: tidto
//  Date: 2025. 11. 22.
//  Time: PM 10:30
//  To change this template use File | Settings | File Templates.
//
package tradeem.bill.dto;

import java.sql.Date;

import tradeem.game.dto.Game;

public class Bill extends Game {
    private String redeemCode;
    private String memberId;
    private Date purchaseDate; 

    public String getRedeemCode() { return redeemCode; }
    public void setRedeemCode(String redeemCode) { this.redeemCode = redeemCode; }
    public String getMemberId() { return memberId; }
    public void setMemberId(String memberId) { this.memberId = memberId; }
    public Date getPurchaseDate() { return purchaseDate; }
    public void setPurchaseDate(Date purchaseDate) { this.purchaseDate = purchaseDate; }
}