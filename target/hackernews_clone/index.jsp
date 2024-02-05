<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.persistence.*" %>
<%@ page import="com.red_baton.NewsItem" %>
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.select.Elements" %>

<%
    String username = (String) request.getAttribute("username");
    EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("dev");
    EntityManager entityManager = entityManagerFactory.createEntityManager();
    EntityTransaction transaction = entityManager.getTransaction();
    List<NewsItem> news = new ArrayList<>();

    try {
        Document page1 = Jsoup.connect("https://news.ycombinator.com/news?p=1").get();
        Document page2 = Jsoup.connect("https://news.ycombinator.com/news?p=2").get();
        Document page3 = Jsoup.connect("https://news.ycombinator.com/news?p=3").get();
        Document document = Jsoup.parse(page1.html() + page2.html() + page3.html());
        Elements newsElement = document.select(".athing");
        Elements newsElement_subtext = document.select(".subtext");

        for (int newsIndex = 0; newsIndex < Math.max(newsElement.size(), newsElement_subtext.size()); ++newsIndex) {
            String urlText = newsElement.eq(newsIndex).select(".titleline > a").attr("href");
            String url = urlText.contains("item?id=") ? "https://news.ycombinator.com/".concat(urlText) : urlText;
            String hackerNewsUrl = "https://news.ycombinator.com/"
                    .concat(newsElement.eq(newsIndex).select(".sitebit > a").attr("href"));
            LocalDateTime postedOn = LocalDateTime.parse(newsElement_subtext.eq(newsIndex).select(".age").attr("title"));
            String upvotes = newsElement_subtext.eq(newsIndex).select(".score").text();
            String comments = newsElement_subtext.eq(newsIndex).select(".subline > a:contains(comments)").text();
            NewsItem existingNewsItem = entityManager.find(NewsItem.class, url);

            transaction.begin();
            if (existingNewsItem != null) {
                existingNewsItem.setUpvotes(upvotes.isEmpty() ? 0 : Integer.parseInt(upvotes.replaceAll("[^0-9]", "")));
                existingNewsItem.setComments(comments.isEmpty() ? 0 : Integer.parseInt(comments.replaceAll("[^0-9]", "")));
                entityManager.merge(existingNewsItem);
            } else {
                NewsItem newNewsItem = new NewsItem(url, hackerNewsUrl, postedOn,
                        upvotes.isEmpty() ? 0 : Integer.parseInt(upvotes.replaceAll("[^0-9]", "")),
                        comments.isEmpty() ? 0 : Integer.parseInt(comments.replaceAll("[^0-9]", "")));
                entityManager.persist(newNewsItem);
            }
            transaction.commit();
        }

        transaction.begin();
        news = entityManager.createQuery("FROM NewsItem ORDER BY postedOn DESC", NewsItem.class)
                .getResultList();
        int totalItems = news.size();
        if (totalItems > 90) {
            for (NewsItem item : new ArrayList<>(news.subList(90, totalItems))) {
                entityManager.remove(item);
            }
        }
        transaction.commit();
    } catch (IOException e) {
        e.printStackTrace();
    } finally {
        entityManager.close();
        entityManagerFactory.close();
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>News Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 95vw;
            max-height: 90vh;
            margin: 18px 20px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        #table-container {
            height: 80vh;
            overflow-x: auto;
            overflow-y: auto;
            border: 1px solid rgb(80, 79, 79);
        }

        table {
            border-collapse: collapse;
        }

        th,
        td {
            min-width: 13vh;
            border: 1px solid #ddd;
            padding: 9px;
            text-align: left;
            line-height: 1.2;
            max-height: 2.4em;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }

        th {
            text-align: center;
            color: white;
            background-color: rgb(80, 79, 79);
            border: 2px solid rgb(143, 142, 142);
        }

        .actions {
            display: flex;
            justify-content: space-between;
        }

        button {
            padding: 10px;
            margin: 5px;
            cursor: pointer;
            border: none;
            background-color: green;
            color: #fff;
        }

        .actions button.read {
            background-color: #007BFF;
        }
        
        .actions button.delete {
            background-color: #DC3545;
        }

        .title {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        a {
            text-decoration: none;
            color: black;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="title">
            <h1>News Dashboard</h1>
            <% if (username == null) { %>
                <a id="loginLink" href="login.jsp"><button>Login</button></a>
            <% } else { %>
                <p>Welcome, <%= username %>!</p>
            <% } %>
        </div>
        <div id="table-container">
        <table>
            <thead>
                <tr>
                    <th>URL</th>
                    <th>Comments</th>
                    <th>Hacker News URL</th>
                    <th>Posted On</th>
                    <th>Upvotes</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (NewsItem each_news : news) { %>
                    <tr>
                        <td><a href="<%= each_news.getUrl() %>"><%= each_news.getUrl() %></a></td>
                        <td><%= each_news.getComments() %></td>
                        <td><a href="<%= each_news.getHackerNewsUrl() %>">Hacker News Link</a></td>
                        <td><%= each_news.getPostedOn() %></td>
                        <td><%= each_news.getUpvotes() %></td>
                        <td class="actions">
                            <button class="read" onclick="markAsRead('<%= each_news.getUrl() %>')">Mark as Read</button>
                            <button class="delete" onclick="deleteItem('<%= each_news.getUrl() %>')">Delete</button>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
        </div>
    </div>
    <script>
    </script>
</body>

</html>