import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_bible/l10n/app_localizations.dart';

import 'package:the_bible/core/router/app_router.dart';
import 'package:the_bible/features/auth/domain/params/create_user_params.dart';
import 'package:the_bible/features/auth/domain/params/update_token_params.dart';
import 'package:the_bible/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:the_bible/features/auth/presentation/bloc/auth_event.dart';
import 'package:the_bible/features/auth/presentation/bloc/auth_state.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _loginFormKey = GlobalKey<FormState>();
  final _signUpFormKey = GlobalKey<FormState>();

  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  final _signUpNameController = TextEditingController();
  final _signUpEmailController = TextEditingController();
  final _signUpPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _signUpNameController.dispose();
    _signUpEmailController.dispose();
    _signUpPasswordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value, AppLocalizations l10n) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return l10n.emailRequiredError;
    if (!text.contains('@') || !text.contains('.')) {
      return l10n.emailInvalidError;
    }
    return null;
  }

  String? _validatePassword(String? value, AppLocalizations l10n) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return l10n.passwordRequiredError;
    if (text.length < 6) return l10n.passwordMinLengthError;
    return null;
  }

  String? _validateName(String? value, AppLocalizations l10n) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return l10n.nameRequiredError;
    return null;
  }

  Future<void> _handleLogin() async {
    if (!(_loginFormKey.currentState?.validate() ?? false)) return;
    context.read<AuthBloc>().add(
      AuthLoginSubmitted(
        UpdateTokenParams(
        email: _loginEmailController.text.trim(),
        password: _loginPasswordController.text.trim(),
        ),
      ),
    );
  }

  Future<void> _handleSignUp() async {
    if (!(_signUpFormKey.currentState?.validate() ?? false)) return;
    final notifications = context.read<AuthBloc>().state.notifications;
    context.read<AuthBloc>().add(
      AuthSignUpSubmitted(
        CreateUserParams(
        name: _signUpNameController.text.trim(),
        email: _signUpEmailController.text.trim(),
        password: _signUpPasswordController.text.trim(),
        notifications: notifications,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.failure && state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          context.read<AuthBloc>().add(const AuthFeedbackCleared());
        }
        if (state.status == AuthStatus.success) {
          context.go(AppRouter.home);
          context.read<AuthBloc>().add(const AuthFeedbackCleared());
        }
      },
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.authTitle),
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: l10n.loginTab),
                Tab(text: l10n.signUpTab),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _AuthFormCard(
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _loginEmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: l10n.emailLabel),
                        validator: (value) => _validateEmail(value, l10n),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _loginPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: l10n.passwordLabel,
                        ),
                        validator: (value) => _validatePassword(value, l10n),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.isSubmitting ? null : _handleLogin,
                          child: state.isSubmitting
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(l10n.loginButton),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _AuthFormCard(
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _signUpNameController,
                        decoration: InputDecoration(labelText: l10n.nameLabel),
                        validator: (value) => _validateName(value, l10n),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _signUpEmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: l10n.emailLabel),
                        validator: (value) => _validateEmail(value, l10n),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _signUpPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: l10n.passwordLabel,
                        ),
                        validator: (value) => _validatePassword(value, l10n),
                      ),
                      const SizedBox(height: 8),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: state.notifications,
                        title: Text(l10n.receiveNotifications),
                        onChanged: (value) {
                          context.read<AuthBloc>().add(
                            AuthNotificationsToggled(value),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.isSubmitting ? null : _handleSignUp,
                          child: state.isSubmitting
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(l10n.createAccountButton),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AuthFormCard extends StatelessWidget {
  const _AuthFormCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
