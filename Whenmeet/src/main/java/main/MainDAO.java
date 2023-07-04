package main;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.MainDTO;

@Mapper
@Repository
public interface MainDAO {

	public List<MainDTO> myApplication(String user_id);
	public List<MainDTO> myWrite(String user_id);
	public List<String> myGroup(String user_id);
	public List<MainDTO> rankList();
	
}
