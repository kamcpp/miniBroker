import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../services/auth_service.dart';
import '../utils/connectivity_checker.dart';
import '../main.dart';
import '../config/app_config.dart';
import '../config/ui_constants.dart';
import '../widgets/copyright_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  final _signupUserController = TextEditingController();
  final _signupPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isSignupPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool _showSignup = false;

  @override
  void initState() {
    super.initState();

    // Check server connectivity when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConnectivityChecker.checkAndShowErrorIfNeeded(context, 'Login');
    });

    _flipController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _flipAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _flipController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _flipController.dispose();
    _userController.dispose();
    _passwordController.dispose();
    _signupUserController.dispose();
    _signupPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _flipToSignup() async {
    if (!_showSignup) {
      // Rotate to 90 degrees (edge view - invisible)
      await _flipController.animateTo(0.5);
      // Switch content when invisible
      setState(() {
        _showSignup = true;
      });
      // Continue rotation from 90 to 180 degrees
      await _flipController.forward();
    }
  }

  void _flipToLogin() async {
    if (_showSignup) {
      // Rotate from 180 to 90 degrees (edge view - invisible)
      await _flipController.animateTo(0.5);
      // Switch content when invisible
      setState(() {
        _showSignup = false;
      });
      // Continue rotation from 90 to 0 degrees
      await _flipController.reverse();
    }
  }

  Future<void> _handleSignup() async {
    if (!_signupFormKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final result = await authService.signup(
        _signupUserController.text.trim(),
        _signupPasswordController.text,
        _confirmPasswordController.text,
      );

      if (mounted) {
        if (result.isFullySuccessful) {
          // Both local and server succeeded - show green success
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 4),
            ),
          );
        } else if (result.localSuccess) {
          // Local succeeded but server failed - show orange warning
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.message),
              backgroundColor: Colors.orange,
              duration: const Duration(seconds: 5),
            ),
          );
        }

        _signupUserController.clear();
        _signupPasswordController.clear();
        _confirmPasswordController.clear();

        _flipToLogin();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final success = await authService.login(
        _userController.text.trim(),
        _passwordController.text,
      );

      if (success) {
        if (mounted) {
          // The Consumer<AuthService> in the main app will automatically detect the state change
          // and rebuild to show the home page - no navigation needed
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid username or password'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _goBackToConfigSelection() async {
    // Navigate back to config selection by restarting the app initialization
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MyApp()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/chart-background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Semi-transparent overlay for fading
          Container(
            color: const Color(0xFF1a1754).withOpacity(0.9), // 90% fade with dark blue
          ),
          // Selected broker name and settings button in top-right corner
          Positioned(
            top: 20,
            right: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Broker name chip
                if (AppConfig.selectedBrokerName != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.business,
                          color: Colors.white70,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          AppConfig.selectedBrokerName!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(width: 8),
                // Settings button
                IconButton(
                  onPressed: _goBackToConfigSelection,
                  icon: const Icon(Icons.settings, color: Colors.white, size: 28),
                  tooltip: 'Change Configuration',
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    padding: const EdgeInsets.all(12),
                  ),
                ),
              ],
            ),
          ),
          // Main content
          Center(
        child: SingleChildScrollView(
          padding: UIConstants.paddingStandard,
          child: AnimatedBuilder(
            animation: _flipAnimation,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(_flipAnimation.value * 3.14159),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(UIConstants.borderRadiusLg),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      width: 360,
                      padding: const EdgeInsets.all(32.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(UIConstants.borderRadiusLg),
                        border: Border.all(
                          color: Colors.white,
                          width: 0.4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 0),
                            spreadRadius: 3,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: _showSignup
                          ? Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(3.14159),
                              child: _buildSignupForm(),
                            )
                          : _buildLoginForm(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
          ),
          // Copyright status bar at bottom
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CopyrightBar(isDarkTheme: true),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Login Title
                    const Text(
                      'Welcome Back Investor!',
                      style: TextStyle(
                        fontSize: UIConstants.fontSizeXl,
                        fontWeight: UIConstants.fontWeightMedium,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: UIConstants.spacingLg),

                    // Username Field
                    TextFormField(
                      controller: _userController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(color: Colors.black, fontSize: UIConstants.textFieldFontSize),
                      decoration: InputDecoration(
                        hintText: 'Enter your username',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: UIConstants.textFieldFontSize),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        contentPadding: UIConstants.textFieldPadding,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                          borderSide: const BorderSide(color: Color(0xFF1a1754), width: 2),
                        ),
                        prefixIcon: const Icon(Icons.person, color: Colors.grey, size: UIConstants.textFieldIconSize),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        if (value.length < 5) {
                          return 'Username must be at least 5 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: UIConstants.spacingMd),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      style: const TextStyle(color: Colors.black, fontSize: UIConstants.textFieldFontSize),
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: UIConstants.textFieldFontSize),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        prefixIcon: const Icon(Icons.lock, color: Colors.grey, size: UIConstants.textFieldIconSize),
                        suffixIcon: IconButton(
                          focusNode: FocusNode(skipTraversal: true),
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                            size: 18,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        contentPadding: UIConstants.textFieldPadding,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                          borderSide: const BorderSide(color: Color(0xFF1a1754), width: 2),
                        ),
                      ),
                      textInputAction: TextInputAction.go,
                      onFieldSubmitted: (_) => _isLoading ? null : _handleLogin(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 5) {
                          return 'Password must be at least 5 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: UIConstants.spacingMd),

                    // Forgot Password Link (hidden)
                    Visibility(
                      visible: false,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Implement forgot password
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Forgot password feature coming soon'),
                              ),
                            );
                          },
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(
                              color: Color(0xFF1a1754),
                              fontSize: UIConstants.fontSizeSm,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: UIConstants.spacingMd),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1a1754),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: UIConstants.textFieldFontSize,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: UIConstants.spacingMd),

                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: UIConstants.fontSizeSm,
                          ),
                        ),
                        TextButton(
                          onPressed: _flipToSignup,
                          child: const Text(
                            'Signup',
                            style: TextStyle(
                              color: Color(0xFF1a1754),
                              fontSize: UIConstants.fontSizeSm,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
        ],
      ),
    );
  }

  Widget _buildSignupForm() {
    return Form(
      key: _signupFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Signup Title
          const Text(
            'Signup',
            style: TextStyle(
              fontSize: UIConstants.fontSizeXl,
              fontWeight: UIConstants.fontWeightMedium,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: UIConstants.spacingLg),

          // Username Field
          TextFormField(
            controller: _signupUserController,
            keyboardType: TextInputType.text,
            style: const TextStyle(color: Colors.black, fontSize: UIConstants.textFieldFontSize),
            decoration: InputDecoration(
              hintText: 'Enter your username',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: UIConstants.textFieldFontSize),
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
              prefixIcon: const Icon(Icons.person, color: Colors.grey, size: UIConstants.textFieldIconSize),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                borderSide: const BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                borderSide: const BorderSide(color: Color(0xFF1a1754), width: 2),
              ),
              contentPadding: UIConstants.textFieldPadding,
                        isDense: true,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your username';
              }
              if (value.trim().length < 5) {
                return 'Username must be at least 5 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: UIConstants.spacingMd),

          // Password Field
          TextFormField(
            controller: _signupPasswordController,
            obscureText: !_isSignupPasswordVisible,
            style: const TextStyle(color: Colors.black, fontSize: UIConstants.textFieldFontSize),
            decoration: InputDecoration(
              hintText: 'Create a password',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: UIConstants.textFieldFontSize),
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
              prefixIcon: const Icon(Icons.lock, color: Colors.grey, size: UIConstants.textFieldIconSize),
              suffixIcon: IconButton(
                focusNode: FocusNode(skipTraversal: true),
                icon: Icon(
                  _isSignupPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isSignupPasswordVisible = !_isSignupPasswordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                borderSide: const BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                borderSide: const BorderSide(color: Color(0xFF1a1754), width: 2),
              ),
              contentPadding: UIConstants.textFieldPadding,
                        isDense: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please create a password';
              }
              if (value.length < 5) {
                return 'Password must be at least 5 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: UIConstants.spacingMd),

          // Confirm Password Field
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: !_isConfirmPasswordVisible,
            style: const TextStyle(color: Colors.black, fontSize: UIConstants.textFieldFontSize),
            decoration: InputDecoration(
              hintText: 'Confirm your password',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: UIConstants.textFieldFontSize),
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
              prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey, size: UIConstants.textFieldIconSize),
              suffixIcon: IconButton(
                focusNode: FocusNode(skipTraversal: true),
                icon: Icon(
                  _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                borderSide: const BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                borderSide: const BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                borderSide: const BorderSide(color: Color(0xFF1a1754), width: 2),
              ),
              contentPadding: UIConstants.textFieldPadding,
                        isDense: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _signupPasswordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: UIConstants.spacingLg),

          // Signup Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleSignup,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1a1754),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                ),
                elevation: 0,
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Signup',
                      style: TextStyle(
                        fontSize: UIConstants.textFieldFontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: UIConstants.spacingMd),

          // Login link
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account? ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: UIConstants.fontSizeSm,
                ),
              ),
              TextButton(
                onPressed: _flipToLogin,
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Color(0xFF1a1754),
                    fontSize: UIConstants.fontSizeSm,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
