package net.battleMechsMulti.screens.languages
{
   import com.greensock.TweenMax;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.buttons.BMLanguageButton;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMSwitchToSpecificLanguagePanel extends BMMovieClip
   {
      
      public var txtDescEng:TextField;
      
      public var txtDescSpecificLang:TextField;
      
      public var btnLang:BMLanguageButton;
      
      private var _languageID:uint;
      
      private var _onLanguageSelected:Function;
      
      private var _onButtonAnimCompleted:Function;
      
      private var _langButtonAnimationTargetPoint:Point;
      
      private var _langButtonAnimationTargetScale:Number;
      
      public function BMSwitchToSpecificLanguagePanel()
      {
         super();
      }
      
      public function init(param1:uint, param2:Function, param3:Function, param4:String, param5:String, param6:Point = null, param7:Number = 1) : void
      {
         updateTextAndFormat(this.txtDescEng,param4);
         var _loc8_:Number = TextUtils.SIZE_KEEP_CURRENT;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:String = TextUtils.getTextFont_short(param1);
         updateTextAndFormat(this.txtDescSpecificLang,param5,_loc8_,_loc9_,_loc10_,_loc11_);
         this._languageID = param1;
         this._onLanguageSelected = param2;
         this._onButtonAnimCompleted = param3;
         this._langButtonAnimationTargetPoint = param6;
         this._langButtonAnimationTargetScale = param7;
         var _loc12_:String = BMLanguageManager.getInstance().getFlagIconNameByLanguageID(this._languageID);
         var _loc13_:Sprite = BMDataManager.getInstance().getLocalGraphicIcon(_loc12_);
         this.btnLang.addEventListener(BMIntractable.HIT,this.onLangButtonHit);
         this.btnLang.addFlagImage(_loc13_);
         addEventListener(MouseEvent.CLICK,this.onGeneralClick);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      private function onGeneralClick(param1:MouseEvent) : void
      {
         if(this.btnLang.isEnabled() == false)
         {
            return;
         }
         this.switchToLanguageConfirmed();
      }
      
      private function onLangButtonHit(param1:Event) : void
      {
         this.switchToLanguageConfirmed();
      }
      
      private function switchToLanguageConfirmed() : void
      {
         this._onLanguageSelected(this._languageID);
         if(this._langButtonAnimationTargetPoint == null)
         {
            this._onButtonAnimCompleted();
         }
         this.hideMe(true);
         this.btnLang.disableMe();
         removeEventListener(MouseEvent.CLICK,this.onGeneralClick);
      }
      
      public function hideMe(param1:Boolean = false) : void
      {
         if(visible == false)
         {
            return;
         }
         if(this.btnLang.isEnabled() == false)
         {
            return;
         }
         if(param1 && this._langButtonAnimationTargetPoint != null)
         {
            TweenMax.to(this.btnLang,0.3,{
               "x":this._langButtonAnimationTargetPoint.x,
               "y":this._langButtonAnimationTargetPoint.y,
               "scaleX":this._langButtonAnimationTargetScale,
               "scaleY":this._langButtonAnimationTargetScale,
               "onComplete":this.moveLangButtonAnimCompleted
            });
         }
         else
         {
            this.initOutAnimation();
         }
      }
      
      private function initOutAnimation() : void
      {
         this.btnLang.visible = false;
         TweenMax.to(this,0.6,{
            "y":-150,
            "onComplete":this.outAnimCompleted
         });
      }
      
      private function moveLangButtonAnimCompleted() : void
      {
         this.initOutAnimation();
         this._onButtonAnimCompleted();
      }
      
      private function outAnimCompleted() : void
      {
         visible = false;
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         removeEventListener(MouseEvent.CLICK,this.onGeneralClick);
         TweenMax.killTweensOf(this.btnLang);
         TweenMax.killTweensOf(this);
      }
   }
}

