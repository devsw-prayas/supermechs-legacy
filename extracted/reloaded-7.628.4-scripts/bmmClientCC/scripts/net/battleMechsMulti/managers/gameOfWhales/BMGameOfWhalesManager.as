package net.battleMechsMulti.managers.gameOfWhales
{
   import com.gameOfWhales.GameOfWhalesEvent;
   import com.gameOfWhales.GameOfWhalesManager;
   import com.gameOfWhales.GameOfWhalesOffer;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.managers.BMRemoteManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.quests.BMQuestsManager;
   import net.battleMechsMulti.managers.shop.BMGoldPackageData;
   import net.battleMechsMulti.screens.shop.BMClanShopData;
   
   public class BMGameOfWhalesManager
   {
      
      public static const PLACE_SHOP:String = "shop";
      
      public static const PLACE_CLAN_SHOP:String = "clanShop";
      
      public static const PLACE_CAMPAIGN:String = "campaign";
      
      public static const PLACE_RAID:String = "raid";
      
      public static const PLACE_LADDER:String = "ladder";
      
      public static const PLACE_CLAN_WAR:String = "clanWar";
      
      public static const PLACE_CLAN_BOSS:String = "clanBoss";
      
      public static const PLACE_DAILY_BONUS:String = "dailyNonus";
      
      public static const PLACE_UPGRADE:String = "upgrade";
      
      public static const RESOURCE_TOKENS:String = "tokens";
      
      public static const RESOURCE_GOLD:String = "gold";
      
      public static const RESOURCE_BATTLE_CREDITS:String = "battleCredits";
      
      public static const RESOURCE_REVIVE:String = "revive";
      
      public static const RESOURCE_CLAN_COINS:String = "clanCoins";
      
      public static const RESOURCE_ARENA_COINS:String = "arenaCoins";
      
      public static const RESOURCE_XP:String = "xp";
      
      public static const RESOURCE_POWER:String = "power";
      
      public static const SINK_REVIVE:String = "revive";
      
      public static const SINK_ENTER_MISSION:String = "enterMission";
      
      public static const SINK_BUY_GACHA:String = "buyGacha";
      
      public static const SINK_BUY_ITEM:String = "buyItem";
      
      public static const SINK_BUY_GOLD:String = "buyGold";
      
      public static const SINK_BUY_MECH:String = "buyMech";
      
      public static const SINK_PREMIUM_ACCOUNT:String = "premiumAccount";
      
      public static const SINK_STARTER_PACK:String = "starterPack";
      
      public static const SINK_UPGRADE_BOOST:String = "upgradeBoost";
      
      public static const SINK_UPGRADE_TRANSFORM:String = "upgradeTransform";
      
      public static const SOURCE_LEVEL_UP:String = "levelUp";
      
      public static const SOURCE_MISSION_LOSS:String = "missionLoss";
      
      public static const SOURCE_MISSION_WIN:String = "missionWin";
      
      public static const SOURCE_LADDER_WIN:String = "ladderWin";
      
      public static const SOURCE_LADDER_LOSS:String = "ladderLoss";
      
      public static const SOURCE_CLAN_BOSS:String = "clanBoss";
      
      public static const SOURCE_CLAN_WAR:String = "clanWar";
      
      public static const SOURCE_RAID:String = "raid";
      
      public static const SOURCE_DAILY_BONUS:String = "dailyBonus";
      
      private var gowM:GameOfWhalesManager;
      
      private var _initialized:Boolean = false;
      
      public function BMGameOfWhalesManager()
      {
         super();
      }
      
      public function init(param1:String) : void
      {
         if(this.isEnabled == false)
         {
            return;
         }
         this._initialized = true;
         var _loc2_:String = GameOfWhalesManager.PLATFORM_WEB;
         _loc2_ = GameOfWhalesManager.PLATFORM_ANDROID;
         if(param1 == "")
         {
            param1 = GameOfWhalesManager.DEFAULT_COUNTRY_CODE;
         }
         var _loc3_:String = null;
         var _loc4_:String = param1.toUpperCase();
         param1.substr(0,2).toLowerCase();
         param1 = param1 + "_" + param1.toUpperCase();
         this.gowM = new GameOfWhalesManager("5cf76c5e2159023d1c4fa3b0",this.dataM.userID.toString(),_loc3_,_loc4_,_loc2_,this.store,param1,this.currentTime);
         this.gowM.addEventListener(GameOfWhalesEvent.TEMP,this.onPostSent);
         this.gowM.addEventListener(GameOfWhalesEvent.VERSION_SET,this.onVersionSet);
         this.gowM.addEventListener(GameOfWhalesEvent.GOT_OFFERS,this.onGotOffers);
         TsLogger.log(" > > > > > > >   GAME OF WHALES INITIALIZED");
      }
      
      private function get store() : String
      {
         return GameOfWhalesManager.STORE_GOOGLE_PLAY;
      }
      
      private function onPostSent(param1:GameOfWhalesEvent) : void
      {
         TsLogger.log(" > > > > > > >   " + param1.result.output);
      }
      
      private function onVersionSet(param1:GameOfWhalesEvent) : void
      {
         BMRemoteManager.getInstance().socketM.gameOfWhales_sendCommonData(this.gowM.getVariables().common);
         this.getOffers();
      }
      
      public function getOffers() : void
      {
         if(this.isEnabled == false)
         {
            return;
         }
         if(this.gowM == null)
         {
            return;
         }
         this.gowM.getOffers();
      }
      
      private function onGotOffers(param1:GameOfWhalesEvent) : void
      {
         if(int(this.dataM.getGeneralSetting("gameOfWhalesOffersEnabled","0")) == 0)
         {
            return;
         }
         if(this.gowM.currentOffers.length == 0)
         {
            return;
         }
         var _loc2_:GameOfWhalesOffer = this.gowM.currentOffers[0];
         var _loc3_:Number = Math.ceil((_loc2_.finishedAt - _loc2_.activatedAt) / 1000);
         var _loc4_:Number = Math.ceil(_loc2_.activatedAt / 1000);
         TsLogger.log(" SHOWING OFFER " + _loc2_.product + " " + _loc2_.countFactor + " " + _loc4_ + " " + _loc3_);
         this.dataM.myProfile.createStarterPackDataOverride(_loc2_.product,_loc2_.priceFactor,_loc2_.countFactor,_loc4_,_loc3_);
      }
      
      public function get enabledAndInitialized() : Boolean
      {
         if(this.isEnabled == false)
         {
            return false;
         }
         return this._initialized;
      }
      
      public function get isEnabled() : Boolean
      {
         if(BMTutorialManager.gi().isTutorialActive())
         {
            return false;
         }
         if(this.dataM.clientRunningLocally)
         {
            return true;
         }
         if(int(this.dataM.getGeneralSetting("gameOfWhalesEnabled","0")) == 1)
         {
            if(int(this.dataM.getGeneralSetting("gameOfWhalesAndroidEnabled","0")) == 1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function alertLogin() : void
      {
         if(this.enabledAndInitialized == false)
         {
            return;
         }
         this.gowM.setLoginInfo();
      }
      
      public function updateUserProfile() : void
      {
         if(this.enabledAndInitialized == false)
         {
            return;
         }
         var _loc1_:Object = new Object();
         _loc1_.playerName = this.dataM.myProfile.playerName;
         _loc1_.userName = this.dataM.myProfile.userName;
         _loc1_.xpLevel = this.dataM.myProfile.level;
         _loc1_.ladderProgress = this.dataM.myProfile.ladderProgress;
         _loc1_.gold = this.dataM.myProfile.gold;
         _loc1_.tokens = this.dataM.myProfile.tokens;
         _loc1_.battleCredits = this.dataM.myProfile.battleCredits;
         _loc1_.clanCoins = this.dataM.myProfile.clanCoins;
         _loc1_.timeToFirstPayment = this.dataM.myProfile.timeToFirstPayment;
         _loc1_.firstSessionDate = this.dataM.myProfile.firstSessionDate;
         if(_loc1_.firstSessionDate == null)
         {
            _loc1_.firstSessionDate = 0;
         }
         _loc1_.isInClan = this.dataM.myProfile.clanID > 0;
         _loc1_.campaignLevel = this.dataM.singlePlayerM.getAllCampaignsProgress();
         _loc1_.campaignWins = this.dataM.myProfile.winsVSComputer;
         _loc1_.campaignLoses = this.dataM.myProfile.battlesVSComputer;
         _loc1_.ladderWins = this.dataM.myProfile.ladderWins;
         _loc1_.completedQuests = this.dataM.questsManager.getNumOfCompletedQuests(BMQuestsManager.TYPE_ACHIEVEMENT_QUEST);
         _loc1_.clientVersion = BMExternalAssetsManager.getInstance().getVersionNumber();
         this.gowM.setProfile(_loc1_);
      }
      
      public function get hasOffers() : Boolean
      {
         if(this.enabledAndInitialized == false)
         {
            return false;
         }
         return this.gowM.currentOffers.length > 0;
      }
      
      public function get offers() : Vector.<GameOfWhalesOffer>
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.gowM.currentOffers.length)
         {
            TsLogger.log("         OFFER: " + JSON.stringify(this.gowM.currentOffers[_loc1_]));
            _loc1_++;
         }
         return this.gowM.currentOffers;
      }
      
      public function tokensPurchased(param1:Number, param2:String, param3:uint, param4:String) : void
      {
         var _loc15_:String = null;
         if(this.enabledAndInitialized == false)
         {
            return;
         }
         var _loc5_:String = RESOURCE_TOKENS + param3;
         if(param3 == 0)
         {
            _loc5_ = "30DayPass";
         }
         var _loc6_:Number = param1;
         var _loc7_:String = param2;
         param1 *= 100;
         param1 = Math.floor(param1);
         var _loc8_:String = "";
         var _loc9_:String = "";
         var _loc10_:Boolean = false;
         var _loc11_:String = "";
         var _loc12_:Array = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
         var _loc13_:uint = 0;
         while(_loc13_ < param2.length)
         {
            _loc15_ = param2.substr(_loc13_,1);
            if(_loc12_.indexOf(_loc15_.toLowerCase()) != -1)
            {
               _loc11_ += _loc15_;
            }
            _loc13_++;
         }
         TsLogger.log("                  PURCHASE price:" + param1 + " currency:" + _loc11_ + " tokens:" + param3 + " store:" + this.store + " receipt:" + _loc8_);
         var _loc14_:Number = NaN;
         if(_loc11_ == "")
         {
            this.dataM.trackEvent(BMDataManager.ANALYTICS_PRIORITY_HIGHEST,"GameOfWhales","PurchaseWithBlankCurrency",param4,_loc14_,param2,param1,param3,this.dataM.geoipCountryCode);
         }
         else
         {
            this.dataM.trackEvent(BMDataManager.ANALYTICS_PRIORITY_HIGHEST,"GameOfWhales","RegularPurchase",param4,_loc14_,param2,param1,param3,this.dataM.geoipCountryCode,_loc6_,_loc7_);
         }
         this.gowM.setPurchase(_loc11_,param1,_loc5_,this.store,_loc8_,_loc9_,_loc10_);
      }
      
      public function tokensConvertedToGold(param1:uint, param2:uint) : void
      {
         if(this.enabledAndInitialized == false)
         {
            return;
         }
         TsLogger.log("                  CONVERSION tokens:" + param1 + " gold:" + param2);
         this.gowM.setConversion({
            "tokens":-param1,
            "gold":param2
         },PLACE_SHOP);
      }
      
      public function tokensConvertedToBattleCredits(param1:uint, param2:uint) : void
      {
         if(this.enabledAndInitialized == false)
         {
            return;
         }
         TsLogger.log("                  CONVERSION tokens:" + param1 + " bc:" + param2);
         this.gowM.setConversion({
            "tokens":-param1,
            "battleCredits":param2
         },PLACE_CAMPAIGN);
      }
      
      public function usedRevive() : void
      {
         this.resourceConsumed(RESOURCE_TOKENS,this.dataM.missionReviveTokensCost,SINK_REVIVE,PLACE_CAMPAIGN);
      }
      
      public function usedBattleCredits(param1:uint) : void
      {
         this.resourceConsumed(RESOURCE_BATTLE_CREDITS,param1,SINK_ENTER_MISSION,PLACE_CAMPAIGN);
      }
      
      public function usedBoost(param1:uint, param2:uint) : void
      {
         this.resourceConsumed(RESOURCE_GOLD,param1,SINK_UPGRADE_BOOST,PLACE_UPGRADE);
         this.resourceConsumed(RESOURCE_POWER,param2,SINK_UPGRADE_BOOST,PLACE_UPGRADE);
      }
      
      public function usedTransform(param1:uint, param2:uint) : void
      {
         this.resourceConsumed(RESOURCE_GOLD,param1,SINK_UPGRADE_TRANSFORM + param2,PLACE_UPGRADE);
      }
      
      public function boughtGacha(param1:uint, param2:uint, param3:uint, param4:uint) : void
      {
         if(this.enabledAndInitialized == false)
         {
            return;
         }
         if(param1 == 0 && param2 == 0 && param3 == 0)
         {
            return;
         }
         var _loc5_:String = SINK_BUY_GACHA + param4;
         if(param1 > 0)
         {
            this.resourceConsumed(RESOURCE_GOLD,param1,_loc5_,PLACE_SHOP);
            return;
         }
         if(param2 > 0)
         {
            this.resourceConsumed(RESOURCE_TOKENS,param2,_loc5_,PLACE_SHOP);
            return;
         }
         this.resourceConsumed(RESOURCE_CLAN_COINS,param3,_loc5_,PLACE_CLAN_SHOP);
      }
      
      public function boughtItem(param1:uint, param2:uint, param3:uint, param4:uint) : void
      {
         if(this.enabledAndInitialized == false)
         {
            return;
         }
         if(param1 == 0 && param2 == 0 && param3 == 0)
         {
            return;
         }
         var _loc5_:String = SINK_BUY_ITEM + param4;
         if(param1 > 0)
         {
            this.resourceConsumed(RESOURCE_GOLD,param1,_loc5_,PLACE_SHOP);
            return;
         }
         if(param2 > 0)
         {
            this.resourceConsumed(RESOURCE_TOKENS,param2,_loc5_,PLACE_SHOP);
            return;
         }
         this.resourceConsumed(RESOURCE_CLAN_COINS,param3,_loc5_,PLACE_CLAN_SHOP);
      }
      
      public function boughtClanShopItem(param1:uint, param2:BMClanShopData, param3:uint = 0) : void
      {
         var _loc4_:BMGoldPackageData = null;
         if(this.enabledAndInitialized == false)
         {
            return;
         }
         switch(param2.itemType)
         {
            case BMClanShopData.TYPE_GOLD:
               _loc4_ = this.dataM.goldPackagesDB[param2.itemID];
               this.gowM.setConversion({
                  "clanCoins":-param1,
                  "gold":_loc4_.gold
               },PLACE_CLAN_SHOP);
               break;
            case BMClanShopData.TYPE_ITEM:
               this.boughtItem(0,0,param1,param2.itemID);
               break;
            case BMClanShopData.TYPE_MECH:
               this.boughtMech(0,param1,param2.itemID);
               break;
            case BMClanShopData.TYPE_PREMIUM_ACCOUNT:
               this.boughtPremiumAccount(0,param1,param3);
               break;
            case BMClanShopData.TYPE_ITEM_BOX:
               this.boughtGacha(0,0,param1,param2.itemID);
         }
      }
      
      public function boughtMech(param1:uint, param2:uint, param3:uint) : void
      {
         if(this.enabledAndInitialized == false)
         {
            return;
         }
         var _loc4_:uint = param1;
         var _loc5_:String = RESOURCE_TOKENS;
         var _loc6_:String = PLACE_SHOP;
         if(param1 == 0)
         {
            _loc4_ = param2;
            _loc5_ = RESOURCE_CLAN_COINS;
            _loc6_ = PLACE_CLAN_SHOP;
         }
         var _loc7_:String = SINK_BUY_MECH + param3;
         this.gowM.resourcesConsumed(_loc4_,_loc5_,_loc7_,_loc6_);
      }
      
      public function boughtPremiumAccount(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc4_:uint = param1;
         var _loc5_:String = RESOURCE_TOKENS;
         var _loc6_:String = PLACE_SHOP;
         if(param1 == 0)
         {
            _loc4_ = param2;
            _loc5_ = RESOURCE_CLAN_COINS;
            _loc6_ = PLACE_CLAN_SHOP;
         }
         this.resourceConsumed(_loc5_,_loc4_,SINK_PREMIUM_ACCOUNT + param3,_loc6_);
      }
      
      public function resourceConsumed(param1:String, param2:uint, param3:String, param4:String) : void
      {
         if(this.enabledAndInitialized == false)
         {
            return;
         }
         TsLogger.log("                  CONSUME resource:" + param1 + " amount:" + param2 + " sink:" + param3 + " place:" + param4);
         this.gowM.resourcesConsumed(param2,param1,param3,param4);
      }
      
      public function resourceAcquired(param1:String, param2:uint, param3:String, param4:String) : void
      {
         if(this.enabledAndInitialized == false)
         {
            return;
         }
         if(param2 == 0)
         {
            return;
         }
         TsLogger.log("                  RESOURCE ACQUIRED resource:" + param1 + " amount:" + param2 + " source:" + param3 + " place:" + param4);
         this.gowM.resourcesAcquired(param2,param1,param3,param4);
      }
      
      private function currentTime() : Number
      {
         return this.dataM.currentTime * 1000;
      }
      
      private function get dataM() : BMDataManager
      {
         return BMDataManager.getInstance();
      }
   }
}

