import 'package:consulta_cep/consulta_cep.dart';
import 'package:flutter/material.dart';

import 'models/cep_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consulta CEP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController cepController = TextEditingController();
  var cepData = CepModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 20 / 100,
              child: Form(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 75 / 100,
                      child: TextFormField(
                        controller: cepController,
                        textAlign: TextAlign.start,
                        keyboardType: TextInputType.number,
                      )),
                  FloatingActionButton(
                      child: const Icon(Icons.search),
                      onPressed: () async {
                        if (cepController.value.text.length == 8) {
                          cepData = await getCep(cepController.text);
                          setState(() {});
                        } else {
                          await showAlertDialog(context);
                        }
                      })
                ],
              )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 65 / 100,
              child: FutureBuilder<ConsultaCEP>(
                  future: ConsultaCEP.getCEP(cepController.text == ''
                      ? '41650121'
                      : cepController.text),
                  builder: ((context, snapshot) {
                    return Column(
                      children: [
                        Text(
                            'Logradouro - ${snapshot.data == null ? '' : snapshot.data?.logradouro ?? 'Não encontrado'}'),
                        Text(
                            'Complemento - ${snapshot.data == null ? '' : snapshot.data?.complemento ?? 'Não encontrado'}'),
                        Text(
                            'Bairro - ${snapshot.data == null ? '' : snapshot.data?.bairro ?? 'Não encontrado'}'),
                        Text(
                            'Cidade - ${snapshot.data == null ? '' : snapshot.data?.localidade ?? 'Não encontrado'}'),
                        Text(
                            'UF - ${snapshot.data == null ? '' : snapshot.data?.uf ?? 'Não encontrado'}'),
                        Text(
                            'DDD - ${snapshot.data == null ? '' : snapshot.data?.ddd ?? 'Não encontrado'}'),
                      ],
                    );
                  })),
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //         'Logradouro - ${cepData.logradouro ?? 'Não encontrado'}'),
              //     Text(
              //         'Complemento - ${cepData.complemento ?? 'Não encontrado'}'),
              //     Text('Bairro - ${cepData.bairro ?? 'Não encontrado'}'),
              //     Text('Cidade - ${cepData.localidade ?? 'Não encontrado'}'),
              //     Text('UF - ${cepData.uf ?? 'Não encontrado'}'),
              //     Text('IBGE - ${cepData.ibge ?? 'Não encontrado'}'),
              //     Text('GIA - ${cepData.gia ?? 'Não encontrado'}'),
              //     Text('DDD - ${cepData.ddd ?? 'Não encontrado'}'),
              //     Text('Siafi - ${cepData.siafi ?? 'Não encontrado'}'),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = const AlertDialog(
    title: Text("CEP Inválido"),
    content: Text("O CEP precisa ter 8 digitos"),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<CepModel> getCep(String cep) async {
  var result = await ConsultaCEP.getCEP(cep);
  return CepModel.fromConsultaCEP(result);
}
