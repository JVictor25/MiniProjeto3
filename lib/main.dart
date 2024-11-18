import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/favoritos_provider.dart';
import 'provider/lugares_provider.dart';
import 'provider/paises_provider.dart';
import 'screens/abas.dart';
import 'screens/cadastrar_lugar.dart';
import 'screens/configuracoes.dart';
import 'screens/detalhes_lugar.dart';
import 'screens/lugares_por_pais.dart';
import 'screens/gerenciar_lugar.dart';
import 'screens/gerenciar_paises.dart';


void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritosProvider()),
        ChangeNotifierProvider(create: (_) => LugaresProvider()),
        ChangeNotifierProvider(create: (_) => PaisesProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (ctx) => MinhasAbas(), 
          '/lugaresPorPais': (ctx) => LugarPorPaisScreen(),
          '/detalheLugar': (ctx) => DetalhesLugarScreen(),
          '/configuracoes': (ctx) => ConfigracoesScreen(),
          '/cadastrar-lugar': (ctx) => CadastroScreen(),
          '/gerenciar-lugares': (cxt) => GerenciarLugaresScreen(),
          '/gerenciar-paises': (ctx) => GerenciarPaisesScreen(),
        },
      ),
    );
  }
}