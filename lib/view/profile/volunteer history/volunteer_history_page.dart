import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';
import 'volunteer_campaign_details_page.dart';

class VolunteerHistoryPage extends StatelessWidget {
  VolunteerHistoryPage({super.key});

  final List<Map<String, dynamic>> volunteerCampaigns = [
    {
      'campaign': 'Blood Donation Drive',
      'hours': 5,
      'role': 'Organizer',
      'rate': 4.5,
      'date': '2023-06-10',
      'isCurrent': false,
    },
    {
      'campaign': 'Health Awareness Campaign',
      'hours': 3,
      'role': 'Volunteer',
      'rate': 4.8,
      'date': '2023-04-22',
      'isCurrent': false,
    },
    {
      'campaign': 'Ongoing Tree Planting',
      'hours': 2,
      'role': 'Team Member',
      'rate': 5.0,
      'date': '2025-07-01',
      'isCurrent': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final totalHours = volunteerCampaigns.fold<int>(
      0,
      (sum, item) => sum + (item['hours'] as int),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Volunteer History',
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        leading: const BackButton(color: white),
        elevation: 2,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Name & Badge
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ahmed Ali',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: textBlack,
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                              600
                                          ? 24
                                          : 20, // Adjust font size based on screen width
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Active Volunteer',
                                  style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        MediaQuery.of(context).size.width > 600
                                        ? 14
                                        : 12, // Adjust font size based on screen width
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Spacer to push the total hours container to the extreme right
                        const SizedBox(
                          width: 20,
                        ), // Optional spacing between the two sections
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width > 600
                                    ? 25
                                    : 15, // Adjust padding based on screen width
                                vertical:
                                    MediaQuery.of(context).size.width > 600
                                    ? 16
                                    : 12,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.9),
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                '$totalHours',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width > 600
                                      ? 28
                                      : 24, // Adjust font size based on screen width
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                            ),
                            const Text(
                              'Volunteer Hours',
                              style: TextStyle(
                                color: textBlack,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Joined: March 15, 2022',
                        style: TextStyle(
                          color: grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const Divider(height: 40),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.07,
                        width: MediaQuery.of(context).size.width*0.8,
                        decoration: BoxDecoration(color: Colors.red,  
                        borderRadius: BorderRadius.circular(12)

                        ),

                        child: Center(
                          child: Text(
                            'Warnings',
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 40),
                    Text(
                      'Participated and Current Campaigns',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: textBlack,
                      ),
                    ),
                    const SizedBox(height: 12),

                    ListView.separated(
                      itemCount: volunteerCampaigns.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final campaign = volunteerCampaigns[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VolunteerCampaignDetailsPage(
                                  data: campaign,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 12,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Rating Avatar
                                  CircleAvatar(
                                    radius: 26,
                                    backgroundColor: primaryColor,
                                    child: Text(
                                      campaign['rate'].toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  // Campaign Info + Badge
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                campaign['campaign'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: campaign['isCurrent']
                                                    ? secondaryColor
                                                          .withOpacity(0.15)
                                                    : Colors.grey.withOpacity(
                                                        0.15,
                                                      ),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                campaign['isCurrent']
                                                    ? 'Current'
                                                    : 'Participated',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  color: campaign['isCurrent']
                                                      ? secondaryColor
                                                      : Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text('Hours: ${campaign['hours']}'),
                                        Text('Role: ${campaign['role']}'),
                                      ],
                                    ),
                                  ),

                                  // Arrow Icon
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
