import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:parkingapp/Core/Routing/Routes.dart';
import 'package:parkingapp/Core/Theme/ColorManager.dart';

class Signuplogintext extends StatelessWidget{
  const Signuplogintext({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Align(
                    alignment: Alignment.center,
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                          color: ColorManager.subtitleColor,
                          fontSize: 16.sp,
                        ),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              color: ColorManager.buttonColor,
                              fontSize: 16.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(Routes.loginScrren);
                              },
                          ),
                        ],
                      ),
                    ),
                  ) ;
  }
}