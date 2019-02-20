package com.softeam.books.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class LoginController {

    @RequestMapping(value = "/app-login", produces = "application/html")
    public String login() {

        return "redirect:/";
    }
}
