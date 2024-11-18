// lib/favoritos_provider.dart
import 'package:flutter/material.dart';
import '../model/lugar.dart';

class FavoritosProvider extends ChangeNotifier {
  final List<Lugar> _lugaresFavoritos = [];

  List<Lugar> get lugaresFavoritos => _lugaresFavoritos;

  void toggleLugarFavorito(Lugar lugar) {
    if (_lugaresFavoritos.contains(lugar)) {
      _lugaresFavoritos.remove(lugar);
    } else {
      _lugaresFavoritos.add(lugar);
    }
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }
}
