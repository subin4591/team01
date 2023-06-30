package dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface MainDAO {

	public List<String> myApplication(String user_id);
	public List<String> myWrite(String user_id);
	public List<String> myGroup(String user_id);
	public List<String> rankList();
	
}
