import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  static const Color backgroundColor = Color(0xFFF8F9FE);
  static const Color darkTextColor = Color(0xFF11183F);
  static const Color secondaryTextColor = Color(0xFF7B86A8);
  static const Color purpleColor = Color(0xFF6048F5);
  static const Color lightBorderColor = Color(0xFFD9DDEA);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (route) => false,
      );
    }
  }

  void _googleSignUp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Google sign-up selected'),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home',
      (route) => false,
    );
  }

  void _openLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  // Reduced outer padding so the card has more width.
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 44),

                        // --------------------------------------------------
                        // LOGO
                        // --------------------------------------------------
                        Container(
                          width: 74,
                          height: 74,
                          decoration: const BoxDecoration(
                            color: purpleColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.school_rounded,
                            size: 45,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 25),

                        // --------------------------------------------------
                        // TITLE
                        // --------------------------------------------------
                        const Text(
                          'Create Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: darkTextColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Sign up to start your study journey',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // --------------------------------------------------
                        // SIGNUP FORM CARD
                        // --------------------------------------------------
                        Container(
                          width: double.infinity,

                          // Less internal horizontal padding.
                          padding: const EdgeInsets.fromLTRB(
                            20,
                            25,
                            20,
                            25,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.10),
                                blurRadius: 18,
                                offset: const Offset(0, 7),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Full Name
                              _SignUpField(
                                controller: _nameController,
                                hintText: 'Full Name',
                                icon: Icons.person_outline_rounded,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty) {
                                    return 'Please enter your full name';
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 14),

                              // Email Address
                              _SignUpField(
                                controller: _emailController,
                                hintText: 'Email Address',
                                icon: Icons.mail_outline_rounded,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty) {
                                    return 'Please enter your email';
                                  }

                                  if (!value.contains('@') ||
                                      !value.contains('.')) {
                                    return 'Please enter a valid email';
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 14),

                              // Password
                              _SignUpField(
                                controller: _passwordController,
                                hintText: 'Password',
                                icon: Icons.lock_outline_rounded,
                                obscureText: _hidePassword,
                                textInputAction: TextInputAction.next,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _hidePassword = !_hidePassword;
                                    });
                                  },
                                  icon: Icon(
                                    _hidePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: purpleColor,
                                    size: 21,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  }

                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 14),

                              // Confirm Password
                              _SignUpField(
                                controller: _confirmPasswordController,
                                hintText: 'Confirm Password',
                                icon: Icons.lock_outline_rounded,
                                obscureText: _hideConfirmPassword,
                                textInputAction: TextInputAction.done,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _hideConfirmPassword =
                                          !_hideConfirmPassword;
                                    });
                                  },
                                  icon: Icon(
                                    _hideConfirmPassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: purpleColor,
                                    size: 21,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please confirm your password';
                                  }

                                  if (value != _passwordController.text) {
                                    return 'Passwords do not match';
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 18),

                              // ------------------------------------------------
                              // SIGN UP BUTTON
                              // ------------------------------------------------
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF684BFF),
                                        Color(0xFF5842E8),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(11),
                                    boxShadow: [
                                      BoxShadow(
                                        color: purpleColor.withValues(
                                          alpha: 0.20,
                                        ),
                                        blurRadius: 7,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ElevatedButton(
                                    onPressed: _signUp,
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(11),
                                      ),
                                    ),
                                    child: const Text(
                                      'Sign up',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 27),

                        // --------------------------------------------------
                        // OR DIVIDER
                        // --------------------------------------------------
                        const Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Color(0xFFD8DBE8),
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'or',
                                style: TextStyle(
                                  color: secondaryTextColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Color(0xFFD8DBE8),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 27),

                        // --------------------------------------------------
                        // GOOGLE BUTTON
                        // --------------------------------------------------
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: lightBorderColor,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Colors.black.withValues(alpha: 0.10),
                                  blurRadius: 7,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: _googleSignUp,
                                borderRadius: BorderRadius.circular(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      'https://developers.google.com/identity/images/g-logo.png',
                                      width: 22,
                                      height: 22,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Text(
                                          'G',
                                          style: TextStyle(
                                            color: Color(0xFF4285F4),
                                            fontSize: 22,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        );
                                      },
                                    ),

                                    const SizedBox(width: 20),

                                    const Text(
                                      'Continue with Google',
                                      style: TextStyle(
                                        color: darkTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 42),

                        // --------------------------------------------------
                        // LOGIN LINK
                        // --------------------------------------------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: secondaryTextColor,
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: _openLogin,
                              child: const Text(
                                'Log in',
                                style: TextStyle(
                                  color: purpleColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 38),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SIGNUP FIELD
// ---------------------------------------------------------------------------

class _SignUpField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const _SignUpField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        validator: validator,
        cursorColor: _SignUpScreenState.purpleColor,
        style: const TextStyle(
          color: _SignUpScreenState.darkTextColor,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: _SignUpScreenState.secondaryTextColor,
            fontSize: 15,
          ),
          prefixIcon: Icon(
            icon,
            color: _SignUpScreenState.purpleColor,
            size: 21,
          ),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 17,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: _SignUpScreenState.lightBorderColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: _SignUpScreenState.purpleColor,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.redAccent,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.redAccent,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}