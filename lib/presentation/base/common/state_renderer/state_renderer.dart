import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restapi/data/mapper/mapper.dart';
import 'package:flutter_restapi/presentation/resources/assets_manager.dart';
import 'package:flutter_restapi/presentation/resources/strings_manager.dart';
import 'package:flutter_restapi/presentation/resources/styles_manager.dart';
import 'package:flutter_restapi/presentation/resources/values_manager.dart';
import 'package:lottie/lottie.dart';

import '../../../../data/network/failure.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';

enum StateRendererType {
  //Pop up state
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,

  //Full Screen State
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE,
  EMPTY_SCREEN_STATE,
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function? retryActionFunction;

  StateRenderer({super.key,
    required this.stateRendererType,
    Failure? failure,
    String? message,
    String? title,
    required this.retryActionFunction})
      : message = message ?? AppStrings.loading,
        title = title ?? EMPTY;

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE :
        return _getPopUpDialog(context, [_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.POPUP_ERROR_STATE :
        return _getPopUpDialog(context, [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.ok,
              context)
        ]);
      case StateRendererType.FULL_SCREEN_LOADING_STATE :
        return _getItemsInColumn([_getAnimatedImage(JsonAssets.error), _getMessage(message)]);
      case StateRendererType.FULL_SCREEN_ERROR_STATE :
       return _getItemsInColumn([
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retry_again, context)
        ]);
      case StateRendererType.CONTENT_SCREEN_STATE :
        return Container();
      case StateRendererType.EMPTY_SCREEN_STATE :
        return _getItemsInColumn([_getAnimatedImage(JsonAssets.empty), _getMessage(message)]);
      default :
        return Container();
    }
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName), //
    );
  }


  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppPadding.p18,AppPadding.p0,AppPadding.p18,AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(onPressed: () {
            if (stateRendererType ==
                StateRendererType.FULL_SCREEN_ERROR_STATE) {
              retryActionFunction?.call();
            }
            else {
              Navigator.of(context).pop(); // dismiss method
            }
          },

              child: Text(buttonTitle)),
        ),
      ),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppPadding.p18,AppPadding.p0,AppPadding.p18,AppPadding.p18),
        child: Text(message, style: getMediumStyle(
            color: ColorManager.black, fontSize: FontSize.s16)),
      ),
    );
  }


  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}

Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
  return Dialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14)
    ),
    elevation: AppSize.s1_5,
    backgroundColor: Colors.transparent,
    child: Column(
        mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              color: ColorManager.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(AppSize.s14),
              boxShadow: const [
                BoxShadow(color: Colors.black26,
                    blurRadius: AppSize.s12,
                    offset: Offset(AppSize.s0, AppSize.s12))
              ]
          ),
          child: _getDialogContent(context, children),
        ),
      ],
    ),
  );
}

Widget _getDialogContent(BuildContext context, List<Widget> children) {
  return Center(
    child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children),
  );
}



