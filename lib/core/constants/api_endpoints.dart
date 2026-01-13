class ApiEndpoints {
  static const String baseUrl =
      "https://nancy-nondisputatious-interlocally.ngrok-free.dev/api";

  static const Map<String, String> headers = {
    "ngrok-skip-browser-warning": "true",
    "Accept": "application/json",
  };

  // ---------------- Auth ----------------
  static const String register = "/register"; // POSTتم
  static const String login = "/login"; // POSTتم
  static const String logout = "/logout"; // POST (auth)تم
  static const String user = "/user"; // GET (auth)تم
  static const String profile = "/profile"; // GET (auth)تم
  static const String updateProfile = "/profile"; // POST (auth)تم

  // ---------------- Apartments ----------------
  static const String apartments =
      "/apartments"; // GET////تمللاونر لسل فلترة و رنتر
  static String apartmentDetails(int id) =>
      "/apartments/$id"; // GET//بدي اربطو بس للرينتر حاليا
  static const String createApartment =
      "/apartments"; // POST (auth + role:owner)تم
  static String updateApartment(int id) =>
      "/apartments/$id"; // PUT (auth + role:owner)تم
  static String deleteApartment(int id) =>
      "/apartments/$id"; // DELETE (auth + role:owner)تم
  // ---------------- Owner Apartments ----------------
  static const String ownerApartments =
      "/owner/apartments"; // GET (auth + role:owner)

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
  static const String adminLogin = "/admin/login-as-default"; // POSTتم
  static const String pendingUsers =
      "/admin/pending-users"; // GET (auth + role:admin)تم
  static String approveUser(int id) => "/admin/users/$id/approve"; // PATCHتم
  static String rejectUser(int id) => "/admin/users/$id/reject"; // PATCHتم
}
