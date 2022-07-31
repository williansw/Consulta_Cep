import 'package:consulta_cep/consulta_cep.dart';

class CepModel {
  final String? logradouro;
  final String? complemento;
  final String? bairro;
  final String? localidade;
  final String? cep;
  final String? uf;
  final String? ibge;
  final String? gia;
  final String? ddd;
  final String? siafi;

  CepModel(
      {this.cep,
      this.logradouro,
      this.complemento,
      this.bairro,
      this.localidade,
      this.uf,
      this.ibge,
      this.gia,
      this.ddd,
      this.siafi});

  factory CepModel.fromJson(Map<String, dynamic> json) {
    return CepModel(
        cep: json['cep'] ?? '',
        logradouro: json['logradouro'] ?? '',
        complemento: json['complemento'] ?? '',
        bairro: json['bairro'] ?? '',
        localidade: json['localidade'] ?? '',
        uf: json['uf'] ?? '',
        ibge: json['ibge'] ?? '',
        gia: json['gia'] ?? '',
        ddd: json['ddd'] ?? '',
        siafi: json['siafi'] ?? '');
  }
  factory CepModel.fromConsultaCEP(ConsultaCEP consultaCEP) {
    return CepModel(
        cep: consultaCEP.cep ?? '',
        logradouro: consultaCEP.logradouro ?? '',
        complemento: consultaCEP.complemento ?? '',
        bairro: consultaCEP.bairro ?? '',
        localidade: consultaCEP.localidade ?? '',
        uf: consultaCEP.uf ?? '',
        ibge: consultaCEP.ibge ?? '',
        gia: consultaCEP.gia ?? '',
        ddd: consultaCEP.ddd ?? '',
        siafi: consultaCEP.siafi ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    data['ibge'] = ibge;
    data['gia'] = gia;
    data['ddd'] = ddd;
    data['siafi'] = siafi;
    return data;
  }
}
