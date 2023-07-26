package search;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dto.MeetingDTO;
import dto.SearchDTO;

@Controller
public class SearchController {
	@Autowired
	@Qualifier("searchservice")
	SearchService service;
	
	int div_num = 10;
	
	@RequestMapping("/search")
	public ModelAndView search(String search_input,
			@RequestParam(value="category", defaultValue="전체") String category,
			@RequestParam(value="type", defaultValue="title_contents") String type) {
		// SearchDTO 생성
		SearchDTO dto = new SearchDTO();
		dto.setSearch_input(search_input);
		dto.setCategory(category);
		dto.setType(type);
		
		// 검색 결과 목록
		List<MeetingDTO> meeting_list = service.searchList(category, "time", search_input, type, 1);
		
		// 검색 결과 개수
		int total_cnt = service.searchCount(category, search_input, type);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("dto", dto);
		mv.addObject("meeting_list", meeting_list);
		mv.addObject("total_cnt", total_cnt);
		mv.addObject("div_num", div_num);
		mv.setViewName("search/search");
		return mv;
	}
	
	@RequestMapping("/search/sort")
	@ResponseBody
	public List<MeetingDTO> searchSort(String category, String type, String search_input, String sort) {
		return service.searchList(category, sort, search_input, type, 1);
	}
	
	@RequestMapping("/search/page")
	@ResponseBody
	public List<MeetingDTO> searchPage(String category, String type, String search_input, String sort, int page) {
		return service.searchList(category, sort, search_input, type, page);
	}
}
