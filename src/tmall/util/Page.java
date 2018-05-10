package tmall.util;

public class Page {
    private int start;  //开始位置
    private int count;  //每页显示的数量
    private int total;  //总共有多少条数据
    private String param;   //参数

    public Page(int start, int count){
        super();
        this.start = start;
        this.count = count;
    }

    //计算出最后一页对应的数据总条数是从多少开始的
    private int getLast(){
        int last = 0;
        // 假设总数是50，是能够被5整除的，那么最后一页的开始就是45
        if(0 == total % count)
            last = total - count;
        // 假设总数是51，不能够被5整除的，那么最后一页的开始就是50
        else
            last = total - total % count;
        last = last < 0 ? 0 : last;
        return last;
    }
    //判断是否还有下一页
    public boolean isHasNext(){
        if (total == getLast())
            return false;
        return true;
    }
    //判断是否有前一页
    public boolean isHasPrevious(){
        if (start == 0)
            return false;
        return true;
    }
    //计算出可以分多少页
    public int getTotalPage(){
        int totalPage = 0;
        if (0 == total % count)
            totalPage = total / count;
        else
            totalPage = total / count + 1;
        if (0 == totalPage)
            totalPage = 1;
        return totalPage;
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }
}
