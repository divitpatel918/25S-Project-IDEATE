# Ideate - A Data-Driven Club Management Platform
# Link to Video Demonstrations: https://drive.google.com/file/d/1vSpNu-gWNy0Kt8EZfN7eOq42l6w23vmh/view?usp=drive_link
## Overview
Running a product-development club at university comes with challenges, from recruiting members to managing projects and keeping all stakeholders informed. Ideate is a data-driven platform designed to streamline club management by centralizing information on projects, clients, and members. Our platform ensures that clubs can seamlessly connect with clients, work on impactful projects, and foster the professional growth of college students.

## Key Features
Ideate is tailored to support four key user groups:
- **Executive Board Members:** Plan events, review client project proposals, and manage club projects.
- **General Club Members:** Access assigned projects and keep track of club meeting schedules.
- **Advisors (Professors/Teaching Assistants):** View club projects, hold office hours, and invite new members.
- **Clients:** Submit project proposals, track project progress, and refer other clients to the club.


## Technology Stack
The project follows a **three-tier architecture** running on Docker containers:
1. **Backend:** Python Flask REST API for data access and business logic.
2. **Database:** MySQL for structured storage and management of club, project, and user data.
3. **Frontend:** Streamlit-based user interface for an interactive experience.

The three components that will run in their own Docker Containers:
- Streamlit App in the `./app` directory
- Flask REST api in the `./api` directory
- MySQL Database that will be initialized with SQL script files from the `./database-files` directory

## Project Setup
### Prerequisites
Ensure you have the following installed:
- Docker
- Python
- MySQL

1. Set up the `.env` file in the `api` folder based on the `.env.template` file.
1. For running the testing containers (for your personal repo), you will tell `docker compose` to use a different configuration file named `docker-compose-testing.yaml`.
   1. `docker compose -f docker-compose-testing.yaml up -d` to start all the containers in the background
   1. `docker compose -f docker-compose-testing.yaml down` to shutdown and delete the containers
   1. `docker compose -f docker-compose-testing.yaml up db -d` only start the database container (replace db with api or app for the other two services as needed)
   1. `docker compose -f docker-compose-testing.yaml stop` to "turn off" the containers but not delete them.


