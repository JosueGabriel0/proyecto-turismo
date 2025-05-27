import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/general/data/models/familia_general_response.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/lugar/lugar_general_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/lugar/lugar_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/lugar/lugar_general_state.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/familia_lugar_card_widget.dart';

class FamiliasLugaresScreen extends StatelessWidget {
  final Function(int newIndex, {int? id}) onNavigate;
  final Function(int newIndex) onNavigateIndex;
  final int? id;

  const FamiliasLugaresScreen({Key? key, this.id, required this.onNavigate, required this.onNavigateIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (id != null) {
      print('Enviando ID al backend: ${id!}');
      context.read<LugarGeneralBloc>().add(GetFamiliasPorLugarEvent(id!));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Familias del lugar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            onNavigateIndex(0); // ← Navega al índice 1
          },
        ),
      ),
      body: BlocBuilder<LugarGeneralBloc, LugarGeneralState>(
        builder: (context, state) {
          if (state is LugarLoadingGeneral) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FamiliasPorLugarLoadedGeneral) {
            final familias = state.familias;

            if (familias.isEmpty) {
              return const Center(child: Text('No hay familias disponibles.'));
            }

            return ListView.builder(
              itemCount: familias.length,
              itemBuilder: (context, index) {
                final familia = familias[index];
                return FamiliaLugarCardWidget(
                  familia: familia,
                  onExploraPressed: (familia) {
                    onNavigate(2, id: familia.idFamilia);
                    print("Id familia enviada ${familia.idFamilia}");
                  },
                );
              },
            );
          } else if (state is LugarErrorGeneral) {
            return Center(child: Text(state.message));
          }

          return const Center(child: Text('Seleccione un lugar para ver sus familias.'));
        },
      ),
    );
  }
}
