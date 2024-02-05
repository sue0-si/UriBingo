import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/page/main_my_fridge/main_screen_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainScreenViewModel>();
    final state = viewModel.state;
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
        body: (state.isLoading)
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: const Color(0xFF9bc6bf),
                  size: 50,
                ),
              )
            : Stack(
                children: [
                  viewModel.refrigeItems.isEmpty
                      ? const Center(
                          child: Text('등록된 냉장고가 없습니다.'),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.all(16.0).w,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(
                          decelerationRate: ScrollDecelerationRate.fast),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 30,
                        childAspectRatio: 2.6 / 6,
                      ),
                      itemCount: viewModel.fridges.length + 1,
                      itemBuilder: (context, index) {
                        if (index == viewModel.fridges.length) {
                          // Last item is the add button
                          return (state.currentUser != null &&
                              state.currentUser!.manager)
                              ? IconButton(
                                  icon: Icon(
                                    UniconsLine.plus_circle,
                                    size: 40,
                                    color: Colors.grey.shade400,
                                  ),
                                  onPressed: () {
                                    context.go('/addRefrige',
                                        extra: state.currentUser);
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
                ],
              ),
        floatingActionButton:
            (state.currentUser != null && state.currentUser!.manager)
                ? FloatingActionButton(
                    backgroundColor: const Color(0xFF9bc6bf),
                    onPressed: () => context.go('/discardPage'),
                    child: const Icon(
                      Icons.delete_forever_sharp,
                      color: Colors.white,
                    ),
                  )
                : null);
  }
}
