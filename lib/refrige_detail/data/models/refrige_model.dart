class RefrigeDetail {
  int refrigeId;
  String refrigeName;
  int refrigeCompCount;
  int freezerCompCount;
  int period;
  int extentionPeriod;

//<editor-fold desc="Data Methods">
  RefrigeDetail({
    required this.refrigeId,
    required this.refrigeName,
    required this.refrigeCompCount,
    required this.freezerCompCount,
    required this.period,
    required this.extentionPeriod,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RefrigeDetail &&
          runtimeType == other.runtimeType &&
          refrigeId == other.refrigeId &&
          refrigeName == other.refrigeName &&
          refrigeCompCount == other.refrigeCompCount &&
          freezerCompCount == other.freezerCompCount &&
          period == other.period &&
          extentionPeriod == other.extentionPeriod);

  @override
  int get hashCode =>
      refrigeId.hashCode ^
      refrigeName.hashCode ^
      refrigeCompCount.hashCode ^
      freezerCompCount.hashCode ^
      period.hashCode ^
      extentionPeriod.hashCode;

  @override
  String toString() {
    return 'RefrigeDetail{ refrigeId: $refrigeId, refrigeName: $refrigeName, refrigeCompCount: $refrigeCompCount, freezerCompCount: $freezerCompCount, period: $period, extentionPeriod: $extentionPeriod,}';
  }

  RefrigeDetail copyWith({
    int? refrigeId,
    String? refrigeName,
    int? refrigeCompCount,
    int? freezerCompCount,
    int? period,
    int? extentionPeriod,
  }) {
    return RefrigeDetail(
      refrigeId: refrigeId ?? this.refrigeId,
      refrigeName: refrigeName ?? this.refrigeName,
      refrigeCompCount: refrigeCompCount ?? this.refrigeCompCount,
      freezerCompCount: freezerCompCount ?? this.freezerCompCount,
      period: period ?? this.period,
      extentionPeriod: extentionPeriod ?? this.extentionPeriod,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'refrigeId': refrigeId,
      'refrigeName': refrigeName,
      'refrigeCompCount': refrigeCompCount,
      'freezerCompCount': freezerCompCount,
      'period': period,
      'extentionPeriod': extentionPeriod,
    };
  }

  factory RefrigeDetail.fromMap(Map<String, dynamic> map) {
    return RefrigeDetail(
      refrigeId: map['refrigeId'] as int,
      refrigeName: map['refrigeName'] as String,
      refrigeCompCount: map['refrigeCompCount'] as int,
      freezerCompCount: map['freezerCompCount'] as int,
      period: map['period'] as int,
      extentionPeriod: map['extentionPeriod'] as int,
    );
  }

//</editor-fold>
}