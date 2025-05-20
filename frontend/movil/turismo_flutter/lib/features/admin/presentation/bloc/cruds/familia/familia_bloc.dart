import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/buscar_familias_por_nombre_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/delete_familia_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/get_familia_by_id_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/get_familias_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/post_familia_usecase.dart';
import 'package:turismo_flutter/features/admin/domain/usecases/familia/put_familia_usecase.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/familia/familia_state.dart';

class FamiliaBloc extends Bloc<FamiliaEvent, FamiliaState>{
  final GetFamiliasUsecase getFamiliasUsecase;
  final GetFamiliaByIdUsecase getFamiliaByIdUsecase;
  final PostFamiliaUsecase postFamiliaUsecase;
  final PutFamiliaUseCase putFamiliaUseCase;
  final DeleteFamiliaUsecase deleteFamiliaUsecase;
  final BuscarFamiliasPorNombreUsecase buscarFamiliasPorNombreUsecase;

  FamiliaBloc({
    required this.getFamiliasUsecase,
    required this.getFamiliaByIdUsecase,
    required this.postFamiliaUsecase,
    required this.putFamiliaUseCase,
    required this.deleteFamiliaUsecase,
    required this.buscarFamiliasPorNombreUsecase,
}): super(FamiliaInitial()){
    on<GetFamiliasEvent>((event, emit) async {
      emit(FamiliaLoading());
      try{
        final familiaListResponse = await getFamiliasUsecase();
        emit(FamiliaListLoaded(familiaListResponse));
      } catch (e) {
        emit(FamiliaError("Error al obtener familias: $e"));
      }
    });

    on<GetFamiliaByIdEvent>((event, emit) async {
      emit(FamiliaLoading());
      try{
        final familiaResponse = await getFamiliaByIdUsecase(event.idFamilia);
        emit(FamiliaLoaded(familiaResponse));
      }catch (e) {
        emit(FamiliaError("Error al obtener familia: $e"));
      }
    });

    on<PostFamiliaEvent>((event, emit) async {
      emit(FamiliaLoading());
      try{
        await postFamiliaUsecase(event.familiaDto, event.file);
        emit(FamiliaSuccess("Familia creada con exito"));
        final familiaListResponse = await getFamiliasUsecase();
        emit(FamiliaListLoaded(familiaListResponse));
      }catch (e) {
        emit(FamiliaError("Error al crear familia: $e"));
      }
    });

    on<PutFamiliaEvent>((event, emit) async {
      emit(FamiliaLoading());
      try{
        await putFamiliaUseCase(event.idFamilia, event.familiaDto, event.file);
        emit(FamiliaSuccess("Familia actualizada con exito"));
        final familiaListResponse = await getFamiliasUsecase();
        emit(FamiliaListLoaded(familiaListResponse));
      }catch (e) {
        emit(FamiliaError("Error al actualizar familia: $e"));
      }
    });

    on<DeleteFamiliaEvent>((event, emit) async {
      emit(FamiliaLoading());
      try{
        await deleteFamiliaUsecase(event.idFamilia);
        emit(const FamiliaSuccess("Familia eliminada con éxito"));
        final familiaListResponse = await getFamiliasUsecase();
        emit(FamiliaListLoaded(familiaListResponse));
      }catch (e) {
        emit(FamiliaError("Error al eliminar familia: $e"));
      }
    });

    on<BuscarFamiliasPorNombreEvent>(
          (event, emit) async {
        try {
          final resultados = await buscarFamiliasPorNombreUsecase(event.nombre);
          emit(FamiliaListLoaded(resultados));
        } catch (e) {
          emit(FamiliaError("Error al buscar familia: $e"));
        }
      },
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );
  }
}