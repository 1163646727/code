package ${package_name}.${block}.web;

import com.github.pagehelper.PageInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import java.util.Arrays;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.ssh.boot.dto.CommResp;
import org.ssh.boot.dto.EkPageInfo;
import org.ssh.boot.execption.ValidateException;
import ${package_name}.${block}.constant.<#if (block = 'dict') >Nurse<#else >${block?cap_first}</#if>CodeMsg;
import ${package_name}.${block}.dto.${table_name?cap_first}Dto;
import ${package_name}.${block}.entity.${table_name?cap_first};
import ${package_name}.${block}.param.${table_name?cap_first}Param;
import ${package_name}.${block}.service.${table_name?cap_first}Service;

/**
 * className: ${table_name?cap_first}Controller <BR>
 * description: ${table_annotation}控制层<BR>
 * remark: <BR>
 * author: ${author} <BR>
 * createDate: ${date} <BR>
 */
@Slf4j
@RestController
@RequestMapping("/${path}")
@Api(value = " ${table_annotation}", tags = " ${table_annotation}")
public class ${table_name?cap_first}Controller {

    @Autowired
    private ${table_name?cap_first}Service ${table_name?uncap_first}Service;

    @PostMapping
    @ApiOperation(value = "新增", notes = "新增")
    public CommResp<${table_name?cap_first}Dto> save(${table_name?cap_first}Param itemParam){
        ${table_name?cap_first}Dto itemDto = ${table_name?uncap_first}Service.save(itemParam);
        return new CommResp<>(itemDto);
    }

    @DeleteMapping
    @ApiOperation(value = "删除", notes = "删除")
    public CommResp delete(@ApiParam(required = true, value = "主键ID") @RequestParam Long... ids) {
        List idList = Arrays.asList(ids);
        ${table_name?uncap_first}Service.deleteAllByIdIn(idList);
        return CommResp.defaultResp();
    }

    @PutMapping
    @ApiOperation(value = "修改", notes = "修改")
    public CommResp<${table_name?cap_first}Dto> update(
        @ApiParam(value = "主键ID", required = true) @RequestParam Long id,
        @ApiParam(value = "修改内容", required = false) ${table_name?cap_first}Param itemParam) {

        // 判断该数据ID是否存在${author};
        ${table_name?cap_first} item = ${table_name?uncap_first}Service.queryByIds(id);
        if (item == null) {
        throw new ValidateException(<#if (block = 'dict') >Nurse<#else >${block?cap_first}</#if>CodeMsg.ERROR_PROMPT, "该数据ID不存在了！");
        }
        // 修改 ${author}
        ${table_name?cap_first}Dto itemDto = ${table_name?uncap_first}Service.update(item, itemParam);
        return  new CommResp<>(itemDto);
    }

    @GetMapping()
    @ApiOperation(value = "分页查询", notes = "根据条件分页查询")
    public CommResp<List<?>> query(
        @ApiParam(value = "页数（从1开始）", required = false) @RequestParam(required = false ,defaultValue = "1") Integer pageNum,
        @ApiParam(value = "每页数量", required = false) @RequestParam(required = false ,defaultValue = "50") Integer pageSize,
        @ApiParam(value = "查询条件", required = false) String query){

        EkPageInfo ekPageInfo = new EkPageInfo(pageNum, pageSize);
        // 根据条件分页查询 ${author}
        PageInfo<${table_name?cap_first}Dto> pageInfo = ${table_name?uncap_first}Service.query(ekPageInfo ,query);
        // 处理返回数据格式 ${author}
        ekPageInfo.setTotalCount(pageInfo.getTotal());
        ekPageInfo.setTotalPageNum(pageInfo.getPages());
        List<?> list = pageInfo.getList();
        return new CommResp(list, ekPageInfo);
    }

    @GetMapping("/findById")
    @ApiOperation(value = "根据ID查询", notes = "根据ID查询")
    public CommResp<${table_name?cap_first}Dto> findById(
        @ApiParam(value = "主键", required = true) @RequestParam(required = true)Long id) {
        // 根据主键查询 ${author}
        ${table_name?cap_first}Dto itemDto = ${table_name?uncap_first}Service.findById(id);
        return new CommResp<>(itemDto);
    }

}
