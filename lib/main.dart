import 'package:flutter/material.dart';

void main() {
  runApp(const MiniKatalogApp());
}

// --- VERİ MODELİ VE LİSTELER ---
class Product {
  final String name;
  final String brand;
  final double price;
  final String description;
  final IconData icon;
  final Color bgColor;

  Product({
    required this.name,
    required this.brand,
    required this.price,
    required this.description,
    required this.icon,
    required this.bgColor,
  });
}

// TAMAMEN YENİLENMİŞ, TEKNOLOJİ ODAKLI ÜRÜN LİSTEMİZ
final List<Product> dummyProducts = [
  Product(
    name: 'Intel Core Ultra 9 285K',
    brand: 'Intel',
    price: 24999.0,
    description:
        'Render ve üst düzey PC performansı için sınırları zorlayan yeni nesil amiral gemisi işlemci.',
    icon: Icons.memory,
    bgColor: const Color(0xFFBBDEFB), // İntel Mavisi
  ),
  Product(
    name: 'Galaxy Book4 Pro',
    brand: 'Samsung',
    price: 59999.0,
    description:
        'Windows ile kusursuz entegrasyon sağlayan, hafif ve güçlü mobil ekosistem bilgisayarı.',
    icon: Icons.laptop_windows,
    bgColor: const Color(0xFFCFD8DC), // Gümüş/Gri
  ),
  Product(
    name: 'Avatto Matter Akıllı Röle',
    brand: 'Avatto',
    price: 899.0,
    description:
        'Home Assistant ve diğer platformlarla tam uyumlu, akıllı ev otomasyonu için Matter destekli cihaz.',
    icon: Icons.toggle_on,
    bgColor: const Color(0xFFC8E6C9), // Yeşil tonu
  ),
  Product(
    name: 'Raspberry Pi 5 (8GB)',
    brand: 'Raspberry Pi',
    price: 3499.0,
    description:
        'Kendi akıllı ev sunucunuzu kurmak veya özel projeler geliştirmek için ideal mini bilgisayar.',
    icon: Icons.developer_board,
    bgColor: const Color(0xFFFFCDD2), // Kırmızı/Ahududu tonu
  ),
];

List<Product> sepet = [];

// --- ANA UYGULAMA ÇATISI ---
class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Katalog',
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: const KesfetEkrani(),
    );
  }
}

// --- 1. ANA EKRAN (KEŞFET) ---
class KesfetEkrani extends StatefulWidget {
  const KesfetEkrani({super.key});

  @override
  State<KesfetEkrani> createState() => _KesfetEkraniState();
}

class _KesfetEkraniState extends State<KesfetEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Keşfet',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Badge(
              label: Text(sepet.length.toString()),
              isLabelVisible: sepet.isNotEmpty,
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SepetEkrani()),
              ).then((value) {
                setState(() {});
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mükemmel donanımını bul',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 10),
                  Text(
                    'Ürünlerde ara...',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // BANNER KISMI
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://hatali-link-bilerek-koydum-yedek-calissin.com/banner.png',
                width: double.infinity,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade900, Colors.blue.shade500],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '🎁 HAFTANIN FIRSATLARI',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Öne Çıkan Donanımlar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: dummyProducts.length,
                itemBuilder: (context, index) {
                  return UrunKarti(product: dummyProducts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2. ÜRÜN KARTI ---
class UrunKarti extends StatelessWidget {
  final Product product;
  const UrunKarti({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UrunDetayEkrani(product: product),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: product.bgColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Icon(product.icon, size: 50, color: Colors.black54),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.brand,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₺${product.price}',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 3. ÜRÜN DETAY EKRANI ---
class UrunDetayEkrani extends StatelessWidget {
  final Product product;
  const UrunDetayEkrani({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(product.name, style: const TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: product.bgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(product.icon, size: 120, color: Colors.black54),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '₺${product.price}',
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Teknik Özellikler',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  sepet.add(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} sepete eklendi!'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text(
                  'Sepete Ekle',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 4. SEPET EKRANI ---
class SepetEkrani extends StatefulWidget {
  const SepetEkrani({super.key});

  @override
  State<SepetEkrani> createState() => _SepetEkraniState();
}

class _SepetEkraniState extends State<SepetEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Sepetim', style: TextStyle(color: Colors.black)),
      ),
      body: sepet.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Sepetiniz şu an boş',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: sepet.length,
                    itemBuilder: (context, index) {
                      final item = sepet[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: item.bgColor,
                          child: Icon(item.icon, color: Colors.black54),
                        ),
                        title: Text(
                          item.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('₺${item.price}'),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              sepet.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sipariş başarıyla tamamlandı! 🚀'),
                          ),
                        );
                        setState(() {
                          sepet.clear();
                        });
                      },
                      child: const Text(
                        'Siparişi Tamamla',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
