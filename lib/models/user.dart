class UserDetails {
  final String name,
      id,
      docId,
      address,
      email,
      password,
      photo,
      category,
      phone,
      type;
  double rate;

  UserDetails(
      {this.name,
      this.photo,
      this.category,
      this.rate,
      this.phone,
      this.address,
      this.email,
      this.type,
      this.id,
      this.docId,
      this.password});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      address: json['address'] ?? "",
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      photo: json['photo'] ?? "",
      category: json['category'] ?? "",
      type: json['type'] ?? "",
      phone: json['phone'] ?? "",
      rate: json['rate'] ?? 0.0,
    );
  }
}
