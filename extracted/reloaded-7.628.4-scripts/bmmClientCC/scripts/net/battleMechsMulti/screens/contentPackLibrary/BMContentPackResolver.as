package net.battleMechsMulti.screens.contentPackLibrary
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   
   public class BMContentPackResolver
   {
      
      public static const PACK_DOES_NOT_EXIST:uint = 0;
      
      public static const REQ_TYPE_CLEAR_CHAPTER:uint = 1;
      
      public static const REQ_TYPE_REACH_LADDER_RANK:uint = 2;
      
      public static const REQ_TYPE_FINISH_TUTORIAL:uint = 3;
      
      public static const TYPE_TITLE_TORSO:int = -1;
      
      public static const TYPE_TITLE_LEG:int = -2;
      
      public static const TYPE_TITLE_SIDE_WEAPON:int = -3;
      
      public static const TYPE_TITLE_TOP_WEAPON:int = -4;
      
      public static const TYPE_TITLE_MODULE:int = -5;
      
      public static const TYPE_TITLE_SPECIAL:int = -6;
      
      public static const TYPE_TITLE_EMPTY:int = -999;
      
      public static const PACK_TYPE_SPECIAL:String = "special";
      
      public static const PACK_TYPE_NONE:String = "none";
      
      public static const NO_NEW_CONTENT_PACK_ID_UNLOCKED:int = -1;
      
      private var _itemsByContentPacks:Array;
      
      private var _requirementData:Array;
      
      private var _lastHighestLadderRank:uint = 0;
      
      private var _lastHighestCampaignChapterCompleted:uint = 0;
      
      private var _newUnlockedContentPackID:int = -1;
      
      public function BMContentPackResolver()
      {
         super();
      }
      
      public static function getPackTypeByItemType(param1:String) : String
      {
         switch(param1)
         {
            case BMMechStructure.TORSO:
            case BMMechStructure.LEG:
            case BMMechStructure.SIDE_WEAPON:
            case BMMechStructure.TOP_WEAPON:
            case BMMechStructure.MODULE:
            case BMMechStructure.KIT:
               return param1;
            case BMMechStructure.DRONE:
            case BMMechStructure.TELEPORT:
            case BMMechStructure.SHIELD:
            case BMMechStructure.CHARGE:
            case BMMechStructure.HARPOON:
               return BMMechStructure.SPECIAL;
            default:
               return PACK_TYPE_NONE;
         }
      }
      
      public function setRequirementData(param1:Array) : void
      {
         this._lastHighestLadderRank = 0;
         this._lastHighestCampaignChapterCompleted = 0;
         this._requirementData = param1;
         if(this._requirementData == null || this._requirementData.length == 0)
         {
            return;
         }
         this._requirementData.insertAt(0,{
            "requirementType":REQ_TYPE_FINISH_TUTORIAL,
            "requirementThreshold":1
         });
      }
      
      public function setLastStatusData(param1:Boolean = false) : void
      {
         if(this.contentPacksEnabled() == false)
         {
            return;
         }
         if(this._lastHighestLadderRank > 0 && param1 == false)
         {
            return;
         }
         var _loc2_:BMDataManager = BMDataManager.getInstance();
         this._lastHighestLadderRank = _loc2_.getLadderRankByProgress(_loc2_.myProfile.ladderProgress);
         var _loc3_:uint = uint(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1);
         this._lastHighestCampaignChapterCompleted = _loc2_.singlePlayerM.getHighestChapterCompleted(_loc3_,0);
      }
      
      public function setItemsByContentPacks() : void
      {
         var _loc1_:uint = 0;
         var _loc3_:BMItemData = null;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         this._itemsByContentPacks = new Array();
         _loc1_ = 0;
         while(_loc1_ < this.getMaxPacks())
         {
            this._itemsByContentPacks[_loc1_] = new Array();
            _loc1_++;
         }
         var _loc2_:BMDataManager = BMDataManager.getInstance();
         for each(_loc3_ in _loc2_.itemsDB)
         {
            if(_loc3_.isDeprecated == 0)
            {
               if(_loc3_.displayLevel == 1)
               {
                  _loc4_ = getPackTypeByItemType(_loc3_.type);
                  if(!(_loc4_ == PACK_TYPE_NONE || _loc3_.isPowerKit))
                  {
                     _loc5_ = uint(this.getPackTypeSortValue(_loc4_));
                     if(this._itemsByContentPacks[_loc3_.contentPackID][_loc5_] == null)
                     {
                        this._itemsByContentPacks[_loc3_.contentPackID][_loc5_] = new Array();
                     }
                     if(this._itemsByContentPacks[_loc3_.contentPackID][_loc5_][_loc3_.chainID] == null)
                     {
                        this._itemsByContentPacks[_loc3_.contentPackID][_loc5_][_loc3_.chainID] = new Array();
                     }
                     this._itemsByContentPacks[_loc3_.contentPackID][_loc5_][_loc3_.chainID][_loc3_.specialStatus] = _loc3_.itemID;
                  }
               }
            }
         }
         _loc1_ = 0;
         while(_loc1_ < this.getMaxPacks())
         {
            _loc6_ = this._itemsByContentPacks[_loc1_].length - 1;
            while(_loc6_ >= 0)
            {
               if(this._itemsByContentPacks[_loc1_][_loc6_] == null)
               {
                  this._itemsByContentPacks[_loc1_].splice(_loc6_,1);
               }
               else
               {
                  _loc7_ = this._itemsByContentPacks[_loc1_][_loc6_].length - 1;
                  while(_loc7_ >= 0)
                  {
                     if(this._itemsByContentPacks[_loc1_][_loc6_][_loc7_] == null)
                     {
                        this._itemsByContentPacks[_loc1_][_loc6_].splice(_loc7_,1);
                     }
                     else
                     {
                        _loc8_ = this._itemsByContentPacks[_loc1_][_loc6_][_loc7_].length - 1;
                        while(_loc8_ >= 0)
                        {
                           if(this._itemsByContentPacks[_loc1_][_loc6_][_loc7_][_loc8_] == null)
                           {
                              this._itemsByContentPacks[_loc1_][_loc6_][_loc7_].splice(_loc8_,1);
                           }
                           _loc8_--;
                        }
                     }
                     _loc7_--;
                  }
               }
               _loc6_--;
            }
            _loc1_++;
         }
      }
      
      public function getPackTypeSortValue(param1:String) : int
      {
         switch(param1)
         {
            case BMMechStructure.TORSO:
               return 1;
            case BMMechStructure.LEG:
               return 2;
            case BMMechStructure.SIDE_WEAPON:
               return 3;
            case BMMechStructure.TOP_WEAPON:
               return 4;
            case BMMechStructure.MODULE:
               return 6;
            case PACK_TYPE_SPECIAL:
               return 5;
            default:
               return 999;
         }
      }
      
      public function getPackTypeTitleID(param1:String) : int
      {
         switch(param1)
         {
            case BMMechStructure.TORSO:
               return TYPE_TITLE_TORSO;
            case BMMechStructure.LEG:
               return TYPE_TITLE_LEG;
            case BMMechStructure.SIDE_WEAPON:
               return TYPE_TITLE_SIDE_WEAPON;
            case BMMechStructure.TOP_WEAPON:
               return TYPE_TITLE_TOP_WEAPON;
            case BMMechStructure.MODULE:
               return TYPE_TITLE_MODULE;
            case BMMechStructure.DRONE:
            case BMMechStructure.TELEPORT:
            case BMMechStructure.SHIELD:
            case BMMechStructure.CHARGE:
            case BMMechStructure.HARPOON:
               return TYPE_TITLE_SPECIAL;
            default:
               return TYPE_TITLE_EMPTY;
         }
      }
      
      public function getItemsByContentPacks() : Array
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:BMItemData = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         if(this._itemsByContentPacks == null)
         {
            this.setItemsByContentPacks();
         }
         var _loc1_:Array = new Array();
         var _loc2_:uint = 0;
         while(_loc2_ < this.getMaxPacks())
         {
            _loc1_[_loc2_] = new Array();
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < this._itemsByContentPacks[_loc2_].length)
            {
               _loc5_ = uint(this._itemsByContentPacks[_loc2_][_loc4_][0][0]);
               _loc6_ = BMDataManager.getInstance().itemsDB[_loc5_];
               _loc7_ = this.getPackTypeTitleID(_loc6_.type);
               _loc1_[_loc2_][_loc3_] = new Array();
               _loc1_[_loc2_][_loc3_].push(_loc7_);
               _loc3_++;
               _loc8_ = 0;
               while(_loc8_ < this._itemsByContentPacks[_loc2_][_loc4_].length)
               {
                  _loc1_[_loc2_][_loc3_] = new Array();
                  _loc9_ = 0;
                  while(_loc9_ < this._itemsByContentPacks[_loc2_][_loc4_][_loc8_].length)
                  {
                     _loc1_[_loc2_][_loc3_].push(this._itemsByContentPacks[_loc2_][_loc4_][_loc8_][_loc9_]);
                     _loc9_++;
                  }
                  _loc3_++;
                  _loc8_++;
               }
               _loc4_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getPackTitleText(param1:*) : String
      {
         var _loc2_:String = BMLanguageManager.getInstance().getText("contentPackLibrary_armoryLevel");
         return BMDataManager.getInstance().replaceStringInText(_loc2_,"%LEVEL%",String(param1 + 1));
      }
      
      public function getItemTypeTitleText(param1:int) : String
      {
         switch(param1)
         {
            case TYPE_TITLE_TORSO:
               return BMLanguageManager.getInstance().getText("hanger_torso");
            case TYPE_TITLE_LEG:
               return BMLanguageManager.getInstance().getText("hanger_leg");
            case TYPE_TITLE_SIDE_WEAPON:
               return BMLanguageManager.getInstance().getText("hanger_sideWeapon");
            case TYPE_TITLE_TOP_WEAPON:
               return BMLanguageManager.getInstance().getText("hanger_topWeapon");
            case TYPE_TITLE_MODULE:
               return BMLanguageManager.getInstance().getText("hanger_module");
            case TYPE_TITLE_SPECIAL:
               return BMLanguageManager.getInstance().getText("hanger_special");
            default:
               return "";
         }
      }
      
      public function didUnlockNewContentPackID() : Boolean
      {
         if(this.contentPacksEnabled() == false)
         {
            return false;
         }
         if(this.getMyHighestContentPackID(true) == this._requirementData.length - 1)
         {
            return false;
         }
         if(this._lastHighestLadderRank == 0)
         {
            this.setLastStatusData(true);
            return false;
         }
         var _loc1_:uint = this.getMyHighestContentPackID(true);
         var _loc2_:uint = this.getMyHighestContentPackID();
         this.setLastStatusData(true);
         if(_loc2_ > _loc1_)
         {
            this._newUnlockedContentPackID = _loc2_;
            return true;
         }
         return false;
      }
      
      public function getNewUnlockedContentPackIDAndReset() : int
      {
         var _loc1_:int = this._newUnlockedContentPackID;
         if(_loc1_ > BMDataManager.getInstance().myProfile.contentPackID)
         {
            BMDataManager.getInstance().myProfile.contentPackID = _loc1_;
         }
         this._newUnlockedContentPackID = NO_NEW_CONTENT_PACK_ID_UNLOCKED;
         return _loc1_;
      }
      
      public function getMyHighestContentPackID(param1:Boolean = false) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < this._requirementData.length)
         {
            if(!this.isPackUnlocked(_loc3_,param1))
            {
               break;
            }
            _loc2_ = _loc3_;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getLockedMessage(param1:uint) : String
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc2_:uint = this.getPackRequirementType(param1);
         var _loc3_:uint = this.getPackRequirementThreshold(param1);
         var _loc4_:String = "";
         switch(_loc2_)
         {
            case REQ_TYPE_CLEAR_CHAPTER:
               _loc5_ = BMLanguageManager.getInstance().getText("contentPackLibrary_clearChapterToUnlock");
               _loc4_ = _loc5_ = BMDataManager.getInstance().replaceStringInText(_loc5_,"%CHAPTER%",String(_loc3_));
               break;
            case REQ_TYPE_REACH_LADDER_RANK:
               _loc6_ = BMLanguageManager.getInstance().getText("contentPackLibrary_reachArenaRankToUnlock");
               _loc4_ = _loc6_ = BMDataManager.getInstance().replaceStringInText(_loc6_,"%RANK%",String(_loc3_));
         }
         return _loc4_;
      }
      
      public function contentPacksEnabled() : Boolean
      {
         if(BMTutorialManager.gi().isTutorialActive() || this._requirementData == null || this._requirementData.length == 0)
         {
            return false;
         }
         return true;
      }
      
      public function getMaxPacks() : uint
      {
         if(this.contentPacksEnabled() == false)
         {
            return 0;
         }
         return this._requirementData.length;
      }
      
      public function getPackRequirementType(param1:uint) : uint
      {
         if(this._requirementData[param1] == null)
         {
            return PACK_DOES_NOT_EXIST;
         }
         return this._requirementData[param1]["requirementType"];
      }
      
      public function getPackRequirementThreshold(param1:uint) : uint
      {
         if(this._requirementData[param1] == null)
         {
            return PACK_DOES_NOT_EXIST;
         }
         return this._requirementData[param1]["requirementThreshold"];
      }
      
      public function isPackUnlocked(param1:uint, param2:Boolean = false) : Boolean
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         if(this._requirementData[param1] == null)
         {
            return false;
         }
         var _loc3_:BMDataManager = BMDataManager.getInstance();
         if(_loc3_.myProfile.contentPackID >= param1)
         {
            return true;
         }
         var _loc4_:uint = 0;
         while(_loc4_ <= param1)
         {
            _loc5_ = this.getPackRequirementType(_loc4_);
            _loc6_ = this.getPackRequirementThreshold(_loc4_);
            switch(_loc5_)
            {
               case REQ_TYPE_FINISH_TUTORIAL:
                  if(BMTutorialManager.gi().isTutorialActive())
                  {
                     return false;
                  }
                  break;
               case REQ_TYPE_CLEAR_CHAPTER:
                  if(param2)
                  {
                     if(this._lastHighestCampaignChapterCompleted < _loc6_)
                     {
                        return false;
                     }
                  }
                  else
                  {
                     _loc7_ = uint(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1);
                     if(_loc3_.singlePlayerM.didCompleteChapter(_loc7_,_loc6_,0) == false)
                     {
                        return false;
                     }
                  }
                  break;
               case REQ_TYPE_REACH_LADDER_RANK:
                  if(param2)
                  {
                     if(this._lastHighestLadderRank > _loc6_)
                     {
                        return false;
                     }
                  }
                  else if(_loc3_.getLadderRankByProgress(_loc3_.myProfile.ladderProgress) > _loc6_)
                  {
                     return false;
                  }
            }
            _loc4_++;
         }
         return true;
      }
   }
}

