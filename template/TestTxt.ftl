<#if (table_name?substring(table_name?length-4,table_name?length) = 'Dict') ><#--如果是字典Dict结尾-->
itemCode;itemName;itemType<#if field?exists>;<#list 0..(field!?size-1) as i><#if field[i].name?uncap_first != 'id' && field[i].name?uncap_first != 'itemCode' && field[i].name?uncap_first != 'itemName' && field[i].name?uncap_first != 'itemType'>${field[i].name?uncap_first}<#if i!= field!?size-1>;</#if></#if></#list></#if>
a;a;a<#if field?exists>;<#list 0..(field!?size-1) as i><#if field[i].name?uncap_first != 'id' && field[i].name?uncap_first != 'itemCode' && field[i].name?uncap_first != 'itemName' && field[i].name?uncap_first != 'itemType'>${i}<#if i!= field!?size-1>;</#if></#if></#list></#if>
aa;aa;aa<#if field?exists>;<#list 0..(field!?size-1) as i><#if field[i].name?uncap_first != 'id' && field[i].name?uncap_first != 'itemCode' && field[i].name?uncap_first != 'itemName' && field[i].name?uncap_first != 'itemType'>1${i}<#if i!= field!?size-1>;</#if></#if></#list></#if>
<#else ><#--如果是字典Dict结尾，否则-->
<#if field?exists>
<#list 0..(field!?size-1) as i>
<#if field[i].name?uncap_first != 'id'>${field[i].name?uncap_first}<#if i!= field!?size-1>;</#if></#if></#list>
</#if>
<#if field?exists>
<#list 0..(field!?size-1) as i><#if field[i].name?uncap_first != 'id'><#if field[i].type?uncap_first = 'boolean'>true<#if i!= field!?size-1>;</#if><#else>${i}<#if i!= field!?size-1>;</#if></#if></#if></#list>
</#if>
<#if field?exists>
<#list 0..(field!?size-1) as i><#if field[i].name?uncap_first != 'id'><#if field[i].type?uncap_first = 'boolean'>false<#if i!= field!?size-1>;</#if><#else>1${i}<#if i!= field!?size-1>;</#if></#if></#if></#list>
</#if>
</#if>
<#if (table_name?substring(table_name?length-4,table_name?length) = 'Dict') ><#--如果是字典Dict结尾-->
<#else ><#--如果是字典Dict结尾，否则-->
</#if>