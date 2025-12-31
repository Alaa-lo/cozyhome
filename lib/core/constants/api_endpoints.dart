class ApiEndpoints {
  static const String baseUrl =
      "https://nancy-nondisputatious-interlocally.ngrok-free.dev/api";

  // Auth
  static const String register = "/register";
  static const String login = "/login";
  static const String logout = "/logout";
  static const String profile = "/profile";
  static const String user = "/user";
  static const String updateProfile = "/profile"; // POST to update

  // Apartments
  static const String apartments = "/apartments";
  static String apartmentDetails(int id) => "/apartments/$id";

  // Bookings
  static const String bookings = "/bookings";
  static const String myBookings = "/my-bookings";
  static String bookingDetails(int id) => "/bookings/$id";
  static String cancelBooking(int id) => "/bookings/$id/cancel";
  static String approveBooking(int id) => "/owner/bookings/$id/approve";
  static String rejectBooking(int id) => "/owner/bookings/$id/reject";
  static String reviewBooking(int id) => "/bookings/$id/review";

  // Favorites
  static const String favorites = "/favorites";
  static String toggleFavorite(int id) => "/favorites/toggle/$id";

  // Admin
  static String approveUser(int id) => "/admin/users/$id/approve";
  static String rejectUser(int id) => "/admin/users/$id/reject";
}
