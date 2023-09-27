import 'dart:async';

import 'package:ayurbot/services/messageModel.dart';
import 'package:ayurbot/services/userAuth.dart';
import 'package:ayurbot/shared/profilePic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  late DialogFlowtter dialogFlow;
  UserAuth _auth = UserAuth();
  TextEditingController _textCntrl = TextEditingController();
  bool showMessageLoader = true;

  List<ChatMessage> messages = [
    // ChatMessage(
    //     sender: "gpt",
    //     msg:
    //         "Welcome to the chat screen Your prakruti analysis will now begin"),
  ];
  @override
  void dispose() {
    // TODO: implement dispose

    //typecast chatmessages into messageModels
    List<Map<String, dynamic>> msgs = messages.map((msg) {
      MessageModel model =
          MessageModel.fromJsom(sender: msg.sender!, msg: msg.msg!);
      return model.toMap();
    }).toList();

    //call saveMessage from auth
    _auth.saveChat(msgs: msgs);

    super.dispose();
  }

  loadMessages() async {
    //retreiveMessages from firebase
    Map<String, dynamic> msgs = await _auth.retrieveChat();
    print("from function ke andar se");
    List<dynamic> chatList = msgs['msgs'];
    //typecast into chatMessages
    messages = chatList.map((msg) {
      return ChatMessage(sender: msg['sender'], msg: msg['msg']);
    }).toList();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(milliseconds: 3000), () {
      setState(() {
        showMessageLoader = false;
      });
    });

    //loadMessages from firebase
    loadMessages();

    //initializing dialogFlow
    DialogFlowtter.fromFile().then((instance) => dialogFlow = instance);

    super.initState();
  }

  addMessage({
    required Message msg,
    required String sender,
  }) {
    // Text(widget.messages[index]['message'].text.text[0])),
    messages.add(ChatMessage(sender: sender, msg: msg.text!.text![0]));
  }

  sendMessage({required String msg}) async {
    if (msg == "" || msg.isEmpty) return;
    setState(() {
      addMessage(msg: Message(text: DialogText(text: [msg])), sender: "user");
    });

    DetectIntentResponse resp = await dialogFlow.detectIntent(
        queryInput: QueryInput(text: TextInput(text: msg)));
    if (resp.message == null) return;
    setState(() {
      print("response from Pheno is: ${resp.message!.text!.text}");
      addMessage(msg: resp.message!, sender: "gpt");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/chatScreenBG.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
            child: AppBar(
              iconTheme: IconThemeData(
                size: 20,
                color: Colors.white,
              ),
              backgroundColor: Color.fromARGB(162, 0, 11, 5),
              title: Image.asset(
                "assets/appTitleTransparent.png",
                height: 20,
              ),
              centerTitle: true,
            ),
          ),
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Flexible(
                child: showMessageLoader
                    ? SpinKitFadingCircle(
                        duration: Duration(milliseconds: 3200),
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              color: index.isEven
                                  ? const Color.fromARGB(255, 2, 34, 3)
                                  : Colors.green,
                            ),
                          );
                        },
                      )
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: messages.length,
                        // reverse: true,
                        itemBuilder: (context, index) {
                          return messages[index];
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 8,
                ),
                child: _textComposer(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TextField _textComposer(BuildContext context) {
    return TextField(
      controller: _textCntrl,
      decoration: InputDecoration(
        hintText: "Send a message...",
        hintStyle: TextStyle(
          color: Colors.green,
        ),
        filled: true,
        fillColor: Color.fromARGB(202, 16, 17, 16),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(5),
            bottom: Radius.circular(0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(5),
            bottom: Radius.circular(0),
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            //adding user message o the list
            sendMessage(msg: _textCntrl.text.trim());
            _textCntrl.clear();

            // setState(() {
            //   messages.add(ChatMessage(sender: "user", msg: _textCntrl.text));
            //   _textCntrl.clear();
            // });
          },
          splashRadius: 2,
          icon: Icon(
            Icons.send,
            size: 20,
            color: const Color.fromARGB(255, 138, 200, 140),
          ),
        ),
      ),
      style: TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
      cursorColor: const Color.fromARGB(255, 0, 255, 8),
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onSubmitted: (evemt) {
        //adding user message o the list
        /////////////////
        if (!_textCntrl.text.isEmpty && _textCntrl.text.trim() != "")
          sendMessage(msg: _textCntrl.text.trim());
        _textCntrl.clear();
        // setState(() {
        //   messages
        //       .add(ChatMessage(sender: "user", msg: _textCntrl.text.trim()));
        //   _textCntrl.clear();
        // });
      },
    );
  }
}

class ChatMessage extends StatefulWidget {
  String? sender;
  String? msg;
  ChatMessage({
    required this.sender,
    required this.msg,
    super.key,
  });

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage>
    with SingleTickerProviderStateMixin {
  //animation setter
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000), // Adjust duration as needed
    );

    // Define a curved animation
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //////////////////////animation setter over

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.008,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.sender == "user"
              ? [
                  //messageBox
                  /////////////////
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(189, 0, 0, 0),
                          border: Border.all(
                              // color: Colors.orange,
                              ),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Text(
                        widget.msg!,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                MediaQuery.sizeOf(context).height * 0.027),
                      ),
                    ),
                  ),

                  //sender's pic
                  /////////////////
                  profilePic(
                    imagePath: widget.sender == "user"
                        ? "assets/profilePicMaleDefault.png"
                        : "assets/appIconChat.png",
                  ),
                ]
              : [
                  //sender's pic
                  /////////////////
                  profilePic(
                    imagePath: widget.sender == "user"
                        ? "assets/profilePicMaleDefault.png"
                        : "assets/appIconChat.png",
                  ),

                  //messageBox
                  /////////////////
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(189, 0, 0, 0),
                          border: Border.all(
                              // color: Colors.orange,
                              ),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      // child:
                      //  DefaultTextStyle(
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //     fontSize: MediaQuery.sizeOf(context).height * 0.027,
                      //   ),
                      //   child:
                      //    AnimatedTextKit(
                      //     isRepeatingAnimation: false,
                      //     animatedTexts: [
                      //       TyperAnimatedText(
                      //         msg!,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      child: Text(
                        widget.msg!,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize:
                                MediaQuery.sizeOf(context).height * 0.027),
                      ),
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}
