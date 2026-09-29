package net.battleMechsMulti.managers.navigatePlayerToRecommendedMission
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   
   public class BMNavigatePlayerToRecommendedMissionResolver
   {
      
      public function BMNavigatePlayerToRecommendedMissionResolver()
      {
         super();
      }
      
      public static function get targetMissionSlot() : int
      {
         if(isEnabled == false)
         {
            return -1;
         }
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         return uint(dataM.singlePlayerM.getHighestPlayableMissionSlot(_loc1_,_loc2_));
      }
      
      public static function get targetMissionMode() : uint
      {
         return 0;
      }
      
      public static function get targetMissionStoryID() : uint
      {
         return 0;
      }
      
      public static function get isEnabled() : Boolean
      {
         if(tutorialM.isTutorialActive())
         {
            return false;
         }
         var _loc1_:String = dataM.getGeneralSetting("navigatePlayerToPvERecommendedMissionData",null);
         if(_loc1_ == null)
         {
            return false;
         }
         var _loc2_:Object = JSON.parse(_loc1_);
         if(_loc2_.activateUpToMissionSlot == null)
         {
            throw Error("BMNavigatePlayerToRecommendedMissionResolver setting isn\'t built properly");
         }
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = uint(dataM.singlePlayerM.getHighestMissionCompletedSlot(_loc3_,_loc4_));
         if(_loc5_ >= _loc2_.activateUpToMissionSlot)
         {
            return false;
         }
         return true;
      }
      
      private static function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
      
      private static function get tutorialM() : BMTutorialManager
      {
         return BMTutorialManager.gi();
      }
   }
}

