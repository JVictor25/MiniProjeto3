import 'package:flutter/material.dart';
import '../model/lugar.dart';

class LugaresProvider with ChangeNotifier {
  final List<Lugar> _lugares = []; // Lista vazia, que será preenchida dinamicamente

  List<Lugar> get lugares => List.unmodifiable(_lugares);

  void adicionarLugar(Lugar lugar) {
    _lugares.add(lugar);
    notifyListeners(); // Notifica os ouvintes de que os dados foram atualizados
  }
}
