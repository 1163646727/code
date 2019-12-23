package ${package_name};

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.test.web.servlet.MockMvc;
import org.ssh.boot.dto.CommResp;
import ${package_name}.${block}.dao.${table_name?cap_first}Dao;
import ${package_name}.${block}.dto.${table_name?cap_first}Dto;
import ${package_name}.${block}.entity.${table_name?cap_first};
import ${package_name}.${block}.service.${table_name?cap_first}Service;
import ${package_name}.service.BaseDataUtil;
import ${package_name}.service.${table_name?cap_first}TestService;
import ${package_name}.utils.cache.ICache;
import java.util.List;

/**
 * className: ${table_name?cap_first}ControllerTest <BR>
 * description: ${table_annotation}测试类<BR>
 * remark: <BR>
 * author: ${author} <BR>
 * createDate: ${date} <BR>
 */
public class ${table_name?cap_first}ControllerTest extends BaseTest {
    @Autowired
    private MockMvc mockMvc;
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
        // 新增 ${author}
        String responseString = ${table_name?uncap_first}TestService.save(jsob,mockMvc,devToken);
        CommResp<${table_name?cap_first}Dto> commResp = JSONObject
        .parseObject(responseString, new TypeReference<CommResp<${table_name?cap_first}Dto>>() {
        });
        ${table_name?cap_first}Dto itemDto = commResp.getData().getDataInfo();
        // 断言 ${author}
        Long id = itemDto.getId();
        ${table_name?cap_first} item = ${table_name?uncap_first}Dao.findById(id).get();
        Assert.assertNotNull(item.getId());
        JSONObject classObj = (JSONObject) JSON.toJSON(item);
        Assert.assertTrue(BaseDataUtil.assertValues(jsob, classObj));
        Assert.assertEquals("SUCCESS", JSON.parseObject(responseString).getString("code"));
    }

    @Test
    public void deleteTest() throws Exception{
        // 获取数据 ${author}
        JSONObject jsob = getJsonData("${table_name?uncap_first}", ";", 1);
        // 新增数据  ${author};
        String responseString = ${table_name?uncap_first}TestService.save(jsob,mockMvc,devToken);
        CommResp<${table_name?cap_first}Dto> commResp = JSONObject
        .parseObject(responseString, new TypeReference<CommResp<${table_name?cap_first}Dto>>() {
        });
        ${table_name?cap_first}Dto itemDto = commResp.getData().getDataInfo();
        // 断言数据存在 ${author};
        Long id = itemDto.getId();
        Assert.assertNotNull(${table_name?uncap_first}Dao.findById(id).get().getId());
        String[] ids = {String.valueOf(id)};
        // 删除 ${author};
        ${table_name?uncap_first}TestService .delete(ids,mockMvc,devToken);
        // 断言数据已被删除 ${author};
        Assert.assertFalse(${table_name?uncap_first}Dao.findById(id).isPresent());
        Assert.assertEquals("SUCCESS", JSON.parseObject(responseString).getString("code"));
    }

    @Test
    public void updateTest() throws Exception{
        // 获取数据 ${author}
        JSONObject jsob = getJsonData("${table_name?uncap_first}", ";", 1);
        // 新增数据  ${author};
        String responseString = ${table_name?uncap_first}TestService.save(jsob,mockMvc,devToken);
        CommResp<${table_name?cap_first}Dto> commResp = JSONObject
        .parseObject(responseString, new TypeReference<CommResp<${table_name?cap_first}Dto>>() {
        });
        ${table_name?cap_first}Dto itemDto = commResp.getData().getDataInfo();
        // 断言数据存在 ${author};
        Long id = itemDto.getId();
        Assert.assertNotNull(${table_name?uncap_first}Dao.findById(id).get().getId());
        // 获取修改的数据 ${author}
        jsob = getJsonData("${table_name?uncap_first}", ";", 2);
        jsob.put("id", String.valueOf(id));
        ${table_name?uncap_first}TestService.update(jsob,mockMvc,devToken);

        // 查询最新的数据 ${author}
        JSONObject classObj = (JSONObject) JSON.toJSON(${table_name?uncap_first}Dao.findById(id).get());
        // 验证数据
        Assert.assertTrue(BaseDataUtil.assertValues(jsob, classObj));
        Assert.assertEquals("SUCCESS", JSON.parseObject(responseString).getString("code"));
    }

    @Test
    public void findByIdTest() throws Exception{
        // 获取数据 ${author}
        JSONObject jsob = getJsonData("${table_name?uncap_first}", ";", 1);
        // 新增数据  ${author};
        String responseString = ${table_name?uncap_first}TestService.save(jsob,mockMvc,devToken);
        CommResp<${table_name?cap_first}Dto> commResp = JSONObject
        .parseObject(responseString, new TypeReference<CommResp<${table_name?cap_first}Dto>>() {
            });
        ${table_name?cap_first}Dto itemDto = commResp.getData().getDataInfo();
        // 新增数据的主键  ${author};
        Long id = itemDto.getId();
        // 根据id查询 ${author}
        responseString = ${table_name?uncap_first}TestService.findById(id,mockMvc,devToken);
        commResp = JSONObject
        .parseObject(responseString, new TypeReference<CommResp<${table_name?cap_first}Dto>>() {
        });
        itemDto = commResp.getData().getDataInfo();
        Assert.assertNotNull(itemDto.getId());
        JSONObject classObj = (JSONObject) JSON.toJSON(${table_name?uncap_first}Dao.findById(id).get());
        Assert.assertTrue(BaseDataUtil.assertValues(jsob, classObj));
        Assert.assertEquals("SUCCESS", JSON.parseObject(responseString).getString("code"));
    }

    @Test
    public void queryTest() throws Exception{
        // 获取数据 ${author}
        JSONObject jsob = getJsonData("${table_name?uncap_first}", ";", 1);
        // 新增数据  ${author};
        String responseString = ${table_name?uncap_first}TestService.save(jsob,mockMvc,devToken);
        CommResp<${table_name?cap_first}Dto> commResp = JSONObject
        .parseObject(responseString, new TypeReference<CommResp<${table_name?cap_first}Dto>>() {
        });
        // 根据条件分页查询 ${author}
        ${table_name?uncap_first}TestService.query(mockMvc,devToken);

        CommResp<List<${table_name?cap_first}Dto>> commResp2 = JSONObject
        .parseObject(responseString, new TypeReference<CommResp<List<${table_name?cap_first}Dto>>>() {
        });
        List<${table_name?cap_first}Dto> itemList =commResp2.getData().getDataInfo();
        ${table_name?cap_first}Dto item = itemList.get(0);
        // 断言 ChenQi
        Assert.assertNotNull(item.getId());
        JSONObject classObj = (JSONObject) JSON.toJSON(item);
        Assert.assertTrue(BaseDataUtil.assertValues(jsob, classObj));
        Assert.assertEquals("SUCCESS", JSON.parseObject(responseString).getString("code"));
    }
}
