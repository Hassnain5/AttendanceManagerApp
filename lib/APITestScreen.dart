import 'dart:convert';
import 'dart:ui'; // 👈 Needed for ImageFilter
import 'package:first_app/Providers/WeatherProvider.dart';
import 'package:first_app/models/WeatherModel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class APITestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: false);

    Future<void> openSearchScreen() async {
      final city = await context.push<String>("/searchScreen");

      if (city != null) {
        weatherProvider.setCity(city);
      }
    }

    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => openSearchScreen(),
            icon: const Icon(Iconsax.search_normal_1, color: Colors.white),
          ),
        ],
      ),
      body: Consumer<WeatherProvider>(
        builder: (BuildContext context, provider, _) {
          return FutureBuilder<WeatherModel?>(
            future: provider.getWeather(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Colors.white));
              } else if (snapshot.hasData && snapshot.data != null) {
                final data = snapshot.data!;
                final current = data.current!;
                final location = data.location!;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// --- Location & Time
                      Text(
                        "${location.name}, ${location.country}",
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        "Local Time: ${location.localtime}",
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 20),

                      /// --- Current Weather Card
                      _frostedCard(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              if (current.condition?.icon != null)
                                Image.network("https:${current.condition!.icon!}", scale: 1.5),
                              const SizedBox(height: 10),
                              Text(
                                "${current.tempC?.toStringAsFixed(1)}°C",
                                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Text(
                                current.condition?.text ?? "",
                                style: const TextStyle(fontSize: 20, color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Feels like: ${current.feelslikeC?.toStringAsFixed(1)}°C",
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// --- Weather Details Grid
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        children: [
                          _buildInfoTile(Icons.water_drop, "Humidity", "${current.humidity}%"),
                          _buildInfoTile(Icons.air, "Wind", "${current.windKph} kph (${current.windDir})"),
                          _buildInfoTile(Icons.thermostat, "Pressure", "${current.pressureMb} mb"),
                          _buildInfoTile(Icons.cloud, "Cloud", "${current.cloud}%"),
                          _buildInfoTile(Icons.waves, "Precipitation", "${current.precipMm} mm"),
                          _buildInfoTile(Icons.remove_red_eye, "Visibility", "${current.visKm} km"),
                          _buildInfoTile(Icons.brightness_5, "UV Index", "${current.uv}"),
                          _buildInfoTile(Icons.flash_on, "Gust", "${current.gustKph} kph"),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// --- Extra Info
                      _frostedCard(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Extra Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                              const Divider(color: Colors.white30),
                              Text("Heat Index: ${current.heatindexC} °C", style: const TextStyle(color: Colors.white)),
                              Text("Dew Point: ${current.dewpointC} °C", style: const TextStyle(color: Colors.white)),
                              Text("Wind Chill: ${current.windchillC} °C", style: const TextStyle(color: Colors.white)),
                              Text("Last Updated: ${current.lastUpdated}", style: const TextStyle(color: Colors.white70)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text("No Data Found", style: TextStyle(fontSize: 20, color: Colors.red)),
                );
              }
            },
          );
        },
      ),
    );
  }

  /// Frosted Glass Card
  Widget _frostedCard({required Widget child, double borderRadius = 16}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: child,
        ),
      ),
    );
  }

  /// Info Tile (uses frosted card)
  Widget _buildInfoTile(IconData icon, String title, String value) {
    return _frostedCard(
      borderRadius: 12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 12, color: Colors.white70)),
                  Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
