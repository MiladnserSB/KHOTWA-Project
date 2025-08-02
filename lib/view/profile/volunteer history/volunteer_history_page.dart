import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class VolunteerHistoryPage extends StatelessWidget {
  VolunteerHistoryPage({super.key});

  final List<Map<String, dynamic>> dataList = [
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
  Widget build(BuildContext ctx) {
    final totalTime = dataList.fold<int>(0, (acc, item) => acc + (item['hours'] as int));
    final personName = 'Ahmed Ali';
    final joinedDateText = 'Joined: March 15, 2022';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Volunteer History',
          style: TextStyle(color: white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
        elevation: 2,
        leading: const BackButton(color: white),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (ctx, dim) {
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
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                personName,
                                style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: textBlack,
                                      fontSize: MediaQuery.of(ctx).size.width > 600 ? 24 : 20,
                                    ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Active Volunteer',
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(ctx).size.width > 600 ? 14 : 12,
                                    fontWeight: FontWeight.w600,
                                    color: white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(ctx).size.width > 600 ? 25 : 15,
                                vertical: MediaQuery.of(ctx).size.width > 600 ? 16 : 12,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$totalTime',
                                style: TextStyle(
                                  fontSize: MediaQuery.of(ctx).size.width > 600 ? 28 : 24,
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
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        joinedDateText,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: grey,
                        ),
                      ),
                    ),
                    const Divider(height: 40),

                    Center(
                      child: Container(
                        height: MediaQuery.of(ctx).size.height * 0.07,
                        width: MediaQuery.of(ctx).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Warnings',
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 40),
                    Text(
                      'Participated and Current Campaigns',
                      style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: textBlack,
                          ),
                    ),
                    const SizedBox(height: 12),

                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: dataList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, i) {
                        final item = dataList[i];
                        return InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) => EventDetailsPage(data: item),
                            //   ),
                            // );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 26,
                                    backgroundColor: primaryColor,
                                    child: Text(
                                      item['rate'].toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                item['campaign'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 4,
                                                horizontal: 8,
                                              ),
                                              decoration: BoxDecoration(
                                                color: item['isCurrent']
                                                    ? secondaryColor.withOpacity(0.15)
                                                    : Colors.grey.withOpacity(0.15),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                item['isCurrent'] ? 'Current' : 'Participated',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  color: item['isCurrent']
                                                      ? secondaryColor
                                                      : Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text('Hours: ${item['hours']}'),
                                        Text('Role: ${item['role']}'),
                                      ],
                                    ),
                                  ),
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
