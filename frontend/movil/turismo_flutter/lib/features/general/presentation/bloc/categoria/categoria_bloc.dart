import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/categoria/buscar_categorias_por_nombre_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/categoria/delete_categoria_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/categoria/get_categoria_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/categoria/get_categorias_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/categoria/post_categoria_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/categoria/put_categoria_usecase.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_state.dart';
import 'package:turismo_flutter/features/general/domain/usecases/categoria/buscar_categorias_por_nombre_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/categoria/get_categoria_by_id_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/categoria/get_categorias_usecase_general.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/categoria/categoria_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/categoria/categoria_state.dart';

class CategoriaGeneralBloc extends Bloc<CategoriaGeneralEvent, CategoriaGeneralState>{
  final GetCategoriaByIdUsecaseGeneral getCategoriaByIdUsecaseGeneral;
  final GetCategoriasUsecaseGeneral getCategoriasUsecaseGeneral;
  final BuscarCategoriasPorNombreUsecaseGeneral buscarCategoriasPorNombreUsecaseGeneral;

  CategoriaGeneralBloc({
    required this.getCategoriaByIdUsecaseGeneral,
    required this.getCategoriasUsecaseGeneral,
    required this.buscarCategoriasPorNombreUsecaseGeneral,
}): super(CategoriaInitialGeneral()) {
    on<GetCategoriaByIdGeneralEvent>((event, emit) async {
      emit(CategoriaLoadingGeneral());
      try{
        final categoria = await getCategoriaByIdUsecaseGeneral(event.idCategoria);
        emit(CategoriaLoadedGeneral(categoria));
      }catch (e){
        emit(CategoriaErrorGeneral("Error al encontrar categoria: $e"));
      }
    });

    on<GetCategoriasGeneralEvent>((event, emit) async {
      emit(CategoriaLoadingGeneral());
      try{
        final categorias = await getCategoriasUsecaseGeneral();
        emit(CategoriaListLoadedGeneral(categorias));
      } catch (e){
        emit(CategoriaErrorGeneral("Error al encontrar categorias: $e"));
      }
    });

    on<BuscarCategoriasPorNombreGeneralEvent>(
          (event, emit) async {
        try {
          final resultados = await buscarCategoriasPorNombreUsecaseGeneral(event.nombre);
          emit(CategoriaListLoadedGeneral(resultados));
        } catch (e) {
          emit(CategoriaErrorGeneral("Error al buscar categoria: $e"));
        }
      },
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );
  }
}