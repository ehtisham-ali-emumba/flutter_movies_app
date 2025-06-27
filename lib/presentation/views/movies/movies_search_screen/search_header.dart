import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/utils/input_utils.dart';
import 'package:movies/presentation/view_models/movies/movie_search_provider.dart';
import 'package:movies/presentation/widgets/text.dart';

import 'common_searched_chips.dart';

class SearchHeader extends ConsumerStatefulWidget {
  const SearchHeader({super.key});

  @override
  ConsumerState<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends ConsumerState<SearchHeader> {
  final TextEditingController _controller = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 400);

  void _onSearchChanged(String value) {
    _debouncer(value, (val) {
      ref.read(movieSearchProvider.notifier).search(val);
    });
  }

  void setSearchFieldText(String text) {
    _controller.text = text;
    _onSearchChanged(text);
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppText("What'd you like to watch?", kind: TextKind.heading),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search for movies...',
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
                size: 28,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.clear();
                  _onSearchChanged('');
                },
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).primaryColor,
                  size: 28,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 12),
          CommonSearchedChips(onSearch: setSearchFieldText),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
