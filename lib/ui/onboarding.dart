import 'package:client/conf.dart';
import 'package:client/model/slider_model.dart';
import 'package:client/ui/signin.dart';
import 'package:client/ui/component/component.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingPage> {
  List<SliderModel> slides = <SliderModel>[];
  int currentIndex = 0;
  late PageController _controller;

  //late SharedPreferences logindata;
  //late bool newuser;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    slides = getSlides();
    //checkUserLogged();
  }

  /** void checkUserLogged() async {
      logindata = await SharedPreferences.getInstance();
      newuser = (logindata.getBool('login') ?? true);
      print(newuser);
      if (newuser == true) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return  HomePage(paramIndex: 0,);
      }));
      }
      }**/
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: slides.length,
                itemBuilder: (context, index) {
                  // contents of slider
                  return OnboardingSlider(
                    image: slides[index].getImage(),
                    title: slides[index].getTitle(),
                    desc: slides[index].getDesc(),
                    currentIndex: currentIndex,
                    slideLength: slides.length,
                  );
                }),
          ),
          //dot
          Container(
            height: 50,
            margin: const EdgeInsets.all(30),
            width: double.infinity,
            child: ElevatedButton(
              child: Text(
                currentIndex == slides.length - 1 ? titLOGIN : titNEXT,
                style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Color(CLGREY)),
              ),
              onPressed: () {
                if (currentIndex != slides.length - 1) {
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.bounceIn);
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SignIn()),
                  );
                  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> introKey.currentState?.animateScroll(1));
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: const Color(0xffF4EE42),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  )),
            ),
          ),
        ],
      ),
      backgroundColor: clWHITEORI,
    );
  }
}

// ignore: must_be_immutable
// slider declared
// ignore: must_be_immutable
