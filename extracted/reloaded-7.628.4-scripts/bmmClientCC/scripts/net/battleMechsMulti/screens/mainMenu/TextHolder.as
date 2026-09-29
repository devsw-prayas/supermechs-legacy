package net.battleMechsMulti.screens.mainMenu
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   
   public class TextHolder extends BMMovieClip
   {
      
      public var textField:TextField;
      
      public var mcIcon:Sprite;
      
      public function TextHolder()
      {
         super();
         ImageUtils.swapTextFieldWithBitMap(this.textField,this);
      }
      
      public function set text(param1:String) : void
      {
         if(this.textField.parent == null)
         {
            addChild(this.textField);
         }
         var _loc2_:Number = rotation;
         if(rotation != 0)
         {
            rotation = 0;
         }
         updateTextAndFormat(this.textField,param1);
         if(true || _loc2_ != 0)
         {
            ImageUtils.swapTextFieldWithBitMap(this.textField,this);
         }
         if(_loc2_ != 0)
         {
            rotation = _loc2_;
         }
      }
      
      public function get text() : String
      {
         return this.textField.text;
      }
   }
}

