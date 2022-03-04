package com.cory.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by Cory on 2021/2/17.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DemoVO implements Serializable {

    private String name;
    private Date birthday;
}
