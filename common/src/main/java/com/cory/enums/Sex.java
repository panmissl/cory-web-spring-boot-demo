package com.cory.enums;

/**
 * Created by Cory on 2021/3/5.
 */
public enum Sex implements CoryEnum {
    MALE("男", 1),
    FEMALE("女", 2),
    SECRET("保密", 3),
    ;

    private String text;
    private Integer order;

    Sex(String text, Integer order) {
        this.text = text;
        this.order = order;
    }

    @Override
    public String text() {
        return text;
    }

    @Override
    public Integer order() {
        return order;
    }
}
