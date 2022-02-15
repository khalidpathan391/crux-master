class FireStroreUser {
  String mobile;
  String id;
  String name;
  String img;
  FireStroreUser(
      { this.id,
       this.img,
       this.mobile,
       this.name});

  Map<String, dynamic> toJson() {
    return {"name": name, "id": id, "image": img};
  }
}
