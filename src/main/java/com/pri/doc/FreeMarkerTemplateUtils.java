package com.pri.doc;

import freemarker.cache.NullCacheStorage;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;

import java.io.File;
import java.io.IOException;

/**
 * className: FreeMarkerTemplateUtils <BR>
 * description: <BR>
 * remark: <BR>
 * author: ChenQi <BR>
 * createDate: 2019-11-28 22:20 <BR>
 */
public class FreeMarkerTemplateUtils {

    private FreeMarkerTemplateUtils(){}
    private static final Configuration CONFIGURATION = new Configuration(Configuration.VERSION_2_3_22);
    /* 获取当前目录位置 ChenQi*/
    static String basePackagePath = System.getProperty("user.dir");
    static{
        try {
            // 设置模板文件路径 ChenQi
            CONFIGURATION.setDirectoryForTemplateLoading (new File (basePackagePath+"/code/template"));
        } catch (IOException e) {
            e.printStackTrace ();
        }
        CONFIGURATION.setDefaultEncoding("UTF-8");
        CONFIGURATION.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        CONFIGURATION.setCacheStorage(NullCacheStorage.INSTANCE);
    }

    public static Template getTemplate(String templateName) throws IOException {
        try {
            return CONFIGURATION.getTemplate(templateName);
        } catch (IOException e) {
            throw e;
        }
    }

    public static void clearCache() {
        CONFIGURATION.clearTemplateCache();
    }
}
