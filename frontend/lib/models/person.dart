class Person {
  final int? id;
  final String nom;
  final String prenom;
  final String telephone;
  final String userID ;


  Person({
    this.id,
    required this.nom,
    required this.prenom,
    required this.telephone,
    required this.userID
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      telephone: json['telephone'],
      userID: json['userID']
    );
  }
  

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'userID': userID
    };
  }
}
