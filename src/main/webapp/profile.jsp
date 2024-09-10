<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession session_user = request.getSession(false);
    if (session_user == null || session_user.getAttribute("user") == null) {
        response.sendRedirect("/login");
        return;
    }

    String userEmail = (String) session_user.getAttribute("user");
    String userName = (String) session_user.getAttribute("name");
    String instagramLink = (String) session_user.getAttribute("instagram_link");
    String contactNumber = (String) session_user.getAttribute("contact_number");
%>
<html>
<head>
    <title><%=userName%>'s Profile</title>
    <script src="./source/js/bootstrap.bundle.js"></script>
    <link rel="stylesheet" href="./source/css/bootstrap.min.css"/>
    <link rel="icon" type="image/x-icon" href="source/images/user.png"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet"/>
</head>
<body>
<a href="/" target="_self" class="fw-bold position-absolute d-flex mx-5 mt-4 text-decoration-none text-black">
    <img src="./source/images/back.svg" alt="back" style="width: 20px"> Back
</a>

<section class="vh-100">
    <div class="container py-5 h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-md-12 col-xl-4">
                <div class="card shadow border-0" style="border-radius: 15px">
                    <div class="card-body text-center">
                        <div class="mt-3 mb-4">
                            <img
                                    src="ImageServlet?email=<%=userEmail%>"
                                    class="rounded-circle img-fluid"
                                    style="width: 200px"
                            />
                        </div>
                        <h4 class="mb-2"><%= userEmail %>
                        </h4>
                        <p class="text-muted mb-4">
                            @<%=userName%> <span class="mx-2">|</span>
                            <a href="<%=instagramLink%>" target="_blank"><%=userName%>
                            </a>
                        </p>
                        <div class="mb-4 pb-2">
                            <a href="<%=instagramLink%>" class="btn btn-outline-primary btn-floating">
                                <i class="fab fa-facebook-f fa-lg"></i>
                            </a>
                            <a href="<%=instagramLink%>" class="btn btn-outline-primary btn-floating">
                                <i class="fab fa-twitter fa-lg"></i>
                            </a>
                            <a href="<%=instagramLink%>" class="btn btn-outline-primary btn-floating">
                                <i class="fab fa-instagram fa-lg"></i>
                            </a>
                        </div>
                        <a href="tel:<%=contactNumber%>" class="btn btn-primary btn-rounded btn-lg">Message now</a>
                        <div class="d-flex justify-content-between text-center mt-5 mb-2">
                            <div>
                                <p class="mb-2 h5">8471</p>
                                <p class="text-muted mb-0">Wallets Balance</p>
                            </div>
                            <div class="px-3">
                                <p class="mb-2 h5">8512</p>
                                <p class="text-muted mb-0">Income amounts</p>
                            </div>
                            <div>
                                <p class="mb-2 h5">4751</p>
                                <p class="text-muted mb-0">Total Transactions</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
