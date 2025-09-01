import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
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
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      
      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text('Login successful!'.tr),
            backgroundColor: Colors.green,
          ),
        );
      });
    }
  }

  // Helper method to determine if device is in landscape
  bool _isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  // Helper method to determine if device is a tablet
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

    // Calculate responsive dimensions
    final dialogWidth = isTablet 
      ? width * 0.5 
      : isLandscape 
        ? width * 0.7 
        : width * 0.9;
    
    final horizontalPadding = isTablet 
      ? width * 0.03 
      : width * 0.05;
    
    final verticalPadding = isLandscape 
      ? height * 0.02 
      : height * 0.03;

    return Dialog(
      backgroundColor: theme.brightness == Brightness.dark ? const Color(0xFF202020) : thirdColor,
      insetPadding: EdgeInsets.symmetric(
        horizontal: isTablet ? width * 0.1 : width * 0.05,
        vertical: isLandscape ? height * 0.1 : height * 0.15,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
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
color: theme.brightness == Brightness.dark ? Colors.white : primaryColor,                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: isLandscape ? height * 0.015 : height * 0.02),
                
                // Name Field
                Text(
                  'Name'.tr,
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16 * textScaleFactor,
                    fontWeight: FontWeight.w500,
                    color:       theme.brightness == Brightness.dark
                        ? Colors.grey
                        : Colors.black, // Added color
                  ),
                ),
                SizedBox(height: height * 0.01),
                TextFormField(
                    style: const TextStyle( 
    color: Colors.black,
  ),
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
                  decoration: InputDecoration(
                    hintText: 'Enter your full name'.tr,
                    filled: true,
                    fillColor: white, // Changed to white
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor), // Added border color
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 20 : 16,
                      vertical: isTablet ? 18 : 14,
                    ),
                    hintStyle: TextStyle(
                      color: grey, // Changed to grey6
                      fontSize: isTablet ? 16 : 14,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: isLandscape ? height * 0.015 : height * 0.02),
                
                // Email Field
                Text(
                  'Email'.tr,
                  style: TextStyle(
                    fontSize: isTablet ? 18 : 16 * textScaleFactor,
                    fontWeight: FontWeight.w500,
  color:       theme.brightness == Brightness.dark
                        ? Colors.grey
                        : Colors.black,                   ),
                ),
                SizedBox(height: height * 0.01),
                TextFormField(
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
                  },  style:  TextStyle( 
    color: Colors.black,
  ),
                  decoration: InputDecoration(
                    
                    hintText: 'Enter your email'.tr,
                    filled: true,
                    fillColor: white, // Changed to white
                    
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor), // Added border color
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 20 : 16,
                      vertical: isTablet ? 18 : 14,
                    ),
                    hintStyle: TextStyle(
                      color: grey, // Changed to grey
                      fontSize: isTablet ? 16 : 14,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: isLandscape ? height * 0.02 : height * 0.03),
                
                // Buttons - Adaptive layout based on screen size
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

  List<Widget> _buildButtons(BuildContext context, bool isTablet, double width) {
    return [
      ElevatedButton(
               onPressed: _isLoading ? null : () => Navigator.of(context).pop(),

        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor, // Changed to primaryColor
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
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(white),
                ),
              )
            : Text(
                'Cancel'.tr,
                style: TextStyle(
                  fontSize: isTablet ? 16 : 14,
                  color: white,
                ),
              ),
      ),
      SizedBox(width: width * 0.03),
      ElevatedButton(
        onPressed: _isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor, // Changed to primaryColor
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
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(white),
                ),
              )
            : Text(
                'Login'.tr,
                style: TextStyle(
                  fontSize: isTablet ? 16 : 14,
                  color: white,
                ),
              ),
      ),
    ];
  }
}