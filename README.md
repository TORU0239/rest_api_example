# rest_api_example
# REST API Example (Flutter)

A minimal Flutter app showing how to consume a REST API with Retrofit + Dio and manage state with both Bloc and Provider.

What’s Inside
- Retrofit + Dio: Type‑safe HTTP calls
- JsonSerializable + build_runner: Generated JSON parsing
- Two implementations: Bloc tab and Provider tab

Quick Start
1) Install deps: `flutter pub get`
2) Generate code: `flutter pub run build_runner build --delete-conflicting-outputs`
3) Run the app: `flutter run`

How It’s Organized
- Data layer: JSON models (`@JsonSerializable`), Retrofit API (`@RestApi`), repository wrapper
- UI layer: Posts list and Post detail — implemented twice (Bloc and Provider)
- Navigation: Bottom bar switches Bloc/Provider; tapping a post opens detail (fetches by ID)

API
- Base URL: https://jsonplaceholder.typicode.com
- Endpoints: `/posts`, `/posts/{id}`

Common Tasks
- Add a model: annotate class, add `part 'model.g.dart';`, run build_runner
- Add an endpoint: update Retrofit interface with annotations, run build_runner

Troubleshooting
- Missing `*.g.dart`: run build_runner with `--delete-conflicting-outputs`
- Conflicting outputs: same flag as above; avoid editing generated files

A new Flutter project.
