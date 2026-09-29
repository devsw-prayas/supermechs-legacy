package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicSelectable;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol138")]
   public dynamic class MBWorkshopSlot extends BMBasicSelectable
   {
      
      public function MBWorkshopSlot()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

