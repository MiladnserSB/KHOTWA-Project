import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:khotwa/controller/auth_controller.dart';
import 'package:khotwa/controller/visitor_controller.dart';
import 'package:khotwa/shared/constants/colors.dart';

class DonorLoginDialog extends StatefulWidget {
  const DonorLoginDialog({super.key});

  @override
  State<DonorLoginDialog> createState() => _DonorLoginDialogState();
}

class _DonorLoginDialogState extends State<DonorLoginDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final visitorController = Get.find<VisitorController>();
  final authController = Get.put(AuthController());

  bool _isLoading = false;
  bool _obscurePassword = true; // toggle for password visibility

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await authController.registerUser(
          username: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          roleId: 4,
        );
        if (mounted) Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  bool _isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  bool _isTablet(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide > 600;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final isLandscape = _isLandscape(context);
    final isTablet = _isTablet(context);
    final textScaleFactor = mediaQuery.textScaleFactor.clamp(0.8, 1.2);

    final dialogWidth = isTablet
        ? width * 0.5
        : isLandscape
        ? width * 0.7
        : width * 0.9;

    final horizontalPadding = isTablet ? width * 0.03 : width * 0.05;
    final verticalPadding = isLandscape ? height * 0.02 : height * 0.03;

    return Dialog(
      backgroundColor: theme.brightness == Brightness.dark ? sixth : thirdColor,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isTablet ? width * 0.1 : width * 0.05,
        vertical: isLandscape ? height * 0.1 : height * 0.15,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: dialogWidth,
          minWidth: isTablet ? 400 : 300,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Donor Login'.tr,
                    style: TextStyle(
                      fontSize: isTablet ? 28 : 22 * textScaleFactor,
                      fontWeight: FontWeight.bold,
                      color: theme.brightness == Brightness.dark
                          ? Colors.white
                          : primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: isLandscape ? height * 0.015 : height * 0.02),

                /// Name field
                _buildLabel('Name'.tr, isTablet, textScaleFactor, theme),
                SizedBox(height: height * 0.01),
                _buildNameField(isTablet),

                SizedBox(height: isLandscape ? height * 0.015 : height * 0.02),

                /// Email field
                _buildLabel('Email'.tr, isTablet, textScaleFactor, theme),
                SizedBox(height: height * 0.01),
                _buildEmailField(isTablet),

                SizedBox(height: isLandscape ? height * 0.015 : height * 0.02),

                /// Password field
                _buildLabel('Password'.tr, isTablet, textScaleFactor, theme),
                SizedBox(height: height * 0.01),
                _buildPasswordField(isTablet),

                SizedBox(height: isLandscape ? height * 0.02 : height * 0.03),

                /// Buttons
                if (isLandscape && !isTablet)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _buildButtons(context, isTablet, width),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: _buildButtons(context, isTablet, width),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Helper to build labels
  Widget _buildLabel(
    String text,
    bool isTablet,
    double scale,
    ThemeData theme,
  ) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isTablet ? 18 : 16 * scale,
        fontWeight: FontWeight.w500,
        color: theme.brightness == Brightness.dark ? Colors.grey : Colors.black,
      ),
    );
  }

  /// Name field
  Widget _buildNameField(bool isTablet) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      controller: _nameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Name is required".tr;
        }
        if (value.length < 2) {
          return "Name must be at least 2 characters".tr;
        }
        return null;
      },
      decoration: _inputDecoration('Enter your full name'.tr, isTablet),
    );
  }

  /// Email field
  Widget _buildEmailField(bool isTablet) {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Email is required".tr;
        }
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!emailRegex.hasMatch(value)) {
          return "Enter a valid email".tr;
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
      decoration: _inputDecoration('Enter your email'.tr, isTablet),
    );
  }

  /// Password field
  Widget _buildPasswordField(bool isTablet) {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Password is required".tr;
        }
        if (value.length < 6) {
          return "Password must be at least 6 characters".tr;
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
      decoration: _inputDecoration('Enter your password'.tr, isTablet).copyWith(
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: grey,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
    );
  }

  /// Input decoration builder
  InputDecoration _inputDecoration(String hint, bool isTablet) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: isTablet ? 20 : 16,
        vertical: isTablet ? 18 : 14,
      ),
      hintStyle: TextStyle(color: grey, fontSize: isTablet ? 16 : 14),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
    );
  }

  List<Widget> _buildButtons(
    BuildContext context,
    bool isTablet,
    double width,
  ) {
    return [
      ElevatedButton(
        onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 24 : 20,
            vertical: isTablet ? 16 : 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Cancel'.tr,
          style: TextStyle(fontSize: isTablet ? 16 : 14, color: white),
        ),
      ),
      SizedBox(width: width * 0.03),
      ElevatedButton(
        onPressed: _isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? 24 : 20,
            vertical: isTablet ? 16 : 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? SizedBox(
                width: isTablet ? 24 : 20,
                height: isTablet ? 24 : 20,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(white),
                ),
              )
            : Text(
                'Login'.tr,
                style: TextStyle(fontSize: isTablet ? 16 : 14, color: white),
              ),
      ),
    ];
  }
}
