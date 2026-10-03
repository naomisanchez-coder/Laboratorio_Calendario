import 'package:flutter/material.dart';

void main() {
  runApp(const MiCalendarioApp());
}

class MiCalendarioApp extends StatelessWidget {
  const MiCalendarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calendario Flutter Pro',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF181528),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8B5CF6),
          secondary: Color(0xFFEC4899),
        ),
      ),
      home: const CalendarioPage(),
    );
  }
}

class CalendarioPage extends StatefulWidget {
  const CalendarioPage({super.key});

  @override
  State<CalendarioPage> createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  DateTime _fechaActual = DateTime(2026, 5, 22);
  String _vistaSeleccionada = 'Mes'; // 'Día', 'Semana', 'Mes'

  final List<String> _meses = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
  ];

  void _cambiarMes(int incremento) {
    setState(() {
      _fechaActual = DateTime(_fechaActual.year, _fechaActual.month + incremento, 1);
    });
  }

  void _mostrarDialogoNuevoEvento() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF231F3D),
        title: const Text('Nuevo Evento', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Título del evento',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF181528),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Hora (ej. 10:00 AM)',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF181528),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8B5CF6),
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('¡Evento agregado con éxito!'),
                  backgroundColor: Color(0xFF8B5CF6),
                ),
              );
            },
            child: const Text('Guardar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _mostrarDialogoNuevoEvento,
        backgroundColor: const Color(0xFF8B5CF6),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Nuevo Evento', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 550),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildViewSelector(),
                const SizedBox(height: 20),

                _buildHeader(),
                const SizedBox(height: 20),

                if (_vistaSeleccionada == 'Mes') ...[
                  _buildDaysOfWeekHeader(),
                  const SizedBox(height: 12),
                  _buildCalendarGrid(),
                ] else if (_vistaSeleccionada == 'Semana') ...[
                  _buildWeekScheduleView(),
                ] else ...[
                  _buildDayScheduleView(),
                ],

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Agenda del Mes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '3 Eventos',
                        style: TextStyle(color: Color(0xFFA78BFA), fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                _buildEventCard(
                  dia: '05',
                  titulo: 'Campaña de Salud',
                  hora: '08:00 AM - 11:00 AM',
                  categoria: 'Salud',
                  colorCategoria: const Color(0xFF10B981),
                  icono: Icons.health_and_safety_rounded,
                ),
                _buildEventCard(
                  dia: '12',
                  titulo: 'Examen de Programación',
                  hora: '09:00 AM - 11:00 AM',
                  categoria: 'Estudio',
                  colorCategoria: const Color(0xFFEC4899),
                  icono: Icons.code_rounded,
                ),
                _buildEventCard(
                  dia: '22',
                  titulo: 'Reunión con el Equipo',
                  hora: '02:00 PM - 03:30 PM',
                  categoria: 'Trabajo',
                  colorCategoria: const Color(0xFF3B82F6),
                  icono: Icons.groups_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewSelector() {
    final opciones = ['Día', 'Semana', 'Mes'];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF231F3D),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: opciones.map((opcion) {
          final esSeleccionado = _vistaSeleccionada == opcion;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _vistaSeleccionada = opcion;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: esSeleccionado ? const Color(0xFF8B5CF6) : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  opcion,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: esSeleccionado ? Colors.white : Colors.white54,
                    fontWeight: esSeleccionado ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildHeader() {
    final nombreMes = _meses[_fechaActual.month - 1];
    final anio = _fechaActual.year;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$nombreMes $anio',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Vista: $_vistaSeleccionada',
              style: const TextStyle(fontSize: 13, color: Color(0xFFA78BFA)),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Colors.white70),
              onPressed: () => _cambiarMes(-1),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.white70),
              onPressed: () => _cambiarMes(1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDaysOfWeekHeader() {
    final dias = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: dias
          .map((dia) => SizedBox(
                width: 40,
                child: Text(
                  dia,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    final primerDiaMes = DateTime(_fechaActual.year, _fechaActual.month, 1);
    final diasEnMes = DateTime(_fechaActual.year, _fechaActual.month + 1, 0).day;
    int diaInicio = primerDiaMes.weekday;
    final mesAnteriorFin = DateTime(_fechaActual.year, _fechaActual.month, 0).day;

    List<List<Map<String, dynamic>>> semanas = [];
    List<Map<String, dynamic>> semanaActual = [];

    for (int i = diaInicio - 2; i >= 0; i--) {
      semanaActual.add({'numero': '${mesAnteriorFin - i}', 'esOtroMes': true});
    }

    for (int dia = 1; dia <= diasEnMes; dia++) {
      bool esDestacado = (dia == 22 && _fechaActual.month == 5);
      bool tieneEvento = ((dia == 5 || dia == 12) && _fechaActual.month == 5);

      semanaActual.add({
        'numero': '$dia',
        'esOtroMes': false,
        'destacado': esDestacado,
        'evento': tieneEvento,
      });

      if (semanaActual.length == 7) {
        semanas.add(semanaActual);
        semanaActual = [];
      }
    }

    int diaSiguiente = 1;
    while (semanaActual.isNotEmpty && semanaActual.length < 7) {
      semanaActual.add({'numero': '$diaSiguiente', 'esOtroMes': true});
      diaSiguiente++;
    }
    if (semanaActual.isNotEmpty) semanas.add(semanaActual);

    return Column(
      children: semanas.map((semana) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: semana.map((dia) => _buildDayCell(dia)).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDayCell(Map<String, dynamic> dia) {
    final bool esOtroMes = dia['esOtroMes'] ?? false;
    final bool destacado = dia['destacado'] ?? false;
    final bool evento = dia['evento'] ?? false;

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: destacado
            ? const Color(0xFFEC4899)
            : (evento ? const Color(0xFF8B5CF6).withOpacity(0.3) : Colors.transparent),
        shape: BoxShape.circle,
        border: destacado
            ? Border.all(color: Colors.white, width: 2)
            : (evento ? Border.all(color: const Color(0xFFA78BFA), width: 1.5) : null),
      ),
      child: Center(
        child: Text(
          dia['numero'],
          style: TextStyle(
            color: esOtroMes
                ? Colors.white24
                : (destacado ? Colors.white : Colors.white),
            fontWeight: destacado ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildWeekScheduleView() {
    final diasSemana = [
      {'dia': 'Lun 22', 'evento': 'Campaña Salud', 'color': const Color(0xFF10B981)},
      {'dia': 'Mar 23', 'evento': 'Examen Prog.', 'color': const Color(0xFFEC4899)},
      {'dia': 'Mié 24', 'evento': 'Reunión', 'color': const Color(0xFF3B82F6)},
      {'dia': 'Jue 25', 'evento': 'Taller Flutter', 'color': const Color(0xFF8B5CF6)},
      {'dia': 'Vie 26', 'evento': 'Libre', 'color': Colors.transparent},
      {'dia': 'Sáb 27', 'evento': 'Libre', 'color': Colors.transparent},
      {'dia': 'Dom 28', 'evento': 'Libre', 'color': Colors.transparent},
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF231F3D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('22 - 28 de Mayo de 2026', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white70)),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: diasSemana.map((d) {
                final tieneEvento = d['color'] != Colors.transparent;
                return Container(
                  width: 90,
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF181528),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: tieneEvento ? (d['color'] as Color) : Colors.white10,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(d['dia'] as String, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: (d['color'] as Color).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          d['evento'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: tieneEvento ? (d['color'] as Color) : Colors.white30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayScheduleView() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF231F3D),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Viernes, 22 de Mayo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 15),
          _buildHourlyRow('08:00 AM', 'Campaña de Salud', const Color(0xFF10B981)),
          _buildHourlyRow('10:00 AM', 'Libre', Colors.transparent),
          _buildHourlyRow('02:00 PM', 'Reunión de equipo', const Color(0xFF3B82F6)),
          _buildHourlyRow('04:00 PM', 'Estudio de Flutter', const Color(0xFF8B5CF6)),
        ],
      ),
    );
  }

  Widget _buildHourlyRow(String hora, String actividad, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(width: 70, child: Text(hora, style: const TextStyle(color: Colors.white54, fontSize: 12))),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color == Colors.transparent ? const Color(0xFF181528) : color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: color == Colors.transparent ? Colors.white10 : color),
              ),
              child: Text(actividad, style: TextStyle(color: color == Colors.transparent ? Colors.white30 : Colors.white, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard({
    required String dia,
    required String titulo,
    required String hora,
    required String categoria,
    required Color colorCategoria,
    required IconData icono,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF231F3D),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorCategoria.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorCategoria.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icono, color: colorCategoria, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: colorCategoria.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        categoria,
                        style: TextStyle(fontSize: 10, color: colorCategoria, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.access_time_rounded, size: 14, color: Colors.white54),
                    const SizedBox(width: 4),
                    Text(
                      '$dia de mayo • $hora',
                      style: const TextStyle(fontSize: 12, color: Colors.white54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}