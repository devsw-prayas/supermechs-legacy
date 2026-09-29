package net.battleMechsMulti.screens.shop
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1167")]
   public class IconAndText extends BMMovieClip
   {
      
      public var textField:TextField;
      
      public var mcIcon:MovieClip;
      
      private var _orgX:Number;
      
      private var _orgWidth:Number;
      
      public var mcGrayLine:Sprite;
      
      private var _textBM:Bitmap;
      
      private var _textBMD:BitmapData;
      
      public function IconAndText()
      {
         super();
         this._orgX = x;
         this._orgWidth = width;
         if(this.mcGrayLine != null)
         {
            this.mcGrayLine.visible = false;
         }
      }
      
      public function setX(param1:Number) : void
      {
         this._orgX = x = param1;
      }
      
      public function set text(param1:String) : *
      {
         if(this._textBM != null)
         {
            this._textBM.parent.removeChild(this._textBM);
            this._textBM == null;
         }
         x = this._orgX;
         updateTextAndFormat(this.textField,param1);
         var _loc2_:Number = this.textField.x + this.textField.textWidth + 5;
         x = this._orgX + this._orgWidth / 2 - _loc2_ / 2;
         if(this.mcGrayLine != null)
         {
            this.mcGrayLine.width = this.textField.textWidth + 8;
         }
         if(this.textField.width > this.textField.textWidth + 10)
         {
            this.textField.width = this.textField.textWidth + 10;
         }
         this.convertTextToBitMap();
         if(this.mcGrayLine != null)
         {
            if(this.mcGrayLine.parent != null)
            {
               this.mcGrayLine.parent.removeChild(this.mcGrayLine);
            }
            addChild(this.mcGrayLine);
         }
      }
      
      public function activateGrayText() : void
      {
         this.textField.textColor = 13421772;
         if(this.mcGrayLine != null)
         {
            this.mcGrayLine.visible = true;
         }
      }
      
      private function convertTextToBitMap() : *
      {
         var _loc1_:Sprite = null;
         _loc1_ = new Sprite();
         _loc1_.x = this.textField.x;
         _loc1_.y = this.textField.y;
         this.textField.x = 0;
         this.textField.y = 0;
         _loc1_.addChild(this.textField);
         this._textBMD = new BitmapData(_loc1_.width,_loc1_.height,true,0);
         this._textBM = new Bitmap(this._textBMD);
         this._textBMD.draw(_loc1_);
         this._textBM.smoothing = true;
         this._textBM.x = _loc1_.x;
         this._textBM.y = _loc1_.y;
         addChild(this._textBM);
         this.textField.x = _loc1_.x;
         this.textField.y = _loc1_.y;
         if(this.textField.parent != null)
         {
            this.textField.parent.removeChild(this.textField);
         }
         _loc1_ = null;
      }
   }
}

