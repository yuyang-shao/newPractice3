package syy.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {
    private DateUtils(){}         //私有构造方法，禁止实例化
    //string->java.utilDate
    public static Date strToDate(String str,String dateFormat) {
        //1-初始化日期格式对象
        SimpleDateFormat format = new SimpleDateFormat(dateFormat);
        try {
//2-使用日期格式对象将String->java.util.Date，并作为方法返回值
            return format.parse(str);
        } catch (Exception e) {
            return null;
        }
    }
    //java.util.Date->String
    public static final String dateToStr(Date date,String dateFormat){
        //1-初始化日期格式对象
        SimpleDateFormat format = new SimpleDateFormat(dateFormat);
        //2-使用日期格式对象将java.util.Date->String，并作为方法返回值
        return format.format(date);
    }

}


