package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol2028")]
   public class BMScreenWatchRewardedVideo extends BMBaseScreen
   {
      
      public static const PLACEMENT_COMPLETE_MISSION:String = "Mission_Complete_Coins";
      
      public static const PLACEMENT_ABORT_MISSION:String = "Mission_Abort_Token";
      
      public static const PLACEMENT_TOKENS_SHOP:String = "Rewarded_Shop_Tokens";
      
      public static const PLACEMENT_PVP_INCREASE_REWARD_SCREEN:String = "PVP_Double_Reward_Screen";
      
      public static const PLACEMENT_PRE_CAMPAIGN_MISSION_BONUS:String = "Pre_Campaign_Mission_Bonus";
      
      public static const PLACEMENT_OPEN_BOX_EXTRA_CARD:String = "Open_Box_Extra_Card";
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnWatch:Sprite;
      
      public var mcGoldTop:Sprite;
      
      public var mcTokensTop:Sprite;
      
      public var mcGoldBottom:Sprite;
      
      public var mcTokensBottom:Sprite;
      
      public var mcRays:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtDesc:TextField;
      
      public var btnBack:BMButton_pictureE;
      
      private var _type:uint;
      
      private var _analyticsParam:Number = NaN;
      
      private var _firstRefresh:Boolean = true;
      
      public const TYPE_COMPLETE_MISSION:uint = 1;
      
      public const TYPE_ABORT_MISSION:uint = 2;
      
      public const TYPE_TOKENS_SHOP:uint = 3;
      
      public const TYPE_WIN_PVP:uint = 4;
      
      public const TYPE_LOSE_PVP:uint = 5;
      
      public const TYPE_PRE_CAMPAIGN_MISSION_BONUS:uint = 6;
      
      public const TYPE_OPEN_BOX_EXTRA_CARD:uint = 7;
      
      public function BMScreenWatchRewardedVideo()
      {
         super();
      }
      
      public function initialize() : void
      {
         trace("BMScreenWatchRewardedVideo initialized");
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("watchRewardedVideo");
      }
      
      public function refreshScreen(param1:uint, param2:Number = NaN) : void
      {
         var _loc5_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer(BMScreensManager.SCR_WATCH_REWARDED_VIDEO,"btnBack","pictureE");
            _loc5_ = this.backClicked;
            if(dataM.runAsMobile)
            {
               _loc5_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc5_,dataM.runAsMobile);
            this._firstRefresh = false;
         }
         this._type = param1;
         this._analyticsParam = param2;
         var _loc3_:Boolean = true;
         var _loc4_:Boolean = false;
         switch(this._type)
         {
            case this.TYPE_COMPLETE_MISSION:
               updateTextAndFormat(this.txtTitle,getScreenText("claimRewards"));
               updateTextAndFormat(this.txtDesc,getScreenText("watchToGainGold"));
               dataM.rewardedVideo_placement = PLACEMENT_COMPLETE_MISSION;
               break;
            case this.TYPE_ABORT_MISSION:
               dataM.rewardedVideo_placement = PLACEMENT_ABORT_MISSION;
               updateTextAndFormat(this.txtTitle,getScreenText("improveYourMech"));
               updateTextAndFormat(this.txtDesc,getScreenText("watchToGainTokens"));
               _loc3_ = false;
               break;
            case this.TYPE_TOKENS_SHOP:
               updateTextAndFormat(this.txtTitle,getScreenText("freeTokens"));
               updateTextAndFormat(this.txtDesc,getScreenText("watchToGainTokens"));
               dataM.rewardedVideo_placement = PLACEMENT_TOKENS_SHOP;
               _loc3_ = false;
               _loc4_ = true;
               break;
            case this.TYPE_WIN_PVP:
               updateTextAndFormat(this.txtTitle,getScreenText("claimRewards"));
               updateTextAndFormat(this.txtDesc,this.getMoreGoldAndXPText(50));
               dataM.rewardedVideo_placement = PLACEMENT_PVP_INCREASE_REWARD_SCREEN;
               _loc4_ = true;
               break;
            case this.TYPE_LOSE_PVP:
               updateTextAndFormat(this.txtTitle,getScreenText("claimRewards"));
               updateTextAndFormat(this.txtDesc,this.getMoreGoldAndXPText(100));
               dataM.rewardedVideo_placement = PLACEMENT_PVP_INCREASE_REWARD_SCREEN;
               _loc4_ = true;
               break;
            case this.TYPE_PRE_CAMPAIGN_MISSION_BONUS:
               dataM.rewardedVideo_placement = PLACEMENT_PRE_CAMPAIGN_MISSION_BONUS;
               _loc4_ = true;
               break;
            case this.TYPE_OPEN_BOX_EXTRA_CARD:
               dataM.rewardedVideo_placement = PLACEMENT_OPEN_BOX_EXTRA_CARD;
               _loc4_ = true;
         }
         if(_loc3_)
         {
            if(this.mcTokensBottom.parent != null)
            {
               this.mcTokensBottom.parent.removeChild(this.mcTokensBottom);
            }
            if(this.mcTokensTop.parent != null)
            {
               this.mcTokensTop.parent.removeChild(this.mcTokensTop);
            }
         }
         else
         {
            if(this.mcGoldBottom.parent != null)
            {
               this.mcGoldBottom.parent.removeChild(this.mcGoldBottom);
            }
            if(this.mcGoldTop.parent != null)
            {
               this.mcGoldTop.parent.removeChild(this.mcGoldTop);
            }
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("watchRewardedVideoTexts",[this.txtDesc,this.txtTitle],"",this);
         }
         if(_loc4_)
         {
            this.watchVideoClickedSub();
            this.removeMe();
         }
         else if(dataM.runAsMobile == false)
         {
            this.mcSizer_btnWatch.addEventListener(MouseEvent.CLICK,this.watchVideoClicked);
         }
      }
      
      private function getMoreGoldAndXPText(param1:uint) : String
      {
         var _loc2_:String = getScreenText("getXMoreGoldAndXP");
         return dataM.replaceStringInText(_loc2_,"%RATIO%",String(param1));
      }
      
      public function onEnterFrameTrigger() : void
      {
         this.mcRays.rotation += 0.5;
      }
      
      private function watchVideoClicked(param1:MouseEvent) : void
      {
         this.watchVideoClickedSub();
      }
      
      public function watchVideoClickedSub() : void
      {
         dataM.trackAdvertisingEvent(BMDataManager.AD_TYPE_REWARDED_VIDEO,BMDataManager.AD_ACTION_WATCHED,dataM.rewardedVideo_placement,this._analyticsParam);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         dataM.showRewardedVideo(dataM.rewardedVideo_placement);
      }
      
      public function backClicked() : void
      {
         switch(this._type)
         {
            case this.TYPE_COMPLETE_MISSION:
               screensM.screenMissionBaseMap.exitScreen();
               break;
            case this.TYPE_ABORT_MISSION:
               screensM.screenMissionBaseMap.abortingMission();
               break;
            case this.TYPE_TOKENS_SHOP:
               BMShopManager.gi().refresh();
         }
         dataM.trackAdvertisingEvent(BMDataManager.AD_TYPE_REWARDED_VIDEO,BMDataManager.AD_ACTION_SKIPPED,dataM.rewardedVideo_placement,this._analyticsParam);
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_WATCH_REWARDED_VIDEO);
      }
   }
}

