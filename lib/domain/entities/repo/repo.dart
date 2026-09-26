import 'package:equatable/equatable.dart';
import 'package:skybase/domain/entities/sample_feature/sample_feature.dart';

class Repo extends Equatable {
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

  @override
  List<Object?> get props => [
        name,
        owner,
        description,
        language,
        totalWatch,
        totalFork,
        totalStar,
      ];

  Repo copyWith({
    String? name,
    SampleFeature? owner,
    String? description,
    String? language,
    int? totalWatch,
    int? totalFork,
    int? totalStar,
  }) {
    return Repo(
      name: name ?? this.name,
      owner: owner ?? this.owner,
      description: description ?? this.description,
      language: language ?? this.language,
      totalWatch: totalWatch ?? this.totalWatch,
      totalFork: totalFork ?? this.totalFork,
      totalStar: totalStar ?? this.totalStar,
    );
  }
}
