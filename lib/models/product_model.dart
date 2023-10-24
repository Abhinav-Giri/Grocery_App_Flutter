// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  final String? email;
  final String? password;

  Product({
    this.email,
    this.password,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      email: json['email'],
      password: json['passsword'],
    );
  }
}
