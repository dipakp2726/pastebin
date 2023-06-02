import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pastebin/features/user/login/providers/phone_provider.dart';
import 'package:pastebin/features/user/login/view/pages/pages.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ref.listen(phoneProvider, (previous, next) {});
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
                const SizedBox(height: AppSpacing.xxlg),
                const _HeaderImage(),
                const _HeaderText(),
                const SizedBox(height: AppSpacing.xxlg),
                _PhoneNumberField(_formKey),
                const Spacer(),
                const SizedBox(
                  height: AppSpacing.xxlg * 2,
                ),
                _NextButton(_formKey),
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

class _HeaderText extends StatelessWidget {
  const _HeaderText();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Text(
      'Login with Phone number',
      style: textTheme.headlineMedium,
    );
  }
}

class _PhoneNumberField extends ConsumerWidget {
  const _PhoneNumberField(this.formKey);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: formKey,
      child: TextFormField(
        style: textTheme.bodyLarge!.copyWith(color: AppColors.grey),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Text(
              '+91',
              style: textTheme.headlineSmall,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 32,
          ),
          hintText: 'Enter your mobile number',
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
        ],
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter mobile number';
          } else if (value.length != 10) {
            return 'Please enter valid mobile number';
          }
          return null;
        },
        onChanged: (val) {
          ref.read(phoneProvider.notifier).state = val;
        },
      ),
    );
  }
}

class _HeaderImage extends StatelessWidget {
  const _HeaderImage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 50,
        ),
        child: Assets.images.login.image(
          color: AppColors.secondary,
        ),
      ),
    );
  }
}

class _NextButton extends ConsumerWidget {
  const _NextButton(this.formKey);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 62,
      child: AppButton.yellow(
        textStyle: Theme.of(context).textTheme.headlineSmall,
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            final phone = ref.read(phoneProvider);

            final resp =
                await ref.read(phoneAuthProvider.notifier).sendOtp(phone);

            if (resp.hasValue) {
              final val = resp.value as Map<String, dynamic>;

              final requestId = val['request_id'] as String;

              if (context.mounted) {
                await Navigator.push(
                  context,
                  VerifyPage.route(phoneNumber: requestId),
                );
              }
            } else {
              final err = resp.error.toString();

              if (context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(err)));
              }
            }
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: AppSpacing.xxlg),
              child: Text('Next'),
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

void callErrorDialog(BuildContext context, String message) {}
