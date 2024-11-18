// lib/screens/favoritos.dart
import 'package:flutter/material.dart';
import '../model/lugar.dart';
import '../components/item_lugar.dart';

class FavoritosScreen extends StatelessWidget {
  final List<Lugar> lugaresFavoritos;

  const FavoritosScreen({Key? key, required this.lugaresFavoritos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (lugaresFavoritos.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum Lugar Marcado como Favorito!',
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: lugaresFavoritos.length,
        itemBuilder: (ctx, index) {
          return ItemLugar(lugar: lugaresFavoritos[index]);
        },
      );
    }
  }
}
