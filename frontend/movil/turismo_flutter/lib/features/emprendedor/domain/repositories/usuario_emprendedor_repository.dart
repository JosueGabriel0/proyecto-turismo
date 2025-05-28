import 'dart:io';

import 'package:turismo_flutter/features/emprendedor/data/models/usuario_emprendedor_dto.dart';
import 'package:turismo_flutter/features/emprendedor/data/models/usuario_emprendedor_response.dart';

abstract class UsuarioEmprendedorRepository {
  Future<UsuarioEmprendedorResponse> getUsuarioCompletoById(int id);
  Future<UsuarioEmprendedorResponse> putUsuarioCompleto(int id, UsuarioEmprendedorDto usuario, File? imagen);
}
