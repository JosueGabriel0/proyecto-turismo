// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emprendimiento_api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations

class _EmprendimientoApiClient implements EmprendimientoApiClient {
  _EmprendimientoApiClient(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<List<EmprendimientoResponse>> getEmprendimientos() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<EmprendimientoResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/admin/emprendimiento',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<List<dynamic>>(_options);
    late List<EmprendimientoResponse> _value;
    try {
      _value =
          _result.data!
              .map(
                (dynamic i) =>
                    EmprendimientoResponse.fromJson(i as Map<String, dynamic>),
              )
              .toList();
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<EmprendimientoResponse> getEmprendimientoById(
    int idEmprendimiento,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<EmprendimientoResponse>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/admin/emprendimiento/${idEmprendimiento}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late EmprendimientoResponse _value;
    try {
      _value = EmprendimientoResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<EmprendimientoResponse> postEmprendimiento(
    String emprendimientoJson,
    MultipartFile? file,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('emprendimiento', emprendimientoJson));
    if(file != null){
      _data.files.add(MapEntry('file', file));
    }
    final _options = _setStreamType<EmprendimientoResponse>(
      Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'multipart/form-data',
          )
          .compose(
            _dio.options,
            '/admin/emprendimiento',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late EmprendimientoResponse _value;
    try {
      _value = EmprendimientoResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<EmprendimientoResponse> putEmprendimiento(
    int idEmprendimiento,
    String emprendimientoJson,
    MultipartFile? file,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry('emprendimiento', emprendimientoJson));
    if(file != null){
      _data.files.add(MapEntry('file', file));
    }
    final _options = _setStreamType<EmprendimientoResponse>(
      Options(
            method: 'PUT',
            headers: _headers,
            extra: _extra,
            contentType: 'multipart/form-data',
          )
          .compose(
            _dio.options,
            '/admin/emprendimiento/${idEmprendimiento}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late EmprendimientoResponse _value;
    try {
      _value = EmprendimientoResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  @override
  Future<void> deleteEmprendimiento(int idEmprendimiento) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<void>(
      Options(method: 'DELETE', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/admin/emprendimiento/${idEmprendimiento}',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    await _dio.fetch<void>(_options);
  }

  @override
  Future<List<EmprendimientoResponse>> buscarEmprendimientosPorNombre(
    String nombre,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'nombre': nombre};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<EmprendimientoResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/admin/emprendimiento/buscar',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<List<dynamic>>(_options);
    late List<EmprendimientoResponse> _value;
    try {
      _value =
          _result.data!
              .map(
                (dynamic i) =>
                    EmprendimientoResponse.fromJson(i as Map<String, dynamic>),
              )
              .toList();
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}