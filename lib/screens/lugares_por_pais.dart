import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pais.dart';
import '../components/item_lugar.dart';
import '../provider/paises_provider.dart'; // Importando o provider

class LugarPorPaisScreen extends StatelessWidget {
  LugarPorPaisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recupera o país passado como argumento
    final pais = ModalRoute.of(context)?.settings.arguments as Pais;

    // Obtém a lista de lugares do provider para o país específico
    final lugaresPorPais = Provider.of<PaisesProvider>(context)
        .obterLugaresPorPais(pais.id);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: pais.cor,
        title: Text(
          "Lugares em ${pais.titulo}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: lugaresPorPais.length,
        itemBuilder: (ctx, index) {
          return ItemLugar(lugar: lugaresPorPais[index]);
        },
      ),
    );
  }
}
