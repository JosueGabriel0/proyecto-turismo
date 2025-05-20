import 'package:equatable/equatable.dart';
import 'package:turismo_flutter/features/admin/data/models/lugar_response.dart';

abstract class LugarState extends Equatable{
  const LugarState();

  @override
  List<Object?> get props => [];
}

class LugarInitial extends LugarState{}

class LugarLoading extends LugarState{}

class LugarListLoaded extends LugarState{
  final List<LugarResponse> lugares;
  const LugarListLoaded(this.lugares);

  @override
  List<Object?> get props => [lugares];
}

class LugarLoaded extends LugarState{
  final LugarResponse lugar;
  const LugarLoaded(this.lugar);

  @override
  List<Object?> get props => [lugar];
}

class LugarSuccess extends LugarState{
  final String message;
  const LugarSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class LugarError extends LugarState{
  final String message;
  const LugarError(this.message);

  @override
  List<Object?> get props => [message];
}

class LugarSearchLoaded extends LugarState {
  final List<LugarResponse> resultados;

  const LugarSearchLoaded(this.resultados);

  @override
  List<Object?> get props => [resultados];
}