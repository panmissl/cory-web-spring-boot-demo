package com.cory.vo;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by Cory on 2021/2/17.
 */
@Data
public class DemoVO implements Serializable {

    private String name;
    private Date birthday;
}
