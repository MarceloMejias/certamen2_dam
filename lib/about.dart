import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de la Universidad'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/usm_logo.png', // Cambia 'usm_logo.png' al nombre de tu archivo
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              'Universidad Técnica Federico Santa María',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'La Universidad Técnica Federico Santa María (UTFSM) es una de las universidades más prestigiosas en el ámbito de la ingeniería y ciencias en Chile y América Latina. Fundada en 1926, la universidad se destaca por su excelencia académica y su enfoque en la formación técnica y profesional de alta calidad.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10),
            const Text(
              'La UTFSM ofrece una amplia variedad de programas de pregrado y postgrado en ingeniería, ciencias y tecnología, y se caracteriza por su innovación en investigación y desarrollo, promoviendo el avance tecnológico y el conocimiento científico.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
