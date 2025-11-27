abstract class PeopleRoutes {
  static const page   = '/people';        // optional deep-link
  static const detail = '/people/detail/:id';    // tanpa navbar
  static const form   = '/people/form';
  static String detailPath(String id) => '/people/detail/$id';
}
