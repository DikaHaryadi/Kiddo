import 'package:flutter/material.dart';
import 'package:textspeech/auth/controller/user/network_manager.dart';
import 'package:textspeech/interface/mobile/home_mobile_screen.dart';
import 'package:textspeech/interface/tablet/home_tablet_screen.dart';

import '../util/etc/responsive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfcf4f1),
      body: RefreshIndicator(
        onRefresh: () => _onRefresh(),
        child: SafeArea(
            child: isMobile(context)
                ? const HomeMobileScreem()
                : const HomeTabletScreen()),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await NetworkManager.instance.refreshConnectionStatus();
  }
}
