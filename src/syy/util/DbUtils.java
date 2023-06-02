package syy.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DbUtils {
    //数据库连接参数常量
    private final static String
            DRIVER="net.sourceforge.jtds.jdbc.Driver";
    private final static String URL =
            "jdbc:jtds:sqlserver://localhost:1433/site";
    private final static String USERID = "sa";
    private final static String UERPASSWORD = "123456";
    //私有构造方法，禁止实例对象
    private DbUtils() { }
    static {                                           //1-利用静态语句块进行类的初始化
        try {
            Class.forName(DRIVER);           //JDK6.0以上不再必要这一步
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static Connection getConnection() {                        //2-获得数据库连接
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(URL, USERID, UERPASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
    // 关闭数据集/语句/连接对象
    public static void close(ResultSet rs, Statement st,  Connection conn) {
        try {
            if (rs != null)  rs.close();            //关闭数据集对象
            if (st != null)  st.close();            //关闭SQL语句对象
            if (conn != null)  conn.close();    //关闭数据库连接对象
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

