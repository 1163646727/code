<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
    PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${package_name}.${block}.mapper.${table_name?cap_first}Mapper">

    <!-- 根据条件查询 -->
    <select id="query" resultType="${package_name}.${block}.dto.${table_name?cap_first}Dto">
        <#if (table_name?substring(table_name?length-4,table_name?length) = 'Dict') ><#--如果是字典Dict结尾-->
        select t.id ,t.itemCode ,t.itemName ,t.itemType ,t.itemPy,t.itemWb<#if field?exists><#list 0..(field!?size-1) as i><#if field[i].name?uncap_first != 'id' && field[i].name?uncap_first != 'itemCode' && field[i].name?uncap_first != 'itemName' && field[i].name?uncap_first != 'itemType'>,t.${field[i].name?uncap_first} </#if></#list></#if>
        <#else ><#--如果是字典Dict结尾，否则-->
        select t.id ,<#if field?exists><#list 0..(field!?size-1) as i><#if field[i].name?uncap_first != 'id'>t.${field[i].name?uncap_first} <#if i!= field!?size-1>,</#if></#if></#list></#if>
        </#if>
        from T_${table_name} t
        <where>
            <#if (table_name?substring(table_name?length-4,table_name?length) = 'Dict') >
            <if test="hospitalId != null and hospitalId != ''">
                and t.hospitalId = ${r'#{hospitalId}'}
            </if>
            </#if>
            <if test="query != null and query != ''">
            <#if (table_name?substring(table_name?length-4,table_name?length) = 'Dict') ><#--如果是字典Dict结尾-->
                and ( t.itemCode like concat(concat('%',${r'#{query}'}),'%') or t.itemName like concat(concat('%',${r'#{query}'}),'%') or t.itemType like concat(concat('%',${r'#{query}'}),'%') or t.itemPy like concat(concat('%',${r'#{query}'}),'%') or t.itemWb like concat(concat('%',${r'#{query}'}),'%')<#list 0..(field!?size-1) as i><#if field[i].name?uncap_first != 'id' && field[i].name?uncap_first != 'itemCode' && field[i].name?uncap_first != 'itemName' && field[i].name?uncap_first != 'itemType' && field[i].name?uncap_first != 'itemPy' && field[i].name?uncap_first != 'itemWb'> or t.${field[i].name?uncap_first} like concat(concat('%',${r'#{query}'}),'%')</#if></#list> )
            <#else ><#--如果是字典Dict结尾，否则-->
                <#if field?exists>
                and ( <#list 0..(field!?size-1) as i><#if field[i].name?uncap_first != 'id'>t.${field[i].name?uncap_first} like concat(concat('%',${r'#{query}'}),'%')<#if i!= field!?size-1> or </#if></#if></#list> )
                </#if>
            </#if>
            </if>
        </where>
    </select>

</mapper>