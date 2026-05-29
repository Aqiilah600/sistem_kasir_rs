import 'package:flutter/material.dart';

class TransaksiSearch extends StatelessWidget {
  final TextEditingController controller;

  const TransaksiSearch({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "No Antrian",
            style: TextStyle(fontSize: 12),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: controller,

            decoration: InputDecoration(
              hintText: "Input No Antrian",

              hintStyle: TextStyle(
                color: Colors.grey.shade400,
              ),

              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Colors.teal,
                ),
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}