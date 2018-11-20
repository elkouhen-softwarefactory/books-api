package com.softeam.helloworld.resources;

import com.softeam.helloworld.dto.MessageDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.Collection;

@RestController
public class HelloResource {

    private final Logger logger = LoggerFactory.getLogger(HelloResource.class);

    @GetMapping(path = "/helloworld")
    Collection<MessageDTO> helloworld() {

        logger.info("Helloworld Ressource called !");
        return Arrays.asList(new MessageDTO(1, "French", "Bonjour tout le monde !"));
    }
}
