package com.red_baton;

import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "news_item")
public class NewsItem {
    @Id
    @Column(nullable = false)
    private String url;
    @Column(name = "hacker_news_url", nullable = false)
    private String hackerNewsUrl;
    @Column(name = "posted_on", nullable = false)
    private LocalDateTime postedOn;
    @Column(nullable = false)
    private int upvotes;
    @Column(nullable = false)
    private int comments;

    public NewsItem() {
    }

    public NewsItem(String url, String hackerNewsUrl, LocalDateTime postedOn, int upvotes, int comments) {
        this.url = url;
        this.hackerNewsUrl = hackerNewsUrl;
        this.postedOn = postedOn;
        this.upvotes = upvotes;
        this.comments = comments;
    }

    public String getUrl() {
        return this.url;
    }

    public String getHackerNewsUrl() {
        return this.hackerNewsUrl;
    }

    public void setHackerNewsUrl(String hackerNewsUrl) {
        this.hackerNewsUrl = hackerNewsUrl;
    }

    public LocalDateTime getPostedOn() {
        return this.postedOn;
    }

    public void setPostedOn(LocalDateTime postedOn) {
        this.postedOn = postedOn;
    }

    public int getUpvotes() {
        return this.upvotes;
    }

    public void setUpvotes(int upvotes) {
        this.upvotes = upvotes;
    }

    public int getComments() {
        return this.comments;
    }

    public void setComments(int comments) {
        this.comments = comments;
    }
}