class User {

  final String uid;
  final String email;
  final bool isVerified;
  final String displayName;

  User({
    this.uid,
    this.email,
    this.isVerified,
    this.displayName
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      email: json['email'],
      isVerified: json['isVerified'],
      displayName: json['displayName']
    );
  }

}