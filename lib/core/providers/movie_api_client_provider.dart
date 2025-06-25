import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/core/network/api_client.dart';

final movieApiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    baseUrl: dotenv.env['TMDB_API_BASE_URL']!,
    bearerToken: dotenv.env['TMDB_BEARER_TOKEN'],
  );
});
