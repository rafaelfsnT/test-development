import 'package:flutter/material.dart';
import '../../model/search_result_model.dart';

class ResultCard extends StatelessWidget {
  final SearchResultModel result;
  final Function(String) onLinkTap;

  const ResultCard({
    super.key,
    required this.result,
    required this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.titulo,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade900,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            InkWell(
              onTap: () => onLinkTap(result.link),
              child: Text(
                result.link,
                style: const TextStyle(
                  color: Colors.green, 
                  decoration: TextDecoration.underline,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}