package com.cory.model;

import com.cory.db.annotations.Field;
import com.cory.db.annotations.Model;
import com.cory.db.enums.CoryDbType;
import com.cory.enums.Sex;
import lombok.Data;

import java.util.Date;

/**
 * Created by Cory on 2021/2/17.
 */
@Data
@Model(name = "测试", module = "demo")
public class Demo extends BaseModel {

    @Field(label = "年龄", type = CoryDbType.INT)
    private Integer age;

    @Field(label = "外键ID", type = CoryDbType.BIGINT, desc = "随意的数字")
    private Integer foreignId;

    @Field(label = "存款", type = CoryDbType.DOUBLE)
    private Double balance;

    @Field(label = "姓名", type = CoryDbType.VARCHAR, len = 50, filtered = true)
    private String name;

    @Field(label = "说明", type = CoryDbType.TEXT)
    private String remark;

    @Field(label = "是否儿童", type = CoryDbType.BOOLEAN, filtered = true)
    private Boolean isChild;

    @Field(label = "生日", type = CoryDbType.DATE, filtered = true)
    private Date birthday;

    @Field(label = "时间", type = CoryDbType.DATETIME, desc = "随便选个时间吧", filtered = true)
    private Date time;

    @Field(label = "性别", type = CoryDbType.ENUM, filtered = true)
    private Sex sex;
}
