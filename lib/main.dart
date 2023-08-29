import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends HookWidget {
  static const Color baizeColor = Color.fromRGBO(0, 0xa0, 0, 1);

  const GameScreen({super.key}) : super();

  @override
  Widget build(BuildContext context) {
    var theGame = useMemoized(() => TheGame());
    var gameWidget = useState(GameWidget(game: TheGame()));

    return Scaffold(
      backgroundColor: baizeColor,
      floatingActionButton: FloatingActionButton(onPressed: () {
        gameWidget.value = GameWidget(game: theGame);
      }),
      body: SafeArea(child: gameWidget.value),
    );
  }
}

class DebugComponent extends PositionComponent {
  int frames = 0;

  DebugComponent();

  @override
  void onMount() {
    debugPrint('COMPONENT: onMount');
    super.onMount();
  }

  @override
  void onGameResize(Vector2 size) {
    debugPrint('COMPONENT: onGameResize');
    super.onGameResize(size);
  }

  @override
  Future<void>? onLoad() async {
    debugPrint('COMPONENT: onLoad');
    await super.onLoad();
  }

  @override
  void onRemove() {
    debugPrint('COMPONENT: onRemove');
    super.onRemove();
  }

  @override
  void update(double dt) {
    if (frames < 10) {
      debugPrint('COMPONENT: update');
    }
    super.update(dt);
    frames++;
  }

  @override
  void render(Canvas canvas) {
    if (frames < 10) {
      debugPrint('COMPONENT: render');
    }
    super.render(canvas);
    frames++;
  }
}

class TheGame extends FlameGame {
  int frames = 0;

  TheGame() {
    add(DebugComponent());
  }

  @override
  void onMount() {
    debugPrint('GAME: onMount');
    super.onMount();
  }

  @override
  void onGameResize(Vector2 size) {
    debugPrint('GAME: onGameResize');
    super.onGameResize(size);
  }

  @override
  Future<void>? onLoad() async {
    debugPrint('GAME: onLoad');
    await super.onLoad();
  }

  @override
  void onRemove() {
    debugPrint('GAME: onRemove');
    super.onRemove();
  }

  @override
  void update(double dt) {
    if (frames < 10) {
      debugPrint('GAME: update');
    }
    super.update(dt);
    frames++;
  }

  @override
  void render(Canvas canvas) {
    if (frames < 10) {
      debugPrint('GAME: render');
    }
    super.render(canvas);
    frames++;
  }
}
