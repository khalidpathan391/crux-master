class CaseStudyAns {
  List finding1;
  List finding2;
  List discussion1;
  List discussion2;
  List discussion3;
  List conclusion;
  List recommendations;
  List implementation1;
  List implementation2;
  List reference;
  List appendices;
  CaseStudyAns(
      this.finding1,
      this.finding2,
      this.discussion1,
      this.discussion2,
      this.discussion3,
      this.conclusion,
      this.recommendations,
      this.implementation1,
      this.implementation2,
      this.reference,
      this.appendices);
  CaseStudyAns.fromJson(Map<String, dynamic> json)
      : finding1 = json["finding1"],
        finding2 = json["finding2"],
        discussion1 = json["discussion1"],
        discussion2 = json["discussion2"],
        discussion3 = json["discussion3"],
        conclusion = json["conclusion"],
        recommendations = json["recommendations"],
        implementation1 = json["implementation1"],
        implementation2 = json["implementation2"],
        reference = json["reference"],
        appendices = json["appendices"];
  Map<String, dynamic> toJson() {
    return {
      "finding1": finding1,
      "finding2": finding2,
      "discussion1": discussion1,
      "discussion2": discussion2,
      "discussion3": discussion3,
      "conclusion": conclusion,
      "recommendations": recommendations,
      "implementation1": implementation1,
      "implementation2": implementation2,
      "reference": reference,
      "appendices": appendices
    };
  }
}
