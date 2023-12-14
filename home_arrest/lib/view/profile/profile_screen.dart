import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:home_arrest/global_widgets/global_scaffold/global_scaffold.dart';
import 'package:home_arrest/mixins/appbar_mixin.dart';
import 'package:home_arrest/providers/user_provider.dart';
import 'package:home_arrest/view/profile/edit_profile_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/image_constants.dart';
import '../../global_widgets/image_pickers/custom_image.dart';
import '../../utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AppbarMixin {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).getUserDetails(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: baseStyleAppBar(
              title: 'My Profile',
              backgroundColor: Colors.transparent,
              titleColor: const Color(0xFF0D0E2C),
              leadingWidget: Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.adaptive.arrow_back, color: const Color(0xFF21356A)),
                );
              }),
            ),
            body: !userProvider.isLoading
                ? userProvider.user != null
                    ? Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: const Color(0xFFF2F2F2)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('${userProvider.user?.firstName} ${userProvider.user?.lastName}',
                                          style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfileScreen(user: userProvider.user))).then((value) {
                                            if (value != null) {
                                              userProvider.getUserDetails(context);
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          padding: const EdgeInsets.all(13),
                                          child: Center(child: Image.asset(ImagesConstants.edit)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(height: 1, width: double.infinity, color: const Color(0xFFF2F2F2)),
                                const SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(50),
                                            child: CustomImage(image: userProvider.user?.profilePic ?? '', height: 50, width: 50, fit: BoxFit.fill),
                                          ),
                                          const SizedBox(width: 20),
                                          Text(
                                            '${userProvider.user?.firstName} ${userProvider.user?.lastName}',
                                            style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'PHONE',
                                        style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                                      ),
                                      Text(
                                        '${userProvider.user?.phoneNumber}',
                                        style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'EMAIL',
                                        style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                                      ),
                                      Text(
                                        '${userProvider.user?.email}',
                                        style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'GENDER',
                                        style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                                      ),
                                      Text(
                                        '${userProvider.user?.gender}',
                                        style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'HOME ADDRESS',
                                        style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                                      ),
                                      Text('30 N Gould St Ste 7596, Sheridan, WY, 82801.', style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black)),
                                      const SizedBox(height: 10),
                                      Text(
                                        'WORK ADDRESS',
                                        style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey),
                                      ),
                                      Text(
                                        '30 N Gould St Ste 7596, Sheridan, WY, 82801.',
                                        style: Utils.safeGoogleFont('Poppins', fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                                      ),
                                      const SizedBox(height: 15),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Text('No Data Found', style: Utils.safeGoogleFont('Poppins', fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                      )
                : const Center(child: Center(child: CupertinoActivityIndicator())),
          );
        },
      ),
    );
  }
}
