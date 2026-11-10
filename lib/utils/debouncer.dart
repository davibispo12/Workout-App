import 'dart:async';

class Debouncer {
  final Duration tempoDeEspera;
  Timer? _timer;
  Debouncer ({required this.tempoDeEspera});

  void executar (void Function() acao){
  _timer?.cancel();
  _timer = Timer(tempoDeEspera, acao);
  }
  void cancelar(){
  _timer?.cancel();

  }


}