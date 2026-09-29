package net.battleMechsMulti.mobiles
{
   import flash.display.MovieClip;
   
   public class BMMapObject
   {
      
      public var mcGrp:MovieClip;
      
      public var row:uint;
      
      public var column:uint;
      
      public var code:String;
      
      public var grp:String;
      
      public function BMMapObject()
      {
         super();
      }
      
      public function initialize(param1:uint, param2:uint, param3:MovieClip, param4:String, param5:String) : void
      {
         this.row = param1;
         this.column = param2;
         this.mcGrp = param3;
         this.grp = param5;
         this.code = param4;
      }
      
      public function removeMe() : void
      {
         if(this.mcGrp.parent != null)
         {
            this.mcGrp.parent.removeChild(this.mcGrp);
            this.mcGrp = null;
         }
      }
   }
}

