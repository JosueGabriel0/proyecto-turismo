import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turismo_flutter/data/models/usuario_completo_dto.dart';
import 'package:turismo_flutter/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/data/services/login_service.dart';
import 'package:turismo_flutter/data/services/usuario_service.dart';

class AdminUsuarioScreen extends StatefulWidget{
  const AdminUsuarioScreen({super.key});

  @override
  _AdminUsuarioScreenState createState() => _AdminUsuarioScreenState();
}

class _AdminUsuarioScreenState extends State<AdminUsuarioScreen> {
  List<UsuarioCompletoResponse> usuarios = [];
  bool isLoading = true;
  final UsuarioService _usuarioService = UsuarioService();


  @override
  void initState(){
    super.initState();
    _fetchUsuarios();
  }



  Future<void> _fetchUsuarios() async {
    try{
      final fetchedUsuarios = await _usuarioService.obtenerUsuarios();
      setState(() {
        usuarios = fetchedUsuarios;
        isLoading = false;
      });
    } catch(e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al cargar usuarios: $e")),
        );
        setState(
          () => isLoading = false
        );
    }
  }
  void _showAddUsuarioDialog() {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final estadoCuentaController = TextEditingController();
    final nombreRolController = TextEditingController();
    final nombresController = TextEditingController();
    final apellidosController = TextEditingController();
    final tipoDocumentoController = TextEditingController();
    final numeroDocumentoController = TextEditingController();
    final telefonoController = TextEditingController();
    final direccionController = TextEditingController();
    final correoElectronicoController = TextEditingController();
    final fotoPerfilController = TextEditingController();
    final fechaNacimientoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Agregar nuevo usuario"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(controller: usernameController, decoration: const InputDecoration(hintText: 'Username')),
                TextField(controller: passwordController, decoration: const InputDecoration(hintText: 'Contraseña'), obscureText: true),
                TextField(controller: estadoCuentaController, decoration: const InputDecoration(hintText: 'Estado de cuenta')),
                TextField(controller: nombreRolController, decoration: const InputDecoration(hintText: 'Nombre del rol')),
                TextField(controller: nombresController, decoration: const InputDecoration(hintText: 'Nombres')),
                TextField(controller: apellidosController, decoration: const InputDecoration(hintText: 'Apellidos')),
                TextField(controller: tipoDocumentoController, decoration: const InputDecoration(hintText: 'Tipo de documento')),
                TextField(controller: numeroDocumentoController, decoration: const InputDecoration(hintText: 'Número de documento')),
                TextField(controller: telefonoController, decoration: const InputDecoration(hintText: 'Teléfono')),
                TextField(controller: direccionController, decoration: const InputDecoration(hintText: 'Dirección')),
                TextField(controller: correoElectronicoController, decoration: const InputDecoration(hintText: 'Correo electrónico')),
                TextField(controller: fotoPerfilController, decoration: const InputDecoration(hintText: 'Foto de perfil (opcional)')),
                TextField(controller: fechaNacimientoController, decoration: const InputDecoration(hintText: 'Fecha de nacimiento (YYYY-MM-DD)')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (usernameController.text.isNotEmpty && fechaNacimientoController.text.isNotEmpty) {
                  try {
                    final fechaNacimiento = DateTime.parse(fechaNacimientoController.text);

                    final nuevoUsuarioDto = UsuarioCompletoDto(
                      username: usernameController.text,
                      password: passwordController.text,
                      estadoCuenta: estadoCuentaController.text,
                      nombreRol: nombreRolController.text,
                      nombres: nombresController.text,
                      apellidos: apellidosController.text,
                      tipoDocumento: tipoDocumentoController.text,
                      numeroDocumento: numeroDocumentoController.text,
                      telefono: telefonoController.text,
                      direccion: direccionController.text,
                      correoElectronico: correoElectronicoController.text,
                      fotoPerfil: fotoPerfilController.text.isNotEmpty ? fotoPerfilController.text : "",
                      fechaNacimiento: fechaNacimiento,
                    );

                    final creado = await _usuarioService.crearUsuario(nuevoUsuarioDto);

                    setState(() {
                      usuarios.add(creado);
                    });

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Usuario creado exitosamente")),
                    );
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error al crear usuario: $e")),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Por favor complete los campos obligatorios")),
                  );
                }
              },
              child: const Text("Crear"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }


  void _showUpdateUsuarioDialog(int index) {
    final usuario = usuarios[index];
    TextEditingController usernameController = TextEditingController(text: usuario.username);
    TextEditingController passwordController = TextEditingController(text: usuario.password ?? '');
    TextEditingController estadoCuentaController = TextEditingController(text: usuario.estado);
    TextEditingController nombreRolController = TextEditingController(text: usuario.rol.nombre);
    TextEditingController nombresController = TextEditingController(text: usuario.persona.nombres);
    TextEditingController apellidosController = TextEditingController(text: usuario.persona.apellidos);
    TextEditingController tipoDocumentoController = TextEditingController(text: usuario.persona.tipoDocumento);
    TextEditingController numeroDocumentoController = TextEditingController(text: usuario.persona.numeroDocumento);
    TextEditingController telefonoController = TextEditingController(text: usuario.persona.telefono);
    TextEditingController direccionController = TextEditingController(text: usuario.persona.direccion);
    TextEditingController correoElectronicoController = TextEditingController(text: usuario.persona.correoElectronico);
    TextEditingController fotoPerfilController = TextEditingController(text: usuario.persona.fotoPerfil ?? '');
    TextEditingController fechaNacimientoController = TextEditingController(text: usuario.persona.fechaNacimiento.toIso8601String());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Actualizar usuario"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(hintText: 'Nuevo username'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(hintText: 'Nueva contraseña'),
                  obscureText: true,
                ),
                TextField(
                  controller: estadoCuentaController,
                  decoration: const InputDecoration(hintText: 'Nuevo estado'),
                ),
                TextField(
                  controller: nombreRolController,
                  decoration: const InputDecoration(hintText: 'Nuevo nombre de rol'),
                ),
                TextField(
                  controller: nombresController,
                  decoration: const InputDecoration(hintText: 'Nombres'),
                ),
                TextField(
                  controller: apellidosController,
                  decoration: const InputDecoration(hintText: 'Apellidos'),
                ),
                TextField(
                  controller: tipoDocumentoController,
                  decoration: const InputDecoration(hintText: 'Tipo de documento'),
                ),
                TextField(
                  controller: numeroDocumentoController,
                  decoration: const InputDecoration(hintText: 'Número de documento'),
                ),
                TextField(
                  controller: telefonoController,
                  decoration: const InputDecoration(hintText: 'Teléfono'),
                ),
                TextField(
                  controller: direccionController,
                  decoration: const InputDecoration(hintText: 'Dirección'),
                ),
                TextField(
                  controller: correoElectronicoController,
                  decoration: const InputDecoration(hintText: 'Correo electrónico'),
                ),
                TextField(
                  controller: fotoPerfilController,
                  decoration: const InputDecoration(hintText: 'Foto de perfil'),
                ),
                TextField(
                  controller: fechaNacimientoController,
                  decoration: const InputDecoration(hintText: 'Fecha de nacimiento (YYYY-MM-DD)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (usernameController.text.isNotEmpty && fechaNacimientoController.text.isNotEmpty) {
                  try {
                    final fechaNacimiento = DateTime.parse(fechaNacimientoController.text);
                    final updateDto = usuario.toDto(
                      usernameController.text,
                      passwordController.text,
                      estadoCuentaController.text,
                      nombreRolController.text,
                      nombresController.text,
                      apellidosController.text,
                      tipoDocumentoController.text,
                      numeroDocumentoController.text,
                      telefonoController.text,
                      direccionController.text,
                      correoElectronicoController.text,
                      fotoPerfilController.text,
                      fechaNacimiento,
                    );

                    final updatedUsuarioResponse = await _usuarioService.actualizarUsuario(usuario.idUsuario, updateDto);

                    setState(() {
                      usuarios[index] = updatedUsuarioResponse;
                    });

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Usuario actualizado exitosamente")),
                    );
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error al actualizar usuario: $e")),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Por favor complete todos los campos")),
                  );
                }
              },
              child: const Text("Actualizar"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(usuarios[index].idUsuario.toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) async {
              final usuarioId = usuarios[index].idUsuario;

              try {
                await _usuarioService.eliminarUsuario(usuarioId);
                setState(() {
                  usuarios.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Usuario eliminado exitosamente")),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error al eliminar el usuario: $e")),
                );
              }
            },
            background: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            child: ListTile(
              title: Text(usuarios[index].username),
              subtitle: Text(usuarios[index].rol.nombre),
              trailing: const Icon(Icons.edit),
              onTap: () => _showUpdateUsuarioDialog(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _showAddUsuarioDialog,
          child: const Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
      ),
    );
  }
}