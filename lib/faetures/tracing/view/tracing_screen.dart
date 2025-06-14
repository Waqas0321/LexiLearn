import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/Const/app_colors.dart';
import 'package:lexi_learn/core/utils/app_sizes.dart';
import 'package:lexi_learn/core/widgets/custom_appbar.dart';
import '../../../../core/Const/app_images.dart';
import '../controller/tracing_cotroller.dart';
import 'package:tracing_game/tracing_game.dart';

class TracingScreen extends StatelessWidget {
  TracingScreen({super.key});

  final TracingController controller = Get.put(TracingController());
  final AppSizes appSizes = AppSizes();

  @override
  Widget build(BuildContext context) {
    final String alphabet = Get.arguments["alphabet"];
    final bool isAlphabet = Get.arguments["isAlphabet"];
    return Scaffold(
      appBar: CustomAppBar(title: "Alphabets Trace", goBack: true),
      body: Container(
        height: appSizes.getHeightPercentage(100),
        width: appSizes.getWidthPercentage(100),
        padding: appSizes.getCustomPadding(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(appSizes.getHeightPercentage(22)),
            isAlphabet
                ? TracingCharsGame(
                  showAnchor: true,
                  traceShapeModel: [
                    TraceCharsModel(
                      chars: [
                        TraceCharModel(
                          char: alphabet.toUpperCase(),
                          traceShapeOptions: TraceShapeOptions(
                            innerPaintColor: AppColors.orange,
                          ),
                        ),
                        TraceCharModel(
                          char: alphabet.toLowerCase(),
                          traceShapeOptions: TraceShapeOptions(
                            innerPaintColor: AppColors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                : TracingWordGame(
                  showAnchor: true,
                  words: [
                    TraceWordModel(
                      word: alphabet.toUpperCase(),
                      traceShapeOptions: TraceShapeOptions(
                        innerPaintColor: AppColors.orange,
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
