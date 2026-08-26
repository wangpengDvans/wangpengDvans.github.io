import 'package:equatable/equatable.dart';

class TimelineEvent extends Equatable {
  final String year;
  final String title;
  final String? subtitle;

  const TimelineEvent({
    required this.year,
    required this.title,
    this.subtitle,
  });

  factory TimelineEvent.fromJson(Map<String, dynamic> json) {
    return TimelineEvent(
      year: json['year'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'year': year,
        'title': title,
        'subtitle': subtitle,
      };

  @override
  List<Object?> get props => [year, title, subtitle];
}

class GuestbookMessage extends Equatable {
  final String id;
  final String author;
  final String content;
  final String date;

  const GuestbookMessage({
    required this.id,
    required this.author,
    required this.content,
    required this.date,
  });

  factory GuestbookMessage.fromJson(Map<String, dynamic> json) {
    return GuestbookMessage(
      id: json['id'] as String,
      author: json['author'] as String,
      content: json['content'] as String,
      date: json['date'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author,
        'content': content,
        'date': date,
      };

  @override
  List<Object?> get props => [id, author, content, date];
}

class MemorialProfile extends Equatable {
  final String id;
  final String name;
  final String birthDate;
  final String deathDate;
  final int age;
  final String? photoUrl;
  final String epitaph;
  final int flowerCount;
  final int candleCount;
  final int messageCount;
  final int shareCount;
  final List<TimelineEvent> timeline;
  final List<GuestbookMessage> messages;

  const MemorialProfile({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.deathDate,
    required this.age,
    this.photoUrl,
    required this.epitaph,
    required this.flowerCount,
    required this.candleCount,
    required this.messageCount,
    required this.shareCount,
    required this.timeline,
    required this.messages,
  });

  factory MemorialProfile.fromJson(Map<String, dynamic> json) {
    return MemorialProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      birthDate: json['birthDate'] as String,
      deathDate: json['deathDate'] as String,
      age: json['age'] as int,
      photoUrl: json['photoUrl'] as String?,
      epitaph: json['epitaph'] as String,
      flowerCount: json['flowerCount'] as int,
      candleCount: json['candleCount'] as int,
      messageCount: json['messageCount'] as int,
      shareCount: json['shareCount'] as int,
      timeline: (json['timeline'] as List<dynamic>)
          .map((e) => TimelineEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      messages: (json['messages'] as List<dynamic>)
          .map((e) => GuestbookMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'birthDate': birthDate,
        'deathDate': deathDate,
        'age': age,
        'photoUrl': photoUrl,
        'epitaph': epitaph,
        'flowerCount': flowerCount,
        'candleCount': candleCount,
        'messageCount': messageCount,
        'shareCount': shareCount,
        'timeline': timeline.map((e) => e.toJson()).toList(),
        'messages': messages.map((e) => e.toJson()).toList(),
      };

  MemorialProfile copyWith({
    int? flowerCount,
    int? candleCount,
    int? messageCount,
    int? shareCount,
  }) =>
      MemorialProfile(
        id: id,
        name: name,
        birthDate: birthDate,
        deathDate: deathDate,
        age: age,
        photoUrl: photoUrl,
        epitaph: epitaph,
        flowerCount: flowerCount ?? this.flowerCount,
        candleCount: candleCount ?? this.candleCount,
        messageCount: messageCount ?? this.messageCount,
        shareCount: shareCount ?? this.shareCount,
        timeline: timeline,
        messages: messages,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        birthDate,
        deathDate,
        age,
        photoUrl,
        epitaph,
        flowerCount,
        candleCount,
        messageCount,
        shareCount,
        timeline,
        messages,
      ];
}
