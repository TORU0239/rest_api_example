# Prompt Pack — rest_api_example

Curated prompts tailored for this Flutter REST API sample. Use them in your IDE assistant to speed up changes and troubleshooting.

## Project Overview
- Explain architecture: "Explain the data, repository, and UI layers in this repo, referencing `lib/data/**`, `lib/feature/**`, and how Bloc and Provider pages differ."
- Readme summary: "Summarize `README.md:1` and list exact commands to run the app and generate code."

## Setup & Tooling
- Install and generate: "Run `flutter pub get` and the build step for `json_serializable` using `flutter pub run build_runner build --delete-conflicting-outputs`. If anything fails, show the error and fix."
- Dependency upgrades: "Propose safe minor/patch upgrades for `pubspec.yaml:1` and explain risks."

## Networking (Dio + Retrofit style)
- Add endpoint: "Add a new GET endpoint `GET /users` to `lib/data/network/api_client.dart:8` and implement it in `lib/data/network/api_client_impl.dart`. Create a `User` model in `lib/data/models/user.dart` using `json_serializable`."
- Interceptor: "Add a Dio logging interceptor to `PostRepository` so that all requests/responses are logged in debug builds."
- Error handling: "Improve error handling in `api_client_impl.dart` so HTTP errors throw typed exceptions. Update repository methods to translate errors into user-friendly messages."
- Base URL override: "Allow overriding base URL via an env/config for staging vs prod; thread it from `MainApp` down to `ApiClient`."

## Repository Layer
- Caching: "Introduce simple in-memory caching in `PostRepository` for `fetchPosts()` with a TTL of 60s, including an explicit `refresh` flag."
- Pagination: "Add paginated posts (page, limit) to API + repository. Update UI to support infinite scrolling in the Bloc tab."

## Models
- New model: "Create `Comment` model (`lib/data/models/comment.dart`) with `id, postId, name, email, body`. Wire it to new endpoint `/posts/{id}/comments`."
- Codegen sanity: "Regenerate model code and ensure `part` directives are correct across models."

## State Management
- Bloc feature: "In `lib/feature/posts/bloc`, add retry logic and a 'pull to refresh' event. Reflect loading states in `lib/feature/posts/view/posts_page_bloc.dart`."
- Provider feature: "In `lib/feature/posts/provider`, add error + retry UI, and a manual refresh button on the AppBar."
- Consistency: "Unify state classes to include `timestamp` for last successful load."

## UI/Navigation
- Detail enhancements: "On `PostDetailPage` (both Bloc and Provider variants), render a list of comments below the post body with loading and error states."
- Theming: "Add a light/dark theme toggle persisted via `SharedPreferences`."

## Testing
- Unit tests: "Add unit tests for `PostRepository` using Dio `MockAdapter` to cover success and error cases."
- Bloc tests: "Add tests for `PostsBloc` state transitions on success, error, and refresh."
- Widget tests: "Write a widget test that pumps `PostsPageBloc` and asserts list rendering and error retry button behavior."

## Dev Experience
- Lints: "Strengthen lints in `analysis_options.yaml` to include common Flutter lints without breaking existing code; propose minimal fixes."
- Format: "Run `dart format` across `lib/` and suggest any significant diffs for review."

## CI/CD
- GitHub Actions: "Add a CI workflow that runs `flutter pub get`, codegen, format check, analyze, and tests on push/PR."

## Troubleshooting
- Build_runner issues: "If build_runner fails due to conflicts, explain the cause and run with `--delete-conflicting-outputs`."
- Network errors: "Diagnose 4xx/5xx errors by inspecting Dio logs; map common cases to user-facing messages."
- Null data: "Guard against null/empty API responses in `api_client_impl.dart` and the repository, returning empty lists when appropriate."

## Code Search & Navigation
- Find API usage: "List all call sites of `PostRepository.fetchPosts()` and `fetchPost()` across `lib/**`."
- Trace detail flow: "Trace how a tap on a post ID triggers navigation and data loading in both Bloc and Provider implementations."

## Refactors
- Retrofit generator: "Replace handwritten client with `retrofit_generator` + `build_runner`. Update `pubspec.yaml` dev_dependencies and remove `api_client_impl.dart` in favor of generated code."
- Error model: "Introduce a unified `AppFailure` sealed class for network, parsing, and unknown errors; refactor Bloc/Provider to use it."

## Templates
- Feature request: "Draft a small spec to add favorites for posts, including data schema, repository changes, Bloc/Provider updates, and UI tweaks."
- Bug report: "Given a crash log, identify the failing code path and propose a minimal fix with tests."

---

Tips
- Always run codegen after editing models: `flutter pub run build_runner build --delete-conflicting-outputs`.
- Keep changes minimal and focused; mirror patterns already used in `posts` features.
