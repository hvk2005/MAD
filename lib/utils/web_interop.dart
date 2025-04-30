@JS()
library web_interop;

import 'package:js/js.dart';
import 'package:js/js_util.dart' as js_util;
import 'dart:async';

@JS('Promise')
external dynamic get JsPromise;

@JS('Object')
class Object {
  external static dynamic defineProperty(
      dynamic o, String name, ObjectPropertyDescriptor descriptor);
}

@JS()
@anonymous
class ObjectPropertyDescriptor {
  external factory ObjectPropertyDescriptor({
    dynamic value,
    bool? enumerable,
    bool? configurable,
    bool? writable,
  });
}

dynamic handleThenable(dynamic thenable) {
  return js_util.promiseToFuture(thenable);
}

dynamic jsify(Object object) {
  return js_util.jsify(object);
}

dynamic dartify(Object object) {
  return js_util.dartify(object);
}

class PromiseJsImpl<T> {
  final dynamic _promise;
  PromiseJsImpl(this._promise);

  Future<T> then<T>(FutureOr<T> Function(dynamic value) onFulfilled) {
    return js_util.promiseToFuture(_promise).then(onFulfilled);
  }
}
