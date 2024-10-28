import 'dart:async';

import 'package:cardreader/mainBloc/bloc.dart';
import 'package:cardreader/mainBloc/event.dart';
import 'package:cardreader/mainBloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'consts.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<bool> copied1 = [];
  List<bool> copied2 = [];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CardBloc>(context).add(GetCards());
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double f = w / 25;
    return SafeArea(
      child: Scaffold(
          body: BlocListener<CardBloc, CardState>(
        listener: (context, state) => {
          if (state is ScanResulte)
            {
              if (state.res)
                {BlocProvider.of<CardBloc>(context).add(GetCards())}
              else
                 {BlocProvider.of<CardBloc>(context).add(GetCards())}
            }
          else if (state is Cards)
            {
              setState(() {
                for (var a in state.data) {
                  copied1.add(false);
                  copied2.add(false);
                }
              })
            }
        },
        child: Container(
          height: h,
          child: Column(
            children: [
              Container(
                height: h * 0.85,
                width: w,
                child:
                    BlocBuilder<CardBloc, CardState>(builder: (context, state) {
                  if (state is Cards) {
                    return ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: h * 0.4,
                          width: w,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: white, width: 1),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3))
                            ],
                          ),
                          margin: EdgeInsets.only(top: h * 0.02),
                          child: Column(
                            children: [
                              //netWork name
                              Container(
                                // height: h * 0.1,
                                width: w,
                                child: Center(
                                  child: Text(
                                    state.data[index].netWorkName,
                                    style: TextStyle(
                                        color: white,
                                        fontSize: f * 2,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              // user name and password
                              Container(
                                height: h * 0.18,
                                width: w,
                                child: Row(
                                  children: [
                                    Container(
                                      width: w * 0.3,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          // height: h * 0.26,
                                          width: w,
                                          child: Center(
                                            child: Image.asset(
                                              "assets/images/logo.png",
                                              width: w * 0.4,
                                              height: w * 0.4,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: w * 0.7 - 4,
                                      child: Column(
                                        children: [
                                          selectedDesc(
                                              h,
                                              w,
                                              f,
                                              'اسم المستخدم',
                                              state.data[index].username,
                                              black,
                                              darksoap),
                                          selectedDesc(
                                              h,
                                              w,
                                              f,
                                              'كلمة المرور',
                                              state.data[index].password,
                                              black,
                                              darksoap),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Spacer(),
                                    //time name
                                    Container(
                                      child: Center(
                                        child: Text(
                                          'time:',
                                          style: TextStyle(
                                              color: white,
                                              fontSize: f * 1.3,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: w * 0.01,
                                    ),
                                    //time value
                                    Container(
                                      child: Center(
                                        child: Text(
                                          state.data[index].time,
                                          style: TextStyle(
                                              color: white,
                                              fontSize: f * 1.3,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    //size name
                                    Container(
                                      child: Center(
                                        child: Text(
                                          'size:',
                                          style: TextStyle(
                                              color: white,
                                              fontSize: f * 1.3,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: w * 0.01,
                                    ),
                                    //size value
                                    Container(
                                      child: Center(
                                        child: Text(
                                          state.data[index].size,
                                          style: TextStyle(
                                              color: white,
                                              fontSize: f * 1.3,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    //type name
                                    Container(
                                      child: Center(
                                        child: Text(
                                          'type:',
                                          style: TextStyle(
                                              color: white,
                                              fontSize: f * 1.3,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: w * 0.01,
                                    ),
                                    //type value
                                    Container(
                                      child: Center(
                                        child: Text(
                                          state.data[index].type,
                                          style: TextStyle(
                                              color: white,
                                              fontSize: f * 1.3,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Spacer()
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: h * 0.02),
                                height: h * 0.05,
                                child: Row(
                                  children: [
                                    Spacer(),
                                    //time name
                                    InkWell(
                                      onTap: () {
                                        BlocProvider.of<CardBloc>(context)
                                            .add(DeleteCard(index: index));
                                      },
                                      child: Container(
                                        width: w * 0.3,
                                        decoration: BoxDecoration(
                                            color: white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            'حذف الكرت',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: f * 1.3,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: state.data[index].password));
                                        Timer(Duration(seconds: 3), () {
                                          setState(() {
                                            copied2[index] = false;
                                          });
                                        });
                                        setState(() {
                                          copied2[index] = true;
                                        });
                                      },
                                      child: Container(
                                        width: w * 0.3,
                                        decoration: BoxDecoration(
                                            color: white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            copied2[index]
                                                ? "تم النسخ"
                                                : 'نسخ حقل2',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: f * 1.3,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Clipboard.setData(ClipboardData(
                                            text: state.data[index].username));
                                        Timer(Duration(seconds: 3), () {
                                          setState(() {
                                            copied1[index] = false;
                                          });
                                        });
                                        setState(() {
                                          copied1[index] = true;
                                        });
                                      },
                                      child: Container(
                                        width: w * 0.3,
                                        decoration: BoxDecoration(
                                            color: white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            copied1[index]
                                                ? "تم النسخ"
                                                : 'نسخ حقل1',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: f * 1.3,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer()
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (state is LoadingState) {
                    return Center(
                        child: CircularProgressIndicator(
                            color: blue, strokeWidth: 2));
                  } else {
                    return Container();
                  }
                }),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Material(
                  child: InkWell(
                    splashColor: white,
                    onTap: () {
                      BlocProvider.of<CardBloc>(context).add(Scan());
                    },
                    child: Container(
                      height: h * 0.07,
                      width: w * 0.7,
                      margin: EdgeInsets.only(top: h * 0.02),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3))
                          ],
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text('قراءة QR',
                            style: TextStyle(
                                color: white,
                                fontSize: f * 1.5,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Container selectedDesc(double h, double w, double f, String name,
      String value, Color textColor, Color backColor) {
    return Container(
      margin: EdgeInsets.only(top: h * 0.02),
      height: h * 0.06,
      width: w * 0.65,
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.blue, width: 1),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3))
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: w * 0.39,
            decoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                    color: black, fontSize: f, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: w * 0.25,
            child: Center(
              child: Text(
                name,
                style: TextStyle(
                    color: textColor, fontSize: f, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
