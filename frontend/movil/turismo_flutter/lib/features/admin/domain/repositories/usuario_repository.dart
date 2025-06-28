import 'dart:io';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_id_mensaje_dto_response.dart';

abstract class UsuarioRepository {
  Future<List<UsuarioCompletoResponse>> getUsuariosCompleto();
  Future<UsuarioCompletoResponse> getUsuarioCompletoById(int id);
  Future<UsuarioCompletoResponse> postUsuarioCompleto(UsuarioCompletoDto usuario, File? imagen);
  Future<UsuarioCompletoResponse> putUsuarioCompleto(int id, UsuarioCompletoDto usuario, File? imagen);
  Future<void> deleteUsuarioCompleto(int id);
  Future<List<UsuarioCompletoResponse>> buscarUsuariosCompletosPorNombre(String username);
  Future<UsuarioIdMensajeDtoResponse> buscarIdPorUsername(String userName);
}
