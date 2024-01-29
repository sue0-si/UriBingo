import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/user_model.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view_model/main_screen_view_model.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../widget/custom_widgets/super_loading_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
//   List<Widget> fridges = [];
//   List<RefrigeDetail> refrigeItems = [];
//
//   final UserDataRepository userDataRepository = UserDataRepository();
//   bool isManager = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainScreenViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            '냉장고',
            style: AppTextStyle.header22(color: Colors.white),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: const Color(0xFF9bc6bf),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
      body: (viewModel.isLoading)
          ? Center(
              child: SuperLoadingBar(
                colors: const [Color(0xFF254e7a)],
                strokeWidth: 4,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 30,
                  childAspectRatio: 3 / 6,
                ),
                itemCount: viewModel.fridges.length + 1,
                itemBuilder: (context, index) {
                  if (index == viewModel.fridges.length) {
                    // Last item is the add button
                    return viewModel.isManager
                        ? IconButton(
                            icon: Icon(
                              UniconsLine.plus_circle,
                              size: 40,
                              color: Colors.grey.shade400,
                            ),
                            onPressed: () {
                              context.go('/addRefrige', extra: 0);

                              setState(() {});
                            },
                          )
                        : Container();
                  } else {
                    // Display the fridge container
                    return viewModel.fridges[index];
                  }
                },
              ),
            ),
    );
  }
}
