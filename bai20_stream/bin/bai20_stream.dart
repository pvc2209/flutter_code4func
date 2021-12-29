import 'dart:async';

void main(List<String> arguments) {
  // Lưu ý: stream chỉ bắt đầu phát thông tin từ khi có 1 listener lắng nghe nó

  /*
  // Tạo stream từ Future
  var data = Future<int>.delayed(const Duration(seconds: 2), () {
    return 100;
  });


  Stream<int> stream = Stream<int>.fromFuture(data);
  print("stream đang phát thông tin");

  stream.listen((event) {
    print(event.toString());
  }, onDone: () {
    print("done");
  });
  */

  /*
  // Tạo stream từ Iterable
  var data1 = Iterable<int>.generate(10, (value) {
    return value * 1000;
  });

  Stream<int> stream1 = Stream<int>.fromIterable(data1);
  print("stream1 đang phát thông tin");

  stream1.listen((event) {
    print(event.toString());
  }, onDone: () {
    print("done");
  });
  */

  /*
  // Stream phát thông tin theo chu kỳ (periodic) như ở ví dụ
  // dưới là sau mỗi 2 giây thì stream sẽ phát ra value (value chạy từ 0 đến vô cùng)

  // Dùng để tạo timer
  Stream<int> stream2 =
      Stream<int>.periodic(const Duration(seconds: 2), (value) {
    return value;
  });
  print("stream2 đang phát thông tin");

  stream2.listen((event) {
    print(event.toString());
  }, onDone: () {
    print("done");
  });
  */

  /*
  // Có 2 loại stream là:
  // single subscription: 1 stream chỉ cho phép "một" listener lắng nghe
  // broadcast: 1 stream chỉ cho phép "nhiều" listener lắng nghe

  // Những ví dụ bên trên đều là single subscription, nếu muốn stream đó thành
  // boardcast thì làm như sau

  var data2 = Future<int>.delayed(const Duration(seconds: 2), () {
    return 100;
  });

  Stream<int> stream = Stream<int>.fromFuture(data2).asBroadcastStream();
  print("stream đang phát thông tin");

  // 2 listener cùng lắng nghe stream 1 lúc
  stream.listen((event) {
    print(event.toString());
  }, onDone: () {
    print("done");
  });

  stream.listen((event) {
    print(event.toString());
  }, onDone: () {
    print("done");
  });
  */

  /*
  // Cách sử dụng subcription để pause và resume việc phát (emit) data "từ stream"
  Stream<int> stream2 =
      Stream<int>.periodic(const Duration(seconds: 1), (value) {
    return value;
  });
  print("stream2 đang phát thông tin");

  // take(10) là chỉ listen 10 value từ stream
  var subscription = stream2.take(10).listen((event) {
    print(event.toString());
  }, onDone: () {
    print("done");
  });

  // Đến giây thứ 3 thì pause
  Future.delayed(const Duration(seconds: 3), () {
    print("pause");
    subscription.pause();
  });

  // Đến giây thứ 10 thì resume
  Future.delayed(const Duration(seconds: 10), () {
    print("resume");
    subscription.resume();
  });
  */

  /*
  // Stream controller - Class choh phép ta thêm tự thêm dữ liệu vào stream ** QUAN TRỌNG
  StreamController<int> controller = StreamController();

  // Listen data từ stream
  controller.stream.listen((data) {
    print(data);
  });

  // Thêm data và stream để phát đi
  controller.sink.add(100);
  controller.sink.add(200);
  controller.sink.add(300);
  */

  // stream tranformer: ví dụ stream phát ra data là 1 thì qua stream tranformer
  // ta muốn biến đổi data đó thành 1 * 1000 để gửi cho listener

  Stream<int> stream2 =
      Stream<int>.periodic(const Duration(seconds: 2), (value) {
    return value;
  });

  stream2
      .transform(StreamTransformer.fromHandlers(handleData: (input, sink) {
        var newValue = input * 1000;
        sink.add(newValue);
      }))
      .take(10)
      .listen((event) {
        print(event);
      });
}
