package login;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface MemberDAO {
	
	public MemberDTO oneMember(String user_id);
	public void insertMember(MemberDTO dto);
	public MemberDTO loginMember(MemberDTO dto);
	public MemberDTO infoMember(String user_id);
	public void updateMember(MemberDTO dto); // 정보 수정
    public void deleteMember(String user_id); // 회원 탈퇴 
    public int idCheck(String user_id);
    public int emailCheck(String email);

}