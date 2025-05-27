class AuthorityResponse {
  String authority;

  AuthorityResponse({required this.authority});

  factory AuthorityResponse.fromJson(Map<String, dynamic> json) {
    return AuthorityResponse(authority: json['authority']);
  }

  Map<String, dynamic> toJson() {
    return {'authority': authority};
  }
}