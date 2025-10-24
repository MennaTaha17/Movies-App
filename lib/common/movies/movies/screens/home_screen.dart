import 'dart:ui';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // قائمة الأفلام للصف الأول والثالث
  final List<String> centerMoviesTopRow = const [
    "assets/movies/movie1.jpg",
    "assets/movies/1917-bg.jpg",
    "assets/movies/movie2.jpg",
  ];

  // قائمة الأفلام للصف الثاني
  final List<String> centerMoviesBottomRow = const [
    "assets/movies/movie4.jpg",
    "assets/movies/movie3.jpg",
    "assets/movies/movie1.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // 1. الخلفية مع التمويه (Blur)
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/movies/1917-bg.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                // تصحيح: استخدام قيمة الشفافية الستعشرية لإزالة التحذير
                color: const Color(0x4D000000),
              ),
            ),
          ),

          // 2. المحتوى الرئيسي القابل للتمرير عموديًا
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50 + 20),

                // -------------------------
                // نص "Available Now" (الصف الأول)
                // -------------------------
                const Center(
                  child: Text(
                    "Available Now",
                    style: TextStyle(
                      fontFamily: "DancingScript",
                      fontSize: 48,
                      color: Colors.white,
                      shadows: [
                        Shadow(color: Colors.black87, blurRadius: 10, offset: Offset(2, 2)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // -------------------------
                // الصف الأول من الأفلام (قابل للتمرير أفقيًا)
                // -------------------------
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _buildCenterMovieRow(
                    leftImg: centerMoviesTopRow[0],
                    centerImg: centerMoviesTopRow[1],
                    rightImg: centerMoviesTopRow[2],
                  ),
                ),

                const SizedBox(height: 30),

                // -------------------------
                // نص "Watch Now" (الصف الثاني)
                // -------------------------
                const Center(
                  child: Text(
                    "Watch Now",
                    style: TextStyle(
                      fontFamily: "DancingScript",
                      fontSize: 48,
                      color: Colors.white,
                      shadows: [
                        Shadow(color: Colors.black87, blurRadius: 10, offset: Offset(2, 2)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // -------------------------
                // الصف الثاني من الأفلام (قابل للتمرير أفقيًا)
                // -------------------------
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _buildCenterMovieRow(
                    leftImg: centerMoviesBottomRow[0],
                    centerImg: centerMoviesBottomRow[1],
                    rightImg: centerMoviesBottomRow[2],
                  ),
                ),

                const SizedBox(height: 30), // فاصل جديد

                // -------------------------
                // نص "Recommended" (الصف الثالث)
                // -------------------------
                const Center(
                  child: Text(
                    "Recommended",
                    style: TextStyle(
                      fontFamily: "DancingScript",
                      fontSize: 48,
                      color: Colors.white,
                      shadows: [
                        Shadow(color: Colors.black87, blurRadius: 10, offset: Offset(2, 2)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // -------------------------
                // الصف الثالث من الأفلام (مكرر) - قابل للتمرير أفقيًا
                // -------------------------
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _buildCenterMovieRow(
                    leftImg: centerMoviesTopRow[0], // إعادة استخدام صور الصف الأول
                    centerImg: centerMoviesTopRow[1],
                    rightImg: centerMoviesTopRow[2],
                  ),
                ),

                // مسافة لمنع المحتوى من الاختفاء خلف شريط التنقل السفلي
                SizedBox(height: kBottomNavigationBarHeight + bottomPadding + 50),
              ],
            ),
          ),

          // 3. شريط التنقل السفلي مع تأثير الضبابية
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: BottomNavigationBar(
                  // تصحيح: استخدام قيمة الشفافية الستعشرية لإزالة التحذير
                  backgroundColor: const Color(0x80000000),
                  selectedItemColor: Colors.amber,
                  unselectedItemColor: Colors.white70,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
                    BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
                    BottomNavigationBarItem(icon: Icon(Icons.compass_calibration), label: ""),
                    BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------
  // دالة مساعدة لإنشاء صف الأفلام المركزي المتكرر
  // ----------------------------------------------------
  Widget _buildCenterMovieRow({
    required String leftImg,
    required String centerImg,
    required String rightImg,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // الفيلم الجانبي الأيسر
        _moviePoster(
          leftImg,
          width: 120,
          height: 180,
          rate: "7.7",
        ),
        // الفيلم الرئيسي في المنتصف (أكبر حجماً)
        _moviePoster(
          centerImg,
          width: 180,
          height: 270,
          rate: "7.7",
          showDetails: true,
        ),
        // الفيلم الجانبي الأيمن
        _moviePoster(
          rightImg,
          width: 120,
          height: 180,
          rate: "7.7",
        ),
      ],
    );
  }

  // ----------------------------------------------------
  // Movie Poster Widget
  // ----------------------------------------------------
  Widget _moviePoster(String img, {double width = 120, double height = 180, String? rate, bool showDetails = false}) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // شارة التقييم
          if (rate != null)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  // تصحيح: استخدام قيمة الشفافية الستعشرية لإزالة التحذير
                  color: const Color(0xB3000000),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      rate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(Icons.star, color: Colors.amber, size: 14),
                  ],
                ),
              ),
            ),

          // نص تفصيلي "TIME IS THE ENEMY"
          if (showDetails)
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "TIME IS THE ENEMY",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}