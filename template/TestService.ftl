package ${package_name}.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.junit.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import ${package_name}.${block}.dto.${table_name?cap_first}Dto;
import ${package_name}.dto.CommResp;

/**
 * className: ${table_name?cap_first}TestService <BR>
 * description: ${table_annotation}测试业务类<BR>
 * remark: <BR>
 * author: ${author} <BR>
 * createDate: ${date} <BR>
 */
@Slf4j
@Service
public class ${table_name?cap_first}TestService extends BaseParamService{

    @Autowired
    private MockMvc mockMvc;
    @Value("${r'${oauth2.dev-token}'}")
    private String devToken;

    List<List<String>> listA = getData("${table_name?uncap_first}",";");

    public ${table_name?cap_first}Dto save(JSONObject jsob) throws Exception{
        MockHttpServletRequestBuilder builder = BaseDataUtil
        .getBuilder(jsob, "post", "/${path}");
        String responseString = BaseDataUtil.mockExecute(mockMvc, builder, devToken);
        CommResp<${table_name?cap_first}Dto> commResp = JSONObject
        .parseObject(responseString, new TypeReference<CommResp<${table_name?cap_first}Dto>>() {
        });
        return commResp.getData().getDataInfo();
    }

    public String delete(String[] ids) throws Exception {
        String responseString = mockMvc.perform(
        MockMvcRequestBuilders.delete("/${path}")
        .param("ids",ids)
        .param("access_token",devToken)
        .contentType(MediaType.APPLICATION_FORM_URLENCODED)
        )
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andDo(MockMvcResultHandlers.print())
        .andReturn().getResponse().getContentAsString();
        System.out.println("--------\r 返回的json = " + responseString);
        return responseString;
    }

    public void update(JSONObject jsob) throws Exception{
        MockHttpServletRequestBuilder builder = BaseDataUtil
        .getBuilder(jsob, "put", "/${path}");
        BaseDataUtil.mockExecute(mockMvc, builder, devToken);
    }

    public void query() throws Exception{
        List<String> list = listA.get(1);
        String responseString = mockMvc.perform(
        MockMvcRequestBuilders.get("/${path}")
        .param("pageNum","1")
        .param("pageSize","50")
        .param("query",list.get(0))
        .param("access_token",devToken)
        .contentType(MediaType.APPLICATION_FORM_URLENCODED)
        )
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andDo(MockMvcResultHandlers.print())
        .andReturn().getResponse().getContentAsString();
        // 断言  ${author};
        Assert.assertEquals("SUCCESS", JSON.parseObject(responseString).getString("code"));
        System.out.println("--------\r 返回的json = " + responseString);
        CommResp<List<?>> commResp = JSONObject
        .parseObject(responseString, new TypeReference<CommResp<List<?>>>() {
        });
        List<?> itemList =commResp.getData().getDataInfo();
        Assert.assertTrue(itemList.size()>0);
    }

    public ${table_name?cap_first}Dto findById(Long id) throws Exception {
        String responseString = mockMvc.perform(
        MockMvcRequestBuilders.get("/${path}/findById")
        .param("id",String.valueOf(id))
        .param("access_token",devToken)
        .contentType(MediaType.APPLICATION_FORM_URLENCODED)
        )
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andDo(MockMvcResultHandlers.print())
        .andReturn().getResponse().getContentAsString();
        // 断言  ChenQi;
        Assert.assertEquals("SUCCESS", JSON.parseObject(responseString).getString("code"));
        System.out.println("--------\r 返回的json = " + responseString);
        CommResp<${table_name?cap_first}Dto> commResp = JSONObject
        .parseObject(responseString, new TypeReference<CommResp<${table_name?cap_first}Dto>>() {
        });
        return commResp.getData().getDataInfo();
    }

}
