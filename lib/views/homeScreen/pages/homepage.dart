import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import '../../../providers/color_pallate_generator.dart';
import '../../../providers/theme_provider.dart';
import '../../../utils/currancyList.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScreenshotController screenshotController = ScreenshotController();
  int i = 0;

  late Uint8List imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("Color Pallate Generator"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            icon: const Icon(Icons.light_mode),
          ),
          IconButton(
            onPressed: () async {
              await screenshotController.capture().then((Uint8List? image) {
                //Capture Done
                setState(() {
                  imageFile = image!;
                });
              }).catchError((onError) {
                print(onError);
              });
              await ImageGallerySaver.saveImage(imageFile);

              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Palette saved in gallery.."),
                  backgroundColor: Colors.greenAccent,
                ),
              );
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                Provider.of<ColorPallateGenerator>(context, listen: false).data;
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future:
              Provider.of<ColorPallateGenerator>(context, listen: true).data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List? data = snapshot.data;
              return Screenshot(
                controller: screenshotController,
                child: Card(
                  elevation: 100,

                  color: Colors.pink.shade200,
                  shadowColor: Colors.pink.shade900,
                  surfaceTintColor: Colors.pink.shade900,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    width: 300,
                    height: 500,
                    child: ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (context, index) {
                          var color =
                              data[index].toUpperCase().replaceAll("#", "0xFF");

                          int finalColor = int.parse(color);

                          return Container(
                            height: 100,
                            color: Color(finalColor),
                          );
                        }),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString(),
                    textAlign: TextAlign.center),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
