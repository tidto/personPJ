//
//  Created by IntelliJ IDEA.
//  User: tidto
//  Date: 2025. 11. 20.
//  Time: PM 11:02
//  To change this template use File | Settings | File Templates.
//
package tradeem.member.service;

import tradeem.member.dao.MemberDAO;
import tradeem.member.dto.Member;

public class MemberService {
    
    private static MemberService instance = new MemberService();
    public static MemberService getInstance() { return instance; }
    private MemberService() {}
    
    private MemberDAO dao = MemberDAO.getInstance();

    // 로그인 서비스
    public Member login(String id, String pw) {
        return dao.checkLogin(id, pw);
    }

    // 회원가입 서비스
    public int join(Member dto) {
        return dao.insertMember(dto);
    }
    public boolean isIdExist(String id) {
        return dao.isIdExist(id);
    }
    
    // 코인 충전
    public int chargeCoin(String id, int amount) {
        return dao.updateCoin(id, amount);
    }

    // 회원 정보 갱신
    public Member getMember(String id) {
        return dao.getMember(id);
    }
}