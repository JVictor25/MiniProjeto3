import 'package:flutter/material.dart';

class MeuDrawer extends StatelessWidget {
  const MeuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ThemeData().primaryColor,
            ),
            child: Text(
              'Configurações',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: const Text('Países'),
            onTap: () {
              //context.pushReplacement('/');
              Navigator.of(context).pushReplacementNamed(
                '/',
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.engineering),
            title: const Text('Configurações'),
            onTap: () {
              //context.pushReplacement('/configuracoes');
              Navigator.of(context).pushReplacementNamed(
                '/configuracoes',
              );
            },
          ),
           ListTile(
            leading: Icon(Icons.person_add),
            title: const Text('Cadastrar'),
            onTap: () {
              Navigator.of(context).pushNamed('/cadastrar-lugar');
            },
          ),
          ListTile(
            leading: Icon(Icons.list_alt), // Ícone apropriado para gerenciamento
            title: const Text('Gerenciar Lugares'),
            onTap: () {
              Navigator.of(context).pushNamed('/gerenciar-lugares'); // Rota para a tela de gerenciamento de lugares
            },
          ),
          ListTile(
          leading: Icon(Icons.flag),
          title: Text('Gerenciar Países'),
          onTap: () {
            Navigator.of(context).pushNamed('/gerenciar-paises');
          },
        ),
        ],
      ),
    );
  }
}
