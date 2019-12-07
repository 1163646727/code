package com.pri.doc;

import freemarker.template.Template;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * className: CodeGenerateUtils <BR>
 * description: 代码生成器<BR>
 * remark: 工具类<BR>
 * author: ChenQi <BR>
 * createDate: 2019-11-26 20:12 <BR>
 */
public class CodeGenerateUtils {

    /** 注释中的作者 ChenQi*/
    private final String AUTHOR = "ChenQi";
    /** 注释中的日期，这里获取系统当前时间 ChenQi*/
    private final String CURRENT_DATE = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    /** 数据表名称 ChenQi*/
    private  String TABLE_NAME = "TestDict";
    /** 数据库表注释 **/
    private  String TABLE_ANNOTATION = "用户类";
    /** 包的名称 ChenQi*/
    private final String PACKAGE_NAME = "org.ssh.boot";
    /** 代码生成的位置 **/
    private final String DISK_PATH = System.getProperty("user.dir");
    /* 获取当前目录位置 ChenQi*/
    // System.out.println(System.getProperty("user.dir"));//user.dir指定了当前的路径
    private final static String PRO_HISDATA = "sshapp-hisdata";
    private final static String PRO_Manager = "sshapp-manager";
    private final static String PRO_NURSE = "sshapp-nurse";
    private final static String PRO_NURSE_DICT = "sshapp-nurse";
    private final static String PRO_EMR = "sshapp-emr";

    private final static String BLOCK_HISDATA = "hisdata";
    private final static String BLOCK_Manager = "manager";
    private final static String BLOCK_NURSE = "nurse";
    private final static String BLOCK_NURSE_DICT = "dict";
    private final static String BLOCK_EMR = "emr";

    /**
     * 描述：代码生成器的执行入口
     * @param args
     */
    public static void main(String[] args) throws Exception{
        /** 创建代码生成器工具类 ChenQi*/
        CodeGenerateUtils codeGenerateUtils = new CodeGenerateUtils();
        // 选择项目与模块 ChenQi
        String pro = PRO_HISDATA;
        String block = BLOCK_HISDATA;
        /** 创建元数据集合 ChenQi*/
        List<Map<String,Object>> metadataList = generateMetadata();
        for (Map<String,Object> map : metadataList) {
            Table table = (Table) map.get("table");
            List<Field> fieldList = (List<Field>)map.get("field");
            codeGenerateUtils.generate(table,fieldList,pro,block);
        }
    }

    /**
     * methodName: generate <BR>
     * description: 生成代码<BR>
     * remark: 代码生成器的核心方法 <BR>
     * param:  <BR>
     * return: void <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-26 20:22 <BR>
     */
    public void generate(Table table,List<Field> fieldList,String pro,String block) throws Exception{
        try {
            // 生成实体类文件
            generateEntityFile(table,fieldList,pro,block);
            // 生成DTO文件
            generateDTOFile(table,fieldList,pro,block);
            // 生成Param文件 ChenQi
            generateParamFile(table,fieldList,pro,block);
            // 生成Dao文件
            generateDaoFile(table,fieldList,pro,block);
            // 生成MapperXml文件 ChenQi
            genarateMapperXmlFile(table,fieldList,pro,block);
            // 生成Mapper文件
            generateMapperFile(table,fieldList,pro,block);
            // 生成Service服务文件
            generateServiceFile(table,fieldList,pro,block);
            // 生成Controller层文件
            generateControllerFile(table,fieldList,pro,block);
            // 生成Test测试业务文件
            generateTestServiceFile(table,fieldList,pro,block);
            // 生成Test测试文件
            generateTestFile(table,fieldList,pro,block);
            // 生成Test测试数据文件
            generateTestTxtFile(table,fieldList,pro);


        } catch (Exception e) {
            throw new RuntimeException(e);
        }finally{

        }
    }


    /**
     * methodName: generateEntityFile <BR>
     * description:生成实体类文件 <BR>
     * remark: <BR>
     * param: table <BR>
     * param: fieldList <BR>
     * return: void <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 14:54 <BR>
     */
    private void generateEntityFile(Table table,List<Field> fieldList,String pro,String block) throws Exception{

        //文件的后缀
        final String suffix = ".java";
        //文件生成的路径
        final String path = DISK_PATH +"/"+pro+ "/src/main/java/" + PACKAGE_NAME.replace(".", "/")+"/"+block+"/entity/"+toUpperCaseFirstOne(table.getName()) + suffix;
        //文件的模板
        final String templateName = "Entity.ftl";
        /* 生成实体类文件 ChenQi*/
        File mapperFile = new File(path);
        /** 参数集合 ChenQi*/
        Map<String,Object> dataMap = new HashMap<>();
        // 添加表字段集合 ChenQi
        dataMap.put("field", fieldList);
        // 表名 ChenQi
        dataMap.put("table_name", table.getName());
        //表注释
        dataMap.put("table_annotation", table.getAnnotation());
        //项目模块
        dataMap.put("block", block);
        generateFileByTemplate(templateName,mapperFile,dataMap);
    }


    /**
     * methodName: generateDTOFile <BR>
     * description:生成DTO文件 <BR>
     * remark: <BR>
     * param: table <BR>
     * param: fieldList <BR>
     * return: void <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 14:55 <BR>
     */
    private void generateDTOFile(Table table,List<Field> fieldList,String pro,String block) throws Exception{
        final String suffix = "Dto.java";
        final String path = DISK_PATH + "/"+pro+"/src/main/java/" + PACKAGE_NAME.replace(".", "/")+"/"+block+"/dto/"+toUpperCaseFirstOne(table.getName()) + suffix;
        final String templateName = "DTO.ftl";
        File mapperFile = new File(path);
        /** 参数集合 ChenQi*/
        Map<String,Object> dataMap = new HashMap<>();
        // 添加表字段集合 ChenQi
        dataMap.put("field", fieldList);
        // 表名 ChenQi
        dataMap.put("table_name", table.getName());
        //表注释
        dataMap.put("table_annotation", table.getAnnotation());
        //项目模块
        dataMap.put("block", block);
        generateFileByTemplate(templateName,mapperFile,dataMap);
    }


    /**
     * methodName: generateParamFile <BR>
     * description: 生成Param文件 <BR>
     * remark: <BR>
     * param: table <BR>
     * param: fieldList <BR>
     * return: void <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 14:55 <BR>
     */
    private void generateParamFile(Table table,List<Field> fieldList,String pro,String block) throws Exception{
        final String suffix = "Param.java";
        final String path = DISK_PATH + "/"+pro+"/src/main/java/" + PACKAGE_NAME.replace(".", "/")+"/"+block+"/param/"+toUpperCaseFirstOne(table.getName()) + suffix;
        final String templateName = "Param.ftl";
        File mapperFile = new File(path);
        /** 参数集合 ChenQi*/
        Map<String,Object> dataMap = new HashMap<>();
        // 添加表字段集合 ChenQi
        dataMap.put("field", fieldList);
        // 表名 ChenQi
        dataMap.put("table_name", table.getName());
        //表注释
        dataMap.put("table_annotation", table.getAnnotation());
        //项目模块
        dataMap.put("block", block);
        generateFileByTemplate(templateName,mapperFile,dataMap);
    }

    /**
     * methodName: generateControllerFile <BR>
     * description: 生成Controller层文件<BR>
     * remark: <BR>
     * param: table <BR>
     * param: fieldList <BR>
     * return: void <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 14:58 <BR>
     */
    private void generateControllerFile(Table table,List<Field> fieldList,String pro,String block) throws Exception{
        final String suffix = "Controller.java";
        final String path = DISK_PATH + "/"+pro+"/src/main/java/" + PACKAGE_NAME.replace(".", "/")+"/"+block+"/web/"+toUpperCaseFirstOne(table.getName()) + suffix;
        final String templateName = "Controller.ftl";
        File mapperFile = new File(path);
        /** 参数集合 ChenQi*/
        Map<String,Object> dataMap = new HashMap<>();
        // 添加表字段集合 ChenQi
        dataMap.put("field", fieldList);
        // 表名 ChenQi
        dataMap.put("table_name", table.getName());
        //表注释
        dataMap.put("table_annotation", table.getAnnotation());
        // 接口访问路径 ChenQi
        dataMap.put("path", camelToUnderline (toLowerCaseFirstOne(table.getName())));
        //项目模块
        dataMap.put("block", block);
        generateFileByTemplate(templateName,mapperFile,dataMap);
    }

    /**
     * methodName: generateTestFile <BR>
     * description: 生成Test测试文件<BR>
     * remark: <BR>
     * param: table <BR>
     * param: fieldList <BR>
     * return: void <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 14:59 <BR>
     */
    private void generateTestFile(Table table,List<Field> fieldList,String pro,String block) throws Exception{
        final String suffix = "ControllerTest.java";
        final String path = DISK_PATH + "/"+pro+"/src/test/java/" + PACKAGE_NAME.replace(".", "/")+"/"+toUpperCaseFirstOne(table.getName()) + suffix;
        final String templateName = "Test.ftl";
        File mapperFile = new File(path);
        /** 参数集合 ChenQi*/
        Map<String,Object> dataMap = new HashMap<>();
        // 添加表字段集合 ChenQi
        dataMap.put("field", fieldList);
        // 表名 ChenQi
        dataMap.put("table_name", table.getName());
        //表注释
        dataMap.put("table_annotation", table.getAnnotation());
        // 接口访问路径 ChenQi
        dataMap.put("path", camelToUnderline (toLowerCaseFirstOne(table.getName())));
        //项目模块
        dataMap.put("block", block);
        generateFileByTemplate(templateName,mapperFile,dataMap);
    }

    /**
     * methodName: generateTestServiceFile <BR>
     * description: 生成Test测试业务文件<BR>
     * remark: <BR>
     * param: table <BR>
     * param: fieldList <BR>
     * return: void <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 14:58 <BR>
     */
    private void generateTestServiceFile(Table table,List<Field> fieldList,String pro,String block) throws Exception{
        final String suffix = "TestService.java";
        final String path = DISK_PATH + "/"+pro+"/src/test/java/" + PACKAGE_NAME.replace(".", "/")+"/service/"+toUpperCaseFirstOne(table.getName()) + suffix;
        final String templateName = "TestService.ftl";
        File mapperFile = new File(path);
        /** 参数集合 ChenQi*/
        Map<String,Object> dataMap = new HashMap<>();
        // 添加表字段集合 ChenQi
        dataMap.put("field", fieldList);
        // 表名 ChenQi
        dataMap.put("table_name", table.getName());
        //表注释
        dataMap.put("table_annotation", table.getAnnotation());
        // 接口访问路径 ChenQi
        dataMap.put("path", camelToUnderline (toLowerCaseFirstOne(table.getName())));
        //项目模块
        dataMap.put("block", block);
        generateFileByTemplate(templateName,mapperFile,dataMap);
    }

    /**
     * methodName: generateTestTxtFile <BR>
     * description: 生成Test测试数据文件<BR>
     * remark: <BR>
     * param: table <BR>
     * param: fieldList <BR>
     * return: void <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 14:59 <BR>
     */
    private void generateTestTxtFile(Table table,List<Field> fieldList,String pro) throws Exception{
        final String suffix = ".txt";
        final String path = DISK_PATH +"/"+pro+ "/src/test/resources/data/"+toLowerCaseFirstOne(table.getName()) + suffix;
        final String templateName = "TestTxt.ftl";
        File mapperFile = new File(path);
        /** 参数集合 ChenQi*/
        Map<String,Object> dataMap = new HashMap<>();
        // 添加表字段集合 ChenQi
        dataMap.put("field", fieldList);
        // 表名 ChenQi
        dataMap.put("table_name", table.getName());
        //表注释
        dataMap.put("table_annotation", table.getAnnotation());
        generateFileByTemplate(templateName,mapperFile,dataMap);
    }


    /**
     * methodName: generateServiceFile <BR>
     * description:生成Service服务文件 <BR>
     * remark: <BR>
     * param: table <BR>
     * param: fieldList <BR>
     * return: void <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 14:58 <BR>
     */
    private void generateServiceFile(Table table,List<Field> fieldList,String pro,String block) throws Exception{
        final String suffix = "Service.java";
        final String path = DISK_PATH + "/"+pro+"/src/main/java/" + PACKAGE_NAME.replace(".", "/")+"/"+block+"/service/"+toUpperCaseFirstOne(table.getName()) + suffix;
        final String templateName = "Service.ftl";
        File mapperFile = new File(path);
        /** 参数集合 ChenQi*/
        Map<String,Object> dataMap = new HashMap<>();
        // 添加表字段集合 ChenQi
        dataMap.put("field", fieldList);
        // 表名 ChenQi
        dataMap.put("table_name", table.getName());
        //表注释
        dataMap.put("table_annotation", table.getAnnotation());
        //项目模块
        dataMap.put("block", block);
        generateFileByTemplate(templateName,mapperFile,dataMap);
    }

    /**
     * methodName: generateDaoFile <BR>
     * description:生成Dao文件 <BR>
     * remark: <BR>
     * param: table <BR>
     * param: fieldList <BR>
     * return: void <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 14:55 <BR>
     */
    private void generateDaoFile(Table table,List<Field> fieldList,String pro,String block) throws Exception{
        final String suffix = "Dao.java";
        //文件生成的路径
        final String path = DISK_PATH + "/"+pro+"/src/main/java/" + PACKAGE_NAME.replace(".", "/")+"/"+block+"/dao/"+toUpperCaseFirstOne(table.getName()) + suffix;
        //文件的模板
        final String templateName = "DAO.ftl";
        /* 生成实体类文件 ChenQi*/
        File mapperFile = new File(path);
        /** 参数集合 ChenQi*/
        Map<String,Object> dataMap = new HashMap<>();
        // 添加表字段集合 ChenQi
        dataMap.put("field", fieldList);
        // 表名 ChenQi
        dataMap.put("table_name", table.getName());
        //表注释
        dataMap.put("table_annotation", table.getAnnotation());
        //项目模块
        dataMap.put("block", block);
        generateFileByTemplate(templateName,mapperFile,dataMap);
    }

    /**
     * methodName: genarateMapperXmlFile <BR>
     * description:生成MapperXml文件 <BR>
     * remark: <BR>
     * param: table <BR>
     * param: fieldList <BR>
     * return: void <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 14:56 <BR>
     */
    private void genarateMapperXmlFile(Table table,List<Field> fieldList,String pro,String block) throws Exception{
        final String suffix = "Mapper.xml";
        //文件生成的路径
        final String path = DISK_PATH + "/"+pro+"/src/main/resources/mapper/"+toUpperCaseFirstOne(table.getName()) + suffix;
        //文件的模板
        final String templateName = "MapperXml.ftl";
        /* 生成实体类文件 ChenQi*/
        File mapperFile = new File(path);
        /** 参数集合 ChenQi*/
        Map<String,Object> dataMap = new HashMap<>();
        // 添加表字段集合 ChenQi
        dataMap.put("field", fieldList);
        // 表名 ChenQi
        dataMap.put("table_name", table.getName());
        //表注释
        dataMap.put("table_annotation", table.getAnnotation());
        //项目模块
        dataMap.put("block", block);
        generateFileByTemplate(templateName,mapperFile,dataMap);

    }

    /**
     * methodName: generateMapperFile <BR>
     * description:生成Mapper文件 <BR>
     * remark: <BR>
     * param: table <BR>
     * param: fieldList <BR>
     * return: void <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 14:56 <BR>
     */
    private void generateMapperFile(Table table,List<Field> fieldList,String pro,String block) throws Exception{
        final String suffix = "Mapper.java";
        final String path = DISK_PATH + "/"+pro+"/src/main/java/" + PACKAGE_NAME.replace(".", "/")+"/"+block+"/mapper/"+toUpperCaseFirstOne(table.getName()) + suffix;
        final String templateName = "Mapper.ftl";
        /* 生成实体类文件 ChenQi*/
        File mapperFile = new File(path);
        /** 参数集合 ChenQi*/
        Map<String,Object> dataMap = new HashMap<>();
        // 添加表字段集合 ChenQi
        dataMap.put("field", fieldList);
        // 表名 ChenQi
        dataMap.put("table_name", table.getName());
        //表注释
        dataMap.put("table_annotation", table.getAnnotation());
        //项目模块
        dataMap.put("block", block);
        generateFileByTemplate(templateName,mapperFile,dataMap);

    }

    /**
     * methodName: generateFileByTemplate <BR>
     * description: 写入文件内容<BR>
     * remark: <BR>
     * param: templateName 模板名称<BR>
     * param: file 修改的目标文件<BR>
     * param: dataMap 实体类参数集 <BR>
     * return: void <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 20:39 <BR>
     */
    private void generateFileByTemplate(final String templateName,File file,Map<String,Object> dataMap) throws Exception{
        //注释中的作者
        dataMap.put("author",AUTHOR);
        //当前日期
        dataMap.put("date",CURRENT_DATE);
        //包名
        dataMap.put("package_name", PACKAGE_NAME);
        /* 创建字符流 ChenQi*/
        FileOutputStream fos = new FileOutputStream(file);
        /* 文件流，就是修改的目标文件 ChenQi*/
        Writer out = new BufferedWriter(new OutputStreamWriter(fos, "utf-8"),10240);
        /* 获取模板文件 ChenQi*/
        Template template = FreeMarkerTemplateUtils.getTemplate(templateName);
        /** 写入文件内容<BR/>
         *  dataMap:数据集(参数集)ChenQi*/
        template.process(dataMap,out);
    }


    /**
     * methodName: generateMetadata <BR>
     * description: 创建元数据集合<BR>
     * remark: <BR>
     * param:  <BR>
     * return: java.util.List<java.util.Map<java.lang.String,java.lang.Object>> <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 15:04 <BR>
     */
    public static List<Map<String,Object>> generateMetadata(){

        List<Map<String,Object>> metadataList = new ArrayList<>();

        Map<String,Object> entityMap = new HashMap<>();
        Table table = new Table();
        List<Field> list = new ArrayList<>();
        Field field = new Field();
        table.setName("student");
        table.setAnnotation("测试字典表");
        entityMap.put("table", table);

        field.setName("id");
        field.setType("bigint");
        field.setAnnotation("主键");
        list.add(field);

        field = new Field();
        field.setName("sex");
        field.setType("varchar");
        field.setAnnotation("性别");
        list.add(field);


        entityMap.put("field",list);

        metadataList.add(entityMap);

        entityMap = new HashMap<>();
        table = new Table();
        table.setName("persionDict");
        table.setAnnotation("人员字典表");
        entityMap.put("table", table);

        list = new ArrayList<>();
        field = new Field();
        field.setName("id");
        field.setType("bigint");
        field.setAnnotation("主键");
        list.add(field);

        /*
        field = new Field();
        field.setName("itemCode");
        field.setType("varchar");
        field.setAnnotation("编码");
        list.add(field);

        field = new Field();
        field.setName("itemName");
        field.setType("varchar");
        field.setAnnotation("名称");
        list.add(field);
        */

        field = new Field();
        field.setName("sex");
        field.setType("varchar");
        field.setAnnotation("性别");
        list.add(field);

        entityMap.put("field",list);

        metadataList.add(entityMap);
        return metadataList;
    }


    /**
     * methodName: toUpperCaseFirstOne <BR>
     * description:首字母转大写 <BR>
     * remark: <BR>
     * param: s <BR>
     * return: java.lang.String <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 14:54 <BR>
     */
    public static String toUpperCaseFirstOne(String s) {
        if (Character.isUpperCase(s.charAt(0))) {
            return s;
        } else {
            return (new StringBuilder()).append(Character.toUpperCase(s.charAt(0))).append(s.substring(1)).toString();
        }
    }

    /**
     * methodName: toLowerCaseFirstOne <BR>
     * description: 首字母转小写<BR>
     * remark: <BR>
     * param: s <BR>
     * return: java.lang.String <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 14:52 <BR>
     */
    public static String toLowerCaseFirstOne(String s) {
        if (Character.isLowerCase(s.charAt(0))) {
            return s;
        } else {
            return (new StringBuilder()).append(Character.toLowerCase(s.charAt(0))).append(s.substring(1)).toString();
        }
    }

    /**
     * methodName: camelToUnderline <BR>
     * description: 驼峰转下划线<BR>
     * remark: 注意先将首字母转成小写<BR>
     * param: param <BR>
     * return: java.lang.String <BR>
     * author: ChenQi <BR>
     * createDate: 2019-11-30 22:51 <BR>
     */
    public static String camelToUnderline(String param) {
        if (param == null || "".equals(param.trim())) {
            return "";
        }
        int len = param.length();
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            char c = param.charAt(i);
            if (Character.isUpperCase(c)) {
                sb.append('-');
            }
            //统一都转小写
            sb.append(Character.toLowerCase(c));
        }
        return sb.toString();
    }

    /**
     * methodName: getBasePackagePath <BR>
     * description: 获取当面项目目录的上一层<BR>
     * remark: <BR>
     * param:  <BR>
     * return: java.lang.String <BR>
     * author: ChenQi <BR>
     * createDate: 2019-12-02 11:29 <BR>
     */
    public static String getBasePackagePath(){
        String basePackagePath = System.getProperty("user.dir");
        return basePackagePath.substring(0, basePackagePath.lastIndexOf("\\"));
    }
}









