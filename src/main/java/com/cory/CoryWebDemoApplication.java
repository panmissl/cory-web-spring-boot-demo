package com.cory;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
public class CoryWebDemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(CoryWebDemoApplication.class, args);
	}

}
