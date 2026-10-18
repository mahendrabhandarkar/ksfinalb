import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/errors/app_exceptions.dart';
import '../../../core/router/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/validators.dart';
import '../../../domain/entities/profile.dart';
import '../../../domain/entities/user.dart';
import '../../controllers/session_controller.dart';

/// Four-step registration mirroring the website wizard:
/// account → community → career → about you.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _about = TextEditingController();

  Gender _gender = Gender.male;
  String _religion = 'Hindu';
  final TextEditingController _community = TextEditingController();
  String _motherTongue = 'Hindi';
  String _education = 'B.Tech';
  String _profession = 'Software Engineer';
  String _city = 'Mumbai';
  MaritalStatus _maritalStatus = MaritalStatus.neverMarried;
  Diet _diet = Diet.vegetarian;

  int _step = 0;
  bool _submitting = false;
  bool _obscure = true;

  static const List<String> _religions = [
    'Hindu', 'Muslim', 'Christian', 'Sikh', 'Jain', 'Buddhist', 'Other',
  ];
  static const List<String> _tongues = [
    'Hindi', 'Marathi', 'Gujarati', 'Punjabi', 'Tamil', 'Telugu', 'Kannada',
    'Malayalam', 'Bengali', 'Odia', 'Urdu', 'Konkani', 'English',
  ];
  static const List<String> _educations = [
    'B.Tech', 'M.Tech', 'B.E', 'MBBS', 'MD Medicine', 'BDS', 'LLB', 'CA',
    'MBA', 'M.Sc', 'Ph.D', 'B.Com', 'M.Com', 'B.A', 'M.A', 'BBA', 'B.Des',
    'B.Arch',
  ];
  static const List<String> _professions = [
    'Software Engineer', 'Data Scientist', 'Product Manager', 'Doctor',
    'Chartered Accountant', 'Corporate Lawyer', 'Architect', 'Professor',
    'Business Owner', 'Investment Banker', 'UX Designer', 'Research Scientist',
    'School Principal', 'Paediatrician', 'Dentist', 'Brand Manager',
    'Data Analyst', 'Finance Controller', 'Heritage Hotelier', 'Physician',
  ];
  static const List<String> _cities = [
    'Mumbai', 'New Delhi', 'Bengaluru', 'Hyderabad', 'Chennai', 'Pune',
    'Kolkata', 'Ahmedabad', 'Jaipur', 'Lucknow', 'Kochi', 'Goa', 'Chandigarh',
    'Gurugram', 'Noida', 'Indore', 'Nagpur', 'Vadodara', 'Amritsar', 'Udaipur',
  ];

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    _about.dispose();
    _community.dispose();
    super.dispose();
  }

  bool _validateCurrentStep() {
    if (_step != 0) return true;
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return false;
    return true;
  }

  Future<void> _submit() async {
    if (!_validateCurrentStep()) return;
    setState(() => _submitting = true);
    try {
      await ref.read(sessionControllerProvider.notifier).register(
            RegisterFormData(
              fullName: _name.text.trim(),
              email: _email.text.trim(),
              phone: _phone.text.trim(),
              gender: _gender,
              religion: _religion,
              community: _community.text.trim().isEmpty
                  ? _religion
                  : _community.text.trim(),
              motherTongue: _motherTongue,
              education: _education,
              profession: _profession,
              city: _city,
              maritalStatus: _maritalStatus,
              diet: _diet,
              about: _about.text.trim(),
            ),
          );
      if (mounted) context.go(RouteNames.home);
    } on AppException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(e.message)));
        setState(() => _submitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create your profile'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                'Step ${_step + 1} of 4',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (_step + 1) / 4,
              minHeight: 5,
              borderRadius: BorderRadius.circular(4),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                autovalidateMode: _step == 0
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _stepBody(_step),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                children: [
                  if (_step > 0)
                    OutlinedButton(
                      onPressed: () => setState(() => _step--),
                      child: const Text('Back'),
                    ),
                  const Spacer(),
                  if (_step < 3)
                    FilledButton(
                      onPressed: () {
                        if (_validateCurrentStep()) {
                          setState(() => _step++);
                        }
                      },
                      child: const Text('Continue'),
                    )
                  else
                    FilledButton.icon(
                      onPressed: _submitting ? null : _submit,
                      icon: _submitting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.workspace_premium_rounded),
                      label: const Text('Create Account'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepBody(int step) {
    switch (step) {
      case 0:
        return _accountStep();
      case 1:
        return _communityStep();
      case 2:
        return _careerStep();
      default:
        return _aboutStep();
    }
  }

  Widget _accountStep() => Column(
        key: const ValueKey<int>(0),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _StepTitle('Basic details'),
          TextFormField(
            controller: _name,
            decoration: const InputDecoration(
              labelText: 'Full name', prefixIcon: Icon(Icons.person_outline),
            ),
            validator: Validators.name,
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<Gender>(
            initialValue: _gender,
            decoration: const InputDecoration(
              labelText: 'I am a', prefixIcon: Icon(Icons.wc_rounded),
            ),
            items: const [
              DropdownMenuItem(value: Gender.male, child: Text('Male')),
              DropdownMenuItem(value: Gender.female, child: Text('Female')),
            ],
            onChanged: (v) => setState(() => _gender = v ?? Gender.male),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email', prefixIcon: Icon(Icons.alternate_email_rounded),
            ),
            validator: Validators.email,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _phone,
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
            controller: _password,
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
          ),
        ],
      );

  Widget _communityStep() => Column(
        key: const ValueKey<int>(1),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _StepTitle('Religious & community background'),
          DropdownButtonFormField<String>(
            initialValue: _religion,
            decoration: const InputDecoration(
              labelText: 'Religion', prefixIcon: Icon(Icons.temple_hindu_rounded),
            ),
            items: _religions
                .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                .toList(),
            onChanged: (v) => setState(() => _religion = v ?? _religion),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _community,
            decoration: const InputDecoration(
              labelText: 'Community / caste (optional)',
              prefixIcon: Icon(Icons.groups_rounded),
            ),
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            initialValue: _motherTongue,
            decoration: const InputDecoration(
              labelText: 'Mother tongue',
              prefixIcon: Icon(Icons.translate_rounded),
            ),
            items: _tongues
                .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                .toList(),
            onChanged: (v) => setState(() => _motherTongue = v ?? _motherTongue),
          ),
        ],
      );

  Widget _careerStep() => Column(
        key: const ValueKey<int>(2),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _StepTitle('Education & career'),
          DropdownButtonFormField<String>(
            initialValue: _education,
            decoration: const InputDecoration(
              labelText: 'Highest education',
              prefixIcon: Icon(Icons.school_rounded),
            ),
            items: _educations
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => setState(() => _education = v ?? _education),
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            initialValue: _profession,
            decoration: const InputDecoration(
              labelText: 'Profession', prefixIcon: Icon(Icons.work_outline),
            ),
            items: _professions
                .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                .toList(),
            onChanged: (v) => setState(() => _profession = v ?? _profession),
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            initialValue: _city,
            decoration: const InputDecoration(
              labelText: 'City', prefixIcon: Icon(Icons.location_city_rounded),
            ),
            items: _cities
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (v) => setState(() => _city = v ?? _city),
          ),
        ],
      );

  Widget _aboutStep() => Column(
        key: const ValueKey<int>(3),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _StepTitle('About you'),
          DropdownButtonFormField<MaritalStatus>(
            initialValue: _maritalStatus,
            decoration: const InputDecoration(
              labelText: 'Marital status',
              prefixIcon: Icon(Icons.favorite_outline),
            ),
            items: MaritalStatus.values
                .map(
                  (m) => DropdownMenuItem(value: m, child: Text(m.label)),
                )
                .toList(),
            onChanged: (v) =>
                setState(() => _maritalStatus = v ?? _maritalStatus),
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<Diet>(
            initialValue: _diet,
            decoration: const InputDecoration(
              labelText: 'Diet', prefixIcon: Icon(Icons.restaurant_rounded),
            ),
            items: Diet.values
                .map((d) => DropdownMenuItem(value: d, child: Text(d.label)))
                .toList(),
            onChanged: (v) => setState(() => _diet = v ?? _diet),
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _about,
            minLines: 4,
            maxLines: 6,
            maxLength: 500,
            decoration: const InputDecoration(
              labelText: 'About you and your family',
              alignLabelWithHint: true,
            ),
          ),
        ],
      );
}

class _StepTitle extends StatelessWidget {
  const _StepTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          Container(
            width: 46,
            height: 4,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.gold, AppColors.goldLight],
              ),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}
