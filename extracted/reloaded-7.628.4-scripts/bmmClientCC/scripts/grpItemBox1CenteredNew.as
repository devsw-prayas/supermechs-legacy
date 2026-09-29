package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1024")]
   public dynamic class grpItemBox1CenteredNew extends MovieClip
   {
      
      public function grpItemBox1CenteredNew()
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

