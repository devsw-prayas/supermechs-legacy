package net.battleMechsMulti.managers.nukes
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   
   public class BMNukesResolver
   {
      
      private static var _instance:BMNukesResolver;
      
      private var _dataParsed:Boolean = false;
      
      private var _dataAvailable:Boolean = false;
      
      private var _maxNukes:uint;
      
      private var _enabledTime:int;
      
      private var _minXPLevel:uint;
      
      private var _nukesMaxedPopupDisplayedThisSession:Boolean = false;
      
      public function BMNukesResolver()
      {
         super();
      }
      
      public static function gi() : BMNukesResolver
      {
         if(_instance == null)
         {
            _instance = new BMNukesResolver();
         }
         return _instance;
      }
      
      private function parseData() : void
      {
         this._dataParsed = true;
         var _loc1_:String = this.dataM.getGeneralSetting("nukesData",null);
         if(_loc1_ == null)
         {
            this._dataAvailable = false;
            return;
         }
         this._dataAvailable = true;
         var _loc2_:Object = JSON.parse(_loc1_);
         this._maxNukes = _loc2_["maxNukes"];
         this._enabledTime = _loc2_["enabledTime"];
         this._minXPLevel = _loc2_["minXPLevel"];
      }
      
      private function get dataAvailable() : Boolean
      {
         if(this._dataParsed == false)
         {
            this.parseData();
         }
         return this._dataAvailable;
      }
      
      public function get isEnabled() : Boolean
      {
         if(this.dataAvailable == false)
         {
            return false;
         }
         if(this.dataM.currentTime < this._enabledTime)
         {
            return false;
         }
         if(this.dataM.myProfile.level < this._minXPLevel)
         {
            return false;
         }
         return true;
      }
      
      public function canActivateNukeInMission(param1:uint, param2:uint, param3:uint) : Boolean
      {
         if(this.isEnabled == false)
         {
            return false;
         }
         var _loc4_:BMWorldMapLocationData = this.dataM.singlePlayerM.getSpecificMissionDB(param1,param2);
         if(_loc4_.subType == BMWorldMapLocationData.SUB_TYPE_MISSION_DUNGEON)
         {
            return false;
         }
         return this.dataM.singlePlayerM.didCompleteSlot(param1,param2,param3);
      }
      
      public function get maxNukes() : uint
      {
         if(this.dataAvailable == false)
         {
            throw Error("BMNukesResolver Data not set");
         }
         return this._maxNukes;
      }
      
      private function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
      
      private function get screensM() : BMScreensManager
      {
         return BMScreensManager.getInstance();
      }
      
      public function displayNukesMaxedPopup() : void
      {
         if(this.isEnabled == false)
         {
            return;
         }
         if(this._nukesMaxedPopupDisplayedThisSession)
         {
            return;
         }
         if(this.dataM.myProfile.nukes < this.maxNukes)
         {
            return;
         }
         this._nukesMaxedPopupDisplayedThisSession = true;
         var _loc1_:String = BMLanguageManager.getInstance().getText("nukes_maxedTitle");
         var _loc2_:String = BMLanguageManager.getInstance().getText("nukes_maxedDesc");
         var _loc3_:String = BMLanguageManager.getInstance().getText("general_OK");
         _loc2_ = this.dataM.replaceStringInText(_loc2_,"%NUKES%",String(this.maxNukes));
         this.screensM.addScreen(BMScreensManager.SCR_YES_NO_POPUP,true,BMScreenYesNoPopup9_nukesMaxed);
         this.screensM.screenYesNoPopup.displayYesNoPopup(_loc1_,_loc2_,"",null,null,_loc3_);
      }
      
      public function get nukesMaxedPopupDisplayedThisSession() : Boolean
      {
         return this._nukesMaxedPopupDisplayedThisSession;
      }
   }
}

