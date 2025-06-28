import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatUsuario {
  final String username;
  final String nombreCompleto;
  final String ultimoMensaje;
  final DateTime hora;
  final String avatarUrl;

  ChatUsuario({
    required this.username,
    required this.nombreCompleto,
    required this.ultimoMensaje,
    required this.hora,
    required this.avatarUrl,
  });
}

class ChatUsuarioScreen extends StatefulWidget {
  const ChatUsuarioScreen({super.key});

  @override
  State<ChatUsuarioScreen> createState() => _ChatUsuarioScreenState();
}

class _ChatUsuarioScreenState extends State<ChatUsuarioScreen> {
  List<ChatUsuario> chats = [
    ChatUsuario(
      username: 'maria21',
      nombreCompleto: 'María Gómez',
      ultimoMensaje: '¿Cómo estás?',
      hora: DateTime.now().subtract(Duration(minutes: 5)),
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
    ),
    ChatUsuario(
      username: 'juanito',
      nombreCompleto: 'Juan Pérez',
      ultimoMensaje: 'Nos vemos mañana.',
      hora: DateTime.now().subtract(Duration(hours: 1)),
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
    ),
    ChatUsuario(
      username: 'carla_dev',
      nombreCompleto: 'Carla Fernández',
      ultimoMensaje: '¡Gracias por el archivo!',
      hora: DateTime.now().subtract(Duration(days: 1)),
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
    ),
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    final chatsFiltrados = chats.where((chat) {
      return chat.nombreCompleto.toLowerCase().contains(query.toLowerCase()) ||
          chat.username.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              onChanged: (text) => setState(() => query = text),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Buscar chats...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatsFiltrados.length,
              itemBuilder: (context, index) {
                final chat = chatsFiltrados[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(chat.avatarUrl),
                  ),
                  title: Text(chat.nombreCompleto),
                  subtitle: Text(
                    chat.ultimoMensaje,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                      DateFormat('hh:mm a').format(chat.hora),
                      style: TextStyle(fontSize: 12),
                  ),
                  onTap: () {
                    // Aquí iría la navegación al chat con ese usuario
                    print('Ir al chat con ${chat.username}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
