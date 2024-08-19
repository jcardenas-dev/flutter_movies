# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)

## [Unreleased]

### Added
- Added BLoC for popular movies.
- Added bottom navigation to the app to navigate between different sections.
- Implemented the core data layer, including the repository and API client.
- Added use case for fetching popular movies.
- Created enums for `MovieLanguage`, `MovieSort`, and `MovieWithReleaseType` to use as parameters sent to the repository.
- Set up dependency injection for use cases and repositories.
- Implemented BLoC and use case for now playing movies.
- Updated API client to support fetching now playing movies.
- Updated UI to display now playing movies.
- Implemented UseCases for inserting and deleting favorite movies.
- Updated the Home feature to display and manage favorite movies.
- Added functionality to mark and unmark favorites in the "Now Playing" and "Popular" movie sections.

### Changed
- Updated `PopularMoviesBloc` and `NowPlayingMoviesBloc` to handle the favorite state and allow deletion from movie lists.
- Modified movie list views to reflect changes in the favorite status reactively.

### Fixed
- Resolved the issue with updating lists when adding or removing favorites to ensure visual state consistency with the data.
- Fixed fallback image handling in movie detail views to avoid errors in image loading.

