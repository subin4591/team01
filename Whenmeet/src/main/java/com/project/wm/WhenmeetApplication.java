package com.project.wm;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@SpringBootApplication
@ComponentScan(basePackages = {"main","login","schedule","meeting"})
@MapperScan(basePackages = {"main","login","schedule","meeting"})
public class WhenmeetApplication {

	public static void main(String[] args) {
		SpringApplication.run(WhenmeetApplication.class, args);
	}

}