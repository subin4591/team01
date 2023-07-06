package com.project.wm;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"main","login","schedule","meeting","search","group"})
@MapperScan(basePackages = {"main","login","schedule","meeting","search","group"})
public class WhenmeetApplication {

	public static void main(String[] args) {
		SpringApplication.run(WhenmeetApplication.class, args);
	}

}