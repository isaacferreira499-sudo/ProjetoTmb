import 'package:flutter/material.dart';

void main() {
  runApp(const TMBPage());
}



class TMBPage extends StatefulWidget {
  const TMBPage({super.key});

  @override
  State<TMBPage> createState() => _TMBPageState();
}

class _TMBPageState extends State<TMBPage> {
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  String genero = 'Masculino';
  String nivelAtividade = 'Sedentário';
  double resultado = 0;

  final Map<String, double> fatoresAtividade = {
    'Sedentário': 1.2,
    'Levemente ativo': 1.375,
    'Moderadamente ativo': 1.55,
    'Muito ativo': 1.725,
    'Extremamente ativo': 1.9,
  };

  void calcularTMB() {
    double idade = double.tryParse(idadeController.text) ?? 0;
    double peso = double.tryParse(pesoController.text) ?? 0;
    double altura = double.tryParse(alturaController.text) ?? 0;

    double fator = fatoresAtividade[nivelAtividade]!;

    double tmb;

    if (genero == 'Masculino') {
      tmb = fator *
          (66 + (13.7 * peso) + (5 * altura) - (6.8 * idade));
    } else {
      tmb = fator *
          (655 + (9.6 * peso) + (1.8 * altura) - (4.7 * idade));
    }

    setState(() {
      resultado = tmb;
    });
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora TMB'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextField('Idade', idadeController),
            const SizedBox(height: 10),
            buildTextField('Peso (kg)', pesoController),
            const SizedBox(height: 10),
            buildTextField('Altura (cm)', alturaController),

            const SizedBox(height: 20),

            Row(
              children: [
                const Text('Gênero:'),
                Radio(
                  value: 'Masculino',
                  // ignore: deprecated_member_use
                  groupValue: genero,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      genero = value!;
                    });
                  },
                ),
                const Text('Masculino'),
                Radio(
                  value: 'Feminino',
                  // ignore: deprecated_member_use
                  groupValue: genero,
                  // ignore: deprecated_member_use
                  onChanged: (value) {
                    setState(() {
                      genero = value!;
                    });
                  },
                ),
                const Text('Feminino'),
              ],
            ),

            const SizedBox(height: 10),

            DropdownButton<String>(
              value: nivelAtividade,
              isExpanded: true,
              items: fatoresAtividade.keys.map((String nivel) {
                return DropdownMenuItem(
                  value: nivel,
                  child: Text(nivel),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  nivelAtividade = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: calcularTMB,
              child: const Text('Calcular'),
            ),

            const SizedBox(height: 20),

            Text(
              'Resultado: ${resultado.toStringAsFixed(2)} kcal/dia',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}