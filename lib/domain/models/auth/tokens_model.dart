class Tokens {
  String? refresh;
  String? access;

  Tokens({this.refresh, this.access});

  factory Tokens.fromJson(Map<String, dynamic> json) =>
      Tokens(refresh: json['refresh'], access: json['access']);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'refresh': refresh, 'access': access};
}
