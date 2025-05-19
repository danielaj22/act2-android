import 'package:flutter/material.dart';

void main() {
  runApp(SmartHomeApp());
}

class SmartHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sans',
        scaffoldBackgroundColor: Color(0xFFF8F7FD),
      ),
      home: HomeScreen(),
    );
  }
}

// =================== HOME SCREEN ===================
class HomeScreen extends StatelessWidget {
  final Color purple = Color.fromARGB(255, 138, 137, 141);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.menu, color: Colors.black), onPressed: () {})
        ],
        title: Text('HI Dany', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Image.network(
                    'https://raw.githubusercontent.com/danielaj22/tatuajes_imagens_app_flutter/refs/heads/main/este.jpg',
                    height: 180)),
            SizedBox(height: 20),
            Center(
              child: Text('Categorias',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ),
            SizedBox(height: 30),
            Text('SERVICES',
                style: TextStyle(
                    fontSize: 14, color: Colors.grey[600], letterSpacing: 1.2)),
            SizedBox(height: 15),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  _buildServiceCard(
                      Icons.water_drop, 'TINTAS', Colors.white),
                  _buildServiceCard(Icons.brunch_dining_outlined, 'AGUJAS', purple,
                      onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => TemperatureScreen()),
                    );
                  }),
                  _buildServiceCard(Icons.brush, 'MAQUINAS', Colors.white),
                  _buildServiceCard(Icons.create_new_folder_rounded, 'CUIDADOS', Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(IconData icon, String label, Color bgColor,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: bgColor == Colors.white
              ? [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 5,
                      spreadRadius: 2)
                ]
              : [],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 32,
                  color: bgColor == Colors.white
                      ? Colors.black54
                      : Colors.white),
              SizedBox(height: 10),
              Text(label,
                  style: TextStyle(
                    color: bgColor == Colors.white
                        ? Colors.black87
                        : Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

// =================== TEMPERATURE SCREEN ===================
class TemperatureScreen extends StatefulWidget {
  @override
  _TemperatureScreenState createState() => _TemperatureScreenState();
}

class _TemperatureScreenState extends State<TemperatureScreen> {
  double heating = 15;
  double fanSpeed = 1;

  @override
  Widget build(BuildContext context) {
    final Color purple = Color.fromARGB(255, 118, 116, 126);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        actions: [
          IconButton(icon: Icon(Icons.menu, color: Colors.black), onPressed: () {})
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 10),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CircularProgressIndicator(
                    value: 0.86,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(purple),
                  ),
                ),
                Text("26°", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 10),
            Text("TEMPERATURE", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabButton("GENERAL", true, purple),
                SizedBox(width: 10),
                _buildTabButton("SERVICES", false, purple),
              ],
            ),
            SizedBox(height: 30),
            _buildSlider("HEATING", heating, 0, 30,
                (val) => setState(() => heating = val)),
            SizedBox(height: 20),
            _buildSlider("FAN SPEED", fanSpeed, 0, 2,
                (val) => setState(() => fanSpeed = val),
                labels: ["LOW", "MID", "HIGH"]),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  List.generate(3, (i) => _buildFanButton(i + 1, i == 1, purple)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, bool active, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      decoration: BoxDecoration(
        color: active ? color : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: active ? Colors.white : color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSlider(String title, double value, double min, double max,
      ValueChanged<double> onChanged,
      {List<String>? labels}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold)),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: labels != null ? labels.length - 1 : null,
          label: labels != null ? labels[value.round()] : value.toStringAsFixed(0),
          onChanged: onChanged,
          activeColor: Color.fromARGB(255, 137, 136, 141),
        ),
      ],
    );
  }

  Widget _buildFanButton(int num, bool selected, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: selected ? color : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: selected
                ? []
                : [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
          ),
          child: Icon(Icons.toys,
              color: selected ? Colors.white : Colors.black54),
        ),
        SizedBox(height: 8),
        Text('FAN $num'),
      ],
    );
  }
}