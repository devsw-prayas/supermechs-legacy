package net.battleMechsMulti.mobiles.buttons
{
   import flash.display.MovieClip;
   
   public class BMBasicSelectable extends BMBasicButton
   {
      
      public var mcSelected:MovieClip;
      
      public var id:String;
      
      public function BMBasicSelectable()
      {
         super();
         this.selected = false;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this.mcSelected.visible = param1;
      }
      
      public function get selected() : Boolean
      {
         return this.mcSelected.visible;
      }
   }
}

