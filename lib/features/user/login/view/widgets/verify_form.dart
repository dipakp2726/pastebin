import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pastebin/features/user/login/providers/providers.dart';
import 'package:pastebin/features/user/login/view/widgets/resend_timer.dart';
import 'package:pastebin/features/user/profile/view/pages/homepage.dart';
import 'package:pastebin/features/user/profile/view/pages/pages.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerifyForm extends StatelessWidget {
  const VerifyForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xlg + AppSpacing.sm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: AppSpacing.xxlg,
                ),
                const AppBackButton(),
                const SizedBox(
                  height: AppSpacing.xxlg * 2,
                ),
                const _EnterDigitText(),
                const SizedBox(
                  height: AppSpacing.xxlg * 2,
                ),
                const _OtpField(),
                const SizedBox(
                  height: AppSpacing.xxlg,
                ),
                ResendCodeTimer(
                  onTimerFinished: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                const SizedBox(
                  height: AppSpacing.xxlg * 2,
                ),
                const _ConfirmButton(),
                const SizedBox(
                  height: AppSpacing.xxlg,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EnterDigitText extends StatelessWidget {
  const _EnterDigitText();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Enter 4 digit verification code sent to your number',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: AppFontWeight.medium,
          ),
    );
  }
}

class _OtpField extends ConsumerStatefulWidget {
  const _OtpField();

  @override
  ConsumerState<_OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends ConsumerState<_OtpField> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(otpProvider, (previous, next) {});

    return SizedBox(
      height: 44,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: PinFieldAutoFill(
          controller: controller,
          autoFocus: true,
          onCodeChanged: (value) {
            ref.read(otpProvider.notifier).state = value ?? '';
          },
          enableInteractiveSelection: false,
          codeLength: 6,
          onCodeSubmitted: (String otp) {},
          decoration: BoxLooseDecoration(
            gapSpace: 12,
            strokeColorBuilder: PinListenColorBuilder(
              AppColors.secondary.withOpacity(.3),
              AppColors.secondary.withOpacity(.3),
            ),
          ),
        ),
      ),
    );
  }
}

class _ConfirmButton extends ConsumerWidget {
  const _ConfirmButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 62,
      child: AppButton.yellow(
        textStyle: Theme.of(context).textTheme.headlineSmall,
        onPressed: () async {
          final otp = ref.read(otpProvider);

          if (otp.length == 6) {
            final phone = ref.read(phoneRequestIdProvider);

            try {
              // ignore: unused_local_variable
              final resp = await ref
                  .read(phoneAuthProvider.notifier)
                  .verifyOtp(phone, otp);

              if (context.mounted) {
                if (resp) {
                  /// goto home page

                  unawaited(Navigator.push(context, HomePage.route()));
                } else {
                  unawaited(Navigator.push(context, ProfilePage.route()));
                }
              }
            } catch (err) {
              if (context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(err.toString())));
              }
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please Enter otp')),
            );
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: AppSpacing.xxlg),
              child: Text('Confirm'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.lg),
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(CupertinoIcons.chevron_right),
              ),
            )
          ],
        ),
      ),
    );
  }
}
