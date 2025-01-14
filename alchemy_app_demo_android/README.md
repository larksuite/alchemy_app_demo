| 模块 | 简介 | 涉及协议组件 | 涉及能力组件 |
| -- | -- | -- | -- |
| lifecycle-api-impl | 监听生命周期与登录态的变化。 | lifecycle-api | N/A |
| logger | 包装了飞书的日志能力。 | N/A | logger-api, core-component-api |
|  message-action-api-impl | 向文件类型的消息增加了「下载」菜单项。 | message-action-api | N/A |
| native-app-extension-ability-impl | 为JSBridge提供了地图相关能力。 | native-app-extension-ability| N/A |
| native-app-extension-api-impl | 自定义登录页面。 | native-app-extension-api | kv-api, core-component-api, applink-api |
| qrcode-api-impl | 监听扫码的回调。 | qrcode-api | N/A |
| shortcut-api-impl | 自定义桌面快捷方式。例如打开日历和任务。 | shortcut-api | N/A |
| tab-container-api-impl | 自定义Tab容器。在点击进入邮件详情页后可以转发文件到消息。 | tab-container-api | message-api, core-component-api |