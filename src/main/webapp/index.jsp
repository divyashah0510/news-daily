<%@page language="java" contentType="text/html; ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    HttpSession session_user = request.getSession(false); // Get session without creating a new one
    if (session_user == null || session_user.getAttribute("user") == null) {
        response.sendRedirect("/login");
        return;
    }
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
<!DOCTYPE html>
<html>
  <head>
    <title>News Daily</title>
    <script src="./source/js/bootstrap.bundle.js"></script>
    <link rel="stylesheet" href="./source/css/bootstrap.min.css" />
    <link rel="icon" type="image/x-icon" href="source/images/favicon.png" />
    <script src="./source/news.js"></script>
    <style>
      body{
        overflow-x: hidden;
      }
      .bg-image {
        background-size: cover; /* Adjusts the size of the background image */
        background-position: center; /* Centers the background image */
        background-repeat: no-repeat; /* Ensures the image does not repeat */
        position: relative; /* Ensures child elements are positioned relative to this container */
        border-radius: 50%;
      }

      /* Dark overlay pseudo-element */
      .bg-image::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5); /* Dark overlay with 50% opacity */
        z-index: 0; /* Places the overlay behind the text */
        border-radius: 10px;
      }

      /* Ensures the content is visible above the overlay */
      .bg-image .col-lg-6 {
        position: relative;
        z-index: 1; /* Ensures the text content is on top of the overlay */
      }
      .recent-post-title {
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
      }
    </style>
  </head>
  <body>
    <header class="p-3 mb-3 border-bottom">
      <div class="container">
        <div
          class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start"
        >
          <a
            href="/"
            class="d-flex align-items-center mb-2 mb-lg-0 link-body-emphasis text-decoration-none"
          >
            <img
              src="./source/images/favicon.png"
              alt="Logo"
              class="bi me-2"
              width="100%"
              height="50"
              role="img"
              aria-label="Logo"
            />
          </a>

          <ul
            class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0"
          >
            <li>
              <a href="news?query=cricket" class="nav-link px-2 link-secondary"
                >Cricket</a
              >
            </li>
            <li>
              <a
                href="news?query=entertainment"
                class="nav-link px-2 link-body-emphasis"
                >Entertainment</a
              >
            </li>
            <li>
              <a
                href="news?query=artificial+intelligence"
                class="nav-link px-2 link-body-emphasis"
                >Artificial Intelligence</a
              >
            </li>
            <li>
              <a
                class="nav-item nav-link link-body-emphasis active"
                href="news?query=world"
                >World</a
              >
            </li>
            <li>
              <a
                class="nav-item nav-link link-body-emphasis"
                href="news?query=us"
                >U.S.</a
              >
            </li>
            <li>
              <a
                class="nav-item nav-link link-body-emphasis"
                href="news?query=business"
                >Business</a
              >
            </li>
            <li>
              <a
                class="nav-item nav-link link-body-emphasis"
                href="news?query=politics"
                >Politics</a
              >
            </li>
            <li>
              <a
                class="nav-item nav-link link-body-emphasis"
                href="news?query=health"
                >Health</a
              >
            </li>
          </ul>

          <form
            action="news"
            method="post"
            class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3"
            role="search"
          >
            <input
              type="search"
              class="form-control"
              placeholder="Search..."
              name="query"
              aria-label="Search"
            />
          </form>

          <div class="dropdown text-end">
            <a
              href="#"
              class="d-block link-body-emphasis text-decoration-none dropdown-toggle"
              data-bs-toggle="dropdown"
              aria-expanded="false"
            >
              <img
                src="https://github.com/mdo.png"
                alt="mdo"
                width="32"
                height="32"
                class="rounded-circle"
              />
            </a>
            <ul class="dropdown-menu text-small">
              <li><a class="dropdown-item" href="/profile.jsp">Profile</a></li>
              <li>
                <hr class="dropdown-divider" />
              </li>
              <li>
                <a
                  class="dropdown-item"
                  href="<%= request.getContextPath() %>/logout"
                  >Sign out</a
                >
              </li>
            </ul>
          </div>
        </div>
      </div>
    </header>
    <main class="container">
      <div
        id="news"
        class="p-4 p-md-5 mb-4 rounded text-body-emphasis bg-body-secondary bg-image"
      ></div>
      <div class="row mb-2" id="featured-posts"></div>
      <div class="row g-5">
        <div class="col-md-8">
          <h3 class="pb-4 mb-4 fst-italic border-bottom">
            From the News Daily
          </h3>
          <nav class="blog-pagination" aria-label="Pagination">
            <a
              id="older-posts"
              class="btn btn-outline-primary rounded-pill"
              href="#"
              >Older</a
            >
            <a
              id="newer-posts"
              class="btn btn-outline-secondary rounded-pill disabled"
              aria-disabled="true"
              >Newer</a
            >
          </nav>
          <!-- Placeholder for blog posts -->
          <div id="blog-posts-container">
            <!-- Dynamic blog posts will be inserted here -->
          </div>
        </div>
        <div class="col-md-4">
          <div class="position-sticky" style="top: 2rem">
            <div class="p-4 mb-3 bg-body-tertiary rounded" id="about-section">
              <!-- Dynamic About content will be inserted here -->
            </div>

            <div id="recent-posts">
              <h4 class="fst-italic">Recent posts</h4>
              <ul class="list-unstyled" id="recent-posts-list"></ul>
            </div>

            <div class="p-4">
              <h4 class="fst-italic">Elsewhere</h4>
              <ol class="list-unstyled" id="elsewhere-list">
                <!-- Dynamic Elsewhere links will be inserted here -->
              </ol>
            </div>
          </div>
        </div>
      </div>
    </main>
    <script
      src="/docs/5.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>
  </body>
</html>
