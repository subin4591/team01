package schedule;

import java.util.List;

import dto.GroupDTO;
import dto.GroupUserDTO;
import dto.UserDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface scheduleMapper {
	List<UserDTO> selectUser() throws Exception;
	List<GroupDTO> selectGroup() throws Exception;
	GroupDTO selectGroupOne(String group_id) throws Exception;
	List<GroupUserDTO> selectGroupUser() throws Exception;
}