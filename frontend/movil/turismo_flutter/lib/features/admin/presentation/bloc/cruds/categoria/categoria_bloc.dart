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

class CategoriaBloc extends Bloc<CategoriaEvent, CategoriaState>{
  final DeleteCategoriaUseCase deleteCategoriaUseCase;
  final GetCategoriaByIdUsecase getCategoriaByIdUsecase;
  final GetCategoriasUsecase getCategoriasUsecase;
  final PostCategoriaUsecase postCategoriaUsecase;
  final PutCategoriaUsecase putCategoriaUsecase;
  final BuscarCategoriasPorNombreUsecase buscarCategoriasPorNombreUsecase;

  CategoriaBloc({
    required this.deleteCategoriaUseCase,
    required this.getCategoriaByIdUsecase,
    required this.getCategoriasUsecase,
    required this.postCategoriaUsecase,
    required this.putCategoriaUsecase,
    required this.buscarCategoriasPorNombreUsecase,
}): super(CategoriaInitial()) {
    on<DeleteCategoriaEvent>((event, emit) async {
      emit(CategoriaLoading());
      try{
        await deleteCategoriaUseCase(event.idCategoria);
        emit(const CategoriaSuccess("Categoria eliminada exitosamente"));
        final categorias = await getCategoriasUsecase();
        emit(CategoriaListLoaded(categorias));
      } catch (e){
        emit(CategoriaError("Error al eliminar categoria: $e"));
      }
    });

    on<GetCategoriaByIdEvent>((event, emit) async {
      emit(CategoriaLoading());
      try{
        final categoria = await getCategoriaByIdUsecase(event.idCategoria);
        emit(CategoriaLoaded(categoria));
      }catch (e){
        emit(CategoriaError("Error al encontrar categoria: $e"));
      }
    });

    on<GetCategoriasEvent>((event, emit) async {
      emit(CategoriaLoading());
      try{
        final categorias = await getCategoriasUsecase();
        emit(CategoriaListLoaded(categorias));
      } catch (e){
        emit(CategoriaError("Error al encontrar categorias: $e"));
      }
    });

    on<PostCategoriaEvent>((event, emit) async {
      emit(CategoriaLoading());
      try{
        await postCategoriaUsecase(event.categoriaDto, event.file);
        emit(const CategoriaSuccess("Categoria creada con exito"));
        final categorias = await getCategoriasUsecase();
        emit(CategoriaListLoaded(categorias));
      } catch (e){
        emit(CategoriaError("Error al crear categoria: $e"));
      }
    });

    on<PutCategoriaEvent>((event, emit) async {
      emit(CategoriaLoading());
      try{
        await putCategoriaUsecase(event.idCategoria, event.categoriaDto, event.file);
        emit(const CategoriaSuccess("Categoria actualizada con exito"));
        final categorias = await getCategoriasUsecase();
        emit(CategoriaListLoaded(categorias));
      } catch (e){
        emit(CategoriaError("Error al encontrar categoria: $e"));
      }
    });

    on<BuscarCategoriasPorNombreEvent>(
          (event, emit) async {
        try {
          final resultados = await buscarCategoriasPorNombreUsecase(event.nombre);
          emit(CategoriaListLoaded(resultados));
        } catch (e) {
          emit(CategoriaError("Error al buscar categoria: $e"));
        }
      },
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );
  }
}