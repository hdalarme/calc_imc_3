import 'package:calc_imc_2/services/app_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:calc_imc_2/model/imc_model.dart';
import 'package:calc_imc_2/repositories/sqlite/imc_sqllite_repository.dart';
import 'package:calc_imc_2/shared/widgets/text_label.dart';
import 'package:intl/intl.dart';

class IMCPage extends StatefulWidget {
  const IMCPage({Key? key}) : super(key: key);

  @override
  State<IMCPage> createState() => _IMCPageState();
}

class _IMCPageState extends State<IMCPage> {
  AppStorageService storage = AppStorageService();
  IMCSQLiteRepository imcRepository = IMCSQLiteRepository();
  var _imcs = const <IMCModel>[];
  var dataController = TextEditingController(text: "");
  var nomeController = TextEditingController(text: "");
  var pesoController = TextEditingController(text: "");
  var alturaController = TextEditingController(text: "");

  final formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    //obterIMCs();
    carregarDados();
  }

  bool salvando = false;

  carregarDados() async {
    dataController.text = formattedDate;
    nomeController.text = await storage.getConfiguracoesNomeUsuario();
    alturaController.text =
        (await (storage.getConfiguracoesAltura())).toString();
    setState(() {});

  }

  void obterIMCs() async {
    _imcs = await imcRepository.obterDados();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulário")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: salvando
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const TextLabel(texto: "Data"),
                  TextField(
                      controller: dataController,
                      readOnly: true,
                      onTap: () async {
                        var data = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900, 5, 20),
                            lastDate: DateTime(2999, 12, 31));
                        if (data != null) {
                          final formattedDate = DateFormat('dd/MM/yyyy').format(data);
                          dataController.text = formattedDate.toString();
                        }
                      }),
                  const TextLabel(texto: "Nome"),
                  TextField(
                    controller: nomeController,
                  ),
                  const TextLabel(texto: "Altura"),
                  TextField(
                    controller: alturaController,
                    keyboardType: TextInputType.number,
                  ),
                  const TextLabel(texto: "Peso"),
                  TextField(
                    controller: pesoController,
                    keyboardType: TextInputType.number,
                  ),
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        salvando = false;
                      });
                      if (dataController.text.trim().length < 3) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("A data deve ser preenchido")));
                        return;
                      }
                      if (nomeController.text.trim().length < 3) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("O nome deve ser preenchido")));
                        return;
                      }
                      if (pesoController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("O peso deve ser preenchido")));
                        return;
                      }
                      if (alturaController.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("A altura deve ser preenchido")));
                        return;
                      }

                      setState(() {
                        salvando = true;
                      });

                      await imcRepository.salvar(IMCModel(
                          0,
                          dataController.text,
                          nomeController.text,
                          pesoController.text,
                          alturaController.text));

                      Future.delayed(const Duration(seconds: 3), () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Dados salvo com sucesso")));
                        setState(() {
                          salvando = false;
                        });
                        nomeController.text = '';
                        pesoController.text = '';
                        alturaController.text = '';
                        carregarDados();
                        // ignore: use_build_context_synchronously
                        //Navigator.pop(context);
                        //setState(() {});
                      });
                    },
                    child: const Text("Salvar"),
                  ),
                ],
              ),
      ),
    );
  }
}
