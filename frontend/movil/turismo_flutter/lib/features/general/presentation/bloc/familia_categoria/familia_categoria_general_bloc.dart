import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:turismo_flutter/features/general/domain/usecases/familia_categoria/get_emprendimientos_por_familia_categoria_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/familia_categoria/listar_relaciones_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/familia_categoria/obtener_por_id_categoria_usecase_general.dart';
import 'package:turismo_flutter/features/general/domain/usecases/familia_categoria/obtener_por_id_familia_usecase_general.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/familia_categoria/familia_categoria_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/familia_categoria/familia_categoria_general_state.dart';

class FamiliaCategoriaGeneralBloc extends Bloc<FamiliaCategoriaGeneralEvent, FamiliaCategoriaGeneralState>{
  final ListarRelacionesUsecaseGeneral listarRelacionesUsecaseGeneral;
  final ObtenerPorIdCategoriaUsecaseGeneral obtenerPorIdCategoriaUsecaseGeneral;
  final ObtenerPorIdFamiliaUsecaseGeneral obtenerPorIdFamiliaUsecaseGeneral;
  final GetEmprendimientosPorFamiliaCategoriaUsecaseGeneral getEmprendimientosPorFamiliaCategoriaUsecaseGeneral;

  FamiliaCategoriaGeneralBloc({
    required this.listarRelacionesUsecaseGeneral,
    required this.obtenerPorIdCategoriaUsecaseGeneral,
    required this.obtenerPorIdFamiliaUsecaseGeneral,
    required this.getEmprendimientosPorFamiliaCategoriaUsecaseGeneral,
}): super(FamiliaCategoriaInitialGeneral()) {

    on<ListarRelacionesEventGeneral>((event, emit) async {
      emit(FamiliaCategoriaLoadingGeneral());
      try{
        final relaciones = await listarRelacionesUsecaseGeneral();
        emit(FamiliaCategoriaListLoadedGeneral(relaciones));
      }catch (e) {
        emit(FamiliaCategoriaErrorGeneral("Error al listar familia con categoria: $e"));
      }
    });

    on<ObtenerPorIdCategoriaEventGeneral> ((event, emit) async {
      emit(FamiliaCategoriaLoadingGeneral());
      try{
        await obtenerPorIdCategoriaUsecaseGeneral(event.idCategoria);
        emit(FamiliaCategoriaSuccessGeneral("Obtener por id categoria con exito"));
      }catch (e) {
        emit(FamiliaCategoriaErrorGeneral("Error al obtener por id categoria: $e"));
      }
    });

    on<ObtenerPorIdFamiliaEventGeneral>((event, emit) async {
      emit(FamiliaCategoriaLoadingGeneral());

      try {
        final categorias = await obtenerPorIdFamiliaUsecaseGeneral(event.idFamilia);

        print("Bloc - datos cargados para familia ${event.idFamilia}: ${categorias.map((e) => e.idCategoria).toList()}");
        print("Bloc - datos a emitir para familia ${event.idFamilia}: ${categorias.map((e) => e.idFamiliaCategoria).toList()}");

        // 🔴 Emite estado vacío antes de emitir el resultado real
        emit(FamiliaCategoriaListLoadedGeneral([]));
        emit(FamiliaCategoriaListLoadedGeneral(categorias));

      } catch (e) {
        emit(FamiliaCategoriaErrorGeneral("Error al obtener por id familia: $e"));
      }
    });

    on<GetEmprendimientosPorFamiliaCategoriaEvent>(
          (event, emit) async {
        emit(FamiliaCategoriaLoadingGeneral());
        try {
          final emprendimientos = await getEmprendimientosPorFamiliaCategoriaUsecaseGeneral(event.idFamiliaCategoria, event.nombre);
          emit(EmprendimientosPorFamiliaCategoriaLoadedGeneral(emprendimientos));
        } catch (e) {
          emit(FamiliaCategoriaErrorGeneral("Error al buscar emprendimientos: $e"));
        }
      },
      transformer: (events, mapper) =>
          events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );
  }
}