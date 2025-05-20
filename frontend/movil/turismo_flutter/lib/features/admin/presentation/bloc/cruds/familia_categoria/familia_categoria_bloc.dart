import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia_categoria/asociar_familia_categoria_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia_categoria/eliminar_relacion_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia_categoria/listar_relaciones_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia_categoria/obtener_por_id_categoria_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia_categoria/obtener_por_id_familia_usecase.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia_categoria/familia_categoria_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia_categoria/familia_categoria_state.dart';

class FamiliaCategoriaBloc extends Bloc<FamiliaCategoriaEvent, FamiliaCategoriaState>{
  final AsociarFamiliaCategoriaUseCase asociarFamiliaCategoriaUseCase;
  final EliminarRelacionUsecase eliminarRelacionUsecase;
  final ListarRelacionesUsecase listarRelacionesUsecase;
  final ObtenerPorIdCategoriaUsecase obtenerPorIdCategoriaUsecase;
  final ObtenerPorIdFamiliaUsecase obtenerPorIdFamiliaUsecase;

  FamiliaCategoriaBloc({
    required this.asociarFamiliaCategoriaUseCase,
    required this.eliminarRelacionUsecase,
    required this.listarRelacionesUsecase,
    required this.obtenerPorIdCategoriaUsecase,
    required this.obtenerPorIdFamiliaUsecase,
}): super(FamiliaCategoriaInitial()) {
    on<AsociarFamiliaCategoriaEvent> ((event, emit) async {
      emit(FamiliaCategoriaLoading());
      try{
        await asociarFamiliaCategoriaUseCase(event.dto);
        emit(FamiliaCategoriaSuccess("Familia categoria asociada con exito"));
        final relaciones = await listarRelacionesUsecase();
        emit(FamiliaCategoriaListLoaded(relaciones));
      }catch (e) {
        emit(FamiliaCategoriaError("Error al asociar familia con categoria: $e"));
      }
    });

    on<EliminarRelacionEvent> ((event, emit) async {
      emit(FamiliaCategoriaLoading());
      try {
        await eliminarRelacionUsecase(event.idFamiliaCategoria);
        emit(FamiliaCategoriaSuccess("Relacion eliminada correctamente"));
        final relaciones = await listarRelacionesUsecase();
        emit(FamiliaCategoriaListLoaded(relaciones));
      }catch (e) {
        emit(FamiliaCategoriaError("Error al eliminar familia con categoria: $e"));
      }
    });

    on<ListarRelacionesEvent>((event, emit) async {
      emit(FamiliaCategoriaLoading());
      try{
        final relaciones = await listarRelacionesUsecase();
        emit(FamiliaCategoriaListLoaded(relaciones));
      }catch (e) {
        emit(FamiliaCategoriaError("Error al listar familia con categoria: $e"));
      }
    });

    on<ObtenerPorIdCategoriaEvent> ((event, emit) async {
      emit(FamiliaCategoriaLoading());
      try{
        await obtenerPorIdCategoriaUsecase(event.idCategoria);
        emit(FamiliaCategoriaSuccess("Obtener por id categoria con exito"));
      }catch (e) {
        emit(FamiliaCategoriaError("Error al obtener por id categoria: $e"));
      }
    });

    on<ObtenerPorIdFamiliaEvent> ((event, emit) async {
      emit(FamiliaCategoriaLoading());
      try{
        await obtenerPorIdFamiliaUsecase(event.idFamilia);
        emit(FamiliaCategoriaSuccess("Obtener por id familia con exito"));
      }catch (e) {
        emit(FamiliaCategoriaError("Error al obtener por id familia: $e"));
      }
    });
  }
}