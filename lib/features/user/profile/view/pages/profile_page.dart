import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pastebin/features/user/profile/providers/providers.dart';
import 'package:pastebin/features/user/profile/view/pages/homepage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  /// The static route for [ProfilePage]
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const ProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
      ),
      body: const SafeArea(
        child: ProfileView(),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.xlg),
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _WelcomeTitle(),
                _ProfileHint(),
                SizedBox(height: AppSpacing.lg),
                Text('Name'),
                SizedBox(
                  height: AppSpacing.md,
                ),
                _NameField(),
                Text('Email'),
                SizedBox(
                  height: AppSpacing.md,
                ),
                _EmailField(),
                Spacer(),
                SizedBox(
                  height: AppSpacing.xxlg * 2,
                ),
                _SubmitButton(),
                SizedBox(
                  height: AppSpacing.xxlg,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ProfileHint extends StatelessWidget {
  const _ProfileHint();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        'Looks like you are new here. Tell us a bit about yourself.',
      ),
    );
  }
}

class _WelcomeTitle extends StatelessWidget {
  const _WelcomeTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Welcome',
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}

class _EmailField extends ConsumerWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(emailProvider, (previous, next) {});
    return AppTextField(
      hintText: 'username@mail.com',
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        ref.read(emailProvider.notifier).state = value;
      },
    );
  }
}

class _NameField extends ConsumerWidget {
  const _NameField();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(nameProvider, (previous, next) {});
    return AppTextField(
      hintText: 'John',
      onChanged: (String value) {
        ref.read(nameProvider.notifier).state = value;
      },
    );
  }
}

class _SubmitButton extends ConsumerWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppButton.yellow(
      child: const Text('Submit'),
      onPressed: () async {
        final name = ref.read(nameProvider);
        final email = ref.read(emailProvider);

        if (name.trim().isEmpty) {
          await showErrorDialog(context, 'Please Enter name');
        } else if (email.isEmpty || !validateEmail(email)) {
          await showErrorDialog(context, 'Please Enter valid email');
        } else {
          try {
            await ref.read(
              profileSubmitProvider(name: name, email: email).future,
            );

            if (context.mounted) {
              unawaited(
                Navigator.pushReplacement(context, HomePage.route()),
              );
            }
          } on Exception catch (e) {
            await showErrorDialog(context, e.toString());
          }
        }
      },
    );
  }
}

Future<void> showErrorDialog(BuildContext context, String error) async {
  if (context.mounted) {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(error),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }
}

bool validateEmail(String value) {
  const Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  final regex = RegExp(pattern as String);

  return regex.hasMatch(value);
}
