# MyJob

MyJob is a Ruby on Rails application designed to manage job postings, submissions, and recruiters. It includes features for job management, search functionality, and user authentication.

## Features

- **Job Management**: Create, read, update, and delete job postings.
- **Submission Management**: Submit and manage applications for jobs.
- **Recruiter Management**: Recruiters can create and manage their profiles.
- **Search Functionality**: Search jobs by title, description, and skills.
- **Pagination**: Paginate job listings and recruiter records.
- **JWT Authentication**: Secure authentication for users.

## Installation

### Prerequisites

- Ruby 2.7.2
- Rails 6.0.6
- PostgreSQL
- Node.js (for JavaScript runtime)
- Yarn (for managing JavaScript dependencies)

### Setup

1. **Clone the Repository**

   ```bash
   git clone https://github.com/your-username/myjob.git
   cd myjob

2. **Install Dependencies**
   ```bash
    bundle install
    yarn install

3. **Set the database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed

4. **Start the server**
   ```bash
   rails s

5. **Usage - API Endpoints**
    - Jobs
        - GET /api/v1/jobs - List all jobs
        - GET /api/v1/jobs/:id - Show job details
        - POST /api/v1/jobs - Create a new job
        - PATCH /api/v1/jobs/:id - Update a job
        - DELETE /api/v1/jobs/:id - Delete a job

    - Submissions
        - POST /api/v1/submissions - Create a new submission

    - Recruiters
        - GET /api/v1/recruiters/:id - Show recruiter details
        - POST /api/v1/recruiters - Create a new recruiter
        - PATCH /api/v1/recruiters/:id - Update a recruiter
        - DELETE /api/v1/recruiters/:id - Delete a recruiter

    - Authentication
        - POST /api/v1/auth/login - Login and receive a JWT token
        - POST /api/v1/auth/logout - Logout
