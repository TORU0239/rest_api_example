# rest_api_example
# REST API Example (Flutter)

Small Flutter app demonstrating Retrofit + Dio to parse JSON from a REST API, with two state management approaches side‑by‑side: Bloc and Provider.

Features
- Retrofit + Dio: Type‑safe HTTP client
- JsonSerializable: Code‑generated JSON models
- build_runner: One‑shot and watch codegen
- State management: flutter_bloc and provider
- Example API: JSONPlaceholder posts list + detail

Tech Stack
- Runtime: `dio`, `retrofit`, `json_annotation`, `provider`, `flutter_bloc`, `equatable`
- Dev: `build_runner`, `retrofit_generator`, `json_serializable`

Project Structure
- `lib/data/models/post.dart` — Post model (`@JsonSerializable()`)
- `lib/data/network/api_client.dart` — Retrofit interface (`@RestApi`)
- `lib/data/repositories/post_repository.dart` — Thin wrapper over `ApiClient`
- Bloc list/detail
  - `lib/feature/posts/bloc/posts_bloc.dart`
  - `lib/feature/posts/bloc/posts_event.dart`
  - `lib/feature/posts/bloc/posts_state.dart`
  - `lib/feature/posts/bloc/post_detail_bloc.dart`
  - `lib/feature/posts/bloc/post_detail_event.dart`
  - `lib/feature/posts/bloc/post_detail_state.dart`
  - `lib/feature/posts/view/posts_page_bloc.dart`
  - `lib/feature/posts/view/post_detail_page_bloc.dart`
- Provider list/detail
  - `lib/feature/posts/provider/posts_provider.dart`
  - `lib/feature/posts/provider/post_detail_provider.dart`
  - `lib/feature/posts/view/posts_page_provider.dart`
  - `lib/feature/posts/view/post_detail_page_provider.dart`
- App shell
  - `lib/main.dart` — Bottom navigation toggles Bloc vs Provider examples

API
- Base URL: `https://jsonplaceholder.typicode.com`
- Endpoints used: `/posts`, `/posts/{id}`

Getting Started
1) Install dependencies
- `flutter pub get`

2) Generate code (models + Retrofit client)
- One‑off: `flutter pub run build_runner build --delete-conflicting-outputs`
- Watch: `flutter pub run build_runner watch --delete-conflicting-outputs`

3) Run
- `flutter run`

How It Works
- Models: `post.dart` declares `part 'post.g.dart';`. Codegen creates `post.g.dart` with `_$PostFromJson`/`_$PostToJson`.
- Retrofit: `api_client.dart` declares `part 'api_client.g.dart';` with `@RestApi` methods. Codegen creates `_ApiClient` using Dio.
- Repository: `PostRepository` delegates to the generated `ApiClient`.
- Bloc flow: dispatch `LoadPosts` → loading → `PostsLoaded`/`PostsError`; detail dispatches `LoadPostDetail(id)`.
- Provider flow: call `load()`/`load(id)` on `ChangeNotifier` and react to `isLoading`/`error`/data via `Consumer`.

Navigation
- List tiles push detail pages:
  - Bloc: `lib/feature/posts/view/posts_page_bloc.dart:1` → `PostDetailPageBloc(id: p.id)`
  - Provider: `lib/feature/posts/view/posts_page_provider.dart:1` → `PostDetailPageProvider(id: p.id)`

Common Tasks
- Add a model
  - Create `lib/data/models/thing.dart` with `@JsonSerializable()` and `part 'thing.g.dart';`
  - Run build_runner to generate `thing.g.dart`
- Add an API method
  - Add to `ApiClient` with annotations (`@GET`, `@POST`, etc.)
  - Run build_runner; use via `PostRepository` or a new repository

Troubleshooting
- Missing `*.g.dart` / unresolved `part` files
  - Run: `flutter pub run build_runner build --delete-conflicting-outputs`
- Generator conflicts
  - Use the `--delete-conflicting-outputs` flag; avoid hand‑editing generated files
- Network errors
  - Check device/emulator connectivity; JSONPlaceholder is public and should be reachable

Notes
- The `*.g.dart` files are generated and may be overwritten by build_runner. If present in the repo, they serve only to allow compilation before generation.

A new Flutter project.
