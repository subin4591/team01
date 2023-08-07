package login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {
    private final MemberDAO memberDAO;
    

    @Autowired
    public MemberServiceImpl(MemberDAO memberDAO) {
        this.memberDAO = memberDAO;
    }

    @Override
    public MemberDTO oneMember(String id) {
        return memberDAO.oneMember(id);
    }

    @Override
    public void insertMember(MemberDTO dto) {
        memberDAO.insertMember(dto);
    }

    @Override
    public MemberDTO loginMember(MemberDTO dto) {
        return memberDAO.loginMember(dto);
    }

    @Override
    public MemberDTO infoMember(String user_id) {
    	System.out.println("-------infoMember-------");
    	return memberDAO.infoMember(user_id);
        
    }

    @Override
    public void updateMember(MemberDTO dto) {
    	System.out.println("-------updateMember-------");
        memberDAO.updateMember(dto);
    }

	@Override
	public void deleteMember(String user_id) {		
		memberDAO.deleteMember(user_id);
	}

	public int idCheck(String user_id) {
	    return memberDAO.idCheck(user_id); // DAO의 idCheck() 메소드를 호출하여 중복 체크 결과를 반환
	}

	@Override
    public int emailCheck(String email) {
        return memberDAO.emailCheck(email);
    }

	@Override
	public boolean isUserIdDuplicated(String userId) {
		// TODO Auto-generated method stub
		return false;
	}
    
}
