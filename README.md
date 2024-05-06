# token_hub

A new Flutter project.

the env file would be hidden in a production project

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

notes
Caching: Since the CoinGecko API has rate limits, cache the results of your queries to reduce the number of API calls
and improve the app's responsiveness.
Pagination: If your users need access to more than the initial 100 tokens, consider implementing pagination or infinite
scrolling, fetching more tokens as needed.
Error Handling: Implement error handling for API calls to gracefully manage network issues or API limits.
User Experience: Remember to add loading indicators when fetching data and consider empty states for your lists.