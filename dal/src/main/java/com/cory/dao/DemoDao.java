package com.cory.dao;

import com.cory.db.annotations.Dao;
import com.cory.db.annotations.Select;
import com.cory.model.Demo;
import com.cory.vo.DemoVO;

import java.util.List;

/**
 * Created by Cory on 2021/2/17.
 */
@Dao(model = Demo.class)
public interface DemoDao extends BaseDao<Demo> {

    @Select
    List<Demo> listDemo();

    @Select(returnType = DemoVO.class)
    List<DemoVO> listDemoVo();
}
