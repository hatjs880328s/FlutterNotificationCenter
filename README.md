
# FlutterNotificationCenter
## 参照IOS通知中心 Flutter版本
## 
## 如何使用？
1. 发送消息、通知
   ```swift
   // post notification
   NotificationCenter.postNotification(
        NotificationKeyCenter.chatWindowReplayOneMsg,
        {'msg': msg, 'orderType': orderMsgType.withDrawMsg});
   ```
2. 接受消息、通知
    ```swift
    // receive notification
    NotificationCenter.addNotification(
        NotificationKeyCenter.chatWindowReplayOneMsg,
        this,
        replayOneMsgReloadUI);
    ```
    ```swift
    //消息引用
    void replayOneMsgReloadUI(Map<String, dynamic> info) {
        // ...
    }
    ```
3. 移除通知
   ```swift
   // invoke this in dispose function or others dealloc function
   NotificationCenter.removeOneItem(
        NotificationKeyCenter.chatWindowReplayOneMsg, this);
   ```
 
    
