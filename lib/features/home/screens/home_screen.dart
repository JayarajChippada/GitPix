import 'package:flutter/material.dart';
import 'package:gitpix/features/home/screens/bookmark_screen.dart';
import 'package:gitpix/features/home/widgets/gallery_tab.dart';
import 'package:gitpix/features/home/widgets/repo_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [RepoTab(), GalleryTab()];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/gitpix3.jpg',
                height: 20,
                width: 20,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              'GitPix',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            )
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              Navigator.pushNamed(
                context, 
                BookmarkScreen.routeName,
              );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.code), label: 'Repo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_library), label: 'Gallery'),
        ],
      ),
    );
  }
}
