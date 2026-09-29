package net.battleMechsMulti.screens.animationSequences
{
   import com.greensock.TimelineMax;
   import com.greensock.easing.BackOut;
   import com.greensock.easing.Cubic;
   import com.greensock.easing.Linear;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol4114")]
   public class BMScreenCampaignOpeningSequence extends BMBaseScreen
   {
      
      public var mcScene1:MovieClip;
      
      public var mcScene2A:MovieClip;
      
      public var mcScene2B:MovieClip;
      
      public var mcScene2C:MovieClip;
      
      public var mcScene3:MovieClip;
      
      public var mcMouseHitArea:Sprite;
      
      public var txtScene3Title:TextField;
      
      private var originPositions:Object;
      
      private var _timeLine:TimelineMax;
      
      private var _callbackFunction:Function;
      
      private const SCENE_1:String = "scene1";
      
      private const SCENE_2_IN:String = "scene2In";
      
      private const SCENE_2_OUT:String = "scene2Out";
      
      private const SCENE_2A:String = "scene2A";
      
      private const SCENE_2B:String = "scene2B";
      
      private const SCENE_2C:String = "scene2C";
      
      private const SCENE_3:String = "scene3";
      
      private const SCENE_MECHS_LOGO:String = "mcMechsLogo";
      
      public function BMScreenCampaignOpeningSequence()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         this.initTexts();
         this.initScenes();
         this.mcMouseHitArea.addEventListener(MouseEvent.CLICK,this.mouseClicked);
      }
      
      private function initTexts() : void
      {
         setLanguageManagerScreenName("campaignOpeningSequence");
      }
      
      private function initScenes() : void
      {
         this.originPositions = new Object();
         updateTextAndFormat(this.mcScene1.txtDialog,getScreenText("1"));
         updateTextAndFormat(this.mcScene2A.txtDialog,getScreenText("2A"));
         updateTextAndFormat(this.mcScene2B.txtDialog,getScreenText("2B"));
         updateTextAndFormat(this.mcScene2C.txtDialog,getScreenText("2C"));
         updateTextAndFormat(this.txtScene3Title,getScreenText("theWorldNeeds"));
         this.originPositions[this.SCENE_1] = new Point(this.mcScene1.x,this.mcScene1.y);
         this.originPositions[this.SCENE_2A] = new Point(this.mcScene2A.x,this.mcScene2A.y);
         this.originPositions[this.SCENE_2B] = new Point(this.mcScene2B.x,this.mcScene2B.y);
         this.originPositions[this.SCENE_2C] = new Point(this.mcScene2C.x,this.mcScene2C.y);
         this.originPositions[this.SCENE_3] = new Point(this.mcScene3.x,this.mcScene3.y);
         this.originPositions[this.SCENE_MECHS_LOGO] = new Point(this.mcScene3.mcMechsLogo.x,this.mcScene3.mcMechsLogo.y);
         this.mcScene1.y = -500;
         this.mcScene2A.y = -500;
         this.mcScene2B.x = -500;
         this.mcScene2C.y = 850;
         this.txtScene3Title.alpha = 0;
         this.mcScene3.visible = false;
         soundM.createMusic("music8_loop","music8_loop");
      }
      
      public function startAnimation(param1:Function) : void
      {
         this._callbackFunction = param1;
         this._timeLine = new TimelineMax();
         this._timeLine.addLabel(this.SCENE_1,"+=0.3");
         this._timeLine.to(this.mcScene1,0.5,{
            "y":this.originPositions[this.SCENE_1].y,
            "ease":BackOut.ease.config(1),
            "onStart":this.activateFrameSound
         },this.SCENE_1);
         this._timeLine.to(this.mcScene1,0.25,{
            "delay":2,
            "y":500
         },this.SCENE_1);
         this._timeLine.addLabel(this.SCENE_2_IN,"-=0.2");
         this._timeLine.to(this.mcScene2A,0.5,{
            "y":this.originPositions[this.SCENE_2A].y,
            "ease":BackOut.ease.config(1),
            "onStart":this.activateFrameSound
         },this.SCENE_2_IN);
         this._timeLine.to(this.mcScene2B,0.5,{
            "x":this.originPositions[this.SCENE_2B].x,
            "ease":BackOut.ease.config(1),
            "onStart":this.activateFrameSound
         },"scene2In+=1");
         this._timeLine.to(this.mcScene2C,0.5,{
            "y":this.originPositions[this.SCENE_2C].y,
            "ease":BackOut.ease.config(1),
            "onStart":this.activateFrameSound
         },"scene2In+=2");
         this._timeLine.addLabel(this.SCENE_2_OUT,"+=2.5");
         this._timeLine.to(this.mcScene2A,0.25,{"x":-500},this.SCENE_2_OUT);
         this._timeLine.to(this.mcScene2B,0.25,{"y":500},this.SCENE_2_OUT);
         this._timeLine.to(this.mcScene2C,0.25,{"x":850},this.SCENE_2_OUT);
         this._timeLine.to(this.txtScene3Title,0.5,{"alpha":1});
         this._timeLine.addLabel(this.SCENE_3,"+=1");
         this._timeLine.to(this.txtScene3Title,0.2,{"alpha":0},this.SCENE_3);
         this._timeLine.fromTo(this.mcScene3,0.5,{
            "scaleX":2,
            "scaleY":2
         },{
            "visible":true,
            "scaleX":1,
            "scaleY":1,
            "ease":Cubic.easeIn,
            "onStart":this.activateDropSound
         },this.SCENE_3);
         this._timeLine.to(this.mcScene3,0.1,{
            "scaleX":1.07,
            "scaleY":1.07,
            "ease":Linear.easeNone
         });
         this._timeLine.to(this.mcScene3,0.1,{
            "scaleX":1,
            "scaleY":1,
            "ease":Linear.easeNone
         });
         this._timeLine.to(this.mcScene3,0.25,{
            "delay":3,
            "x":1300,
            "onComplete":this.animationCompleted
         },this.SCENE_3);
      }
      
      private function activateFrameSound() : void
      {
         soundM.createSound("fireRocket1",1);
      }
      
      private function activateDropSound() : void
      {
         soundM.createSound("doorsClose",1.8);
      }
      
      private function mouseClicked(param1:MouseEvent) : void
      {
      }
      
      private function animationCompleted() : void
      {
         this._timeLine.kill();
         this.mcMouseHitArea.removeEventListener(MouseEvent.CLICK,this.mouseClicked);
         screensM.removeScreen(BMScreensManager.SCR_CAMPAIGN_OPENING_SEQUENCE);
         screensM.addScreen(BMScreensManager.SCR_OPENING_SEQUENCE);
         screensM.screenOpeningSequence.startAnimation(this._callbackFunction);
      }
   }
}

