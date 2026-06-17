import 'package:flutter/material.dart';
import '../../../../models/kasir_acc_model.dart';

class KasirAccountCard extends StatelessWidget {
  final KasirAccount account;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const KasirAccountCard({
    super.key,
    required this.account,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // AVATAR
          CircleAvatar(
            radius: 28,
            backgroundImage: account.photoUrl != null
                ? AssetImage(account.photoUrl!)
                : null,
            backgroundColor: const Color(0xFF005461),
            child: account.photoUrl == null
                ? const Icon(Icons.person, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 14),

          // INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.namaKasir,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  account.username,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  account.email,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // ACTION BUTTONS
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // EDIT BUTTON
              GestureDetector(
                onTap: onEdit,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(Icons.edit, size: 18, color: Colors.blue[600]),
                ),
              ),
              const SizedBox(height: 8),

              // DELETE BUTTON
              GestureDetector(
                onTap: onDelete,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.delete, size: 18, color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
