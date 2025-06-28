import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:turismo_flutter/core/services/token_storage_service.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/perfil/perfil_admin_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/perfil/perfil_admin_event.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_event.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_dto_user.dart';
import 'package:turismo_flutter/features/usuario/data/models/usuario_user_response.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_bloc.dart';
import 'package:turismo_flutter/features/usuario/presentation/bloc/usuario/usuario_user_event.dart';

class FormularioActualizarUser extends StatefulWidget {
  final UsuarioUserResponse usuario;

  const FormularioActualizarUser({super.key, required this.usuario});

  @override
  State<FormularioActualizarUser> createState() => _FormularioActualizarUserState();
}

class _FormularioActualizarUserState extends State<FormularioActualizarUser> {
  late final TextEditingController usernameCtrl;
  late final TextEditingController passwordCtrl;
  late final TextEditingController nombreCtrl;
  late final TextEditingController apellidoCtrl;
  String? tipoDocumentoCtrl;
  late final TextEditingController numeroDocumentoCtrl;
  late final TextEditingController telefonoCtrl;
  late final TextEditingController direccionCtrl;
  late final TextEditingController correoCtrl;
  late final TextEditingController fechaNacimientoCtrl;
  late String usernameOriginal;

  File? _imagen;

  late final TextEditingController confirmPasswordCtrl;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;


  final List<String> _tiposDocumento = ['DNI', 'Pasaporte', 'Cédula', 'Otro'];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usernameOriginal = widget.usuario.username ?? '';
    usernameCtrl = TextEditingController(text: widget.usuario.username ?? '');
    passwordCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();
    nombreCtrl = TextEditingController(text: widget.usuario.persona?.nombres ?? '');
    apellidoCtrl = TextEditingController(text: widget.usuario.persona?.apellidos ?? '');
    tipoDocumentoCtrl = widget.usuario.persona?.tipoDocumento;
    numeroDocumentoCtrl = TextEditingController(text: widget.usuario.persona?.numeroDocumento ?? '');
    telefonoCtrl = TextEditingController(text: widget.usuario.persona?.telefono ?? '');
    direccionCtrl = TextEditingController(text: widget.usuario.persona?.direccion ?? '');
    correoCtrl = TextEditingController(text: widget.usuario.persona?.correoElectronico ?? '');
    fechaNacimientoCtrl = TextEditingController(text: widget.usuario.persona?.fechaNacimiento ?? '');
  }

  @override
  void dispose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    nombreCtrl.dispose();
    apellidoCtrl.dispose();
    numeroDocumentoCtrl.dispose();
    telefonoCtrl.dispose();
    direccionCtrl.dispose();
    correoCtrl.dispose();
    fechaNacimientoCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final nuevoUsername = usernameCtrl.text;

    final dto = UsuarioDtoUser(
      username: nuevoUsername,
      password: passwordCtrl.text,
      nombres: nombreCtrl.text,
      apellidos: apellidoCtrl.text,
      tipoDocumento: tipoDocumentoCtrl ?? '',
      numeroDocumento: numeroDocumentoCtrl.text,
      telefono: telefonoCtrl.text,
      direccion: direccionCtrl.text,
      correoElectronico: correoCtrl.text,
      fechaNacimiento: fechaNacimientoCtrl.text,
    );

    print("Json enviado: ${jsonEncode(dto.toJson())}");

    // 🔥 Lanza el evento (esto NO es instantáneo, es asíncrono)
    context.read<UsuarioUserBloc>().add(
      PutUsuarioUserEvent(dto, _imagen),
    );

    // 🕐 Esperamos un pequeño delay para dar tiempo a que el BLoC procese
    await Future.delayed(Duration(milliseconds: 500));

    // ✅ Mostrar el diálogo después de la "actualización"
    if (nuevoUsername != usernameOriginal) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Username cambiado'),
            content: const Text(
              'Has cambiado tu nombre de usuario. Para continuar, debes volver a registrarte.',
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  final tokenService = TokenStorageService();
                  await tokenService.clearToken();
                  context.go("/login");
                },
                child: const Text('Volver a registrarse'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.pop(context, true);
    }
  }

  Future<void> _pickImage(Function() setStateCallback) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imagen = File(image.path);
      setStateCallback(); // Esto actualiza el diálogo
    }
  }

  final DateFormat _formatter = DateFormat('yyyy-MM-dd');

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Campo requerido';
    final passwordRegex =
    RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Debe tener 8+ caracteres, mayúscula, minúscula, número y símbolo';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != passwordCtrl.text) return 'Las contraseñas no coinciden';
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text("Editando Usuario", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: usernameCtrl,
                  decoration: const InputDecoration(labelText: "Username"),
                  validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                ),
                TextFormField(
                  controller: passwordCtrl,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    errorMaxLines: 2,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: _validatePassword,
                ),
                TextFormField(
                  controller: confirmPasswordCtrl,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    labelText: "Confirmar Contraseña",
                    errorMaxLines: 2,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: _validateConfirmPassword,
                ),
                TextFormField(
                  controller: nombreCtrl,
                  decoration: const InputDecoration(labelText: "Nombres"),
                  validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                ),
                TextFormField(
                  controller: apellidoCtrl,
                  decoration: const InputDecoration(labelText: "Apellidos"),
                  validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                ),
                DropdownButtonFormField<String>(
                  value: _tiposDocumento.contains(tipoDocumentoCtrl) ? tipoDocumentoCtrl : null,
                  items: _tiposDocumento.map((tipo) {
                    return DropdownMenuItem<String>(
                      value: tipo,
                      child: Text(tipo),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Tipo Documento',
                  ),
                  onChanged: (value) {
                    setState(() {
                      tipoDocumentoCtrl = value;
                    });
                  },
                  validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                ),
                TextFormField(
                  controller: numeroDocumentoCtrl,
                  decoration: const InputDecoration(labelText: "Número Documento"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Campo requerido';
                    if (!RegExp(r'^\d+$').hasMatch(value)) return 'Solo se permiten números';
                    return null;
                  },
                ),
                TextFormField(
                  controller: telefonoCtrl,
                  decoration: const InputDecoration(labelText: "Teléfono"),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Campo requerido';
                    if (!RegExp(r'^\d+$').hasMatch(value)) return 'Solo se permiten números';
                    return null;
                  },
                ),
                TextFormField(
                  controller: direccionCtrl,
                  decoration: const InputDecoration(labelText: "Dirección"),
                  validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                ),
                TextFormField(
                  controller: correoCtrl,
                  decoration: const InputDecoration(labelText: "Correo Electrónico"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Campo requerido';
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) return 'Correo electrónico no válido';
                    return null;
                  },
                ),
                TextFormField(
                  controller: fechaNacimientoCtrl,
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
                      setState(() {
                        fechaNacimientoCtrl.text = _formatter.format(fechaSeleccionada);
                      });
                    }
                  },
                  validator: (value) => value == null || value.isEmpty ? "Campo requerido" : null,
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await _pickImage(() => setState(() {}));
                        },
                        child: const Text("Seleccionar Imagen"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (_imagen == null)
                      const Text("Ninguna imagen seleccionada")
                    else
                      Center(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              _imagen!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Guardar cambios'),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}