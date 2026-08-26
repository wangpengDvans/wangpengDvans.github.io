import 'package:equatable/equatable.dart';

class GuideStep extends Equatable {
  final int index;
  final String title;
  final String subtitle;
  final String description;
  final List<String> materials;
  final List<String> costReferences;
  final bool isCompleted;

  const GuideStep({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.materials,
    required this.costReferences,
    required this.isCompleted,
  });

  factory GuideStep.fromJson(Map<String, dynamic> json) {
    return GuideStep(
      index: json['index'] as int,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      description: json['description'] as String,
      materials: (json['materials'] as List<dynamic>).cast<String>(),
      costReferences: (json['costReferences'] as List<dynamic>).cast<String>(),
      isCompleted: json['isCompleted'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'index': index,
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'materials': materials,
        'costReferences': costReferences,
        'isCompleted': isCompleted,
      };

  GuideStep copyWith({bool? isCompleted}) => GuideStep(
        index: index,
        title: title,
        subtitle: subtitle,
        description: description,
        materials: materials,
        costReferences: costReferences,
        isCompleted: isCompleted ?? this.isCompleted,
      );

  @override
  List<Object?> get props => [index, title, subtitle, description, materials, costReferences, isCompleted];
}
