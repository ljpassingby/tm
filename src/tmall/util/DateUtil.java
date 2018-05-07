package tmall.util;

//用于java.util.Date类与java.sql.Timestamp 类的互相转换
public class DateUtil {
    //java.util.Date date = new Date()的输出格式为Sun May 06 15:01:26 CST 2018
    //date.getTime()输出形式为1525590116586
    //new java.sql.Timestamp(date.getTime())的输出形式为2018-05-06 15:01:56.586
    public static java.sql.Timestamp d2t(java.util.Date d){
        if (null == d){
            return null;
        }
        return new java.sql.Timestamp(d.getTime());
    }
    public static java.util.Date t2d(java.sql.Timestamp t){
        if (null == t)
            return null;
        return new java.util.Date(t.getTime());
    }
}
