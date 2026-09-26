import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/domain/entities/repo/repo.dart' as entity;

class Repo {
  final String name;
  final SampleFeature owner;
  final String? description;
  final String? language;
  final int? totalWatch;
  final int? totalFork;
  final int? totalStar;

  const Repo({
    required this.name,
    required this.owner,
    this.description,
    this.language,
    this.totalWatch,
    this.totalFork,
    this.totalStar,
  });

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      name: json['full_name'] as String,
      owner: SampleFeature.fromJson(json['owner'] as Map<String, dynamic>),
      description: json['description'] as String?,
      language: json['language'] as String?,
      totalWatch: json['watchers_count'] as int?,
      totalFork: json['forks_count'] as int?,
      totalStar: json['stargazers_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': name,
      'owner': owner.toJson(),
      'description': description,
      'language': language,
      'watchers_count': totalWatch,
      'forks_count': totalFork,
      'stargazers_count': totalStar,
    };
  }

  entity.Repo toEntity() => entity.Repo(
        name: name,
        owner: owner.toEntity(),
        description: description,
        language: language,
        totalWatch: totalWatch,
        totalFork: totalFork,
        totalStar: totalStar,
      );
}
