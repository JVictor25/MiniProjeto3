import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/item_pais.dart';
import '../provider/paises_provider.dart'; // Importando o provider

class PaisScreen extends StatelessWidget {
  const PaisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Acessando o PaisesProvider para obter os países
    final paises = Provider.of<PaisesProvider>(context).paises;

    return Scaffold(
      appBar: AppBar(
        title: Text('Países'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisExtent: 120,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: paises.length,
        itemBuilder: (ctx, index) {
          return ItemPais(pais: paises[index]);
        },
      ),
    );
  }
}
