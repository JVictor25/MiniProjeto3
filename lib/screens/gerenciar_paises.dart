import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/pais.dart';
import '../provider/paises_provider.dart';

class GerenciarPaisesScreen extends StatefulWidget {
  @override
  _GerenciarPaisesScreenState createState() => _GerenciarPaisesScreenState();
}

class _GerenciarPaisesScreenState extends State<GerenciarPaisesScreen> {
  final List<Color> _coresDisponiveis = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    final paisesProvider = Provider.of<PaisesProvider>(context);
    final paises = paisesProvider.paises;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Países'),
      ),
      body: paises.isEmpty
          ? Center(child: Text('Nenhum país cadastrado')) // Mensagem caso não haja países
          : ListView.builder(
              itemCount: paises.length,
              itemBuilder: (ctx, index) {
                final pais = paises[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(Icons.flag, color: pais.cor), // Usa a cor selecionada
                    title: Text(pais.titulo),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditDialog(context, pais); // Chamando o modal para edição
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteConfirmationDialog(context, pais.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddDialog(context); // Chamando o modal para adicionar um novo país
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final tituloController = TextEditingController();
    Color corSelecionada = _coresDisponiveis[0];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Adicionar País'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: tituloController,
              decoration: InputDecoration(labelText: 'Nome do País'),
            ),
            SizedBox(height: 10),
            DropdownButton<Color>(
              value: corSelecionada,
              items: _coresDisponiveis
                  .map((cor) => DropdownMenuItem(
                        value: cor,
                        child: Container(
                          width: 20,
                          height: 20,
                          color: cor,
                        ),
                      ))
                  .toList(),
              onChanged: (novaCor) {
                setState(() {
                  corSelecionada = novaCor!;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text('Salvar'),
            onPressed: () {
              final novoPais = Pais(
                id: DateTime.now().toString(),
                titulo: tituloController.text,
                cor: corSelecionada,
              );

              Provider.of<PaisesProvider>(context, listen: false).adicionarPais(novoPais);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, Pais pais) {
    final tituloController = TextEditingController(text: pais.titulo);
    Color corSelecionada = pais.cor;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Editar País'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: tituloController,
              decoration: InputDecoration(labelText: 'Nome do País'),
            ),
            SizedBox(height: 10),
            DropdownButton<Color>(
              value: corSelecionada,
              items: _coresDisponiveis
                  .map((cor) => DropdownMenuItem(
                        value: cor,
                        child: Container(
                          width: 20,
                          height: 20,
                          color: cor,
                        ),
                      ))
                  .toList(),
              onChanged: (novaCor) {
                setState(() {
                  corSelecionada = novaCor!;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text('Salvar'),
            onPressed: () {
              final updatedPais = Pais(
                id: pais.id,
                titulo: tituloController.text,
                cor: corSelecionada,
              );

              Provider.of<PaisesProvider>(context, listen: false).editarPais(updatedPais);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String paisId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmar remoção'),
        content: Text('Tem certeza de que deseja remover este país?'),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text('Remover'),
            onPressed: () {
              Provider.of<PaisesProvider>(context, listen: false).removerPais(paisId);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('País removido com sucesso!')),
              );
            },
          ),
        ],
      ),
    );
  }
}
