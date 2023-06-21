package com.project.wm;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"main","login","schedule"}) 
public class WhenmeetApplication {

	public static void main(String[] args) {
		SpringApplication.run(WhenmeetApplication.class, args);
	}

}
