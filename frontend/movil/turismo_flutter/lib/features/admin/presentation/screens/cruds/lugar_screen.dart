import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/lugar/lugar_state.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_state.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';

class LugarScreen extends StatefulWidget{
  const LugarScreen({super.key});

  @override
  State<LugarScreen> createState() => _LugarScreenState();
}

class _LugarScreenState extends State<LugarScreen>{

  @override
  void initState() {
    super.initState();
    context.read<LugarBloc>().add(GetAllLugaresEvent());
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocListener<LugarBloc, LugarState>(
            listener: (context, state){
              if(state is LugarSuccess){
                context.read<LugarBloc>().add(GetAllLugaresEvent());
              }
              },
            child: BlocBuilder<LugarBloc, LugarState>(
                builder: (context, state) {
                  if(state is LugarLoading){
                    return const Center(child: CircularProgressIndicator(),);
                  } else if(state is LugarListLoaded){
                    return ListView.builder(
                        itemCount: state.lugares.length,
                        itemBuilder: (context, index) {
                          final lugar = state.lugares[index];
                          return Dismissible(
                              key: Key(lugar.idLugar.toString()),
                              //confirmDismiss: (_) => _onDismissed(context, lugar),
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.delete, color: Colors.white,),
                              ),
                              child: ListTile(
                                leading: FotoWidget(
                                  fileName: lugar.imagenUrl
                                ),
                                title: Text(lugar.nombre),
                                subtitle: Text(lugar.direccion),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.info),
                                      onPressed: (){},
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: (){}, )
                                  ],
                                ),
                              ),
                          );
                        },
                        );
                  } else if(state is LugarError){
                    return Text(
                      state.message, style: const TextStyle(color: Colors.red),
                    );
                  }
                  return const SizedBox.shrink();
                },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          child: const Icon(Icons.add),
      ),
    );
  }
}