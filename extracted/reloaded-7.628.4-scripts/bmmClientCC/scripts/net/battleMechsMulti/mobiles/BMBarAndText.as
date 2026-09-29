package net.battleMechsMulti.mobiles
{
   import flash.text.TextField;
   
   public class BMBarAndText extends BMMovieClip
   {
      
      public var txtValue:TextField;
      
      public var mcBar:BMBar;
      
      public function BMBarAndText()
      {
         super();
      }
      
      public function initialize(param1:Number, param2:Number, param3:Boolean = true) : void
      {
         this.mcBar.initialize(BMBar.COLOR_BLUE);
         var _loc4_:Number = param1 / param2;
         this.mcBar.setFill(_loc4_);
         var _loc5_:String = Math.ceil(_loc4_ * 100).toString();
         if(param3)
         {
            _loc5_ += "%";
         }
         updateTextAndFormat(this.txtValue,_loc5_);
      }
   }
}

