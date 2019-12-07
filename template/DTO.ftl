package ${package_name}.${block}.dto;

import lombok.Data;

/**
 * className: ${table_name?cap_first}Dto <BR>
 * description: ${table_annotation}出参<BR>
 * remark: <BR>
 * author: ${author} <BR>
 * createDate: ${date} <BR>
 */
@Data
public class ${table_name?cap_first}Dto {
    /** 主键 ChenQi*/
    private Long id;
<#if (table_name?substring(table_name?length-4,table_name?length) = 'Dict') ><#--如果是字典Dict结尾-->

    /** 编码 ${author}*/
    private String itemCode;

    /** 名称 ${author}*/
    private String itemName;

    /** 类型 ${author}*/
    public String itemType;

    /** 拼音码 ChenQi*/
    public String itemPy;

    /** 五笔码 ChenQi*/
    public String itemWb;
<#if field?exists><#--field:参数集合-->
<#list field as item>
<#if (item.name?uncap_first != 'id') && (item.name?uncap_first != 'itemCode') && (item.name?uncap_first != 'itemName') && (item.name?uncap_first != 'itemType')>

    /** ${item.annotation!} ${author}*/
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
<#if (item.name?uncap_first != 'id')>

    /** ${item.annotation!} ${author}*/
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
