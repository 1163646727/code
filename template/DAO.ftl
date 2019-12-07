package ${package_name}.${block}.dao;

import org.springframework.stereotype.Repository;
import ${package_name}.${block}.entity.${table_name?cap_first};
import org.ssh.boot.orm.dao.BaseDao;

/**
* interfaceName: ${table_name?cap_first}Dao <BR>
* description: ${table_annotation}数据层<BR>
* remark: <BR>
* author: ${author} <BR>
* createDate: ${date} <BR>
*/
@Repository
public interface ${table_name?cap_first}Dao extends BaseDao<${table_name?cap_first},Long> {

}