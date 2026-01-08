class ApiEndpoints {
  static const String baseUrl =
      "https://nancy-nondisputatious-interlocally.ngrok-free.dev/api";

  static const Map<String, String> headers = {
    "ngrok-skip-browser-warning": "true",
    "Accept": "application/json",
  };

  // ---------------- Auth ----------------
  static const String register = "/register"; // POST
  static const String login = "/login"; // POST
  static const String logout = "/logout"; // POST (auth)
  static const String user = "/user"; // GET (auth)
  static const String profile = "/profile"; // GET (auth)
  static const String updateProfile = "/profile"; // POST (auth)

  // ---------------- Apartments ----------------
  static const String apartments = "/apartments"; // GET
  static String apartmentDetails(int id) => "/apartments/$id"; // GET
  static const String createApartment =
      "/apartments"; // POST (auth + role:owner)
  static String updateApartment(int id) =>
      "/apartments/$id"; // PUT (auth + role:owner)
  static String deleteApartment(int id) =>
      "/apartments/$id"; // DELETE (auth + role:owner)

  // ---------------- Bookings ----------------
  static const String bookings = "/bookings"; // POST (auth)
  static const String myBookings = "/my-bookings"; // GET (auth)
  static String bookingDetails(int id) => "/bookings/$id"; // GET (auth)
  static String updateBooking(int id) => "/bookings/$id"; // PUT (auth)
  static String cancelBooking(int id) => "/bookings/$id/cancel"; // PATCH (auth)
  static String reviewBooking(int id) => "/bookings/$id/review"; // POST (auth)

  // Owner actions
  static String approveBooking(int id) =>
      "/owner/bookings/$id/approve"; // PATCH (auth + role:owner)
  static String rejectBooking(int id) =>
      "/owner/bookings/$id/reject"; // PATCH (auth + role:owner)
  static const String ownerBookings =
      "/owner/bookings"; // GET (auth + role:owner)

  // ---------------- Favorites ----------------
  static const String favorites = "/favorites"; // GET (auth)
  static String toggleFavorite(int id) =>
      "/favorites/toggle/$id"; // POST (auth)

  // ---------------- Admin ----------------
  static const String adminLogin = "/admin/login-as-default"; // POST
  static const String pendingUsers =
      "/admin/pending-users"; // GET (auth + role:admin)
  static String approveUser(int id) => "/admin/users/$id/approve"; // PATCH
  static String rejectUser(int id) => "/admin/users/$id/reject"; // PATCH
}
