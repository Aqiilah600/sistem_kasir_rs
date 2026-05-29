import 'package:flutter/material.dart';

class TransaksiPayment extends StatelessWidget {
  final String selectedPayment;
  final Function(String) onChanged;

  const TransaksiPayment({
    super.key,
    required this.selectedPayment,
    required this.onChanged,
  });

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

          Row(
            children: const [

              Icon(
                Icons.payment,
                color: Colors.teal,
                size: 20,
              ),

              SizedBox(width: 8),

              Text(
                "Metode Pembayaran",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          _radioTile("Cash", Icons.payments),
          _radioTile("Kartu Debit", Icons.credit_card),
          _radioTile("Transfer", Icons.account_balance),
        ],
      ),
    );
  }

  Widget _radioTile(String title, IconData icon) {
    return RadioListTile(
      contentPadding: EdgeInsets.zero,

      activeColor: Colors.teal,

      value: title,
      groupValue: selectedPayment,

      onChanged: (value) {
        onChanged(value!);
      },

      title: Text(title),

      secondary: Icon(
        icon,
        color: Colors.teal,
      ),
    );
  }
}