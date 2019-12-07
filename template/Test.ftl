package ${package_name};

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import ${package_name}.${block}.dao.${table_name?cap_first}Dao;
import ${package_name}.${block}.dto.${table_name?cap_first}Dto;
import ${package_name}.${block}.service.${table_name?cap_first}Service;
import ${package_name}.service.BaseDataUtil;
import ${package_name}.service.${table_name?cap_first}TestService;
import ${package_name}.utils.cache.ICache;

/**
 * className: ${table_name?cap_first}ControllerTest <BR>
 * description: ${table_annotation}测试类<BR>
 * remark: <BR>
 * author: ${author} <BR>
 * createDate: ${date} <BR>
 */
public class ${table_name?cap_first}ControllerTest extends BaseTest {

    @Autowired
    ICache cache;
    @Value("${r'${oauth2.dev-token}'}")
    private String devToken;
    @Before()
    public void setup() {
        cache.clearAll();
        ${table_name?uncap_first}Service.deleteAll();
    }

    @Autowired
    private ${table_name?cap_first}TestService ${table_name?uncap_first}TestService;
    @Autowired
    private ${table_name?cap_first}Dao ${table_name?uncap_first}Dao;
    @Autowired
    ${table_name?cap_first}Service ${table_name?uncap_first}Service;

    @Test
    public void saveTest() throws Exception{
        // 获取数据 ${author}
        JSONObject jsob = getJsonData("${table_name?uncap_first}", ";", 1);
        ${table_name?cap_first}Dto itemDto = ${table_name?uncap_first}TestService.save(jsob);
        // 断言 ${author}
        Long id = itemDto.getId();
        Assert.assertNotNull(${table_name?uncap_first}Dao.findById(id).get().getId());
    }

    @Test
    public void deleteTest() throws Exception{
        // 获取数据 ${author}
        JSONObject jsob = getJsonData("${table_name?uncap_first}", ";", 1);
        // 新增数据  ${author};
        ${table_name?cap_first}Dto itemDto = ${table_name?uncap_first}TestService.save(jsob);
        // 断言数据存在 ${author};
        Long id = itemDto.getId();
        Assert.assertNotNull(${table_name?uncap_first}Dao.findById(id).get().getId());
        String[] ids = {String.valueOf(id)};
        // 删除 ${author};
        ${table_name?uncap_first}TestService .delete(ids);
        // 断言数据已被删除 ${author};
        Assert.assertFalse(${table_name?uncap_first}Dao.findById(id).isPresent());
    }

    @Test
    public void updateTest() throws Exception{
        // 获取数据 ${author}
        JSONObject jsob = getJsonData("${table_name?uncap_first}", ";", 1);
        // 新增数据  ${author};
        ${table_name?cap_first}Dto itemDto = ${table_name?uncap_first}TestService.save(jsob);
        // 断言数据存在 ${author};
        Long id = itemDto.getId();
        Assert.assertNotNull(${table_name?uncap_first}Dao.findById(id).get().getId());
        // 获取修改的数据 ${author}
        jsob = getJsonData("${table_name?uncap_first}", ";", 2);
        jsob.put("id", String.valueOf(id));
        ${table_name?uncap_first}TestService.update(jsob);

        // 查询最新的数据 ${author}
        JSONObject classObj = (JSONObject) JSON.toJSON(${table_name?uncap_first}Dao.findById(id).get());
        // 验证数据
        Assert.assertTrue(BaseDataUtil.assertValues(jsob, classObj));
    }

    @Test
    public void findByIdTest() throws Exception{
        // 获取数据 ${author}
        JSONObject jsob = getJsonData("${table_name?uncap_first}", ";", 1);
        // 新增数据  ${author};
        ${table_name?cap_first}Dto itemDto =${table_name?uncap_first}TestService.save(jsob);
        // 新增数据主键  ${author};
        Long id = itemDto.getId();
        // 断言 ${author}
        Assert.assertNotNull(${table_name?uncap_first}TestService.findById(id).getId());
    }

    @Test
    public void queryTest() throws Exception{
        // 获取数据 ${author}
        JSONObject jsob = getJsonData("${table_name?uncap_first}", ";", 1);
        // 新增数据  ${author};
        ${table_name?cap_first}Dto itemDto =${table_name?uncap_first}TestService.save(jsob);
        // 根据条件分页查询 ${author}
        ${table_name?uncap_first}TestService.query();
    }
}
