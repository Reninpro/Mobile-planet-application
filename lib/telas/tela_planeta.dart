import 'package:flutter/material.dart';

import '../controles/controle_planeta.dart';
import '../modelo/planeta.dart';

class TelaPlaneta extends StatefulWidget {
  final bool isIncluir;
  final Planeta planeta;
  final Function() onFinalizado;

  const TelaPlaneta({
    super.key,
    required this.isIncluir,
    required this.planeta,
    required this.onFinalizado,
  });

  @override
  State<TelaPlaneta> createState() => _TelaPlanetaState();
}

class _TelaPlanetaState extends State<TelaPlaneta> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  late Planeta _planeta;

  final ControlePlaneta _controlePlaneta = ControlePlaneta();

  @override
  void initState() {
    _planeta = widget.planeta;
    _nameController.text = _planeta.name;
    _distanceController.text = _planeta.distance.toString();
    _sizeController.text = _planeta.size.toString();
    _nicknameController.text = _planeta.nickname ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _distanceController.dispose();
    _sizeController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _inserirPlaneta() async {
    _controlePlaneta.inserirPlaneta(_planeta);
  }

  Future<void> _atualizarPlaneta() async {
    _controlePlaneta.atualizarPlaneta(_planeta);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (widget.isIncluir) {
        _inserirPlaneta();
      } else {
        _atualizarPlaneta();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Os dados do planeta foram ${widget.isIncluir ? 'incluidos' : 'alterados'} com sucesso!')),
      );
    }
    Navigator.of(context).pop();
    widget.onFinalizado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text('Cadastrar planeta'),
        ),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          side: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Nome',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um nome';
                      }
                      if (value.length < 3) {
                        return 'O nome do planeta tem que ter no minimo 3 letras';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _planeta.name = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: TextFormField(
                    controller: _distanceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Distância',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira uma distância';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Por favor, insira um número válido';
                      }
                      if (double.parse(value) <= 0.0) {
                        return 'Por favor, insira um número maior que zero';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _planeta.distance = double.parse(value!);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextFormField(
                    controller: _sizeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Tamanho (Em Km)',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira um size';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Por favor, insira um número válido';
                      }
                      if (double.parse(value) <= 0.0) {
                        return 'Por favor, insira um número maior que zero';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _planeta.size = double.parse(value!);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextFormField(
                    controller: _nicknameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Apelido',
                    ),
                    onSaved: (value) {
                      _planeta.nickname = value;
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Salvar', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Voltar', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
