abstract class PeopleRoutes {
  static const page   = '/people';        // optional deep-link
  static const detail = '/people/:id';    // tanpa navbar
  static String detailPath(String id) => '/people/$id';
}
