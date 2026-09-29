package net.battleMechsMulti.mobiles
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol327")]
   public class BMChatBubble extends BMBaseClass
   {
      
      public var mcBackground:Sprite;
      
      public var txtMessage:TextField;
      
      public var mcArrow:Sprite;
      
      private var _closingMessage:Boolean = false;
      
      private var _autoCloseCountdown:Number = 0;
      
      private const MAX_ROWS:Number = 5;
      
      public function BMChatBubble()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         TextUtils.updateTextFormat(this.txtMessage,14);
         this.txtMessage.text = "";
      }
      
      public function onEnterFrameTrigger(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = param1 - this.mcBackground.width / 2;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         else if(_loc3_ + this.mcBackground.width > dataM.STAGE_WIDTH)
         {
            _loc3_ = dataM.STAGE_WIDTH - this.mcBackground.width;
         }
         x = _loc3_;
         this.mcArrow.x = this.mcBackground.x + this.mcBackground.width / 2;
         var _loc4_:Number = param2 - this.mcBackground.height;
         y = _loc4_;
         if(this._closingMessage)
         {
            if(this.mcBackground.height > 15)
            {
               this.mcBackground.height -= 10;
               this.updateArrowYPos();
            }
            else
            {
               visible = false;
               this._closingMessage = false;
            }
         }
         if(this._autoCloseCountdown > 0)
         {
            --this._autoCloseCountdown;
            if(this._autoCloseCountdown == 0)
            {
               this.closeMessage(false);
            }
         }
      }
      
      public function showNewMessage(param1:String) : void
      {
         this._closingMessage = false;
         this.txtMessage.htmlText = param1;
         var _loc2_:Number = this.txtMessage.numLines;
         if(_loc2_ > this.MAX_ROWS)
         {
            _loc2_ = this.MAX_ROWS;
         }
         this.mcBackground.width = 20 + this.txtMessage.textWidth;
         this.mcBackground.height = 8 + _loc2_ * 19;
         this.updateArrowYPos();
         this._autoCloseCountdown = 120 + 60 * (_loc2_ - 1);
         visible = true;
      }
      
      private function updateArrowYPos() : void
      {
         this.mcArrow.y = this.mcBackground.height - 5;
      }
      
      public function closeMessage(param1:Boolean) : void
      {
         this.txtMessage.text = "";
         if(param1)
         {
            visible = false;
         }
         else
         {
            this._closingMessage = true;
            this._autoCloseCountdown = 0;
         }
      }
      
      public function messageActive() : Boolean
      {
         var _loc1_:Boolean = false;
         if(this.txtMessage.text != "" || this._closingMessage)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
   }
}

