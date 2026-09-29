package net.battleMechsMulti.mobiles.worldMap
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1102")]
   public class BMWorldMapChapterTitle extends MovieClip
   {
      
      public var txtTitle:TextField;
      
      public function BMWorldMapChapterTitle()
      {
         super();
      }
      
      public function setTitleText(param1:String, param2:Function) : void
      {
         param2(this.txtTitle,param1);
      }
   }
}

