# Ideate - A Data-Driven Club Management Platform

## Overview
Running a product-development club at university comes with challenges, from recruiting members to managing projects and keeping all stakeholders informed. Ideate is a data-driven platform designed to streamline club management by centralizing information on projects, clients, and members. Our platform ensures that clubs can seamlessly connect with clients, work on impactful projects, and foster the professional growth of college students.

## Key Features
Ideate is tailored to support four key user groups:
- **Executive Board Members:** Plan events, review client project proposals, and manage club projects.
- **General Club Members:** Access assigned projects and keep track of club meeting schedules.
- **Advisors (Professors/Teaching Assistants):** View club projects, hold office hours, and invite new members.
- **Clients:** Submit project proposals, track project progress, and refer other clients to the club.

### Notable Functionalities
- **Real-time Project Dashboards:** Monitor project timelines and updates.
- **Centralized Scheduling System:** View upcoming club meetings and events.
- **Seamless Client-Club Interaction:** Clients can submit, track, and manage project proposals efficiently.

## Technology Stack
The project follows a **three-tier architecture** running on Docker containers:
1. **Backend:** Python Flask REST API for data access and business logic.
2. **Database:** MySQL for structured storage and management of club, project, and user data.
3. **Frontend:** Streamlit-based user interface for an interactive experience.

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
