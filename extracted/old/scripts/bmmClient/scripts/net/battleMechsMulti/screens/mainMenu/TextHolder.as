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
      }
      
      public function set text(param1:String) : void
      {
         this.textField.text = param1;
      }
   }
}

