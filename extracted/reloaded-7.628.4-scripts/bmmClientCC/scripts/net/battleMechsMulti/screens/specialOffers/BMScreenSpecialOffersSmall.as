package net.battleMechsMulti.screens.specialOffers
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.managers.sales.BMSale;
   import net.battleMechsMulti.managers.sales.BMSalesManager;
   import net.battleMechsMulti.managers.specialOffers.BMSpecialOffersManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMStarterPackData;
   import net.battleMechsMulti.utils.TimeUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol533")]
   public class BMScreenSpecialOffersSmall extends BMScreenSpecialOffersBase
   {
      
      public var txtTitle:TextField;
      
      public var txtTimer:TextField;
      
      public var mcRays:Sprite;
      
      private var _resetTimer:Timer;
      
      public function BMScreenSpecialOffersSmall()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function initialize() : void
      {
         TsLogger.log("BMScreenSpecialOffersSmall initialized");
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("specialOffers");
         this.mcRays.mouseEnabled = false;
         this.mcRays.mouseChildren = false;
         if(dataM.runAsMobile == false)
         {
            mcSpecialSalesHitArea.addEventListener(MouseEvent.CLICK,this.specialSaleHitAreaClicked);
         }
      }
      
      override public function refreshScreen() : void
      {
         var _loc3_:BMPlayerProfile = null;
         var _loc1_:uint = BMSpecialOffersManager.gi().currentOfferID;
         var _loc2_:Boolean = _loc1_ == BMSpecialOffersManager.STARTER_PACK_ID;
         if(_loc2_)
         {
            _loc3_ = dataM.myProfile;
            if(_loc3_.starterPackData.getStarterPackType() == BMStarterPackData.TYPE_TOKENS)
            {
               gotoAndStop("tokens");
            }
            else if(_loc3_.starterPackData.getStarterPackType() == BMStarterPackData.TYPE_GOLD)
            {
               gotoAndStop("gold");
            }
            else if(_loc3_.starterPackData.getStarterPackType() == BMStarterPackData.TYPE_GOLD_AND_TOKENS)
            {
               gotoAndStop("goldAndTokens");
            }
            else if(_loc3_.starterPackData.getStarterPackType() == BMStarterPackData.TYPE_ITEM_AND_TOKENS)
            {
               gotoAndStop("itemAndTokens");
            }
            else if(_loc3_.starterPackData.getStarterPackType() == BMStarterPackData.TYPE_BOXES_ONLY)
            {
               gotoAndStop("boxesOnly");
            }
            else if(_loc3_.starterPackData.boostID > 0)
            {
               gotoAndStop("box");
            }
            else if(_loc3_.starterPackData.getStarterPackType() == BMStarterPackData.TYPE_MECH_ONLY)
            {
               gotoAndStop("mechOnly");
            }
            else
            {
               gotoAndStop("mech");
            }
            this.titleText = getScreenText("specialOffer");
         }
         else if(BMSpecialOffersManager.gi().currentOfferID == BMSpecialOffersManager.GLOBAL_SALE_ID)
         {
            gotoAndStop(this.getGlobalSaleFrameName());
            this.titleText = this.getGlobalSaleTitleText();
         }
         else if(BMSpecialOffersManager.gi().currentOfferID == BMSpecialOffersManager.POST_MYTHICAL_STARTER_PACK_ID)
         {
            this.titleText = getScreenText("specialOffer");
         }
         this.stopTimer();
         this.startTimer();
         this.refreshTimer();
      }
      
      private function startTimer() : *
      {
         this._resetTimer = new Timer(1000,0);
         this._resetTimer.addEventListener(TimerEvent.TIMER,this.resetTimerEvent);
         this._resetTimer.start();
      }
      
      private function stopTimer() : void
      {
         if(this._resetTimer != null)
         {
            this._resetTimer.stop();
            this._resetTimer.removeEventListener(TimerEvent.TIMER,this.resetTimerEvent);
            this._resetTimer = null;
         }
      }
      
      private function resetTimerEvent(param1:TimerEvent) : void
      {
         this.refreshTimer();
      }
      
      private function refreshTimer() : void
      {
         var _loc1_:Number = this.getTimeLeft();
         if(_loc1_ <= 0)
         {
            this.titleText = getSpecificText("buyStarterPack_timeUp");
            this.timeText = "00:00";
            this.disableMe();
            this.stopTimer();
            BMSpecialOffersManager.gi().offerTimerEnded();
         }
         else
         {
            this.timeText = TimeUtils.formatTimeLeft(_loc1_);
         }
      }
      
      private function getTimeLeft() : *
      {
         switch(BMSpecialOffersManager.gi().currentOfferID)
         {
            case BMSpecialOffersManager.STARTER_PACK_ID:
               return this.getStarterPackTimeLeft(dataM.myProfile.starterPackData);
            case BMSpecialOffersManager.GLOBAL_SALE_ID:
               return this.getSaleTimeLeft();
            case BMSpecialOffersManager.POST_MYTHICAL_STARTER_PACK_ID:
               return this.getStarterPackTimeLeft(dataM.myProfile.postMythicalStarterPackData);
            default:
               return;
         }
      }
      
      private function set timeText(param1:String) : void
      {
         this.txtTimer.text = param1;
         if(dataM.runAsMobile)
         {
            ImageUtils.swapTextFieldWithBitMap(this.txtTimer,this);
         }
      }
      
      private function set titleText(param1:String) : void
      {
         updateTextAndFormat(this.txtTitle,param1);
         if(dataM.runAsMobile)
         {
            ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
         }
      }
      
      private function getSaleTimeLeft() : Number
      {
         return BMSalesManager.gi().getSaleData().endDate - dataM.currentTime;
      }
      
      private function getStarterPackTimeLeft(param1:BMStarterPackData) : Number
      {
         return param1.starterPackEndDate - dataM.currentTime;
      }
      
      override public function buyClicked() : void
      {
      }
      
      override public function removeMe() : void
      {
         this.stopTimer();
         if(screensM.isScreenOpened(BMScreensManager.SCR_SPECIAL_OFFERS))
         {
            screensM.removeScreen(BMScreensManager.SCR_SPECIAL_OFFERS);
         }
      }
      
      override public function disableMe() : void
      {
         mcSpecialSalesHitArea.removeEventListener(MouseEvent.CLICK,this.specialSaleHitAreaClicked);
      }
      
      override public function enableMe() : void
      {
         mcSpecialSalesHitArea.addEventListener(MouseEvent.CLICK,this.specialSaleHitAreaClicked);
      }
      
      private function specialSaleHitAreaClicked(param1:MouseEvent) : void
      {
         if(BMTutorialManager.gi().isAllowedToClickOnMovieClip(mcSpecialSalesHitArea))
         {
            this.specialSaleHitAreaClickedSub();
         }
      }
      
      override public function specialSaleHitAreaClickedSub() : void
      {
         BMSpecialOffersManager.gi().doCurrentAction("SmallSaleIcon");
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this.mcRays.visible)
         {
            this.mcRays.rotation += 0.1;
         }
      }
      
      private function getGlobalSaleFrameName() : String
      {
         var _loc1_:BMSale = BMSalesManager.gi().getSaleData();
         if(_loc1_ != null)
         {
            if(_loc1_.saleType == BMSale.SALE_TYPE_REWARD_INCREASE)
            {
               switch(_loc1_.saleStoreSection)
               {
                  case BMSale.STORE_SECTION_ARENA_GOLD:
                     return "arenaGold";
                  case BMSale.STORE_SECTION_ARENA_XP:
                     return "arenaXP";
                  case BMSale.STORE_SECTION_CAMPAIGN_GOLD:
                     return "campaignGold";
                  case BMSale.STORE_SECTION_CAMPAIGN_XP:
                     return "campaignXP";
                  case BMSale.STORE_SECTION_CAMPAIGN_CLAN_BOSS_TICKETS:
                     return "campaignClanBossTickets";
                  case BMSale.STORE_SECTION_CAMPAIGN_BATTLE_CREDITS_REGENERATION:
                     return "campaignBattleCreditsRegeneration";
                  case BMSale.STORE_SECTION_ARENA_COINS:
                     return "arenaCoins";
               }
            }
            else if(_loc1_.saleType == BMSale.SALE_TYPE_COST_REDUCTION)
            {
               switch(_loc1_.saleStoreSection)
               {
                  case BMSale.STORE_SECTION_CAMPAIGN_BATTLE_CREDITS_REGENERATION:
                     return "campaignBattleCreditsRegeneration";
               }
            }
            else
            {
               if(_loc1_.saleType == BMSale.SALE_TYPE_DUMMY_SALE)
               {
                  return "news";
               }
               if(_loc1_.saleType == BMSale.SALE_TYPE_QUEST)
               {
                  return "quest";
               }
               if(_loc1_.saleType == BMSale.SALE_TYPE_DUNGEON)
               {
                  return "dungeon";
               }
            }
         }
         return "sale";
      }
      
      private function getGlobalSaleTitleText() : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Number = NaN;
         var _loc1_:BMSale = BMSalesManager.gi().getSaleData();
         if(_loc1_ != null)
         {
            if(_loc1_.saleType == BMSale.SALE_TYPE_REWARD_INCREASE)
            {
               _loc4_ = _loc1_.saleEffect;
               switch(_loc1_.saleStoreSection)
               {
                  case BMSale.STORE_SECTION_ARENA_GOLD:
                     _loc2_ = languageM.getText("mainMenu_arena");
                     _loc3_ = languageM.getText("globalShop_gold");
                     break;
                  case BMSale.STORE_SECTION_ARENA_XP:
                     _loc2_ = languageM.getText("mainMenu_arena");
                     _loc3_ = "XP";
                     break;
                  case BMSale.STORE_SECTION_CAMPAIGN_GOLD:
                     _loc2_ = languageM.getText("mainMenu_campaign");
                     _loc3_ = languageM.getText("globalShop_gold");
                     break;
                  case BMSale.STORE_SECTION_CAMPAIGN_XP:
                     _loc2_ = languageM.getText("mainMenu_campaign");
                     _loc3_ = "XP";
                     break;
                  case BMSale.STORE_SECTION_CAMPAIGN_CLAN_BOSS_TICKETS:
                     _loc3_ = languageM.getText("clanBoss_tickets");
                     break;
                  case BMSale.STORE_SECTION_ARENA_COINS:
                     _loc3_ = languageM.getText("general_coins");
                     break;
                  case BMSale.STORE_SECTION_CAMPAIGN_BATTLE_CREDITS_REGENERATION:
                     _loc4_ *= 2;
                     _loc3_ = languageM.getText("general_fuel");
                     break;
                  default:
                     return getScreenText("hotSale");
               }
               return "+" + _loc4_ + "% " + _loc3_;
            }
            if(_loc1_.saleType == BMSale.SALE_TYPE_COST_REDUCTION)
            {
               _loc4_ = _loc1_.saleEffect;
               switch(_loc1_.saleStoreSection)
               {
                  case BMSale.STORE_SECTION_CAMPAIGN_BATTLE_CREDITS_REGENERATION:
                     _loc4_ *= 2;
                     _loc3_ = languageM.getText("general_fuel");
                     return "+" + _loc4_ + "% " + _loc3_;
                  default:
                     return getScreenText("hotSale");
               }
            }
            else
            {
               if(_loc1_.saleType == BMSale.SALE_TYPE_DUMMY_SALE)
               {
                  return getScreenText("news");
               }
               if(_loc1_.saleType == BMSale.SALE_TYPE_QUEST)
               {
                  return getScreenText("news");
               }
               if(_loc1_.saleType == BMSale.SALE_TYPE_DUNGEON)
               {
                  return getSpecificText("specialOffers_portal");
               }
            }
         }
         return getScreenText("hotSale");
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

