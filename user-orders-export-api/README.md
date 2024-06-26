# UserOrdersExport Api

This repository contains the backend API for a user management application built using Ruby on Rails. It provides endpoints to manage users and generate CSV files containing user data.

## Prerequisites

* Ruby (version 3.0.0)

## Installation

1. Clone the repository:

```bash
  git clone https://github.com/dev-nirmal-yadav/user_orders_export_app.git
  cd user_orders_export_app/user-orders-export-api
```

2. Install dependencies:

```bash
  bundle install
```

3. Database setup:

* Ensure PostgreSQL is running.
* Update config/database.yml with your database credentials.
* Run migrations and seed the database:

```bash
  rails db:create
  rails db:migrate
  rails db:seed
```

4. Running the server:

* Start the Rails server:
```bash
  rails server
```
5. Start sidekiq for background jobs
* bundle exec sidekiq