import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pils_recommendation/Pages/services/auth.dart';
import 'package:pils_recommendation/Pages/services/wrapper.dart';
import 'package:pils_recommendation/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white,
      )
    ],
    debug: true,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: true,
    theme: ThemeData(
      primarySwatch: Colors.blue, // replace with your chosen color
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: Authentication().authStateChanges,
      initialData: null,
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}











/**
 * Orders Page

This page will allow users to manage their medication orders. Key features could include:

    Order List:
        Display a list of all past and current orders.
        Include details such as order date, drug name, quantity, status (e.g., pending, shipped, delivered), and estimated delivery date.

    Order Details:
        When a user clicks on an order, show detailed information including a summary of the drugs ordered, their dosages, and any additional instructions.

    Track Order:
        Provide a tracking feature for users to track the status of their order in real-time.

    Order History:
        Allow users to filter and search through past orders based on date, drug name, or status.

    Reorder:
        Enable users to quickly reorder previously ordered medications with a single click.

Inventory Page

This page will help users keep track of their current stock of medications. Key features could include:

    Inventory List:
        Show a list of all medications currently in stock.
        Include details such as drug name, dosage, quantity on hand, expiration date, and storage instructions.

    Low Stock Alerts:
        Highlight medications that are running low and need to be reordered.
        Send notifications to users when a drug is below a certain threshold.

    Expiration Alerts:
        Notify users when a medication is close to its expiration date.

    Add/Remove Inventory:
        Allow users to manually add new medications to the inventory and remove expired or used-up medications.

Stocks Page

This page will enable users to monitor the availability and manage the reordering of medications. Key features could include:

    Stock Levels:
        Show current stock levels of each medication.
        Include graphical representations like bar charts or pie charts for an at-a-glance view of stock levels.

    Restock Alerts:
        Send reminders or alerts when it’s time to restock certain medications.

    Supplier Information:
        Provide details on suppliers for each medication, including contact information and order history.

    Order Stock:
        Direct link to the Orders page to place a new order when stock is low.

    Batch Management:
        Track batches of medications, including batch numbers and manufacturing dates for better inventory control.

Integration and Additional Features

To enhance the overall user experience, consider the following additional features:

    User Profiles:
        Allow users to create profiles with their personal information and medical history.

    Custom Reminders:
        Enable users to set custom reminders for medication intake, reorder dates, and medical appointments.

    Reports and Analytics:
        Provide detailed reports and analytics on medication usage, inventory levels, and order history.

    Security and Privacy:
        Implement robust security features to protect users' personal and medical data.

    Multilingual Support:
        Offer support for multiple languages to cater to a wider audience.


        Enhanced Home Page Features

    Dashboard Overview:
        Daily Medication Schedule: Display a clear, concise list of all medications that need to be taken today, along with the times.
        Upcoming Alerts: Show upcoming medication reminders for the next few days.
        Quick Actions: Provide quick access buttons for frequently used actions such as adding a new medication or viewing inventory.

    Health Tracking:
        Vitals Monitoring: Allow users to log and monitor vital signs such as blood pressure, glucose levels, weight, and heart rate.
        Symptom Tracker: Enable users to log symptoms and side effects to track how they feel over time.
        Mood Tracker: Include a simple mood tracking feature to help users monitor their emotional well-being.

    Reminders and Notifications:
        Custom Reminders: Allow users to set custom reminders not only for medications but also for drinking water, exercising, or doctor’s appointments.
        Snooze and Dismiss Options: Provide options to snooze or dismiss reminders directly from the home page.

    Health Tips and Articles:
        Educational Content: Display a feed of health tips, articles, and news relevant to the user’s medications and health conditions.
        Daily Tips: Offer daily health tips or motivational quotes to encourage adherence and a healthy lifestyle.

    User Profile Summary:
        Personal Information: Show a summary of the user’s profile, including their name, photo, and basic health information.
        Medication Adherence Rate: Display a simple statistic showing how well the user is adhering to their medication schedule.

    Recent Activity:
        Recent Logs: Display a log of recent activity, such as medications taken, symptoms logged, and any changes made to the medication schedule.
        Upcoming Orders: Highlight upcoming orders or notifications about low stock directly on the home page.

    Interactive Calendar:
        Medication Calendar: Include a calendar view where users can see their medication schedule for the month.
        Appointment Calendar: Allow users to log and view upcoming doctor’s appointments and medical events.

    Integration with Wearables and Health Apps:
        Sync Data: Integrate with popular wearables and health apps to sync data such as step counts, sleep patterns, and other health metrics.
        Real-time Updates: Provide real-time updates from connected devices directly on the home page.

Design Considerations

    User-Friendly Interface: Ensure that the home page layout is clean, intuitive, and easy to navigate. Use clear icons and a logical structure to help users find what they need quickly.
    Customization Options: Allow users to customize the home page layout and choose which widgets or sections they want to see.
    Accessibility: Ensure the app is accessible to all users, including those with disabilities. Use large fonts, high-contrast colors, and voice command support where possible.

Example Home Page Layout

    Header:
        User Profile Icon
        Settings Gear
        Notifications Bell

    Main Section:
        Daily Medication Schedule: List with checkboxes for marking medications as taken.
        Health Tracking Summary: Small widgets showing key health metrics.

    Secondary Section:
        Upcoming Alerts: List of upcoming medication reminders and alerts.
        Health Tips: Scrollable feed of tips and articles.

    Footer:
        Quick Actions: Buttons for adding a medication, viewing inventory, and placing an order.
        Interactive Calendar: Mini-calendar view showing upcoming medications and appointments.
 */
