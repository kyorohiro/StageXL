library example05;

import 'dart:async';
import 'dart:math';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

part 'world.dart';

void main() {
  
  //------------------------------------------------------------------
  // Initialize the Display List
  //------------------------------------------------------------------

  Stage stage = new Stage("myStage", html.document.query('#stage'));

  RenderLoop renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  Juggler juggler = renderLoop.juggler;
  
  //------------------------------------------------------------------
  // Use the Resource class to load some Bitmaps
  //------------------------------------------------------------------

  var resourceManager = new ResourceManager()
    ..addBitmapData("house", "../common/images/House.png")
    ..addBitmapData("sun", "../common/images/Sun.png")
    ..addBitmapData("tree", "../common/images/Tree.png");

  resourceManager.load().then((result) {
    
    // Let's create a new World

    World world = new World(resourceManager);
    world.pivotX = world.width / 2;
    world.pivotY = world.height / 2;
    world.x = 100;
    world.y = 100;
    stage.addChild(world);

    // Flash does not support programmable animations out of the box.
    // So we create our own :) Let's move the world ...

    juggler.tween(world, 2.0, TransitionFunction.easeOutBounce)
      ..animate.x.to(700)
      ..animate.y.to(500)
      ..delay = 1.0;

    juggler.tween(world, 2.0, TransitionFunction.easeOutBounce)
      ..animate.x.to(100)
      ..animate.y.to(100)
      ..delay = 4.0;

    juggler.tween(world, 6.0, TransitionFunction.easeInOutElastic)
      ..animate.rotation.to(PI * 4.0)
      ..delay = 7.0;
  });

}
