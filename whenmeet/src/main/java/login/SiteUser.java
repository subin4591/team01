package login;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
public class SiteUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true)
    private String username; 

    private String password; 

    @Column(unique = true)
    private String email; // 이메일 필

    private String name;     // 이름 필드
    private String address; // 주소 필드
    
    @Column(unique = true)
    private String phone;   // 폰 번호 필드

}