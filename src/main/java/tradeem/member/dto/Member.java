//
//  Created by IntelliJ IDEA.
//  User: tidto
//  Date: 2025. 11. 20.
//  Time: PM 11:02
//  To change this template use File | Settings | File Templates.
//
package tradeem.member.dto;

import java.sql.Date;

public class Member {
	
	private String memberId;
	private String memberPw;
    private String memberNm;
    private Date createDate;
    private int rdCoin;
    
    public Member() {}
    
    // 회원가입용 생성자 - reldate recoin = default
    public Member(String memberId, String memberPw, String memberNm) {
        this.memberId = memberId;
        this.memberPw = memberPw;
        this.memberNm = memberNm;
    }
    
    public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPw() {
		return memberPw;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}
	public String getMemberNm() {
		return memberNm;
	}
	public void setMemberNm(String memberNm) {
		this.memberNm = memberNm;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public int getRdCoin() {
		return rdCoin;
	}
	public void setRdCoin(int rdCoin) {
		this.rdCoin = rdCoin;
	}
	
}
