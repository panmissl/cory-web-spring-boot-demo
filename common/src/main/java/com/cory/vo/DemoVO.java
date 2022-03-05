package com.cory.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author Cory
 * @date 2021/2/17
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DemoVO implements Serializable {

    private static final long serialVersionUID = -3504412963994655197L;

    private String name;
    private Date birthday;
}
