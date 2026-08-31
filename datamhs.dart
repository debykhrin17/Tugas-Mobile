import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

Map<String, dynamic> mahasiswa = {
  'deby karina': [[85, 90, 78, 92, 88], 2],
  'farel zid': [[55, 60, 58, 52, 45], 2],
  'anggan yunanda': [[70, 75, 68, 72, 80], 1],
  'james bond': [[60, 65, 70, 58, 62], 3],
  'tobey maguaire': [[75, 80, 85, 78, 82], 2],
};

double hitungRataRata(List<int> nilai) {
  return nilai.reduce((a, b) => a + b) / nilai.length;
}

String tentukanGrade(double rata) {
  if (rata >= 85) return 'A';
  if (rata >= 75) return 'B';
  if (rata >= 65) return 'C';
  if (rata >= 60) return 'D';
  return 'E';
}

bool cekKelulusan(double rata, int absensi) {
  return rata >= 60 && absensi <= 3;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 Nilai Mahasiswa'),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [

          for (var data in mahasiswa.entries)
            Card(
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),

                title: Text(
                  data.key,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Builder(
                  builder: (context) {

                    List<int> nilai = data.value[0];
                    int absensi = data.value[1];

                    double rata = hitungRataRata(nilai);
                    String grade = tentukanGrade(rata);

                    bool lulus = cekKelulusan(
                      rata,
                      absensi,
                    );

                    return Text(
                      'Rata-rata: ${rata.toStringAsFixed(1)} | '
                      'Grade: $grade\n'
                      'Absensi: $absensi | '
                      '${lulus ? "✅ LULUS" : "❌ TIDAK LULUS"}',
                    );
                  },
                ),
              ),
            ),

          const SizedBox(height: 10),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '📊 STATISTIK KELAS\n\n'
                'Nilai Tertinggi : 92\n'
                'Nilai Terendah  : 45\n'
                'Rata-rata Kelas : 73.2',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}