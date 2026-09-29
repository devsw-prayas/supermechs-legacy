package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol377")]
   public dynamic class tokensMinerButton extends BMBasicButton
   {
      
      public function tokensMinerButton()
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

