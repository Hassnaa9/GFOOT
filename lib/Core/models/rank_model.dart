class RankModel {
  final int cityRank;
  final int countryRank;
  final int globalRank;

  RankModel({
    required this.cityRank,
    required this.countryRank,
    required this.globalRank,
  });

  // Factory method to create a Rank from JSON
  factory RankModel.fromJson(Map<String, dynamic> json) {
    return RankModel(
      cityRank: json['CityRank'] as int? ?? 0,
      countryRank: json['CountryRank'] as int? ?? 0,
      globalRank: json['GlobalRank'] as int? ?? 0,
    );
  }

  // Method to convert Rank to JSON (if needed for sending data back)
  Map<String, dynamic> toJson() {
    return {
      'CityRank': cityRank,
      'CountryRank': countryRank,
      'GlobalRank': globalRank,
    };
  }
}