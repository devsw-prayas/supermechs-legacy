package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2063")]
   public class BMScreenReconnecting extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var txtReconnecting:TextField;
      
      public function BMScreenReconnecting()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen() : void
      {
         updateTextAndFormat(this.txtReconnecting,getGeneralText("reconnectingCaps"));
      }
   }
}

