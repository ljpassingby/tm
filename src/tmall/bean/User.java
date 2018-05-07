package tmall.bean;

public class User {
    private int id;
    private String name;
    private String password;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    //返回一个带*的匿名用户名，用于区分name
    public String getAnonymousName(){
        if(null == name){
            return null;
        }
        if(name.length() <= 1){
            return "*";
        }
        //如name为“张三”，则返回“张*”
        if(name.length() == 2){
            return (name.substring(0, 1) + "*");
        }
        //如name为“张三丰”，则返回“张*丰”
        char[] cs = name.toCharArray();
        for (int i = 1; i < cs.length - 1; i++){
            cs[i] = '*';
        }
        return new String(cs);
    }
}
