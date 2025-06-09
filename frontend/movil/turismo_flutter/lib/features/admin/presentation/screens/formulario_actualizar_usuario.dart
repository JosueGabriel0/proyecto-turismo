import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_dto.dart';
import 'package:turismo_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_bloc.dart';
import 'package:turismo_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_event.dart';

class FormularioActualizarUsuario extends StatefulWidget {
  final UsuarioCompletoResponse usuario;

  const FormularioActualizarUsuario({super.key, required this.usuario});

  @override
  State<FormularioActualizarUsuario> createState() => _FormularioActualizarUsuarioState();
}

class _FormularioActualizarUsuarioState extends State<FormularioActualizarUsuario> {
  late final TextEditingController nombreCtrl;
  late final TextEditingController apellidoCtrl;
  late final TextEditingController correoCtrl;
  late final TextEditingController telefonoCtrl;

  @override
  void initState() {
    super.initState();
    nombreCtrl = TextEditingController(text: widget.usuario.persona?.nombres ?? '');
    apellidoCtrl = TextEditingController(text: widget.usuario.persona?.apellidos ?? '');
    correoCtrl = TextEditingController(text: widget.usuario.persona?.correoElectronico ?? '');
    telefonoCtrl = TextEditingController(text: widget.usuario.persona?.telefono ?? '');
  }

  @override
  void dispose() {
    nombreCtrl.dispose();
    apellidoCtrl.dispose();
    correoCtrl.dispose();
    telefonoCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final dto = UsuarioCompletoDto(
      username: widget.usuario.username ?? '',
      password: widget.usuario.password ?? '',
      estadoCuenta: widget.usuario.estado ?? '',
      nombreRol: widget.usuario.rol?.nombre ?? '',
      nombreEmprendimiento: widget.usuario.emprendimiento?.nombre ?? '',
      nombres: nombreCtrl.text,
      apellidos: apellidoCtrl.text,
      tipoDocumento: widget.usuario.persona?.tipoDocumento ?? '',
      numeroDocumento: widget.usuario.persona?.numeroDocumento ?? '',
      telefono: telefonoCtrl.text,
      direccion: widget.usuario.persona?.direccion ?? '',
      correoElectronico: correoCtrl.text,
      fechaNacimiento: widget.usuario.persona?.fechaNacimiento ?? '',
    );

    context.read<UsuarioBloc>().add(
      UpdateUsuarioEvent(widget.usuario.idUsuario, dto, null),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        runSpacing: 16,
        children: [
          TextFormField(controller: nombreCtrl, decoration: const InputDecoration(labelText: 'Nombres')),
          TextFormField(controller: apellidoCtrl, decoration: const InputDecoration(labelText: 'Apellidos')),
          TextFormField(controller: correoCtrl, decoration: const InputDecoration(labelText: 'Correo')),
          TextFormField(controller: telefonoCtrl, decoration: const InputDecoration(labelText: 'Teléfono')),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _submit, child: const Text('Guardar cambios')),
        ],
      ),
    );
  }
}