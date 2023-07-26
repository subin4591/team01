package login;


import java.io.IOException;
import java.util.List;
import java.util.UUID;
import java.io.File;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.IOException;
import org.apache.ibatis.javassist.compiler.ast.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MemberBoardController {
	@Autowired
	@Qualifier("memberServiceImpl")
	MemberService service;
	
@GetMapping("/login")
    public String showLoginPage() {
        // login_login.jsp로 이동
        return "/login/login_login";
    }

@GetMapping("/boardlogin")
public String loginform() {
    return "/login/login_login";
}

@PostMapping("/boardlogin")
public String loginprocess(String user_id, String pw, HttpSession session) {
    // 1. c_member id, pw 확인
    MemberDTO dto = service.oneMember(user_id);
    if (dto != null && dto.getPw().equals(pw)) {
        session.setAttribute("session_id", user_id);
    } else {
        session.removeAttribute("session_id");
        // 로그인 실패 처리 (예: 메시지 출력 또는 다시 로그인 페이지로 이동)
    }
    return "login/main";
}

@RequestMapping("/boardlogout")
public String logout(HttpSession session) {
    session.removeAttribute("session_id");
    return "redirect:/"; // 로그아웃 후 메인 페이지로 이동하도록 설정
}

@GetMapping("/join")
public String signupform() {
	return "/login/login_join";
}

@PostMapping("/signup")
public ModelAndView signupForm(MemberDTO dto) {
	System.out.println("=======================signup 이동=================="); 
	System.out.println("파라미터유저아이디 : " + dto.getUser_id());
	//1. 회원가 form data 받기 
	//2. 서비스 로직 구현 
	 // 프로필 사진을 받지 않으므로 profile_url은 빈 문자열로 설정
	dto.setProfile_url("/img/user_logo.png");

	service.insertMember(dto);	
	ModelAndView mv = new ModelAndView();
	mv.addObject("memberresult", "회원 가입 성공");
	mv.setViewName("/login/register");
	return mv;
}

@PostMapping("/loginProcess")
public ModelAndView login(String user_id, String pw, HttpSession session) {
    System.out.println("--------로그인----------");
    System.out.println("파라미터유저아이디 : " + user_id + " " + pw);

    // 1. 사용자 정보 확인
    MemberDTO dto = new MemberDTO();
    dto.setUser_id(user_id);
    dto.setPw(pw);

    // 로그인 정보와 프로필 사진을 함께 가져옴
    MemberDTO dtore = service.infoMember(user_id);

    ModelAndView mv = new ModelAndView();
    if (dtore != null && dtore.getPw().equals(pw)) {
        // 로그인 성공 시 세션에 loggedIn과 session_id, session_url 저장
        session.setAttribute("loggedIn", true);
        session.setAttribute("session_id", user_id);
        session.setAttribute("session_url", dtore.getProfile_url());
        mv.setViewName("redirect:/"); // 로그인 성공 시 "/" 주소로 리다이렉트
    } else {
        // 로그인 실패 시 에러 메시지 설정
        mv.addObject("errorMessage", "아이디 또는 비밀번호를 확인해주세요.");
        // 로그인 실패 시에도 loggedIn 변수를 세션에 저장
        session.setAttribute("loggedIn", false);
        mv.setViewName("/login/login_login"); // 로그인 실패 시 로그인 페이지로 유지
    }

    return mv;
}

////jsp
//${detaildto.seq } //detaildto.getseq();
////controller
//BoardDTO detaildto = service.xxxxxx(seq);
//mv.addObject("detaildto", detaildto);

@GetMapping("/myinfo")
public ModelAndView myinfoForm(HttpSession session) {
    // 로그인 상태 확인
    Object session_id = session.getAttribute("session_id");
    if (session_id == null) {
        // 로그인되지 않은 상태이므로 로그인 페이지로 리다이렉트
        return new ModelAndView("redirect:/login"); // 로그인 페이지로 리다이렉트하는 예시 코드
    }

    // 로그인된 상태이므로 마이페이지 정보 조회 및 뷰 반환
    System.out.println("--------myinfo----------");
    System.out.println("파라미터유저아이디 : " + session_id);
    MemberDTO dto = service.infoMember(session_id.toString());
    ModelAndView mv = new ModelAndView();
    mv.addObject("dto", dto);
    mv.addObject("session_url", dto.getProfile_url()); // 프로필 사진 파일 경로를 뷰로 전달
    System.out.println(dto.getProfile_url());
    mv.setViewName("login/login_info");
    return mv;
}

// 회원 정보 수정 페이지 @
@RequestMapping("/userUpdate")
public String userUpdate() {
	return "userUpdate";
}

// 회원 정보 수정 
@PostMapping("/updateMember")
public ModelAndView updateMember(MemberDTO dto, HttpSession session, @RequestParam("profile") MultipartFile file) {
    ModelAndView mv = new ModelAndView();

    if (file.isEmpty()) {
        // 파일을 업로드하지 않은 경우 기존의 프로필 사진 경로를 유지
        MemberDTO originalDto = service.infoMember((String) session.getAttribute("session_id"));
        dto.setProfile_url(originalDto.getProfile_url());
    } else {
        try {
            // 파일을 업로드한 경우 기존의 코드와 동일하게 처리
            String uploadPath = "프로필_사진_업로드_경로"; // 업로드 경로 설정
            String originalFilename = file.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String savedFilename = UUID.randomUUID() + extension;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            File uploadedFile = new File(uploadPath, savedFilename);
            file.transferTo(uploadedFile);
            dto.setProfile_url(uploadedFile.getAbsolutePath());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // 기존 코드... (비밀번호 변경, 이름 변경 등의 로직)

    // 회원 정보 업데이트
    service.updateMember(dto);

    // 업데이트된 프로필 사진 URL을 세션에 저장
    session.setAttribute("session_url", dto.getProfile_url());

    // 정보 수정 후 마이페이지로 리다이렉트
    mv.setViewName("redirect:/mypage");

    return mv;
}

// 회원 탈퇴
@GetMapping("/withdraw")
public ModelAndView withdrawForm(HttpSession session) {
    ModelAndView mv = new ModelAndView();
    String userId = (String) session.getAttribute("sessionid");
    if (userId == null) {
        mv.setViewName("/login");
    } else {
        mv.setViewName("/login/withdraw");
    }
    return mv;
}

// 회원 탈퇴 처리
@PostMapping("/withdraw")
public ModelAndView withdraw(HttpSession session) {
    ModelAndView mv = new ModelAndView();
    String userId = (String) session.getAttribute("sessionid");
    if (userId == null) {
        mv.setViewName("/login");
    } else {
        service.deleteMember(userId);
        session.invalidate(); // 세션 만료
        mv.addObject("message", "회원 탈퇴가 완료되었습니다.");
        mv.setViewName("/login");
    }
    return mv;
}

@RequestMapping(value = "/deleteMember")
public String deleteMember(String user_id) {
	System.out.println("-----del-----");
	System.out.println(user_id);
    service.deleteMember(user_id);
    return "redirect:/"; // 회원 탈퇴 후 메인 페이지로 이동하도록 설정
}

@PostMapping("/idCheck")
@ResponseBody
public int idCheck(@RequestParam("user_id") String user_id) {
	
	int cnt = service.idCheck(user_id);
	return cnt;
	
}


@PostMapping("/emailCheck")
@ResponseBody
public int emailCheck(@RequestParam("email") String email) {
    int cnt = service.emailCheck(email);
    return cnt;
}




@PostMapping("/uploadProfile")
public String uploadProfile(@RequestParam("profile") MultipartFile file, HttpSession session) {
    if (!file.isEmpty()) {
        try {
            // 파일을 저장할 경로
            String uploadDir = "/Users/chaesuwon/kdt/upload/";
            
            String fileName = session.getAttribute("session_id") + "_" + System.currentTimeMillis() + "_" + file.getOriginalFilename();
            
            // 파일을 지정된 경로에 저장
            File uploadedFile = new File(uploadDir + fileName);
            file.transferTo(uploadedFile);

            // 세션에 업로드된 파일의 경로를 저장합니다.
            session.setAttribute("profile_url", uploadedFile.getAbsolutePath());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    return "redirect:/myinfo"; // 업로드가 완료되면 다시 myinfo 페이지로 이동합니다.
}
}