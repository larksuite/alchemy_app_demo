# Harmony App Examples

本 Demo 提供了多个 HarmonyOS App 的示例场景，用于指导如何搭建和实现飞书客户端的定制能力。

| 模块 | 简介 | 涉及协议/能力 |
| :--- | :--- | :--- |
| [alchemy_custom_api_impl](sample_app/src/main/ets/alchemy_custom_api_impl) | 为 JSBridge 提供了自定义的 API 能力扩展。 | `IAlchemyCustomApi` |
| [alchemy_ka_tab_api_impl](sample_app/src/main/ets/alchemy_ka_tab_api_impl) | 实现了自定义的 Tab 容器，可向主导航栏添加自定义 Tab。 | `IAlchemyKATabApi` |
| [alchemy_lifecycle_api_impl](sample_app/src/main/ets/alchemy_lifecycle_api_impl) | 监听应用的生命周期事件，如登录状态变化等。 | `IAlchemyLifecycle` |
| [alchemy_nativeapp_extension_api_impl](sample_app/src/main/ets/alchemy_nativeapp_extension_api_impl) | 提供了原生应用的扩展能力，例如实现自定义登录页面。 | `IAlchemyNativeAppExtension` |
| [alchemy_nativelauncher_api_impl](sample_app/src/main/ets/alchemy_nativelauncher_api_impl) | 演示了如何通过客户端 OpenAPI 调用飞书的各项原生能力，如 `showToast`。 | `IAlchemyNativeLauncher` |
| [alchemy_webcontainer_api_impl](sample_app/src/main/ets/alchemy_webcontainer_api_impl) | 实现了 Web 容器的回调，用于处理特定的 Web 操作。 | `IAlchemyWebContainer` |

---

# Harmony App Examples

This demo provides several examples for HarmonyOS App scenarios, which can act as guidelines on how to set up and implement custom functionalities for the Lark client.

| Module | Description | Protocols/Capabilities |
| :--- | :--- | :--- |
| [alchemy_custom_api_impl](sample_app/src/main/ets/alchemy_custom_api_impl) | Provides custom API capability extensions for JSBridge. | `IAlchemyCustomApi` |
| [alchemy_ka_tab_api_impl](sample_app/src/main/ets/alchemy_ka_tab_api_impl) | Implements a custom Tab container to add custom tabs to the main navigation bar. | `IAlchemyKATabApi` |
| [alchemy_lifecycle_api_impl](sample_app/src/main/ets/alchemy_lifecycle_api_impl) | Monitors application lifecycle events, such as login state changes. | `IAlchemyLifecycle` |
| [alchemy_nativeapp_extension_api_impl](sample_app/src/main/ets/alchemy_nativeapp_extension_api_impl) | Provides extension capabilities for native apps, such as implementing a custom login page. | `IAlchemyNativeAppExtension` |
| [alchemy_nativelauncher_api_impl](sample_app/src/main/ets/alchemy_nativelauncher_api_impl) | Demonstrates how to invoke Lark's native capabilities, such as `showToast`, via the client OpenAPI. | `IAlchemyNativeLauncher` |
| [alchemy_webcontainer_api_impl](sample_app/src/main/ets/alchemy_webcontainer_api_impl) | Implements callbacks for the Web container to handle specific web operations. | `IAlchemyWebContainer` |