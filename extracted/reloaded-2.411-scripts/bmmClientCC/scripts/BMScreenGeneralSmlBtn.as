package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1550")]
   public dynamic class BMScreenGeneralSmlBtn extends BMBasicButton
   {
      
      public function BMScreenGeneralSmlBtn()
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

