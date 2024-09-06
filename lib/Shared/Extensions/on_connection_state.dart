import 'package:flutter/material.dart';

extension OnConnectionState on ConnectionState {
  bool get isDone => this == ConnectionState.done;

  bool get isWaiting => this == ConnectionState.waiting;

  bool get isActive => this == ConnectionState.active;

  bool get isNone => this == ConnectionState.none;
}
