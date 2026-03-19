import 'dart:io';
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
  final _passwordFocusNode = FocusNode();
  final _signupPasswordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();
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
    _passwordFocusNode.dispose();
    _signupPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
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
          Navigator.of(context).popUntil((route) => route.isFirst);
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
          UIConstants.preLoginBackground(),
          // Back button in top-left
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              tooltip: 'Back',
              style: UIConstants.preLoginIconButtonStyle(),
            ),
          ),
          // Selected broker name and settings button in top-right corner
          Positioned(
            top: 20,
            right: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (AppConfig.selectedBrokerName != null)
                  UIConstants.brokerNameChip(AppConfig.selectedBrokerName!),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _goBackToConfigSelection,
                  icon: const Icon(Icons.settings, color: Colors.white, size: 28),
                  tooltip: 'Change Configuration',
                  style: UIConstants.preLoginIconButtonStyle(),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => Process.run('open', ['-n', '-a', Platform.resolvedExecutable]),
                  icon: const Icon(Icons.open_in_new, color: Colors.white, size: 28),
                  tooltip: 'New Instance',
                  style: UIConstants.preLoginIconButtonStyle(),
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
                    filter: ImageFilter.blur(
                      sigmaX: UIConstants.glassBlurSigma,
                      sigmaY: UIConstants.glassBlurSigma,
                    ),
                    child: Container(
                      width: 360,
                      padding: const EdgeInsets.all(32.0),
                      decoration: UIConstants.glassCardDecoration(),
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
                    const SizedBox(height: UIConstants.spacingMd),

                    // Username Field
                    TextFormField(
                      controller: _userController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
                      style: const TextStyle(color: Colors.black, fontSize: UIConstants.textFieldFontSize),
                      decoration: UIConstants.preLoginInputDecoration(
                        hintText: 'Enter your username',
                        prefixIcon: Icons.person,
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
                      focusNode: _passwordFocusNode,
                      obscureText: !_isPasswordVisible,
                      style: const TextStyle(color: Colors.black, fontSize: UIConstants.textFieldFontSize),
                      decoration: UIConstants.preLoginInputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: Icons.lock,
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

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: UIConstants.loginButtonHeight * 0.8,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: UIConstants.preLoginButtonStyle(),
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
                    const SizedBox(height: UIConstants.spacingSm),

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
                              color: UIConstants.colorCommand,
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
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => _signupPasswordFocusNode.requestFocus(),
            style: const TextStyle(color: Colors.black, fontSize: UIConstants.textFieldFontSize),
            decoration: UIConstants.preLoginInputDecoration(
              hintText: 'Enter your username',
              prefixIcon: Icons.person,
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
            focusNode: _signupPasswordFocusNode,
            obscureText: !_isSignupPasswordVisible,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) => _confirmPasswordFocusNode.requestFocus(),
            style: const TextStyle(color: Colors.black, fontSize: UIConstants.textFieldFontSize),
            decoration: UIConstants.preLoginInputDecoration(
              hintText: 'Create a password',
              prefixIcon: Icons.lock,
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
            focusNode: _confirmPasswordFocusNode,
            obscureText: !_isConfirmPasswordVisible,
            textInputAction: TextInputAction.go,
            onFieldSubmitted: (_) => _isLoading ? null : _handleSignup(),
            style: const TextStyle(color: Colors.black, fontSize: UIConstants.textFieldFontSize),
            decoration: UIConstants.preLoginInputDecoration(
              hintText: 'Confirm your password',
              prefixIcon: Icons.lock_outline,
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
            height: UIConstants.loginButtonHeight,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleSignup,
              style: UIConstants.preLoginButtonStyle(),
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
                    color: UIConstants.colorCommand,
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
