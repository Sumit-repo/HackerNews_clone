# HackerNews Clone

HackerNews Clone is a HackerNews clone built in Java that allows users to view and manage the top 90 articles from HackerNews in reverse chronological order.

## Features

- **News Scraper:** A script to crawl the first three pages of HackerNews, extract news items, and update the database.
  
- **User Authentication:** Users can sign up or log in to access their personalized dashboard.

- **Dashboard:** A user-friendly dashboard where all news items are listed in reverse chronological order.

- **Actionable Items:** Users can mark news items as read or delete them. Deleted items are not displayed in the user's panel but are retained in the database.

## Getting Started

### Prerequisites

- Java Development Kit (JDK)
- Apache Maven
- MySQL Database

### Installation

1. Clone the repository.
2. Configure your database connection in `resources.META-INF.presistance.xml`.
3. Run the database schema script.
4. Build the project using Maven.

### Usage

1. Execute the news scraping script.
2. Start the application.
3. Access the dashboard through a web browser.

## Technologies Used

- Java
- JavaServer Pages (JSP)
- Jsoup for web scraping
- Hibernate for database interaction
- HTML, CSS for front-end

## Contributions

Contributions are welcome! Fork the repository, make your changes, and submit a pull request.
