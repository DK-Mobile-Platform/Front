class User {
  String id;
  String username;
  String password;
  String country;
  String? userId; //로그인에 성공할때 username으로 할당, 그 외엔 null

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.country,
    this.userId
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'country': country,
      'userId': userId, // userId가 null일 수 있으므로 nullable로 설정
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      country: map['country'],
      userId: map['userId'], // userId가 null일 수 있으므로 nullable로 설정
    );
  }
}
