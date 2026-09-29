package net.battleMechsMulti.screens.mainMenu
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TextHolder extends MovieClip
   {
      
      public var textField:TextField;
      
      public function TextHolder()
      {
         super();
         ImageUtils.swapTextFieldWithBitMap(this.textField,this);
      }
      
      public function set text(param1:String) : void
      {
         this.textField.text = param1;
         ImageUtils.swapTextFieldWithBitMap(this.textField,this);
      }
      
      public function get text() : String
      {
         return this.textField.text;
      }
   }
}

