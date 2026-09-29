package net.battleMechsMulti.screens
{
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol186")]
   public class BMScreenOpeningSequence extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcFrame1:MovieClip;
      
      public var mcFrame2:MovieClip;
      
      public var mcFrame3:MovieClip;
      
      private var _completeFunction:Function;
      
      public function BMScreenOpeningSequence()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
      }
      
      public function startAnimation(param1:Function) : void
      {
         this._completeFunction = param1;
         var _loc2_:Number = 0.5;
         var _loc3_:Number = 1.25;
         var _loc4_:Number = 2;
         TweenMax.fromTo(this.mcFrame1,0.3,{"x":this.mcFrame1.x - 1000},{
            "x":this.mcFrame1.x,
            "delay":_loc2_,
            "onStart":this.activateFrameSound
         });
         TweenMax.fromTo(this.mcFrame2,0.3,{"x":this.mcFrame2.x - 1000},{
            "x":this.mcFrame2.x,
            "delay":_loc3_,
            "onStart":this.activateFrameSound
         });
         TweenMax.fromTo(this.mcFrame3,0.3,{"x":this.mcFrame3.x - 1000},{
            "x":this.mcFrame3.x,
            "delay":_loc4_,
            "onStart":this.activateFrameSound
         });
         TweenMax.to(this.mcFrame1.mcText1,0.25,{
            "x":this.mcFrame1.mcText1.x,
            "delay":_loc2_
         });
         TweenMax.to(this.mcFrame1.mcText2,0.25,{
            "x":this.mcFrame1.mcText2.x,
            "delay":_loc2_ + 0.1
         });
         TweenMax.to(this.mcFrame1.mcMech,0.6,{
            "x":this.mcFrame1.mcMech.x,
            "delay":_loc2_ + 0.1
         });
         TweenMax.to(this.mcFrame1.mcWeapon,0.6,{
            "y":this.mcFrame1.mcWeapon.y,
            "delay":_loc2_ + 0.1
         });
         this.mcFrame1.mcText1.x -= 250;
         this.mcFrame1.mcText2.x -= 250;
         this.mcFrame1.mcMech.x += 300;
         this.mcFrame1.mcWeapon.y -= 120;
         TweenMax.to(this.mcFrame2.mcText1,0.25,{
            "x":this.mcFrame2.mcText1.x,
            "delay":_loc3_
         });
         TweenMax.to(this.mcFrame2.mcText2,0.25,{
            "x":this.mcFrame2.mcText2.x,
            "delay":_loc3_ + 0.1
         });
         TweenMax.to(this.mcFrame2.mcBox,1.3,{
            "x":this.mcFrame2.mcBox.x,
            "delay":_loc3_
         });
         TweenMax.to(this.mcFrame2.mcCard1,1,{
            "x":this.mcFrame2.mcCard1.x - 10,
            "rotation":-22,
            "delay":_loc3_
         });
         TweenMax.to(this.mcFrame2.mcCard2,1.15,{
            "x":this.mcFrame2.mcCard2.x,
            "rotation":0,
            "delay":_loc3_
         });
         TweenMax.to(this.mcFrame2.mcCard3,1.3,{
            "x":this.mcFrame2.mcCard3.x,
            "rotation":22,
            "delay":_loc3_
         });
         this.mcFrame2.mcText1.x += 350;
         this.mcFrame2.mcText2.x += 350;
         this.mcFrame2.mcBox.x -= 15;
         this.mcFrame2.mcCard1.x -= 25;
         this.mcFrame2.mcCard2.x -= 25;
         this.mcFrame2.mcCard3.x -= 25;
         this.mcFrame2.mcCard1.rotation = -35;
         this.mcFrame2.mcCard2.rotation = -35;
         this.mcFrame2.mcCard3.rotation = -35;
         TweenMax.to(this.mcFrame3.mcText1,0.25,{
            "x":this.mcFrame3.mcText1.x,
            "delay":_loc4_
         });
         TweenMax.to(this.mcFrame3.mcText2,0.25,{
            "x":this.mcFrame3.mcText2.x,
            "delay":_loc4_ + 0.1
         });
         TweenMax.to(this.mcFrame3.mcText3,0.25,{
            "x":this.mcFrame3.mcText3.x,
            "delay":_loc4_ + 0.2
         });
         TweenMax.to(this.mcFrame3.mcMech1,2.5,{
            "x":this.mcFrame3.mcMech1.x,
            "delay":_loc4_
         });
         TweenMax.to(this.mcFrame3.mcMech1.mcFire,2.5,{
            "width":this.mcFrame3.mcMech1.mcFire.width,
            "delay":_loc4_
         });
         TweenMax.to(this.mcFrame3.mcExplosion,2.5,{
            "x":this.mcFrame3.mcExplosion.x,
            "scaleX":2,
            "scaleY":2,
            "rotation":this.mcFrame3.mcExplosion.rotation + 40,
            "delay":_loc4_
         });
         TweenMax.to(this.mcFrame3.mcMech2,2.5,{
            "x":this.mcFrame3.mcMech2.x,
            "delay":_loc4_
         });
         TweenMax.to(this.mcFrame3.mcRays,2.5,{
            "x":this.mcFrame3.mcRays.x,
            "sacleX":1.2,
            "scaleY":1.2,
            "rotation":this.mcFrame3.mcRays.rotation + 80,
            "delay":_loc4_
         });
         TweenMax.to(this.mcFrame3.mcSpark1,2.5,{
            "x":this.mcFrame3.mcSparkTarget1.x,
            "y":this.mcFrame3.mcSparkTarget1.y,
            "delay":_loc4_
         });
         TweenMax.to(this.mcFrame3.mcSpark2,2.5,{
            "x":this.mcFrame3.mcSparkTarget2.x,
            "y":this.mcFrame3.mcSparkTarget2.y,
            "delay":_loc4_
         });
         TweenMax.to(this.mcFrame3.mcSpark3,2.5,{
            "x":this.mcFrame3.mcSparkTarget3.x,
            "y":this.mcFrame3.mcSparkTarget3.y,
            "delay":_loc4_
         });
         TweenMax.to(this.mcFrame3.mcSpark4,2.5,{
            "x":this.mcFrame3.mcSparkTarget4.x,
            "y":this.mcFrame3.mcSparkTarget4.y,
            "delay":_loc4_
         });
         TweenMax.to(this.mcFrame3.mcSpark5,2.5,{
            "x":this.mcFrame3.mcSparkTarget5.x,
            "y":this.mcFrame3.mcSparkTarget5.y,
            "delay":_loc4_
         });
         TweenMax.to(this.mcFrame3.mcSpark6,2.5,{
            "x":this.mcFrame3.mcSparkTarget6.x,
            "y":this.mcFrame3.mcSparkTarget6.y,
            "delay":_loc4_
         });
         this.mcFrame3.mcText1.x -= 300;
         this.mcFrame3.mcText2.x -= 300;
         this.mcFrame3.mcText3.x -= 300;
         this.mcFrame3.mcMech1.x -= 150;
         this.mcFrame3.mcMech1.mcFire.width += 120;
         this.mcFrame3.mcExplosion.x -= 30;
         this.mcFrame3.mcMech2.x -= 30;
         this.mcFrame3.mcRays.x -= 30;
         TweenMax.to(this,1,{"onComplete":this.activateFrame1Sparks});
         TweenMax.to(this,2,{"onComplete":this.activateFrame2Sparks});
         TweenMax.to(this,3,{"onComplete":this.activateFrame3Sparks});
         TweenMax.to(this,6,{"onComplete":this.moveFramesOut});
         TweenMax.to(this,6.8,{"onComplete":this.removeMe});
      }
      
      private function activateFrameSound() : void
      {
         soundM.createSound("fireRocket1",1);
      }
      
      private function activateFrame1Sparks() : void
      {
         effectsM.createSparksMC("screenOpeningSequence","spark",this.mcFrame1.mcSparksPosition1.x,this.mcFrame1.mcSparksPosition1.y,3,9,30,"horizontal","blue",false,0.7);
      }
      
      private function activateFrame2Sparks() : void
      {
         effectsM.createSparksMC("screenOpeningSequence","spark",this.mcFrame1.mcSparksPosition2.x,this.mcFrame1.mcSparksPosition2.y,3,14,30,"horizontal","blue",false,0.7);
      }
      
      private function activateFrame3Sparks() : void
      {
         effectsM.createSparksMC("screenOpeningSequence","spark",this.mcFrame1.mcSparksPosition3.x,this.mcFrame1.mcSparksPosition3.y,3,9,30,"horizontal","blue",false,0.7);
      }
      
      private function moveFramesOut() : void
      {
         TweenMax.to(this.mcFrame1,0.25,{"x":900});
         TweenMax.to(this.mcFrame2,0.25,{
            "x":900,
            "delay":0.25
         });
         TweenMax.to(this.mcFrame3,0.25,{
            "x":900,
            "delay":0.5
         });
      }
      
      private function removeMe() : void
      {
         BMNotificationsManager.getInstance();
         screensM.removeScreen("screenOpeningSequence");
         this._completeFunction();
      }
      
      private function removedFromStage(param1:Event) : void
      {
         TweenMax.killAll();
      }
   }
}

