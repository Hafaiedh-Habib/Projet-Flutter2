class User {
  final int? id;
  final String nom;
  final String prenom;
  final String numero;
  final String motDePasse;
  final String userID ;

  User({
    this.id,
    required this.nom,
    required this.prenom,
    required this.numero,
    required this.motDePasse,
    required this.userID
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      numero: map['numero'],
      motDePasse: map['mot_de_passe'],
      userID: map['userID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'numero': numero,
      'mot_de_passe': motDePasse,
      'userID': userID
    };
  }
}


