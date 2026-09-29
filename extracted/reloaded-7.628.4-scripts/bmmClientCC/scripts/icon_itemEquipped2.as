package
{
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol38")]
   public dynamic class icon_itemEquipped2 extends TextHolder
   {
      
      public function icon_itemEquipped2()
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

