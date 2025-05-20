import 'dart:convert';
import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:turismo_flutter/features/admin/data/datasources/remote/crud/categoria_api_client.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/categoria_response.dart';
import 'package:turismo_flutter/features/admin/domain/repositories/categoria_repository.dart';

class CategoriaRepositoryImpl implements CategoriaRepository {
  final CategoriaApiClient categoriaApiClient;

  CategoriaRepositoryImpl(this.categoriaApiClient);

  @override
  Future<void> deleteCategoria(int idCategoria) async {
    return await categoriaApiClient.deleteCategoria(idCategoria);
  }

  @override
  Future<CategoriaResponse> getCategoriaById(int idCategoria) async {
    return await categoriaApiClient.getCategoriaById(idCategoria);
  }

  @override
  Future<List<CategoriaResponse>> getCategorias() async {
    return await categoriaApiClient.getCategorias();
  }

  @override
  Future<CategoriaResponse> postCategoria(CategoriaDto categoriaDto, File? file) async {
    final categoriaJson = jsonEncode(categoriaDto);
    MultipartFile? multipartFile;
    if(file != null){
      multipartFile = await MultipartFile.fromFile(
          file.path,
          filename: file.uri.pathSegments.last,
          contentType: MediaType("image", "jpeg")
      );
    }
    return await categoriaApiClient.postCategoria(categoriaJson, multipartFile);
  }

  @override
  Future<CategoriaResponse> putCategoria(int idCategoria, CategoriaDto categoriaDto, File? file) async {
    final categoriaJson = jsonEncode(categoriaDto);
    MultipartFile? multipartFile;
    if(file != null){
      multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg")
      );
    }
    return categoriaApiClient.putCategoria(idCategoria, categoriaJson, multipartFile);
  }

  @override
  Future<List<CategoriaResponse>> buscarCategoriasPorNombre(String nombre) {
    return categoriaApiClient.buscarCategoriasPorNombre(nombre);
  }
}