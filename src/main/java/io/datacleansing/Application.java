package io.datacleansing;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;

@SpringBootApplication
@EnableWebSecurity
@RestController
@CrossOrigin(origins = "*")
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @RequestMapping(value= "/")
    public String hello(){
      String instance  = System.getenv().get("DMC_DEMO_INSTANCE_NAME");
      if(instance == null || instance.length() == 0)
        instance = "default instance";

      return "Hello Summer from " + instance;
    }
}
