class FinanceModel {
  FinanceModel({
    this.totalSpp,
    this.totalFee,
    this.laba,
  });

  int totalSpp;
  int totalFee;
  int laba;

  factory FinanceModel.fromJson(Map<String, dynamic> json) => FinanceModel(
        totalSpp: json["total_spp"],
        totalFee: json["total_fee"],
        laba: json["laba"],
      );

  Map<String, dynamic> toJson() => {
        "total_spp": totalSpp,
        "total_fee": totalFee,
        "laba": laba,
      };
}
