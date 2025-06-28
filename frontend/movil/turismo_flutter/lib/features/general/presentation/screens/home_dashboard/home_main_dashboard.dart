import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/categoria/categoria_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/categoria/categoria_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/emprendimiento/emprendimiento_general_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/emprendimiento/emprendimiento_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/lugar/lugar_general_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/lugar/lugar_general_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/ubicacion/ubicacion_bloc.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/ubicacion/ubicacion_event.dart';
import 'package:turismo_flutter/features/general/presentation/bloc/ubicacion/ubicacion_state.dart';
import 'package:turismo_flutter/features/general/presentation/screens/mapa_general_screen.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/custom_progress_card.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/categorias_grid_widget.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/popular_places_carousel.dart';
import 'package:turismo_flutter/features/general/presentation/widgets/suggested_locales_carousel.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_event.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_state.dart';

class HomeMainDashboard extends StatefulWidget {
  final Function(int newIndex, {int? id}) onNavigate;

  const HomeMainDashboard({Key? key, required this.onNavigate}) : super(key: key);

  @override
  _HomeMainDashboardState createState() => _HomeMainDashboardState();
}

class _HomeMainDashboardState extends State<HomeMainDashboard> {
  UsuarioUserResponse? _usuario;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsuarioUserBloc>().add(GetMyUsuarioUserEvent());
    });
  }

  Future<void> _onRefresh() async {
    final usuarioBloc = BlocProvider.of<UsuarioUserBloc>(context);
    final lugarGeneralBloc = BlocProvider.of<LugarGeneralBloc>(context);
    final emprendimientoGeneralBloc = BlocProvider.of<EmprendimientoGeneralBloc>(context);
    final categoriaGeneralBloc = BlocProvider.of<CategoriaGeneralBloc>(context);

    usuarioBloc.add(GetMyUsuarioUserEvent());
    lugarGeneralBloc.add(GetAllLugaresGeneralEvent());
    emprendimientoGeneralBloc.add(GetEmprendimientosGeneralEvent());
    categoriaGeneralBloc.add(GetCategoriasGeneralEvent());

    // Esperar un poco para permitir que los datos se actualicen visualmente.
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsuarioUserBloc, UsuarioUserState>(
        listener: (context, state) {
      if (state is UsuarioUserProfileLoaded) {
        setState(() {
          _usuario = state.usuario;
        });
      }
    },
    child: Scaffold(
    body: SafeArea(
    child: RefreshIndicator(
    onRefresh: _onRefresh,
    child: SingleChildScrollView(
    physics: const AlwaysScrollableScrollPhysics(),
    padding: const EdgeInsets.all(16),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const SizedBox(height: 5),
                Row(
                  children: [
                    _usuario != null && _usuario!.persona?.fotoPerfil != null
                        ? FotoWidget(
                      fileName: _usuario!.persona!.fotoPerfil!,
                      size: 60,
                    )
                        : const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 36, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bienvenido, ${_usuario?.persona?.nombres ?? "Usuario"}',
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Descubre lo único',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<UbicacionBloc, UbicacionState>(
                      listener: (context, state) {
                        if (state is UbicacionLoaded) {
                          // Navegar al mapa con datos reales
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MapaGeneralScreen(
                                ubicaciones: state.ubicaciones
                                    .map((u) => {
                                  'lat': u.lat,
                                  'lng': u.lng,
                                  'titulo': u.titulo,
                                  'tipo': u.tipo,
                                  'descripcion': u.descripcion,
                                  'imagen': u.imagen,
                                })
                                    .toList(),
                              ),
                            ),
                          );
                        } else if (state is UbicacionError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.mensaje)),
                          );
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state is UbicacionLoading;

                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                  context.read<UbicacionBloc>().add(ObtenerUbicacionesEvent());
                                },
                                icon: const Icon(Icons.location_on),
                                label: const Text('Explorar mapa'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF5AC7F5),
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (isLoading)
                              const Positioned(
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                CustomProgressCard(
                  title: "Conoce todo a tu alrededor",
                  subtitle: "Descubre joyas ocultas en cada lugar",
                  progressPercent: 50,
                  onMapPressed: () => print("Mapa"),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          hintText: 'Busca tesoros locales',
                          prefixIcon: const Icon(Icons.search),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        print("Ir a la tienda");
                      },
                      icon: const Icon(Icons.store),
                      tooltip: 'Tienda',
                      color: Colors.black,
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        side: const BorderSide(color: Colors.grey),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                PopularPlacesCarousel(
                  onExplorarPressed: (lugar) {
                    widget.onNavigate(1, id: lugar.idLugar);
                    print("Explorar lugar: ${lugar.idLugar}");
                    // puedes llamar setState o navegación aquí
                  },
                  onRatePressed: (lugar) {
                    print("Rate lugar: ${lugar.idLugar}");
                  },
                  onCardTapped: (lugar) {
                    widget.onNavigate(1, id: lugar.idLugar);
                    print("Card completo tocado: ${lugar.idLugar}");
                  },
                ),

                Transform.translate(
                  offset: const Offset(0, -30), // Mueve hacia arriba 10px
                  child: SuggestedLocalesCarousel(),
                ),

                Transform.translate(
                  offset: const Offset(0, -30), // Mueve hacia arriba 10px
                  child: CategoriasGridWidget(),
                ),

              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}