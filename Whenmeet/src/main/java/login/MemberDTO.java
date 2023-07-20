package login;

import org.springframework.stereotype.Component;

@Component
public class MemberDTO {
	String user_id, name;
	String pw;
	String phone, email, address, profile_url;

	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	MemberDTO(String user_id, String pw){
		System.out.println("매개변수 있는 생성자 호출");
		this.user_id = user_id;
		this.pw = pw;
	}
	MemberDTO(){
		System.out.println("MemberDTO 기본 생성자 호출");
	}
	
	public MemberDTO(String user_id, String name, String pw, String phone, String email) {
		super();
		this.user_id = user_id;
		this.pw = pw;
		this.name = name;
		
		this.phone = phone;
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getProfile_url() {
		return profile_url;
	}
	public void setProfile_url(String profile_url) {
		this.profile_url = profile_url;
	}
	public String toString() {
		return user_id+":"+pw+":"+name+":"+address+":"+phone+":"+email;
	}
	
	
}
