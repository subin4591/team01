package search;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.MeetingDTO;
import dto.SearchPagingDTO;

@Service("searchservice")
public class SearchService {
	@Autowired
	SearchDAO dao;
	
	// Search select
	// 검색 게시글 목록
	public List<MeetingDTO> searchList(String category, String sort, String search_input, String type, int page) {
		// SearchPagingDTO 생성
		SearchPagingDTO dto = new SearchPagingDTO();
		dto.setCategory(category);
		dto.setSort_type(sort);
		dto.setSearch_input(search_input);
		dto.setType(type);
		dto.calcNum(page, 10);
		
		return dao.searchList(dto);
	}
	public int searchCount(String category, String search_input, String type) {
		// SearchPagingDTO 생성
		SearchPagingDTO dto = new SearchPagingDTO();
		dto.setCategory(category);
		dto.setSearch_input(search_input);
		dto.setType(type);
				
		return dao.searchCount(dto);
	}
}
