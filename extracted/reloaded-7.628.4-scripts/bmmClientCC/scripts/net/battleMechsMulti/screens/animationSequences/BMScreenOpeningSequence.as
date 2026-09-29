package net.battleMechsMulti.screens.animationSequences
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Expo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4083")]
   public class BMScreenOpeningSequence extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcFrame1:MovieClip;
      
      public var mcFrame2:MovieClip;
      
      public var mcFrame3:MovieClip;
      
      public var mcMouseHitArea:Sprite;
      
      private var _completeFunction:Function;
      
      public function BMScreenOpeningSequence()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         this.mcMouseHitArea.addEventListener(MouseEvent.CLICK,this.mouseClicked);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
      }
      
      public function startAnimation(param1:Function) : void
      {
         var _loc2_:Boolean = false;
         if(dataM.languageID != BMLanguageManager.LANGUAGE_ENGLISH)
         {
            if(languageM.getText("introSequence_build") != "")
            {
               _loc2_ = true;
            }
         }
         if(_loc2_)
         {
            updateTextAndFormat(this.mcFrame1.txtDialog,languageM.getText("introSequence_build"));
            updateTextAndFormat(this.mcFrame2.txtDialog,languageM.getText("introSequence_upgrade"));
            updateTextAndFormat(this.mcFrame3.txtDialog,languageM.getText("introSequence_fight"));
            this.mcFrame3.mcEngText.visible = false;
         }
         else
         {
            this.mcFrame1.mcCover.visible = false;
            this.mcFrame2.mcCover.visible = false;
            this.mcFrame1.txtDialog.text = "";
            this.mcFrame2.txtDialog.text = "";
            this.mcFrame3.txtDialog.text = "";
         }
         this._completeFunction = param1;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0.75;
         var _loc5_:Number = 1.5;
         TweenMax.fromTo(this.mcFrame1,0.3,{"x":this.mcFrame1.x - 1000},{
            "x":this.mcFrame1.x,
            "delay":_loc3_,
            "onStart":this.activateFrameSound
         });
         TweenMax.fromTo(this.mcFrame2,0.3,{"x":this.mcFrame2.x - 1000},{
            "x":this.mcFrame2.x,
            "delay":_loc4_,
            "onStart":this.activateFrameSound
         });
         TweenMax.fromTo(this.mcFrame3,0.3,{"x":this.mcFrame3.x - 1000},{
            "x":this.mcFrame3.x,
            "delay":_loc5_,
            "onStart":this.activateFrameSound
         });
         TweenMax.to(this.mcFrame1.mcMech,0.6,{
            "x":this.mcFrame1.mcMech.x,
            "delay":_loc3_ + 0.1
         });
         TweenMax.to(this.mcFrame1.mcWeapon,0.6,{
            "y":this.mcFrame1.mcWeapon.y,
            "delay":_loc3_ + 0.1
         });
         this.mcFrame1.mcMech.x += 200;
         this.mcFrame1.mcWeapon.y -= 120;
         TweenMax.to(this.mcFrame2.mcCard2,1.15,{
            "x":this.mcFrame2.mcCard2.x,
            "delay":_loc4_ + 0.3,
            "ease":Expo.easeOut
         });
         TweenMax.to(this.mcFrame2.mcCard3,1.3,{
            "x":this.mcFrame2.mcCard3.x,
            "delay":_loc4_ + 0.3,
            "ease":Expo.easeOut
         });
         TweenMax.to(this.mcFrame2.mcCard4,1.45,{
            "x":this.mcFrame2.mcCard4.x,
            "delay":_loc4_ + 0.3,
            "ease":Expo.easeOut
         });
         this.mcFrame2.mcCard2.x -= 30;
         this.mcFrame2.mcCard3.x -= 65;
         this.mcFrame2.mcCard4.x -= 100;
         TweenMax.to(this.mcFrame3.mcMech1,2,{
            "x":this.mcFrame3.mcMech1.x,
            "delay":_loc5_
         });
         TweenMax.to(this.mcFrame3.mcMech1.mcFire,2,{
            "width":this.mcFrame3.mcMech1.mcFire.width,
            "delay":_loc5_
         });
         TweenMax.to(this.mcFrame3.mcExplosion,2.5,{
            "x":this.mcFrame3.mcExplosion.x,
            "scaleX":2,
            "scaleY":2,
            "rotation":this.mcFrame3.mcExplosion.rotation + 40,
            "delay":_loc5_
         });
         TweenMax.to(this.mcFrame3.mcMech2,2.5,{
            "x":this.mcFrame3.mcMech2.x,
            "delay":_loc5_
         });
         TweenMax.to(this.mcFrame3.mcRays,2.5,{
            "x":this.mcFrame3.mcRays.x,
            "sacleX":1.2,
            "scaleY":1.2,
            "rotation":this.mcFrame3.mcRays.rotation + 80,
            "delay":_loc5_
         });
         TweenMax.to(this.mcFrame3.mcSpark1,2.5,{
            "x":this.mcFrame3.mcSparkTarget1.x,
            "y":this.mcFrame3.mcSparkTarget1.y,
            "delay":_loc5_
         });
         TweenMax.to(this.mcFrame3.mcSpark2,2.5,{
            "x":this.mcFrame3.mcSparkTarget2.x,
            "y":this.mcFrame3.mcSparkTarget2.y,
            "delay":_loc5_
         });
         TweenMax.to(this.mcFrame3.mcSpark3,2.5,{
            "x":this.mcFrame3.mcSparkTarget3.x,
            "y":this.mcFrame3.mcSparkTarget3.y,
            "delay":_loc5_
         });
         TweenMax.to(this.mcFrame3.mcSpark4,2.5,{
            "x":this.mcFrame3.mcSparkTarget4.x,
            "y":this.mcFrame3.mcSparkTarget4.y,
            "delay":_loc5_
         });
         TweenMax.to(this.mcFrame3.mcSpark5,2.5,{
            "x":this.mcFrame3.mcSparkTarget5.x,
            "y":this.mcFrame3.mcSparkTarget5.y,
            "delay":_loc5_
         });
         TweenMax.to(this.mcFrame3.mcSpark6,2.5,{
            "x":this.mcFrame3.mcSparkTarget6.x,
            "y":this.mcFrame3.mcSparkTarget6.y,
            "delay":_loc5_
         });
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
         effectsM.createSparksMC(BMScreensManager.SCR_OPENING_SEQUENCE,"spark",this.mcFrame1.mcSparksPosition1.x,this.mcFrame1.mcSparksPosition1.y,3,9,30,"horizontal","blue",false,0.7);
      }
      
      private function activateFrame2Sparks() : void
      {
         effectsM.createSparksMC(BMScreensManager.SCR_OPENING_SEQUENCE,"spark",this.mcFrame1.mcSparksPosition2.x,this.mcFrame1.mcSparksPosition2.y,3,14,30,"horizontal","blue",false,0.7);
      }
      
      private function activateFrame3Sparks() : void
      {
         effectsM.createSparksMC(BMScreensManager.SCR_OPENING_SEQUENCE,"spark",this.mcFrame1.mcSparksPosition3.x,this.mcFrame1.mcSparksPosition3.y,3,9,30,"horizontal","blue",false,0.7);
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
      
      private function mouseClicked(param1:MouseEvent) : void
      {
      }
      
      private function removeMe() : void
      {
         soundM.removeAllMusic();
         BMNotificationsManager.getInstance();
         screensM.removeScreen(BMScreensManager.SCR_OPENING_SEQUENCE);
         if(this._completeFunction != null)
         {
            this._completeFunction();
         }
      }
      
      private function removedFromStage(param1:Event) : void
      {
         this.mcMouseHitArea.removeEventListener(MouseEvent.CLICK,this.mouseClicked);
         TweenMax.killAll();
      }
   }
}

