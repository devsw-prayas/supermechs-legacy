package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1150")]
   public dynamic class BMContentPackLibraryButton2 extends BMBasicButton
   {
      
      public function BMContentPackLibraryButton2()
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

