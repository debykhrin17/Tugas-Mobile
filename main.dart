
import 'package:flutter/material.dart';

void main() => runApp(const PerpusApp());

class PerpusApp extends StatelessWidget {
  const PerpusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perpustakaan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ), 
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String cari = '';

  final List<Map<String, dynamic>> buku = [
    {'judul': 'Laskar Pelangi', 'pengarang': 'Andrea Hirata', 'tahun': 2005, 'rating': 4.8, 'tersedia': true},
    {'judul': 'Bumi', 'pengarang': 'Tere Liye', 'tahun': 2014, 'rating': 4.6, 'tersedia': true},
    {'judul': 'Dilan 1990', 'pengarang': 'Pidi Baiq', 'tahun': 2014, 'rating': 4.0, 'tersedia': false},
    {'judul': 'Negeri 5 Menara', 'pengarang': 'Ahmad Fuadi', 'tahun': 2009, 'rating': 4.3, 'tersedia': true},
    {'judul': 'Filosofi Teras', 'pengarang': 'Henry Manampiring', 'tahun': 2018, 'rating': 4.7, 'tersedia': false},
    {'judul': 'Perahu Kertas', 'pengarang': 'Dee Lestari', 'tahun': 2009, 'rating': 3.8, 'tersedia': true},
  ];

  @override
  Widget build(BuildContext context) {
    final hasil = buku
        .where((b) => b['judul'].toLowerCase().contains(cari.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('📚 Perpustakaan'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (v) => setState(() => cari = v),
              decoration: InputDecoration(
                hintText: 'Cari buku...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.blue.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: hasil.isEmpty
                ? const Center(child: Text('Buku tidak ditemukan'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: hasil.length,
                    itemBuilder: (context, index) {
                      final b = hasil[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailPage(buku: b),
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: const Icon(Icons.book, color: Colors.white),
                          ),
                          title: Text(
                            b['judul'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          subtitle: Text(
                            '${b['pengarang']} • ${b['tahun']}\n'
                            '⭐ ${b['rating']}',
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: b['tersedia']
                                  ? Colors.green.shade100
                                  : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              b['tersedia'] ? 'Tersedia' : 'Dipinjam',
                              style: TextStyle(
                                color: b['tersedia']
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> buku;

  const DetailPage({super.key, required this.buku});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? catatanPeminjam;

  @override
  Widget build(BuildContext context) {
    final b = widget.buku;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Buku'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.menu_book,
                        size: 45, color: Colors.white),
                  ),
                  const SizedBox(height: 15),

                  Text(
                    b['judul'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 15),
                  Text('Pengarang : ${b['pengarang']}'),
                  Text('Tahun : ${b['tahun']}'),
                  Text('Rating : ⭐ ${b['rating']}'),

                  const SizedBox(height: 10),

                  Text(
                    b['tersedia'] ? 'Tersedia' : 'Sedang Dipinjam',
                    style: TextStyle(
                      color: b['tersedia'] ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const Divider(height: 30),

                  Text(
                    catatanPeminjam ?? '(Tidak ada catatan)',
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          catatanPeminjam = b['tersedia']
                              ? 'Buku sedang dipinjam'
                              : 'Buku sudah dikembalikan';
                          b['tersedia'] = !b['tersedia'];
                        });
                      },
                      icon: Icon(
                        b['tersedia'] ? Icons.bookmark : Icons.undo,
                      ),
                      label: Text(
                        b['tersedia'] ? 'Pinjam Buku' : 'Kembalikan Buku',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: b['tersedia']
                            ? Colors.red
                            : Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

