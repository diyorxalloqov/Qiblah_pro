import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qiblah_pro/modules/global/imports/app_imports.dart';
import 'package:qiblah_pro/modules/namoz/bloc/namoz_bloc.dart';

class NamozPage extends StatefulWidget {
  const NamozPage({super.key});

  @override
  State<NamozPage> createState() => _NamozPageState();
}

class _NamozPageState extends State<NamozPage> {
  late NamozBloc namozBloc;

  @override
  void initState() {
    namozBloc = NamozBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: namozBloc,
      child: BlocBuilder<NamozBloc, NamozState>(
        builder: (context, state) {
          if (state.status == ActionStatus.isLoading) {
            return const SizedBox.shrink();
          }
          if (state.status == ActionStatus.isSuccess) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    title: MediumText(text: 'organish'.tr()),
                    centerTitle: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12.r),
                            bottomRight: Radius.circular(12.r))),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, 'learnNamozPage',
                              arguments: state
                                  .namozModel[
                                      StorageRepository.getBool(Keys.isMan)
                                          ? 0
                                          : 1]
                                  .categoryItems),
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.isDark
                                  ? containerBlackColor
                                  : const Color(0xFFF4EBD8),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 18.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 170.w,
                                        child: Text(
                                          state
                                                  .namozModel[
                                                      StorageRepository.getBool(
                                                              Keys.isMan)
                                                          ? 0
                                                          : 1]
                                                  .categoryName ??
                                              '',
                                          overflow: TextOverflow.clip,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: context.isDark
                                                ? Colors.white
                                                : const Color(0xFF615745),
                                            fontFamily: AppfontFamily
                                                .comforta.fontFamily,
                                            fontSize: AppSizes.size_16,
                                            fontWeight: AppFontWeight.w_700,
                                          ),
                                        ),
                                      ),
                                      const SpaceHeight(),
                                      SizedBox(
                                        width: 190,
                                        child: Text(
                                          state
                                                  .namozModel[
                                                      StorageRepository.getBool(
                                                              Keys.isMan)
                                                          ? 0
                                                          : 1]
                                                  .description ??
                                              '',
                                          overflow: TextOverflow.clip,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: AppSizes.size_12,
                                              color: smallTextColor,
                                              fontFamily: AppfontFamily
                                                  .inter.fontFamily,
                                              fontWeight: AppFontWeight.w_400),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Transform.rotate(
                                      angle: -23.8 * pi / 180,
                                      child: Image.asset(
                                        AppImages.joynamoz,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.centerRight,
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, 'tahorat',
                              arguments: state.namozModel[2].categoryItems),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 12.0),
                            decoration: BoxDecoration(
                              color: context.isDark
                                  ? containerBlackColor
                                  : const Color(0xFFD0EAF8),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18.w, vertical: 20.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 170.w,
                                        child: Text(
                                          state.namozModel[2].categoryName ??
                                              '',
                                          overflow: TextOverflow.clip,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: context.isDark
                                                ? Colors.white
                                                : const Color(0xFF615745),
                                            fontFamily: AppfontFamily
                                                .comforta.fontFamily,
                                            fontSize: AppSizes.size_16,
                                            fontWeight: AppFontWeight.w_700,
                                          ),
                                        ),
                                      ),
                                      const SpaceHeight(),
                                      SizedBox(
                                          width: 190,
                                          child: Text(
                                            state.namozModel[2].description ??
                                                '',
                                            style: TextStyle(
                                                fontSize: AppSizes.size_12,
                                                color: smallTextColor,
                                                fontFamily: AppfontFamily
                                                    .inter.fontFamily,
                                                fontWeight:
                                                    AppFontWeight.w_400),
                                          ))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Image.asset(AppImages.tahorat,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.centerRight),
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, 'mistakes',
                                  arguments: state.namozModel[3].categoryItems),
                              child: Container(
                                height: 141.h,
                                width: 170.w,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18.w, vertical: 18.h),
                                decoration: BoxDecoration(
                                    color: context.isDark
                                        ? containerBlackColor
                                        : const Color(0xFFFDE3E3),
                                    borderRadius: BorderRadius.circular(16.r)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.namozModel[3].categoryName ?? '',
                                      overflow: TextOverflow.clip,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: context.isDark
                                            ? Colors.white
                                            : const Color(0xFF615745),
                                        fontFamily:
                                            AppfontFamily.comforta.fontFamily,
                                        fontSize: AppSizes.size_16,
                                        fontWeight: AppFontWeight.w_700,
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                          alignment: Alignment.bottomRight,
                                          child:
                                              Image.asset(AppImages.mistake)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, 'qoshimchalar',
                                  arguments: state.namozModel[4].categoryItems),
                              child: Container(
                                height: 141.h,
                                width: 170.w,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 18.w, vertical: 18.h),
                                decoration: BoxDecoration(
                                  color: context.isDark
                                      ? containerBlackColor
                                      : const Color(0xFFF5E5E0),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.namozModel[4].categoryName ?? '',
                                      overflow: TextOverflow.clip,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: context.isDark
                                            ? Colors.white
                                            : const Color(0xFF615745),
                                        fontFamily:
                                            AppfontFamily.comforta.fontFamily,
                                        fontSize: AppSizes.size_16,
                                        fontWeight: AppFontWeight.w_700,
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: Image.asset(
                                              AppImages.qoshimchalar,
                                              width: 85)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, 'jamoatNamozi',
                              arguments: state.namozModel[5].categoryItems),
                          child: Container(
                            height: 141.h,
                            width: 170.w,
                            margin: const EdgeInsets.only(top: 12),
                            padding: EdgeInsets.only(
                                right: 18.w, left: 18.w, top: 16.h),
                            decoration: BoxDecoration(
                                color: context.isDark
                                    ? containerBlackColor
                                    : const Color(0xFFF7EFEB),
                                borderRadius: BorderRadius.circular(16.r)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.namozModel[5].categoryName ?? '',
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: context.isDark
                                        ? Colors.white
                                        : const Color(0xFF615745),
                                    fontFamily:
                                        AppfontFamily.comforta.fontFamily,
                                    fontSize: AppSizes.size_16,
                                    fontWeight: AppFontWeight.w_700,
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: Image.asset(AppImages.jamoat,
                                        width: 85))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text(state.error));
          }
        },
      ),
    );
  }
}
