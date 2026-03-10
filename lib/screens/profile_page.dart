import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/theme_service.dart';
import '../services/database_helper.dart';
import '../utils/connectivity_checker.dart';
import '../config/ui_constants.dart';
import '../widgets/copyright_bar.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  
  bool _isEditingUsername = false;
  bool _isEditingPassword = false;
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    
    // Check server connectivity when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConnectivityChecker.checkAndShowErrorIfNeeded(context, 'Profile');
    });
    
    _loadUserData();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _loadUserData() {
    final authService = Provider.of<AuthService>(context, listen: false);
    _usernameController.text = authService.username;
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final themeService = Provider.of<ThemeService>(context);
    final isDarkTheme = themeService.isDarkTheme;

    return Theme(
      data: isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        backgroundColor: UIConstants.pageBackground(isDarkTheme),
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: UIConstants.colorCommand,
          foregroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: UIConstants.paddingComfortable,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: UIConstants.fontSizeLg,
                          fontWeight: UIConstants.fontWeightMedium,
                          color: UIConstants.textPrimary(isDarkTheme),
                        ),
                      ),

                      const SizedBox(height: UIConstants.spacingLg),

                      // Username Section
                      _buildInfoSection(
                        label: 'Username',
                        value: authService.username,
                        isEditing: _isEditingUsername,
                        controller: _usernameController,
                        onEdit: () => setState(() => _isEditingUsername = true),
                        onSave: _saveUsername,
                        onCancel: () {
                          setState(() => _isEditingUsername = false);
                          _usernameController.text = authService.username;
                        },
                        isDarkTheme: isDarkTheme,
                        canEdit: false,
                      ),

                      const SizedBox(height: UIConstants.spacingLg),

                      // Password Section
                      _buildPasswordSection(
                        isDarkTheme: isDarkTheme,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Copyright Status Bar
            CopyrightBar(isDarkTheme: isDarkTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String label,
    required String value,
    required bool isEditing,
    required TextEditingController controller,
    required VoidCallback onEdit,
    required VoidCallback onSave,
    required VoidCallback onCancel,
    required bool isDarkTheme,
    bool canEdit = true,
  }) {
    return Container(
      padding: UIConstants.paddingStandard,
      decoration: BoxDecoration(
        color: UIConstants.cardBackground(isDarkTheme),
        borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
        border: Border.all(
          color: UIConstants.borderColor(isDarkTheme),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: UIConstants.textFieldFontSize,
                  fontWeight: UIConstants.fontWeightNormal,
                  color: UIConstants.textSecondary(isDarkTheme),
                ),
              ),
              if (canEdit && !isEditing)
                TextButton(
                  onPressed: onEdit,
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: UIConstants.commandColor(isDarkTheme),
                      fontSize: UIConstants.textFieldFontSize,
                      fontWeight: UIConstants.fontWeightNormal,
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: UIConstants.spacingSm),
          
          if (isEditing) ...[
            TextFormField(
              controller: controller,
              style: TextStyle(
                fontSize: UIConstants.textFieldFontSize,
                color: UIConstants.textPrimary(isDarkTheme),
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                ),
                contentPadding: UIConstants.textFieldContentPadding,
                        isDense: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a $label';
                }
                return null;
              },
            ),
            
            const SizedBox(height: UIConstants.spacingSm),
            
            Row(
              children: [
                ElevatedButton(
                  onPressed: onSave,
                  style: UIConstants.buttonStyle(UIConstants.colorCommand),
                  child: const Text('Save'),
                ),
                const SizedBox(width: UIConstants.spacingSm),
                TextButton(
                  onPressed: onCancel,
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ] else ...[
            Text(
              value,
              style: TextStyle(
                fontSize: UIConstants.textFieldFontSize,
                color: UIConstants.textPrimary(isDarkTheme),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPasswordSection({required bool isDarkTheme}) {
    return Container(
      padding: UIConstants.paddingStandard,
      decoration: BoxDecoration(
        color: UIConstants.cardBackground(isDarkTheme),
        borderRadius: BorderRadius.circular(UIConstants.borderRadiusMd),
        border: Border.all(
          color: UIConstants.borderColor(isDarkTheme),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Password',
                style: TextStyle(
                  fontSize: UIConstants.textFieldFontSize,
                  fontWeight: UIConstants.fontWeightNormal,
                  color: UIConstants.textSecondary(isDarkTheme),
                ),
              ),
              if (!_isEditingPassword)
                TextButton(
                  onPressed: () => setState(() => _isEditingPassword = true),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      color: UIConstants.commandColor(isDarkTheme),
                      fontSize: UIConstants.textFieldFontSize,
                      fontWeight: UIConstants.fontWeightNormal,
                    ),
                  ),
                ),
            ],
          ),
          
          const SizedBox(height: UIConstants.spacingSm),
          
          if (_isEditingPassword) ...[
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              style: TextStyle(
                fontSize: UIConstants.textFieldFontSize,
                color: UIConstants.textPrimary(isDarkTheme),
              ),
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                ),
                contentPadding: UIConstants.textFieldContentPadding,
                        isDense: true,
                suffixIcon: IconButton(
                  focusNode: FocusNode(skipTraversal: true),
                  icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a new password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            
            const SizedBox(height: UIConstants.spacingSm),
            
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: !_isPasswordVisible,
              style: TextStyle(
                fontSize: UIConstants.textFieldFontSize,
                color: UIConstants.textPrimary(isDarkTheme),
              ),
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(UIConstants.textFieldBorderRadius),
                ),
                contentPadding: UIConstants.textFieldContentPadding,
                        isDense: true,
              ),
              validator: (value) {
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            
            const SizedBox(height: UIConstants.spacingSm),
            
            Row(
              children: [
                ElevatedButton(
                  onPressed: _savePassword,
                  style: UIConstants.buttonStyle(UIConstants.colorCommand),
                  child: const Text('Save'),
                ),
                const SizedBox(width: UIConstants.spacingSm),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isEditingPassword = false;
                      _passwordController.clear();
                      _confirmPasswordController.clear();
                    });
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ] else ...[
            Text(
              '••••••••••',
              style: TextStyle(
                fontSize: UIConstants.textFieldFontSize,
                color: UIConstants.textPrimary(isDarkTheme),
                letterSpacing: 2,
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _saveUsername() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final newUsername = _usernameController.text.trim();
      
      // Check if username actually changed
      if (newUsername.toLowerCase() == authService.username.toLowerCase()) {
        setState(() => _isEditingUsername = false);
        return;
      }
      
      // Check if username already exists
      final exists = await _databaseHelper.isUsernameExists(newUsername);
      if (exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          UIConstants.errorSnackBar('Username already exists'),
        );
        return;
      }
      
      // Update username
      final success = await authService.updateUsername(newUsername);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          UIConstants.successSnackBar('Username updated successfully'),
        );
        setState(() => _isEditingUsername = false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          UIConstants.errorSnackBar('Failed to update username'),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        UIConstants.errorSnackBar('Error updating username: $e'),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _savePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final newPassword = _passwordController.text;
      
      // Update password
      final success = await authService.updatePassword(newPassword);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          UIConstants.successSnackBar('Password updated successfully'),
        );
        setState(() {
          _isEditingPassword = false;
          _passwordController.clear();
          _confirmPasswordController.clear();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          UIConstants.errorSnackBar('Failed to update password'),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        UIConstants.errorSnackBar('Error updating password: $e'),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
