import 'package:flutter/material.dart';

class VegetablesContent extends StatelessWidget {
  const VegetablesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('Trace And Match'),
            Row(
              children: [
                SizedBox(
                  width: 150, // Menyesuaikan lebar Container
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(5, (index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        width: 50,
                        height: 100,
                        color: Colors.red,
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) => const CircleAvatar(
                      minRadius: 10,
                      maxRadius: 15,
                    ),
                  ),
                ),
                SizedBox(
                  width: 150, // Menyesuaikan lebar SizedBox
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(5, (index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20.0)),
                          border: Border.all(
                            color: Colors.black,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            style: BorderStyle.solid,
                            width: 1.5,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(
                  width: 150, // Menyesuaikan lebar SizedBox
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(5, (index) {
                      return const CircleAvatar(
                        minRadius: 10,
                        maxRadius: 15,
                      );
                    }),
                  ),
                ),
                Container(
                  width: 150, // Menyesuaikan lebar Container
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(5, (index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        width: 50,
                        height: 100,
                        color: Colors.red,
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
