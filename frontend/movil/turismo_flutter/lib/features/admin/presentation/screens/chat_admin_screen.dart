import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:turismo_flutter/config/theme/local_theme_provider.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/mensaje/mensaje_admin_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/mensaje/mensaje_admin_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/mensaje/mensaje_admin_state.dart';
import 'package:turismo_flutter/features/admin/data/models/chat_resumen_dto.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_state.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';

class ChatAdminScreen extends StatefulWidget {
  const ChatAdminScreen({super.key});

  @override
  State<ChatAdminScreen> createState() => _ChatAdminScreenState();
}

class _ChatAdminScreenState extends State<ChatAdminScreen> {
  String query = '';

  @override
  void initState() {
    super.initState();
    // Llama al evento para obtener los chats recientes
    context.read<MensajeAdminBloc>().add(ObtenerChatsRecientesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<LocalThemeProvider>().isDarkMode;
    final theme = isDarkMode ? ThemeData.dark() : ThemeData.light();

    return Theme(
        data: theme,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Chat"),
            actions: [
              IconButton(
                icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
                onPressed: () => context.read<LocalThemeProvider>().toggle(),
              ),
            ],
          ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              onChanged: (text) => setState(() => query = text),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Buscar chats...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MensajeAdminBloc, MensajeAdminState>(
              builder: (context, state) {
                if (state is MensajeAdminLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatsRecientesCargados) {
                  final chats = state.chats.where((chat) {
                    final nombre = chat.nombreCompleto?.toLowerCase() ?? '';
                    final usuario = chat.username?.toLowerCase() ?? '';
                    return nombre.contains(query.toLowerCase()) ||
                        usuario.contains(query.toLowerCase());
                  }).toList();

                  if (chats.isEmpty) {
                    return const Center(child: Text('No hay chats recientes'));
                  }

                  return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      return ListTile(
                        leading: FotoWidget(
                          fileName: chat.avatarUrl ?? '',
                          size: 50,
                        ),
                        title: Text(chat.nombreCompleto ?? ''),
                        subtitle: Text(
                          chat.ultimoMensaje ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text(
                          chat.hora != null
                              ? DateFormat('hh:mm a').format(chat.hora!)
                              : '',
                          style: const TextStyle(fontSize: 12),
                        ),
                        onTap: () async {
                          final username = chat.username;
                          if (username != null) {
                            final usuarioBloc = context.read<UsuarioBloc>();

                            usuarioBloc.add(BuscarIdPorUsernameEvent(username));

                            final localContext = context; // Copia segura del context
                            late final StreamSubscription subscription;

                            subscription = usuarioBloc.stream.listen((state) {
                              if (!mounted) return; // Asegura que el widget no esté desmontado

                              if (state is BuscarIdSuccess) {
                                final idUsuario = state.usuario.usuarioId;
                                localContext.go(
                                  '/admin/chatPersonal/$idUsuario/$username',
                                  extra: {'chat': chat},
                                );
                                subscription.cancel(); // Evita fugas de memoria
                              } else if (state is BuscarIdError) {
                                ScaffoldMessenger.of(localContext).showSnackBar(
                                  SnackBar(content: Text(state.mensaje)),
                                );
                                subscription.cancel();
                              }
                            });
                          }
                        },
                      );
                    },
                  );
                } else if (state is MensajeAdminError) {
                  return Center(child: Text(state.mensaje));
                }

                return const Center(child: Text('Cargando chats...'));
              },
            ),
          ),
        ],
      ),
    )
    );
  }
}