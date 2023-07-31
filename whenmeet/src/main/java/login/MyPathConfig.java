package login;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration //xml 대신 자바파일
public class MyPathConfig implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/upload/**").addResourceLocations("file:/Users/chaesuwon/kdt/upload/");
		//<resources mapping="/upload/**" location="file:///c:/kdt/upload/" /> : file:/kdt/upload
	}

}
