import 'package:flutter/material.dart';

class TransaksiDataPasien extends StatelessWidget {
  final Map<String, String> data;

  const TransaksiDataPasien({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TITLE
          Row(
            children: const [
              Icon(Icons.people, color: Colors.teal, size: 20),

              SizedBox(width: 8),

              Text(
                "Data Pasien",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // FIELD
          ...data.entries.map((e) => _field(e.key, e.value)),

          const SizedBox(height: 20),

          // TOTAL
          Container(
            width: double.infinity,

            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),

              gradient: const LinearGradient(
                colors: [Color(0xFF3AC0A8), Color(0xFF0E8F98)],
              ),
            ),

            child: RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(text: "Total Keseluruhan : "),
                  TextSpan(
                    text: "268.000",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FIELD
  Widget _field(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),

      child: Row(
        children: [
          SizedBox(
            width: 95,
            child: Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ),

          Expanded(
            child: SizedBox(
              height: 38,

              child: TextField(
                readOnly: true,

                decoration: InputDecoration(
                  hintText: value,

                  hintStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),

                  suffixIcon: title == "Tanggal"
                      ? const Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: Color(0xFF4B5A6A),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
