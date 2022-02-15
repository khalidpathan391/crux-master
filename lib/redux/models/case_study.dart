class CaseStudy {
  String name;
  String beg_date;
  String end_date;
  String interest_profile;
  String personality;
  String subject;
  String sub_subject;
  String semester;
  String year;
  String purpose;
  String find_of_research;
  String issue_and_finiding;
  String methodology;
  List condition;
  List reward_and_recognition;
  Map major_outComes;
  CaseStudy(
      this.name,
      this.beg_date,
      this.end_date,
      this.interest_profile,
      this.personality,
      this.subject,
      this.sub_subject,
      this.semester,
      this.year,
      this.purpose,
      this.find_of_research,
      this.issue_and_finiding,
      this.methodology,
      this.condition,
      this.reward_and_recognition,
      this.major_outComes);
  CaseStudy.fromJson(Map<String, dynamic> json):
      name=json["name"],
  beg_date=json["beg_date"],
  end_date=json["end_date"],
  interest_profile=json["interest_profile"],
  personality=json["personality"],
  subject=json["subject"],
  sub_subject=json["sub_subject"],
  semester=json["semester"],
  year=json["year"],
  purpose=json["purpose"],
  find_of_research=json["find_of_research"],
  issue_and_finiding=json["issue_and_finiding"],
  methodology=json["methodology"],
  condition=json["condition"],
  reward_and_recognition=json["reward_and_recognition"],
  major_outComes=json["major_outComes"];
  Map<String, dynamic> toJson() {
  return {
   "name":name,
   "beg_date":beg_date,
   "end_date":end_date,
   "interest_profile":interest_profile,
   "personality":personality,
   "subject":subject,
   "sub_subject":sub_subject,
   "semester":semester,
   "year":year,
   "purpose":purpose,
   "find_of_research":find_of_research,
   "issue_and_finiding":issue_and_finiding,
   "methodology":methodology,
   "condition":condition,
   "reward_and_recognition":reward_and_recognition,
   "major_outComes":major_outComes
  };

  }
}
