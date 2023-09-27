import 'package:ayurbot/screens/chatbotPage.dart';
import 'package:ayurbot/shared/RoundedRectImage.dart';
import 'package:ayurbot/shared/profilePic.dart';
import 'package:flutter/material.dart';
import 'package:ayurbot/services/userAuth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int showCategoryDesc = -1;
  UserAuth _auth = UserAuth();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: SweepGradient(
          colors: [Color(0xff000000), Color(0xff0a0d1d)],
          stops: [0, 1],
          center: Alignment.topRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,

          // backgroundColor: Color.fromARGB(255, 45, 47, 62),
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/appTitleTransparent.png",
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  print("profile pic was clicked");
                },
                child: profilePic(
                  imagePath: "assets/profilePicMaleDefault.png",
                  radius: 12,
                  width: 32,
                  height: 32,
                ),
              ),
            ],
          ),
          // centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              //sectionOne
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.033),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height * 0.03),
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: RoundedRectImage(
                          imagePath: "assets/heroImage.png",
                          wd: MediaQuery.sizeOf(context).width,
                          ht: MediaQuery.sizeOf(context).height * 0.4,
                          radius: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      "Know your Prakruti",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.04,
                      ),
                    ),
                    Text(
                      "Embark on a fascinating journey to uncover your Prakruti with our PhenoPal, based on ancient Ayurvedic principles. Unveil your unique dosha balance and take conscious steps for a healthier you.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 110, 118, 138),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              //sectionTwo
              Container(
                width: MediaQuery.of(context).size.width * 0.93,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.03,
                ),
                decoration: BoxDecoration(),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Why Ayurveda?",
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.04,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            "Ayurveda, a 5,000-year-old holistic healing system, emphasizes the importance of balance for optimal health. Prakruti analysis reveals your inherent dosha composition, empowering you to make lifestyle choices that enhance your well-being.",
                            style: TextStyle(
                              color: Color.fromARGB(255, 110, 118, 138),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(),
                          child: RoundedRectImage(
                            imagePath: "assets/heroImage.png",
                            radius: 20,
                            wd: MediaQuery.sizeOf(context).width * 0.42,
                            ht: MediaQuery.sizeOf(context).height * 0.31,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //sectionThree
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                ),
                decoration: BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.03,
                        left: MediaQuery.of(context).size.width * 0.03,
                        bottom: MediaQuery.of(context).size.height * 0.03,
                      ),
                      child: Text(
                        "The three doshas",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.sizeOf(context).height * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          categoryDescStack(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          categoryDescStack(
                            title: "Pitta",
                            subTitle: "regulates metabolism",
                            bgCol: Color(0xFFF012BE),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          categoryDescStack(
                            title: "Kapha",
                            subTitle: "manages assimilation",
                            bgCol: Color(0xFF3d9970),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // SectionFour
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.024,
                  bottom: MediaQuery.of(context).size.height * 0.04,
                ),
                decoration: BoxDecoration(),
                child: Column(
                  children: [
                    Text(
                      "Discover your unique Prakruti, \nguided by our interactive chatbot.\nUncover your path to holistic well-being now!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 110, 118, 138),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        //try to load messages
                        // await _auth.retrieveChat();

                        //leads to chatbot  page
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatBotScreen()));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 45, 0, 53),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "Dive in",
                          style: TextStyle(
                            color: Color.fromARGB(255, 179, 0, 210),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class categoryDescStack extends StatelessWidget {
  String? title;
  String? subTitle;
  String? imagePath;
  Color? bgCol;
  categoryDescStack({
    this.imagePath = "assets/heroImage.png",
    this.title = "Vata",
    this.subTitle = "governs movement",
    this.bgCol = const Color.fromARGB(195, 0, 140, 255),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        RoundedRectImage(
          imagePath: imagePath!,
          radius: 20,
          wd: MediaQuery.sizeOf(context).width * 0.42,
          ht: MediaQuery.sizeOf(context).height * 0.31,
        ),
        Positioned(
          bottom: MediaQuery.sizeOf(context).height * 0.00,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.42,
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.02,
              bottom: MediaQuery.of(context).size.width * 0.02,
            ),
            decoration: BoxDecoration(
              color: bgCol,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 0.04,
                  ),
                ),
                Text(
                  subTitle!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.024,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
