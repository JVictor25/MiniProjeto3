import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../provider/paises_provider.dart';
import '../model/lugar.dart';
import '../model/pais.dart';

class DetalhesLugarScreen extends StatelessWidget {
  const DetalhesLugarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lugar = ModalRoute.of(context)?.settings.arguments as Lugar;
    final paisesProvider = Provider.of<PaisesProvider>(context);
    final List<String> paisesDoLugar = lugar.paises;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          lugar.titulo,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          // Imagem do lugar
          Container(
            height: 300,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: lugar.imagemUrl,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
          ),

          // Título "Países"
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Países Associados',
              style: Theme.of(context).textTheme.titleLarge, // Substituição aqui
            ),
          ),

          // Lista de países
          Container(
            width: 350,
            height: 150,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              itemCount: paisesDoLugar.length,
              itemBuilder: (context, index) {
                final pais = paisesDoLugar[index];
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      title: Text(pais),
                      onTap: () {
                        // Exibe detalhes do país ou realiza alguma ação
                        print('País selecionado: $pais');
                      },
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ),

          // Título "Dicas"
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Dicas',
              style: Theme.of(context).textTheme.titleLarge, // Substituição aqui
            ),
          ),

          // Lista de recomendações
          Container(
            width: 350,
            height: 150,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              itemCount: lugar.recomendacoes.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(lugar.recomendacoes[index]),
                      subtitle: Text(lugar.titulo),
                      onTap: () {
                        print(lugar.recomendacoes[index]);
                      },
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          )
        ],
      ),
      // Ação no botão flutuante (exemplo: adicionar/remover países relacionados)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Exemplo de funcionalidade: adicionar ou editar países associados ao lugar
          paisesProvider.adicionarPais(
            Pais(
              id: DateTime.now().toString(),
              titulo: "Novo País", // Adicione o título desejado
            ),
          );
        },
        child: const Icon(Icons.add_location),
      ),
    );
  }
}
