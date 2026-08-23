import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LecturerQuickMenu extends StatelessWidget {
  const LecturerQuickMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickMenuItem(
            icon: Icons.add_circle_outline,
            label: 'Ajukan Kelas',
            onTap: () {
              context.push('/pengajuan');
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickMenuItem(
            icon: Icons.assignment_outlined,
            label: 'Monitoring',
            onTap: () {
              context.push('/history');
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickMenuItem(
            icon: Icons.person_outline,
            label: 'Profil',
            onTap: () {
              context.push('/profile');
            },
          ),
        ),
      ],
    );
  }
}

class _QuickMenuItem extends StatelessWidget {
  const _QuickMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
