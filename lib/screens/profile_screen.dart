import 'package:flutter/material.dart';
import 'package:travel/config/session.dart';
import 'package:travel/utils/dimensions_utils.dart';
import 'package:travel/utils/rgb_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLogin = false;
  bool isLoaded = false;
  Map sessionUser = {};

  @override
  void initState() {
    super.initState();
    initApp();
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? isLogin
            ? ListView(
                children: [
                  Container(
                    height: 120,
                    color: RGB.muted,
                  ),
                  Transform.translate(
                    offset: const Offset(0, -60),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(
                          Dimensions.smSize,
                        ),
                        decoration: BoxDecoration(
                          color: RGB.white,
                          border: Border.all(
                            width: 1,
                            color: RGB.border,
                          ),
                          borderRadius: BorderRadius.circular(
                            Dimensions.circleSize,
                          ),
                        ),
                        child: const Icon(
                          Icons.person,
                          size: Dimensions.avatarSize * 2,
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -50),
                    child: Column(
                      children: [
                        Text(
                          sessionUser['name'],
                          style: const TextStyle(
                            fontSize: Dimensions.lgSize,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.defaultSize,
                        ),
                        Text(
                          sessionUser['phone'],
                          style: const TextStyle(
                            fontSize: Dimensions.lgSize,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text('Please, login first!'),
              )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  // functional task
  void initApp() async {
    sessionUser = await Session().user();
    isLogin = await Session().isLogin();
    isLoaded = true;
    if (mounted) {
      setState(() {});
    }
  }
}
