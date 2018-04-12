# WebViewDemo 主要采用JSContext与原生客户端交互

目前HTML Page与Native交互支持同步与异步方式，主要实现可采用:UCWebViewController/SupportLibary/JavascriptBridge/UCJavascriptBridge.m 中实现动态跳转到指定的方法执行。

使用方法如下：

@interface CommonWebViewController : UCWebViewController
