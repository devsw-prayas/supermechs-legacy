package net.battleMechsMulti.mobiles.buttons
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class BMLanguageButton extends BMBasicButton
   {
      
      public var mcFlagHolder:Sprite;
      
      public var mcFlagSizer:Sprite;
      
      private var mcFlag:Sprite;
      
      private var _languageID:uint;
      
      public function BMLanguageButton()
      {
         super();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function addFlagImage(param1:Sprite) : void
      {
         this.removeFlagIcon();
         this.mcFlag = param1;
         this.mcFlag.width = this.mcFlagSizer.width;
         this.mcFlag.height = this.mcFlagSizer.height;
         this.mcFlagHolder.addChild(this.mcFlag);
      }
      
      private function removeFlagIcon() : void
      {
         if(this.mcFlag != null)
         {
            if(this.mcFlag.parent != null)
            {
               this.mcFlag.parent.removeChild(this.mcFlag);
            }
            this.mcFlag = null;
         }
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.removeFlagIcon();
      }
      
      public function get languageID() : uint
      {
         return this._languageID;
      }
      
      public function set languageID(param1:uint) : void
      {
         this._languageID = param1;
      }
   }
}

