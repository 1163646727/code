package ${package_name}.service;

import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.junit.Assert;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultHandlers;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
import java.util.List;

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

    List<List<String>> listA = getData("${table_name?uncap_first}",";");

    public String save(JSONObject jsob,MockMvc mockMvc,String devToken) throws Exception{
        MockHttpServletRequestBuilder builder = BaseDataUtil
        .getBuilder(jsob, "post", "/${path}");
        String responseString = BaseDataUtil.mockExecute(mockMvc, builder, devToken);
        return responseString;
    }

    public String delete(String[] ids,MockMvc mockMvc,String devToken) throws Exception {
        String responseString = mockMvc.perform(
        MockMvcRequestBuilders.delete("/${path}")
        .param("ids",ids)
        .param("access_token",devToken)
        .contentType(MediaType.APPLICATION_FORM_URLENCODED)
        )
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andDo(MockMvcResultHandlers.print())
        .andReturn().getResponse().getContentAsString();
        return responseString;
    }

    public void update(JSONObject jsob,MockMvc mockMvc,String devToken) throws Exception{
        MockHttpServletRequestBuilder builder = BaseDataUtil
        .getBuilder(jsob, "put", "/${path}");
        BaseDataUtil.mockExecute(mockMvc, builder, devToken);
    }

    public String findById(Long id,MockMvc mockMvc,String devToken) throws Exception {
        String responseString = mockMvc.perform(
        MockMvcRequestBuilders.get("/${path}/findById")
        .param("id",String.valueOf(id))
        .param("access_token",devToken)
        .contentType(MediaType.APPLICATION_FORM_URLENCODED)
        )
        .andExpect(MockMvcResultMatchers.status().isOk())
        .andDo(MockMvcResultHandlers.print())
        .andReturn().getResponse().getContentAsString();
        return responseString;
    }

    public String query(MockMvc mockMvc,String devToken) throws Exception{
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
        return responseString;
    }

}
