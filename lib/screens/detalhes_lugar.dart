import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../provider/favoritos_provider.dart';
import '../model/lugar.dart';

class DetalhesLugarScreen extends StatelessWidget {
  const DetalhesLugarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lugar = ModalRoute.of(context)?.settings.arguments as Lugar;
    final favoritosProvider = Provider.of<FavoritosProvider>(context);
    final bool isFavorito = favoritosProvider.lugaresFavoritos.contains(lugar);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: Text(
          lugar.titulo,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
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
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Dicas',
              style: ThemeData().textTheme.displayLarge,
            ),
          ),
          Container(
            width: 350,
            height: 300,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)),
            child: ListView.builder(
              itemCount: lugar.recomendacoes.length,
              itemBuilder: (contexto, index) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => favoritosProvider.toggleLugarFavorito(lugar),
        child: Icon(isFavorito ? Icons.star : Icons.star_border),
      ),
    );
  }
}