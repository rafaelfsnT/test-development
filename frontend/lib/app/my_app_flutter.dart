import 'package:flutter/material.dart';
import 'package:teste_development/view/home_page.dart';

class MyAppFlutter extends StatelessWidget {
  const MyAppFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp é o widget raiz que configura o tema e a navegação do app
    return MaterialApp(
      title: 'Teste API Pesquisa',
      home: HomePage(),
      debugShowCheckedModeBanner: false, // Remove a faixa de debug
    );
  }
}
