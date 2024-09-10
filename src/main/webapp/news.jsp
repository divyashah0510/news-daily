<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib
        prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page
        contentType="text/html;charset=UTF-8" language="java" %>
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
<html>
<head>
    <title>News on ${query}</title>
    <script src="./source/js/bootstrap.bundle.js"></script>
    <link rel="stylesheet" href="./source/css/bootstrap.min.css"/>
    <link rel="icon" type="image/x-icon" href="source/images/favicon.png"/>
</head>
<body class="bg-body-tertiary">
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
                        <hr class="dropdown-divider"/>
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
<main>
    <h2 class="bg-body-tertiary mb-0 container">News on: ${query}</h2>
    <div class="album py-5 bg-body-tertiary">
        <div class="container">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                <c:forEach var="article" items="${articles}">
                    <div class="col">
                        <div class="card shadow-sm">
                            <img
                                    src="${empty article.urlToImage ? 'source/images/no-image.png' : article.urlToImage}"
                                    class="bd-placeholder-img card-img-top"
                                    width="100%"
                                    height="255"
                                    alt="${article.title}"
                            />
                            <div class="card-body">
                                <h5>
                                        ${empty article.title ? 'No title provided' :
                                                fn:substring(article.title, 0, 45)}
                                </h5>
                                <p class="card-text">
                                        ${empty article.description ? 'No description provided' :
                                                fn:substring(article.description, 0, 88)}...
                                </p>
                                <div
                                        class="d-flex justify-content-between align-items-center"
                                >
                                    <div class="btn-group">
                                        <a
                                                href="${article.url}"
                                                target="_blank"
                                                class="btn btn-sm btn-outline-secondary"
                                        >Read more</a
                                        >
                                    </div>
                                    <small class="text-body-secondary"
                                    >${article.publishedAt}</small
                                    >
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
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
