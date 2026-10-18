import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/errors/app_exceptions.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../controllers/session_controller.dart';
import '../../widgets/primary_button.dart';

/// Sign-in with two modes: password and one-time password (OTP).
///
/// Business calls go through [SessionController]; the screen owns only
/// form/UI state (tab index, controllers, submitting flag).
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs = TabController(length: 2, vsync: this);

  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  bool _submitting = false;
  bool _obscure = true;
  bool _otpSent = false;

  @override
  void dispose() {
    _tabs.dispose();
    _identifierController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _submitPassword() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    try {
      await ref.read(sessionControllerProvider.notifier).signInWithPassword(
            identifier: _identifierController.text.trim(),
            password: _passwordController.text,
          );
      if (mounted) context.go(RouteNames.home);
    } on AppException catch (e) {
      _showError(e.message);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Future<void> _sendOtp() async {
    final phoneError = Validators.phone(_phoneController.text);
    if (phoneError != null) {
      _showError(phoneError);
      return;
    }
    setState(() => _submitting = true);
    try {
      final otp = await ref
          .read(sessionControllerProvider.notifier)
          .requestOtp(phone: _phoneController.text.trim());
      if (!mounted) return;
      setState(() {
        _otpSent = true;
        _submitting = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Demo OTP: $otp (sent to your phone)')),
      );
    } on AppException catch (e) {
      if (mounted) {
        setState(() => _submitting = false);
        _showError(e.message);
      }
    }
  }

  Future<void> _verifyOtp() async {
    final code = _otpController.text.trim();
    if (Validators.otp(code) != null) {
      _showError('Enter the 6-digit code we sent you');
      return;
    }
    setState(() => _submitting = true);
    try {
      await ref.read(sessionControllerProvider.notifier).verifyOtp(
            phone: _phoneController.text.trim(),
            code: code,
          );
      if (mounted) context.go(RouteNames.home);
    } on AppException catch (e) {
      _showError(e.message);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome back',
                    style: theme.textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to continue your royal journey',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          TabBar(
                            controller: _tabs,
                            dividerColor: Colors.transparent,
                            indicatorColor: AppColors.crimson,
                            labelColor: AppColors.crimson,
                            unselectedLabelColor:
                                theme.colorScheme.onSurfaceVariant,
                            tabs: const [
                              Tab(text: 'Password'),
                              Tab(text: 'OTP'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: _otpSent ? 210 : 170,
                            child: TabBarView(
                              controller: _tabs,
                              children: [
                                _passwordForm(theme),
                                _otpForm(theme),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New to Vivaah Royal?',
                        style: theme.textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: () => context.go(RouteNames.register),
                        child: const Text('Create account'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Demo build — any valid credentials work.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordForm(ThemeData theme) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            controller: _identifierController,
            decoration: const InputDecoration(
              labelText: 'Email or mobile number',
              prefixIcon: Icon(Icons.alternate_email_rounded),
            ),
            validator: (v) {
              final emailError = Validators.email(v);
              final phoneError = Validators.phone(v);
              if (emailError == null || phoneError == null) return null;
              return 'Enter a valid email or mobile number';
            },
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscure,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
            ),
            validator: Validators.password,
            onFieldSubmitted: (_) => _submitPassword(),
          ),
          const SizedBox(height: 18),
          PrimaryButton(
            label: 'Sign In',
            icon: Icons.login_rounded,
            isLoading: _submitting,
            onPressed: _submitPassword,
          ),
        ],
      ),
    );
  }

  Widget _otpForm(ThemeData theme) {
    return Column(
      children: [
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Mobile number',
            prefixIcon: Icon(Icons.phone_android_rounded),
            prefixText: '+91 ',
          ),
          validator: Validators.phone,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: _otpController,
          enabled: _otpSent,
          keyboardType: TextInputType.number,
          maxLength: 6,
          decoration: InputDecoration(
            labelText: _otpSent ? '6-digit code' : 'Request the code first',
            prefixIcon: const Icon(Icons.password_rounded),
            counterText: '',
          ),
        ),
        const SizedBox(height: 18),
        PrimaryButton(
          label: _otpSent ? 'Verify & Sign In' : 'Send OTP',
          icon: _otpSent
              ? Icons.verified_rounded
              : Icons.sms_outlined,
          isLoading: _submitting,
          onPressed: _otpSent ? _verifyOtp : _sendOtp,
        ),
      ],
    );
  }
}
