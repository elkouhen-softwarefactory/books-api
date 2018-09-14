package com.softeam.helloworld.resources;

import com.softeam.helloworld.dto.MessageDTO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.Collection;

@RestController
public class HelloResource {


    @GetMapping(path = "/helloworld")
    Collection<MessageDTO> findAll() {
        return Arrays.asList(new MessageDTO(1, "French", "Bonjour tout le monde !"));
    }
}
