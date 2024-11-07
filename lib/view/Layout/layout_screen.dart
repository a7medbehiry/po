
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/view/stores/stores_screen.dart';

import '../../components/constant.dart';
import '../clinics/clinic_screen.dart';
import '../find_pet/find_pet_screen.dart';
import '../home/home_screen.dart';
import '../market/market_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {

  int _selectedIndex=3;
  int indexhome=4;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      indexhome=index;
    });
  }

  void _onFabPressed() {
    setState(() {
      indexhome = 4; // Set this to the index of the home screen
    });
  }

  // int index = 0;
  List<Widget>screens=[
    StoresScreen(),
    ClinicScreen(),
    FindPetScreen(),
    MarketScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: indexhome != 4 ? screens[_selectedIndex]: HomeScreen(),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: primaryColor,

        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust the vertical padding as needed
              child: ImageIcon(
                AssetImage('assets/images/l1.png'),
              ),
            ),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust the vertical padding as needed
              child: ImageIcon(
                AssetImage('assets/images/l2.png'),
              ),
            ),
            label: 'Clinics',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust the vertical padding as needed
              child: ImageIcon(
                AssetImage('assets/images/l4.png'), // You might want to use a different image for variety
              ),
            ),
            label: 'Find Pet',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust the vertical padding as needed
              child: ImageIcon(
                AssetImage('assets/images/l5.png'),
              ),
            ),
            label: 'Market',
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        elevation: 5,
        backgroundColor: primaryColor,
        onPressed: () {
          _onFabPressed();
          //Navigator.push(context, MaterialPageRoute(builder: (context)=>StatisticsScreen()));
        },
        child: Image.asset('assets/images/l3.png'),
      ),

    );


  }
}
