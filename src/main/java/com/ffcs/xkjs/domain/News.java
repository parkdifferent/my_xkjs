package com.ffcs.xkjs.domain;

import java.util.Date;

/**
 * Created by tianf on 2016/4/4.
 */
@SuppressWarnings("serial")
public class News  implements java.io.Serializable{
    private String newsId;
    private String title;       //标题
    private String publisher;  //发布者
    private Date newsTime;    //发布时间
    private String content;   //内容

    public String getNewsId() {
        return newsId;
    }

    public void setNewsId(String newsId) {
        this.newsId = newsId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public Date getNewsTime() {
        return newsTime;
    }

    public void setNewsTime(Date newsTime) {
        this.newsTime = newsTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "News{" +
                "newsId='" + newsId + '\'' +
                ", title='" + title + '\'' +
                ", publisher='" + publisher + '\'' +
                ", newsTime=" + newsTime +
                ", content='" + content + '\'' +
                '}';
    }
}
