class FamiliaCategoriaDtoPost {
  int idFamilia;
  int idCategoria;

  FamiliaCategoriaDtoPost({
    required this.idFamilia,
    required this.idCategoria,
  });

  factory FamiliaCategoriaDtoPost.fromJson(Map<String, dynamic> json) {
    return FamiliaCategoriaDtoPost(
      idFamilia: json['idFamilia'],
      idCategoria: json['idCategoria'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idFamilia': idFamilia,
      'idCategoria': idCategoria,
    };
  }
}