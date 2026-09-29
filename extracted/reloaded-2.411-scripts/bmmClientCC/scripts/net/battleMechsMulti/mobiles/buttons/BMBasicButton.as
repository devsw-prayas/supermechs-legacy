package net.battleMechsMulti.mobiles.buttons
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMBasicButton extends BMIntractable
   {
      
      public var txtTitle:TextField;
      
      public var txtPlaceHolder:MovieClip;
      
      public var contentPlaceHolder:MovieClip;
      
      public var contentSizer:MovieClip;
      
      private var _clickSoundFunction:Function;
      
      private var _rolloverSoundFunction:Function;
      
      private var _origTextSize:Number;
      
      public function BMBasicButton()
      {
         var _loc1_:Object = null;
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
         if(this.txtTitle != null)
         {
            _loc1_ = this.txtTitle.getTextFormat().size;
            if(_loc1_ == null)
            {
               _loc1_ = 12;
            }
            this._origTextSize = Number(_loc1_);
         }
      }
      
      public function set text(param1:String) : void
      {
         this.txtTitle.text = param1;
         this.txtTitle.visible = true;
         if(this.txtPlaceHolder != null)
         {
            ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this.txtPlaceHolder);
         }
         else
         {
            ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
         }
         addEventListener(Event.ENTER_FRAME,this.onMobileEnterFrame);
      }
      
      protected function onMobileEnterFrame(param1:Event) : void
      {
         this.txtTitle.visible = false;
      }
      
      private function onRemoved(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         removeEventListener(Event.ENTER_FRAME,this.onMobileEnterFrame);
      }
      
      public function set textScale(param1:Number) : *
      {
         var _loc2_:TextFormat = this.txtTitle.getTextFormat();
         var _loc3_:int = Math.round(this._origTextSize * param1);
         TextUtils.updateTextFormat(this.txtTitle,_loc3_);
      }
      
      protected function gotoVisualState(param1:String) : void
      {
         gotoAndStop(param1);
      }
      
      override protected function onDisableMe() : void
      {
         this.gotoVisualState("disabled");
      }
      
      override protected function onEnableMe() : void
      {
         this.gotoVisualState("up");
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

