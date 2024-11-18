import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../model/lugar.dart';

class ItemLugar extends StatelessWidget {
  const ItemLugar({super.key, required this.lugar});

  final Lugar lugar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/detalheLugar',
          arguments: lugar,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: lugar.imagemUrl,
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.star),
                      SizedBox(width: 6),
                      Text('${lugar.avaliacao}/5')
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.attach_money),
                      SizedBox(width: 6),
                      Text('custo: R\$${lugar.custoMedio}')
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
