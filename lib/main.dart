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
    super.onMount();
    debugPrint('COMPONENT: onMount');
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    debugPrint('COMPONENT: onGameResize');
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    debugPrint('COMPONENT: onLoad');
  }

  @override
  void onRemove() {
    super.onRemove();
    debugPrint('COMPONENT: onRemove');
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (frames < 10) {
      debugPrint('COMPONENT: update');
    }
    frames++;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (frames < 10) {
      debugPrint('COMPONENT: render');
    }
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
    super.onMount();
    debugPrint('GAME: onMount');
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    debugPrint('GAME: onGameResize');
  }

  @override
  Future<void>? onLoad() async {
    // NOTE: If don't call `onLoad` here we get the `onRemove` after `onLoad`!
    await super.onLoad();
    debugPrint('GAME: onLoad');
    // await super.onLoad();
  }

  @override
  void onRemove() {
    super.onRemove();
    debugPrint('GAME: onRemove');
    removeAll(children);
    processLifecycleEvents();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (frames < 10) {
      debugPrint('GAME: update');
    }
    frames++;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (frames < 10) {
      debugPrint('GAME: render');
    }
    frames++;
  }
}
