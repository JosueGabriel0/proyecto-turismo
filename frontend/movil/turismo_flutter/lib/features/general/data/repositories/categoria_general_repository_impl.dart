import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/categoria_api_client.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/categoria_repository.dart';
import 'package:turismo_flutter/features/general/data/datasources/remote/categoria_general_api_client.dart';
import 'package:turismo_flutter/features/general/data/models/categoria_general_response.dart';
import 'package:turismo_flutter/features/general/domain/repositories/categoria_general_repository.dart';

class CategoriaGeneralRepositoryImpl implements CategoriaGeneralRepository {
  final CategoriaGeneralApiClient categoriaApiClient;

  CategoriaGeneralRepositoryImpl(this.categoriaApiClient);

  @override
  Future<CategoriaGeneralResponse> getCategoriaByIdGeneral(int idCategoria) async {
    return await categoriaApiClient.getCategoriaById(idCategoria);
  }

  @override
  Future<List<CategoriaGeneralResponse>> getCategoriasGeneral() async {
    return await categoriaApiClient.getCategorias();
  }

  @override
  Future<List<CategoriaGeneralResponse>> buscarCategoriasPorNombreGeneral(String nombre) {
    return categoriaApiClient.buscarCategoriasPorNombre(nombre);
  }
}