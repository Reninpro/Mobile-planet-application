class Planeta {
  int? id;
  String name;
  double size;
  double distance;
  String? nickname;

  Planeta({
    //Construtor normal
    this.id = 0,
    required this.name,
    required this.size,
    required this.distance,
    this.nickname,
  });

  Planeta.vazio() // Construtor alternativo
    : name = '',
      size = 0.0,
      distance = 0.0,
      nickname = '';

  factory Planeta.fromMap(Map<String, dynamic> map) {
    return Planeta(
      id: map['id'],
      name: map['nome'],
      size: map['tamanho'],
      distance: map['distancia'],
      nickname: map['apelido'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'tamanho': size,
      'distancia': distance,
      'apelido': nickname,
    }; // Procedimento key -> value
  }
}
