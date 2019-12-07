package ${package_name}.${block}.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import ${package_name}.${block}.dto.${table_name?cap_first}Dto;

/**
 * interfaceName: ${table_name?cap_first}Mapper <BR>
 * description: ${table_annotation}数据层<BR>
 * remark: <BR>
 * author: ${author} <BR>
 * createDate: ${date}2 <BR>
 */
@Mapper
public interface ${table_name?cap_first}Mapper {

    /** 根据条件查询 ChenQi*/
    List<${table_name?cap_first}Dto> query(@Param("query") String query<#if (table_name?substring(table_name?length-4,table_name?length) = 'Dict') > ,@Param("hospitalId") String hospitalId</#if>);

}
