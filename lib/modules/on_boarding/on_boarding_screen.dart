import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import '../login/shop_login_screen.dart';

class BoardingModel
{
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
{
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
  title: 'On Board 1 Title',
  image: 'assets/images/onboard1.jpg',
  body: 'On Board 1 Body',
  ),
    BoardingModel(
  title: 'On Board 2 Title',
  image: 'assets/images/onboard1.jpg',
  body: 'On Board 2 Body',
  ),
    BoardingModel(
  title: 'On Board 3 Title',
  image: 'assets/images/onboard1.jpg',
  body: 'On Board 3 Body',
  ),
  ];

  bool isLast = false;

  void submit()
  {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value)
      {
        navigateAndFinish(
          context,
          ShopLoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: submit,
              text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
            children :
            [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (int index){
                    if(index == boarding.length - 1)
                    {
                      setState(() {
                        isLast = true;
                      });
                      print('last');
                    } else
                      {
                        setState(() {
                          isLast = false;
                        });
                        print('not last');
                      }
                  },
                  itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children:
                [
                  SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                    count: boarding.length,
                  ),
                  Spacer(),
                  FloatingActionButton(
                      onPressed: ()
                      {
                        if(isLast)
                        {
                          submit();
                        }
                        else
                        {
                          boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      },
                    child: Icon(Icons.arrow_forward_ios,),
                  ),
                ],
              ),
            ],
        ),
      ),
    );
  }

  Widget buildBoardingItem (BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 24.0,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
    ],
  );
}
