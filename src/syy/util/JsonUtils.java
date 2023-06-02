package syy.util;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class JsonUtils {
    private static Gson gson=null;                       //私有静态变量gson
    private JsonUtils(){}
    static{                                    //利用静态语句块初始化静态变量gson
        GsonBuilder builder=new GsonBuilder();
        builder.setDateFormat( "yyyy-MM-dd'T'HH:mm:ss" );
        gson = builder.create();
    }
    //Java对象-》JSON字符串
    public static String objectToJson(Object obj){
        String str = gson.toJson( obj , obj.getClass() );
        return str;
    }

    //JSON字符串-》Java对象
    public static Object jsonToObject (String str,Class cls){
        Object obj=gson.fromJson( str, cls );
        return obj;
    }

}



