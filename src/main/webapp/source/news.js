document.addEventListener("DOMContentLoaded", () => {
  const apiKey = "1f0ef25771d74023a3118716b153dfc3"; // Replace with your News API key
  const apiUrl = `https://newsapi.org/v2/top-headlines?country=us&apiKey=${apiKey}`;

  fetch(apiUrl)
    .then((response) => response.json())
    .then((data) => {
      const articles = data.articles;
      const newsContainer = document.getElementById("news");

      if (articles.length > 0) {
        const topArticle = articles[0];

        // Update the background image of the news container
        newsContainer.style.backgroundImage = `url('${topArticle.urlToImage}')`;

        // Update the content inside the news container
        newsContainer.innerHTML = `
          <div class="col-lg-6 px-0 text-white">
            <h1 class="display-4 fst-italic">${topArticle.title}</h1>
            <p class="justify-content-between my-3 ">${topArticle.description}</p>
            <p class="lead mb-0">
              <a href="${topArticle.url}" target="_blank" class="fw-semibold text-decoration-none "
                >Continue reading...</a
              >
            </p>
          </div>
        `;
      } else {
        newsContainer.innerHTML = `<p>No news available.</p>`;
      }
    })
    .catch((error) => console.error("Error fetching news:", error));
});
document.addEventListener("DOMContentLoaded", () => {
  const apiKey = "1f0ef25771d74023a3118716b153dfc3"; // Replace with your News API key
  const apiUrl = `https://newsapi.org/v2/top-headlines?country=us&apiKey=${apiKey}`;

  fetch(apiUrl)
    .then((response) => response.json())
    .then((data) => {
      const articles = data.articles;

      // Function to find a valid article for a given keyword
      const findArticle = (keyword) => {
        return articles.find(
          (article) =>
            article.title &&
            article.description &&
            article.url &&
            article.urlToImage &&
            article.title.toLowerCase().includes(keyword.toLowerCase())
        );
      };

      // Function to find a valid fallback article
      const findFallbackArticle = (exclude) => {
        return articles.find(
          (article) =>
            article !== exclude &&
            article.title &&
            article.description &&
            article.url &&
            article.urlToImage
        );
      };

      // Find articles for "World" and "Design"
      const worldArticle = findArticle("World");
      const designArticle = findArticle("Design");

      // Fallbacks for articles
      const worldFallback = worldArticle ? null : findFallbackArticle(null);
      const designFallback = designArticle
        ? null
        : findFallbackArticle(worldFallback);

      // Prepare data for HTML rendering
      const prepareCardData = (article, fallback) => {
        return {
          title: article
            ? article.title
            : fallback
            ? fallback.title
            : "No Title",
          date: article
            ? new Date(article.publishedAt).toLocaleDateString()
            : fallback
            ? new Date(fallback.publishedAt).toLocaleDateString()
            : "No Date",
          description: article
            ? article.description
            : fallback
            ? fallback.description
            : "No Description",
          url: article ? article.url : fallback ? fallback.url : "#",
          image: article
            ? article.urlToImage
            : fallback
            ? fallback.urlToImage
            : "#",
        };
      };

      const worldCardData = prepareCardData(worldArticle, worldFallback);
      const designCardData = prepareCardData(designArticle, designFallback);

      // Generate HTML for featured posts
      const featuredPostsHTML = `
        <div class="col-md-6">
          <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
            <div class="col p-4 d-flex flex-column position-static">
              <strong class="d-inline-block mb-2 text-primary-emphasis">World</strong>
              <h3 class="mb-0">${worldCardData.title.slice(0, 45)}...</h3>
              <div class="mb-1 text-body-secondary">${worldCardData.date}</div>
              <p class="card-text mb-auto">${worldCardData.description.slice(
                0,
                45
              )}...</p>
              <a href="${
                worldCardData.url
              }" target="_blank" class="icon-link gap-1 icon-link-hover stretched-link">
                Continue reading
                <svg class="bi">
                  <use xlink:href="#chevron-right"></use>
                </svg>
              </a>
            </div>
            <div class="col-auto d-none d-lg-block">
              <img src="${
                worldCardData.image
              }"  class="bd-placeholder-img object-fit-cover position-relative align-content-center" width="200" height="250" alt="${
        worldCardData.title
      }">
            </div>
          </div>
        </div>
        <div class="col-md-6">
          <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
            <div class="col p-4 d-flex flex-column position-static">
              <strong class="d-inline-block mb-2 text-success-emphasis">Design</strong>
              <h3 class="mb-0">${designCardData.title.slice(0, 45)}...</h3>
              <div class="mb-1 text-body-secondary">${designCardData.date}</div>
              <p class="card-text mb-auto">${designCardData.description.slice(
                0,
                45
              )}...</p>
              <a href="${
                designCardData.url
              }" target="_blank" class="icon-link gap-1 icon-link-hover stretched-link">
                Continue reading
                <svg class="bi">
                  <use xlink:href="#chevron-right"></use>
                </svg>
              </a>
            </div>
            <div class="col-auto d-none d-lg-block">
              <img src="${
                designCardData.image
              }" class="bd-placeholder-img object-fit-cover position-relative align-content-center" width="200" height="250" alt="${
        designCardData.title
      }">
            </div>
          </div>
        </div>
      `;

      // Insert HTML into the container
      const featuredPostsContainer = document.getElementById("featured-posts");
      featuredPostsContainer.innerHTML = featuredPostsHTML;
    })
    .catch((error) => console.error("Error fetching news:", error));
});
document.addEventListener("DOMContentLoaded", () => {
  const blogPostsContainer = document.getElementById("blog-posts-container");
  const olderPostsBtn = document.getElementById("older-posts");
  const newerPostsBtn = document.getElementById("newer-posts");

  let currentPage = 1;
  const postsPerPage = 5;

  // Function to fetch blog posts from JSONPlaceholder API
  const fetchBlogPosts = async (page) => {
    try {
      // URL for fetching posts, with pagination
      const response = await fetch(
        `https://jsonplaceholder.typicode.com/posts?_page=${page}&_limit=${postsPerPage}`
      );

      if (!response.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }

      const posts = await response.json();
      return posts;
    } catch (error) {
      console.error("Error fetching blog posts:", error);
      return [];
    }
  };

  // Function to capitalize the first letter of each word in a string
  const capitalizeFirstLetter = (string) => {
    return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
  };

  // Function to generate blog posts HTML
  const generateBlogPostsHTML = (posts) => {
    if (posts.length === 0) {
      return "<p>No posts available.</p>";
    }

    return posts
      .map(
        (post) => `
          <article class="blog-post">
              <h2 class="display-5 link-body-emphasis mb-1">${capitalizeFirstLetter(
                post.title
              )}</h2>
              <p class="blog-post-meta">
                  ${new Date().toLocaleDateString()} by <a href="#">Anonymous</a>
              </p>
              <p>${post.body}</p>
          </article>
      `
      )
      .join("");
  };

  // Function to load and display blog posts
  const loadBlogPosts = async () => {
    const posts = await fetchBlogPosts(currentPage);

    blogPostsContainer.innerHTML = generateBlogPostsHTML(posts);

    // Update pagination buttons
    olderPostsBtn.classList.toggle("disabled", currentPage <= 1);
    newerPostsBtn.classList.toggle("disabled", posts.length < postsPerPage);
  };

  // Event listeners for pagination buttons
  olderPostsBtn.addEventListener("click", (e) => {
    e.preventDefault();
    if (currentPage > 1) {
      currentPage--;
      loadBlogPosts();
    }
  });

  newerPostsBtn.addEventListener("click", (e) => {
    e.preventDefault();
    currentPage++;
    loadBlogPosts();
  });

  // Initial load
  loadBlogPosts();
});
document.addEventListener("DOMContentLoaded", async () => {
  const apiKey = "1f0ef25771d74023a3118716b153dfc3"; // Replace with your News API key
  const apiUrl = "https://newsapi.org/v2/top-headlines"; // News API endpoint
  const aboutSection = document.getElementById("about-section");
  const recentPostsList = document.getElementById("recent-posts-list");
  const elsewhereList = document.getElementById("elsewhere-list");

  // Example About content
  const aboutContent = `
      <h4 class="fst-italic">About</h4>
      <p class="mb-0 justify-content-evenly">
          This is News Daily website where you can find the latest news from around the world.It provides the latest news on various topics like business, technology, sports, entertainment, health, and science. Stay updated with the latest news and headlines from around the world.
      </p>
  `;
  aboutSection.innerHTML = aboutContent;

  // Fetch news data
  const fetchNews = async () => {
    try {
      const response = await fetch(`${apiUrl}?country=us&apiKey=${apiKey}`);
      const data = await response.json();
      return data.articles;
    } catch (error) {
      console.error("Error fetching news:", error);
      return [];
    }
  };

  const articles = await fetchNews();

  // Populate Recent Posts
  recentPostsList.innerHTML = articles
    .slice(0, 3)
    .map(
      (post) => `
        <li>
          <a
            class="d-flex flex-column flex-lg-row gap-3 align-items-start align-items-lg-center py-3 link-body-emphasis text-decoration-none border-top"
            href="${post.url}"
            target="_blank"
          >
            <img
              src="${post.urlToImage || "https://via.placeholder.com/100x96"}"
              class="bd-placeholder-img"
              width="100%"
              height="96"
              alt="${post.title}"
            />
            <div class="col-lg-8">
              <h6 class="mb-0">${post.title.length > 20 ? post.title.slice(0, 20) + '...' : post.title}</h6>
              <small class="text-body-secondary">${new Date(post.publishedAt).toLocaleDateString()}</small>
            </div>
          </a>
        </li>
      `
    )
    .join("");

  // Example Elsewhere links
  const elsewhereLinks = [
    { name: "GitHub", url: "https://github.com/divyashah0510/" },
    { name: "Twitter", url: "https://x.com/Divya_Shah22" },
    { name: "LinkedIn", url: "https://www.linkedin.com/in/divya-d-shah/" },
  ];

  elsewhereList.innerHTML = elsewhereLinks
    .map((link) => `<li><a target="_blanck" href="${link.url}">${link.name}</a></li>`)
    .join("");
});
