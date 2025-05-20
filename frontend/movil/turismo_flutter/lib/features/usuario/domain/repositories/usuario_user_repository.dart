import 'dart:io';

import 'package:turismo_flutter/features/usuario/data/models/usuario_user_dto.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';

abstract class UsuarioUserRepository {
  Future<UsuarioUserResponse> getUsuarioCompletoById(int id);
  Future<UsuarioUserResponse> putUsuarioCompleto(int id, UsuarioUserDto usuario, File? imagen);
}
