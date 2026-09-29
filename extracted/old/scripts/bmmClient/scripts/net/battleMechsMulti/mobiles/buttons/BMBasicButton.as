package net.battleMechsMulti.mobiles.buttons
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMBasicButton extends BMIntractable
   {
      
      public var txtTitle:TextField;
      
      private var _clickSoundFunction:Function;
      
      private var _rolloverSoundFunction:Function;
      
      private var _origTextSize:Number;
      
      public function BMBasicButton()
      {
         super();
         mouseEnabled = true;
         mouseChildren = false;
         addEventListener(BMIntractable.DOWN,this.onDown);
         addEventListener(MouseEvent.ROLL_OUT,this.onOut);
         addEventListener(MouseEvent.ROLL_OUT,this.onOut);
         this._rolloverSoundFunction = BMScreensManager.getInstance().sound_buttonRollover;
         this._clickSoundFunction = BMScreensManager.getInstance().sound_buttonClicked;
         addEventListener(MouseEvent.ROLL_OVER,this.onOver);
         addEventListener(BMIntractable.UP,this.onUp);
         var _loc1_:Object = this.txtTitle.getTextFormat().size;
         if(_loc1_ == null)
         {
            _loc1_ = 12;
         }
         this._origTextSize = Number(_loc1_);
      }
      
      public function set text(param1:String) : void
      {
         this.txtTitle.text = param1;
         var _loc2_:TextFormat = this.txtTitle.getTextFormat();
      }
      
      public function set textScale(param1:Number) : *
      {
         var _loc2_:TextFormat = this.txtTitle.getTextFormat();
         var _loc3_:int = Math.round(this._origTextSize * param1);
         TextUtils.updateTextFormat(this.txtTitle,_loc3_);
      }
      
      override protected function onDisableMe() : void
      {
         gotoAndStop("disabled");
      }
      
      override protected function onEnableMe() : void
      {
         gotoAndStop("up");
      }
      
      private function onUp(param1:Event) : void
      {
         if(isEnabled())
         {
            gotoAndStop("over");
         }
      }
      
      private function onOut(param1:MouseEvent) : void
      {
         if(isEnabled())
         {
            gotoAndStop("up");
         }
      }
      
      private function onOver(param1:MouseEvent) : void
      {
         if(isEnabled())
         {
            gotoAndStop("over");
            this._rolloverSoundFunction();
         }
      }
      
      private function onDown(param1:Event) : void
      {
         if(isEnabled())
         {
            gotoAndStop("hit");
            this._clickSoundFunction();
         }
      }
   }
}

