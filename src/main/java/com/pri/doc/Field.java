package com.pri.doc;

/**
 * className: Field <BR>
 * description: 字段信息<BR>
 * remark: 元数据的字段<BR>
 * auther: ChenQi <BR>
 * date: 2019/11/28 22:17 <BR>
 * version 1.0 jdk1.8 <BR>
 */
public class Field {
    /** 名称 ChenQi*/
    private String name;

    /** 字段类型 ChenQi*/
    private String type;

    /** 注释、备注信息 ChenQi*/
    private String annotation;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getAnnotation() {
        return annotation;
    }

    public void setAnnotation(String annotation) {
        this.annotation = annotation;
    }
}
