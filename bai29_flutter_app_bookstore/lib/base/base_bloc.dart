import 'dart:async';

import 'package:bai29_flutter_app_bookstore/base/base_event.dart';
import 'package:flutter/foundation.dart';

abstract class BaseBloc {
  // Controller này cho phép phía view gửi data(event) đến Bloc để xử lý
  final StreamController<BaseEvent> _eventStreamController = StreamController();

  Sink<BaseEvent> get event => _eventStreamController.sink;

  BaseBloc() {
    _eventStreamController.stream.listen((BaseEvent event) {
      // Không cần check event thuộc kiểu BaseEvent như
      // trong bài mẫu vì generic của StreamController đã là BaseEvent rồi

      // Lại truyền event vào hàm dispatchEvent để xử lý
      // tùy theo ý event thuộc kiểu AddTodoEvent hay DeleteTodoEvent
      dispatchEvent(event); // dispatch có nghĩa là gửi đi
    });
  }

  // Lớp nào extends abstract class phải triền khai hàm này
  void dispatchEvent(BaseEvent event);

  // @mustCallSuper đảm bảo khi class nào extends từ BaseBloc khi call dispose cũng sẽ tự động call hàm này
  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
  }
}
