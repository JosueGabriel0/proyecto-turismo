import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/emprendimiento/emprendimiento_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/emprendimiento/emprendimiento_state.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/rol/rol_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/rol/rol_state.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_state.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/foto_widget.dart';
import 'package:turismo_flutter/features/admin/presentation/widgets/cruds/info_row_widget.dart';
import 'package:intl/intl.dart';

class UsuarioScreen extends StatefulWidget {
  const UsuarioScreen({super.key});

  @override
  State<UsuarioScreen> createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _estadoCuentaController = TextEditingController();
  final _nombreRolController = TextEditingController();
  final _nombreEmprendimientoController = TextEditingController();
  final _nombresController = TextEditingController();
  final _apellidosController = TextEditingController();
  final _tipoDocumentoController = TextEditingController();
  final _numeroDocumentoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _direccionController = TextEditingController();
  final _correoElectronicoController = TextEditingController();
  final _fechaNacimientoController = TextEditingController();
  File? _imagen;
  int? _usuarioEditandoId;
  final _searchController = TextEditingController();

  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  String? _rolSeleccionado;

  String? _emprendimientoSeleccionado;

  @override
  void initState() {
    super.initState();
    context.read<UsuarioBloc>().add(GetAllUsuariosEvent());
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _imagen = File(image.path));
  }

  void _resetForm() {
    _userNameController.clear();
    _passwordController.clear();
    _estadoCuentaController.clear();
    _nombreRolController.clear();
    _nombreEmprendimientoController.clear();
    _nombresController.clear();
    _apellidosController.clear();
    _tipoDocumentoController.clear();
    _numeroDocumentoController.clear();
    _telefonoController.clear();
    _direccionController.clear();
    _correoElectronicoController.clear();
    _fechaNacimientoController.clear();
    _imagen = null;
    _usuarioEditandoId = null;
    _rolSeleccionado = null;
    _emprendimientoSeleccionado = null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final usuarioDto = UsuarioCompletoDto(
        username: _userNameController.text,
        password: _passwordController.text,
        estadoCuenta: _estadoCuentaController.text,
        nombreRol: _nombreRolController.text,
        nombreEmprendimiento: _nombreRolController.text.toLowerCase() == 'role_emprendedor'
            ? _emprendimientoSeleccionado
            : null,
        nombres: _nombresController.text,
        apellidos: _apellidosController.text,
        tipoDocumento: _tipoDocumentoController.text,
        numeroDocumento: _numeroDocumentoController.text,
        telefono: _telefonoController.text,
        direccion: _direccionController.text,
        correoElectronico: _correoElectronicoController.text,
        fechaNacimiento: _fechaNacimientoController.text,
      );

      print('DTO JSON a enviar: ${usuarioCompletoDtoToJson(usuarioDto)}');

      if (_usuarioEditandoId != null) {
        context.read<UsuarioBloc>().add(
          UpdateUsuarioEvent(_usuarioEditandoId!, usuarioDto, _imagen),
        );
      } else {
        context.read<UsuarioBloc>().add(
            CreateUsuarioEvent(usuarioDto, _imagen));
      }

      _resetForm();
    }
  }

  void _cargarParaEditar(UsuarioCompletoResponse usuario) {
    setState(() {
      _usuarioEditandoId = usuario.idUsuario;
      _userNameController.text = usuario.username ?? 'Sin nombre';
      _passwordController.text = '';
      _estadoCuentaController.text = usuario.estado ?? 'Sin nombre';
      _rolSeleccionado = usuario.rol?.nombre ?? '';
      _nombreRolController.text = usuario.rol?.nombre ?? '';
      _nombresController.text = usuario.persona?.nombres ?? 'Sin nombre';
      _apellidosController.text = usuario.persona?.apellidos ?? 'Sin nombre';
      _tipoDocumentoController.text =
          usuario.persona?.tipoDocumento ?? 'Sin nombre';
      _numeroDocumentoController.text =
          usuario.persona?.numeroDocumento ?? 'Sin nombre';
      _telefonoController.text = usuario.persona?.telefono ?? 'Sin nombre';
      _direccionController.text = usuario.persona?.direccion ?? 'Sin nombre';
      _correoElectronicoController.text =
          usuario.persona?.correoElectronico ?? 'Sin nombre';
      _fechaNacimientoController.text =
          usuario.persona?.fechaNacimiento ?? 'Sin nombre';
    });
  }

  Future<bool?> _onDismissed(BuildContext context,
      UsuarioCompletoResponse usuario) async {
    final confirmacion = await showDialog<bool>(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text("¿Confirmar eliminación?"),
            content: Text(
                "¿Estás seguro de que deseas eliminar al usuario '${usuario
                    .username}'?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                    "Eliminar", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );

    if (confirmacion == true) {
      context.read<UsuarioBloc>().add(DeleteUsuarioEvent(usuario.idUsuario));
    }

    return confirmacion; // 👈 Esto es lo que necesita confirmDismiss
  }

  void _mostrarFormulario(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _userNameController,
                        decoration: const InputDecoration(labelText: "Username"),
                        validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(labelText: "Password"),
                        obscureText: true,
                      ),
                      DropdownButtonFormField<String>(
                        value: _estadoCuentaController.text.isNotEmpty
                            ? _estadoCuentaController.text
                            : null,
                        decoration: const InputDecoration(labelText: "Estado Cuenta"),
                        items: const [
                          DropdownMenuItem(value: 'ACTIVO', child: Text('ACTIVO')),
                          DropdownMenuItem(value: 'INACTIVO', child: Text('INACTIVO')),
                          DropdownMenuItem(value: 'BLOQUEADO', child: Text('BLOQUEADO')),
                        ],
                        onChanged: (value) {
                          setStateDialog(() {
                            _estadoCuentaController.text = value!;
                          });
                        },
                        validator: (value) =>
                        value == null || value.isEmpty ? 'Campo requerido' : null,
                      ),
                      BlocBuilder<RolBloc, RolState>(
                        builder: (context, rolState) {
                          if (rolState is RolLoadedState) {
                            final roles = rolState.roles
                                .map((r) => r.nombre)
                                .toSet()
                                .toList();

                            final currentValue = roles.contains(_nombreRolController.text)
                                ? _nombreRolController.text
                                : null;

                            return DropdownButtonFormField<String>(
                              value: _rolSeleccionado ?? currentValue,
                              decoration: const InputDecoration(labelText: "Rol"),
                              items: roles.map((rol) {
                                return DropdownMenuItem(value: rol, child: Text(rol));
                              }).toList(),
                              onChanged: (value) {
                                setStateDialog(() {
                                  _rolSeleccionado = value;
                                  _nombreRolController.text = value ?? '';

                                  if (value?.toLowerCase() != 'role_emprendedor') {
                                    _emprendimientoSeleccionado = null;
                                    _nombreEmprendimientoController.clear();
                                  }
                                });
                              },
                              validator: (value) =>
                              value == null || value.isEmpty ? 'Campo requerido' : null,
                            );
                          } else if (rolState is RolLoadingState) {
                            return const CircularProgressIndicator();
                          } else if (rolState is RolErrorState) {
                            return Text("Error al cargar roles: ${rolState.message}");
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      if (_rolSeleccionado?.toLowerCase() == 'role_emprendedor')
                        BlocBuilder<EmprendimientoBloc, EmprendimientoState>(
                          builder: (context, emprendimientoState) {
                            if (emprendimientoState is EmprendimientoListLoaded) {
                              final emprendimientos = emprendimientoState.emprendimientos
                                  .map((e) => e.nombre)
                                  .toSet()
                                  .toList();

                              final currentValue = emprendimientos.contains(_nombreEmprendimientoController.text)
                                  ? _nombreEmprendimientoController.text
                                  : null;

                              return DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: _emprendimientoSeleccionado ?? currentValue,
                                decoration: const InputDecoration(labelText: "Emprendimiento"),
                                items: emprendimientos.map((emprendimiento) {
                                  return DropdownMenuItem<String>(
                                    value: emprendimiento,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text(emprendimiento, overflow: TextOverflow.ellipsis),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setStateDialog(() {
                                    _emprendimientoSeleccionado = value;
                                    _nombreEmprendimientoController.text = value ?? '';
                                  });
                                },
                                validator: (value) =>
                                value == null || value.isEmpty ? 'Campo requerido' : null,
                              );
                            } else if (emprendimientoState is EmprendimientoLoading) {
                              return const CircularProgressIndicator();
                            } else if (emprendimientoState is EmprendimientoError) {
                              return Text("Error al cargar emprendimientos: ${emprendimientoState.message}");
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      TextFormField(
                        controller: _nombresController,
                        decoration: const InputDecoration(labelText: "Nombres"),
                      ),
                      TextFormField(
                        controller: _apellidosController,
                        decoration: const InputDecoration(labelText: "Apellidos"),
                      ),
                      TextFormField(
                        controller: _tipoDocumentoController,
                        decoration: const InputDecoration(labelText: "Tipo Documento"),
                      ),
                      TextFormField(
                        controller: _numeroDocumentoController,
                        decoration: const InputDecoration(labelText: "Número Documento"),
                      ),
                      TextFormField(
                        controller: _telefonoController,
                        decoration: const InputDecoration(labelText: "Teléfono"),
                      ),
                      TextFormField(
                        controller: _direccionController,
                        decoration: const InputDecoration(labelText: "Dirección"),
                      ),
                      TextFormField(
                        controller: _correoElectronicoController,
                        decoration: const InputDecoration(labelText: "Correo Electrónico"),
                      ),
                      TextFormField(
                        controller: _fechaNacimientoController,
                        decoration: const InputDecoration(
                          labelText: "Fecha de Nacimiento",
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? fechaSeleccionada = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (fechaSeleccionada != null) {
                            setStateDialog(() {
                              _fechaNacimientoController.text =
                                  _formatter.format(fechaSeleccionada);
                            });
                          }
                        },
                        validator: (value) =>
                        value == null || value.isEmpty ? "Campo requerido" : null,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: _pickImage,
                            child: const Text("Seleccionar Imagen"),
                          ),
                          if (_imagen != null)
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text("Imagen seleccionada"),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _submitForm();
                              Navigator.of(context).pop();
                            },
                            child: Text(_usuarioEditandoId == null ? "Crear" : "Actualizar"),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: () {
                              _resetForm();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancelar"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocListener<UsuarioBloc, UsuarioState>(
          listener: (context, state) {
            if (state is UsuarioSuccess) {
              context.read<UsuarioBloc>().add(GetAllUsuariosEvent());
            }
          },
          child: BlocBuilder<UsuarioBloc, UsuarioState>(
            builder: (context, state) {
              if (state is UsuarioLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UsuarioListLoaded) {
                return Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        context
                            .read<UsuarioBloc>()
                            .add(BuscarUsuarioPorNombreEvent(value));
                      },
                      decoration: const InputDecoration(
                        labelText: 'Buscar usuario...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.usuarios.length,
                        itemBuilder: (context, index) {
                          final usuario = state.usuarios[index];
                          return Dismissible(
                            key: Key(usuario.idUsuario.toString()),
                            confirmDismiss: (_) => _onDismissed(context, usuario),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: ListTile(
                              leading: FotoWidget(
                                fileName: usuario.persona?.fotoPerfil ?? "",
                              ),
                              title: Text(usuario.username ?? 'Sin username'),
                              subtitle: Text(usuario.persona?.nombres ?? 'Sin nombre'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.info),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text('Información del Usuario'),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: FotoWidget(
                                                    fileName: usuario.persona?.fotoPerfil ?? '',
                                                    size: 80,
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                InfoRowWidget(label: "ID", value: usuario.idUsuario.toString()),
                                                InfoRowWidget(label: "Username", value: usuario.username ?? 'Sin username'),
                                                InfoRowWidget(label: "Password", value: "Encriptado"),
                                                InfoRowWidget(label: "Estado", value: usuario.estado ?? 'Sin estado'),
                                                InfoRowWidget(label: "Rol", value: usuario.rol?.nombre ?? 'Sin rol'),
                                                InfoRowWidget(label: "Nombres", value: usuario.persona?.nombres ?? 'Sin nombres'),
                                                InfoRowWidget(label: "Apellidos", value: usuario.persona?.apellidos ?? 'Sin apellidos'),
                                                InfoRowWidget(label: "Tipo Documento", value: usuario.persona?.tipoDocumento ?? 'Sin tipo'),
                                                InfoRowWidget(label: "Número Documento", value: usuario.persona?.numeroDocumento ?? 'Sin número'),
                                                InfoRowWidget(label: "Teléfono", value: usuario.persona?.telefono ?? 'Sin teléfono'),
                                                InfoRowWidget(label: "Dirección", value: usuario.persona?.direccion ?? 'Sin dirección'),
                                                InfoRowWidget(label: "Correo", value: usuario.persona?.correoElectronico ?? 'Sin correo'),
                                                InfoRowWidget(label: "Fecha Nacimiento", value: usuario.persona?.fechaNacimiento ?? 'Sin fecha'),
                                                InfoRowWidget(label: "Reseñas", value: usuario.resenas?.toString() ?? 'Sin reseñas'),
                                                InfoRowWidget(label: "Reservas", value: usuario.reservas?.toString() ?? 'Sin reservas'),
                                                usuario.emprendimiento != null
                                                    ? Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(height: 12),
                                                    Text(
                                                      'Emprendimiento:',
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                    ),
                                                    InfoRowWidget(label: "Nombre:", value: usuario.emprendimiento?.nombre),
                                                    InfoRowWidget(label: "Descripcion:", value: usuario.emprendimiento?.descripcion),

                                                  ],
                                                )
                                                    : SizedBox.shrink(),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.of(context).pop(),
                                              child: const Text('Cerrar'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      _cargarParaEditar(usuario);
                                      _mostrarFormulario(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is UsuarioError) {
                return Text(state.message, style: const TextStyle(color: Colors.red));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormulario(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}