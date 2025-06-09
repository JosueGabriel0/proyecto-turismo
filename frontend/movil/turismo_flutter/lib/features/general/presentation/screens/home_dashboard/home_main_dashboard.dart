import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
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
          child: SingleChildScrollView(
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
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MapaGeneralScreen(
                              ubicaciones: [
                                {'lat': -17.7828, 'lng': -63.1821, 'titulo': 'Lugar A'},
                                {'lat': -17.7891, 'lng': -63.1964, 'titulo': 'Lugar B'},
                                {'lat': -17.7801, 'lng': -63.1702, 'titulo': 'Lugar C'},
                              ],
                            ),
                          ),
                        );
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
                            width: 2, // Puedes ajustar el grosor del borde
                          ),
                        ),
                      ),
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
    );
  }
}