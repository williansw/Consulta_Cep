import 'package:consulta_cep/consulta_cep.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Consultar CEP", () async {
    final consultaCep = await ConsultaCEP.getCEP("41650121");
    expect(consultaCep, isA<ConsultaCEP>());
  });
}
