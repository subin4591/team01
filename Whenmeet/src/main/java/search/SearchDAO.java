package search;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import dto.MeetingDTO;
import dto.SearchPagingDTO;

@Mapper
@Repository
public interface SearchDAO {
	// Search select
	// 검색 게시글 목록
	public List<MeetingDTO> searchList(SearchPagingDTO dto);
	public int searchCount(SearchPagingDTO dto);
}
