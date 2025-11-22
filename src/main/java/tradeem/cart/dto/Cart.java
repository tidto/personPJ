//
//  Created by IntelliJ IDEA.
//  User: tidto
//  Date: 2025. 11. 22.
//  Time: PM 10:31
//  To change this template use File | Settings | File Templates.
//
package tradeem.cart.dto;

import tradeem.game.dto.Game;

public class Cart extends Game {
	private int cartNo;
    private String memberId;

    public int getCartNo() { return cartNo; }
    public void setCartNo(int cartNo) { this.cartNo = cartNo; }
    public String getMemberId() { return memberId; }
    public void setMemberId(String memberId) { this.memberId = memberId; }
}
