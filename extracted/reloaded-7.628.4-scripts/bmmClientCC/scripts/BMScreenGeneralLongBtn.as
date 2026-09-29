package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol249")]
   public dynamic class BMScreenGeneralLongBtn extends BMBasicButton
   {
      
      public function BMScreenGeneralLongBtn()
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

