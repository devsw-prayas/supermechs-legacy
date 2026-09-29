package net.battleMechsMulti.screens.popups
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2013")]
   public class BMScreenYesNoPopup extends BMBaseScreen
   {
      
      public static const SIGN_NONE:uint = 0;
      
      public static const SIGN_QUESTION:uint = 1;
      
      public static const SIGN_EXCLAMATION:uint = 2;
      
      public static const GUIDE_ARROW_DIRECTION_RIGHT:String = "right";
      
      public static const GUIDE_ARROW_DIRECTION_LEFT:String = "left";
      
      public var txtTitle:TextField;
      
      public var txtDesc1:TextField;
      
      public var txtDesc2:TextField;
      
      public var txtDesc3:TextField;
      
      public var txtDesc4:TextField;
      
      public var txtDesc5:TextField;
      
      public var btnYes:BMBasicButton;
      
      public var btnNo:BMBasicButton;
      
      public var btnNoX:BMBasicButton;
      
      public var mcGuideArrow:Sprite;
      
      public var mcSign1:MovieClip;
      
      public var mcSign2:MovieClip;
      
      public var mcRays:Sprite;
      
      private var _yes:Function;
      
      private var _no:Function;
      
      private var _guideArrowController:BMTutorialArrowController;
      
      public function BMScreenYesNoPopup()
      {
         super();
      }
      
      public function initialize() : void
      {
      }
      
      public function displayYesNoPopup(param1:String, param2:String = "", param3:String = "", param4:Function = null, param5:Function = null, param6:String = "", param7:String = "", param8:uint = 1) : void
      {
         generateSingletonClassesPointers();
         if(this.txtTitle != null)
         {
            updateTextAndFormat(this.txtTitle,param1);
         }
         this.setDesc1Text(param2);
         if(this.txtDesc2 != null)
         {
            updateTextAndFormat(this.txtDesc2,param3);
         }
         this._yes = param4;
         this._no = param5;
         var _loc9_:String = getGeneralText("OK");
         var _loc10_:String = getGeneralText("cancel");
         if(param6 != "")
         {
            _loc9_ = param6;
         }
         if(param7 != "")
         {
            _loc10_ = param7;
         }
         this.btnYes.text = _loc9_;
         this.btnYes.addEventListener(BMIntractable.HIT,this.yesClicked);
         if(this.btnNo != null)
         {
            this.btnNo.text = _loc10_;
            this.btnNo.addEventListener(BMIntractable.HIT,this.noClicked);
         }
         if(this.btnNoX != null)
         {
            this.btnNoX.addEventListener(BMIntractable.HIT,this.noClicked);
         }
         if(this.mcSign1 != null)
         {
            if(param8 == SIGN_NONE)
            {
               this.mcSign1.visible = false;
               this.mcSign2.visible = false;
            }
            else
            {
               this.mcSign1.gotoAndStop(param8);
               this.mcSign2.gotoAndStop(param8);
            }
         }
         if(this.mcGuideArrow != null)
         {
            this.mcGuideArrow.parent.removeChild(this.mcGuideArrow);
         }
         if(this.mcRays != null)
         {
            TweenMax.to(this.mcRays,30,{
               "rotation":360,
               "ease":Linear.easeNone,
               "repeat":-1
            });
         }
      }
      
      public function setDesc3Text(param1:String) : void
      {
         if(this.txtDesc3 != null)
         {
            updateTextAndFormat(this.txtDesc3,param1,TextUtils.SIZE_KEEP_CURRENT,false,true);
         }
      }
      
      public function setDesc4Text(param1:String) : void
      {
         if(this.txtDesc4 != null)
         {
            updateTextAndFormat(this.txtDesc4,param1,TextUtils.SIZE_KEEP_CURRENT,false,true);
         }
      }
      
      public function setDesc5Text(param1:String) : void
      {
         if(this.txtDesc5 != null)
         {
            updateTextAndFormat(this.txtDesc5,param1,TextUtils.SIZE_KEEP_CURRENT,false,true);
         }
      }
      
      protected function setDesc1Text(param1:String) : void
      {
         if(this.txtDesc1 != null)
         {
            updateTextAndFormat(this.txtDesc1,param1,TextUtils.SIZE_KEEP_CURRENT,false,true);
         }
      }
      
      private function yesClicked(param1:Event) : void
      {
         this.removeMe();
         if(this._yes != null)
         {
            this.runYesFunction();
         }
      }
      
      protected function runYesFunction() : void
      {
         this._yes();
      }
      
      private function noClicked(param1:Event) : void
      {
         this.removeMe();
         if(this._no != null)
         {
            this._no();
         }
      }
      
      public function activateGuideArrow(param1:BMBasicButton, param2:String = "right") : void
      {
         if(this.mcGuideArrow == null)
         {
            return;
         }
         if(this._guideArrowController == null)
         {
            this._guideArrowController = new BMTutorialArrowController(this.mcGuideArrow);
         }
         var _loc3_:uint = 0;
         var _loc4_:Number = param1.x + param1.width;
         var _loc5_:Number = param1.y + param1.height / 2;
         if(param2 == GUIDE_ARROW_DIRECTION_LEFT)
         {
            _loc3_ = 180;
            _loc4_ = param1.x;
         }
         this._guideArrowController.activateTutorialArrowWithTimer(this,_loc4_,_loc5_,_loc3_);
      }
      
      public function removeMe() : void
      {
         if(this._guideArrowController != null)
         {
            this._guideArrowController.deactivateTutorialArrow();
         }
         if(this.mcRays != null)
         {
            TweenMax.killTweensOf(this.mcRays);
         }
         screensM.removeScreen(BMScreensManager.SCR_YES_NO_POPUP,true);
      }
   }
}

