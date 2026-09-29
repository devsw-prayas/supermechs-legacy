package net.battleMechsMulti.mobiles.buttons
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMBasicButton extends BMIntractable
   {
      
      public var txtTitle:TextField;
      
      public var txtSubTitle:TextField;
      
      public var txtPlaceHolder:MovieClip;
      
      public var txtSubPlaceHolder:MovieClip;
      
      public var contentPlaceHolder:MovieClip;
      
      public var contentSizer:MovieClip;
      
      public var mcLocked:Sprite;
      
      public var mcSkins:MovieClip;
      
      private var _clickSoundFunction:Function;
      
      private var _rolloverSoundFunction:Function;
      
      private var _origTextSize:Number = 12;
      
      private var _origSubTextSize:Number = 12;
      
      public function BMBasicButton()
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         super();
         mouseEnabled = true;
         mouseChildren = false;
         addEventListener(BMIntractable.DOWN,this.onDown);
         addEventListener(MouseEvent.ROLL_OUT,this.onOut);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         this._rolloverSoundFunction = BMScreensManager.getInstance().sound_buttonRollover;
         this._clickSoundFunction = BMScreensManager.getInstance().sound_buttonClicked;
         if(this.txtTitle != null)
         {
            this.text = this.txtTitle.text;
         }
         if(this.txtSubTitle != null)
         {
            this.subText = this.txtSubTitle.text;
         }
         if(this.txtTitle != null)
         {
            _loc1_ = this.txtTitle.getTextFormat().size;
            if(_loc1_ == null)
            {
               _loc1_ = 12;
            }
            this._origTextSize = Number(_loc1_);
         }
         if(this.txtSubTitle != null)
         {
            _loc2_ = this.txtSubTitle.getTextFormat().size;
            if(_loc2_ == null)
            {
               _loc2_ = 12;
            }
            this._origSubTextSize = Number(_loc2_);
         }
         if(this.mcLocked != null)
         {
            this.mcLocked.visible = false;
         }
      }
      
      public function set text(param1:String) : void
      {
         if(this.txtTitle == null)
         {
            return;
         }
         updateTextAndFormat(this.txtTitle,param1);
         this.updateTxtForMoblie();
      }
      
      public function set text_withHTMLColoringForMobile(param1:String) : void
      {
         if(this.txtTitle == null)
         {
            return;
         }
         var _loc2_:Boolean = true;
         updateTextAndFormat(this.txtTitle,param1,TextUtils.SIZE_KEEP_CURRENT,_loc2_);
         this.updateTxtForMoblie();
      }
      
      public function set subText(param1:String) : void
      {
         if(this.txtSubTitle == null)
         {
            return;
         }
         updateTextAndFormat(this.txtSubTitle,param1);
         this.updateTxtForMoblie();
      }
      
      public function setSubText(param1:String, param2:Boolean = false) : void
      {
         if(this.txtSubTitle == null)
         {
            return;
         }
         updateTextAndFormat(this.txtSubTitle,param1,TextUtils.SIZE_KEEP_CURRENT,param2);
         this.updateTxtForMoblie();
      }
      
      private function updateTxtForMoblie() : void
      {
         this.txtTitle.visible = true;
         if(this.txtPlaceHolder != null)
         {
            ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this.txtPlaceHolder);
         }
         else
         {
            ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
         }
         if(this.txtSubTitle != null)
         {
            this.txtSubTitle.visible = true;
            if(this.txtSubPlaceHolder != null)
            {
               ImageUtils.swapTextFieldWithBitMap(this.txtSubTitle,this.txtSubPlaceHolder);
            }
            else
            {
               ImageUtils.swapTextFieldWithBitMap(this.txtSubTitle,this);
            }
         }
         addEventListener(Event.ENTER_FRAME,this.onMobileEnterFrame);
      }
      
      protected function onMobileEnterFrame(param1:Event) : void
      {
         if(this.txtTitle != null)
         {
            this.txtTitle.visible = false;
         }
         if(this.txtSubTitle != null)
         {
            this.txtSubTitle.visible = false;
         }
      }
      
      private function onRemoved(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         removeEventListener(Event.ENTER_FRAME,this.onMobileEnterFrame);
      }
      
      public function set textScale(param1:Number) : *
      {
         var _loc2_:int = Math.round(this._origTextSize * param1);
         updateTextAndFormat(this.txtTitle,this.txtTitle.text,_loc2_);
      }
      
      protected function gotoVisualState(param1:String) : void
      {
         if(this.mcSkins != null)
         {
            this.mcSkins.gotoAndStop(param1);
         }
         else
         {
            gotoAndStop(param1);
         }
      }
      
      override protected function onDisableMe() : void
      {
         this.gotoVisualState("disabled");
      }
      
      override protected function onEnableMe() : void
      {
         this.gotoVisualState("up");
      }
      
      public function lock() : void
      {
         if(this.mcLocked == null)
         {
            return;
         }
         this.mcLocked.visible = true;
         this.text = "";
      }
      
      private function onUp(param1:Event) : void
      {
         if(isEnabled())
         {
            this.gotoVisualState("over");
         }
      }
      
      private function onOut(param1:MouseEvent) : void
      {
         if(isEnabled())
         {
            this.gotoVisualState("up");
         }
      }
      
      private function onOver(param1:MouseEvent) : void
      {
         if(isEnabled())
         {
            this.gotoVisualState("over");
            this._rolloverSoundFunction();
         }
      }
      
      private function onDown(param1:Event) : void
      {
         if(isEnabled())
         {
            this.gotoVisualState("hit");
            this._clickSoundFunction();
         }
      }
      
      public function set content(param1:DisplayObject) : void
      {
         if(this.contentPlaceHolder == null)
         {
            TsLogger.log("BMBasicButton set content not supported on button" + name);
            return;
         }
         if(this.contentSizer != null)
         {
            param1.width = this.contentSizer.width;
            param1.height = this.contentSizer.height;
            this.contentPlaceHolder.x = this.contentSizer.x;
            this.contentPlaceHolder.y = this.contentSizer.y;
         }
         this.contentPlaceHolder.removeChildren();
         this.contentPlaceHolder.addChild(param1);
      }
      
      public function get content() : DisplayObject
      {
         return this.contentPlaceHolder.getChildAt(0);
      }
   }
}

