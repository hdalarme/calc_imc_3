import 'package:calc_imc_2/model/imc_model.dart';
import 'package:calc_imc_2/repositories/sqlite/imc_sqllite_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IMCResultPage extends StatefulWidget {
  const IMCResultPage({super.key});

  @override
  State<IMCResultPage> createState() => _IMCResultPageState();
}

class _IMCResultPageState extends State<IMCResultPage> {

  IMCSQLiteRepository imcRepository = IMCSQLiteRepository();
  // ignore: non_constant_identifier_names
  var _imcs = const <IMCModel>[];

  @override
  void initState() {
    super.initState();
    obterIMCs();
  }

  void obterIMCs() async {
    _imcs = await imcRepository.obterDados();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de IMCs Calculados")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
                children: [
                  
                  const SizedBox(
                  height: 15,
                ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: _imcs.length,
                          itemBuilder: (BuildContext bc, int index) {
                            var imc = _imcs[index];
                            return Dismissible(
                                onDismissed:
                                    (DismissDirection dismissDirection) async {
                                  await imcRepository.remover(imc.id);
                                  obterIMCs();
                                },
                                key: Key(imc.nome),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(imc.nome + ": " + imc.altura + " m, " + imc.peso + " Kg em " + imc.data /*DateFormat('dd/MM/yyyy').format(imc.data as DateTime)*/),
                                      subtitle: Text(imc.calcImc(imc)),
                                    ),
                                  ],
                                ));
                          }))
                ],
              ),
      ),
    );
  }
}