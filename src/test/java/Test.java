/**
 * className: Test <BR>
 * description: <BR>
 * remark: <BR>
 * auther: ChenQi <BR>
 * date: 2019/11/30 22:41 <BR>
 * version 1.0 jdk1.8 <BR>
 */
public class Test {

    public static void main(String[] args) {

        /*String str = "adminDict";
        String str_abc = camelToUnderline(str);   //  下划线小写:abc_def
        System.out.println("驼峰转化成下划线小写 :" + str_abc);*/
        String st = "org.ssh.boo";
        String st2 = st.replace(".", "/");
        System.out.println("st2"+st2);
    }

    //驼峰转下划线
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

}
