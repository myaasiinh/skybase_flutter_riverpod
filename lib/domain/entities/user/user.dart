import 'package:equatable/equatable.dart';

class User extends Equatable {
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

  @override
  List<Object?> get props => [
        id,
        token,
        refreshToken,
        username,
        name,
        location,
        company,
        gitUrl,
        bio,
        avatarUrl,
        repository,
        followers,
        following,
      ];

  User copyWith({
    int? id,
    String? token,
    String? refreshToken,
    String? username,
    String? name,
    String? location,
    String? company,
    String? gitUrl,
    String? bio,
    String? avatarUrl,
    int? repository,
    int? followers,
    int? following,
  }) {
    return User(
      id: id ?? this.id,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
      username: username ?? this.username,
      name: name ?? this.name,
      location: location ?? this.location,
      company: company ?? this.company,
      gitUrl: gitUrl ?? this.gitUrl,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      repository: repository ?? this.repository,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}
