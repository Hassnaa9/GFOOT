class EmissionEntry {
  final DateTime date;
  final double carbonEmission;

  EmissionEntry({required this.date, required this.carbonEmission});

  factory EmissionEntry.fromJson(Map<String, dynamic> json) {
    return EmissionEntry(
      date: DateTime.parse(json['Date']),
      carbonEmission: (json['CarbonEmission'] as num).toDouble(),
    );
  }
}

class StatisticsModel {
  final List<EmissionEntry> daily;
  final List<EmissionEntry> monthly;
  final List<EmissionEntry> yearly;

  StatisticsModel({
    required this.daily,
    required this.monthly,
    required this.yearly,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      daily: (json['DataDaily'] as List)
          .map((e) => EmissionEntry.fromJson(e))
          .toList(),
      monthly: (json['DataMonthly'] as List)
          .map((e) => EmissionEntry.fromJson(e))
          .toList(),
      yearly: (json['DataYearly'] as List)
          .map((e) => EmissionEntry.fromJson(e))
          .toList(),
    );
  }
}
