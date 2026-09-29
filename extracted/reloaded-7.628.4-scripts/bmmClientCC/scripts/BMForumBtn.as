package
{
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3040")]
   public dynamic class BMForumBtn extends BMBasicButton
   {
      
      public function BMForumBtn()
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

