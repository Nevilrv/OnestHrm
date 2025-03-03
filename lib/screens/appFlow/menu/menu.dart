import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hrm_app/api_service/connectivity/no_internet_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/componets/menu_drawer.dart';
import 'package:hrm_app/screens/appFlow/menu/menu_provider.dart';
import 'package:provider/provider.dart';

import '../../../utils/res.dart';
import 'my_account/my_account.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: ChangeNotifierProvider(
        create: (context) => MenuProvider(),
        child: Consumer<MenuProvider>(
          builder: (context, provider, _) {
            return Scaffold(
                key: _scaffoldKey,
                endDrawer: MenuDrawer(provider: provider),
                extendBody: true,
                body: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          AppColors.colorPrimary,
                          AppColors.colorPrimaryGradient
                        ])),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 50),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const MyAccount()));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 20),
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: CachedNetworkImage(
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      imageUrl: "${provider.profileImage}",
                                      placeholder: (context, url) => Center(
                                        child: Image.asset(
                                            // "assets/images/placeholder_image.png",
                                            "assets/images/app_icon.png"),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider.userName ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          tr("view_profile"),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors.colorPrimary),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        if (_scaffoldKey
                                            .currentState!.isEndDrawerOpen) {
                                          _scaffoldKey.currentState
                                              ?.openEndDrawer();
                                        } else {
                                          _scaffoldKey.currentState
                                              ?.openEndDrawer();
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.menu,
                                        color: AppColors.colorPrimary,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: provider.menuList?.length ?? 0,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, childAspectRatio: 2),
                            itemBuilder: (BuildContext context, int index) {
                              final data = provider.menuList![index];
                              return menuCard(
                                  context: context,
                                  name: data.name,
                                  image: data.icon,
                                  onPressed: () =>
                                      provider.getRoutSlag(context, data.slug));
                            },
                          ),
                        ),
                      ],
                    )));
          },
        ),
      ),
    );
  }

  Card menuCard(
      {BuildContext? context,
      String? image,
      String? name,
      Function()? onPressed}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextButton(
        // onPressed: () {
        //   NavUtil.navigateScreen(context!, const PhonebookScreen());
        // },
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              SvgPicture.network(
                image ?? "",
                height: 25,
                width: 25,
                color: AppColors.colorPrimary,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                tr("$name"),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
