create database news;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    facebook_link VARCHAR(255),
    x_link VARCHAR(255),
    instagram_link VARCHAR(255),
    photo MEDIUMBLOB,
    contact_number VARCHAR(20)
);