import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart' as entity;

class SampleFeature {
  final int id;
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
  final List<Repo>? repositoryList;
  final List<SampleFeature>? followersList;
  final List<SampleFeature>? followingList;

  const SampleFeature({
    required this.id,
    required this.username,
    this.name,
    this.location,
    this.company,
    this.gitUrl,
    this.bio,
    this.avatarUrl,
    this.repository,
    this.followers,
    this.following,
    this.repositoryList,
    this.followersList,
    this.followingList,
  });

  factory SampleFeature.fromJson(Map<String, dynamic> json) {
    return SampleFeature(
      id: json['id'] as int,
      username: json['login'] as String,
      name: json['name'] as String?,
      location: json['location'] as String?,
      company: json['company'] as String?,
      gitUrl: json['html_url'] as String?,
      bio: json['bio'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      repository: json['public_repos'] as int?,
      followers: json['followers'] as int?,
      following: json['following'] as int?,
      repositoryList: json['repository_list'] != null
          ? (json['repository_list'] as List)
              .map((i) => Repo.fromJson(i))
              .toList()
          : null,
      followersList: json['followers_list'] != null
          ? (json['followers_list'] as List)
              .map((i) => SampleFeature.fromJson(i))
              .toList()
          : null,
      followingList: json['following_list'] != null
          ? (json['following_list'] as List)
              .map((i) => SampleFeature.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': username,
      'name': name,
      'location': location,
      'company': company,
      'html_url': gitUrl,
      'bio': bio,
      'avatar_url': avatarUrl,
      'public_repos': repository,
      'followers': followers,
      'following': following,
      'repository_list': repositoryList?.map((e) => e.toJson()).toList(),
      'followers_list': followersList?.map((e) => e.toJson()).toList(),
      'following_list': followingList?.map((e) => e.toJson()).toList(),
    };
  }

  SampleFeature copyWith({
    int? id,
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
    List<Repo>? repositoryList,
    List<SampleFeature>? followersList,
    List<SampleFeature>? followingList,
  }) {
    return SampleFeature(
      id: id ?? this.id,
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
      repositoryList: repositoryList ?? this.repositoryList,
      followersList: followersList ?? this.followersList,
      followingList: followingList ?? this.followingList,
    );
  }

  entity.SampleFeature toEntity() => entity.SampleFeature(
        id: id,
        username: username,
        name: name,
        gitUrl: gitUrl,
        bio: bio,
        avatarUrl: avatarUrl,
        company: company,
        location: location,
        repository: repository,
        followers: followers,
        following: following,
        repositoryList: repositoryList?.map((e) => e.toEntity()).toList(),
        followersList: followersList?.map((e) => e.toEntity()).toList(),
        followingList: followingList?.map((e) => e.toEntity()).toList(),
      );
}
