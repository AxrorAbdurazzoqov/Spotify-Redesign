import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:spotify/src/core/constants/color/color_const.dart';
import 'package:spotify/src/core/extensions/get_text_theme.dart';

class CustomSupportRichText extends StatelessWidget {
  final VoidCallback onError;

  const CustomSupportRichText({
    super.key,
    required this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'If you need any support\t',
        style: context.textSmall!.copyWith(color: ColorConst.instance.grey),
        children: [
          TextSpan(
            text: 'Click Here',
            style: context.textSmall!.copyWith(color: ColorConst.instance.lightGreen),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final Email email = Email(
                  body: 'Please provide your support details here.',
                  subject: 'Support Request',
                  recipients: [
                    'ballistixgame@gmail.com'
                  ],
                  isHTML: false,
                );

                try {
                  await FlutterEmailSender.send(email);
                } catch (error) {
                  onError;
                }
              },
          ),
        ],
      ),
    );
  }
}
