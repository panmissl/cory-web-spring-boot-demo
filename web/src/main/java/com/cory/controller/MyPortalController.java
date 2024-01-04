package com.cory.controller;

import com.cory.web.controller.BasePortalController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * Created by Cory on 2017/5/13.
 */
@Controller
public class MyPortalController extends BasePortalController {

    @GetMapping({"/my_page/{page}"})
    public String page(@PathVariable String page) {
        return page;
    }

}