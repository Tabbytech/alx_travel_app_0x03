
# ALX Travel App - Milestone 3: Listings and Bookings API

This milestone focuses on building API endpoints for managing **Listings** and **Bookings** using Django REST Framework (DRF), with Swagger documentation support for testing and exploration.

## Project Overview

This is **Milestone 3** of the ALX Travel App series. In this stage, we:

- Created RESTful API endpoints for Listings and Bookings.
- Used `ModelViewSet` from DRF to enable full CRUD support.
- Registered all endpoints under `/api/` using a router.
- Integrated Swagger (drf-yasg) for auto-generated API documentation.

---

## Tech Stack

- Python 3.x
- Django 5.2.3
- Django REST Framework 3.16.0
- drf-yasg 1.21.10 (Swagger for API docs)
- django-environ
- PyMySQL

---

## Custom User Model

We use a custom user model with the following roles:

- `guest`
- `host`
- `admin`

Users authenticate via email and have UUID primary keys.

---

## Models Summary

### Listing

| Field         | Type      | Description            |
| ------------- | --------- | ---------------------- |
| property_id   | UUIDField | Unique property ID     |
| host          | FK(User)  | Host of the listing    |
| name          | CharField | Property name          |
| description   | TextField | Description            |
| location      | CharField | Location string        |
| pricepernight | Decimal   | Cost per night         |
| created_at    | DateTime  | Auto timestamp         |
| updated_at    | DateTime  | Auto updated timestamp |

### Booking

| Field       | Type        | Description                    |
| ----------- | ----------- | ------------------------------ |
| booking_id  | UUIDField   | Unique booking ID              |
| property    | FK(Listing) | Property booked                |
| user        | FK(User)    | Guest who made booking         |
| start_date  | DateField   | Booking start date             |
| end_date    | DateField   | Booking end date               |
| total_price | Decimal     | Total cost                     |
| status      | Choice      | pending / confirmed / canceled |
| created_at  | DateTime    | Auto timestamp                 |

---

## API Endpoints

Base URL: `/api/`

### Listings Endpoints

| Method | Endpoint          | Description                 |
| ------ | ----------------- | --------------------------- |
| GET    | `/listings/`      | List all listings           |
| POST   | `/listings/`      | Create new listing          |
| GET    | `/listings/{id}/` | Retrieve a specific listing |
| PUT    | `/listings/{id}/` | Update listing              |
| DELETE | `/listings/{id}/` | Delete listing              |

### Bookings Endpoints

| Method | Endpoint          | Description        |
| ------ | ----------------- | ------------------ |
| GET    | `/bookings/`      | List all bookings  |
| POST   | `/bookings/`      | Create new booking |
| GET    | `/bookings/{id}/` | Retrieve a booking |
| PUT    | `/bookings/{id}/` | Update booking     |
| DELETE | `/bookings/{id}/` | Delete booking     |

---

## 📑 API Documentation

Visit:  
🔗 [`/swagger/`](http://localhost:8000/swagger/) — Swagger UI  
🔗 [`/redoc/`](http://localhost:8000/redoc/) — ReDoc UI

Auto-generated using **drf-yasg**.

---

## How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/Tabbytech/alx_travel_app_0x01.git
   cd alx_travel_app
   ```

````

2. Install dependencies:

   ```bash
   pip install -r requirements.txt
   ```

3. Set up `.env` file using `django-environ`.

4. Run migrations:

   ```bash
   python manage.py migrate
   ```

5. Start development server:

   ```bash
   python manage.py runserver
   ```

---

## Testing the API

Use **Postman**, **Insomnia**, or **Swagger UI** to test:

* Create listings and bookings
* Retrieve, update, delete them
* Confirm status updates (confirmed, canceled, etc.)

---

## Project Structure

```
alx_travel_app/
├── listings/
│   ├── models.py
│   ├── views.py
│   ├── urls.py
│   └── serializers.py
├── users/
│   ├── models.py
│   └── managers.py
├── settings.py
└── README.md
```

````
