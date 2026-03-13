import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../../services/auth_service.dart';
import '../../config/app_config.dart';
import '../../config/ui_constants.dart';
import '../../widgets/copyright_bar.dart';

class BrokerLoginPage extends StatefulWidget {
  const BrokerLoginPage({super.key});

  @override
  State<BrokerLoginPage> createState() => _BrokerLoginPageState();
}

class _BrokerLoginPageState extends State<BrokerLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final success = await authService.brokerLogin(
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
              content: Text('Invalid broker credentials'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          UIConstants.preLoginBackground(),
          // Broker name in top-right
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
                  onPressed: () => Process.run('open', ['-n', '-a', Platform.resolvedExecutable]),
                  icon: const Icon(Icons.open_in_new, color: Colors.white, size: 28),
                  tooltip: 'New Instance',
                  style: UIConstants.preLoginIconButtonStyle(),
                ),
              ],
            ),
          ),
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
          // Main content
          Center(
            child: SingleChildScrollView(
              padding: UIConstants.paddingStandard,
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.business,
                            color: Colors.white70,
                            size: 40,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Broker Login',
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
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => _passwordFocusNode.requestFocus(),
                            style: const TextStyle(color: Colors.black, fontSize: UIConstants.textFieldFontSize),
                            decoration: UIConstants.preLoginInputDecoration(
                              hintText: 'Enter broker username',
                              prefixIcon: Icons.person,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
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
                              hintText: 'Enter broker password',
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
                              return null;
                            },
                          ),
                          const SizedBox(height: UIConstants.spacingLg),

                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            height: UIConstants.loginButtonHeight,
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Copyright bar
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
}
