import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lexi_learn/core/Const/app_images.dart';
import 'package:lexi_learn/core/widgets/custom_appbar.dart';
import '../../../core/Const/app_colors.dart';
import '../../../core/helpers/date_formatter.dart';
import '../../../core/utils/app_sizes.dart';
import '../../../core/widgets/custom_input_textfield.dart';
import '../../../core/widgets/custom_text_widget.dart';
import '../../../core/widgets/custom_toast_show.dart';
import '../controller/ai_controller.dart';

class AiChatScreen extends StatelessWidget {
  AiChatScreen({super.key});

  AiChatController controller = Get.find<AiChatController>();
  AppSizes appSizes = AppSizes();
  ToastClass toast = ToastClass();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: CustomAppBar(title: "Chat with Ai", goBack: true),
          body: Container(
            width: appSizes.getWidthPercentage(100),
            height: appSizes.getHeightPercentage(100),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.background),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Obx(
                    () =>
                        controller.messages.isNotEmpty
                            ? ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 6,
                              ),
                              itemCount: controller.messages.length,
                              itemBuilder: (context, index) {
                                final message = controller.messages[index];
                                final isMe = message.isMe;
                                final time = DateFormatter.formatDate(
                                  message.timestamp,
                                );
                                return GestureDetector(
                                  onLongPress: () {
                                    Clipboard.setData(
                                      ClipboardData(text: message.text),
                                    ).then(
                                      (value) => toast.showCustomToast(
                                        "Text copied successfully!",
                                      ),
                                    );
                                  },
                                  child: Align(
                                    alignment:
                                        isMe
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          isMe
                                              ? CrossAxisAlignment.end
                                              : CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            left:
                                                isMe
                                                    ? appSizes
                                                        .getWidthPercentage(10)
                                                    : 6,
                                            right:
                                                !isMe
                                                    ? appSizes
                                                        .getWidthPercentage(10)
                                                    : 6,
                                            top: 4,
                                            bottom: 4,
                                          ),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color:
                                                isMe
                                                    ? AppColors.orange
                                                    : AppColors.orange2,
                                            borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  const Radius.circular(14),
                                              bottomLeft: const Radius.circular(
                                                16,
                                              ),
                                              topRight:
                                                  isMe
                                                      ? const Radius.circular(0)
                                                      : const Radius.circular(
                                                        16,
                                                      ),
                                              topLeft:
                                                  isMe
                                                      ? const Radius.circular(
                                                        16,
                                                      )
                                                      : const Radius.circular(
                                                        0,
                                                      ),
                                            ),
                                          ),
                                          child: CustomTextWidget(
                                            text: message.text,
                                            textColor:
                                                isMe
                                                    ? AppColors.white
                                                    : AppColors.black,
                                            fontSize: 14,
                                            textOverflow: TextOverflow.visible,
                                            textAlign: TextAlign.start,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 12,
                                            right: 12,
                                          ),
                                          child: CustomTextWidget(
                                            text: time,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            textColor: AppColors.whitish,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                            : Center(
                              child: CustomTextWidget(
                                text: "Ai Chat not found",

                                textColor: AppColors.whitish2,
                              ),
                            ),
                  ),
                ),
                Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomInputTextField(
                          hintText: 'Type message...',
                          borderColor: AppColors.white,
                          isFilled: true,
                          textEditingController: controller.messageController,
                          labelText: 'Message',
                        ),
                      ),
                      const Gap(8),
                      GestureDetector(
                        onTap: controller.toggleListening,
                        child: CircleAvatar(
                          backgroundColor: controller.isListening.value
                              ? AppColors.orange
                              : AppColors.white,
                          radius: 26,
                          child: Icon(
                            controller.isListening.value ? Icons.mic : Icons.mic_none,
                            color: controller.isListening.value
                                ? AppColors.white
                                : AppColors.orange,
                          ),
                        ),
                      ),
                      const Gap(6),
                      ElevatedButton(
                        onPressed: () {
                          controller.sendMessage(controller.messageController.text);
                          controller.messageController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(10),
                          backgroundColor: AppColors.white,
                        ),
                        child: const Icon(Icons.send, color: AppColors.orange, size: 29),
                      ),
                    ],
                  ),
                ))

              ],
            ),
          ),
        );
      },
    );
  }
}
