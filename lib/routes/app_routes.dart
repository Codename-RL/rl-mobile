abstract class Routes {
  // journal
  static const journal = '/';

  // people
  static const people = '/people';
  static const personDetail = '/people/:id';

  // compose
  static const compose = '/compose';


  // reminder
  static const reminder = '/reminder';

  // settings
  static const settings = '/setting';


  // auth
  static const login   = '/auth/login';
  static const register= '/auth/register';
  static const otp     = '/auth/otp';        // ?email=...
  static const reset   = '/auth/reset';
}
