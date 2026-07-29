import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLogin,
    required this.isLoading,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final bool isLoading;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _rememberMe = false;
  bool _obscurePassword = true;

  InputDecoration _inputDecoration({
    required String hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(
          color: Color(0xffD6D6D6),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 1.6,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: _inputDecoration(
            hint: 'Email',
          ),
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: widget.passwordController,
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => widget.onLogin(),
          decoration: _inputDecoration(
            hint: 'Password',
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: Checkbox(
                value: _rememberMe,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value ?? false;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Remember me',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Silakan hubungi Bagian Akademik untuk reset password.',
                    ),
                  ),
                );
              },
              child: const Text(
                'Lupa Password',
                style: TextStyle(
                  color: Color(0xffC96A00),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: widget.isLoading ? null : widget.onLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: widget.isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    'Masuk',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
