package com.cory.controller;

import com.cory.model.Demo;
import com.cory.service.DemoService;
import com.cory.vo.DemoVO;
import com.cory.web.controller.BaseAjaxController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * Created by Cory on 2021/2/8.
 */
@RestController
@RequestMapping("/ajax/demo/demo/")
public class DemoAjaxController extends BaseAjaxController<Demo> {

    @Autowired
    private DemoService demoService;

    //setUnauthorizedUrl("error?type=403");403页面的测试

    @GetMapping("hi")
    public String hi(String name) {
        List<Demo> list = demoService.listDemo();
        List<DemoVO> voList = demoService.listDemoVo();
        return "你好: " + name;
    }

    @PostMapping("post")
    public String post(String name) {
        return "你好: " + name;
    }

    @PostMapping("upload")
    public String upload(MultipartFile file, String username) {
        System.out.println("content type: " + file.getContentType());
        System.out.println("name: " + file.getName());
        System.out.println("origi name: " + file.getOriginalFilename());
        System.out.println(file.getContentType());
        System.out.println("username: " + username);
        return "SUCCESS";
    }

    @Override
    public DemoService getService() {
        return demoService;
    }
}
