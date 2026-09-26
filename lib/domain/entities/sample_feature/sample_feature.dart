import 'package:equatable/equatable.dart';
import 'package:skybase/domain/entities/repo/repo.dart';

class SampleFeature extends Equatable {
  final int id;
  final String username;
  final String? name;
  final String? gitUrl;
  final String? bio;
  final String? avatarUrl;
  final String? company;
  final String? location;
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
    this.gitUrl,
    this.bio,
    this.avatarUrl,
    this.company,
    this.location,
    this.repository,
    this.followers,
    this.following,
    this.repositoryList,
    this.followersList,
    this.followingList,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        name,
        gitUrl,
        bio,
        avatarUrl,
        company,
        location,
        repository,
        followers,
        following,
        repositoryList,
        followersList,
        followingList,
      ];

  SampleFeature copyWith({
    int? id,
    String? username,
    String? name,
    String? gitUrl,
    String? bio,
    String? avatarUrl,
    String? company,
    String? location,
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
      gitUrl: gitUrl ?? this.gitUrl,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      company: company ?? this.company,
      location: location ?? this.location,
      repository: repository ?? this.repository,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      repositoryList: repositoryList ?? this.repositoryList,
      followersList: followersList ?? this.followersList,
      followingList: followingList ?? this.followingList,
    );
  }
}
