package net.battleMechsMulti.screens.animationSequences
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.greensock.easing.Quad;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.tacticsoft.utils.RandomUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4144")]
   public class BMScreenCampaignEndingSequence extends BMBaseScreen
   {
      
      public var mcScene1A:MovieClip;
      
      public var mcScene1B:MovieClip;
      
      public var mcScene2:MovieClip;
      
      public var mcScene3:MovieClip;
      
      private var originPositions:Object;
      
      private var _timeLine:TimelineMax;
      
      private var _callbackFunction:Function;
      
      private var _mechView:BMMechView;
      
      private var _frameCounter:uint;
      
      public function BMScreenCampaignEndingSequence()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("campaignEndingSequence");
         this.initScenes();
      }
      
      private function initScenes() : void
      {
         updateTextAndFormat(this.mcScene1B.txtDialog,getScreenText("1"));
         updateTextAndFormat(this.mcScene2.txtDialog,getScreenText("2A"));
         updateTextAndFormat(this.mcScene2.txtTitle,getScreenText("2B"));
         updateTextAndFormat(this.mcScene3.txtTitle1,getScreenText("3A"));
         updateTextAndFormat(this.mcScene3.txtTitle2,getScreenText("3B"));
         screensM.createMultipleTextsBitmap("campaignEndingSequence",[this.mcScene2.txtDialog,this.mcScene2.txtTitle]," ",this.mcScene2);
         this.originPositions = new Object();
         this.originPositions["scene1A"] = new Point(this.mcScene1A.x,this.mcScene1A.y);
         this.originPositions["scene1B"] = new Point(this.mcScene1B.x,this.mcScene1B.y);
         this.originPositions["scene2"] = new Point(this.mcScene2.x,this.mcScene2.y);
         this.originPositions["scene3"] = new Point(this.mcScene3.x,this.mcScene3.y);
         this.mcScene1A.x = -820;
         this.mcScene1B.x = -820;
         this.mcScene3.y = -500;
         this.mcScene2.alpha = 0;
         updateTextAndFormat(this.mcScene3.txtTitle1,getScreenText("3A"));
         updateTextAndFormat(this.mcScene3.txtTitle2,getScreenText("3B"));
         ImageUtils.swapTextFieldWithBitMap(this.mcScene3.txtTitle1,this.mcScene3);
         ImageUtils.swapTextFieldWithBitMap(this.mcScene3.txtTitle2,this.mcScene3);
         soundM.createMusic("music8_loop","music8_loop");
      }
      
      public function startAnimation(param1:int = 0, param2:Function = null) : void
      {
         var _loc3_:int = 0;
         while(_loc3_ < param1)
         {
            this.mcScene3["mcStar" + _loc3_].gotoAndStop(2);
            _loc3_++;
         }
         this.mcScene3.addChild(this.mcScene3["mcStar" + param1]);
         this._callbackFunction = param2;
         this._timeLine = new TimelineMax();
         this._timeLine.addLabel("scene1In","+=0.3");
         this._timeLine.to(this.mcScene1A,0.5,{
            "x":this.originPositions["scene1A"].x,
            "onStart":this.activateFrameSound
         },"scene1In");
         this._timeLine.to(this.mcScene1B,0.5,{
            "delay":0.25,
            "x":this.originPositions["scene1B"].x,
            "onStart":this.activateFrameSound
         },"scene1In");
         this._timeLine.addLabel("scene1Out","+=3");
         this._timeLine.to(this.mcScene1A,0.25,{"x":820},"scene1Out");
         this._timeLine.to(this.mcScene1B,0.25,{
            "delay":0.25,
            "x":820
         },"scene1Out");
         this._timeLine.addLabel("scene2");
         this._timeLine.fromTo(this.mcScene2,1.5,{
            "alpha":0,
            "scaleX":0.5,
            "scaleY":0.5
         },{
            "alpha":1,
            "scaleX":1,
            "scaleY":1,
            "onStart":this.onScene3Start
         },"scene2");
         this._timeLine.fromTo(this.mcScene2.txtTitle,0.7,{"alpha":0},{"alpha":1},"scene2+=2.50");
         this._timeLine.to(this.mcScene2,0.25,{
            "delay":4.5,
            "x":1220,
            "onComplete":this.createMech
         },"scene2");
         this._timeLine.addLabel("scene3","+=0.3");
         this._timeLine.to(this.mcScene3,0.25,{
            "y":this.originPositions["scene3"].y,
            "onStart":this.activateFrameSound3
         },"scene3");
         this._timeLine.fromTo(this.mcScene3["mcStar" + param1],0.6,{
            "scaleX":0.2,
            "scaleY":0.2
         },{
            "scaleX":1.5,
            "scaleY":1.5,
            "frame":2,
            "colorTransform":{
               "tint":16777215,
               "tintAmount":0.5
            }
         });
         this._timeLine.to(this.mcScene3["mcStar" + param1],0.3,{
            "scaleX":1,
            "scaleY":1,
            "colorTransform":{
               "tint":16777215,
               "tintAmount":0
            },
            "onComplete":this.onAnimationCompleted
         });
      }
      
      private function onScene3Start() : void
      {
         this.activateFrameSound2();
         this.startScene3Effects();
      }
      
      private function startScene3Effects() : void
      {
         TweenMax.to(this.mcScene3.mcGlow,40,{
            "rotation":360,
            "ease":Linear.easeNone,
            "repeat":-1
         });
         this.tweenDots();
      }
      
      private function tweenDots() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < 60)
         {
            this.tweenDot(this.createDot(),RandomUtils.getRandom(0,3));
            _loc1_++;
         }
      }
      
      private function tweenDot(param1:MovieClip, param2:Number) : void
      {
         param1.x = 0;
         param1.y = 0;
         param1.alpha = 1;
         var _loc3_:Number = RandomUtils.getRandom(0,Math.PI * 2);
         var _loc4_:Number = param1.x + Math.cos(_loc3_) * 225;
         var _loc5_:Number = param1.y + Math.sin(_loc3_) * 225;
         var _loc6_:Number = 2.8;
         TweenMax.to(param1,0.8,{
            "alpha":0,
            "delay":param2 + _loc6_ - 0.8,
            "overwrite":0
         });
         TweenMax.to(param1,_loc6_,{
            "x":_loc4_,
            "y":_loc5_,
            "delay":param2,
            "onComplete":this.tweenDot,
            "onCompleteParams":[param1,0],
            "ease":Quad.easeOut,
            "overwrite":0
         });
      }
      
      private function createDot() : MovieClip
      {
         var _loc1_:MovieClip = Math.random() > 0.5 ? new spark0() : new spark1();
         this.mcScene3.mcSparksHolder.addChild(_loc1_);
         return _loc1_;
      }
      
      private function createMech() : void
      {
         this._mechView = new BMMechView();
         this._mechView.initialize(dataM.ONLINE_PLAYER_ID,"hanger",BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID,0.8,false);
         this._mechView.buildMech(dataM.myPlayerData.mechStructures[1]);
         this._mechView.y = -(this._mechView.mechSizer.height + this._mechView.mechSizer.y);
         this._mechView.activateBreathing();
         this.mcScene3.mcMechHolder.addChild(this._mechView);
         addEventListener(Event.ENTER_FRAME,this.mechBreathingOnEnterFrame);
         this._frameCounter = 0;
      }
      
      private function mechBreathingOnEnterFrame(param1:Event) : void
      {
         this._mechView.onEnterFrameTrigger();
         ++this._frameCounter;
         if(this._frameCounter == 30 || this._frameCounter == 80)
         {
            this._mechView.activateTease2();
         }
      }
      
      private function onAnimationCompleted() : void
      {
         addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      private function activateFrameSound() : void
      {
         soundM.createSound("fireRocket1",1);
      }
      
      private function activateFrameSound2() : void
      {
         soundM.createSound("godModeAngry1",1);
      }
      
      private function activateFrameSound3() : void
      {
         soundM.removeAllMusic();
         soundM.createSound("missionComplete",1);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         this.backClicked();
      }
      
      private function backClicked() : void
      {
         this._timeLine.kill();
         if(this._mechView != null)
         {
            this._mechView.removeMe();
            this._mechView = null;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.mcScene3.mcSparksHolder.numChildren)
         {
            TweenMax.killTweensOf(this.mcScene3.mcSparksHolder.getChildAt(_loc1_));
            _loc1_++;
         }
         TweenMax.killTweensOf(this.mcScene3.mcGlow);
         removeEventListener(Event.ENTER_FRAME,this.mechBreathingOnEnterFrame);
         screensM.removeScreen("screenCampaignEndingSequence");
      }
   }
}

