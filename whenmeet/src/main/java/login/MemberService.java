package login;

import org.apache.ibatis.javassist.compiler.ast.Member;

public interface MemberService {
	MemberDTO oneMember(String id);
	void insertMember(MemberDTO dto);
	MemberDTO loginMember(MemberDTO dto);
	MemberDTO infoMember(String user_id);
	void updateMember(MemberDTO dto);
	void deleteMember(String user_id);
	public int idCheck(String user_id);
	public int emailCheck(String email);
    boolean isUserIdDuplicated(String userId);

}
