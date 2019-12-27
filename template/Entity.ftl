package ${package_name}.${block}.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.validation.constraints.NotNull;
import lombok.Data;
<#if (table_name?substring(table_name?length-4,table_name?length) = 'Dict') >
import org.ssh.boot.businessCommon.entity.BaseItemEntity;
<#else >
import org.ssh.boot.businessCommon.entity.BaseBusinessEntity;
</#if>


/**
 * className:  ${table_name?cap_first} <BR>
 * description: ${table_annotation} <BR>
 * remark: <BR>
 * author: ${author} <BR>
 * createDate: ${date} <BR>
 */
@Data
@Entity
@Table(name = "T_${table_name?cap_first}")
<#if (table_name?substring(table_name?length-4,table_name?length) = 'Dict') ><#--如果是字典Dict结尾-->
public class ${table_name?cap_first} extends BaseItemEntity {
<#else ><#--如果是字典Dict结尾，否则-->
public class ${table_name?cap_first} extends BaseBusinessEntity {
</#if>
<#if (table_name?substring(table_name?length-4,table_name?length) = 'Dict') ><#--如果是字典Dict结尾-->
<#if field?exists><#--field:参数集合-->
<#list field as item>
<#--根据字段的类型，创建对应的属性-->
<#if (item.name?uncap_first != 'id') && (item.name?uncap_first != 'itemCode') && (item.name?uncap_first != 'itemName') && (item.name?uncap_first != 'itemType')>
<#if item.canNull = '0'>
    @NotNull
    @Column(nullable = false)
</#if>
    /** ${item.annotation!} ${author}*/
<#if (item.type = 'varchar' || item.type = 'text' || item.type = 'String')>
    private String ${item.name?uncap_first};
</#if>
<#if item.type = 'timestamp' >
    private Date ${item.name?uncap_first};
</#if>
<#if (item.type = 'numeric' || item.type = 'Float') >
    private Float ${item.name?uncap_first};
</#if>
<#if (item.type = 'bigint' || item.type = 'Long'|| item.type = 'long') >
    private Long ${item.name?uncap_first};
</#if>
<#if (item.type = 'int' || item.type = 'Integer') >
    private Integer ${item.name?uncap_first};
</#if>
<#if (item.type = 'Boolean' || item.type = 'boolean') >
    private Boolean ${item.name?uncap_first};
</#if>
</#if>

</#list>
</#if>
<#else ><#--如果是字典Dict结尾，否则-->
<#if field?exists><#--field:参数集合-->
<#list field as item>
<#--根据字段的类型，创建对应的属性-->
<#if (item.name != 'id')>
<#if item.canNull = '0'>
    @NotNull
    @Column(nullable = false)
</#if>
    /** ${item.annotation!} ${author}*/
<#if (item.type = 'varchar' || item.type = 'text' || item.type = 'String')>
    private String ${item.name?uncap_first};
</#if>
<#if item.type = 'timestamp' >
    private Date ${item.name?uncap_first};
</#if>
<#if (item.type = 'numeric' || item.type = 'Float') >
    private Float ${item.name?uncap_first};
</#if>
<#if (item.type = 'bigint' || item.type = 'Long'|| item.type = 'long') >
    private Long ${item.name?uncap_first};
</#if>
<#if (item.type = 'int' || item.type = 'Integer') >
    private Integer ${item.name?uncap_first};
</#if>
<#if (item.type = 'Boolean' || item.type = 'boolean') >
    private Boolean ${item.name?uncap_first};
</#if>
</#if>

</#list>
</#if>
</#if>
}