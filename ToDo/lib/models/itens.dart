class Itens {
  int id;
  String atividade;
  bool marcado;

  Itens({this.id, this.atividade, this.marcado});

  Itens.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    atividade = json['atividade'];
    marcado = json['marcado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['atividade'] = this.atividade;
    data['marcado'] = this.marcado;
    return data;
  }
}
