
class RulesModel {
    RulesModel({
        this.id,
        this.rulesFor,
        this.rules,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String rulesFor;
    String rules;
    DateTime createdAt;
    DateTime updatedAt;

    factory RulesModel.fromJson(Map<String, dynamic> json) => RulesModel(
        id: json["id"] == null ? null : json["id"],
        rulesFor: json["rules_for"] == null ? null : json["rules_for"],
        rules: json["rules"] == null ? null : json["rules"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "rules_for": rulesFor == null ? null : rulesFor,
        "rules": rules == null ? null : rules,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
