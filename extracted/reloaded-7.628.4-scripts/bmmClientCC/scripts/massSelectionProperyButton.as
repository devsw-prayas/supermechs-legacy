package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicSelectable;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2816")]
   public dynamic class massSelectionProperyButton extends BMBasicSelectable
   {
      
      public function massSelectionProperyButton()
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

