
class User{

  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String city;
  final String company;
  final String website;

  User({this.id, this.name, this.username, this.email, this.phone, this.website,this.city,this.company});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      city: json['address']['city'],
      company: json['company']['name'],
    );
  }
}