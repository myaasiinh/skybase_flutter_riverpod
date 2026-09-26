import 'package:skybase/domain/entities/user/user.dart' as entity;

class User {
  final int id;
  final String? token;
  final String? refreshToken;
  final String username;
  final String? name;
  final String? location;
  final String? company;
  final String? gitUrl;
  final String? bio;
  final String? avatarUrl;
  final int? repository;
  final int? followers;
  final int? following;

  const User({
    required this.id,
    required this.username,
    this.token,
    this.refreshToken,
    this.name,
    this.location,
    this.company,
    this.gitUrl,
    this.bio,
    this.avatarUrl,
    this.repository,
    this.followers,
    this.following,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['login'] ?? json['username'] as String,
      token: json['token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      name: json['name'] as String?,
      location: json['location'] as String?,
      company: json['company'] as String?,
      gitUrl: json['html_url'] as String?,
      bio: json['bio'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      repository: json['public_repos'] as int?,
      followers: json['followers'] as int?,
      following: json['following'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': username,
      'token': token,
      'refresh_token': refreshToken,
      'name': name,
      'location': location,
      'company': company,
      'html_url': gitUrl,
      'bio': bio,
      'avatar_url': avatarUrl,
      'public_repos': repository,
      'followers': followers,
      'following': following,
    };
  }

  entity.User toEntity() => entity.User(
        id: id,
        username: username,
        token: token,
        refreshToken: refreshToken,
        name: name,
        location: location,
        company: company,
        gitUrl: gitUrl,
        bio: bio,
        avatarUrl: avatarUrl,
        repository: repository,
        followers: followers,
        following: following,
      );
}
