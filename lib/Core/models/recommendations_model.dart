class Recommendation {
  final String id; // Unique identifier for the recommendation
  final String title; // Maps to RecHeader (e.g., "Diet")
  final String description; // Maps to RecBody
  final DateTime timestamp; // Client-side timestamp since not provided by backend
  final String category; // Inferred from RecHeader for icon mapping

  Recommendation({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.category,
  });

  // Factory method to create a Recommendation from JSON
  factory Recommendation.fromJson(Map<String, dynamic> json) {
    final header = json['RecHeader'] as String? ?? 'General';
    return Recommendation(
      id: json['Id'] as String? ?? '',
      title: header,
      description: json['RecBody'] as String? ?? '',
      timestamp: DateTime.now(), // Use current time since timestamp isn't provided
      category: _inferCategory(header), // Infer category from RecHeader
    );
  }

  // Helper method to infer category from RecHeader
  static String _inferCategory(String header) {
    switch (header.toLowerCase()) {
      case 'diet':
        return 'food';
      case 'clothing':
        return 'clothing';
      default:
        return 'general';
    }
  }

  // Method to convert Recommendation to JSON (if needed for sending data back)
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'RecHeader': title,
      'RecBody': description,
      'timestamp': timestamp.toIso8601String(),
      'category': category,
    };
  }
}