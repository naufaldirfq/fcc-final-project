import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mekari_pixel/mekari_pixel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _profileBody(),
    );
  }

  Widget _profileBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 100
          ),
          const SizedBox(height: 32),
          Text("Jackie Mock", style: MpTextStyles.xl.semiBold,),
          const SizedBox(height: 8),
          const Text("jackie.mock@mekari.com", style: MpTextStyles.sm),
          const SizedBox(height: 8),
          const Text("Balance IDR 3.000.000", style: MpTextStyles.sm,)
        ],
      ),
    );
  }
}
