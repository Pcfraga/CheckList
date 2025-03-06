class LoginViewModel {
  final String email;
  final String password;

  LoginViewModel({required this.email, required this.password});

  factory LoginViewModel.fromMap(Map<String, dynamic> map) {
    return LoginViewModel(email: map['email'], password: map['password']);
  }
}
