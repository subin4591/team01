package main;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.GroupDTO;
import dto.MainDTO;

@Mapper
@Repository
public interface MainDAO {

	public List<MainDTO> myApplication(String user_id);
	public List<MainDTO> myWrite(String user_id);
	public List<GroupDTO> myGroup(String user_id);
	public List<MainDTO> rankList();
	public void address(String address,String group_id);
	
	
}
