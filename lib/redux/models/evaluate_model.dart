class EvaluateAns {
  double level_of_understandin;
  double accuracy_of_finding;
  double level_of_satisfaction;
  double feasibility_of_ecommendation;
  double sustainablity_of_implementation;
  double relevance_of_reference;
  double quality_of_language;
  String status;
  EvaluateAns(
      this.level_of_understandin,
      this.accuracy_of_finding,
      this.level_of_satisfaction,
      this.feasibility_of_ecommendation,
      this.sustainablity_of_implementation,
      this.relevance_of_reference,
      this.quality_of_language,
      this.status);
  EvaluateAns.fromJson(Map<String, dynamic> json)
      : level_of_understandin = json["level_of_understandin"],
        accuracy_of_finding = json["accuracy_of_finding"],
        level_of_satisfaction = json["level_of_satisfaction"],
        feasibility_of_ecommendation = json["feasibility_of_ecommendation"],
        sustainablity_of_implementation =
            json["sustainablity_of_implementation"],
        relevance_of_reference = json["relevance_of_reference"],
        quality_of_language = json["quality_of_language"],
        status = json["status"];
  Map<String, dynamic> toJson() {
    return {
      "level_of_understandin": level_of_understandin,
      "accuracy_of_finding": accuracy_of_finding,
      "level_of_satisfaction": level_of_satisfaction,
      "feasibility_of_ecommendation": feasibility_of_ecommendation,
      "sustainablity_of_implementation": sustainablity_of_implementation,
      "relevance_of_reference": relevance_of_reference,
      "quality_of_language": quality_of_language,
      "status": status
    };
  }
}
