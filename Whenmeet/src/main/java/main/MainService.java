package main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.MainDTO;

@Service("mainservice")
public class MainService {
	
	@Autowired
	MainDAO dao;
	
	public List<MainDTO> myApplication(String user_id){
		return dao.myApplication(user_id);
	};
	public List<MainDTO> myWrite(String user_id){
		return dao.myWrite(user_id);
	};
	public List<String> myGroup(String user_id){
		return dao.myGroup(user_id);
	};
	public List<MainDTO> rankList(){
		return dao.rankList();
	}
}
