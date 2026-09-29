package net.battleMechsMulti.managers.basebuilding
{
   import flash.utils.Dictionary;
   
   public class BMBaseBuildingState
   {
      
      private var state:Dictionary;
      
      private var positionsWithStructures:Array;
      
      public function BMBaseBuildingState()
      {
         super();
         this.state = new Dictionary();
         this.positionsWithStructures = new Array();
      }
      
      public function updateFromData(param1:Object) : *
      {
         var _loc2_:String = null;
         this.state = new Dictionary();
         this.positionsWithStructures = new Array();
         for(_loc2_ in param1)
         {
            this.state[uint(_loc2_)] = new BMBaseBuildingStructureState(param1[_loc2_]);
            this.positionsWithStructures.push(uint(_loc2_));
         }
      }
      
      public function getPositionsWithStructures() : Array
      {
         return this.positionsWithStructures;
      }
      
      public function getStructureState(param1:uint) : BMBaseBuildingStructureState
      {
         return this.state[param1];
      }
   }
}

