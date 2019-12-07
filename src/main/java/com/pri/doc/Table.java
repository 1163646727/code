package com.pri.doc;

/**
 * className: Table <BR>
 * description: 表信息<BR>
 * remark: 元数据的表信息<BR>
 * auther: ChenQi <BR>
 * date: 2019/11/28 22:13 <BR>
 * version 1.0 jdk1.8 <BR>
 */
public class Table {
    /** 名称 ChenQi*/
    private String name;

    /** 注释、备注 ChenQi*/
    private String annotation;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAnnotation() {
        return annotation;
    }

    public void setAnnotation(String annotation) {
        this.annotation = annotation;
    }
}
