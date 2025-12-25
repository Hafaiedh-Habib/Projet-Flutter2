class User {
  final int? id;
  final String nom;
  final String prenom;
  final String numero;
  final String? motDePasse; // Optional for login responses

  User({
    this.id,
    required this.nom,
    required this.prenom,
    required this.numero,
    this.motDePasse,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      numero: map['numero'],
      motDePasse: map['mot_de_passe'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'prenom': prenom,
      'numero': numero,
      if (motDePasse != null) 'mot_de_passe': motDePasse,
    };
  }

  Map<String, dynamic> toJsonWithId() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'numero': numero,
<<<<<<< HEAD
    };
=======
      'mot_de_passe': motDePasse
      };
>>>>>>> 2f047c9461103b86b359469ea2a001eab7f624b9
  }
}


