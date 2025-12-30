# Cozy Home API Documentation

This document lists all the API endpoints available in the Cozy Home project.

## Authentication Endpoints

### 1. Register
- **URL**: `/api/register`
- **Method**: `POST`
- **Description**: Register a new user (Renter or Owner). Accounts are pending admin approval.
- **Request Body**:
    - `fullname`: (string, required)
    - `phonenumber`: (string, required, unique)
    - `password`: (string, required)
    - `role`: (string, required: 'renter' or 'owner')
    - `birth_date`: (date, required)
    - `profile_image`: (file, required)
    - `id_image`: (file, required)

### 2. Login
- **URL**: `/api/login`
- **Method**: `POST`
- **Description**: Login to get an access token.
- **Request Body**:
    - `phonenumber`: (string, required)
    - `password`: (string, required)

### 3. Logout
- **URL**: `/api/logout`
- **Method**: `POST`
- **Authentication**: Bearer Token (Sanctum)
- **Description**: Revoke the current access token.

---

## Profile Endpoints

### 4. Show Profile
- **URL**: `/api/profile`
- **Method**: `GET`
- **Authentication**: Bearer Token (Sanctum)
- **Description**: Get the authenticated user's details.

### 5. Update Profile
- **URL**: `/api/profile`
- **Method**: `POST`
- **Authentication**: Bearer Token (Sanctum)
- **Description**: Update profile details and images.
- **Request Body**: (Optional fields)
    - `first_name`, `last_name`, `phonenumber`, `profile_image`, `identity_image`, etc.

---

## Apartment Endpoints

### 6. List Apartments
- **URL**: `/api/apartments`
- **Method**: `GET`
- **Description**: List all available apartments with optional filters.
- **Query Parameters**:
    - `city`: (string) Filter by city.
    - `province`: (string) Filter by province.
    - `max_price`: (numeric) Filter by maximum price per night.

### 7. View Apartment Details
- **URL**: `/api/apartments/{apartment}`
- **Method**: `GET`
- **Description**: Get detailed information about a specific apartment.

### 8. Create Apartment (Owner Only)
- **URL**: `/api/apartments`
- **Method**: `POST`
- **Authentication**: Bearer Token (Sanctum), Role: Owner
- **Description**: Create a new apartment listing.
- **Request Body**:
    - `title`, `description`, `city`, `province`, `price_per_night`, `images[]` (files), etc.

### 9. Update Apartment (Owner Only)
- **URL**: `/api/apartments/{apartment}`
- **Method**: `PUT`
- **Authentication**: Bearer Token (Sanctum), Role: Owner
- **Description**: Update an existing apartment listing.

### 10. Delete Apartment (Owner Only)
- **URL**: `/api/apartments/{apartment}`
- **Method**: `DELETE`
- **Authentication**: Bearer Token (Sanctum), Role: Owner
- **Description**: Remove an apartment listing.

---

## Booking Endpoints

### 11. Create Booking
- **URL**: `/api/bookings`
- **Method**: `POST`
- **Authentication**: Bearer Token (Sanctum)
- **Description**: Request a booking for an apartment.
- **Request Body**:
    - `apartment_id`: (integer, required)
    - `start_date`: (date, required)
    - `end_date`: (date, required)
    - `number_of_persons`: (integer, required)
    - `notes`: (string, optional)

### 12. List My Bookings
- **URL**: `/api/my-bookings`
- **Method**: `GET`
- **Authentication**: Bearer Token (Sanctum)
- **Description**: Get all bookings related to the authenticated renter (Upcoming, Completed, Canceled, Pending).

### 13. View Booking Details
- **URL**: `/api/bookings/{booking}`
- **Method**: `GET`
- **Authentication**: Bearer Token (Sanctum)
- **Description**: Get details of a specific booking.

### 14. Update Booking
- **URL**: `/api/bookings/{booking}`
- **Method**: `PUT`
- **Authentication**: Bearer Token (Sanctum)
- **Description**: Update a pending booking.

### 15. Cancel Booking
- **URL**: `/api/bookings/{booking}/cancel`
- **Method**: `PATCH`
- **Authentication**: Bearer Token (Sanctum)
- **Description**: Cancel a booking (Renter or Owner).

### 16. Approve Booking (Owner Only)
- **URL**: `/api/owner/bookings/{booking}/approve`
- **Method**: `PATCH`
- **Authentication**: Bearer Token (Sanctum), Role: Owner
- **Description**: Approve a booking request for an owned apartment.

### 17. Reject Booking (Owner Only)
- **URL**: `/api/owner/bookings/{booking}/reject`
- **Method**: `PATCH`
- **Authentication**: Bearer Token (Sanctum), Role: Owner
- **Description**: Reject a booking request for an owned apartment.

---

## Favorite Endpoints

### 18. List Favorites
- **URL**: `/api/favorites`
- **Method**: `GET`
- **Authentication**: Bearer Token (Sanctum)
- **Description**: List all apartments favorited by the user.

### 19. Toggle Favorite
- **URL**: `/api/favorites/toggle/{apartment}`
- **Method**: `POST`
- **Authentication**: Bearer Token (Sanctum)
- **Description**: Add or remove an apartment from favorites.

---

## Review Endpoints

### 20. Submit Review
- **URL**: `/api/bookings/{booking}/review`
- **Method**: `POST`
- **Authentication**: Bearer Token (Sanctum)
- **Description**: Submit a review for a completed booking.
- **Request Body**:
    - `rating`: (integer, 1-5, required)
    - `comment`: (string, max 500, optional)

---

## Admin Endpoints

### 21. Approve User Account
- **URL**: `/api/admin/users/{user}/approve`
- **Method**: `PATCH`
- **Authentication**: Bearer Token (Sanctum), Role: Admin
- **Description**: Approve a pending user account registration.

### 22. Get Current User Info
- **URL**: `/api/user`
- **Method**: `GET`
- **Authentication**: Bearer Token (Sanctum)
- **Description**: Basic route returning the authenticated user object.
