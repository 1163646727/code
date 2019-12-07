package ${package_name}.${block}.param;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
* className: ${table_name?cap_first}Param <BR>
* description: ${table_annotation}入参<BR>
* remark: <BR>
* author: ${author} <BR>
* createDate: ${date} <BR>
*/
@Data
public class ${table_name?cap_first}Param {
<#if (table_name?substring(table_name?length-4,table_name?length) = 'Dict') ><#--如果是字典Dict结尾-->
    /** 编码 ${author}*/
    @ApiModelProperty(value = "编码", required = true)
    private String itemCode;

    /** 名称 ${author}*/
    @ApiModelProperty(value = "名称", required = true)
    private String itemName;

    /** 类型 ${author}*/
    @ApiModelProperty(value = "类型", required = true)
    public String itemType;

<#if field?exists><#--field:参数集合-->
<#list field as item>
<#if (item.name?uncap_first != 'id') && (item.name?uncap_first != 'itemCode') && (item.name?uncap_first != 'itemName') && (item.name?uncap_first != 'itemType')>
    /** ${item.annotation!} ${author}*/
    @ApiModelProperty(value = "${item.annotation}", required = true)
<#--根据字段的类型，创建对应的属性-->
<#if (item.type = 'varchar' || item.type = 'text')>
    private String ${item.name?uncap_first};
</#if>
<#if item.type = 'timestamp' >
    private Date ${item.name?uncap_first};
</#if>
<#if item.type = 'numeric' >
    private Float ${item.name?uncap_first};
</#if>
<#if item.type = 'bigint' >
    private Long ${item.name?uncap_first};
</#if>
</#if>
</#list>
</#if>

<#else ><#--如果是字典Dict结尾，否则-->
<#if field?exists><#--field:参数集合-->
<#list field as item>
<#if (item.name != 'id')>
    /** ${item.annotation!} ${author}*/
    @ApiModelProperty(value = "${item.annotation}", required = true)
<#--根据字段的类型，创建对应的属性-->
<#if (item.type = 'varchar' || item.type = 'text')>
    private String ${item.name?uncap_first};
</#if>
<#if item.type = 'timestamp' >
    private Date ${item.name?uncap_first};
</#if>
<#if item.type = 'numeric' >
    private Float ${item.name?uncap_first};
</#if>
<#if item.type = 'bigint' >
    private Long ${item.name?uncap_first};
</#if>
</#if>
</#list>
</#if>
</#if>
}