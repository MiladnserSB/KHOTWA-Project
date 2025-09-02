import 'package:flutter/material.dart';
import 'package:khotwa/maps/maps_screen.dart';
import 'package:khotwa/shared/constants/colors.dart';

class LocationDisplayScreen extends StatefulWidget {
  final LatLong center;
  final String locationName;
  final Color locationPinIconColor;
  final String limitLocation;
  final String eventName;
  final String eventTime;
  final String eventDate;

  const LocationDisplayScreen({
    super.key,
    required this.center,
    required this.locationName,
    this.locationPinIconColor = Colors.blue,
    required this.limitLocation,
    required this.eventName,
    required this.eventTime,
    required this.eventDate,
  });

  @override
  State<LocationDisplayScreen> createState() => _LocationDisplayScreenState();
}

class _LocationDisplayScreenState extends State<LocationDisplayScreen> {
  // Controller to set the initial location text
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial text to the location name
    _searchController.text = widget.locationName;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Location"),
        backgroundColor: theme.brightness == Brightness.dark
            ? primaryColor
            : secondaryColor,
      ),
      body: Stack(
        children: [
          // The main map display
          MapScreenChooseLocation(
            center: widget.center,
            onPicked: (pickedData) {
              // Empty function - no action when location is "picked"
            },
            onGetCurrentLocationPressed: MapScreenChooseLocation.nopFunction,
            limitLocation: widget.limitLocation,
            buttonColor: Colors.transparent,
            buttonTextColor: Colors.transparent,
            locationPinIconColor: widget.locationPinIconColor,
            buttonText: '',
            hintText: '',
          ),
          
          // Overlay to block all interactions
          Positioned.fill(
            child: IgnorePointer(
              child: Container(color: Colors.transparent),
            ),
          ),
          
          // Event details card at the bottom
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: theme.brightness == Brightness.dark 
      ? primaryColor // Dark green in dark mode
      : thirdColor, // Light beige in light mode
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: primaryColor.withOpacity(0.3),
        blurRadius: 12,
        spreadRadius: 2,
        offset: const Offset(0, 6),
      ),
    ],
    border: theme.brightness == Brightness.dark
      ? Border.all(color: secondaryColor.withOpacity(0.3), width: 1)
      : Border.all(color: primaryColor.withOpacity(0.2), width: 1),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        widget.eventName,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: theme.brightness == Brightness.dark
              ? white
              : textBlack,
          letterSpacing: 0.5,
        ),
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Icon(
            Icons.access_time,
            size: 18,
            color: theme.brightness == Brightness.dark
                ? secondaryColor // Gold color in dark mode
                : primaryColor, // Dark green in light mode
          ),
          const SizedBox(width: 6),
          Text(
            widget.eventTime,
            style: TextStyle(
              color: theme.brightness == Brightness.dark
                  ? white.withOpacity(0.9)
                  : primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 20),
          Icon(
            Icons.calendar_today,
            size: 18,
            color: theme.brightness == Brightness.dark
                ? secondaryColor // Gold color in dark mode
                : primaryColor, // Dark green in light mode
          ),
          const SizedBox(width: 6),
          Text(
            widget.eventDate,
            style: TextStyle(
              color: theme.brightness == Brightness.dark
                  ? white.withOpacity(0.9)
                  : primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      const SizedBox(height: 12),
      Divider(
        color: theme.brightness == Brightness.dark
            ? secondaryColor.withOpacity(0.4) // Gold with opacity in dark mode
            : primaryColor.withOpacity(0.3), // Dark green with opacity in light mode
        height: 1,
        thickness: 1,
      ),
      const SizedBox(height: 12),
      Row(
        children: [
          Icon(
            Icons.location_on,
            size: 18,
            color: theme.brightness == Brightness.dark
                ? secondaryColor // Gold color in dark mode
                : primaryColor, // Dark green in light mode
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              widget.locationName,
              style: TextStyle(
                color: theme.brightness == Brightness.dark
                    ? white.withOpacity(0.9)
                    : primaryColor,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ],
  ),
)   ),
        ],
      ),
    );
  }
}