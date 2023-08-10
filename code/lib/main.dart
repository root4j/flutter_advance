import 'package:flutter/material.dart';

import 's01/check_signal_basic.dart';
import 's01/check_signal_get.dart';

void main() {
  var tipo = Tipos.checkSignalGet;
  switch (tipo) {
    case Tipos.checkSignalBasic:
      runApp(const CheckSignalBasic());
      break;
    case Tipos.checkSignalGet:
      runApp(const CheckSignalGet());
      break;
    default:
      runApp(const CheckSignalBasic());
      break;
  }
}

// Enumeracion para ejecucion principal de Wigets
enum Tipos { checkSignalBasic, checkSignalGet }
