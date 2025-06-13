class Utils {
  bool isValidUsername(String username) {
    final RegExp regExp = RegExp(r'^.{5,}$');

    return regExp.hasMatch(username);
  }

  bool isValidEmail(String email) {
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  bool isValidPassword(String password) {
  final RegExp regExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

    
    return regExp.hasMatch(password);
  }

  bool isValidName(String name) {
    final RegExp regExp = RegExp(r'^(?!\s*$).+');
    return regExp.hasMatch(name);
  }

  bool istelephoneNumber(String number) {
final RegExp regExp = RegExp(r'^0\d{9}$');


    return regExp.hasMatch(number);
  }

  bool isValidAddress(String address) {
    final RegExp regExp = RegExp(r'^.+$');
    return regExp.hasMatch(address);
  }
}
