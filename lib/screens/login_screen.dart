import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
      TextEditingController();

  final TextEditingController _passwordController =
      TextEditingController();

  bool _hidePassword = true;

  static const Color backgroundColor = Color(0xFFF8F9FE);
  static const Color darkTextColor = Color(0xFF11183F);
  static const Color secondaryTextColor = Color(0xFF7B86A8);
  static const Color purpleColor = Color(0xFF6048F5);
  static const Color lightBorderColor = Color(0xFFD9DDEA);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful'),
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

  void _googleLogin() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Google sign-in successful'),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home',
      (route) => false,
    );
  }

  void _forgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Password recovery is not implemented in this prototype.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _openSignUp() {
    Navigator.pushNamed(
      context,
      '/signup',
    );
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 98),

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
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          'Welcome Back',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: darkTextColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Log in to continue your learning journey',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: secondaryTextColor,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 36),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Email Address',
                            style: TextStyle(
                              color: darkTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),

                        _StudyTrackTextField(
                          controller: _emailController,
                          hintText: 'Enter your email',
                          prefixIcon:
                              Icons.mail_outline_rounded,
                          keyboardType:
                              TextInputType.emailAddress,
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

                        const SizedBox(height: 26),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            style: TextStyle(
                              color: darkTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),

                        _StudyTrackTextField(
                          controller: _passwordController,
                          hintText: 'Enter your password',
                          prefixIcon:
                              Icons.lock_outline_rounded,
                          obscureText: _hidePassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _hidePassword =
                                    !_hidePassword;
                              });
                            },
                            icon: Icon(
                              _hidePassword
                                  ? Icons.visibility_outlined
                                  : Icons
                                      .visibility_off_outlined,
                              color: purpleColor,
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty) {
                              return 'Please enter your password';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 8),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _forgotPassword,
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: purpleColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient:
                                  const LinearGradient(
                                colors: [
                                  Color(0xFF684BFF),
                                  Color(0xFF5842E8),
                                ],
                              ),
                              borderRadius:
                                  BorderRadius.circular(11),
                            ),
                            child: ElevatedButton(
                              onPressed: _login,
                              style:
                                  ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor:
                                    Colors.transparent,
                                shadowColor:
                                    Colors.transparent,
                                foregroundColor:
                                    Colors.white,
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                    11,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Log In',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight:
                                      FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        const Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Color(0xFFD8DBE8),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                'or',
                                style: TextStyle(
                                  color:
                                      secondaryTextColor,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Color(0xFFD8DBE8),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 27),

                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: OutlinedButton(
                            onPressed: _googleLogin,
                            style:
                                OutlinedButton.styleFrom(
                              backgroundColor:
                                  Colors.white,
                              side: const BorderSide(
                                color: lightBorderColor,
                              ),
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(
                                  10,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  'https://developers.google.com/identity/images/g-logo.png',
                                  width: 22,
                                  height: 22,
                                  errorBuilder:
                                      (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                    return const Text(
                                      'G',
                                      style: TextStyle(
                                        color:
                                            Color(0xFF4285F4),
                                        fontSize: 22,
                                        fontWeight:
                                            FontWeight.bold,
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
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don’t have an account? ',
                              style: TextStyle(
                                color:
                                    secondaryTextColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: _openSignUp,
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  color: purpleColor,
                                  fontWeight:
                                      FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),
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

class _StudyTrackTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const _StudyTrackTextField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        cursorColor:
            _LoginScreenState.purpleColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color:
                _LoginScreenState.secondaryTextColor,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: _LoginScreenState.purpleColor,
          ),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(10),
            borderSide: const BorderSide(
              color:
                  _LoginScreenState.lightBorderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(10),
            borderSide: const BorderSide(
              color:
                  _LoginScreenState.purpleColor,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.redAccent,
            ),
          ),
          focusedErrorBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(10),
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