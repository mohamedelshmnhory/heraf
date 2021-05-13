class UserDetails {
  final String name,
      userId,
      address,
      email,
      password,
      photo,
      category,
      phone,
      type,
      token;
  double rate;

  UserDetails(
      {this.name,
      this.token,
      this.photo,
      this.category,
      this.rate,
      this.phone,
      this.address,
      this.email,
      this.type,
      this.userId,
      this.password});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      userId: json['userId'] ?? "",
      name: json['name'] ?? "",
      address: json['address'] ?? "",
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      photo: json['photo'] ?? "",
      category: json['category'] ?? "",
      type: json['type'] ?? "",
      phone: json['phone'] ?? "",
      token: json['token'] ?? "",
      rate: json['rate'] ?? 0.0,
    );
  }
}
