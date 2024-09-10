package com.news.main;

import com.kwabenaberko.newsapilib.NewsApiClient;
import com.kwabenaberko.newsapilib.models.request.EverythingRequest;
import com.kwabenaberko.newsapilib.models.response.ArticleResponse;
import com.kwabenaberko.newsapilib.models.Article;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.CompletableFuture;
import java.util.List;

public class NewsServlet extends HttpServlet {
    private final String NEWS_API_KEY = "1f0ef25771d74023a3118716b153dfc3"; // Set your API key here

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("query");
        if (query == null || query.isEmpty()) {
            request.setAttribute("errorMessage", "No query provided for news search.");
            return;
        }


        // Initialize NewsApiClient
        NewsApiClient newsApiClient = new NewsApiClient(NEWS_API_KEY);

        // Create a CompletableFuture to handle the async call
        CompletableFuture<Void> future = new CompletableFuture<>();

        // Perform the asynchronous request to the News API
        newsApiClient.getEverything(
                new EverythingRequest.Builder()
                        .q(query)
                        .build(),
                new NewsApiClient.ArticlesResponseCallback() {
                    @Override
                    public void onSuccess(ArticleResponse articleResponse) {
                        // On success, set articles to request attribute
                        request.setAttribute("articles", articleResponse.getArticles());
                        request.setAttribute("query", query);
                        // Complete the future
                        future.complete(null);
                    }

                    @Override
                    public void onFailure(Throwable throwable) {
                        throwable.printStackTrace();
                        request.setAttribute("errorMessage", "An error occurred while fetching news.");
                        // Complete the future even on failure
                        future.completeExceptionally(throwable);
                    }
                }
        );

        // Wait for the future to complete (this blocks until onSuccess/onFailure is called)
        try {
            future.get(); // Block until the async operation finishes
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Forward to JSP after the async call completes
        request.getRequestDispatcher("/news.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
