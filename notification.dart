/*
 * @Author: Noah shan
 * @Date: 2021-03-16 17:45:50
 * @LastEditTime: 2022-04-14 10:41:21
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: notification.dart
 */

/// 推送中心
/// 目前推送中心自己维护，不适用flutter版本的wigget notification

class NotificationCenter {
  /// 被监听者hash表
  static Map<String, List<Object>> allObservables = {};

  /// 执行函数hash table
  static Map<String, Function> functions = {};

  /// 添加一个被监听者
  static void addNotification(String key, Object observable, Function action) {
    String newKey = key + observable.hashCode.toString();
    if (NotificationCenter.allObservables[key] == null) {
      NotificationCenter.allObservables[key] = [observable];
      NotificationCenter.functions[newKey] = action;
    } else {
      List<Object> nowInfo = NotificationCenter.allObservables[key] ?? [];
      nowInfo.add(observable);
      NotificationCenter.allObservables[key] = nowInfo;
      NotificationCenter.functions[newKey] = action;
    }
  }

  /// 移除一个对象
  static void removeOneItem(String key, Object item) {
    try {
      String newKey = key + item.hashCode.toString();
      if (NotificationCenter.allObservables[key] == null) {
        // donothing...
      } else {
        // 1.先移除方法map
        NotificationCenter.functions.remove(newKey);
        // 2.再移除对象map
        List<Object> objInfo = NotificationCenter.allObservables[key] ?? [];
        for (Object eachitem in objInfo) {
          if (item == eachitem) {
            objInfo.remove(eachitem);
            break;
          }
        }
        NotificationCenter.allObservables[key] = objInfo;
      }
    } catch (e) {
      print(e);
    }
  }

  /// 发送一个通知
  static void postNotification(String key, Map<String, dynamic> params) {
    if (NotificationCenter.allObservables[key] == null) {
      // donothing...
    } else {
      // 获取所有对象
      List<Object> nowInfo = NotificationCenter.allObservables[key] ?? [];
      // 循环所有对象获取指定key
      for (Object item in nowInfo) {
        String functionKey = key + item.hashCode.toString();
        if (NotificationCenter.functions[functionKey] != null) {
          NotificationCenter.functions[functionKey]!(params);
        } else {
          // 需要检测，应该是释放时忘记手动销毁
          print('FORGET 2 RELEASE NAME: $functionKey');
        }
      }
    }
  }
}
