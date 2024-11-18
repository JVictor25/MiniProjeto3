// lib/screens/abas.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/drawer.dart';
import '../screens/favoritos.dart';
import '../screens/pais_screen.dart';
import '../provider/favoritos_provider.dart';

class MinhasAbas extends StatefulWidget {
  @override
  State<MinhasAbas> createState() => _MinhasAbasState();
}

class _MinhasAbasState extends State<MinhasAbas> {
  @override
  Widget build(BuildContext context) {
    return MinhasAbasBottom(); // Remova o 'const'
  }
}

class MinhasAbasBottom extends StatefulWidget {
  @override
  State<MinhasAbasBottom> createState() => _MinhasAbasBottomState();
}

class _MinhasAbasBottomState extends State<MinhasAbasBottom> {
  String _nomeTab = "Países";
  final List<String> _nomeTabs = ["Países", "Favoritos"];

  void _getNomeTab(int index) {
    setState(() {
      _nomeTab = _nomeTabs[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoritosProvider = Provider.of<FavoritosProvider>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _nomeTab,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: ThemeData().primaryColor,
        ),
        drawer: const MeuDrawer(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: TabBarView(
                children: [
                  const PaisScreen(),
                  FavoritosScreen(
                    lugaresFavoritos: favoritosProvider.lugaresFavoritos,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              decoration: BoxDecoration(
                color: ThemeData().primaryColor,
              ),
              child: TabBar(
                onTap: _getNomeTab,
                indicatorColor: Colors.amber,
                labelColor: Colors.amber,
                unselectedLabelColor: Colors.white60,
                tabs: const [
                  Tab(
                    icon: Icon(Icons.category),
                    text: "Países",
                  ),
                  Tab(
                    icon: Icon(Icons.star),
                    text: "Favoritos",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
