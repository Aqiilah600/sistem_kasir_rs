import 'package:flutter/material.dart';

class SedangDilayaniCard extends StatefulWidget {
  final String nomor;
  final String nama;
  final String poli;

  final VoidCallback onSelesai;
  final VoidCallback onSkip;

  const SedangDilayaniCard({
    super.key,
    required this.nomor,
    required this.nama,
    required this.poli,
    required this.onSelesai,
    required this.onSkip,
  });

  @override
  State<SedangDilayaniCard> createState() => _SedangDilayaniCardState();
}

class _SedangDilayaniCardState extends State<SedangDilayaniCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF006873), Color(0xFF188C89), Color(0xFF3AC0A8)],
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 6)),
        ],
      ),

      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // KIRI: NOMOR BESAR & INFO
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF37BCA7),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Sedang Dilayani',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 1),
              // Center the queue number without affecting the buttons on the right
              SizedBox(
                width: 120,
                height: 60,
                child: Center(
                  child: Text(
                    widget.nomor,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 0),
              SizedBox(
                width: 120,
                height: 20,
                child: Center(
                  child: Text(
                    widget.nama,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 120,
                height: 20,
                child: Center(
                  child: Text(
                    widget.poli,
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.hardEdge,
              child: Row(
                children: [
                  _buildButton(
                    icon: Icons.call,
                    label: 'Panggil\nUlang',
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  _buildButton(
                    icon: Icons.check_circle_outline,
                    label: 'Selesai &\nLanjut',
                    onPressed: widget.onSelesai,
                  ),
                  const SizedBox(width: 8),
                  _SkipButton(onPressed: widget.onSkip),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return _ActionButton(icon: icon, label: label, onPressed: onPressed);
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final buttonColor = isHover
        ? const Color(0xFF006873)
        : const Color(0xFF26A69B);

    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: Colors.white, size: 20),
              const SizedBox(height: 2),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8.6,
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkipButton extends StatefulWidget {
  final VoidCallback onPressed;

  const _SkipButton({required this.onPressed});

  @override
  State<_SkipButton> createState() => _SkipButtonState();
}

class _SkipButtonState extends State<_SkipButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final buttonColor = isHover ? Colors.red.shade700 : Colors.red;

    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
