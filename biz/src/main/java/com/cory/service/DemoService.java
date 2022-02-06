package com.cory.service;

import com.cory.dao.DemoDao;
import com.cory.model.Demo;
import com.cory.vo.DemoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Cory on 2021/2/17.
 */
@Service
@Scope(proxyMode = ScopedProxyMode.TARGET_CLASS)
@Transactional
public class DemoService extends BaseService<Demo> {

    @Autowired
    private DemoDao demoDao;

    @Override
    public DemoDao getDao() {
        return demoDao;
    }

    public List<Demo> listDemo() {
        return demoDao.listDemo();
    }

    public List<DemoVO> listDemoVo() {
        return demoDao.listDemoVo();
    }
}
