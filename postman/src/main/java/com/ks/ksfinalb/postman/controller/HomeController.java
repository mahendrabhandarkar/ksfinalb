package com.ks.ksfinalb.postman.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

    @GetMapping("/abc")
    public ModelAndView showPage(ModelAndView mv) {
        return new ModelAndView("index");
    }

    @GetMapping("/")
    public String showIndexPage(Model model) {
        model.addAttribute("message", "Hello Thymeleaf");
        return "index";
    }
}
