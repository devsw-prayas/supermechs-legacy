package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMShopManager;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol738")]
   public class BMScreenWatchRewardedVideo extends BMBaseScreen
   {
      
      public static const PLACEMENT_COMPLETE_MISSION:String = "Mission_Complete_Coins";
      
      public static const PLACEMENT_ABORT_MISSION:String = "Mission_Abort_Token";
      
      public static const PLACEMENT_TOKENS_SHOP:String = "Rewarded_Shop_Tokens";
      
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
      
      private var _placment:String;
      
      private var _firstRefresh:Boolean = true;
      
      public const TYPE_COMPLETE_MISSION:uint = 1;
      
      public const TYPE_ABORT_MISSION:uint = 2;
      
      public const TYPE_TOKENS_SHOP:uint = 3;
      
      public function BMScreenWatchRewardedVideo()
      {
         super();
      }
      
      public function initialize() : void
      {
         trace("BMScreenWatchRewardedVideo initialized");
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen(param1:uint) : void
      {
         var _loc4_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenWatchRewardedVideo","btnBack","pictureE");
            _loc4_ = this.backClicked;
            if(dataM.runAsMobile)
            {
               _loc4_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc4_,dataM.runAsMobile);
            this._firstRefresh = false;
         }
         this._type = param1;
         var _loc2_:Boolean = true;
         var _loc3_:Boolean = false;
         dataM.rewardedVideo_tokensReward = false;
         switch(this._type)
         {
            case this.TYPE_COMPLETE_MISSION:
               this.txtTitle.text = "CLAIM REWARDS";
               this.txtDesc.text = "Watch to gain bonus Credits";
               this._placment = PLACEMENT_COMPLETE_MISSION;
               break;
            case this.TYPE_ABORT_MISSION:
               this._placment = PLACEMENT_ABORT_MISSION;
               if(dataM.gameType == BMDataManager.GAME_TYPE_GUEST)
               {
                  this.txtTitle.text = "IMPROVE YOUR MECH";
                  this.txtDesc.text = "Watch to gain bonus Credits";
                  dataM.rewardedVideo_tokensReward = false;
                  _loc2_ = true;
               }
               else
               {
                  this.txtTitle.text = "IMPROVE YOUR MECH";
                  this.txtDesc.text = "Watch to gain free Tokens";
                  dataM.rewardedVideo_tokensReward = true;
                  _loc2_ = false;
               }
               break;
            case this.TYPE_TOKENS_SHOP:
               this.txtTitle.text = "FREE TOKENS";
               this.txtDesc.text = "Watch to gain free Tokens";
               this._placment = PLACEMENT_TOKENS_SHOP;
               dataM.rewardedVideo_tokensReward = true;
               _loc2_ = false;
               _loc3_ = true;
         }
         if(_loc2_)
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
         if(_loc3_)
         {
            this.watchVideoClicked();
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         this.mcRays.rotation += 0.5;
      }
      
      public function watchVideoClicked() : void
      {
         dataM.showRewardedVideo(this._placment);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
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
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen("screenWatchRewardedVideo");
      }
   }
}

