<a id="readme-top"></a>
<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/daniNKV/avivas">
    <img src="docs/images/horizontal.svg" alt="Logo" width="300" height="auto">
  </a>
  <p align="center">
    👟 Sportswear Clothing Store
    <br>
    <a href="https://github.com/daniNKV/avivas">View Demo</a>
    ·
    <a href="https://github.com/daniNKV/avivas/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## 📖 About The Project

<div align="center">
    <img src="docs/images/phrase.svg" alt="Domain Phrase" width="auto" height="auto">
</div>


Welcome to the ultimate solution for managing inventory, boosting sales, and elevating the customer experience for a renowned sportswear chain! This application is your all-in-one platform to ensure smooth operations and happy customers.

#### 💡 What Does It Do?
**Stock Management:** Empower the store staff with real-time tools to track, update, and optimize inventory like pros. From the latest running shoes to the trendiest activewear, everything is under control!

**Sales Processing:** Speed up the checkout process and streamline sales with an intuitive interface designed to meet the fast-paced needs of retail.

**Public Product Catalog:** Engage your customers with a sleek, modern product showcase. Let them explore what's in stock and get excited about their next purchase!

#### 🚀 Why It Matters
**Efficiency:** Reduce errors and save time by automating and centralizing inventory management.

**Scalability:** Handle growing demand and new stores with ease.

**Customer Delight:** A seamless shopping experience keeps them coming back for more.
<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With
## 🚀 **Built With**  

- ![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white)  


- ![Ruby on Rails](https://img.shields.io/badge/Rails-CC0000?style=for-the-badge&logo=rubyonrails&logoColor=white)


- ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)


- ![TailwindCSS](https://img.shields.io/badge/TailwindCSS-06B6D4?style=for-the-badge&logo=tailwindcss&logoColor=white)


- ![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)     



<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

#### Prerequisites

Before you begin, ensure you have the following installed:

- [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
- [Rails](https://rubyonrails.org/)
- [SQLite](https://www.sqlite.org/download.html) (for development and testing)
- [PostgreSQL](https://www.postgresql.org/download/) (for production)
- [Node.js](https://nodejs.org/en/) (for JavaScript dependencies)
- [Yarn](https://yarnpkg.com/) (for managing JavaScript packages)


### 💻 Installation
1. Clone the repo
   ```sh
   git clone https://github.com/daniNKV/avivas.git
   ```
2. Install Ruby dependencies
    Make sure you're in the project directory and run:
    ```
    bundle install
    ```
   2.1 Install STMP server for development
    ```
    sudo apt-get -y install golang-go
    go install github.com/mailhog/MailHog@latest
    ```
   2.2 Run the STMP server
    ```
    ~/go/bin/MailHog
    ```

3. Install JavaScript dependencies:
    If you’re using Yarn:
    ```
    yarn install
    ```

4. Set up the database:
    ```
    rails db:create
    rails db:migrate
    ```

5. Precompile assets (for production):
    If you're preparing for production:
    ```
    rails assets:precompile
    ```

6. Start the server:
    To run the Rails server and initialize watchers:
    ```
    bin/dev
    ```

7. Visit http://localhost:3000 to see the application running!

    7.1 Optional: Running tests
    To run tests, you can use:
    ```
    rails test
    ```


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## 🚀 Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- ROADMAP
## Roadmap

- [ ] Feature 1
- [ ] Feature 2
- [ ] Feature 3
    - [ ] Nested Feature

See the [open issues](https://github.com/github_username/repo_name/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p> -->



<!-- CONTRIBUTING -->
## Contributing
If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- LICENSE -->
## 📝 License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- ACKNOWLEDGMENTS -->
## 🙏 Acknowledgments

* []()
* []()
* []()

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/github_username/repo_name.svg?style=for-the-badge
[contributors-url]: https://github.com/github_username/repo_name/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/github_username/repo_name.svg?style=for-the-badge
[forks-url]: https://github.com/github_username/repo_name/network/members
[stars-shield]: https://img.shields.io/github/stars/github_username/repo_name.svg?style=for-the-badge
[stars-url]: https://github.com/github_username/repo_name/stargazers
[issues-shield]: https://img.shields.io/github/issues/github_username/repo_name.svg?style=for-the-badge
[issues-url]: https://github.com/github_username/repo_name/issues
[license-shield]: https://img.shields.io/github/license/github_username/repo_name.svg?style=for-the-badge
[license-url]: https://github.com/github_username/repo_name/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
[product-screenshot]: images/screenshot.png
