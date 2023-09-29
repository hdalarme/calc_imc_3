import 'package:flutter/material.dart';

import 'package:calc_imc_2/pages/configuracoes_page.dart';
import 'package:calc_imc_2/pages/imc_page.dart';
import 'package:calc_imc_2/pages/imc_result_page.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  posicaoPagina = value;
                });
              },
              children: const [
                IMCPage(),
                IMCResultPage(),
                ConfiguracoesPage(),
              ],
            ),
          ),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              controller.jumpToPage(value);
            },
            currentIndex: posicaoPagina,
            items: const [
              BottomNavigationBarItem(label: "Form IMC", icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: "Resultado IMC", icon: Icon(Icons.list)),
              BottomNavigationBarItem(label: "Config", icon: Icon(Icons.info)),
            ]
          )
        ],
      ),
    ));
  }
}
