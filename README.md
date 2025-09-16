# rest_api_example
# REST API Example (Flutter)

A minimal Flutter app showing how to consume a REST API with Retrofit + Dio and manage state with Bloc, Provider, and Riverpod — all backed by the same repository layer.

What’s Inside
- Retrofit + Dio: Type‑safe HTTP calls
- Three implementations: Bloc, Provider, and Riverpod tabs using a shared repository

Quick Start
1) Install deps: `flutter pub get`
2) Generate model code: `flutter pub run build_runner build --delete-conflicting-outputs`
3) Run the app: `flutter run`
4) Troubleshooting: see Error Handling below for Dio exceptions.

How It’s Organized
- Data layer: JSON models (`json_serializable` + `build_runner`), Retrofit API interface (`@RestApi`) with a handwritten implementation, repository wrapper
- UI layer: Posts list and Post detail — implemented three times (Bloc, Provider, Riverpod)
- Navigation: Bottom bar switches between the three tabs; tapping a post opens detail (fetches by ID)

API
- Base URL: https://jsonplaceholder.typicode.com
- Endpoints: `/posts`, `/posts/{id}`

Notes
- API client is handwritten (no `retrofit_generator`). Models use `json_serializable` and require build_runner.

## Error Handling
- Centralized Dio error mapping converts low-level `DioException` into friendly messages (e.g., "No internet connection", "Forbidden", "Server error").
- Implementation lives in `lib/data/network/network_exceptions.dart` and is applied in `PostRepository`.
- Repository wraps calls and throws `NetworkException` with a clean `toString()` so UI shows human‑readable errors in both Bloc and Provider paths.

Developer Notes
- Shared `Dio` instance is set up in `PostRepository` with default JSON headers, a helpful `User-Agent`, and a `LogInterceptor` for diagnostics.

A new Flutter project.
