# Native App Examples
This demo provides several examples about native app scenarios. It can act as guidelines about how to set up a Lark native app project and implement custom functionalities.

## Protocol Component | 协议组件

### JS API Extension | LKJsApiExternalIMP | JS API扩展
[source code](LKJsApiExternalIMP)

This module provides two implementations of the protocol `KANativeAppPluginDelegate` in `NativeAppPublicKit`. With this protocol, developers can define events sent from H5 page and implement custom handlers.

In this example, users open the `三方地图` app in workplace and click `当前位置` or `美食检索` to obtain corresponding results. The two functions are implemented in _Object-C_ and _Swift_ respectively.

### Lifecycle Ability | LKLifecycleExternalIMP | 生命周期能力
[source code](LKLifecycleExternalIMP)

This module provides an example of how to set up callback functions on lifecycle events.

### Message Menu Ability | LKMenusExternalIMP | 消息菜单容器
[source code](LKMenusExternalIMP)

This module provides an implementation of the protocol `KAMenusProtocol` in `LKMenusExternal`. With this protocol, developers can add custom items to the message menu.

This example adds a `下载` button to the menu that appears when a message is long pressed. Users can download the file attached to a message by clicking the button. 

### Native App Extension | LKNativeAppExtensionExternalIMP | 原生集成应用
[source code](LKNativeAppExtensionExternalIMP)

This module shows how to integrate custom login page with Lark by implementing the protocol `LKNativeAppExtension`  in `LKNativeAppExtension` and the protocol `LKNativeAppExtensionPageRoute` in `LKNativeAppExtensionAbility`.

### Scan QR Code | LKQRCodeExternalIMP | 扫码能力
[source code](LKQRCodeExternalIMP)

This module provides an implementation of the protocol `KAQRCodeApiDelegate` in `LKQRCodeExternal`. With this protocol, developers can implement custom callback functions on scanning a QR code.

### App Shortcut | LKShortcutExternalIMP | 桌面快捷菜单
[source code](LKShortcutExternalIMP)

This module provides an implementation of the protocol `KAShortcutProtocol` in `LKShortcutExternal`. With this protocol, developers can add custom shorcuts to app menu.

This example adds a `打开日历` shortcut to the menu that appears when the Lark app icon is long pressed. User can open the calendar app by clicking this shortcut.

### Tab Container | LKTabExternalIMP | Tab容器
[source code](LKTabExternalIMP)

This module provides an implementation of the protocol `KATabProtocol` in `LKTabExternal`. With this protocol, developers can define custom navigation tabs. 

This example adds a `三方邮件` tab to the bottom navigation bar.

### WebContainer | LKWebContainerExternalIMP
[source code](LKWebContainerExternalIMP)

This module provides an implementation of the protocol `KAWebContainerProtocol` in `LKWebContainerExternal`. With this protocol, developers can define custom callback functions for web operations. 

In this example, the native app would request a VPN connection upon openning url `"http://www.feishu.cn"`


## Ability Component | 能力组件

### Logger Ability | LKLoggerExternalIMP | 日志能力
[source code](LKLoggerExternalIMP)

This module shows how to log message via the protocol `KALoggerProtocol` in `LKLoggerExternal`.

### Message Ability | LKMessageExternalIMP | 消息能力
[source code](LKMessageExternalIMP)

This module shows how to download or forward file via the protocol `KAMessageNavigator` in `LKMessageExternal`.

### Native App Open Api | LKNativeAppPublicKitIMP | 客户端OpenAPI能力
[source code](LKNativeAppPublicKitIMP)

This module provides an example of invoking the open API `showToast` via the protocol `NativeAppManagerProtocol` in `NativeAppPublicKit`.



