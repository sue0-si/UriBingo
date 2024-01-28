import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:leute/data/models/foods_model.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/view_model/my_food_detail_view_model.dart';
import 'package:leute/view/widget/custom_dialog/two_answer_dialog.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/my_food_detail_page_widget/food_detail_image_widget.dart';
import 'package:provider/provider.dart';
import '../../../data/repository/foods_repository.dart';

class MyFoodDetail extends StatefulWidget {
  const MyFoodDetail({super.key, required this.myFoodItem, required this.ourRefrigItem});

  final FoodDetail myFoodItem;
  final RefrigeDetail ourRefrigItem;

  @override
  State<MyFoodDetail> createState() => _MyFoodDetailState();
}

// 등록한 ChangeNotifier 을 불러올때는 context.read 또는 context.watch 를 이용해서 불러올 수 있는데요,
// watch 는 notifyListeners(); 가 호출되면 상태변화를 자동으로 감지해서 데이터를 동기화를 시키게되고
// read 는 상태변화를 감지하지 않습니다
// 그래서 데이터 변경을 반영해야할 경우에는 watch 를 사용하시면 되고,
// 뷰모델 내부의 함수를 호출하거나 단순히 값을 읽어오기만 할 경우에는 context.read 를 사용하시면 되요
class _MyFoodDetailState extends State<MyFoodDetail> {
  // ChangeNotifer 을 불러올때 이렇게 불러오면 안되요
  // final myFoodViewModel = MyFoodDetailViewModel();

  // 아래 데이터들은 viewmodel 에서 관리하도록 할게요
  // int _remainPeriod = 0;
  // bool _isOld = false;

  // remainPeriod 계산, 연장버튼 네 클릭 -> _remainPeriod 업데이트, 2일 미만 체크 -> _isOld 업데이트
  @override
  void initState() {
    super.initState();
    // initData();
    // initState 에서는 바로 context 에 접근할 수 없기때문에 비동기 처리 해서 context에 접근할 수 잇도록 합니다
    Future.microtask(() {
      context.read<MyFoodDetailViewModel>().calculateRemainPeriod(widget.myFoodItem, widget.ourRefrigItem);
      context.read<MyFoodDetailViewModel>().checkOld(widget.myFoodItem, widget.ourRefrigItem);
    });
  }

  //foodDetails 데이터 get
  void initData() async {
    // MVVM 아키텍쳐인데 View 에서 repository 에 직접 접근하는방법은 좋지 않아요
    // 이건 viewmodel로 옮기는게 더 좋아보입니다!
    // final foods = await RegisterdFoodsRepository().getFirebaseFoodsData();
    // setState(() {
    //   foods; << 이거요 그러면 이거는 필요없는 거죠 ?
    //아뇨 이 데이터를 아예 안쓰고있는것같아서요
    // 그럼 사용하고있지 않는게 맞는것같아요
    // });
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy년 MM월 dd일');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/', extra: 1);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodDetailImageWidget(
                  itemImage: widget.myFoodItem.foodImage,
                ),
              ),
            );
          },
          child: Hero(
            tag: 'imageTag',
            child: Container(
              height: 200.h,
              width: 300.w,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(widget.myFoodItem.foodImage, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        SizedBox(height: 32.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            children: [
              Row(
                children: [
                  Text('등록일: ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(widget.myFoodItem.registerDate))}',
                      style: AppTextStyle.body14R()),
                ],
              ),
              // 이제 아래에서는 viewmodel 에 있는 데이터를 참조할게요
              // 더이상 setState를 사용할 필요가 없어져요
              Row(
                children: [
                  Text('남은기간: ', style: AppTextStyle.body14R()),
                  Text(
                    '${context.watch<MyFoodDetailViewModel>().remainPeriod} 일',
                    style: AppTextStyle.body14R(
                        color: context.watch<MyFoodDetailViewModel>().isOld ? AppColors.caution : AppColors.mainText),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[50]),
                    //남은 기간이 2일 미만-> 다이얼로그 생성 / 2일 이상 ->버튼 비활성화
                    onPressed: context.watch<MyFoodDetailViewModel>().isOld
                        ? () {
                      showDialog(
                          context: context,
                          builder: (desContext) {
                            return TwoAnswerDialog(
                                title: '연장하시겠습니까?',
                                firstButton: '네',
                                secondButton: '아니오',
                                onTap: () {
                                  //'네' 클릭 -> _isOld 변경, _remainPeriod 변경, firestore isExtended 변경
                                  setState(() {
                                    context.read<MyFoodDetailViewModel>().isOld = false;
                                    context
                                        .read<MyFoodDetailViewModel>()
                                        .extendPeriod(widget.myFoodItem, widget.ourRefrigItem);
                                    context.read<MyFoodDetailViewModel>().updateFirestore(widget.myFoodItem);
                                  });
                                  Navigator.of(context).pop();
                                });
                          });
                    }
                    //연장버튼 비활성화
                        : null,
                    child: const Text('연장하기'),
                  )
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (desContext) {
                              return TwoAnswerDialog(
                                  title: '등록한 음식을 삭제하시겠습니까?',
                                  firstButton: '네',
                                  secondButton: '아니오',
                                  // firebase 삭제
                                  onTap: () {
                                    context
                                        .read<MyFoodDetailViewModel>()
                                        .deleteFoodAndStorage(widget.myFoodItem, widget.ourRefrigItem);
                                    if (mounted) {
                                      context.go('/', extra: 1);
                                    }
                                  });
                            });
                      },
                      child: const Text('삭제하기')),
                ],
              ),
              SizedBox(height: 32.h),
              //남은 기간에 따라 다른 텍스트 출력
              context.watch<MyFoodDetailViewModel>().isOld
                  ? Text('곧 폐기됩니다.', style: AppTextStyle.body14R(color: AppColors.caution))
                  : widget.myFoodItem.isExtended
                  ? const Text('더이상 연장이 불가해요')
                  : const Text('아직은 연장이 불가해요')
            ],
          ),
        ),
      ]),
    );
  }
}