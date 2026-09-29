package net.battleMechsMulti.screens.inventory
{
   import flash.display.MovieClip;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   
   public class BMInventoryTileListItem extends BMTileListItem
   {
      
      public var mcBg:MovieClip;
      
      public function BMInventoryTileListItem()
      {
         super();
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         if(param1)
         {
            this.mcBg.gotoAndStop(2);
         }
         else
         {
            this.mcBg.gotoAndStop(1);
         }
      }
   }
}

