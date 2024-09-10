<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
    <script src="./source/js/bootstrap.bundle.js"></script>
    <link rel="stylesheet" href="./source/css/bootstrap.min.css">
    <link rel="icon" type="image/x-icon" href="source/images/favicon.png">
</head>
<body class="d-flex align-items-center py-4 bg-body-tertiary">

<main class="form-signin w-25 m-auto container">
    <form action="register" method="post" enctype="multipart/form-data" class="">
        <img class="mb-4" src="./source/images/favicon.png" alt="" width="72" height="57">
        <h1 class="h3 mb-3 fw-normal">Please register</h1>

        <div class="form-floating mb-3">
            <input type="text" name="name" class="form-control" id="floatingName" placeholder="John Doe">
            <label for="floatingName">Name</label>
        </div>

        <div class="form-floating mb-3">
            <input type="email" name="email" class="form-control" id="floatingEmail" placeholder="name@example.com">
            <label for="floatingEmail">Email address</label>
        </div>

        <div class="form-floating mb-3">
            <input type="password" name="password" class="form-control" id="floatingPassword" placeholder="Password">
            <label for="floatingPassword">Password</label>
        </div>

        <div class="mb-3">
            <label for="photo" class="form-label">Profile Photo</label>
            <input type="file" id="photo" name="photo" class="form-control">
        </div>

        <div class="form-floating mb-3">
            <input type="url" name="facebook" class="form-control" id="floatingFacebook" placeholder="Facebook Link">
            <label for="floatingFacebook">Facebook Link</label>
        </div>

        <div class="form-floating mb-3">
            <input type="url" name="x" class="form-control" id="floatingX" placeholder="X Link">
            <label for="floatingX">X Link</label>
        </div>

        <div class="form-floating mb-3">
            <input type="url" name="instagram" class="form-control" id="floatingInstagram" placeholder="Instagram Link">
            <label for="floatingInstagram">Instagram Link</label>
        </div>

        <div class="form-floating mb-3">
            <input type="tel" name="contact_number" class="form-control" id="floatingContact" placeholder="Contact Number">
            <label for="floatingContact">Contact Number</label>
        </div>

        <button class="btn btn-primary w-100 py-2" type="submit">Register</button>
        <p class="mt-5 mb-3 text-body-secondary">©2024</p>
    </form>
</main>

</body>
</html>
