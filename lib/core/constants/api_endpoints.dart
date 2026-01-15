class ApiEndpoints {
  static const String baseUrl =
      "https://nancy-nondisputatious-interlocally.ngrok-free.dev/api";

  static const Map<String, String> headers = {
    "ngrok-skip-browser-warning": "true",
    "Accept": "application/json",
  };

  static String get storageBaseUrl {
    return baseUrl.replaceAll('/api', '/storage/');
  }

  // ---------------- Auth ----------------
  static const String register = "/register"; //
  static const String login = "/login"; //
  static const String logout = "/logout"; //
  static const String user = "/user"; //
  static const String profile = "/profile"; //
  static const String updateProfile = "/profile"; //

  // ---------------- Apartments ----------------
  static const String apartments = "/apartments"; //
  static String apartmentDetails(int id) => "/apartments/$id"; //
  static const String createApartment = "/apartments"; //
  static String updateApartment(int id) => "/apartments/$id"; //
  static String deleteApartment(int id) => "/apartments/$id"; //

  // Owner Apartments
  static const String ownerApartments = "/owner/apartments"; //

  // ---------------- Bookings ----------------
  static const String bookings = "/bookings";
  static const String myBookings = "/my-bookings"; //
  static String bookingDetails(int id) => "/bookings/$id"; //
  static String updateBooking(int id) => "/bookings/$id";
  static String cancelBooking(int id) => "/bookings/$id/cancel"; //
  static String reviewBooking(int id) => "/bookings/$id/review";

  // Owner actions
  static String approveBooking(int id) => "/owner/bookings/$id/approve"; //
  static String rejectBooking(int id) => "/owner/bookings/$id/reject"; //
  static const String ownerBookings = "/owner/bookings"; //

  // ---------------- Favorites ----------------
  static const String favorites = "/favorites"; //
  static String toggleFavorite(int id) => "/favorites/toggle/$id"; //

  // ---------------- Admin ----------------
  // داخل كلاس ApiEndpoints
  static const String adminLogin = "/login"; //
  static const String pendingUsers = "/admin/pending-users"; //
  static String approveUser(int id) => "/admin/users/$id/approve"; //
  static String rejectUser(int id) => "/admin/users/$id/reject"; //
}
