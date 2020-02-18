import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

openMapsSheet(context, String local_map, String resName) async {
  List ltd;
  ltd = local_map.split(",");
  print(ltd);

  try {
    final title = resName+'';
    final description = "หิ๊วมั๊ย";
    final coords = Coords(double.parse(ltd[0]), double.parse(ltd[1]));
    final availableMaps = await MapLauncher.installedMaps;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () => map.showMarker(
                        coords: coords,
                        title: title,
                        description: description,
                      ),
                      title: Text(map.mapName),
                      leading: Image(
                        image: map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  } catch (e) {
    print(e);
  }
}
