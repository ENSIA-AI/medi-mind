import 'package:flutter/material.dart';
import 'package:medi_mind/presentation/views/welcome_screen.dart';
import 'package:medi_mind/presentation/views/widgets/common/logo_name_widget.dart';
import 'package:medi_mind/presentation/views/widgets/Boarding%20Screens/on_boarding_page_info.dart';
import 'package:medi_mind/themes/colors.dart';
import 'package:medi_mind/utils/pages_enum.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';







class OnBoardingPages extends StatefulWidget {
  const OnBoardingPages({
    super.key,
  });

  @override
  State<OnBoardingPages> createState() => _OnBoardingPagesState();
}

class _OnBoardingPagesState extends State<OnBoardingPages> {
  final PageController _currentOnBoardingPage = PageController();
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentOnBoardingPage.addListener(() {
      setState(() {
        _currentPageIndex = _currentOnBoardingPage.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0, bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LogoNameWidget(),
              Expanded(
                child: PageView.builder(
                  controller: _currentOnBoardingPage,
                    itemCount: 3,
                    itemBuilder: (context, index){
                  return OnBoardingPageInfoWidget(
                    imagePath: onBoardingInfo[index]["imageUrl"],
                    description: onBoardingInfo[index]["description"],
                    title: onBoardingInfo[index]["title"],
                  );
                }),
              ),

              SmoothPageIndicator(
                  controller: _currentOnBoardingPage,
                  count: 3,
                  effect: WormEffect(
                    activeDotColor: PRIMARY_BLUE
                  ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap : (){},
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Skip", style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey
                        ),),
                      ),
                    ),
                    AnimatedSwitcher(duration: Duration(milliseconds: 300),
                      child: _currentPageIndex < 2 ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: CircleBorder(),
                              backgroundColor: PRIMARY_BLUE, elevation: 5, padding: EdgeInsets.all(12)),
                          onPressed: (){
                            _currentOnBoardingPage.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
                          },
                          child: Icon(Icons.arrow_forward_ios_rounded) ) :
                      ElevatedButton(
                        
                          style: ElevatedButton.styleFrom(

                              foregroundColor: Colors.white,
                              backgroundColor: PRIMARY_BLUE, elevation: 5),
                          onPressed: (){
                            Navigator.of(context).pushReplacementNamed('/main');
                          },
                          child: Text("Get Started", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                          ),) ),
                    )

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

