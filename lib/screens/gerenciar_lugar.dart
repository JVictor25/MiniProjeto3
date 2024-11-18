import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/lugar.dart';
import '../provider/paises_provider.dart';
import '../model/pais.dart';

class GerenciarLugaresScreen extends StatefulWidget {
  @override
  _GerenciarLugaresScreenState createState() => _GerenciarLugaresScreenState();
}

class _GerenciarLugaresScreenState extends State<GerenciarLugaresScreen> {
  @override
  Widget build(BuildContext context) {
    final lugaresProvider = Provider.of<PaisesProvider>(context);
    final lugares = lugaresProvider.lugares;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Lugares'),
      ),
      body: lugares.isEmpty
          ? Center(child: Text('Nenhum lugar cadastrado'))
          : ListView.builder(
              itemCount: lugares.length,
              itemBuilder: (ctx, index) {
                final lugar = lugares[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(Icons.event_note), // Ícone de evento padrão do Flutter
                    title: Text(lugar.titulo),
                    subtitle: Text(
                      'Avaliação: ${lugar.avaliacao} | Custo: ${lugar.custoMedio}'
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditDialog(context, lugar);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteConfirmationDialog(context, lugar.id);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _showEditDialog(BuildContext context, Lugar lugar) {
    final tituloController = TextEditingController(text: lugar.titulo);
    final imagemController = TextEditingController(text: lugar.imagemUrl);
    final avaliacaoController =
        TextEditingController(text: lugar.avaliacao.toString());
    final custoController =
        TextEditingController(text: lugar.custoMedio.toString());
    final recomendacoesController =
        TextEditingController(text: lugar.recomendacoes.join(', '));
    final paisesProvider = Provider.of<PaisesProvider>(context, listen: false);

    List<String> paisesSelecionados = List.from(lugar.paises);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Editar Lugar'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: tituloController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: imagemController,
                decoration: InputDecoration(labelText: 'URL da Imagem'),
              ),
              TextField(
                controller: avaliacaoController,
                decoration: InputDecoration(labelText: 'Avaliação'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: custoController,
                decoration: InputDecoration(labelText: 'Custo Médio'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: recomendacoesController,
                decoration: InputDecoration(labelText: 'Recomendações'),
              ),
              // Exibe a lista de países selecionados
              Wrap(
                children: paisesSelecionados
                    .map((paisId) {
                      // Procura o país correspondente ao ID na lista de países disponíveis
                      final paisEncontrado = paisesProvider.paises.firstWhere(
                        (pais) => pais.id == paisId,
                        orElse: () => Pais(id: '', titulo: ''), // Retorna um Pais vazio se não encontrar
                      );

                      // Verifica se o país foi encontrado antes de tentar acessar seu título
                      if (paisEncontrado.id.isNotEmpty) {
                        return Chip(
                          label: Text(paisEncontrado.titulo), // Exibe o título do país encontrado
                          onDeleted: () {
                            setState(() {
                              paisesSelecionados.remove(paisId); // Remove pelo ID do país
                            });
                          },
                        );
                      } else {
                        return SizedBox.shrink(); // Retorna um widget vazio se o país não for encontrado
                      }
                    })
                    .toList(),
              ),
              DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Adicionar País'),
              items: paisesProvider.paises
                  .where((pais) => !paisesSelecionados.contains(pais.id)) // Garantir que o país não esteja já selecionado
                  .map(
                    (pais) => DropdownMenuItem(
                      value: pais.id, // Adiciona o ID do país, não o título
                      child: Text(pais.titulo), // Exibe o título do país
                    ),
                  )
                  .toList(),
              onChanged: (novoPaisId) {
                setState(() {
                  if (novoPaisId != null && !paisesSelecionados.contains(novoPaisId)) {
                    paisesSelecionados.add(novoPaisId); // Adiciona o ID do país à lista
                  }
                });
              },
              hint: Text('Selecione um País'),
            ),
            ],
          ),
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
              if (paisesSelecionados.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selecione pelo menos um país.')),
                );
                return;
              }

              final updatedLugar = Lugar(
                id: lugar.id,
                titulo: tituloController.text,
                imagemUrl: imagemController.text,
                avaliacao: double.parse(avaliacaoController.text),
                custoMedio: double.parse(custoController.text),
                recomendacoes: recomendacoesController.text.split(','),
                paises: paisesSelecionados, // Lista de países atualizada
              );

              paisesProvider.editarLugar(updatedLugar);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String lugarId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirmar remoção'),
        content: Text('Tem certeza de que deseja remover este lugar?'),
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
              Provider.of<PaisesProvider>(context, listen: false)
                  .removerLugar(lugarId);
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Lugar removido com sucesso!')),
              );
            },
          ),
        ],
      ),
    );
  }
}
