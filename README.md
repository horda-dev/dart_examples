# Horda Examples for Flutter

Flutter example projects demonstrating Horda's stateful serverless backend features and client integration.

All projects come with a Horda client API key provided, so you can run and test each project's Flutter app on your machine and see it in action.

Projects are ordered by increasing complexity:

- **Counter** 
- **Twitter** 

## Counter Example

[View in Horda Console](https://console.horda.dev/?project=d2sqf8kgc98s73838big)

[View Code](counter/)

<div align="center">
  <video src="https://github.com/user-attachments/assets/679eef38-0caa-4096-bd41-bb258dc2bdd7" />
</div>

A "Hello World" project showcasing basic Horda Server SDK concepts including Entity, State, and View Group, and how to use them to create a stateful serverless backend.

Use the Counter Flutter app to understand how the Horda Client SDK is used to connect to Horda backends, request business processes, query entity views, and display results.

## Twitter Example

[View in Horda Console](https://console.horda.dev/?project=d368c1sgc98s738ue7cg)

[View Code](twitter/)

<div align="center">
  <video src="https://github.com/user-attachments/assets/bbbe0981-7d2a-4968-8f2c-6c19f381e001" />
</div>

A comprehensive example showcasing how to build a Twitter-like social media platform using Horda. This example highlights the implementation of business logic on the backend and how the client is kept in sync with real-time data changes.

## Running Projects Locally

For local development, the server packages in these examples utilize the `horda_local_host` dev dependency. This package allows you to run the Horda server locally, enabling rapid iteration and testing without deploying to the Horda platform.

To connect your client application to a locally hosted server, use the following WebSocket URLs:
- `"ws://localhost:8080/client"` for local development on your machine.
- `"ws://10.0.2.2:8080/client"` for local development with an Android emulator.

The `horda_local_host` package is not limited to these examples; it can also be used when developing your own Horda server packages. You can find more information about `horda_local_host` on [pub.dev](https://pub.dev/packages/horda_local_host).
