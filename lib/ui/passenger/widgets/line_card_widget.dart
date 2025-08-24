// lib/ui/passenger/widgets/line_card_widget.dart
import 'package:flutter/material.dart';

class LineCardWidget extends StatelessWidget {
  const LineCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Número temporal de líneas
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text('Línea ${index + 1}'),
            subtitle: Text('Ruta ${index + 1} - Frecuencia: 15 min'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // TODO: Navegar a detalles de la línea
            },
          ),
        );
      },
    );
  }
}

