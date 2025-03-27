class AccountModel {
  final String? name;
  final String email;
  final String? image;
  final String? accessToken;

  AccountModel({
    required this.email,
    this.name,
    this.image,
    this.accessToken,
  });
}
