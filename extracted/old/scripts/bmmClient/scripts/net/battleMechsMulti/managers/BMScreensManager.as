package net.battleMechsMulti.managers
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.StageDisplayState;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.net.LocalConnection;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMItemCard;
   import net.battleMechsMulti.mobiles.BMMechEquipmentItem;
   import net.battleMechsMulti.mobiles.BMMultiplayerLadderChatAlert;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton2;
   import net.battleMechsMulti.mobiles.buttons.BMButton3;
   import net.battleMechsMulti.mobiles.buttons.BMButton4;
   import net.battleMechsMulti.mobiles.buttons.BMButtonBattle;
   import net.battleMechsMulti.mobiles.buttons.BMButtonEmote;
   import net.battleMechsMulti.mobiles.buttons.BMButtonWorkbench;
   import net.battleMechsMulti.mobiles.buttons.BMButton_arrowLeft;
   import net.battleMechsMulti.mobiles.buttons.BMButton_arrowRight;
   import net.battleMechsMulti.mobiles.buttons.BMButton_battleBonus;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureA;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureB;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureC;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureD;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureF;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureG;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureH;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureI;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureJ;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureK;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureL;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureM;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureN;
   import net.battleMechsMulti.mobiles.buttons.BMButton_plus;
   import net.battleMechsMulti.mobiles.buttons.BMButton_plus2;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.BMScreenAchievementUnlocked;
   import net.battleMechsMulti.screens.BMScreenAchievements;
   import net.battleMechsMulti.screens.BMScreenAdminTools;
   import net.battleMechsMulti.screens.BMScreenBattle;
   import net.battleMechsMulti.screens.BMScreenBattleInterfaceBottom;
   import net.battleMechsMulti.screens.BMScreenBattleInterfaceEmotes;
   import net.battleMechsMulti.screens.BMScreenBattleInterfaceTop;
   import net.battleMechsMulti.screens.BMScreenBattleOptions;
   import net.battleMechsMulti.screens.BMScreenBattleResult;
   import net.battleMechsMulti.screens.BMScreenBlack;
   import net.battleMechsMulti.screens.BMScreenBuyAnotherItemBox;
   import net.battleMechsMulti.screens.BMScreenBuyBattleCredits;
   import net.battleMechsMulti.screens.BMScreenBuyBattleCreditsWithVideo;
   import net.battleMechsMulti.screens.BMScreenBuyGold;
   import net.battleMechsMulti.screens.BMScreenBuyItem;
   import net.battleMechsMulti.screens.BMScreenBuyItemBox;
   import net.battleMechsMulti.screens.BMScreenBuyMissions;
   import net.battleMechsMulti.screens.BMScreenBuyStarterPack;
   import net.battleMechsMulti.screens.BMScreenChangeMechsOrder;
   import net.battleMechsMulti.screens.BMScreenChangeName;
   import net.battleMechsMulti.screens.BMScreenClan;
   import net.battleMechsMulti.screens.BMScreenClanCreate;
   import net.battleMechsMulti.screens.BMScreenClanFlag;
   import net.battleMechsMulti.screens.BMScreenConfirmation;
   import net.battleMechsMulti.screens.BMScreenCraftMythicals;
   import net.battleMechsMulti.screens.BMScreenDailyLoginStreakBonus;
   import net.battleMechsMulti.screens.BMScreenDebugger;
   import net.battleMechsMulti.screens.BMScreenFPSTracker;
   import net.battleMechsMulti.screens.BMScreenGetTokens;
   import net.battleMechsMulti.screens.BMScreenHangerBackground;
   import net.battleMechsMulti.screens.BMScreenHangerFusion;
   import net.battleMechsMulti.screens.BMScreenHangerGiftKeys;
   import net.battleMechsMulti.screens.BMScreenHangerInsertGiftKey;
   import net.battleMechsMulti.screens.BMScreenHangerInventory;
   import net.battleMechsMulti.screens.BMScreenHangerItemComparison;
   import net.battleMechsMulti.screens.BMScreenHangerMech;
   import net.battleMechsMulti.screens.BMScreenHangerMenu;
   import net.battleMechsMulti.screens.BMScreenHangerShop;
   import net.battleMechsMulti.screens.BMScreenHelp;
   import net.battleMechsMulti.screens.BMScreenInspectPlayer;
   import net.battleMechsMulti.screens.BMScreenItemCards;
   import net.battleMechsMulti.screens.BMScreenLadderStatus;
   import net.battleMechsMulti.screens.BMScreenLanguageSelection;
   import net.battleMechsMulti.screens.BMScreenLevelUp;
   import net.battleMechsMulti.screens.BMScreenLevelUpEntry;
   import net.battleMechsMulti.screens.BMScreenLostConnection;
   import net.battleMechsMulti.screens.BMScreenMechGenerator;
   import net.battleMechsMulti.screens.BMScreenMenuMultiPlayerInspect;
   import net.battleMechsMulti.screens.BMScreenMissionBaseMap;
   import net.battleMechsMulti.screens.BMScreenMissionCompleted;
   import net.battleMechsMulti.screens.BMScreenMissionWorldMap;
   import net.battleMechsMulti.screens.BMScreenMissionWorldMapInterface;
   import net.battleMechsMulti.screens.BMScreenMorePaymentOptions;
   import net.battleMechsMulti.screens.BMScreenMultiPlayerChat;
   import net.battleMechsMulti.screens.BMScreenMultiPlayerLadder;
   import net.battleMechsMulti.screens.BMScreenMythicalCrafted;
   import net.battleMechsMulti.screens.BMScreenNewMenu;
   import net.battleMechsMulti.screens.BMScreenNews;
   import net.battleMechsMulti.screens.BMScreenOpeningSequence;
   import net.battleMechsMulti.screens.BMScreenPopUp;
   import net.battleMechsMulti.screens.BMScreenProfileAccounts;
   import net.battleMechsMulti.screens.BMScreenProfileInfo;
   import net.battleMechsMulti.screens.BMScreenProfileOptions;
   import net.battleMechsMulti.screens.BMScreenRankingList;
   import net.battleMechsMulti.screens.BMScreenReconnecting;
   import net.battleMechsMulti.screens.BMScreenRegister;
   import net.battleMechsMulti.screens.BMScreenRegisterOffer;
   import net.battleMechsMulti.screens.BMScreenReplays;
   import net.battleMechsMulti.screens.BMScreenSMTV;
   import net.battleMechsMulti.screens.BMScreenSearchForClan;
   import net.battleMechsMulti.screens.BMScreenSearchForPlayer;
   import net.battleMechsMulti.screens.BMScreenSelectAccount;
   import net.battleMechsMulti.screens.BMScreenSelectBattleMechsPerPlayer;
   import net.battleMechsMulti.screens.BMScreenSendTokensToPlayer;
   import net.battleMechsMulti.screens.BMScreenServerRestartCountdown;
   import net.battleMechsMulti.screens.BMScreenSkipTutorial;
   import net.battleMechsMulti.screens.BMScreenTopBar;
   import net.battleMechsMulti.screens.BMScreenTopBarNew;
   import net.battleMechsMulti.screens.BMScreenVS;
   import net.battleMechsMulti.screens.BMScreenWatchRewardedVideo;
   import net.battleMechsMulti.screens.BMScreenWelcomeBackground;
   import net.battleMechsMulti.screens.BMScreenWelcomeLogin;
   import net.battleMechsMulti.screens.BMScreenWelcomeLoginAs;
   import net.battleMechsMulti.screens.BMScreenWelcomeNewExisting;
   import net.battleMechsMulti.screens.BMScreenWorldMapSelectBattle;
   import net.battleMechsMulti.screens.BMScreenYouTubeVidsGuide;
   import net.battleMechsMulti.screens.extraOptions.BMScreenExtraOptions;
   import net.battleMechsMulti.screens.mainMenu.BMScreenMainMenu;
   import net.battleMechsMulti.screens.shop.BMScreenGlobalShop;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffersBase;
   
   public class BMScreensManager extends BMBaseClass
   {
      
      private static var _instance:BMScreensManager;
      
      private static var _allowInstantiation:Boolean;
      
      public static var CLIENT_READY:String = "bmSCREENS_CLIENT_READY";
      
      private var _afterLoginScreensCreated:Boolean = false;
      
      private var _socketConnectionEstablished:Boolean = false;
      
      private var _socketConnectionFailed:Boolean = false;
      
      private var _resourcesLoaded:Boolean = false;
      
      private var _inactivityCounter:Number = 0;
      
      private var _currentTimeTimer:Timer;
      
      private var _secondsTimer:Timer;
      
      private var _secondsTotal:Number = 0;
      
      private var _framesTotal:Number = 0;
      
      private var _refreshBattleStatisticsCounter:Number = 0;
      
      private var _openToolTipFrameCountdown:Number = 0;
      
      private var _openToolTipFunction:Function = null;
      
      private var _openToolTipParameter_number:Number = -1;
      
      private var _openToolTipParameter_string:String = "";
      
      public var gameDefaultTextFormat:TextFormat = new TextFormat("American Captain Eternal",20);
      
      public var chineseTextFormat:TextFormat = new TextFormat("_sans",20);
      
      public var russianTextFormat:TextFormat = new TextFormat("_sans",16);
      
      public var turkishTextFormat:TextFormat = new TextFormat("_sans",16);
      
      public var italianTextFormat:TextFormat = new TextFormat("_sans",16);
      
      public var stagePointer:Stage;
      
      private var bottomLayer:MovieClip;
      
      private var semiMiddleLayer:MovieClip;
      
      private var middleLayer:MovieClip;
      
      private var topLayer:MovieClip;
      
      private var superTopLayer:MovieClip;
      
      public var btnDebugger:BMButton_pictureE;
      
      public var screenWelcomeBackground:BMScreenWelcomeBackground;
      
      public var screenSelectBattleMechsPerPlayer:BMScreenSelectBattleMechsPerPlayer;
      
      public var screenWelcomeLogin:BMScreenWelcomeLogin;
      
      public var screenWelcomeLoginAs:BMScreenWelcomeLoginAs;
      
      public var screenWelcomeNewExisting:BMScreenWelcomeNewExisting;
      
      public var screenSMTV:BMScreenSMTV;
      
      public var screenGlobalShop:BMScreenGlobalShop;
      
      public var screenMorePaymentOptions:BMScreenMorePaymentOptions;
      
      public var screenBuyGold:BMScreenBuyGold;
      
      public var screenLostConnection:BMScreenLostConnection;
      
      public var screenBuyAnotherItemBox:BMScreenBuyAnotherItemBox;
      
      public var screenBuyStarterPack:BMScreenBuyStarterPack;
      
      public var screenGetTokens:BMScreenGetTokens;
      
      public var screenRegister:BMScreenRegister;
      
      public var screenRegisterOffer:BMScreenRegisterOffer;
      
      public var screenMultiPlayerChat:BMScreenMultiPlayerChat;
      
      public var screenMultiPlayerLadder:BMScreenMultiPlayerLadder;
      
      public var screenBattle:BMScreenBattle;
      
      public var screenBattleResult:BMScreenBattleResult;
      
      public var screenHangerBackground:BMScreenHangerBackground;
      
      public var screenBuyItem:BMScreenBuyItem;
      
      public var screenBuyItemBox:BMScreenBuyItemBox;
      
      public var screenHangerMenu:BMScreenHangerMenu;
      
      public var screenHangerInventory:BMScreenHangerInventory;
      
      public var screenHangerMech:BMScreenHangerMech;
      
      public var screenOpeningSequence:BMScreenOpeningSequence;
      
      public var screenHangerItemComparison:BMScreenHangerItemComparison;
      
      public var screenConfirmation:BMScreenConfirmation;
      
      public var screenCraftMythicals:BMScreenCraftMythicals;
      
      public var screenExtraOptions:BMScreenExtraOptions;
      
      public var screenBattleInterfaceBottom:BMScreenBattleInterfaceBottom;
      
      public var screenBattleInterfaceEmotes:BMScreenBattleInterfaceEmotes;
      
      public var screenBattleInterfaceTop:BMScreenBattleInterfaceTop;
      
      public var screenRankingList:BMScreenRankingList;
      
      public var screenSearchForClan:BMScreenSearchForClan;
      
      public var screenServerRestartCountdown:BMScreenServerRestartCountdown;
      
      public var screenTopBar:BMScreenTopBar;
      
      public var screenTopBarNew:BMScreenTopBarNew;
      
      public var screenVS:BMScreenVS;
      
      public var screenFPSTracker:BMScreenFPSTracker;
      
      public var screenBlack:BMScreenBlack;
      
      public var screenReplays:BMScreenReplays;
      
      public var screenSkipTutorial:BMScreenSkipTutorial;
      
      public var screenHelp:BMScreenHelp;
      
      public var screenAdminTools:BMScreenAdminTools;
      
      public var screenSpecialOffers:BMScreenSpecialOffersBase;
      
      public var screenNews:BMScreenNews;
      
      public var screenMainMenu:BMScreenMainMenu;
      
      public var screenNewMenu:BMScreenNewMenu;
      
      public var screenBattleOptions:BMScreenBattleOptions;
      
      public var screenProfileOptions:BMScreenProfileOptions;
      
      public var screenProfileAccounts:BMScreenProfileAccounts;
      
      public var screenInspectPlayer:BMScreenInspectPlayer;
      
      public var screenMechGenerator:BMScreenMechGenerator;
      
      public var screenPopUp:BMScreenPopUp;
      
      public var screenProfileInfo:BMScreenProfileInfo;
      
      public var screenAchievements:BMScreenAchievements;
      
      public var screenAchievementUnlocked:BMScreenAchievementUnlocked;
      
      public var screenWorldMapSelectBattle:BMScreenWorldMapSelectBattle;
      
      public var screenItemCards:BMScreenItemCards;
      
      public var screenHangerFusion:BMScreenHangerFusion;
      
      public var screenHangerShop:BMScreenHangerShop;
      
      public var screenMenuMultiPlayerInspect:BMScreenMenuMultiPlayerInspect;
      
      public var screenLadderStatus:BMScreenLadderStatus;
      
      public var screenLevelUp:BMScreenLevelUp;
      
      public var screenLevelUpEntry:BMScreenLevelUpEntry;
      
      public var screenBuyBattleCredits:BMScreenBuyBattleCredits;
      
      public var screenBuyBattleCreditsWithVideo:BMScreenBuyBattleCreditsWithVideo;
      
      public var screenBuyMissions:BMScreenBuyMissions;
      
      public var screenClanCreate:BMScreenClanCreate;
      
      public var screenClanFlag:BMScreenClanFlag;
      
      public var screenChangeName:BMScreenChangeName;
      
      public var screenSendTokensToPlayer:BMScreenSendTokensToPlayer;
      
      public var screenMythicalCrafted:BMScreenMythicalCrafted;
      
      public var screenChangeMechsOrder:BMScreenChangeMechsOrder;
      
      public var screenClan:BMScreenClan;
      
      public var screenDailyLoginStreakBonus:BMScreenDailyLoginStreakBonus;
      
      public var screenMissionBaseMap:BMScreenMissionBaseMap;
      
      public var screenMissionWorldMap:BMScreenMissionWorldMap;
      
      public var screenMissionWorldMapInterface:BMScreenMissionWorldMapInterface;
      
      public var screenMissionCompleted:BMScreenMissionCompleted;
      
      public var screenHangerGiftKeys:BMScreenHangerGiftKeys;
      
      public var screenHangerInsertGiftKey:BMScreenHangerInsertGiftKey;
      
      public var screenSearchForPlayer:BMScreenSearchForPlayer;
      
      public var screenYouTubeVidsGuide:BMScreenYouTubeVidsGuide;
      
      public var screenSelectAccount:BMScreenSelectAccount;
      
      public var screenWatchRewardedVideo:BMScreenWatchRewardedVideo;
      
      public var screenLanguageSelection:BMScreenLanguageSelection;
      
      public var screenReconnecting:BMScreenReconnecting;
      
      public var screenDebugger:BMScreenDebugger;
      
      public var mcBlackCover:Sprite;
      
      public var clientPointer:BMClient;
      
      public var textsBitmap:Object = new Object();
      
      public var textsBitmapData:Object = new Object();
      
      public var secondaryBattleScreensOpened:Boolean = false;
      
      public var secondaryBattleScreensOpenedIgnoringBattleBonus:Boolean = false;
      
      public var mobileMouseDown:Boolean = false;
      
      public var mobileMouseDownFrames:Number = 0;
      
      public var disableNextClickForMobile:Boolean = false;
      
      public var topBottomBordersForMobile:MovieClip;
      
      private var _topBottomBordersForMobile_originYPos:Number;
      
      private var _topBottomBordersForMobile_visible:Boolean;
      
      private var _topBottomBordersForMobile_animationActive:Boolean;
      
      private var _topBottomBordersForMobile_showDelayFrames:Number;
      
      private var openedScrenes:Object = new Object();
      
      private var _onEnterFrameType:String = "frame";
      
      private var _onEnterFrameTimer:Timer;
      
      private var _lastSystemMemory_change:Number = 0;
      
      private var _lastSystemMemory_frame:Number = 0;
      
      private var _lastSystemMemoryArray:Array = new Array();
      
      private var _buttonsActiveMouseDownEffect:Array = new Array();
      
      private var _secondsLeftForBattleCreditAddon:Number;
      
      private var _preloginScreensCreated:Boolean = false;
      
      private var _screensWithOnOnterFrameFunction:Object = new Object();
      
      public var USE_FPS_TRACKER:Boolean = false;
      
      public var MOBILE_FINAL_BORDER_ADDON:uint = 0;
      
      private const MOBILE_IPAD_BORDER_ADDON:uint = 0;
      
      public function BMScreensManager()
      {
         super();
         if(!_allowInstantiation)
         {
            throw new Error("Error: Instantiation failed: Use BMScreensManager.getInstance() instead of new.");
         }
      }
      
      public static function getInstance() : BMScreensManager
      {
         if(_instance == null)
         {
            _allowInstantiation = true;
            _instance = new BMScreensManager();
            _allowInstantiation = false;
         }
         return _instance;
      }
      
      public function setStagePointer(param1:Stage) : void
      {
         this.stagePointer = param1;
         this.bottomLayer = new MovieClip();
         this.semiMiddleLayer = new MovieClip();
         this.middleLayer = new MovieClip();
         this.topLayer = new MovieClip();
         this.superTopLayer = new MovieClip();
         if(this.clientPointer.launchScreen != null)
         {
            this.bottomLayer.visible = false;
            this.semiMiddleLayer.visible = false;
            this.middleLayer.visible = false;
            this.topLayer.visible = false;
            this.superTopLayer.visible = false;
         }
         var _loc2_:uint = 480;
         if(dataM.runAsMobile)
         {
            _loc2_ += this.MOBILE_FINAL_BORDER_ADDON * 2;
         }
         this.clientPointer.mcMainHolder.addChild(this.bottomLayer);
         this.clientPointer.mcMainHolder.addChild(this.semiMiddleLayer);
         this.clientPointer.mcMainHolder.addChild(this.middleLayer);
         this.clientPointer.mcMainHolder.addChild(this.topLayer);
         this.clientPointer.mcMainHolder.addChild(this.superTopLayer);
         if(this.clientPointer.launchScreen != null)
         {
            this.clientPointer.setChildIndex(this.clientPointer.launchScreen,this.clientPointer.numChildren - 1);
            if(dataM.runAsMobile == false)
            {
            }
         }
         if(dataM.runAsMobile)
         {
            this.bottomLayer.y = this.MOBILE_FINAL_BORDER_ADDON;
            this.semiMiddleLayer.y = this.MOBILE_FINAL_BORDER_ADDON;
            this.middleLayer.y = this.MOBILE_FINAL_BORDER_ADDON;
            this.topLayer.y = this.MOBILE_FINAL_BORDER_ADDON;
            this.superTopLayer.y = this.MOBILE_FINAL_BORDER_ADDON;
            this.addTopBottomBordersForMobile();
         }
         if(this.clientPointer.launchScreen != null)
         {
            this.clientPointer.setChildIndex(this.clientPointer.launchScreen,this.clientPointer.numChildren - 1);
         }
      }
      
      public function initialize(param1:BMClient) : void
      {
         TsLogger.log("BMScreensManager initialize");
         generateSingletonClassesPointers("screensManager");
         this.clientPointer = param1;
         this.MOBILE_FINAL_BORDER_ADDON = this.MOBILE_IPAD_BORDER_ADDON;
         dataM.setFlashVarsPointer();
         var _loc2_:Boolean = false;
         if(this.clientPointer.loadedFromGlobalLoader)
         {
            _loc2_ = true;
         }
         if(this.clientPointer.launchScreen != null)
         {
            this.clientPointer.setChildIndex(this.clientPointer.launchScreen,this.clientPointer.numChildren - 1);
         }
         externalAssetsM.initialize(this.loadingResourcesOnEnterFrame,this.resourcesLoaded,this.updateLoadingStatus,dataM.clientVersion,dataM.clientRunningLocally,_loc2_);
         if(dataM.runAsMobile == false)
         {
            this.USE_FPS_TRACKER = true;
         }
         this._screensWithOnOnterFrameFunction["screenWelcomeBackground"] = true;
         this._screensWithOnOnterFrameFunction["screenWelcomeNewExisting"] = true;
         this._screensWithOnOnterFrameFunction["screenBattle"] = true;
         this._screensWithOnOnterFrameFunction["screenBattleInterfaceBottom"] = true;
         this._screensWithOnOnterFrameFunction["screenBattleInterfaceTop"] = true;
         this._screensWithOnOnterFrameFunction["screenBattleInterfaceEmotes"] = true;
         this._screensWithOnOnterFrameFunction["screenBattleResult"] = true;
         this._screensWithOnOnterFrameFunction["screenLadderStatus"] = true;
         this._screensWithOnOnterFrameFunction["screenDailyLoginStreakBonus"] = true;
         this._screensWithOnOnterFrameFunction["screenMissionCompleted"] = true;
         this._screensWithOnOnterFrameFunction["screenDailyLoginStreakBonus"] = true;
         this._screensWithOnOnterFrameFunction["screenMissionCompleted"] = true;
         this._screensWithOnOnterFrameFunction["screenChangeMechsOrder"] = true;
         this._screensWithOnOnterFrameFunction["screenHangerMenu"] = true;
         this._screensWithOnOnterFrameFunction["screenHangerInventory"] = true;
         this._screensWithOnOnterFrameFunction["screenHangerMech"] = true;
         this._screensWithOnOnterFrameFunction["screenHangerShop"] = true;
         this._screensWithOnOnterFrameFunction["screenHangerFusion"] = true;
         this._screensWithOnOnterFrameFunction["screenCraftMythicals"] = true;
         this._screensWithOnOnterFrameFunction["screenMissionBaseMap"] = true;
         this._screensWithOnOnterFrameFunction["screenMissionCompleted"] = true;
         this._screensWithOnOnterFrameFunction["screenMissionWorldMap"] = true;
         this._screensWithOnOnterFrameFunction["screenMissionWorldMapInterface"] = true;
         this._screensWithOnOnterFrameFunction["screenRegisterOffer"] = true;
         this._screensWithOnOnterFrameFunction["screenWorldMapSelectBattle"] = true;
         this._screensWithOnOnterFrameFunction["screenSpecialOffers"] = true;
         this._screensWithOnOnterFrameFunction["screenMultiPlayerLadder"] = true;
         this._screensWithOnOnterFrameFunction["screenSpecialOfferPackage"] = true;
         this._screensWithOnOnterFrameFunction["screenSMTV"] = true;
         this._screensWithOnOnterFrameFunction["screenMultiPlayerChat"] = true;
         this._screensWithOnOnterFrameFunction["screenSearchForPlayer"] = true;
         this._screensWithOnOnterFrameFunction["screenProfileInfo"] = true;
         this._screensWithOnOnterFrameFunction["screenGetTokens"] = true;
         this._screensWithOnOnterFrameFunction["screenPopUp"] = true;
         this._screensWithOnOnterFrameFunction["screenLevelUp"] = true;
         this._screensWithOnOnterFrameFunction["screenLevelUpEntry"] = true;
         this._screensWithOnOnterFrameFunction["screenVS"] = true;
         this._screensWithOnOnterFrameFunction["screenTopBar"] = true;
         this._screensWithOnOnterFrameFunction["screenTopBarNew"] = true;
         this._screensWithOnOnterFrameFunction["screenHelp"] = true;
         this._screensWithOnOnterFrameFunction["screenItemCards"] = true;
         this._screensWithOnOnterFrameFunction["screenAchievementUnlocked"] = true;
         this._screensWithOnOnterFrameFunction["screenRankingList"] = true;
         this._screensWithOnOnterFrameFunction["screenSearchForClan"] = true;
         this._screensWithOnOnterFrameFunction["screenInspectPlayer"] = true;
         this._screensWithOnOnterFrameFunction["screenReplays"] = true;
         this._screensWithOnOnterFrameFunction["screenAchievements"] = true;
         this._screensWithOnOnterFrameFunction["screenNews"] = true;
         this._screensWithOnOnterFrameFunction["screenClan"] = true;
         this._screensWithOnOnterFrameFunction["screenBuyStarterPack"] = true;
         this._screensWithOnOnterFrameFunction["screenBuyGold"] = true;
         this._screensWithOnOnterFrameFunction["screenBuyItemBox"] = true;
         this._screensWithOnOnterFrameFunction["screenWatchRewardedVideo"] = true;
         this._screensWithOnOnterFrameFunction["screenGlobalShop"] = true;
         this._screensWithOnOnterFrameFunction["screenMainMenu"] = true;
      }
      
      public function iosFollowUp() : void
      {
      }
      
      private function loadingResourcesOnEnterFrame(param1:Number) : void
      {
         if(this.clientPointer.parent.parent != null)
         {
            this.clientPointer.parent["parent"].progressHandler_resources(param1);
         }
      }
      
      private function updateLoadingStatus(param1:String) : void
      {
         if(this.clientPointer.parent.parent != null)
         {
            this.clientPointer.parent["parent"].progressHandler_status(param1);
         }
      }
      
      public function get resourcesAreLoaded() : Boolean
      {
         return this._resourcesLoaded;
      }
      
      public function resourcesLoaded() : void
      {
         this._resourcesLoaded = true;
         this.addDebuggerText("resources loaded");
         this.createPreLoginScreens("resourcesLoaded");
         dispatchEvent(new Event(BMScreensManager.CLIENT_READY));
      }
      
      public function socketConnectionEstablished() : void
      {
         this._socketConnectionEstablished = true;
         this.createPreLoginScreens("socketConnectionEstablished");
      }
      
      public function socketConnectionFailed() : void
      {
         this._socketConnectionFailed = true;
         this.createPreLoginScreens("socketConnectionFailed");
      }
      
      private function addDebuggerText(param1:String) : void
      {
         if(this.clientPointer.parent.parent != null)
         {
            this.clientPointer.parent["parent"].addDebuggerText(param1);
         }
      }
      
      public function languageSelected() : void
      {
         this.createPreLoginScreens("languageSelected");
      }
      
      private function _fastForward() : void
      {
         this.setOnEnterFrameType("timer10");
      }
      
      private function createPreLoginScreens(param1:String) : void
      {
         var conn:LocalConnection = null;
         var currentDomain:* = undefined;
         var $caller:String = param1;
         TsLogger.log("createPreLoginScreens caller : " + $caller);
         if(this._preloginScreensCreated == false)
         {
            this._preloginScreensCreated = true;
            this.addScreen("screenDebugger",false);
            this.addDebuggerText("createPreLoginScreens");
            this.addDebuggerText("_socketConnectionEstablished : " + this._socketConnectionEstablished);
            this.addDebuggerText("_socketConnectionFailed : " + this._socketConnectionFailed);
            this.addDebuggerText("_resourcesLoaded : " + this._resourcesLoaded);
            if(this._resourcesLoaded)
            {
               if(this.clientPointer.launchScreen != null)
               {
                  this.clientPointer.setChildIndex(this.clientPointer.launchScreen,this.clientPointer.numChildren - 1);
               }
               tooltip.externalAssetsLoaded();
               addEventListener(Event.ENTER_FRAME,this.screensManagerOnEnterFrame);
               this.clientPointer.mcMainHolder.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownDetector);
               if(dataM.runAsMobile)
               {
                  this.clientPointer.mcMainHolder.addEventListener(MouseEvent.CLICK,this.mouseClickDetector);
                  this.clientPointer.mcMainHolder.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpDetector);
                  this.stagePointer.addEventListener(Event.MOUSE_LEAVE,this.mouseLeaveDetector);
               }
               if(dataM.runAsMobile)
               {
                  this.setOnEnterFrameType("timer2");
               }
               else if(dataM.clientRunningLocally)
               {
                  this.setOnEnterFrameType("timer2");
               }
               else
               {
                  this.setOnEnterFrameType("timer2");
               }
               if(dataM.clientRunningLocally)
               {
                  this.setOnEnterFrameType("timer10");
               }
               else
               {
                  try
                  {
                     if(ExternalInterface.available)
                     {
                        ExternalInterface.addCallback("MakeItSo",this._fastForward);
                     }
                  }
                  catch(e:Error)
                  {
                     TsLogger.log("createPreLoginScreens: ExternalInterface not supported");
                  }
               }
               this._secondsTimer = new Timer(1000,0);
               this._secondsTimer.addEventListener(TimerEvent.TIMER,this.seocndTimerEvent);
               this._secondsTimer.start();
               this.createDebuggerButton();
               conn = new LocalConnection();
               currentDomain = conn.domain;
               this.addScreen("screenNewMenu",false);
               this.screenNewMenu.refreshScreen();
               this.addScreen("screenConfirmation",false);
               this.addScreen("screenWelcomeBackground");
               this.addScreen("screenWelcomeLogin",false);
               this.addScreen("screenBlack");
               this.screenDebugger.addTrace("Current domain : " + currentDomain);
               if(this.USE_FPS_TRACKER)
               {
                  this.addScreen("screenFPSTracker",false);
               }
               this.superTopLayer.addChild(this.screenBlack);
               if(this.clientPointer.launchScreen != null)
               {
                  this.clientPointer.setChildIndex(this.clientPointer.launchScreen,this.clientPointer.numChildren - 1);
               }
               if(this.USE_FPS_TRACKER)
               {
               }
               this.screenBlack.activateBlackScreen(null,false,true,null,0);
               this.addScreen("screenWelcomeBackground");
               this.screenWelcomeBackground.refreshScreen(true);
               addEventListener(Event.ENTER_FRAME,this.waitForSetup);
            }
            this.addDebuggerText("createPreLoginScreens completed");
         }
         else
         {
            TsLogger.log("CONNECTION LOST: CREATE PRELOGIN SCREENS");
            this.addIfNotOpened("screenLostConnection");
            this.screenLostConnection.refreshScreen();
         }
      }
      
      private function waitForSetup(param1:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.waitForSetup);
         addEventListener(Event.ENTER_FRAME,this.afterSetup);
      }
      
      private function afterSetup(param1:Event) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.afterSetup);
         this.bottomLayer.visible = true;
         this.semiMiddleLayer.visible = true;
         this.middleLayer.visible = true;
         this.topLayer.visible = true;
         this.superTopLayer.visible = true;
         if(this.clientPointer.launchScreen != null)
         {
            this.clientPointer.removeChild(this.clientPointer.launchScreen);
            this.clientPointer.launchScreen = null;
         }
      }
      
      private function seocndTimerEvent(param1:TimerEvent) : void
      {
         ++this._secondsTotal;
      }
      
      public function startCurrentTimeTimer() : void
      {
         if(this._currentTimeTimer != null)
         {
            this._currentTimeTimer.stop();
            this._currentTimeTimer.removeEventListener(TimerEvent.TIMER,this.updateCurrentTime);
            this._currentTimeTimer = null;
         }
         this._currentTimeTimer = new Timer(1000,0);
         this._currentTimeTimer.start();
         this._currentTimeTimer.addEventListener(TimerEvent.TIMER,this.updateCurrentTime);
      }
      
      private function updateCurrentTime(param1:TimerEvent) : void
      {
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         dataM.currentTime += 1;
         if(dataM.premiumAccountTime > dataM.currentTime)
         {
            if(this.isScreenOpened("screenProfileInfo"))
            {
               this.screenProfileInfo.refreshPremiumAccountText();
            }
         }
         if(this.isScreenOpened("screenTopBar"))
         {
            _loc2_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc3_ = dataM.battleCreditsMax;
            _loc4_ = dataM.secondsForNewBattleCredit;
            if(_loc2_.tokensSpent > 0)
            {
               _loc3_ = dataM.battleCreditsMax_supporters;
               _loc4_ = dataM.secondsForNewBattleCredit_supporters;
            }
            _loc5_ = dataM.currentTime - dataM.lastBattleCreditAddon;
            if(_loc5_ >= _loc4_)
            {
               _loc6_ = Math.floor(_loc5_ / _loc4_);
               _loc7_ = _loc5_ - _loc6_ * _loc4_;
               if(_loc6_ > 0)
               {
                  if(_loc2_.battleCredits + _loc6_ > _loc3_)
                  {
                     _loc6_ = _loc3_ - _loc2_.battleCredits;
                  }
               }
               dataM.lastBattleCreditAddon = dataM.currentTime - _loc7_;
               if(_loc6_ > 0)
               {
                  _loc2_.battleCredits += _loc6_;
                  this.screenTopBar.refreshBattleCredits();
               }
               if(this.isScreenOpened("screenMissionCompleted") == false)
               {
                  dataM.saveGuestData("screensM updateCurrentTime");
               }
            }
            this._secondsLeftForBattleCreditAddon = _loc4_ - _loc5_;
            if(_loc2_.battleCredits < _loc3_)
            {
               this.screenTopBar.refreshBattleCreditsTimer(this._secondsLeftForBattleCreditAddon);
            }
            if(this.isScreenOpened("screenBuyBattleCredits"))
            {
               this.screenBuyBattleCredits.refreshBattleCreditsTimer(this._secondsLeftForBattleCreditAddon);
            }
            else if(this.isScreenOpened("screenBuyBattleCreditsWithVideo"))
            {
               this.screenBuyBattleCreditsWithVideo.refreshBattleCreditsTimer(this._secondsLeftForBattleCreditAddon);
            }
         }
      }
      
      public function getSecondsLeftForBattleCreditAddon() : Number
      {
         return this._secondsLeftForBattleCreditAddon;
      }
      
      public function setOnEnterFrameType(param1:String) : void
      {
         switch(param1)
         {
            case "frame":
               this._onEnterFrameType = "frame";
               this.stopOnEnterFrameTimer();
               break;
            case "timer1":
               this._onEnterFrameType = "timer";
               this.startOnEnterFrameTimer(15);
               break;
            case "timer2":
               this._onEnterFrameType = "timer";
               this.startOnEnterFrameTimer(35);
               break;
            case "timer3":
               this._onEnterFrameType = "timer";
               this.startOnEnterFrameTimer(45);
               break;
            case "timer10":
               this._onEnterFrameType = "timer";
               this.startOnEnterFrameTimer(100);
         }
      }
      
      public function stopOnEnterFrameTimer() : void
      {
         if(this._onEnterFrameTimer != null)
         {
            this._onEnterFrameTimer.stop();
            this._onEnterFrameTimer = null;
         }
      }
      
      public function startOnEnterFrameTimer(param1:Number) : void
      {
         this.stopOnEnterFrameTimer();
         this._onEnterFrameTimer = new Timer(Math.ceil(1000 / param1),0);
         this._onEnterFrameTimer.addEventListener(TimerEvent.TIMER,this.screensManagerOnEnterFrameTimer);
         this._onEnterFrameTimer.start();
      }
      
      private function screensManagerOnEnterFrameTimer(param1:TimerEvent) : void
      {
         if(this._onEnterFrameType == "timer")
         {
            this.screensManagerOnEnterFrameSub();
         }
      }
      
      private function screensManagerOnEnterFrame(param1:Event) : void
      {
         if(this._onEnterFrameType == "frame")
         {
            this.screensManagerOnEnterFrameSub();
         }
      }
      
      private function screensManagerOnEnterFrameSub() : void
      {
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc1_:Number = 0;
         this._lastSystemMemoryArray.push(System.totalMemory - this._lastSystemMemory_frame);
         this._lastSystemMemory_frame = System.totalMemory;
         var _loc2_:uint = 0;
         while(_loc2_ < this._lastSystemMemoryArray.length)
         {
            _loc1_ += this._lastSystemMemoryArray[_loc2_];
            _loc2_++;
         }
         _loc1_ = Math.round(_loc1_ / this._lastSystemMemoryArray.length);
         if(this._lastSystemMemoryArray.length >= 30)
         {
            this._lastSystemMemoryArray.splice(0,this._lastSystemMemoryArray.length - 29);
         }
         if(this._lastSystemMemory_change != System.totalMemory)
         {
            this._lastSystemMemory_change = System.totalMemory;
         }
         if(dataM.runAsMobile)
         {
            if(dataM.useNoConnectionMode)
            {
               _loc4_ = 300;
               if(dataM.noConnectionModeActive == false && this._framesTotal == _loc4_ && dataM.firstSocketConnectionEstablished == false)
               {
                  BMLoadingTimer.gi().hideLoading();
                  if(dataM.getSharedObjectLastLoginUsername() != "")
                  {
                     this.addScreen("screenWelcomeLogin");
                     this.screenWelcomeLogin.refreshScreen();
                  }
                  else
                  {
                     this.addScreen("screenWelcomeNewExisting");
                     this.screenWelcomeNewExisting.refreshScreen();
                  }
                  dataM.noConnectionModeActive = true;
               }
            }
         }
         for each(_loc3_ in this.openedScrenes)
         {
            if(this._screensWithOnOnterFrameFunction[_loc3_])
            {
               this[_loc3_].onEnterFrameTrigger();
            }
         }
         effectsM.onEnterFrameTrigger();
         draggingM.onEnterFrameTrigger();
         tooltip.onEnterFrameTrigger();
         this.screenBlack.onEnterFrameTrigger();
         soundM.onEnterFrameTrigger();
         this.screenConfirmation.onEnterFrameTrigger();
         this.topBottomBordersForMobileHandler();
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE && dataM.userID > 0)
         {
            if(this.isScreenOpened("screenProfileInfo"))
            {
               ++this._refreshBattleStatisticsCounter;
               if(this._refreshBattleStatisticsCounter > 1000)
               {
                  if(this.isPlayerActive())
                  {
                     remoteM.lobby_usersStatistics();
                  }
                  this._refreshBattleStatisticsCounter = 0;
               }
            }
         }
         if(dataM.allowSlowCPUMode && dataM.runAsMobile == false)
         {
            if(this.screenFPSTracker != null)
            {
               if(this.screenFPSTracker.fpsTracker.FPS < dataM.slowCPUModeActivateFPS && dataM.slowCPUMode == false)
               {
                  dataM.slowCPUMode = true;
                  dataM.generalSpeedRatio = 2;
               }
               else if(this.screenFPSTracker.fpsTracker.FPS > dataM.slowCPUModeDeactivateFPS && dataM.slowCPUMode)
               {
                  dataM.slowCPUMode = false;
                  dataM.generalSpeedRatio = 1;
               }
            }
         }
         this.mobileToolTipHandler();
         if(dataM.chat_sendMessageCooldown > 0)
         {
            --dataM.chat_sendMessageCooldown;
         }
         ++this._inactivityCounter;
         ++this._framesTotal;
         if(this.mobileMouseDown)
         {
            ++this.mobileMouseDownFrames;
         }
         else
         {
            this.mobileMouseDownFrames = 0;
         }
      }
      
      public function getAverageFPS() : Number
      {
         var _loc1_:Number = 30;
         if(this._secondsTotal > 0)
         {
            _loc1_ = this._framesTotal / this._secondsTotal;
         }
         return _loc1_;
      }
      
      public function fpsMax() : Number
      {
         if(this.USE_FPS_TRACKER)
         {
            return this.screenFPSTracker.fpsTracker.getMaxFPS();
         }
         return 0;
      }
      
      public function fpsMin() : Number
      {
         if(this.USE_FPS_TRACKER)
         {
            return this.screenFPSTracker.fpsTracker.getMinFPS();
         }
         return 0;
      }
      
      public function fpsAvg() : Number
      {
         if(this.USE_FPS_TRACKER)
         {
            return this.screenFPSTracker.fpsTracker.getAverageFPS();
         }
         return 0;
      }
      
      private function mouseDownDetector(param1:MouseEvent) : void
      {
         var _loc2_:Function = null;
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Array = null;
         var _loc11_:Number = NaN;
         var _loc12_:BMMechEquipmentItem = null;
         var _loc13_:BMTileListItem = null;
         var _loc14_:BMMultiplayerLadderChatAlert = null;
         var _loc15_:BMTileListItem = null;
         var _loc16_:Number = NaN;
         var _loc17_:BMTileListItem = null;
         var _loc18_:BMTileListItem = null;
         var _loc19_:Number = NaN;
         var _loc20_:BMButtonBattle = null;
         var _loc21_:Object = null;
         this.mobileMouseDown = true;
         this._inactivityCounter = 0;
         if(dataM.runAsMobile)
         {
            if(this.screenBlack.isActive() == false)
            {
               _loc2_ = null;
               _loc3_ = new Array();
               _loc5_ = this.getTargetScreens();
               _loc6_ = new Array();
               _loc7_ = 0;
               while(_loc7_ < _loc5_.length)
               {
                  switch(_loc5_[_loc7_])
                  {
                     case "screenConfirmation":
                        if(this.isButtonInCoordinates("screenConfirmation","btnCancel"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCancel"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenConfirmation","btnCancelOnly"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCancelOnly"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenConfirmation","btnCancelSmall"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCancelSmall"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenConfirmation","btnConfirm"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnConfirm"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenConfirmation","btnOKOnly"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnOKOnly"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenConfirmation","btnRegister"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnRegister"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenConfirmation","btnLater"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLater"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenConfirmation","btnHanger"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnHanger"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenConfirmation","btnAppStore"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnAppStore"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenConfirmation","btnGetCredits"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnGetCredits"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenConfirmation","btnGetTokens"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnGetTokens"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenConfirmation","btnSuperMechs"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSuperMechs"
                           });
                        }
                        break;
                     case "screenBattleOptions":
                        if(this.isButtonInCoordinates("screenBattleOptions","btnMusicOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnMusicOn"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBattleOptions","btnMusicOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnMusicOff"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBattleOptions","btnSoundOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSoundOn"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBattleOptions","btnSoundOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSoundOff"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBattleOptions","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBattleOptions","btnParticlesMinus"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnParticlesMinus"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBattleOptions","btnParticlesPlus"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnParticlesPlus"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBattleOptions","btnBreathingOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBreathingOff"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBattleOptions","btnBreathingOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBreathingOn"
                           });
                        }
                        break;
                     case "screenTopBar":
                        if(mouseY <= 45)
                        {
                           if(this.screenTopBar.canClickOnButton())
                           {
                              if(this.isButtonInCoordinates("screenTopBar","btnGetGold"))
                              {
                                 _loc6_.push({
                                    "screen":_loc5_[_loc7_],
                                    "button":"btnGetGold"
                                 });
                                 this.setMobileToolTipActivation(this.screenTopBar.getGoldMouseOver);
                              }
                              else if(this.screenTopBar.mcBackgroundCover.visible == false && this.isButtonInCoordinates("screenTopBar","btnGetTokens"))
                              {
                                 _loc6_.push({
                                    "screen":_loc5_[_loc7_],
                                    "button":"btnGetTokens"
                                 });
                                 this.setMobileToolTipActivation(this.screenTopBar.getTokensMouseOver);
                              }
                              else if(this.isSpriteInCoordinates(this.screenTopBar.mcTooltip_gold) || this.isSpriteInCoordinates(this.screenTopBar.mcSizer_btnGetGold))
                              {
                                 this.setMobileToolTipActivation(this.screenTopBar.tooltipMouseOverSub,-1,"gold");
                              }
                              else if(this.screenTopBar.mcBackgroundCover.visible == false && this.isSpriteInCoordinates(this.screenTopBar.mcTooltip_tokens) || this.isSpriteInCoordinates(this.screenTopBar.mcSizer_btnGetTokens))
                              {
                                 this.setMobileToolTipActivation(this.screenTopBar.tooltipMouseOverSub,-1,"tokens");
                              }
                           }
                           if(this.isSpriteInCoordinates(this.screenTopBar.mcTooltip_XP))
                           {
                              this.setMobileToolTipActivation(this.screenTopBar.tooltipMouseOverSub,-1,"XP");
                           }
                           else if(this.isSpriteInCoordinates(this.screenTopBar.mcTooltip_level))
                           {
                              this.setMobileToolTipActivation(this.screenTopBar.tooltipMouseOverSub,-1,"level");
                           }
                           else if(this.isSpriteInCoordinates(this.screenTopBar.mcTooltip_rank))
                           {
                              this.setMobileToolTipActivation(this.screenTopBar.tooltipMouseOverSub,-1,"rank");
                           }
                           else if(this.screenTopBar.mcBackgroundCover.visible == false && this.isSpriteInCoordinates(this.screenTopBar.mcTooltip_battleCredits))
                           {
                              this.setMobileToolTipActivation(this.screenTopBar.tooltipMouseOverSub,-1,"battleCredits");
                           }
                        }
                        break;
                     case "screenTopBarNew":
                        if(mouseY <= 45)
                        {
                           if(this.screenTopBarNew.canClickOnButton())
                           {
                              if(this.isButtonInCoordinates("screenTopBarNew","btnGetGold"))
                              {
                                 _loc6_.push({
                                    "screen":_loc5_[_loc7_],
                                    "button":"btnGetGold"
                                 });
                                 this.setMobileToolTipActivation(this.screenTopBar.getGoldMouseOver);
                              }
                              else if(this.isButtonInCoordinates("screenTopBarNew","btnGetTokens"))
                              {
                                 _loc6_.push({
                                    "screen":_loc5_[_loc7_],
                                    "button":"btnGetTokens"
                                 });
                                 this.setMobileToolTipActivation(this.screenTopBarNew.getTokensMouseOver);
                              }
                              else if(this.isSpriteInCoordinates(this.screenTopBarNew.mcTooltip_gold) || this.isSpriteInCoordinates(this.screenTopBarNew.mcSizer_btnGetGold))
                              {
                                 this.setMobileToolTipActivation(this.screenTopBarNew.tooltipMouseOverSub,-1,"gold");
                              }
                              else if(this.isSpriteInCoordinates(this.screenTopBarNew.mcTooltip_tokens) || this.isSpriteInCoordinates(this.screenTopBarNew.mcSizer_btnGetTokens))
                              {
                                 this.setMobileToolTipActivation(this.screenTopBarNew.tooltipMouseOverSub,-1,"tokens");
                              }
                           }
                           if(this.isSpriteInCoordinates(this.screenTopBarNew.mcTooltip_XP))
                           {
                              this.setMobileToolTipActivation(this.screenTopBarNew.tooltipMouseOverSub,-1,"XP");
                           }
                           else if(this.isSpriteInCoordinates(this.screenTopBarNew.mcTooltip_level))
                           {
                              this.setMobileToolTipActivation(this.screenTopBarNew.tooltipMouseOverSub,-1,"level");
                           }
                        }
                        break;
                     case "screenPopUp":
                        if(this.isButtonInCoordinates("screenPopUp","btnOK"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnOK"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenPopUp","btnFacebookPublish"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnFacebookPublish"
                           });
                        }
                        break;
                     case "screenLevelUp":
                        if(this.isButtonInCoordinates("screenLevelUp","btnOK"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnOK"
                           });
                        }
                        else if(this.isSpriteInCoordinates(this.screenLevelUp.mcSizer_tooltip15))
                        {
                           this.setMobileToolTipActivation(this.screenLevelUp.cardTooltipMouseOverSub,15);
                        }
                        else if(this.isSpriteInCoordinates(this.screenLevelUp.mcSizer_tooltip20))
                        {
                           this.setMobileToolTipActivation(this.screenLevelUp.cardTooltipMouseOverSub,20);
                        }
                        else if(this.isSpriteInCoordinates(this.screenLevelUp.mcSizer_tooltip25))
                        {
                           this.setMobileToolTipActivation(this.screenLevelUp.cardTooltipMouseOverSub,25);
                        }
                        else if(this.isSpriteInCoordinates(this.screenLevelUp.mcSizer_tooltip30))
                        {
                           this.setMobileToolTipActivation(this.screenLevelUp.cardTooltipMouseOverSub,30);
                        }
                        break;
                     case "screenItemCards":
                        if(this.isButtonInCoordinates("screenItemCards","btnOK"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnOK"
                           });
                        }
                        break;
                     case "screenHangerMenu":
                        if(this.isButtonInCoordinates("screenHangerMenu","btnMech"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnMech"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenHangerMenu","btnFusion"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnFusion"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenHangerMenu","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenHangerMenu","btnChangeMechsOrder"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnChangeMechsOrder"
                           });
                        }
                        break;
                     case "screenChangeMechsOrder":
                        if(this.isButtonInCoordinates("screenChangeMechsOrder","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isSpriteInCoordinates(this.screenChangeMechsOrder.mcMouseHitArea))
                        {
                           this.screenChangeMechsOrder.mechsMouseDownSub();
                        }
                        break;
                     case "screenHangerInventory":
                        if(draggingM.item == null)
                        {
                           if(this.isButtonInCoordinates("screenHangerInventory","btnItemsLeft"))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnItemsLeft"
                              });
                           }
                           else if(this.isButtonInCoordinates("screenHangerInventory","btnItemsRight"))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnItemsRight"
                              });
                           }
                           else
                           {
                              _loc4_ = 1;
                              while(_loc4_ <= this.screenHangerInventory.ITEM_TYPE_BUTTONS)
                              {
                                 if(this.isButtonInCoordinates("screenHangerInventory","btnItemType" + _loc4_))
                                 {
                                    _loc6_.push({
                                       "screen":_loc5_[_loc7_],
                                       "button":"btnItemType" + _loc4_
                                    });
                                    this.setMobileToolTipActivation(this.screenHangerInventory.itemTypeButtonMouseOverSub,_loc4_);
                                    _loc4_ = this.screenHangerInventory.ITEM_TYPE_BUTTONS + 1;
                                 }
                                 _loc4_++;
                              }
                           }
                        }
                        break;
                     case "screenHangerShop":
                        if(this.isButtonInCoordinates("screenHangerShop","btnItemsLeft"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnItemsLeft"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenHangerShop","btnItemsRight"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnItemsRight"
                           });
                        }
                        else if(this.isSpriteInCoordinates(this.screenHangerShop.mcSizer_itemsTileList))
                        {
                           _loc10_ = this.screenHangerShop.itemsTileList.getItemIDInCoords(mouseX - this.screenHangerShop.mcSizer_itemsTileList.x,mouseY - this.screenHangerShop.mcSizer_itemsTileList.y);
                           _loc11_ = Number(_loc10_[1]);
                           if(_loc11_ > 0)
                           {
                              this.setMobileToolTipActivation(this.screenHangerShop.shopItemMouseOverSub,_loc11_,"",3);
                           }
                        }
                        break;
                     case "screenBuyItem":
                        if(this.isButtonInCoordinates("screenBuyItem","btnBuy"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBuy"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyItem","btnCancel"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCancel"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyItem","btnBack0"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack0"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyItem","btnBack1"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack1"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyItem","btnBack2"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack2"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyItem","btnBack3"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack3"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyItem","btnBack4"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack4"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyItem","btnBack5"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack5"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyItem","btnPlus"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnPlus"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyItem","btnMinus"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnMinus"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyItem","btnGetCredits"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnGetCredits"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyItem","btnGetTokens"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnGetTokens"
                           });
                        }
                        else if(this.isSpriteInCoordinates(this.screenBuyItem.mcSizer_tooltipItem))
                        {
                           this.setMobileToolTipActivation(this.screenBuyItem.itemMouseOverSub,-1,"",2);
                        }
                        else if(this.isSpriteInCoordinates(this.screenBuyItem.mcSizer_tooltipBox1))
                        {
                           if(this.screenBuyItem.getSpecialStatus() >= 3)
                           {
                              this.setMobileToolTipActivation(this.screenBuyItem.boxMouseOverSub,1);
                           }
                        }
                        else if(this.isSpriteInCoordinates(this.screenBuyItem.mcSizer_tooltipBox2))
                        {
                           if(this.screenBuyItem.getSpecialStatus() >= 3)
                           {
                              this.setMobileToolTipActivation(this.screenBuyItem.boxMouseOverSub,2);
                           }
                        }
                        else if(this.isSpriteInCoordinates(this.screenBuyItem.mcSizer_tooltipBox3))
                        {
                           if(this.screenBuyItem.getSpecialStatus() >= 3)
                           {
                              this.setMobileToolTipActivation(this.screenBuyItem.boxMouseOverSub,3);
                           }
                        }
                        break;
                     case "screenBuyItemBox":
                        if(this.isButtonInCoordinates("screenBuyItemBox","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyItemBox","btnBuy"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBuy"
                           });
                        }
                        break;
                     case "screenHangerMech":
                        if(this.isButtonInCoordinates("screenHangerMech","btnPreviousMech"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnPreviousMech"
                           });
                           this.setMobileToolTipActivation(this.screenHangerMech.previousMechButtonMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenHangerMech","btnNextMech"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnNextMech"
                           });
                           this.setMobileToolTipActivation(this.screenHangerMech.nextMechButtonMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenHangerMech","btnRedeemStarterPackMech"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnRedeemStarterPackMech"
                           });
                           this.setMobileToolTipActivation(this.screenHangerMech.redeemStarterPackMechMouseOver);
                        }
                        else if(this.isSpriteInCoordinates(this.screenHangerMech.mcTooltip_inspectMech))
                        {
                           tooltip.showToolTip("inspectMech","",this.screenHangerMech.getTargetMechID());
                           tooltip.allowRepositionForMobile = true;
                        }
                        if(dataM.tutorialEnabled == false)
                        {
                           if(_loc6_.length == 0)
                           {
                              _loc4_ = 0;
                              while(_loc4_ < this.screenHangerMech.mechEquipment.equipmentItems.length)
                              {
                                 _loc12_ = this.screenHangerMech.mechEquipment.equipmentItems[_loc4_];
                                 _loc13_ = _loc12_.tileListItem;
                                 if(this.isTileListItemInCoordinates(_loc13_,this.screenHangerMech.mechEquipment.x,this.screenHangerMech.mechEquipment.y))
                                 {
                                    _loc2_ = this.screenHangerMech.mechEquipment.equipmentItemMouseDown;
                                    _loc3_.push(_loc4_,_loc13_.item.ID);
                                    _loc4_ = this.screenHangerMech.mechEquipment.equipmentItems.length;
                                 }
                                 _loc4_++;
                              }
                              if(_loc2_ == null)
                              {
                                 if(this.isSpriteInCoordinates(this.screenHangerMech.mechEquipment.mouseHitArea,this.screenHangerMech.mechEquipment.x,this.screenHangerMech.mechEquipment.y))
                                 {
                                    _loc2_ = this.screenHangerMech.mechEquipment.mouseHitAreaMouseDownSub;
                                 }
                              }
                           }
                        }
                        break;
                     case "screenHangerFusion":
                        if(this.isButtonInCoordinates("screenHangerFusion","btnActivate"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnActivate"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenHangerFusion","btnCraftMythicals"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCraftMythicals"
                           });
                        }
                        break;
                     case "screenCraftMythicals":
                        if(this.isButtonInCoordinates("screenCraftMythicals","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenCraftMythicals","btnCraft"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCraft"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_torso"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnType_torso"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_leg"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnType_leg"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_sideWeapon"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnType_sideWeapon"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_topWeapon"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnType_topWeapon"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_special"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnType_special"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_module"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnType_module"
                           });
                        }
                        break;
                     case "screenOpeningSequence":
                        break;
                     case "screenMythicalCrafted":
                        if(this.isButtonInCoordinates("screenMythicalCrafted","btnClose"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClose"
                           });
                        }
                        break;
                     case "screenHangerInsertGiftKey":
                        if(this.isButtonInCoordinates("screenHangerInsertGiftKey","btnInsertKey"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnInsertKey"
                           });
                        }
                        break;
                     case "screenHangerGiftKeys":
                        if(this.isButtonInCoordinates("screenHangerGiftKeys","btnCopy1"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCopy1"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenHangerGiftKeys","btnCopy2"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCopy2"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenHangerGiftKeys","btnCopy3"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCopy3"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenHangerGiftKeys","btnClaim1"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClaim1"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenHangerGiftKeys","btnClaim2"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClaim2"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenHangerGiftKeys","btnClaim3"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClaim3"
                           });
                        }
                        break;
                     case "screenInspectPlayer":
                        if(this.isButtonInCoordinates("screenInspectPlayer","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenInspectPlayer","btnPreviousMech"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnPreviousMech"
                           });
                           this.setMobileToolTipActivation(this.screenInspectPlayer.previousMechButtonMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenInspectPlayer","btnNextMech"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnNextMech"
                           });
                           this.setMobileToolTipActivation(this.screenInspectPlayer.nextMechButtonMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenInspectPlayer","btnUp"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnUp"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenInspectPlayer","btnDown"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnDown"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenInspectPlayer","btnMechs"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnMechs"
                           });
                           this.setMobileToolTipActivation(this.screenInspectPlayer.mechsMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenInspectPlayer","btnReplays"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnReplays"
                           });
                           this.setMobileToolTipActivation(this.screenInspectPlayer.replaysMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenInspectPlayer","btnAchievements"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnAchievements"
                           });
                           this.setMobileToolTipActivation(this.screenInspectPlayer.achievementsMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenInspectPlayer","btnClan"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClan"
                           });
                           this.setMobileToolTipActivation(this.screenInspectPlayer.clanMouseOver);
                        }
                        else if(this.isSpriteInCoordinates(this.screenInspectPlayer.mcPlayerMedalsTooltip))
                        {
                           this.screenInspectPlayer.playerMedalsTooltipMouseOverSub();
                        }
                        else if(this.isSpriteInCoordinates(this.screenInspectPlayer.mcClanMedalsTooltip))
                        {
                           this.screenInspectPlayer.clanMedalsTooltipMouseOverSub();
                        }
                        break;
                     case "screenSelectBattleMechsPerPlayer":
                        if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenSelectBattleMechsPerPlayer","btn1V1"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btn1V1"
                           });
                        }
                        else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenSelectBattleMechsPerPlayer","btn2V2"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btn2V2"
                           });
                        }
                        else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenSelectBattleMechsPerPlayer","btn3V3"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btn3V3"
                           });
                        }
                        break;
                     case "screenMenuMultiPlayerInspect":
                        if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnSendBattleInvitation"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSendBattleInvitation"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.sendBattleInvitationMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnAcceptBattleInvitation"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnAcceptBattleInvitation"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.acceptBattleInvitationMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnDeclineBattleInvitation"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnDeclineBattleInvitation"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.declineBattleInvitationMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnBlock"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBlock"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.blockMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnUnBlock"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnUnBlock"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.unBlockMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnChat"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnChat"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.chatMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnInspect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnInspect"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.inspectMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnClose"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClose"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnAcceptClanInvitation"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnAcceptClanInvitation"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.acceptClanInvitationMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnDeclineClanInvitation"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnDeclineClanInvitation"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.declineClanInvitationMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnSendClanInvitation"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSendClanInvitation"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.sendClanInvitationMouseOver);
                        }
                        break;
                     case "screenMultiPlayerLadder":
                        if(this.isButtonInCoordinates("screenMultiPlayerLadder","btnSearchForBattle"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSearchForBattle"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenMultiPlayerLadder","btnCancelSearch"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCancelSearch"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenMultiPlayerLadder","btnChatRoom"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnChatRoom"
                           });
                        }
                        else if(this.screenMultiPlayerLadder.chatAlerts.length > 0)
                        {
                           if(this.isSpriteInCoordinates(this.screenMultiPlayerLadder.mcSizer_chatAlertsHitArea))
                           {
                              _loc4_ = 0;
                              while(_loc4_ < this.screenMultiPlayerLadder.chatAlerts.length)
                              {
                                 _loc14_ = this.screenMultiPlayerLadder.chatAlerts[_loc4_];
                                 if(this.isChatAlertInCoordinates(_loc14_))
                                 {
                                    _loc14_.mouseHitAreaMouseOverSub();
                                    _loc4_ = this.screenMultiPlayerLadder.chatAlerts.length;
                                 }
                                 _loc4_++;
                              }
                           }
                        }
                        break;
                     case "screenMultiPlayerChat":
                        if(this.isButtonInCoordinates("screenMultiPlayerChat","btnBackToLadder"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBackToLadder"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenMultiPlayerChat","btnChannelsList"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnChannelsList"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenMultiPlayerChat","btnSearchForPlayer"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSearchForPlayer"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenMultiPlayerChat","btnSendMessage"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSendMessage"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenMultiPlayerChat","btnBattleInvitationsEnabled"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBattleInvitationsEnabled"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenMultiPlayerChat","btnBattleInvitationsDisabled"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBattleInvitationsDisabled"
                           });
                        }
                        break;
                     case "screenSearchForPlayer":
                        if(this.isButtonInCoordinates("screenSearchForPlayer","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenSearchForPlayer","btnSearch"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSearch"
                           });
                        }
                        break;
                     case "screenClan":
                        if(this.isButtonInCoordinates("screenClan","btnAcceptRequest"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnAcceptRequest"
                           });
                           this.setMobileToolTipActivation(this.screenClan.acceptRequestMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenClan","btnDeclineRequest"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnDeclineRequest"
                           });
                           this.setMobileToolTipActivation(this.screenClan.declineRequestMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenClan","btnInspect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnInspect"
                           });
                           this.setMobileToolTipActivation(this.screenClan.inspectMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenClan","btnKickMember"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnKickMember"
                           });
                           this.setMobileToolTipActivation(this.screenClan.kickMemberMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenClan","btnLeaveClan"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLeaveClan"
                           });
                           this.setMobileToolTipActivation(this.screenClan.leaveClanMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenClan","btnChat"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnChat"
                           });
                           this.setMobileToolTipActivation(this.screenClan.chatMouseOver);
                        }
                        else if(this.isSpriteInCoordinates(this.screenClan.mcTooltipMedals))
                        {
                           this.setMobileToolTipActivation(this.screenClan.medalsMouseOverSub);
                        }
                        break;
                     case "screenClanFlag":
                        if(this.isButtonInCoordinates("screenClanFlag","btnRandom"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnRandom"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenClanFlag","btnColorNext"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnColorNext"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenClanFlag","btnColorPrevious"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnColorPrevious"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenClanFlag","btnShapeNext"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnShapeNext"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenClanFlag","btnShapePrevious"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnShapePrevious"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenClanFlag","btnTypeNext"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnTypeNext"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenClanFlag","btnTypePrevious"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnTypePrevious"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenClanFlag","btnSave"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSave"
                           });
                        }
                        break;
                     case "screenBuyBattleCredits":
                        if(this.isButtonInCoordinates("screenBuyBattleCredits","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyBattleCredits","btnBuy1"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBuy1"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyBattleCredits","btnBuy6"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBuy6"
                           });
                        }
                        break;
                     case "screenBuyBattleCreditsWithVideo":
                        if(this.isButtonInCoordinates("screenBuyBattleCreditsWithVideo","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyBattleCreditsWithVideo","btnBuy1"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBuy1"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyBattleCreditsWithVideo","btnBuy6"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBuy6"
                           });
                        }
                        break;
                     case "screenNews":
                        _loc8_ = false;
                        if(this.screenNews.mcWeeklyWins.visible)
                        {
                           if(this.screenNews.rewardsTileListItems.length > 0)
                           {
                              _loc4_ = 0;
                              while(_loc4_ < this.screenNews.rewardsTileListItems.length)
                              {
                                 _loc15_ = this.screenNews.rewardsTileListItems[_loc4_];
                                 if(this.isTileListItemInCoordinates(_loc15_,this.screenNews.mcWeeklyWins.x,this.screenNews.mcWeeklyWins.y))
                                 {
                                    _loc16_ = this.screenNews.mcWeeklyWins.x + _loc15_.x - 285;
                                    tooltip.showToolTip("newsItem","",_loc15_.item.ID);
                                    tooltip.allowRepositionForMobile = true;
                                    tooltip.mcMainHolder.x = _loc16_;
                                    _loc4_ = this.screenNews.rewardsTileListItems.length;
                                    _loc8_ = true;
                                 }
                                 _loc4_++;
                              }
                           }
                        }
                        if(_loc8_ == false)
                        {
                           if(this.isButtonInCoordinates("screenNews","btnBack"))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnBack"
                              });
                           }
                           else if(this.isButtonInCoordinates("screenNews","btnPrevious"))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnPrevious"
                              });
                           }
                           else if(this.isButtonInCoordinates("screenNews","btnNext"))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnNext"
                              });
                           }
                        }
                        break;
                     case "screenReplays":
                        if(this.isButtonInCoordinates("screenReplays","btnPlay"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnPlay"
                           });
                        }
                        break;
                     case "screenAchievements":
                        if(this.isButtonInCoordinates("screenAchievements","btnSinglePlayer"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSinglePlayer"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenAchievements","btnMultiplayer"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnMultiplayer"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenAchievements","btnGoogleAchievements"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnGoogleAchievements"
                           });
                        }
                        break;
                     case "screenHelp":
                        if(this.isButtonInCoordinates("screenHelp","btnWiki"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnWiki"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenHelp","btnReplay"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnReplay"
                           });
                        }
                        break;
                     case "screenProfileInfo":
                        if(this.isButtonInCoordinates("screenProfileInfo","btnChangeName"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnChangeName"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileInfo","btnSendTokensToPlayer"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSendTokensToPlayer"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileInfo","btnAdminTools"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnAdminTools"
                           });
                        }
                        else if(this.isSpriteInCoordinates(this.screenProfileInfo.mcSoloMedalsTooltip))
                        {
                           this.screenProfileInfo.soloMedalsMouseOverSub();
                        }
                        else if(this.isSpriteInCoordinates(this.screenProfileInfo.mcClanMedalsTooltip))
                        {
                           this.screenProfileInfo.clanMedalsMouseOverSub();
                        }
                        break;
                     case "screenProfileOptions":
                        if(this.isButtonInCoordinates("screenProfileOptions","btnBreathingOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBreathingOff"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileOptions","btnBreathingOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBreathingOn"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileOptions","btnLanguages"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLanguages"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileOptions","btnMusicOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnMusicOff"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileOptions","btnMusicOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnMusicOn"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileOptions","btnParticlesMinus"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnParticlesMinus"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileOptions","btnParticlesPlus"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnParticlesPlus"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileOptions","btnSoundOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSoundOff"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileOptions","btnSoundOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSoundOn"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileOptions","btnPushNotificationsOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnPushNotificationsOff"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileOptions","btnPushNotificationsOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnPushNotificationsOn"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileOptions","btnSeePerksOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSeePerksOn"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileOptions","btnSeePerksOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSeePerksOff"
                           });
                        }
                        break;
                     case "screenProfileAccounts":
                        if(this.isButtonInCoordinates("screenProfileAccounts","btnSuperMechsConnect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSuperMechsConnect"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileAccounts","btnGooglePlayConnect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnGooglePlayConnect"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileAccounts","btnFacebookConnect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnFacebookConnect"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileAccounts","btnSuperMechsDisconnect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSuperMechsDisconnect"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileAccounts","btnGooglePlayDisconnect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnGooglePlayDisconnect"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileAccounts","btnFacebookDisconnect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnFacebookDisconnect"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenProfileAccounts","btnLogout"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLogout"
                           });
                        }
                        break;
                     case "screenSendTokensToPlayer":
                        if(this.isButtonInCoordinates("screenSendTokensToPlayer","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenSendTokensToPlayer","btnSearchPlayer"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSearchPlayer"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenSendTokensToPlayer","btnSend"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSend"
                           });
                        }
                        break;
                     case "screenWelcomeNewExisting":
                        if(this.isButtonInCoordinates("screenWelcomeNewExisting","btnNewPlayer"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnNewPlayer"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenWelcomeNewExisting","btnExistingPlayer"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnExistingPlayer"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenWelcomeNewExisting","btnAlreadyHasAccount"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnAlreadyHasAccount"
                           });
                        }
                        break;
                     case "screenWelcomeLogin":
                        if(this.isButtonInCoordinates("screenWelcomeLogin","btnLogin"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLogin"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenWelcomeLogin","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenWelcomeLogin","btnRegister"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnRegister"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenWelcomeLogin","btnFacebookLogin"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnFacebookLogin"
                           });
                        }
                        break;
                     case "screenWelcomeLoginAs":
                        if(this.isButtonInCoordinates("screenWelcomeLoginAs","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenWelcomeLoginAs","btnSuperMechs"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSuperMechs"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenWelcomeLoginAs","btnGooglePlay"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnGooglePlay"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenWelcomeLoginAs","btnITunes"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnITunes"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenWelcomeLoginAs","btnFacebook"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnFacebook"
                           });
                        }
                        break;
                     case "screenWelcomeBackground":
                        if(this.isButtonInCoordinates("screenWelcomeBackground","btnLanguages"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLanguages"
                           });
                        }
                        break;
                     case "screenChangeName":
                        if(this.isButtonInCoordinates("screenChangeName","btnCancel"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCancel"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenChangeName","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenChangeName","btnChange"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnChange"
                           });
                        }
                        break;
                     case "screenAdminTools":
                        if(this.isButtonInCoordinates("screenAdminTools","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenAdminTools","btnActivateReset"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnActivateReset"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenAdminTools","btnUpdateBoost"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnUpdateBoost"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenAdminTools","btnResetRateBox"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnResetRateBox"
                           });
                        }
                        break;
                     case "screenSpecialOffers":
                        if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenSpecialOffers","btnBuy"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBuy"
                           });
                        }
                        break;
                     case "screenRegister":
                        if(this.isButtonInCoordinates("screenRegister","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenRegister","btnRegister"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnRegister"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenRegister","btnCopyName"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCopyName"
                           });
                        }
                        break;
                     case "screenGlobalShop":
                        if(this.isButtonInCoordinates("screenGlobalShop","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenGlobalShop","btnClose"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClose"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenGlobalShop","btnBuyTokens"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBuyTokens"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenGlobalShop","btnBuyGold"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBuyGold"
                           });
                        }
                        else if(this.isSpriteInCoordinates(this.screenGlobalShop.mcFingerWheeling))
                        {
                           this.screenGlobalShop.scrollMouseDown();
                        }
                        break;
                     case "screenBuyGold":
                        if(this.isButtonInCoordinates("screenBuyGold","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyGold","btnBuy"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBuy"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyGold","btnGetTokens"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnGetTokens"
                           });
                        }
                        else
                        {
                           this.screenBuyGold.scrollerMouseDownSub();
                        }
                        break;
                     case "screenBuyStarterPack":
                        tooltip.hideToolTip();
                        if(this.isButtonInCoordinates("screenBuyStarterPack","btnBackOrange"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBackOrange"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyStarterPack","btnBackRed"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBackRed"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyStarterPack","btnBuyOrange"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBuyOrange"
                           });
                        }
                        else if(this.screenBuyStarterPack.tileListItems != null)
                        {
                           if(this.screenBuyStarterPack.tileListItems.length > 0)
                           {
                              _loc4_ = 0;
                              while(_loc4_ < this.screenBuyStarterPack.tileListItems.length)
                              {
                                 _loc17_ = this.screenBuyStarterPack.tileListItems[_loc4_];
                                 if(this.isTileListItemInCoordinates(_loc17_))
                                 {
                                    this.screenBuyStarterPack.itemMouseOver(_loc17_.tileID,_loc17_.item.ID);
                                    _loc4_ = this.screenBuyStarterPack.tileListItems.length;
                                 }
                                 _loc4_++;
                              }
                           }
                        }
                        break;
                     case "screenMissionWorldMap":
                        if(this.isButtonInCoordinates("screenMissionWorldMap","btnGoToHighestMission"))
                        {
                           _loc6_.push({
                              "screen":"screenMissionWorldMap",
                              "button":"btnGoToHighestMission"
                           });
                        }
                        break;
                     case "screenMissionWorldMapInterface":
                        if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenMissionWorldMapInterface","btnGoToHighestMission"))
                        {
                           _loc6_.push({
                              "screen":"screenMissionWorldMapInterface",
                              "button":"btnGoToHighestMission"
                           });
                           this.setMobileToolTipActivation(this.screenMissionWorldMapInterface.goToHighestMissionMouseOver);
                        }
                        else if(this.isSpriteInCoordinates(this.screenMissionWorldMapInterface.mcTooltip_hard,0,0))
                        {
                           this.setMobileToolTipActivation(this.screenMissionWorldMapInterface.hardTooltipMouseOverSub);
                        }
                        else if(this.isSpriteInCoordinates(this.screenMissionWorldMapInterface.mcTooltip_insane,0,0))
                        {
                           this.setMobileToolTipActivation(this.screenMissionWorldMapInterface.insaneTooltipMouseOverSub);
                        }
                        break;
                     case "screenBuyAnotherItemBox":
                        if(this.isButtonInCoordinates("screenBuyAnotherItemBox","btnBack"))
                        {
                           _loc6_.push({
                              "screen":"screenBuyAnotherItemBox",
                              "button":"btnBack"
                           });
                        }
                        break;
                     case "screenBuyMissions":
                        if(this.isButtonInCoordinates("screenBuyMissions","btnBack"))
                        {
                           _loc6_.push({
                              "screen":"screenBuyMissions",
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyMissions","btnBuy1"))
                        {
                           _loc6_.push({
                              "screen":"screenBuyMissions",
                              "button":"btnBuy1"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBuyMissions","btnBuy6"))
                        {
                           _loc6_.push({
                              "screen":"screenBuyMissions",
                              "button":"btnBuy6"
                           });
                        }
                        break;
                     case "screenMissionBaseMap":
                        if(this.isButtonInCoordinates("screenMissionBaseMap","btnAbort"))
                        {
                           _loc6_.push({
                              "screen":"screenMissionBaseMap",
                              "button":"btnAbort"
                           });
                        }
                        break;
                     case "screenMissionCompleted":
                        if(this.isButtonInCoordinates("screenMissionCompleted","btnClose"))
                        {
                           _loc6_.push({
                              "screen":"screenMissionCompleted",
                              "button":"btnClose"
                           });
                        }
                        break;
                     case "screenRegisterOffer":
                        if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenRegisterOffer","btnRegister"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnRegister"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenRegisterOffer","btnFacebookLogin"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnFacebookLogin"
                           });
                        }
                        break;
                     case "screenWorldMapSelectBattle":
                        if(this.isButtonInCoordinates("screenWorldMapSelectBattle","btnBattle"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBattle"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenWorldMapSelectBattle","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        break;
                     case "screenRankingList":
                        _loc9_ = false;
                        if(this.screenRankingList.clanRewardItems.length > 0)
                        {
                           _loc4_ = 0;
                           while(_loc4_ < this.screenRankingList.clanRewardItems.length)
                           {
                              _loc18_ = this.screenRankingList.clanRewardItems[_loc4_];
                              if(this.isTileListItemInCoordinates(_loc18_,0,0))
                              {
                                 _loc19_ = _loc18_.x + 60;
                                 tooltip.showToolTip("newsItem","",_loc18_.item.ID);
                                 tooltip.allowRepositionForMobile = true;
                                 tooltip.mcMainHolder.x = _loc19_;
                                 _loc4_ = this.screenRankingList.clanRewardItems.length;
                                 _loc9_ = true;
                              }
                              _loc4_++;
                           }
                        }
                        if(_loc9_ == false)
                        {
                           if(this.isButtonInCoordinates("screenRankingList","btnPlayers"))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnPlayers"
                              });
                           }
                           else if(this.isButtonInCoordinates("screenRankingList","btnClans"))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnClans"
                              });
                           }
                        }
                        break;
                     case "screenSearchForClan":
                        if(this.isButtonInCoordinates("screenSearchForClan","btnClanCreate"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClanCreate"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenSearchForClan","btnClanSearch"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClanSearch"
                           });
                        }
                        break;
                     case "screenWatchRewardedVideo":
                        if(this.isButtonInCoordinates("screenWatchRewardedVideo","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        break;
                     case "screenLanguageSelection":
                        if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang1"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLang1"
                           });
                        }
                        else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang3"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLang3"
                           });
                        }
                        else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang4"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLang4"
                           });
                        }
                        else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang5"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLang5"
                           });
                        }
                        else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang7"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLang7"
                           });
                        }
                        else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang9"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLang9"
                           });
                        }
                        else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang10"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLang10"
                           });
                        }
                        else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang20"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLang20"
                           });
                        }
                        break;
                     case "screenReconnecting":
                        break;
                     case "screenYouTubeVidsGuide":
                        if(this.isButtonInCoordinates("screenYouTubeVidsGuide","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        break;
                     case "screenSelectAccount":
                        break;
                     case "screenClanCreate":
                        if(this.isButtonInCoordinates("screenClanCreate","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenClanCreate","btnCreate"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCreate"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenClanCreate","btnCancel"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCancel"
                           });
                        }
                        break;
                     case "screenBattleInterfaceTop":
                        if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnZoomIn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnZoomIn"
                           });
                           this.setMobileToolTipActivation(this.screenBattleInterfaceTop.zoomInMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnZoomOut"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnZoomOut"
                           });
                           this.setMobileToolTipActivation(this.screenBattleInterfaceTop.zoomOutMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnQuit"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnQuit"
                           });
                           this.setMobileToolTipActivation(this.screenBattleInterfaceTop.quitMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnOptions"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnOptions"
                           });
                           this.setMobileToolTipActivation(this.screenBattleInterfaceTop.optionsMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnEmotesOpen"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnEmotesOpen"
                           });
                           this.setMobileToolTipActivation(this.screenBattleInterfaceTop.emotesOpenMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnEmotesClose"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnEmotesClose"
                           });
                           this.setMobileToolTipActivation(this.screenBattleInterfaceTop.emotesCloseMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnPauseReplay"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnPauseReplay"
                           });
                           this.setMobileToolTipActivation(this.screenBattleInterfaceTop.pauseReplayMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnPlayReplay"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnPlayReplay"
                           });
                           this.setMobileToolTipActivation(this.screenBattleInterfaceTop.playReplayMouseOver);
                        }
                        else if(mouseY <= 155)
                        {
                           if(mouseX <= 300)
                           {
                              if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player1_AP))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player1_AP");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player1_HP))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player1_HP");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player1_energy))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player1_energy");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player1_heat))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player1_heat");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player1_bullets))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player1_bullets");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player1_rockets))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player1_rockets");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player1_resist1))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player1_resist1");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player1_resist2))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player1_resist2");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player1_resist3))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player1_resist3");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcPlayer1DestroyMechBadge1,-20))
                              {
                                 this.screenBattleInterfaceTop.destroyMechBadgeMouseOverSub(1);
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcPlayer1DestroyMechBadge2,-20))
                              {
                                 this.screenBattleInterfaceTop.destroyMechBadgeMouseOverSub(1);
                              }
                           }
                           else if(mouseX >= 500)
                           {
                              if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player2_AP))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player2_AP");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player2_HP))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player2_HP");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player2_energy))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player2_energy");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player2_heat))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player2_heat");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player2_bullets))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player2_bullets");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player2_rockets))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player2_rockets");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player2_resist1))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player2_resist1");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player2_resist2))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player2_resist2");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcToolTip_player2_resist3))
                              {
                                 this.screenBattleInterfaceTop.toolTipAreaMouseOverSub("mcToolTip_player2_resist3");
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcPlayer2DestroyMechBadge1,-20))
                              {
                                 this.screenBattleInterfaceTop.destroyMechBadgeMouseOverSub(2);
                              }
                              else if(this.isSpriteInCoordinates(this.screenBattleInterfaceTop.mcPlayer2DestroyMechBadge2,-20))
                              {
                                 this.screenBattleInterfaceTop.destroyMechBadgeMouseOverSub(2);
                              }
                           }
                        }
                        break;
                     case "screenBattleInterfaceEmotes":
                        if(this.isButtonInCoordinates("screenBattleInterfaceEmotes","btnSendMessage"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSendMessage"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBattleInterfaceEmotes","btnChatEnable"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnChatEnable"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBattleInterfaceEmotes","btnChatDisable"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnChatDisable"
                           });
                        }
                        else
                        {
                           _loc4_ = 1;
                           while(_loc4_ <= this.screenBattleInterfaceEmotes.TOTAL_EMOTES)
                           {
                              if(this.isEmoteButtonInCoordinates(this.screenBattleInterfaceEmotes["btnEmote" + _loc4_],0,0))
                              {
                                 _loc6_.push({
                                    "screen":_loc5_[_loc7_],
                                    "button":"btnEmote" + _loc4_
                                 });
                                 _loc4_ = this.screenBattleInterfaceEmotes.TOTAL_EMOTES;
                              }
                              _loc4_++;
                           }
                        }
                        break;
                     case "screenBattleInterfaceBottom":
                        _loc4_ = 0;
                        while(_loc4_ < this.screenBattleInterfaceBottom.allButtons.length)
                        {
                           _loc20_ = this.screenBattleInterfaceBottom.allButtons[_loc4_];
                           if(this.isBattleButtonInCoordinates(_loc20_,this.screenBattleInterfaceBottom.x,this.screenBattleInterfaceBottom.y))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":_loc20_.name
                              });
                              _loc4_ = this.screenBattleInterfaceBottom.allButtons.length;
                           }
                           _loc4_++;
                        }
                        break;
                     case "screenLadderStatus":
                        if(this.isButtonInCoordinates("screenLadderStatus","btnClose"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClose"
                           });
                        }
                        break;
                     case "screenBattleResult":
                        if(this.isButtonInCoordinates("screenBattleResult","btnOK"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnOK"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenBattleResult","btnChat"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnChat"
                           });
                           this.setMobileToolTipActivation(this.screenBattleResult.chatMouseOver);
                        }
                        else if(this.isButtonInCoordinates("screenBattleResult","btnInviteToClan"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnInviteToClan"
                           });
                           this.setMobileToolTipActivation(this.screenBattleResult.inviteToClanMouseOver);
                        }
                        break;
                     case "screenLostConnection":
                        if(this.isButtonInCoordinates("screenLostConnection","btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates("screenLostConnection","btnRefresh"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnRefresh"
                           });
                        }
                  }
                  _loc7_++;
               }
               _loc4_ = 0;
               while(_loc4_ < _loc6_.length)
               {
                  _loc21_ = _loc6_[_loc4_];
                  this[_loc21_.screen][_loc21_.button].buttonCore.hitAreaMouseDownSub();
                  this._buttonsActiveMouseDownEffect.push({
                     "screen":_loc21_.screen,
                     "button":_loc21_.button
                  });
                  _loc4_++;
               }
               if(_loc2_ != null)
               {
                  if(_loc3_.length == 0)
                  {
                     _loc2_();
                  }
                  else if(_loc3_.length == 1)
                  {
                     _loc2_(_loc3_[0]);
                  }
                  else if(_loc3_.length == 2)
                  {
                     _loc2_(_loc3_[0],_loc3_[1]);
                  }
               }
            }
         }
      }
      
      public function isPlayerActive() : Boolean
      {
         var _loc1_:Boolean = true;
         if(this._inactivityCounter > 3000)
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      private function mouseLeaveDetector(param1:Event) : void
      {
         this.mouseUpDetectorSub();
      }
      
      private function mouseUpDetector(param1:MouseEvent) : void
      {
         this.mouseUpDetectorSub();
      }
      
      private function mouseUpDetectorSub() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Object = null;
         var _loc3_:Function = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc8_:Boolean = false;
         var _loc9_:BMTileListItem = null;
         var _loc10_:Sprite = null;
         var _loc11_:BMButtonBattle = null;
         var _loc12_:Object = null;
         this.mobileMouseDown = false;
         if(this._buttonsActiveMouseDownEffect.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this._buttonsActiveMouseDownEffect.length)
            {
               _loc2_ = this._buttonsActiveMouseDownEffect[_loc1_];
               this[_loc2_.screen][_loc2_.button].buttonCore.hitAreaMouseUpSub();
               _loc1_++;
            }
            this._buttonsActiveMouseDownEffect = new Array();
         }
         if(this.screenBlack.isActive() == false)
         {
            _loc3_ = null;
            _loc4_ = new Array();
            _loc5_ = this.getTargetScreens();
            _loc6_ = new Array();
            _loc7_ = 0;
            while(_loc7_ < _loc5_.length)
            {
               switch(_loc5_[_loc7_])
               {
                  case "screenConfirmation":
                     if(this.isButtonInCoordinates("screenConfirmation","btnCancel"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCancel"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnCancelOnly"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCancelOnly"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnCancelSmall"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCancelSmall"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnConfirm"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnConfirm"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnOKOnly"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnOKOnly"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnRegister"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnRegister"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnLater"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLater"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnHanger"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnHanger"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnAppStore"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAppStore"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnAppStore"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAppStore"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnGetCredits"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnGetCredits"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnGetTokens"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnGetTokens"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnSuperMechs"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSuperMechs"
                        });
                     }
                     break;
                  case "screenBattleOptions":
                     if(this.isButtonInCoordinates("screenBattleOptions","btnMusicOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnMusicOn"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnMusicOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnMusicOff"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnSoundOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSoundOn"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnSoundOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSoundOff"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnParticlesMinus"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnParticlesMinus"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnParticlesPlus"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnParticlesPlus"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnBreathingOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBreathingOn"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnBreathingOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBreathingOff"
                        });
                     }
                     break;
                  case "screenTopBar":
                     if(mouseY <= 45)
                     {
                        if(this.screenTopBar.canClickOnButton())
                        {
                           if(this.isButtonInCoordinates("screenTopBar","btnGetGold"))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnGetGold"
                              });
                           }
                           else if(this.isButtonInCoordinates("screenTopBar","btnGetTokens"))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnGetTokens"
                              });
                           }
                        }
                     }
                     this.screenTopBar.tooltipMouseOutSub();
                     break;
                  case "screenTopBarNew":
                     if(mouseY <= 45)
                     {
                        if(this.screenTopBarNew.canClickOnButton())
                        {
                           if(this.isButtonInCoordinates("screenTopBarNew","btnGetGold"))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnGetGold"
                              });
                           }
                           else if(this.isButtonInCoordinates("screenTopBarNew","btnGetTokens"))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnGetTokens"
                              });
                           }
                        }
                     }
                     this.screenTopBarNew.tooltipMouseOutSub();
                     break;
                  case "screenPopUp":
                     if(this.isButtonInCoordinates("screenPopUp","btnOK"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnOK"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenPopUp","btnFacebookPublish"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnFacebookPublish"
                        });
                     }
                     break;
                  case "screenLevelUp":
                     if(this.isButtonInCoordinates("screenLevelUp","btnOK"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnOK"
                        });
                     }
                     break;
                  case "screenItemCards":
                     if(this.isButtonInCoordinates("screenItemCards","btnOK"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnOK"
                        });
                     }
                     break;
                  case "screenHangerMenu":
                     if(this.isButtonInCoordinates("screenHangerMech","btnMech"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnMech"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenHangerMech","btnFusion"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnFusion"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenHangerMech","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenHangerMech","btnChangeMechsOrder"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnChangeMechsOrder"
                        });
                     }
                     break;
                  case "screenHangerMech":
                     if(this.isButtonInCoordinates("screenHangerMech","btnPreviousMech"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPreviousMech"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenHangerMech","btnNextMech"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnNextMech"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenHangerMech","btnRedeemStarterPackMech"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnRedeemStarterPackMech"
                        });
                     }
                     if(_loc6_.length == 0)
                     {
                        _loc8_ = false;
                        _loc1_ = 0;
                        while(_loc1_ < this.screenHangerMech.mechEquipment.equipmentItems.length)
                        {
                           _loc9_ = this.screenHangerMech.mechEquipment.equipmentItems[_loc1_].tileListItem;
                           if(this.isTileListItemInCoordinates(_loc9_,this.screenHangerMech.mechEquipment.x,this.screenHangerMech.mechEquipment.y))
                           {
                              _loc3_ = this.screenHangerMech.mechEquipment.equipmentItemMouseUp;
                              _loc4_.push(_loc1_,_loc9_.item.ID);
                              _loc1_ = this.screenHangerMech.mechEquipment.equipmentItems.length;
                              _loc8_ = true;
                           }
                           _loc1_++;
                        }
                        if(_loc8_ == false)
                        {
                           _loc10_ = this.screenHangerMech.mechEquipment.mouseHitArea;
                           if(this.isSpriteInCoordinates(_loc10_,this.screenHangerMech.mechEquipment.x,this.screenHangerMech.mechEquipment.y))
                           {
                              _loc3_ = this.screenHangerMech.mechEquipment.mouseHitAreaMouseUpSub;
                           }
                        }
                     }
                     break;
                  case "screenGlobalShop":
                     if(this.isButtonInCoordinates("screenGlobalShop","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenGlobalShop","btnClose"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClose"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenGlobalShop","btnBuyTokens"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBuyTokens"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenGlobalShop","btnBuyGold"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBuyGold"
                        });
                     }
                     else if(this.isSpriteInCoordinates(this.screenGlobalShop.mcFingerWheeling))
                     {
                        this.screenGlobalShop.scrollMouseUp();
                     }
                     break;
                  case "screenBuyGold":
                     if(this.isButtonInCoordinates("screenBuyGold","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyGold","btnBuy"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBuy"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyGold","btnGetTokens"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnGetTokens"
                        });
                     }
                     this.screenBuyGold.scrollerMouseUpSub();
                     break;
                  case "screenBuyStarterPack":
                     tooltip.hideToolTip();
                     if(this.isButtonInCoordinates("screenBuyStarterPack","btnBackOrange"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBackOrange"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyStarterPack","btnBackRed"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBackRed"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyStarterPack","btnBuyOrange"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBuyOrange"
                        });
                     }
                     break;
                  case "screenBattleInterfaceTop":
                     if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnZoomIn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnZoomIn"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnZoomOut"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnZoomOut"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnQuit"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnQuit"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnOptions"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnOptions"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnEmotesOpen"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnEmotesOpen"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnEmotesClose"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnEmotesClose"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnPauseReplay"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPauseReplay"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnPlayReplay"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPlayReplay"
                        });
                     }
                     tooltip.hideToolTip();
                     break;
                  case "screenBattleInterfaceEmotes":
                     if(this.isButtonInCoordinates("screenBattleInterfaceEmotes","btnSendMessage"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSendMessage"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceEmotes","btnChatEnable"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnChatEnable"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceEmotes","btnChatDisable"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnChatDisable"
                        });
                     }
                     else
                     {
                        _loc1_ = 1;
                        while(_loc1_ <= this.screenBattleInterfaceEmotes.TOTAL_EMOTES)
                        {
                           if(this.isEmoteButtonInCoordinates(this.screenBattleInterfaceEmotes["btnEmote" + _loc1_],0,0))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnEmote" + _loc1_
                              });
                              _loc1_ = this.screenBattleInterfaceEmotes.TOTAL_EMOTES;
                           }
                           _loc1_++;
                        }
                     }
                     break;
                  case "screenBattleInterfaceBottom":
                     _loc1_ = 0;
                     while(_loc1_ < this.screenBattleInterfaceBottom.allButtons.length)
                     {
                        _loc11_ = this.screenBattleInterfaceBottom.allButtons[_loc1_];
                        if(this.isBattleButtonInCoordinates(_loc11_,this.screenBattleInterfaceBottom.x,this.screenBattleInterfaceBottom.y))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":_loc11_.name
                           });
                           _loc1_ = this.screenBattleInterfaceBottom.allButtons.length;
                        }
                        _loc1_++;
                     }
                     break;
                  case "screenLadderStatus":
                     if(this.isButtonInCoordinates("screenLadderStatus","btnClose"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClose"
                        });
                     }
                     break;
                  case "screenBattleResult":
                     if(this.isButtonInCoordinates("screenBattleResult","btnOK"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnOK"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleResult","btnChat"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnChat"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBattleResult","btnInviteToClan"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnInviteToClan"
                        });
                     }
                     break;
                  case "screenLostConnection":
                     if(this.isButtonInCoordinates("screenLostConnection","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenLostConnection","btnRefresh"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnRefresh"
                        });
                     }
                     break;
                  case "screenHelp":
                     _loc3_ = this.screenHelp.cancelFingerWheeling;
                     if(this.isButtonInCoordinates("screenHelp","btnWiki"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnWiki"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenHelp","btnReplay"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnReplay"
                        });
                     }
                     break;
                  case "screenProfileInfo":
                     if(this.isButtonInCoordinates("screenProfileInfo","btnChangeName"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnChangeName"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileInfo","btnSendTokensToPlayer"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSendTokensToPlayer"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileInfo","btnAdminTools"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAdminTools"
                        });
                     }
                     break;
                  case "screenProfileOptions":
                     if(this.isButtonInCoordinates("screenProfileOptions","btnBreathingOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBreathingOff"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnBreathingOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBreathingOn"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnLanguages"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLanguages"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnMusicOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnMusicOff"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnMusicOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnMusicOn"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnParticlesMinus"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnParticlesMinus"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnParticlesPlus"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnParticlesPlus"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnSoundOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSoundOff"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnSoundOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSoundOn"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnPushNotificationsOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPushNotificationsOff"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnPushNotificationsOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPushNotificationsOn"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnSeePerksOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSeePerksOn"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnSeePerksOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSeePerksOff"
                        });
                     }
                     break;
                  case "screenProfileAccounts":
                     if(this.isButtonInCoordinates("screenProfileAccounts","btnSuperMechsConnect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSuperMechsConnect"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileAccounts","btnGooglePlayConnect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnGooglePlayConnect"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileAccounts","btnFacebookConnect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnFacebookConnect"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileAccounts","btnSuperMechsDisconnect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSuperMechsDisconnect"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileAccounts","btnGooglePlayDisconnect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnGooglePlayDisconnect"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileAccounts","btnFacebookDisconnect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnFacebookDisconnect"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenProfileAccounts","btnLogout"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLogout"
                        });
                     }
                     break;
                  case "screenSendTokensToPlayer":
                     if(this.isButtonInCoordinates("screenSendTokensToPlayer","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenSendTokensToPlayer","btnSearchPlayer"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSearchPlayer"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenSendTokensToPlayer","btnSend"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSend"
                        });
                     }
                     break;
                  case "screenReplays":
                     _loc3_ = this.screenReplays.cancelFingerWheeling;
                     if(this.isButtonInCoordinates("screenReplays","btnPlay"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPlay"
                        });
                     }
                     break;
                  case "screenAchievements":
                     _loc3_ = this.screenAchievements.cancelFingerWheeling;
                     if(this.isButtonInCoordinates("screenAchievements","btnSinglePlayer"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSinglePlayer"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenAchievements","btnMultiplayer"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnMultiplayer"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenAchievements","btnGoogleAchievements"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnGoogleAchievements"
                        });
                     }
                     break;
                  case "screenNews":
                     _loc3_ = this.screenNews.cancelFingerWheeling;
                     if(this.isButtonInCoordinates("screenNews","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenNews","btnPrevious"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPrevious"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenNews","btnNext"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnNext"
                        });
                     }
                     break;
                  case "screenChangeMechsOrder":
                     if(this.isButtonInCoordinates("screenChangeMechsOrder","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     this.screenChangeMechsOrder.mechsMouseUpSub();
                     break;
                  case "screenHangerInventory":
                     if(draggingM.item != null)
                     {
                        if(this.isSpriteInCoordinates(this.screenHangerInventory.mcFingerWheelingHitArea))
                        {
                           this.screenHangerInventory.inventoryBackgroundMouseUp();
                        }
                     }
                     else if(this.isButtonInCoordinates("screenHangerInventory","btnItemsLeft"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnItemsLeft"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenHangerInventory","btnItemsRight"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnItemsRight"
                        });
                     }
                     else
                     {
                        _loc1_ = 1;
                        while(_loc1_ <= this.screenHangerInventory.ITEM_TYPE_BUTTONS)
                        {
                           if(this.isButtonInCoordinates("screenHangerInventory","btnItemType" + _loc1_))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnItemType" + _loc1_
                              });
                              _loc1_ = this.screenHangerInventory.ITEM_TYPE_BUTTONS + 1;
                           }
                           _loc1_++;
                        }
                     }
                     break;
                  case "screenHangerShop":
                     if(this.isButtonInCoordinates("screenHangerShop","btnItemsLeft"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnItemsLeft"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenHangerShop","btnItemsRight"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnItemsRight"
                        });
                     }
                     break;
                  case "screenBuyItem":
                     if(this.isButtonInCoordinates("screenBuyItem","btnBuy"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBuy"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnCancel"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCancel"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnBack0"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack0"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnBack1"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack1"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnBack2"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack2"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnBack3"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack3"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnBack4"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack4"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnBack5"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack5"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnPlus"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPlus"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnMinus"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnMinus"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnGetCredits"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnGetCredits"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnGetTokens"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnGetTokens"
                        });
                     }
                     break;
                  case "screenBuyItemBox":
                     if(this.isButtonInCoordinates("screenBuyItemBox","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyItemBox","btnBuy"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBuy"
                        });
                     }
                     break;
                  case "screenHangerFusion":
                     _loc3_ = this.screenHangerFusion.cancelFingerWheeling;
                     if(this.isButtonInCoordinates("screenHangerFusion","btnActivate"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnActivate"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenHangerFusion","btnCraftMythicals"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCraftMythicals"
                        });
                     }
                     else if(this.isSpriteInCoordinates(this.screenHangerFusion.mcFingerWheelingHitArea))
                     {
                        _loc3_ = this.screenHangerFusion.tryToAddItem;
                        _loc4_.push(true,false);
                     }
                     else if(this.isSpriteInCoordinates(this.screenHangerFusion.targetHitArea))
                     {
                        _loc3_ = this.screenHangerFusion.targetHitAreaMouseUpSub;
                     }
                     else if(this.isSpriteInCoordinates(this.screenHangerFusion.generalHitArea))
                     {
                        _loc3_ = this.screenHangerFusion.tryToAddItem;
                        _loc4_.push(false,false);
                     }
                     break;
                  case "screenCraftMythicals":
                     if(this.isButtonInCoordinates("screenCraftMythicals","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenCraftMythicals","btnCraft"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCraft"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_torso"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnType_torso"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_leg"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnType_leg"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_sideWeapon"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnType_sideWeapon"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_topWeapon"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnType_topWeapon"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_special"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnType_special"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_module"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnType_module"
                        });
                     }
                     break;
                  case "screenOpeningSequence":
                     break;
                  case "screenMythicalCrafted":
                     if(this.isButtonInCoordinates("screenMythicalCrafted","btnClose"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClose"
                        });
                     }
                     break;
                  case "screenHangerInsertGiftKey":
                     if(this.isButtonInCoordinates("screenHangerInsertGiftKey","btnInsertKey"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnInsertKey"
                        });
                     }
                     break;
                  case "screenHangerGiftKeys":
                     if(this.isButtonInCoordinates("screenHangerGiftKeys","btnCopy1"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCopy1"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenHangerGiftKeys","btnCopy2"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCopy2"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenHangerGiftKeys","btnCopy3"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCopy3"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenHangerGiftKeys","btnClaim1"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClaim1"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenHangerGiftKeys","btnClaim2"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClaim2"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenHangerGiftKeys","btnClaim3"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClaim3"
                        });
                     }
                     break;
                  case "screenSelectBattleMechsPerPlayer":
                     if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenSelectBattleMechsPerPlayer","btn1V1"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btn1V1"
                        });
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenSelectBattleMechsPerPlayer","btn2V2"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btn2V2"
                        });
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenSelectBattleMechsPerPlayer","btn3V3"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btn3V3"
                        });
                     }
                     break;
                  case "screenMenuMultiPlayerInspect":
                     if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnSendBattleInvitation"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSendBattleInvitation"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnAcceptBattleInvitation"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAcceptBattleInvitation"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnDeclineBattleInvitation"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnDeclineBattleInvitation"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnBlock"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBlock"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnUnBlock"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnUnBlock"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnChat"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnChat"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnInspect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnInspect"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnClose"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClose"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnAcceptClanInvitation"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAcceptClanInvitation"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnDeclineClanInvitation"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnDeclineClanInvitation"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnSendClanInvitation"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSendClanInvitation"
                        });
                     }
                     break;
                  case "screenMultiPlayerLadder":
                     if(this.isButtonInCoordinates("screenMultiPlayerLadder","btnSearchForBattle"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSearchForBattle"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerLadder","btnCancelSearch"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCancelSearch"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerLadder","btnChatRoom"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnChatRoom"
                        });
                     }
                     break;
                  case "screenMultiPlayerChat":
                     _loc3_ = this.screenMultiPlayerChat.cancelFingerWheeling;
                     if(this.isButtonInCoordinates("screenMultiPlayerChat","btnBackToLadder"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBackToLadder"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerChat","btnChannelsList"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnChannelsList"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerChat","btnSearchForPlayer"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSearchForPlayer"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerChat","btnSendMessage"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSendMessage"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerChat","btnBattleInvitationsEnabled"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBattleInvitationsEnabled"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerChat","btnBattleInvitationsDisabled"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBattleInvitationsDisabled"
                        });
                     }
                     break;
                  case "screenSearchForPlayer":
                     _loc3_ = this.screenSearchForPlayer.cancelFingerWheeling;
                     if(this.isButtonInCoordinates("screenSearchForPlayer","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenSearchForPlayer","btnSearch"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSearch"
                        });
                     }
                     break;
                  case "screenClan":
                     _loc3_ = this.screenClan.cancelFingerWheeling;
                     if(this.isButtonInCoordinates("screenClan","btnAcceptRequest"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAcceptRequest"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenClan","btnDeclineRequest"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnDeclineRequest"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenClan","btnInspect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnInspect"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenClan","btnKickMember"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnKickMember"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenClan","btnLeaveClan"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLeaveClan"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenClan","btnChat"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnChat"
                        });
                     }
                     break;
                  case "screenClanFlag":
                     if(this.isButtonInCoordinates("screenClanFlag","btnRandom"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnRandom"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenClanFlag","btnColorNext"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnColorNext"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenClanFlag","btnColorPrevious"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnColorPrevious"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenClanFlag","btnShapeNext"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnShapeNext"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenClanFlag","btnShapePrevious"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnShapePrevious"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenClanFlag","btnTypeNext"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnTypeNext"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenClanFlag","btnTypePrevious"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnTypePrevious"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenClanFlag","btnSave"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSave"
                        });
                     }
                     break;
                  case "screenBuyBattleCredits":
                     if(this.isButtonInCoordinates("screenBuyBattleCredits","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyBattleCredits","btnBuy1"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBuy1"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyBattleCredits","btnBuy6"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBuy6"
                        });
                     }
                     break;
                  case "screenBuyBattleCreditsWithVideo":
                     if(this.isButtonInCoordinates("screenBuyBattleCreditsWithVideo","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyBattleCreditsWithVideo","btnBuy1"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBuy1"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyBattleCreditsWithVideo","btnBuy6"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBuy6"
                        });
                     }
                     break;
                  case "screenWelcomeNewExisting":
                     if(this.isButtonInCoordinates("screenWelcomeNewExisting","btnNewPlayer"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnNewPlayer"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeNewExisting","btnExistingPlayer"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnExistingPlayer"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeNewExisting","btnAlreadyHasAccount"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAlreadyHasAccount"
                        });
                     }
                     break;
                  case "screenWelcomeLogin":
                     if(this.isButtonInCoordinates("screenWelcomeLogin","btnLogin"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLogin"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeLogin","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeLogin","btnRegister"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnRegister"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeLogin","btnFacebookLogin"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnFacebookLogin"
                        });
                     }
                     break;
                  case "screenWelcomeLoginAs":
                     if(this.isButtonInCoordinates("screenWelcomeLoginAs","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeLoginAs","btnSuperMechs"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSuperMechs"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeLoginAs","btnGooglePlay"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnGooglePlay"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeLoginAs","btnITunes"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnITunes"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeLoginAs","btnFacebook"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnFacebook"
                        });
                     }
                     break;
                  case "screenWelcomeBackground":
                     if(this.isButtonInCoordinates("screenWelcomeBackground","btnLanguages"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLanguages"
                        });
                     }
                     break;
                  case "screenChangeName":
                     if(this.isButtonInCoordinates("screenChangeName","btnCancel"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCancel"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenChangeName","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenChangeName","btnChange"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnChange"
                        });
                     }
                     break;
                  case "screenAdminTools":
                     if(this.isButtonInCoordinates("screenAdminTools","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenAdminTools","btnActivateReset"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnActivateReset"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenAdminTools","btnUpdateBoost"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnUpdateBoost"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenAdminTools","btnResetRateBox"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnResetRateBox"
                        });
                     }
                     break;
                  case "screenSpecialOffers":
                     if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenSpecialOffers","btnBuy"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBuy"
                        });
                     }
                     break;
                  case "screenMissionWorldMap":
                     if(this.isButtonInCoordinates("screenMissionWorldMap","btnGoToHighestMission"))
                     {
                        _loc6_.push({
                           "screen":"screenMissionWorldMap",
                           "button":"btnGoToHighestMission"
                        });
                     }
                     break;
                  case "screenMissionWorldMapInterface":
                     if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenMissionWorldMapInterface","btnGoToHighestMission"))
                     {
                        _loc6_.push({
                           "screen":"screenMissionWorldMapInterface",
                           "button":"btnGoToHighestMission"
                        });
                     }
                     break;
                  case "screenBuyAnotherItemBox":
                     if(this.isButtonInCoordinates("screenBuyAnotherItemBox","btnBack"))
                     {
                        _loc6_.push({
                           "screen":"screenBuyAnotherItemBox",
                           "button":"btnBack"
                        });
                     }
                     break;
                  case "screenBuyMissions":
                     if(this.isButtonInCoordinates("screenBuyMissions","btnBack"))
                     {
                        _loc6_.push({
                           "screen":"screenBuyMissions",
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyMissions","btnBuy1"))
                     {
                        _loc6_.push({
                           "screen":"screenBuyMissions",
                           "button":"btnBuy1"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenBuyMissions","btnBuy6"))
                     {
                        _loc6_.push({
                           "screen":"screenBuyMissions",
                           "button":"btnBuy6"
                        });
                     }
                     break;
                  case "screenMissionBaseMap":
                     if(this.isButtonInCoordinates("screenMissionBaseMap","btnAbort"))
                     {
                        _loc6_.push({
                           "screen":"screenMissionBaseMap",
                           "button":"btnAbort"
                        });
                     }
                     break;
                  case "screenMissionCompleted":
                     if(this.isButtonInCoordinates("screenMissionCompleted","btnClose"))
                     {
                        _loc6_.push({
                           "screen":"screenMissionCompleted",
                           "button":"btnClose"
                        });
                     }
                     break;
                  case "screenRegisterOffer":
                     if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenRegisterOffer","btnRegister"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnRegister"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenRegisterOffer","btnFacebookLogin"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnFacebookLogin"
                        });
                     }
                     break;
                  case "screenWorldMapSelectBattle":
                     if(this.isButtonInCoordinates("screenWorldMapSelectBattle","btnBattle"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBattle"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenWorldMapSelectBattle","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     break;
                  case "screenRankingList":
                     _loc3_ = this.screenRankingList.cancelFingerWheeling;
                     if(this.isButtonInCoordinates("screenRankingList","btnPlayers"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPlayers"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenRankingList","btnClans"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClans"
                        });
                     }
                     break;
                  case "screenSearchForClan":
                     _loc3_ = this.screenSearchForClan.cancelFingerWheeling;
                     if(this.isButtonInCoordinates("screenSearchForClan","btnClanCreate"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClanCreate"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenSearchForClan","btnClanSearch"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClanSearch"
                        });
                     }
                     break;
                  case "screenWatchRewardedVideo":
                     if(this.isButtonInCoordinates("screenWatchRewardedVideo","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     break;
                  case "screenLanguageSelection":
                     if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang1"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLang1"
                        });
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang3"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLang3"
                        });
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang4"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLang4"
                        });
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang5"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLang5"
                        });
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang7"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLang7"
                        });
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang9"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLang9"
                        });
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang10"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLang10"
                        });
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang20"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLang20"
                        });
                     }
                     break;
                  case "screenReconnecting":
                     break;
                  case "screenYouTubeVidsGuide":
                     if(this.isButtonInCoordinates("screenYouTubeVidsGuide","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     break;
                  case "screenSelectAccount":
                     break;
                  case "screenClanCreate":
                     if(this.isButtonInCoordinates("screenClanCreate","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenClanCreate","btnCreate"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCreate"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenClanCreate","btnCancel"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCancel"
                        });
                     }
                     break;
                  case "screenInspectPlayer":
                     _loc3_ = this.screenInspectPlayer.cancelFingerWheeling;
                     if(this.isButtonInCoordinates("screenInspectPlayer","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnPreviousMech"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPreviousMech"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnNextMech"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnNextMech"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnUp"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnUp"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnDown"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnDown"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnMechs"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnMechs"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnReplays"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnReplays"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnAchievements"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAchievements"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnClan"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClan"
                        });
                     }
                     this.screenInspectPlayer.generalTooltipMouseOutSub();
                     break;
                  case "screenRegister":
                     if(this.isButtonInCoordinates("screenRegister","btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenRegister","btnRegister"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnRegister"
                        });
                     }
                     else if(this.isButtonInCoordinates("screenRegister","btnCopyName"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCopyName"
                        });
                     }
               }
               _loc7_++;
            }
            _loc1_ = 0;
            while(_loc1_ < _loc6_.length)
            {
               _loc12_ = _loc6_[_loc1_];
               this[_loc12_.screen][_loc12_.button].buttonCore.hitAreaMouseUpSub();
               _loc1_++;
            }
            if(_loc3_ != null)
            {
               if(_loc4_.length == 0)
               {
                  _loc3_();
               }
               else if(_loc4_.length == 1)
               {
                  _loc3_(_loc4_[0]);
               }
               else if(_loc4_.length == 2)
               {
                  _loc3_(_loc4_[0],_loc4_[1]);
               }
            }
            if(this.isScreenOpened("screenHangerMenu"))
            {
               this.screenHangerMenu.stageMouseUpSub();
            }
         }
         this.resetMobileToolTipActivation(true);
      }
      
      private function mouseClickDetector(param1:MouseEvent) : void
      {
         var _loc2_:Function = null;
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:BMButtonBattle = null;
         var _loc11_:Boolean = false;
         var _loc12_:BMMultiplayerLadderChatAlert = null;
         if(this.disableNextClickForMobile)
         {
            this.disableNextClickForMobile = false;
         }
         else if(this.screenBlack.isActive() == false)
         {
            _loc2_ = null;
            _loc3_ = new Array();
            _loc6_ = this.getTargetScreens();
            if(this.btnDebugger.buttonCore.isButtonEnabled() && this.btnDebugger.visible)
            {
               if(this.btnDebugger.x <= mouseX && this.btnDebugger.x + this.btnDebugger.width >= mouseX)
               {
                  if(this.btnDebugger.y <= mouseY && this.btnDebugger.y + this.btnDebugger.height >= mouseY)
                  {
                     this.debuggerClicked();
                  }
               }
            }
            _loc7_ = 0;
            while(_loc7_ < _loc6_.length)
            {
               switch(_loc6_[_loc7_])
               {
                  case "screenDebugger":
                     if(this.isButtonInCoordinates("screenDebugger","btnClear"))
                     {
                        _loc2_ = this.screenDebugger.clearClicked;
                     }
                     else if(this.isButtonInCoordinates("screenDebugger","btnClose"))
                     {
                        _loc2_ = this.screenDebugger.closeClicked;
                     }
                     break;
                  case "screenConfirmation":
                     if(this.isButtonInCoordinates("screenConfirmation","btnLater") || this.isButtonInCoordinates("screenConfirmation","btnCancel") || this.isButtonInCoordinates("screenConfirmation","btnCancelOnly") || this.isButtonInCoordinates("screenConfirmation","btnCancelSmall"))
                     {
                        _loc2_ = this.screenConfirmation.cancelClicked;
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnConfirm") || this.isButtonInCoordinates("screenConfirmation","btnOKOnly"))
                     {
                        _loc2_ = this.screenConfirmation.confirmClicked;
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnRegister"))
                     {
                        _loc2_ = this.screenConfirmation.registerClicked;
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnHanger"))
                     {
                        _loc2_ = this.screenConfirmation.hangerClicked;
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnAppStore"))
                     {
                        _loc2_ = this.screenConfirmation.appStoreClicked;
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnGetCredits"))
                     {
                        _loc2_ = this.screenConfirmation.getCreditsClicked;
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnGetTokens"))
                     {
                        _loc2_ = this.screenConfirmation.getTokensClicked;
                     }
                     else if(this.isButtonInCoordinates("screenConfirmation","btnSuperMechs"))
                     {
                        _loc2_ = this.screenConfirmation.superMechsClicked;
                     }
                     else if(this.screenConfirmation.mcVMouseHitArea.visible && this.isSpriteInCoordinates(this.screenConfirmation.mcVMouseHitArea))
                     {
                        this.screenConfirmation.acceptTermsOfUseClickedSub();
                     }
                     else if(this.isSpriteInCoordinates(this.screenConfirmation.mcTermsOfUseLinkHitArea1))
                     {
                        _loc2_ = this.screenRegister.termsOfUseLinkClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenConfirmation.mcTermsOfUseLinkHitArea2))
                     {
                        _loc2_ = this.screenRegister.termsOfUseLinkClicked;
                     }
                     break;
                  case "screenDebugger":
                     if(this.isButtonInCoordinates("screenDebugger","btnClose"))
                     {
                        _loc2_ = this.screenDebugger.closeClicked;
                     }
                     else if(this.isButtonInCoordinates("screenDebugger","btnClear"))
                     {
                        _loc2_ = this.screenDebugger.clearClicked;
                     }
                     break;
                  case "screenGlobalShop":
                     if(this.isButtonInCoordinates("screenGlobalShop","btnBack"))
                     {
                        _loc2_ = this.screenGlobalShop.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenGlobalShop","btnClose"))
                     {
                        _loc2_ = this.screenGlobalShop.closeClicked;
                     }
                     else if(this.isButtonInCoordinates("screenGlobalShop","btnBuyTokens"))
                     {
                        _loc2_ = this.screenGlobalShop.buyTokensClicked;
                     }
                     else if(this.isButtonInCoordinates("screenGlobalShop","btnBuyGold"))
                     {
                        _loc2_ = this.screenGlobalShop.buyGoldClicked;
                     }
                     else if(this.screenGlobalShop.isCategoriesOpen)
                     {
                        _loc4_ = 0;
                        while(_loc4_ < BMScreenGlobalShop.NUM_OF_CATEGORIES)
                        {
                           if(this.isMovieClipInCoordinates(this.screenGlobalShop["mcCategory" + _loc4_],0,0))
                           {
                              _loc2_ = this.screenGlobalShop.onCategoryClickSub;
                              _loc3_.push(_loc4_);
                              break;
                           }
                           _loc4_++;
                        }
                     }
                     else if(this.isSpriteInCoordinates(this.screenGlobalShop.mcFingerWheeling))
                     {
                        _loc2_ = this.screenGlobalShop.scrollerClicked;
                     }
                     break;
                  case "screenBuyGold":
                     if(this.isButtonInCoordinates("screenBuyGold","btnBack"))
                     {
                        _loc2_ = this.screenBuyGold.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyGold","btnBuy"))
                     {
                        _loc2_ = this.screenBuyGold.buyClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyGold","btnGetTokens"))
                     {
                        _loc2_ = this.screenBuyGold.getTokensClicked;
                     }
                     break;
                  case "screenBuyStarterPack":
                     if(this.isButtonInCoordinates("screenBuyStarterPack","btnBackOrange"))
                     {
                        _loc2_ = this.screenBuyStarterPack.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyStarterPack","btnBackRed"))
                     {
                        _loc2_ = this.screenBuyStarterPack.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyStarterPack","btnBuyOrange"))
                     {
                        _loc2_ = this.screenBuyStarterPack.buyClicked;
                     }
                     break;
                  case "screenBattleOptions":
                     if(this.isButtonInCoordinates("screenBattleOptions","btnBreathingOn"))
                     {
                        _loc2_ = this.screenBattleOptions.breathingOnClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnBreathingOff"))
                     {
                        _loc2_ = this.screenBattleOptions.breathingOffClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnParticlesMinus"))
                     {
                        _loc2_ = this.screenBattleOptions.particlesMinusClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnParticlesPlus"))
                     {
                        _loc2_ = this.screenBattleOptions.particlesPlusClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnMusicOn"))
                     {
                        _loc2_ = this.screenBattleOptions.musicOnClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnMusicOff"))
                     {
                        _loc2_ = this.screenBattleOptions.musicOffClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnSoundOn"))
                     {
                        _loc2_ = this.screenBattleOptions.soundOnClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnSoundOff"))
                     {
                        _loc2_ = this.screenBattleOptions.soundOffClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnBack"))
                     {
                        _loc2_ = this.screenBattleOptions.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnPerformanceFrame"))
                     {
                        _loc2_ = this.screenBattleOptions.performanceClicked;
                        _loc3_.push("frame");
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnPerformanceTimer1"))
                     {
                        _loc2_ = this.screenBattleOptions.performanceClicked;
                        _loc3_.push("timer1");
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnPerformanceTimer2"))
                     {
                        _loc2_ = this.screenBattleOptions.performanceClicked;
                        _loc3_.push("timer2");
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnPerformanceTimer3"))
                     {
                        _loc2_ = this.screenBattleOptions.performanceClicked;
                        _loc3_.push("timer3");
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnPerformanceTimer10"))
                     {
                        _loc2_ = this.screenBattleOptions.performanceClicked;
                        _loc3_.push("timer10");
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnSlowCPUOff"))
                     {
                        _loc2_ = this.screenBattleOptions.performanceClicked;
                        _loc3_.push("slowOff");
                     }
                     else if(this.isButtonInCoordinates("screenBattleOptions","btnSlowCPUOn"))
                     {
                        _loc2_ = this.screenBattleOptions.performanceClicked;
                        _loc3_.push("slowOn");
                     }
                     break;
                  case "screenRegister":
                     if(this.isButtonInCoordinates("screenRegister","btnBack"))
                     {
                        _loc2_ = this.screenRegister.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenRegister","btnRegister"))
                     {
                        _loc2_ = this.screenRegister.registerClicked;
                     }
                     else if(this.isButtonInCoordinates("screenRegister","btnCopyName"))
                     {
                        _loc2_ = this.screenRegister.copyNameClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenRegister.mcVMouseHitArea))
                     {
                        _loc2_ = this.screenRegister.acceptTermsOfUseClickedSub;
                     }
                     else if(this.isSpriteInCoordinates(this.screenRegister.mcTermsOfUseLinkHitArea1))
                     {
                        _loc2_ = this.screenRegister.termsOfUseLinkClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenRegister.mcTermsOfUseLinkHitArea2))
                     {
                        _loc2_ = this.screenRegister.termsOfUseLinkClicked;
                     }
                     break;
                  case "screenPopUp":
                     if(this.isButtonInCoordinates("screenPopUp","btnOK"))
                     {
                        _loc2_ = this.screenPopUp.OKClicked;
                     }
                     else if(this.isButtonInCoordinates("screenPopUp","btnFacebookPublish"))
                     {
                        _loc2_ = this.screenPopUp.facebookPublishClicked;
                     }
                     break;
                  case "screenLevelUp":
                     if(this.isButtonInCoordinates("screenLevelUp","btnOK"))
                     {
                        _loc2_ = this.screenLevelUp.OKClicked;
                     }
                     break;
                  case "screenReplays":
                     if(this.isButtonInCoordinates("screenReplays","btnPlay"))
                     {
                        _loc2_ = this.screenReplays.playClicked;
                     }
                     break;
                  case "screenAchievements":
                     if(this.isButtonInCoordinates("screenAchievements","btnSinglePlayer"))
                     {
                        _loc2_ = this.screenAchievements.singlePlayerClicked;
                     }
                     else if(this.isButtonInCoordinates("screenAchievements","btnMultiplayer"))
                     {
                        _loc2_ = this.screenAchievements.multiplayerClicked;
                     }
                     else if(this.isButtonInCoordinates("screenAchievements","btnGoogleAchievements"))
                     {
                        _loc2_ = this.screenAchievements.googleAchievementsClicked;
                     }
                     break;
                  case "screenTopBar":
                     if(mouseY <= 45)
                     {
                        if(this.screenTopBar.canClickOnButton())
                        {
                           if(this.isButtonInCoordinates("screenTopBar","btnGetGold"))
                           {
                              _loc2_ = this.screenTopBar.getGoldClicked;
                           }
                           else if(this.isButtonInCoordinates("screenTopBar","btnGetTokens"))
                           {
                              _loc2_ = this.screenTopBar.getTokensClicked;
                           }
                        }
                     }
                     break;
                  case "screenTopBarNew":
                     if(mouseY <= 45)
                     {
                        if(this.screenTopBarNew.canClickOnButton())
                        {
                           if(this.isButtonInCoordinates("screenTopBarNew","btnGetGold"))
                           {
                              _loc2_ = this.screenTopBarNew.getGoldClicked;
                           }
                           else if(this.isButtonInCoordinates("screenTopBarNew","btnGetTokens"))
                           {
                              _loc2_ = this.screenTopBarNew.getTokensClicked;
                           }
                        }
                     }
                     break;
                  case "screenNews":
                     if(this.isButtonInCoordinates("screenNews","btnBack"))
                     {
                        _loc2_ = this.screenNews.backClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenNews.mcSpecialSaleHitArea))
                     {
                        _loc2_ = this.screenNews.specialSaleClickedSub;
                     }
                     else if(this.isButtonInCoordinates("screenNews","btnPrevious"))
                     {
                        _loc2_ = this.screenNews.previousClicked;
                     }
                     else if(this.isButtonInCoordinates("screenNews","btnNext"))
                     {
                        _loc2_ = this.screenNews.nextClicked;
                     }
                     break;
                  case "screenWelcomeNewExisting":
                     if(this.isButtonInCoordinates("screenWelcomeNewExisting","btnNewPlayer"))
                     {
                        _loc2_ = this.screenWelcomeNewExisting.newPlayerClicked;
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeNewExisting","btnExistingPlayer"))
                     {
                        _loc2_ = this.screenWelcomeNewExisting.existingPlayerClicked;
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeNewExisting","btnAlreadyHasAccount"))
                     {
                        _loc2_ = this.screenWelcomeNewExisting.alreadyHasAccountClicked;
                     }
                     break;
                  case "screenWelcomeLogin":
                     if(this.isButtonInCoordinates("screenWelcomeLogin","btnLogin"))
                     {
                        _loc2_ = this.screenWelcomeLogin.loginClicked;
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeLogin","btnBack"))
                     {
                        _loc2_ = this.screenWelcomeLogin.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeLogin","btnRegister"))
                     {
                        _loc2_ = this.screenWelcomeLogin.registerClicked;
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeLogin","btnFacebookLogin"))
                     {
                        _loc2_ = this.screenWelcomeLogin.facebookLoginClicked;
                     }
                     else if(this.isTextFieldInCoordinates(this.screenWelcomeLogin.txtForgotPassword,0,0))
                     {
                        _loc2_ = this.screenWelcomeLogin.forgotPasswordClickedSub;
                     }
                     else if(this.isSpriteInCoordinates(this.screenWelcomeLogin.mcForgotPasswordHitArea))
                     {
                        _loc2_ = this.screenWelcomeLogin.forgotPasswordClickedSub;
                     }
                     break;
                  case "screenWelcomeLoginAs":
                     if(this.isButtonInCoordinates("screenWelcomeLoginAs","btnBack"))
                     {
                        _loc2_ = this.screenWelcomeLoginAs.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeLoginAs","btnSuperMechs"))
                     {
                        _loc2_ = this.screenWelcomeLoginAs.superMechsClicked;
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeLoginAs","btnGooglePlay"))
                     {
                        _loc2_ = this.screenWelcomeLoginAs.googlePlayClicked;
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeLoginAs","btnITunes"))
                     {
                        _loc2_ = this.screenWelcomeLoginAs.itunesClicked;
                     }
                     else if(this.isButtonInCoordinates("screenWelcomeLoginAs","btnFacebook"))
                     {
                        _loc2_ = this.screenWelcomeLoginAs.facebookClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenWelcomeLoginAs.mcContactSupportHitArea))
                     {
                        _loc2_ = this.screenWelcomeLoginAs.contactSupportClickedSub;
                     }
                     break;
                  case "screenWelcomeBackground":
                     if(this.isButtonInCoordinates("screenWelcomeBackground","btnLanguages"))
                     {
                        _loc2_ = this.screenWelcomeBackground.languagesClicked;
                     }
                     break;
                  case "screenChangeName":
                     if(this.isButtonInCoordinates("screenChangeName","btnBack"))
                     {
                        _loc2_ = this.screenChangeName.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenChangeName","btnCancel"))
                     {
                        _loc2_ = this.screenChangeName.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenChangeName","btnChange"))
                     {
                        _loc2_ = this.screenChangeName.changeClicked;
                     }
                     break;
                  case "screenAdminTools":
                     if(this.isButtonInCoordinates("screenAdminTools","btnBack"))
                     {
                        _loc2_ = this.screenAdminTools.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenAdminTools","btnActivateReset"))
                     {
                        _loc2_ = this.screenAdminTools.activateResetClicked;
                     }
                     else if(this.isButtonInCoordinates("screenAdminTools","btnUpdateBoost"))
                     {
                        _loc2_ = this.screenAdminTools.updateBoostClicked;
                     }
                     else if(this.isButtonInCoordinates("screenAdminTools","btnResetRateBox"))
                     {
                        _loc2_ = this.screenAdminTools.resetRateBoxClicked;
                     }
                     break;
                  case "screenSpecialOffers":
                     if(this.isSpriteInCoordinates(this.screenSpecialOffers.mcSpecialSalesHitArea,this.screenSpecialOffers.x,this.screenSpecialOffers.y))
                     {
                        _loc2_ = this.screenSpecialOffers.specialSaleHitAreaClickedSub;
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenSpecialOffers","btnBuy"))
                     {
                        _loc2_ = this.screenSpecialOffers.buyClicked;
                     }
                     break;
                  case "screenMissionWorldMap":
                     if(this.isButtonInCoordinates("screenMissionWorldMap","btnGoToHighestMission"))
                     {
                        _loc2_ = this.screenMissionWorldMap.goToHighestMission;
                     }
                     else if(this.isButtonInCoordinates("screenMissionWorldMap","btnBack"))
                     {
                        _loc2_ = this.screenMissionWorldMap.backClicked;
                     }
                     break;
                  case "screenMissionWorldMapInterface":
                     if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenMissionWorldMapInterface","btnGoToHighestMission"))
                     {
                        _loc2_ = this.screenMissionWorldMap.goToHighestMission;
                     }
                     break;
                  case "screenBuyAnotherItemBox":
                     if(this.isButtonInCoordinates("screenBuyAnotherItemBox","btnBack"))
                     {
                        _loc2_ = this.screenBuyAnotherItemBox.backClicked;
                     }
                     else if(this.screenBuyAnotherItemBox.packagesTileList != null)
                     {
                        if(this.screenBuyAnotherItemBox.packagesTileList.getAllTileListItemIDs().length == 2)
                        {
                           if(this.isTileListItemInCoordinates(this.screenBuyAnotherItemBox.packagesTileList.findTileListItemByTileListItemID(5),this.screenBuyAnotherItemBox.packagesTileList.x,this.screenBuyAnotherItemBox.packagesTileList.y))
                           {
                              this.screenBuyAnotherItemBox.packageClickedSub(5);
                           }
                           else if(this.isTileListItemInCoordinates(this.screenBuyAnotherItemBox.packagesTileList.findTileListItemByTileListItemID(6),this.screenBuyAnotherItemBox.packagesTileList.x,this.screenBuyAnotherItemBox.packagesTileList.y))
                           {
                              this.screenBuyAnotherItemBox.packageClickedSub(6);
                           }
                        }
                     }
                     break;
                  case "screenBuyMissions":
                     if(this.isButtonInCoordinates("screenBuyMissions","btnBack"))
                     {
                        _loc2_ = this.screenBuyMissions.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyMissions","btnBuy1"))
                     {
                        _loc2_ = this.screenBuyMissions.buy1Clicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyMissions","btnBuy6"))
                     {
                        _loc2_ = this.screenBuyMissions.buy6Clicked;
                     }
                     break;
                  case "screenMissionBaseMap":
                     if(this.isSpriteInCoordinates(this.screenMissionBaseMap.mcMapHitArea))
                     {
                        _loc2_ = this.screenMissionBaseMap.mapHitAreaClickedSub;
                        _loc3_.push(true);
                     }
                     else if(this.isSpriteInCoordinates(this.screenMissionBaseMap.mcPickupsMouseHitArea))
                     {
                        _loc2_ = this.screenMissionBaseMap.upgradesClickedSub;
                     }
                     else if(this.isButtonInCoordinates("screenMissionBaseMap","btnAbort"))
                     {
                        _loc2_ = this.screenMissionBaseMap.abortClicked;
                     }
                     break;
                  case "screenMissionCompleted":
                     if(this.isButtonInCoordinates("screenMissionCompleted","btnClose"))
                     {
                        _loc2_ = this.screenMissionCompleted.closeClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenMissionCompleted.mcMouseHitArea))
                     {
                        _loc2_ = this.screenMissionCompleted.hitAreaClickedSub;
                     }
                     break;
                  case "screenRegisterOffer":
                     if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenRegisterOffer","btnRegister"))
                     {
                        _loc2_ = this.screenRegisterOffer.registerClicked;
                     }
                     else if(this.isButtonInCoordinates("screenRegisterOffer","btnFacebookLogin"))
                     {
                        _loc2_ = this.screenRegisterOffer.facebookLoginClicked;
                     }
                     break;
                  case "screenWorldMapSelectBattle":
                     if(this.isButtonInCoordinates("screenWorldMapSelectBattle","btnBattle"))
                     {
                        _loc2_ = this.screenWorldMapSelectBattle.battleClicked;
                     }
                     else if(this.isButtonInCoordinates("screenWorldMapSelectBattle","btnBack"))
                     {
                        _loc2_ = this.screenWorldMapSelectBattle.backClicked;
                     }
                     break;
                  case "screenHangerMenu":
                     if(this.isButtonInCoordinates("screenHangerMenu","btnMech"))
                     {
                        _loc2_ = this.screenHangerMenu.mechClicked;
                     }
                     else if(this.isButtonInCoordinates("screenHangerMenu","btnFusion"))
                     {
                        _loc2_ = this.screenHangerMenu.fusionClicked;
                     }
                     else if(this.isButtonInCoordinates("screenHangerMenu","btnBack"))
                     {
                        _loc2_ = this.screenHangerMenu.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenHangerMenu","btnChangeMechsOrder"))
                     {
                        _loc2_ = this.screenHangerMenu.changeMechsOrderClicked;
                     }
                     break;
                  case "screenChangeMechsOrder":
                     if(this.isButtonInCoordinates("screenChangeMechsOrder","btnBack"))
                     {
                        _loc2_ = this.screenChangeMechsOrder.backClicked;
                     }
                     break;
                  case "screenHangerInventory":
                     if(draggingM.item == null)
                     {
                        if(this.isButtonInCoordinates("screenHangerInventory","btnItemsLeft"))
                        {
                           _loc2_ = this.screenHangerInventory.itemsLeftClicked;
                        }
                        else if(this.isButtonInCoordinates("screenHangerInventory","btnItemsRight"))
                        {
                           _loc2_ = this.screenHangerInventory.itemsRightClicked;
                        }
                        else
                        {
                           _loc4_ = 1;
                           while(_loc4_ <= this.screenHangerInventory.ITEM_TYPE_BUTTONS)
                           {
                              if(this.isButtonInCoordinates("screenHangerInventory","btnItemType" + _loc4_))
                              {
                                 _loc2_ = this.screenHangerInventory.itemTypeClicked;
                                 _loc3_.push(_loc4_);
                                 _loc4_ = this.screenHangerInventory.ITEM_TYPE_BUTTONS + 1;
                              }
                              _loc4_++;
                           }
                        }
                     }
                     break;
                  case "screenBuyItem":
                     if(this.isButtonInCoordinates("screenBuyItem","btnBuy"))
                     {
                        _loc2_ = this.screenBuyItem.buyClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnCancel"))
                     {
                        _loc2_ = this.screenBuyItem.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnBack0"))
                     {
                        _loc2_ = this.screenBuyItem.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnBack1"))
                     {
                        _loc2_ = this.screenBuyItem.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnBack2"))
                     {
                        _loc2_ = this.screenBuyItem.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnBack3"))
                     {
                        _loc2_ = this.screenBuyItem.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnBack4"))
                     {
                        _loc2_ = this.screenBuyItem.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnBack5"))
                     {
                        _loc2_ = this.screenBuyItem.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnPlus"))
                     {
                        _loc2_ = this.screenBuyItem.plusClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnMinus"))
                     {
                        _loc2_ = this.screenBuyItem.minusClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnGetCredits"))
                     {
                        _loc2_ = this.screenBuyItem.getCreditsClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyItem","btnGetTokens"))
                     {
                        _loc2_ = this.screenBuyItem.getTokensClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenBuyItem.mcSizer_tooltipBox1))
                     {
                        if(this.screenBuyItem.getSpecialStatus() >= 3)
                        {
                           _loc2_ = this.screenBuyItem.boxClickedSub;
                           _loc3_.push(1);
                        }
                     }
                     else if(this.isSpriteInCoordinates(this.screenBuyItem.mcSizer_tooltipBox2))
                     {
                        if(this.screenBuyItem.getSpecialStatus() >= 3)
                        {
                           _loc2_ = this.screenBuyItem.boxClickedSub;
                           _loc3_.push(2);
                        }
                     }
                     else if(this.isSpriteInCoordinates(this.screenBuyItem.mcSizer_tooltipBox3))
                     {
                        if(this.screenBuyItem.getSpecialStatus() >= 3)
                        {
                           _loc2_ = this.screenBuyItem.boxClickedSub;
                           _loc3_.push(3);
                        }
                     }
                     break;
                  case "screenBuyItemBox":
                     if(this.isButtonInCoordinates("screenBuyItemBox","btnBack"))
                     {
                        _loc2_ = this.screenBuyItemBox.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyItemBox","btnBuy"))
                     {
                        _loc2_ = this.screenBuyItemBox.buyClicked;
                     }
                     break;
                  case "screenHangerMech":
                     if(this.isButtonInCoordinates("screenHangerMech","btnPreviousMech"))
                     {
                        _loc2_ = this.screenHangerMech.previousMechClicked;
                     }
                     else if(this.isButtonInCoordinates("screenHangerMech","btnNextMech"))
                     {
                        _loc2_ = this.screenHangerMech.nextMechClicked;
                     }
                     else if(this.isButtonInCoordinates("screenHangerMech","btnRedeemStarterPackMech"))
                     {
                        _loc2_ = this.screenHangerMech.redeemStarterPackMechClicked;
                     }
                     break;
                  case "screenHangerFusion":
                     if(this.isButtonInCoordinates("screenHangerFusion","btnActivate"))
                     {
                        _loc2_ = this.screenHangerFusion.activateClicked;
                     }
                     else if(this.isButtonInCoordinates("screenHangerFusion","btnCraftMythicals"))
                     {
                        _loc2_ = this.screenHangerFusion.craftMythicalsClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenHangerFusion.targetHitArea))
                     {
                        _loc2_ = this.screenHangerFusion.targetHitAreaClickSub;
                     }
                     break;
                  case "screenCraftMythicals":
                     if(this.isButtonInCoordinates("screenCraftMythicals","btnBack"))
                     {
                        _loc2_ = this.screenCraftMythicals.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenCraftMythicals","btnCraft"))
                     {
                        _loc2_ = this.screenCraftMythicals.craftClicked;
                     }
                     else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_torso"))
                     {
                        _loc2_ = this.screenCraftMythicals.typeClicked;
                        _loc3_.push("torso");
                     }
                     else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_leg"))
                     {
                        _loc2_ = this.screenCraftMythicals.typeClicked;
                        _loc3_.push("leg");
                     }
                     else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_sideWeapon"))
                     {
                        _loc2_ = this.screenCraftMythicals.typeClicked;
                        _loc3_.push("sideWeapon");
                     }
                     else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_topWeapon"))
                     {
                        _loc2_ = this.screenCraftMythicals.typeClicked;
                        _loc3_.push("topWeapon");
                     }
                     else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_special"))
                     {
                        _loc2_ = this.screenCraftMythicals.typeClicked;
                        _loc3_.push("special");
                     }
                     else if(this.isButtonInCoordinates("screenCraftMythicals","btnType_module"))
                     {
                        _loc2_ = this.screenCraftMythicals.typeClicked;
                        _loc3_.push("module");
                     }
                     break;
                  case "screenOpeningSequence":
                     break;
                  case "screenMythicalCrafted":
                     if(this.isButtonInCoordinates("screenMythicalCrafted","btnClose"))
                     {
                        _loc2_ = this.screenMythicalCrafted.closeClicked;
                     }
                     break;
                  case "screenHangerInsertGiftKey":
                     if(this.isButtonInCoordinates("screenHangerInsertGiftKey","btnInsertKey"))
                     {
                        _loc2_ = this.screenHangerInsertGiftKey.insertKeyClicked;
                     }
                     break;
                  case "screenHangerGiftKeys":
                     if(this.isButtonInCoordinates("screenHangerGiftKeys","btnCopy1"))
                     {
                        _loc2_ = this.screenHangerGiftKeys.copyGiftKeyClicked;
                        _loc3_.push(1);
                     }
                     else if(this.isButtonInCoordinates("screenHangerGiftKeys","btnCopy2"))
                     {
                        _loc2_ = this.screenHangerGiftKeys.copyGiftKeyClicked;
                        _loc3_.push(2);
                     }
                     else if(this.isButtonInCoordinates("screenHangerGiftKeys","btnCopy3"))
                     {
                        _loc2_ = this.screenHangerGiftKeys.copyGiftKeyClicked;
                        _loc3_.push(3);
                     }
                     else if(this.isButtonInCoordinates("screenHangerGiftKeys","btnClaim1"))
                     {
                        _loc2_ = this.screenHangerGiftKeys.claimBonusClicked;
                        _loc3_.push(1);
                     }
                     else if(this.isButtonInCoordinates("screenHangerGiftKeys","btnClaim2"))
                     {
                        _loc2_ = this.screenHangerGiftKeys.claimBonusClicked;
                        _loc3_.push(2);
                     }
                     else if(this.isButtonInCoordinates("screenHangerGiftKeys","btnClaim3"))
                     {
                        _loc2_ = this.screenHangerGiftKeys.claimBonusClicked;
                        _loc3_.push(3);
                     }
                     break;
                  case "screenBattleInterfaceTop":
                     if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnZoomIn"))
                     {
                        _loc2_ = this.screenBattle.zoomClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnZoomOut"))
                     {
                        _loc2_ = this.screenBattle.zoomClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnQuit"))
                     {
                        _loc2_ = this.screenBattle.quitClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnOptions"))
                     {
                        _loc2_ = this.screenBattle.optionsClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnEmotesOpen"))
                     {
                        _loc2_ = this.screenBattleInterfaceTop.openEmotesClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnEmotesClose"))
                     {
                        _loc2_ = this.screenBattleInterfaceTop.closeEmotesClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnPauseReplay"))
                     {
                        _loc2_ = this.screenBattleInterfaceTop.pauseReplayClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnPlayReplay"))
                     {
                        _loc2_ = this.screenBattleInterfaceTop.playReplayClicked;
                     }
                     break;
                  case "screenBattleInterfaceEmotes":
                     if(this.screenBattleInterfaceEmotes.parent != null)
                     {
                        if(this.isButtonInCoordinates("screenBattleInterfaceEmotes","btnSendMessage"))
                        {
                           _loc2_ = this.screenBattleInterfaceEmotes.sendChatMessageClicked;
                        }
                        else if(this.isButtonInCoordinates("screenBattleInterfaceEmotes","btnChatEnable"))
                        {
                           _loc2_ = this.screenBattleInterfaceEmotes.chatEnableClicked;
                        }
                        else if(this.isButtonInCoordinates("screenBattleInterfaceEmotes","btnChatDisable"))
                        {
                           _loc2_ = this.screenBattleInterfaceEmotes.chatDisableClicked;
                        }
                        else
                        {
                           _loc4_ = 1;
                           while(_loc4_ <= this.screenBattleInterfaceEmotes.TOTAL_EMOTES)
                           {
                              if(this.isEmoteButtonInCoordinates(this.screenBattleInterfaceEmotes["btnEmote" + _loc4_],0,0))
                              {
                                 _loc2_ = this.screenBattleInterfaceEmotes.emoteClicked;
                                 _loc3_.push(_loc4_);
                                 _loc4_ = this.screenBattleInterfaceEmotes.TOTAL_EMOTES;
                              }
                              _loc4_++;
                           }
                        }
                     }
                     break;
                  case "screenBattleInterfaceBottom":
                     _loc4_ = 0;
                     while(_loc4_ < this.screenBattleInterfaceBottom.allButtons.length)
                     {
                        _loc10_ = this.screenBattleInterfaceBottom.allButtons[_loc4_];
                        if(this.isBattleButtonInCoordinates(_loc10_,this.screenBattleInterfaceBottom.x,this.screenBattleInterfaceBottom.y))
                        {
                           _loc2_ = this.screenBattleInterfaceBottom.buttonMouseClicked;
                           _loc3_.push(_loc10_.buttonID,_loc10_.type,_loc10_.equipmentID);
                           _loc4_ = this.screenBattleInterfaceBottom.allButtons.length;
                        }
                        _loc4_++;
                     }
                     if(mouseY > 111 + this.MOBILE_FINAL_BORDER_ADDON && mouseY < 370 + this.MOBILE_FINAL_BORDER_ADDON)
                     {
                        _loc11_ = true;
                        if(this.isButtonInCoordinates("screenBattleInterfaceTop","btnZoomIn") || this.isButtonInCoordinates("screenBattleInterfaceTop","btnZoomOut"))
                        {
                           _loc11_ = false;
                        }
                        else if(this.isScreenOpened("screenBattleInterfaceEmotes"))
                        {
                           if(mouseX >= 220 && mouseX <= 580 && mouseY <= 180)
                           {
                              _loc11_ = false;
                           }
                        }
                        if(_loc11_)
                        {
                           _loc2_ = this.screenBattleInterfaceBottom.mouseHitAreaClickedSub;
                        }
                     }
                     break;
                  case "screenLadderStatus":
                     if(this.isButtonInCoordinates("screenLadderStatus","btnClose"))
                     {
                        _loc2_ = this.screenLadderStatus.closeClicked;
                     }
                     break;
                  case "screenBattleResult":
                     if(this.isButtonInCoordinates("screenBattleResult","btnOK"))
                     {
                        _loc2_ = this.screenBattleResult.OKClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleResult","btnChat"))
                     {
                        _loc2_ = this.screenBattleResult.chatClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBattleResult","btnInviteToClan"))
                     {
                        _loc2_ = this.screenBattleResult.inviteToClanClicked;
                     }
                     break;
                  case "screenLostConnection":
                     if(this.isButtonInCoordinates("screenLostConnection","btnBack"))
                     {
                        _loc2_ = this.screenLostConnection.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenLostConnection","btnRefresh"))
                     {
                        _loc2_ = this.screenLostConnection.backClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenLostConnection.mcContactSupportHitArea))
                     {
                        _loc2_ = this.screenLostConnection.contactSupportClickedSub;
                     }
                     break;
                  case "screenSelectBattleMechsPerPlayer":
                     if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenSelectBattleMechsPerPlayer","btn1V1"))
                     {
                        _loc2_ = this.screenSelectBattleMechsPerPlayer.battleClicked;
                        _loc3_.push(1);
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenSelectBattleMechsPerPlayer","btn2V2"))
                     {
                        _loc2_ = this.screenSelectBattleMechsPerPlayer.battleClicked;
                        _loc3_.push(2);
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenSelectBattleMechsPerPlayer","btn3V3"))
                     {
                        _loc2_ = this.screenSelectBattleMechsPerPlayer.battleClicked;
                        _loc3_.push(3);
                     }
                     if(_loc2_ != null)
                     {
                        _loc6_ = new Array();
                     }
                     break;
                  case "screenMenuMultiPlayerInspect":
                     if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnSendBattleInvitation"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.sendBattleInvitationClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnAcceptBattleInvitation"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.acceptBattleInvitationClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnDeclineBattleInvitation"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.declineBattleInvitationClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnBlock"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.blockClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnUnBlock"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.unBlockClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnChat"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.chatClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnInspect"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.inspectClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnClose"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.closeClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnSendClanInvitation"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.sendClanInvitationClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnAcceptClanInvitation"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.acceptClanInvitationClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMenuMultiPlayerInspect","btnDeclineClanInvitation"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.declineClanInvitationClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenMenuMultiPlayerInspect.mcBackground) == false)
                     {
                        if(this.isScreenOpened("screenMultiPlayerChat"))
                        {
                           if(this.isSpriteInCoordinates(this.screenMultiPlayerChat.mcChatMouseHitArea))
                           {
                              this.screenMultiPlayerChat.chatHistoryMouseOverHandler();
                              _loc2_ = this.screenMultiPlayerChat.tryToInspectPlayerForMobile;
                           }
                        }
                     }
                     break;
                  case "screenMultiPlayerLadder":
                     if(this.isButtonInCoordinates("screenMultiPlayerLadder","btnSearchForBattle"))
                     {
                        _loc2_ = this.screenMultiPlayerLadder.searchForBattleClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerLadder","btnCancelSearch"))
                     {
                        _loc2_ = this.screenMultiPlayerLadder.cancelSearchClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerLadder","btnChatRoom"))
                     {
                        _loc2_ = this.screenMultiPlayerLadder.chatRoomClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerLadder","btnRankingList"))
                     {
                        _loc2_ = this.screenMultiPlayerLadder.rankingListClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerLadder","btnReplays"))
                     {
                        _loc2_ = this.screenMultiPlayerLadder.replaysClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerLadder","btnClan"))
                     {
                        _loc2_ = this.screenMultiPlayerLadder.clanClicked;
                     }
                     else if(this.screenMultiPlayerLadder.chatAlerts.length > 0)
                     {
                        if(this.isSpriteInCoordinates(this.screenMultiPlayerLadder.mcSizer_chatAlertsHitArea))
                        {
                           _loc4_ = 0;
                           while(_loc4_ < this.screenMultiPlayerLadder.chatAlerts.length)
                           {
                              _loc12_ = this.screenMultiPlayerLadder.chatAlerts[_loc4_];
                              if(this.isChatAlertInCoordinates(_loc12_))
                              {
                                 _loc12_.mouseHitAreaClickedSub();
                                 _loc4_ = this.screenMultiPlayerLadder.chatAlerts.length;
                              }
                              _loc4_++;
                           }
                        }
                     }
                     break;
                  case "screenMultiPlayerChat":
                     if(this.isButtonInCoordinates("screenMultiPlayerChat","btnBackToLadder"))
                     {
                        _loc2_ = this.screenMultiPlayerChat.backToLadderClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerChat","btnChannelsList"))
                     {
                        _loc2_ = this.screenMultiPlayerChat.channelsListClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerChat","btnSearchForPlayer"))
                     {
                        _loc2_ = this.screenMultiPlayerChat.searchForPlayerClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerChat","btnSendMessage"))
                     {
                        _loc2_ = this.screenMultiPlayerChat.sendMessageClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerChat","btnBattleInvitationsEnabled"))
                     {
                        _loc2_ = this.screenMultiPlayerChat.battleInvitationsEnabledClicked;
                     }
                     else if(this.isButtonInCoordinates("screenMultiPlayerChat","btnBattleInvitationsDisabled"))
                     {
                        _loc2_ = this.screenMultiPlayerChat.battleInvitationsDisabledClicked;
                     }
                     else if(this.isScreenOpened("screenMenuMultiPlayerInspect") == false)
                     {
                        if(!(this.screenMultiPlayerChat.channelsVisibleOnLastFrame && this.isSpriteInCoordinates(this.screenMultiPlayerChat.mcFingerWheeling_channels)))
                        {
                           if(this.isSpriteInCoordinates(this.screenMultiPlayerChat.mcChatMouseHitArea))
                           {
                              this.screenMultiPlayerChat.chatHistoryMouseOverHandler();
                              _loc2_ = this.screenMultiPlayerChat.tryToInspectPlayerForMobile;
                           }
                        }
                     }
                     break;
                  case "screenSearchForPlayer":
                     if(this.isButtonInCoordinates("screenSearchForPlayer","btnBack"))
                     {
                        _loc2_ = this.screenSearchForPlayer.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenSearchForPlayer","btnSearch"))
                     {
                        _loc2_ = this.screenSearchForPlayer.searchClicked;
                     }
                     break;
                  case "screenClan":
                     if(this.isButtonInCoordinates("screenClan","btnAcceptRequest"))
                     {
                        _loc2_ = this.screenClan.acceptRequestClicked;
                     }
                     else if(this.isButtonInCoordinates("screenClan","btnDeclineRequest"))
                     {
                        _loc2_ = this.screenClan.declineRequestClicked;
                     }
                     else if(this.isButtonInCoordinates("screenClan","btnInspect"))
                     {
                        _loc2_ = this.screenClan.inspectClicked;
                     }
                     else if(this.isButtonInCoordinates("screenClan","btnKickMember"))
                     {
                        _loc2_ = this.screenClan.kickMemberClicked;
                     }
                     else if(this.isButtonInCoordinates("screenClan","btnLeaveClan"))
                     {
                        _loc2_ = this.screenClan.leaveClanClicked;
                     }
                     else if(this.isButtonInCoordinates("screenClan","btnChat"))
                     {
                        _loc2_ = this.screenClan.chatClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenClan.mcFlagHitArea))
                     {
                        _loc2_ = this.screenClan.editFlagClickedSub;
                     }
                     break;
                  case "screenClanFlag":
                     if(this.isButtonInCoordinates("screenClanFlag","btnRandom"))
                     {
                        _loc2_ = this.screenClanFlag.randomClicked;
                     }
                     else if(this.isButtonInCoordinates("screenClanFlag","btnColorNext"))
                     {
                        _loc2_ = this.screenClanFlag.colorNextClicked;
                     }
                     else if(this.isButtonInCoordinates("screenClanFlag","btnColorPrevious"))
                     {
                        _loc2_ = this.screenClanFlag.colorPreviousClicked;
                     }
                     else if(this.isButtonInCoordinates("screenClanFlag","btnShapeNext"))
                     {
                        _loc2_ = this.screenClanFlag.shapeNextClicked;
                     }
                     else if(this.isButtonInCoordinates("screenClanFlag","btnShapePrevious"))
                     {
                        _loc2_ = this.screenClanFlag.shapePreviousClicked;
                     }
                     else if(this.isButtonInCoordinates("screenClanFlag","btnTypeNext"))
                     {
                        _loc2_ = this.screenClanFlag.typeNextClicked;
                     }
                     else if(this.isButtonInCoordinates("screenClanFlag","btnTypePrevious"))
                     {
                        _loc2_ = this.screenClanFlag.typePreviousClicked;
                     }
                     else if(this.isButtonInCoordinates("screenClanFlag","btnSave"))
                     {
                        _loc2_ = this.screenClanFlag.saveClicked;
                     }
                     break;
                  case "screenBuyBattleCredits":
                     if(this.isButtonInCoordinates("screenBuyBattleCredits","btnBack"))
                     {
                        _loc2_ = this.screenBuyBattleCredits.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyBattleCredits","btnBuy1"))
                     {
                        _loc2_ = this.screenBuyBattleCredits.buy1Clicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyBattleCredits","btnBuy6"))
                     {
                        _loc2_ = this.screenBuyBattleCredits.buy6Clicked;
                     }
                     break;
                  case "screenBuyBattleCreditsWithVideo":
                     if(this.isButtonInCoordinates("screenBuyBattleCreditsWithVideo","btnBack"))
                     {
                        _loc2_ = this.screenBuyBattleCreditsWithVideo.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyBattleCreditsWithVideo","btnBuy1"))
                     {
                        _loc2_ = this.screenBuyBattleCreditsWithVideo.buy1Clicked;
                     }
                     else if(this.isButtonInCoordinates("screenBuyBattleCreditsWithVideo","btnBuy6"))
                     {
                        _loc2_ = this.screenBuyBattleCreditsWithVideo.buy6Clicked;
                     }
                     break;
                  case "screenSMTV":
                     _loc8_ = this.screenSMTV.x + this.screenSMTV.mcSMTV.mcHitAreaGeneral.x;
                     _loc9_ = this.screenSMTV.y + this.screenSMTV.mcSMTV.mcHitAreaGeneral.y;
                     if(this.isSpriteInCoordinates(this.screenSMTV.mcSMTV.mcHitAreaGeneral,_loc8_,_loc9_))
                     {
                        _loc2_ = this.screenSMTV.SMTVClickedSub;
                     }
                     break;
                  case "screenItemCards":
                     if(this.isButtonInCoordinates("screenItemCards","btnOK"))
                     {
                        _loc2_ = this.screenItemCards.OKClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenItemCards.mcItemBoxClickHitArea) && this.screenItemCards.waitingForBoxClick())
                     {
                        _loc2_ = this.screenItemCards.itemBoxClickedSub;
                     }
                     else
                     {
                        _loc5_ = 0;
                        while(_loc5_ < this.screenItemCards.itemCards.length)
                        {
                           if(this.isItemCardInCoordinates(this.screenItemCards.itemCards[_loc5_]))
                           {
                              this.screenItemCards.itemCardClicked(_loc5_);
                              _loc5_ = this.screenItemCards.itemCards.length;
                           }
                           _loc5_++;
                        }
                     }
                     break;
                  case "screenHangerShop":
                     if(this.isButtonInCoordinates("screenHangerShop","btnItemsLeft"))
                     {
                        _loc2_ = this.screenHangerShop.itemsLeftClicked;
                     }
                     else if(this.isButtonInCoordinates("screenHangerShop","btnItemsRight"))
                     {
                        _loc2_ = this.screenHangerShop.itemsRightClicked;
                     }
                     break;
                  case "screenHelp":
                     if(this.isButtonInCoordinates("screenHelp","btnReplay"))
                     {
                        _loc2_ = this.screenHelp.replayClicked;
                     }
                     else if(this.isButtonInCoordinates("screenHelp","btnWiki"))
                     {
                        _loc2_ = this.screenHelp.wikiClicked;
                     }
                     break;
                  case "screenProfileInfo":
                     if(this.isButtonInCoordinates("screenProfileInfo","btnChangeName"))
                     {
                        _loc2_ = this.screenProfileInfo.changeNameClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileInfo","btnSendTokensToPlayer"))
                     {
                        _loc2_ = this.screenProfileInfo.sendTokensToPlayerClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileInfo","btnAdminTools"))
                     {
                        _loc2_ = this.screenProfileInfo.adminToolsClicked;
                     }
                     break;
                  case "screenProfileOptions":
                     if(this.isButtonInCoordinates("screenProfileOptions","btnBreathingOff"))
                     {
                        _loc2_ = this.screenProfileOptions.breathingOffClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnBreathingOn"))
                     {
                        _loc2_ = this.screenProfileOptions.breathingOnClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnLanguages"))
                     {
                        _loc2_ = this.screenProfileOptions.languagesClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnMusicOff"))
                     {
                        _loc2_ = this.screenProfileOptions.musicOffClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnMusicOn"))
                     {
                        _loc2_ = this.screenProfileOptions.musicOnClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnParticlesMinus"))
                     {
                        _loc2_ = this.screenProfileOptions.particlesMinusClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnParticlesPlus"))
                     {
                        _loc2_ = this.screenProfileOptions.particlesPlusClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnSoundOff"))
                     {
                        _loc2_ = this.screenProfileOptions.soundOffClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnSoundOn"))
                     {
                        _loc2_ = this.screenProfileOptions.soundOnClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnPushNotificationsOff"))
                     {
                        _loc2_ = this.screenProfileOptions.pushNotificationsOffClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnPushNotificationsOn"))
                     {
                        _loc2_ = this.screenProfileOptions.pushNotificationsOnClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnSeePerksOn"))
                     {
                        _loc2_ = this.screenProfileOptions.seePerksOnClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileOptions","btnSeePerksOff"))
                     {
                        _loc2_ = this.screenProfileOptions.seePerksOffClicked;
                     }
                     break;
                  case "screenProfileAccounts":
                     if(this.isButtonInCoordinates("screenProfileAccounts","btnSuperMechsConnect"))
                     {
                        _loc2_ = this.screenProfileAccounts.superMechsClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileAccounts","btnGooglePlayConnect"))
                     {
                        _loc2_ = this.screenProfileAccounts.googlePlayClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileAccounts","btnFacebookConnect"))
                     {
                        _loc2_ = this.screenProfileAccounts.facebookClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileAccounts","btnSuperMechsDisconnect"))
                     {
                        _loc2_ = this.screenProfileAccounts.superMechsClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileAccounts","btnGooglePlayDisconnect"))
                     {
                        _loc2_ = this.screenProfileAccounts.googlePlayClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileAccounts","btnFacebookDisconnect"))
                     {
                        _loc2_ = this.screenProfileAccounts.facebookClicked;
                     }
                     else if(this.isButtonInCoordinates("screenProfileAccounts","btnLogout"))
                     {
                        _loc2_ = this.screenProfileAccounts.logoutClicked;
                     }
                     break;
                  case "screenSendTokensToPlayer":
                     if(this.isButtonInCoordinates("screenSendTokensToPlayer","btnBack"))
                     {
                        _loc2_ = this.screenSendTokensToPlayer.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenSendTokensToPlayer","btnSearchPlayer"))
                     {
                        _loc2_ = this.screenSendTokensToPlayer.searchPlayerClicked;
                     }
                     else if(this.isButtonInCoordinates("screenSendTokensToPlayer","btnSend"))
                     {
                        _loc2_ = this.screenSendTokensToPlayer.sendTokensClicked;
                     }
                     break;
                  case "screenInspectPlayer":
                     if(this.isButtonInCoordinates("screenInspectPlayer","btnBack"))
                     {
                        _loc2_ = this.screenInspectPlayer.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnPreviousMech"))
                     {
                        _loc2_ = this.screenInspectPlayer.previousMechClicked;
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnNextMech"))
                     {
                        _loc2_ = this.screenInspectPlayer.nextMechClicked;
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnUp"))
                     {
                        _loc2_ = this.screenInspectPlayer.upClicked;
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnDown"))
                     {
                        _loc2_ = this.screenInspectPlayer.downClicked;
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnMechs"))
                     {
                        _loc2_ = this.screenInspectPlayer.mechsClicked;
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnReplays"))
                     {
                        _loc2_ = this.screenInspectPlayer.replaysClicked;
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnAchievements"))
                     {
                        _loc2_ = this.screenInspectPlayer.achievementsClicked;
                     }
                     else if(this.isButtonInCoordinates("screenInspectPlayer","btnClan"))
                     {
                        _loc2_ = this.screenInspectPlayer.clanClicked;
                     }
                     break;
                  case "screenRankingList":
                     if(this.isButtonInCoordinates("screenRankingList","btnPlayers"))
                     {
                        _loc2_ = this.screenRankingList.playersClicked;
                     }
                     else if(this.isButtonInCoordinates("screenRankingList","btnClans"))
                     {
                        _loc2_ = this.screenRankingList.clansClicked;
                     }
                     else if(this.isMovieClipInCoordinates(this.screenRankingList.mcShowOnline,0,0))
                     {
                        _loc2_ = this.screenRankingList.showOnlineClickedSub;
                     }
                     break;
                  case "screenSearchForClan":
                     if(this.isButtonInCoordinates("screenSearchForClan","btnClanCreate"))
                     {
                        _loc2_ = this.screenSearchForClan.clanCreateClicked;
                     }
                     else if(this.isButtonInCoordinates("screenSearchForClan","btnClanSearch"))
                     {
                        _loc2_ = this.screenSearchForClan.clanSearchClicked;
                     }
                     break;
                  case "screenWatchRewardedVideo":
                     if(this.isButtonInCoordinates("screenWatchRewardedVideo","btnBack"))
                     {
                        _loc2_ = this.screenWatchRewardedVideo.backClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenWatchRewardedVideo.mcSizer_btnWatch))
                     {
                        _loc2_ = this.screenWatchRewardedVideo.watchVideoClicked;
                     }
                     break;
                  case "screenLanguageSelection":
                     if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang1"))
                     {
                        _loc2_ = this.screenLanguageSelection.languageClicked;
                        _loc3_.push(1);
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang3"))
                     {
                        _loc2_ = this.screenLanguageSelection.languageClicked;
                        _loc3_.push(3);
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang4"))
                     {
                        _loc2_ = this.screenLanguageSelection.languageClicked;
                        _loc3_.push(4);
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang5"))
                     {
                        _loc2_ = this.screenLanguageSelection.languageClicked;
                        _loc3_.push(5);
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang7"))
                     {
                        _loc2_ = this.screenLanguageSelection.languageClicked;
                        _loc3_.push(7);
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang9"))
                     {
                        _loc2_ = this.screenLanguageSelection.languageClicked;
                        _loc3_.push(9);
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang10"))
                     {
                        _loc2_ = this.screenLanguageSelection.languageClicked;
                        _loc3_.push(10);
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords("screenLanguageSelection","btnLang20"))
                     {
                        _loc2_ = this.screenLanguageSelection.languageClicked;
                        _loc3_.push(20);
                     }
                     break;
                  case "screenReconnecting":
                     break;
                  case "screenYouTubeVidsGuide":
                     if(this.isButtonInCoordinates("screenYouTubeVidsGuide","btnBack"))
                     {
                        _loc2_ = this.screenYouTubeVidsGuide.backClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenYouTubeVidsGuide.mcSizer_channel,0,0))
                     {
                        _loc2_ = this.screenYouTubeVidsGuide.channelClickedSub;
                     }
                     else if(this.isSpriteInCoordinates(this.screenYouTubeVidsGuide.mcSizer_channel2,0,0))
                     {
                        _loc2_ = this.screenYouTubeVidsGuide.channelClickedSub;
                     }
                     break;
                  case "screenSelectAccount":
                     break;
                  case "screenDailyLoginStreakBonus":
                     this.screenDailyLoginStreakBonus.mouseHitAreaClickedSub();
                     break;
                  case "screenClanCreate":
                     if(this.isButtonInCoordinates("screenClanCreate","btnBack"))
                     {
                        _loc2_ = this.screenClanCreate.backClicked;
                     }
                     else if(this.isButtonInCoordinates("screenClanCreate","btnCreate"))
                     {
                        _loc2_ = this.screenClanCreate.createClicked;
                     }
                     else if(this.isButtonInCoordinates("screenClanCreate","btnCancel"))
                     {
                        _loc2_ = this.screenClanCreate.backClicked;
                     }
               }
               _loc7_++;
            }
            if(_loc2_ != null)
            {
               if(_loc3_.length == 0)
               {
                  _loc2_();
               }
               else if(_loc3_.length == 1)
               {
                  _loc2_(_loc3_[0]);
               }
               else if(_loc3_.length == 2)
               {
                  _loc2_(_loc3_[0],_loc3_[1]);
               }
               else if(_loc3_.length == 3)
               {
                  _loc2_(_loc3_[0],_loc3_[1],_loc3_[2]);
               }
            }
         }
      }
      
      public function getTargetScreens() : Array
      {
         var _loc2_:Boolean = false;
         var _loc1_:Array = new Array();
         if(this.isScreenOpened("screenDebugger"))
         {
            _loc1_.push("screenDebugger");
         }
         else if(!this.isScreenOpened("screenReconnecting"))
         {
            if(this.isScreenOpened("screenLostConnection"))
            {
               _loc1_.push("screenLostConnection");
            }
            else if(this.isScreenOpened("screenConfirmation"))
            {
               _loc1_.push("screenConfirmation");
            }
            else if(this.isScreenOpened("screenSelectAccount"))
            {
               _loc1_.push("screenSelectAccount");
            }
            else if(this.isScreenOpened("screenWatchRewardedVideo"))
            {
               _loc1_.push("screenWatchRewardedVideo");
            }
            else if(this.isScreenOpened("screenGlobalShop"))
            {
               if(this.isScreenOpened("screenItemCards"))
               {
                  _loc1_.push("screenItemCards");
               }
               else if(this.isScreenOpened("screenBuyGold"))
               {
                  _loc1_.push("screenBuyGold");
               }
               else if(this.isScreenOpened("screenBuyItem"))
               {
                  _loc1_.push("screenBuyItem");
               }
               else if(this.isScreenOpened("screenBuyItemBox"))
               {
                  _loc1_.push("screenBuyItemBox");
               }
               else
               {
                  _loc1_.push("screenGlobalShop");
               }
            }
            else if(this.isScreenOpened("screenBuyGold"))
            {
               _loc1_.push("screenBuyGold");
            }
            else if(this.isScreenOpened("screenBattleOptions"))
            {
               _loc1_.push("screenBattleOptions");
            }
            else if(this.isScreenOpened("screenRegister"))
            {
               _loc1_.push("screenRegister");
            }
            else if(this.isScreenOpened("screenPopUp"))
            {
               _loc1_.push("screenPopUp");
            }
            else if(this.isScreenOpened("screenLevelUpEntry"))
            {
               _loc1_.push("screenLevelUpEntry");
            }
            else if(this.isScreenOpened("screenLevelUp"))
            {
               if(this.isScreenOpened("screenItemCards"))
               {
                  _loc1_.push("screenItemCards");
               }
               else
               {
                  _loc1_.push("screenLevelUp");
               }
            }
            else if(this.isScreenOpened("screenBuyStarterPack"))
            {
               if(this.isScreenOpened("screenItemCards"))
               {
                  _loc1_.push("screenItemCards");
               }
               else
               {
                  _loc1_.push("screenBuyStarterPack");
                  _loc1_.push("screenTopBar");
               }
            }
            else if(this.isScreenOpened("screenItemCards"))
            {
               _loc1_.push("screenItemCards");
            }
            else if(this.isScreenOpened("screenMissionCompleted"))
            {
               _loc1_.push("screenMissionCompleted");
            }
            else if(this.isScreenOpened("screenDailyLoginStreakBonus"))
            {
               _loc1_.push("screenDailyLoginStreakBonus");
            }
            else if(this.isScreenOpened("screenOpeningSequence"))
            {
               _loc1_.push("screenOpeningSequence");
            }
            else if(this.isScreenOpened("screenWelcomeNewExisting"))
            {
               _loc1_.push("screenWelcomeNewExisting");
               _loc1_.push("screenWelcomeBackground");
               if(this.isScreenOpened("screenLanguageSelection"))
               {
                  _loc1_.push("screenLanguageSelection");
               }
            }
            else if(this.isScreenOpened("screenWelcomeLogin"))
            {
               _loc1_.push("screenWelcomeLogin");
               _loc1_.push("screenWelcomeBackground");
               if(this.isScreenOpened("screenLanguageSelection"))
               {
                  _loc1_.push("screenLanguageSelection");
               }
            }
            else if(this.isScreenOpened("screenWelcomeLoginAs"))
            {
               _loc1_.push("screenWelcomeLoginAs");
               _loc1_.push("screenWelcomeBackground");
            }
            else if(this.isScreenOpened("screenClanFlag"))
            {
               _loc1_.push("screenClanFlag");
            }
            else if(this.isScreenOpened("screenBattle"))
            {
               _loc2_ = false;
               if(this.isScreenOpened("screenVS"))
               {
                  if(this.screenVS.blockingBattle)
                  {
                     _loc2_ = true;
                  }
               }
               if(_loc2_ == false)
               {
                  if(this.isScreenOpened("screenLadderStatus"))
                  {
                     _loc1_.push("screenLadderStatus");
                  }
                  else if(this.isScreenOpened("screenBattleResult"))
                  {
                     _loc1_.push("screenBattleResult");
                  }
                  else
                  {
                     _loc1_.push("screenBattle");
                     if(this.isScreenOpened("screenBattleInterfaceTop"))
                     {
                        _loc1_.push("screenBattleInterfaceTop");
                     }
                     if(this.isScreenOpened("screenBattleInterfaceEmotes"))
                     {
                        _loc1_.push("screenBattleInterfaceEmotes");
                     }
                     if(this.isScreenOpened("screenBattleInterfaceBottom"))
                     {
                        _loc1_.push("screenBattleInterfaceBottom");
                     }
                  }
               }
            }
            else if(this.isScreenOpened("screenMissionBaseMap"))
            {
               if(this.isScreenOpened("screenItemCards"))
               {
                  _loc1_.push("screenItemCards");
               }
               else if(this.isScreenOpened("screenBuyBattleCredits"))
               {
                  _loc1_.push("screenBuyBattleCredits");
               }
               else if(this.isScreenOpened("screenBuyBattleCreditsWithVideo"))
               {
                  _loc1_.push("screenBuyBattleCreditsWithVideo");
               }
               else if(this.isScreenOpened("screenMissionCompleted"))
               {
                  _loc1_.push("screenMissionCompleted");
               }
               else
               {
                  _loc1_.push("screenMissionBaseMap");
                  _loc1_.push("screenTopBar");
               }
            }
            else if(this.isScreenOpened("screenMythicalCrafted"))
            {
               _loc1_.push("screenMythicalCrafted");
            }
            else if(this.isScreenOpened("screenCraftMythicals"))
            {
               _loc1_.push("screenCraftMythicals");
            }
            else if(this.isScreenOpened("screenNews"))
            {
               _loc1_.push("screenNews");
            }
            else if(this.isScreenOpened("screenReplays"))
            {
               _loc1_.push("screenReplays");
            }
            else if(this.isScreenOpened("screenAchievements"))
            {
               _loc1_.push("screenAchievements");
            }
            else if(this.isScreenOpened("screenClan"))
            {
               if(this.isScreenOpened("screenInspectPlayer"))
               {
                  _loc1_.push("screenInspectPlayer");
               }
               else
               {
                  _loc1_.push("screenClan");
               }
            }
            else
            {
               if(this.isScreenOpened("screenTopBar"))
               {
                  if(this.isScreenOpened("screenBuyItem") == false)
                  {
                     _loc1_.push("screenTopBar");
                  }
               }
               if(this.isScreenOpened("screenAdminTools"))
               {
                  _loc1_.push("screenAdminTools");
               }
               else if(this.isScreenOpened("screenMissionWorldMap"))
               {
                  if(this.isScreenOpened("screenItemCards"))
                  {
                     _loc1_.push("screenItemCards");
                  }
                  else if(this.isScreenOpened("screenBuyAnotherItemBox"))
                  {
                     _loc1_.push("screenBuyAnotherItemBox");
                  }
                  else if(this.isScreenOpened("screenWorldMapSelectBattle"))
                  {
                     _loc1_.push("screenWorldMapSelectBattle");
                  }
                  else if(this.isScreenOpened("screenBuyMissions"))
                  {
                     _loc1_.push("screenBuyMissions");
                  }
                  else
                  {
                     _loc1_.push("screenMissionWorldMap");
                     if(this.isScreenOpened("screenMissionWorldMapInterface"))
                     {
                        _loc1_.push("screenMissionWorldMapInterface");
                        if(this.isScreenOpened("screenSpecialOffers"))
                        {
                           _loc1_.push("screenSpecialOffers");
                        }
                     }
                     if(this.isScreenOpened("screenRegisterOffer"))
                     {
                        _loc1_.push("screenRegisterOffer");
                     }
                  }
               }
               else if(this.isScreenOpened("screenHangerMenu"))
               {
                  if(this.isScreenOpened("screenItemCards") && this.screenItemCards.closingScreen == false)
                  {
                     _loc1_.push("screenItemCards");
                  }
                  else if(this.isScreenOpened("screenChangeMechsOrder"))
                  {
                     _loc1_.push("screenChangeMechsOrder");
                  }
                  else
                  {
                     _loc1_.push("screenHangerMenu");
                     if(this.isScreenOpened("screenHangerInventory"))
                     {
                        _loc1_.push("screenHangerInventory");
                     }
                     if(this.isScreenOpened("screenHangerMech"))
                     {
                        _loc1_.push("screenHangerMech");
                     }
                     if(this.isScreenOpened("screenHangerFusion"))
                     {
                        _loc1_.push("screenHangerFusion");
                     }
                     if(this.isScreenOpened("screenHangerGiftKeys"))
                     {
                        _loc1_.push("screenHangerGiftKeys");
                     }
                     if(this.isScreenOpened("screenHangerInsertGiftKey"))
                     {
                        _loc1_.push("screenHangerInsertGiftKey");
                     }
                     if(this.isScreenOpened("screenHangerShop"))
                     {
                        if(this.isScreenOpened("screenBuyItem"))
                        {
                           _loc1_.push("screenBuyItem");
                        }
                        else
                        {
                           _loc1_.push("screenHangerShop");
                        }
                     }
                  }
               }
               else if(this.isScreenOpened("screenMainMenu"))
               {
                  _loc1_.push("screenMainMenu");
                  if(this.isScreenOpened("screenTopBarNew"))
                  {
                     _loc1_.push("screenTopBarNew");
                  }
                  if(this.isScreenOpened("screenSpecialOffers"))
                  {
                     _loc1_.push("screenSpecialOffers");
                  }
               }
               else if(this.isScreenOpened("screenMultiPlayerLadder"))
               {
                  if(this.isScreenOpened("screenYouTubeVidsGuide"))
                  {
                     _loc1_.push("screenYouTubeVidsGuide");
                  }
                  else if(this.isScreenOpened("screenBuyBattleCredits"))
                  {
                     _loc1_.push("screenBuyBattleCredits");
                  }
                  else if(this.isScreenOpened("screenBuyBattleCreditsWithVideo"))
                  {
                     _loc1_.push("screenBuyBattleCreditsWithVideo");
                  }
                  else if(this.isScreenOpened("screenInspectPlayer"))
                  {
                     _loc1_.push("screenInspectPlayer");
                  }
                  else
                  {
                     if(this.isScreenOpened("screenSelectBattleMechsPerPlayer"))
                     {
                        _loc1_.push("screenSelectBattleMechsPerPlayer");
                     }
                     if(this.isScreenOpened("screenMenuMultiPlayerInspect"))
                     {
                        _loc1_.push("screenMenuMultiPlayerInspect");
                     }
                     if(this.isScreenOpened("screenSpecialOffers"))
                     {
                        _loc1_.push("screenSpecialOffers");
                     }
                     if(this.isScreenOpened("screenMultiPlayerLadder"))
                     {
                        _loc1_.push("screenMultiPlayerLadder");
                     }
                     if(this.isScreenOpened("screenSMTV"))
                     {
                        _loc1_.push("screenSMTV");
                     }
                  }
               }
               else if(this.isScreenOpened("screenMultiPlayerChat"))
               {
                  if(this.isScreenOpened("screenBuyBattleCredits"))
                  {
                     _loc1_.push("screenBuyBattleCredits");
                  }
                  else if(this.isScreenOpened("screenBuyBattleCreditsWithVideo"))
                  {
                     _loc1_.push("screenBuyBattleCreditsWithVideo");
                  }
                  else if(this.isScreenOpened("screenInspectPlayer"))
                  {
                     _loc1_.push("screenInspectPlayer");
                  }
                  else if(this.isScreenOpened("screenSearchForPlayer"))
                  {
                     if(this.isScreenOpened("screenMenuMultiPlayerInspect"))
                     {
                        _loc1_.push("screenMenuMultiPlayerInspect");
                     }
                     if(this.isScreenOpened("screenSelectBattleMechsPerPlayer"))
                     {
                        _loc1_.push("screenSelectBattleMechsPerPlayer");
                     }
                     _loc1_.push("screenSearchForPlayer");
                  }
                  else
                  {
                     if(this.isScreenOpened("screenSelectBattleMechsPerPlayer"))
                     {
                        _loc1_.push("screenSelectBattleMechsPerPlayer");
                     }
                     if(this.isScreenOpened("screenMenuMultiPlayerInspect"))
                     {
                        _loc1_.push("screenMenuMultiPlayerInspect");
                     }
                     if(this.isScreenOpened("screenSpecialOffers"))
                     {
                        _loc1_.push("screenSpecialOffers");
                     }
                     _loc1_.push("screenMultiPlayerChat");
                  }
               }
               else if(this.isScreenOpened("screenItemCards") && this.screenItemCards.closingScreen == false)
               {
                  _loc1_.push("screenItemCards");
               }
               else if(this.isScreenOpened("screenHelp"))
               {
                  _loc1_.push("screenHelp");
               }
               else if(this.isScreenOpened("screenProfileInfo"))
               {
                  if(this.isScreenOpened("screenChangeName"))
                  {
                     _loc1_.push("screenChangeName");
                  }
                  else if(this.isScreenOpened("screenSendTokensToPlayer"))
                  {
                     _loc1_.push("screenSendTokensToPlayer");
                  }
                  else
                  {
                     _loc1_.push("screenProfileInfo");
                  }
               }
               else if(this.isScreenOpened("screenProfileAccounts"))
               {
                  _loc1_.push("screenProfileAccounts");
               }
               else if(this.isScreenOpened("screenProfileOptions"))
               {
                  _loc1_.push("screenProfileOptions");
                  if(this.isScreenOpened("screenLanguageSelection"))
                  {
                     _loc1_.push("screenLanguageSelection");
                  }
               }
               else if(this.isScreenOpened("screenRankingList"))
               {
                  if(this.isScreenOpened("screenInspectPlayer"))
                  {
                     _loc1_.push("screenInspectPlayer");
                  }
                  else
                  {
                     _loc1_.push("screenRankingList");
                  }
               }
               else if(this.isScreenOpened("screenSearchForClan"))
               {
                  if(this.isScreenOpened("screenClanCreate"))
                  {
                     _loc1_.push("screenClanCreate");
                  }
                  else
                  {
                     _loc1_.push("screenSearchForClan");
                  }
               }
            }
         }
         return _loc1_;
      }
      
      private function isButtonInCoordinates(param1:String, param2:String) : Boolean
      {
         var _loc4_:BMBaseScreen = null;
         var _loc5_:* = undefined;
         var _loc3_:Boolean = false;
         if(this.isScreenOpened(param1))
         {
            _loc4_ = this[param1];
            if(!_loc4_.isInteractive)
            {
               return false;
            }
            if(!_loc4_.hasOwnProperty(param2))
            {
               return false;
            }
            _loc5_ = this[param1][param2];
            if(Boolean(_loc5_ != null) && Boolean(_loc5_.buttonCore.isButtonEnabled()) && Boolean(_loc5_.visible))
            {
               if(_loc5_.x <= mouseX && _loc5_.x + _loc5_.width >= mouseX)
               {
                  if(_loc5_.y + this.MOBILE_FINAL_BORDER_ADDON <= mouseY && _loc5_.y + _loc5_.height + this.MOBILE_FINAL_BORDER_ADDON >= mouseY)
                  {
                     _loc3_ = true;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function isButtonInCoordinates_insideHolder(param1:String, param2:String, param3:Number, param4:Number) : Boolean
      {
         var _loc5_:Boolean = false;
         if(this.isScreenOpened(param1))
         {
            if(Boolean(this[param1][param2].buttonCore.isButtonEnabled()) && Boolean(this[param1][param2].visible))
            {
               if(this[param1][param2].x + param3 <= mouseX && this[param1][param2].x + param3 + this[param1][param2].width >= mouseX)
               {
                  if(this[param1][param2].y + param4 + this.MOBILE_FINAL_BORDER_ADDON <= mouseY && this[param1][param2].y + param4 + this[param1][param2].height + this.MOBILE_FINAL_BORDER_ADDON >= mouseY)
                  {
                     _loc5_ = true;
                  }
               }
            }
         }
         return _loc5_;
      }
      
      private function isButtonInCoordinates_screenNotOnZeroCoords(param1:String, param2:String) : Boolean
      {
         var _loc4_:BMBaseScreen = null;
         var _loc5_:BMButton = null;
         var _loc3_:Boolean = false;
         if(this.isScreenOpened(param1))
         {
            _loc4_ = this[param1];
            if(_loc4_.hasOwnProperty(param2))
            {
               _loc5_ = _loc4_[param2];
               if(_loc5_.buttonCore.isButtonEnabled() && _loc5_.visible)
               {
                  if(_loc4_.x + _loc5_.x * _loc4_.scaleX <= mouseX && _loc4_.x + (_loc5_.x + _loc5_.width) * _loc4_.scaleX >= mouseX)
                  {
                     if(_loc4_.y + _loc5_.y * _loc4_.scaleY + this.MOBILE_FINAL_BORDER_ADDON <= mouseY && _loc4_.y + (_loc5_.y + _loc5_.height) * _loc4_.scaleY + this.MOBILE_FINAL_BORDER_ADDON >= mouseY)
                     {
                        _loc3_ = true;
                     }
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function isBattleButtonInCoordinates(param1:BMButtonBattle, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Boolean = false;
         if(param1.parent != null)
         {
            if(param1.isButtonBlocked() == false)
            {
               if(param1.buttonCore.isButtonEnabled())
               {
                  if(param1.x + param2 <= mouseX && param1.x + param2 + param1.width >= mouseX)
                  {
                     if(param1.y + param3 + this.MOBILE_FINAL_BORDER_ADDON <= mouseY && param1.y + param3 + param1.height + this.MOBILE_FINAL_BORDER_ADDON >= mouseY)
                     {
                        _loc4_ = true;
                     }
                  }
               }
            }
         }
         return _loc4_;
      }
      
      private function isEmoteButtonInCoordinates(param1:BMButtonEmote, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Boolean = false;
         if(param1.parent != null)
         {
            if(param1.buttonCore.isButtonEnabled())
            {
               if(param1.x + param2 <= mouseX && param1.x + param2 + param1.width >= mouseX)
               {
                  if(param1.y + param3 + this.MOBILE_FINAL_BORDER_ADDON <= mouseY && param1.y + param3 + param1.height + this.MOBILE_FINAL_BORDER_ADDON >= mouseY)
                  {
                     _loc4_ = true;
                  }
               }
            }
         }
         return _loc4_;
      }
      
      private function isTileListItemInCoordinates(param1:BMTileListItem, param2:Number = 0, param3:Number = 0) : Boolean
      {
         var _loc4_:Boolean = false;
         if(param1.visible)
         {
            if(param1.x + param2 <= mouseX && param1.x + param2 + param1.width >= mouseX)
            {
               if(param1.y + param3 + this.MOBILE_FINAL_BORDER_ADDON <= mouseY && param1.y + param3 + param1.height + this.MOBILE_FINAL_BORDER_ADDON >= mouseY)
               {
                  _loc4_ = true;
               }
            }
         }
         return _loc4_;
      }
      
      public function isSpriteInCoordinates(param1:Sprite, param2:Number = 0, param3:Number = 0) : Boolean
      {
         var _loc5_:uint = 0;
         if(param1 == null)
         {
            return false;
         }
         var _loc4_:Boolean = false;
         if(param1.visible && param1.parent != null)
         {
            if(param1.x + param2 <= mouseX && param1.x + param2 + param1.width >= mouseX)
            {
               _loc5_ = 0;
               if(dataM.runAsMobile)
               {
                  _loc5_ = this.MOBILE_FINAL_BORDER_ADDON;
               }
               if(param1.y + param3 + _loc5_ <= mouseY && param1.y + param3 + param1.height + _loc5_ >= mouseY)
               {
                  _loc4_ = true;
               }
            }
         }
         return _loc4_;
      }
      
      public function isMovieClipInCoordinates(param1:MovieClip, param2:Number, param3:Number) : Boolean
      {
         var _loc5_:Rectangle = null;
         var _loc4_:Boolean = false;
         if(param1.visible)
         {
            _loc5_ = param1.getRect(stage.root);
            if(_loc5_.contains(mouseX - param2,mouseY - param3))
            {
               _loc4_ = true;
            }
         }
         return _loc4_;
      }
      
      private function isItemCardInCoordinates(param1:BMItemCard) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1.x - param1.width / 2 <= mouseX && param1.x + param1.width / 2 >= mouseX)
         {
            if(param1.y + this.MOBILE_FINAL_BORDER_ADDON <= mouseY && param1.y + param1.height + this.MOBILE_FINAL_BORDER_ADDON >= mouseY)
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      private function isChatAlertInCoordinates(param1:BMMultiplayerLadderChatAlert) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1.x - param1.width / 2 <= mouseX && param1.x + param1.width / 2 >= mouseX)
         {
            if(param1.y - param1.height / 2 - this.MOBILE_FINAL_BORDER_ADDON <= mouseY && param1.y + param1.height / 2 + this.MOBILE_FINAL_BORDER_ADDON >= mouseY)
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      private function isTextFieldInCoordinates(param1:TextField, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:Boolean = false;
         if(param1.x + param2 <= mouseX && param1.x + param2 + param1.width >= mouseX)
         {
            if(param1.y + param3 + this.MOBILE_FINAL_BORDER_ADDON <= mouseY && param1.y + param3 + param1.height + this.MOBILE_FINAL_BORDER_ADDON >= mouseY)
            {
               _loc4_ = true;
            }
         }
         return _loc4_;
      }
      
      public function addBattleScreens() : void
      {
         var _loc1_:Boolean = false;
         System.gc();
         System.gc();
         dataM.loadNextAdvertisement();
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_REPLAY:
               this.addScreen("screenBattle");
               this.addScreen("screenBattleInterfaceTop");
               this.screenBattleInterfaceTop.refreshScreen();
               this.screenBattle.activateNextBattlePhase("initiate_startNewBattle");
               break;
            case BMDataManager.GAME_TYPE_GUEST:
            case BMDataManager.GAME_TYPE_ONLINE:
               _loc1_ = false;
               if(dataM.runAsMobile == false)
               {
                  switch(dataM.battleType)
                  {
                     case "regular":
                        _loc1_ = true;
                        break;
                     case "challenge":
                        if(dataM.battleSubType == "godMode")
                        {
                           _loc1_ = true;
                        }
                  }
               }
               if(_loc1_)
               {
                  this.addScreen("screenVS");
                  this.screenVS.refreshScreen();
               }
               else
               {
                  this.addScreen("screenBattle");
                  this.addScreen("screenBattleInterfaceTop");
                  this.addScreen("screenBattleInterfaceBottom");
                  this.screenBattleInterfaceTop.refreshScreen();
                  this.screenBattle.activateNextBattlePhase("initiate_startNewBattle");
                  this.stagePointer.focus = this.screenBattle;
                  this.screenBattle.screenVSIsClosed();
               }
         }
      }
      
      public function createButtonFromSizer(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:DisplayObject = this[param1];
         var _loc5_:Boolean = true;
         switch(param3)
         {
            case "regular":
               _loc4_[param2] = new BMButton();
               break;
            case "regular2":
               _loc4_[param2] = new BMButton2();
               break;
            case "regular3":
               _loc4_[param2] = new BMButton3();
               break;
            case "regular4":
               _loc4_[param2] = new BMButton4();
               break;
            case "arrowLeft":
               _loc4_[param2] = new BMButton_arrowLeft();
               break;
            case "arrowRight":
               _loc4_[param2] = new BMButton_arrowRight();
               break;
            case "pictureA":
               _loc4_[param2] = new BMButton_pictureA();
               break;
            case "pictureB":
               _loc4_[param2] = new BMButton_pictureB();
               break;
            case "pictureC":
               _loc4_[param2] = new BMButton_pictureC();
               break;
            case "pictureD":
               _loc4_[param2] = new BMButton_pictureD();
               break;
            case "pictureE":
               _loc4_[param2] = new BMButton_pictureE();
               break;
            case "pictureF":
               _loc4_[param2] = new BMButton_pictureF();
               break;
            case "pictureG":
               _loc4_[param2] = new BMButton_pictureG();
               break;
            case "pictureH":
               _loc4_[param2] = new BMButton_pictureH();
               break;
            case "pictureI":
               _loc4_[param2] = new BMButton_pictureI();
               break;
            case "pictureJ":
               _loc4_[param2] = new BMButton_pictureJ();
               break;
            case "pictureK":
               _loc4_[param2] = new BMButton_pictureK();
               break;
            case "pictureL":
               _loc4_[param2] = new BMButton_pictureL();
               break;
            case "pictureM":
               _loc4_[param2] = new BMButton_pictureM();
               break;
            case "pictureN":
               _loc4_[param2] = new BMButton_pictureN();
               break;
            case "plus":
               _loc4_[param2] = new BMButton_plus();
               break;
            case "plus2":
               _loc4_[param2] = new BMButton_plus2();
               break;
            case "battleBonus":
               _loc4_[param2] = new BMButton_battleBonus();
               break;
            case "battle":
               _loc4_[param2] = new BMButtonBattle();
               break;
            case "emote":
               _loc4_[param2] = new BMButtonEmote();
               _loc5_ = false;
               break;
            case "workbench":
               _loc4_[param2] = new BMButtonWorkbench();
         }
         var _loc6_:Sprite = _loc4_["mcSizer_" + param2];
         _loc4_[param2].x = _loc6_.x;
         _loc4_[param2].y = _loc6_.y;
         _loc4_[param2].width = _loc6_.width;
         _loc4_[param2].height = _loc6_.height;
         if(_loc5_)
         {
            _loc4_[param2].setLanguageID(dataM.languageID);
         }
         _loc4_["mcButtonsHolder"].addChild(_loc4_[param2]);
      }
      
      public function sound_buttonClicked() : void
      {
         soundM.createSound("buttonClick",1);
      }
      
      public function sound_buttonRollover() : void
      {
         soundM.createSound("buttonRollover",1);
      }
      
      public function createIconFromSizer(param1:String, param2:String, param3:Boolean) : void
      {
         var _loc5_:MovieClip = null;
         var _loc4_:Sprite = this[param1]["mcSizer_" + param2];
         if(param3)
         {
            this[param1]["mc_" + param2] = externalAssetsM.getAsset("general",param2,_loc4_.width,_loc4_.height,false,false);
            this[param1]["mc_" + param2].x = _loc4_.x;
            this[param1]["mc_" + param2].y = _loc4_.y;
            this[param1].mcIconsHolder.addChild(this[param1]["mc_" + param2]);
         }
         else
         {
            _loc5_ = externalAssetsM.getAsset("general",param2,_loc4_.width,_loc4_.height,false,false);
            _loc5_.x = _loc4_.x;
            _loc5_.y = _loc4_.y;
            this[param1].mcIconsHolder.addChild(_loc5_);
         }
      }
      
      private function mobileToolTipHandler() : void
      {
         if(dataM.runAsMobile)
         {
            if(this._openToolTipFunction != null)
            {
               if(this._openToolTipFrameCountdown > 0)
               {
                  --this._openToolTipFrameCountdown;
                  if(this._openToolTipFrameCountdown == 0)
                  {
                     if(this._openToolTipParameter_number > -1)
                     {
                        this._openToolTipFunction(this._openToolTipParameter_number);
                     }
                     else if(this._openToolTipParameter_string != "")
                     {
                        this._openToolTipFunction(this._openToolTipParameter_string);
                     }
                     else
                     {
                        this._openToolTipFunction();
                     }
                     this.resetMobileToolTipActivation(false);
                  }
               }
            }
         }
      }
      
      private function setMobileToolTipActivation(param1:Function, param2:Number = -1, param3:String = "", param4:uint = 10) : void
      {
         this._openToolTipFrameCountdown = param4;
         this._openToolTipFunction = param1;
         this._openToolTipParameter_number = param2;
         this._openToolTipParameter_string = param3;
      }
      
      private function resetMobileToolTipActivation(param1:Boolean) : void
      {
         if(param1)
         {
            tooltip.hideToolTip();
         }
         this._openToolTipFrameCountdown = 0;
         this._openToolTipFunction = null;
         this._openToolTipParameter_number = -1;
         this._openToolTipParameter_string = "";
      }
      
      public function readdScreen(param1:String) : void
      {
         if(this[param1] != null)
         {
            if(this[param1].parent != null)
            {
               this[param1].parent.removeChild(this[param1]);
            }
            this.addScreenIntoLayer(param1);
         }
      }
      
      public function addIfNotOpened(param1:String, param2:Boolean = true) : void
      {
         if(this.isScreenOpened(param1))
         {
            return;
         }
         this.addScreen(param1,param2);
      }
      
      public function addScreen(param1:String, param2:Boolean = true, param3:Class = null) : void
      {
         if(this[param1] == null)
         {
            switch(param1)
            {
               case "screenWelcomeBackground":
                  this.screenWelcomeBackground = new BMScreenWelcomeBackground();
                  break;
               case "screenSelectBattleMechsPerPlayer":
                  this.screenSelectBattleMechsPerPlayer = new BMScreenSelectBattleMechsPerPlayer();
                  break;
               case "screenWelcomeLogin":
                  this.screenWelcomeLogin = new BMScreenWelcomeLogin();
                  break;
               case "screenWelcomeLoginAs":
                  this.screenWelcomeLoginAs = new BMScreenWelcomeLoginAs();
                  break;
               case "screenWelcomeNewExisting":
                  this.screenWelcomeNewExisting = new BMScreenWelcomeNewExisting();
                  break;
               case "screenSMTV":
                  this.screenSMTV = new BMScreenSMTV();
                  break;
               case "screenGlobalShop":
                  this.screenGlobalShop = new BMScreenGlobalShop();
                  break;
               case "screenMorePaymentOptions":
                  this.screenMorePaymentOptions = new BMScreenMorePaymentOptions();
                  break;
               case "screenBuyGold":
                  this.screenBuyGold = new BMScreenBuyGold();
                  break;
               case "screenLostConnection":
                  this.screenLostConnection = new BMScreenLostConnection();
                  break;
               case "screenBuyAnotherItemBox":
                  this.screenBuyAnotherItemBox = new BMScreenBuyAnotherItemBox();
                  break;
               case "screenBuyStarterPack":
                  this.screenBuyStarterPack = new BMScreenBuyStarterPack();
                  break;
               case "screenGetTokens":
                  this.screenGetTokens = new BMScreenGetTokens();
                  break;
               case "screenRegister":
                  this.screenRegister = new BMScreenRegister();
                  break;
               case "screenRegisterOffer":
                  this.screenRegisterOffer = new BMScreenRegisterOffer();
                  break;
               case "screenMultiPlayerChat":
                  this.screenMultiPlayerChat = new BMScreenMultiPlayerChat();
                  break;
               case "screenMultiPlayerLadder":
                  this.screenMultiPlayerLadder = new BMScreenMultiPlayerLadder();
                  break;
               case "screenBattle":
                  this.screenBattle = new BMScreenBattle();
                  break;
               case "screenBattleResult":
                  this.screenBattleResult = new BMScreenBattleResult();
                  break;
               case "screenHangerBackground":
                  this.screenHangerBackground = new BMScreenHangerBackground();
                  break;
               case "screenBuyItem":
                  this.screenBuyItem = new BMScreenBuyItem();
                  break;
               case "screenBuyItemBox":
                  this.screenBuyItemBox = new BMScreenBuyItemBox();
                  break;
               case "screenHangerMenu":
                  this.screenHangerMenu = new BMScreenHangerMenu();
                  break;
               case "screenHangerInventory":
                  this.screenHangerInventory = new BMScreenHangerInventory();
                  break;
               case "screenHangerMech":
                  this.screenHangerMech = new BMScreenHangerMech();
                  break;
               case "screenHangerItemComparison":
                  this.screenHangerItemComparison = new BMScreenHangerItemComparison();
                  break;
               case "screenConfirmation":
                  this.screenConfirmation = new BMScreenConfirmation();
                  break;
               case "screenCraftMythicals":
                  this.screenCraftMythicals = new BMScreenCraftMythicals();
                  break;
               case "screenExtraOptions":
                  this.screenExtraOptions = new BMScreenExtraOptions();
                  break;
               case "screenBattleInterfaceBottom":
                  this.screenBattleInterfaceBottom = new BMScreenBattleInterfaceBottom();
                  break;
               case "screenBattleInterfaceEmotes":
                  this.screenBattleInterfaceEmotes = new BMScreenBattleInterfaceEmotes();
                  break;
               case "screenBattleInterfaceTop":
                  this.screenBattleInterfaceTop = new BMScreenBattleInterfaceTop();
                  break;
               case "screenRankingList":
                  this.screenRankingList = new BMScreenRankingList();
                  break;
               case "screenSearchForClan":
                  this.screenSearchForClan = new BMScreenSearchForClan();
                  break;
               case "screenServerRestartCountdown":
                  this.screenServerRestartCountdown = new BMScreenServerRestartCountdown();
                  break;
               case "screenTopBar":
                  this.screenTopBar = new BMScreenTopBar();
                  break;
               case "screenTopBarNew":
                  this.screenTopBarNew = new BMScreenTopBarNew();
                  break;
               case "screenVS":
                  this.screenVS = new BMScreenVS();
                  break;
               case "screenFPSTracker":
                  this.screenFPSTracker = new BMScreenFPSTracker();
                  break;
               case "screenBlack":
                  this.screenBlack = new BMScreenBlack();
                  break;
               case "screenReplays":
                  this.screenReplays = new BMScreenReplays();
                  break;
               case "screenSkipTutorial":
                  this.screenSkipTutorial = new BMScreenSkipTutorial();
                  break;
               case "screenHelp":
                  this.screenHelp = new BMScreenHelp();
                  break;
               case "screenAdminTools":
                  this.screenAdminTools = new BMScreenAdminTools();
                  break;
               case "screenSpecialOffers":
                  this.screenSpecialOffers = new param3();
                  break;
               case "screenNews":
                  this.screenNews = new BMScreenNews();
                  break;
               case "screenNewMenu":
                  this.screenNewMenu = new BMScreenNewMenu();
                  break;
               case "screenMainMenu":
                  this.screenMainMenu = new BMScreenMainMenu();
                  break;
               case "screenBattleOptions":
                  this.screenBattleOptions = new BMScreenBattleOptions();
                  break;
               case "screenProfileOptions":
                  this.screenProfileOptions = new BMScreenProfileOptions();
                  break;
               case "screenProfileAccounts":
                  this.screenProfileAccounts = new BMScreenProfileAccounts();
                  break;
               case "screenInspectPlayer":
                  this.screenInspectPlayer = new BMScreenInspectPlayer();
                  break;
               case "screenPopUp":
                  this.screenPopUp = new BMScreenPopUp();
                  break;
               case "screenProfileInfo":
                  this.screenProfileInfo = new BMScreenProfileInfo();
                  break;
               case "screenAchievements":
                  this.screenAchievements = new BMScreenAchievements();
                  break;
               case "screenAchievementUnlocked":
                  this.screenAchievementUnlocked = new BMScreenAchievementUnlocked();
                  break;
               case "screenWorldMapSelectBattle":
                  this.screenWorldMapSelectBattle = new BMScreenWorldMapSelectBattle();
                  break;
               case "screenItemCards":
                  this.screenItemCards = new BMScreenItemCards();
                  break;
               case "screenHangerFusion":
                  this.screenHangerFusion = new BMScreenHangerFusion();
                  break;
               case "screenHangerShop":
                  this.screenHangerShop = new BMScreenHangerShop();
                  break;
               case "screenMenuMultiPlayerInspect":
                  this.screenMenuMultiPlayerInspect = new BMScreenMenuMultiPlayerInspect();
                  break;
               case "screenLadderStatus":
                  this.screenLadderStatus = new BMScreenLadderStatus();
                  break;
               case "screenLevelUp":
                  this.screenLevelUp = new BMScreenLevelUp();
                  break;
               case "screenLevelUpEntry":
                  this.screenLevelUpEntry = new BMScreenLevelUpEntry();
                  break;
               case "screenBuyBattleCredits":
                  this.screenBuyBattleCredits = new BMScreenBuyBattleCredits();
                  break;
               case "screenBuyBattleCreditsWithVideo":
                  this.screenBuyBattleCreditsWithVideo = new BMScreenBuyBattleCreditsWithVideo();
                  break;
               case "screenBuyMissions":
                  this.screenBuyMissions = new BMScreenBuyMissions();
                  break;
               case "screenClanCreate":
                  this.screenClanCreate = new BMScreenClanCreate();
                  break;
               case "screenClanFlag":
                  this.screenClanFlag = new BMScreenClanFlag();
                  break;
               case "screenChangeName":
                  this.screenChangeName = new BMScreenChangeName();
                  break;
               case "screenSendTokensToPlayer":
                  this.screenSendTokensToPlayer = new BMScreenSendTokensToPlayer();
                  break;
               case "screenOpeningSequence":
                  this.screenOpeningSequence = new BMScreenOpeningSequence();
                  break;
               case "screenMythicalCrafted":
                  this.screenMythicalCrafted = new BMScreenMythicalCrafted();
                  break;
               case "screenChangeMechsOrder":
                  this.screenChangeMechsOrder = new BMScreenChangeMechsOrder();
                  break;
               case "screenClan":
                  this.screenClan = new BMScreenClan();
                  break;
               case "screenDailyLoginStreakBonus":
                  this.screenDailyLoginStreakBonus = new BMScreenDailyLoginStreakBonus();
                  break;
               case "screenMissionBaseMap":
                  this.screenMissionBaseMap = new BMScreenMissionBaseMap();
                  break;
               case "screenMissionWorldMap":
                  this.screenMissionWorldMap = new BMScreenMissionWorldMap();
                  break;
               case "screenMissionWorldMapInterface":
                  this.screenMissionWorldMapInterface = new BMScreenMissionWorldMapInterface();
                  break;
               case "screenMissionCompleted":
                  this.screenMissionCompleted = new BMScreenMissionCompleted();
                  break;
               case "screenHangerGiftKeys":
                  this.screenHangerGiftKeys = new BMScreenHangerGiftKeys();
                  break;
               case "screenHangerInsertGiftKey":
                  this.screenHangerInsertGiftKey = new BMScreenHangerInsertGiftKey();
                  break;
               case "screenSearchForPlayer":
                  this.screenSearchForPlayer = new BMScreenSearchForPlayer();
                  break;
               case "screenYouTubeVidsGuide":
                  this.screenYouTubeVidsGuide = new BMScreenYouTubeVidsGuide();
                  break;
               case "screenSelectAccount":
                  this.screenSelectAccount = new BMScreenSelectAccount();
                  break;
               case "screenWatchRewardedVideo":
                  this.screenWatchRewardedVideo = new BMScreenWatchRewardedVideo();
                  break;
               case "screenLanguageSelection":
                  this.screenLanguageSelection = new BMScreenLanguageSelection();
                  break;
               case "screenReconnecting":
                  this.screenReconnecting = new BMScreenReconnecting();
                  break;
               case "screenDebugger":
                  this.screenDebugger = new BMScreenDebugger();
                  break;
               case "screenMechGenerator":
                  this.screenMechGenerator = new BMScreenMechGenerator();
            }
            this[param1].name = param1;
            this[param1].initialize();
         }
         if(param2 && this[param1].parent == null)
         {
            this.addScreenIntoLayer(param1);
            this.openedScrenes[param1] = param1;
            this.refreshSecondaryBattleScreensCheck();
            this.traceOpenedScreens("addScreen");
            if(this.clientPointer.launchScreen != null)
            {
               this.clientPointer.setChildIndex(this.clientPointer.launchScreen,this.clientPointer.numChildren - 1);
            }
         }
      }
      
      public function readdScreenIntoTopLayer(param1:String) : void
      {
         if(this[param1].parent != null)
         {
            this[param1].parent.removeChild(this[param1]);
            this.topLayer.addChild(this[param1]);
         }
      }
      
      private function addScreenIntoLayer(param1:String) : void
      {
         switch(param1)
         {
            case "screenConfirmation":
            case "screenMissionCompleted":
            case "screenLevelUpEntry":
            case "screenLevelUp":
            case "screenBattleOptions":
            case "screenItemCards":
            case "screenPopUp":
            case "screenBuyAnotherItemBox":
            case "screenGlobalShop":
            case "screenMorePaymentOptions":
            case "screenBuyGold":
            case "screenGetTokens":
            case "screenBuyBattleCredits":
            case "screenBuyBattleCreditsWithVideo":
            case "screenBuyMissions":
            case "screenClanCreate":
            case "screenHangerInsertGiftKey":
            case "screenInspectPlayer":
            case "screenChangeName":
            case "screenSendTokensToPlayer":
            case "screenMythicalCrafted":
            case "screenOpeningSequence":
            case "screenCraftMythicals":
            case "screenExtraOptions":
            case "screenChangeMechsOrder":
            case "screenYouTubeVidsGuide":
            case "screenBuyItem":
            case "screenBuyItemBox":
            case "screenBuyGold":
            case "screenSelectAccount":
            case "screenWatchRewardedVideo":
            case "screenLanguageSelection":
            case "screenMechGenerator":
            case "screenWelcomeLoginAs":
            case "screenSpecialOffers":
               this.topLayer.addChild(this[param1]);
               break;
            case "screenTopBar":
            case "screenTopBarNew":
            case "screenSkipTutorial":
            case "screenVS":
            case "screenSelectBattleMechsPerPlayer":
            case "screenSearchForPlayer":
            case "screenMenuMultiPlayerInspect":
            case "screenMainMenu":
               this.middleLayer.addChild(this[param1]);
               break;
            case "screenHangerMenu":
               this.semiMiddleLayer.addChild(this[param1]);
               break;
            case "screenDebugger":
            case "screenAchievementUnlocked":
            case "screenBlack":
            case "screenLostConnection":
            case "screenServerRestartCountdown":
            case "screenReconnecting":
               this.superTopLayer.addChild(this[param1]);
               break;
            default:
               this.bottomLayer.addChild(this[param1]);
         }
      }
      
      public function removeScreen(param1:String) : void
      {
         if(this[param1] != null)
         {
            if(this[param1].parent != null)
            {
               this[param1].parent.removeChild(this[param1]);
               this.openedScrenes[this[param1].name] = "";
               this.refreshSecondaryBattleScreensCheck();
               this.traceOpenedScreens("removeScreen");
               switch(this[param1].name)
               {
                  case "screenConfirmation":
                     this.screenConfirmation.removeMe();
                     break;
                  default:
                     this[param1] = null;
               }
            }
         }
      }
      
      public function forceBackToLoginScreen() : void
      {
         TsLogger.log("BMScreensManager :: forceBackToLoginScreen");
         this.screenBlack.activateBlackScreen(this.forceBackToLoginScreenSub,false,true,null,0);
      }
      
      public function forceBackToLoginScreenSub() : void
      {
         this.resetClient();
         this.removeScreen("screenWelcomeBackground");
         this.addScreen("screenWelcomeBackground");
         this.screenWelcomeBackground.refreshScreen(true);
         this.screenWelcomeBackground.resetWelcomeBack();
      }
      
      private function resetScreens() : void
      {
         if(this.isScreenOpened("screenBattle"))
         {
            if(this.isScreenOpened("screenLadderStatus"))
            {
               this.removeScreen("screenLadderStatus");
            }
            this.screenBattle.cleanBattle(true);
            this.removeScreen("screenBattleOptions");
         }
         else if(this.isScreenOpened("screenWelcomeBackground"))
         {
            if(this.isScreenOpened("screenDailyLoginStreakBonus"))
            {
               this.screenDailyLoginStreakBonus.removeMe();
            }
            if(this.isScreenOpened("screenMissionCompleted"))
            {
               this.screenMissionCompleted.removeMe();
            }
            if(this.isScreenOpened("screenChangeName"))
            {
               this.screenChangeName.removeMe();
            }
         }
         else if(this.isScreenOpened("screenNewMenu"))
         {
            this.screenNewMenu.removeCurrentScreen();
            this.screenNewMenu.removeMe();
         }
         else if(this.isScreenOpened("screenMissionBaseMap"))
         {
            this.screenMissionBaseMap.removeMe();
            if(this.isScreenOpened("screenMissionCompleted"))
            {
               this.screenMissionCompleted.removeMe();
            }
            this.removeScreen("screenTopBar");
            this.removeScreen("screenBuyBattleCredits");
            this.removeScreen("screenBuyBattleCreditsWithVideo");
         }
         else if(this.isScreenOpened("screenBuyStarterPack"))
         {
            this.screenBuyStarterPack.removeMe();
            this.removeScreen("screenBuyStarterPack");
            this.removeScreen("screenTopBar");
         }
         if(this.isScreenOpened("screenBuyBattleCredits"))
         {
            this.screenBuyBattleCredits.backClicked();
         }
         else if(this.isScreenOpened("screenBuyBattleCreditsWithVideo"))
         {
            this.screenBuyBattleCreditsWithVideo.backClicked();
         }
         if(this.isScreenOpened("screenServerRestartCountdown"))
         {
            this.removeScreen("screenServerRestartCountdown");
         }
         if(this.isScreenOpened("screenGlobalShop"))
         {
            this.screenGlobalShop.closeClicked();
         }
         if(this.isScreenOpened("screenBuyGold"))
         {
            this.screenBuyGold.backClicked();
         }
         if(this.isScreenOpened("screenInspectPlayer"))
         {
            this.screenInspectPlayer.backClicked();
         }
         if(this.isScreenOpened("screenGetTokens"))
         {
            this.screenGetTokens.backClicked();
         }
         if(this.isScreenOpened("screenHangerMenu"))
         {
            this.screenHangerMenu.removeHanger();
         }
         this.removeScreen("screenLostConnection");
         this.removeScreen("screenAdminTools");
         this.removeScreen("screenConfirmation");
         this.removeScreen("screenWelcomeNewExisting");
         this.removeScreen("screenPopUp");
         this.removeScreen("screenLevelUp");
         this.removeScreen("screenTopBarNew");
         this.removeScreen("screenMainMenu");
         tooltip.hideToolTip();
         if(this.isScreenOpened("screenWelcomeLogin"))
         {
            this.removeScreen("screenWelcomeLogin");
         }
         BMSpecialOffersManager.gi().removeSpecialOffer();
         this.removeScreen("screenGlobalShop");
      }
      
      public function resetClient() : void
      {
         BMLoginManager.gi().disconnect();
         this.resetScreens();
         dataM.guestRegistrationActive = false;
         dataM.battle_gamePaused = false;
         dataM.battle_syncData = new Object();
         dataM.premiumAccountTime = 0;
         dataM.tutorialEnabled = false;
         dataM.register_termsOfUseChecked = false;
         dataM.mission_battleEnded = false;
         dataM.hanger_newItemsForDisplay = new Array();
         dataM.missionWorldMap_missionCompletedSlot = -1;
         dataM.mechEquipment_playerItemIDsUpgraded = new Object();
         dataM.onlinePlayersInspect_playerID = 0;
         dataM.chat_initialized = false;
         dataM.chat_lastChatChannel = 0;
         dataM.chat_gotRecentClanMessagesThisLogin = false;
         dataM.replays_loaded = false;
         dataM.topBar_levelUpInProgress = false;
         dataM.nextWeeklyReset = "";
         dataM.iAmBannedFromChat = false;
         dataM.rankingList_allTime = null;
         dataM.rankingList_weekly = null;
         dataM.rankingList_online = null;
         dataM.getTokens_displayAfterOnlineBattleCounter = 0;
         dataM.getTokens_displayAfterSinglePlayerMissionCounter = 0;
         dataM.starterPack_displayAfterOnlineBattleCounter = 3;
         dataM.starterPack_displayAfterSinglePlayerMissionCounter = 3;
         dataM.callingRankingListEnabled = true;
         dataM.battleInvitations = new Object();
         dataM.blockedBattleInvitations = new Object();
         dataM.clanInvitations = new Object();
         dataM.tutorialSkipped = false;
         dataM.battleInvitationsEnabled = true;
         dataM.battle_goToChatAfterBattle = false;
         dataM.battle_inviteToClanAfterBattle = false;
         dataM.userID = 0;
         dataM.advertisingCampaignID = 0;
         dataM.avatarLink = "";
         dataM.newItemsCreated = new Array();
         dataM.clansAroundMyLadderProgress = new Object();
         dataM.campaignBattleType = 1;
         this.screenConfirmation.resetUrgentMessage();
         dataM.sessionManager.switchToServerReset();
         dataM.cancelTokenPolling();
         BMLoginManager.gi().reset();
      }
      
      private function refreshSecondaryBattleScreensCheck() : void
      {
         this.secondaryBattleScreensOpened = false;
         if(this.isScreenOpened("screenVS") || this.isScreenOpened("screenBattleOptions") || this.isScreenOpened("screenConfirmation") || this.isScreenOpened("screenBattleResult") || this.isScreenOpened("screenPopUp"))
         {
            this.secondaryBattleScreensOpened = true;
         }
         this.secondaryBattleScreensOpenedIgnoringBattleBonus = false;
         if(this.isScreenOpened("screenVS") || this.isScreenOpened("screenBattleOptions") || this.isScreenOpened("screenConfirmation") || this.isScreenOpened("screenBattleResult") || this.isScreenOpened("screenPopUp"))
         {
            this.secondaryBattleScreensOpenedIgnoringBattleBonus = true;
         }
      }
      
      public function isScreenOpened(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         if(this[param1] != null)
         {
            if(this.openedScrenes[param1] != null)
            {
               if(this.openedScrenes[param1] != "")
               {
                  _loc2_ = Boolean(this.openedScrenes[param1]);
               }
            }
         }
         return _loc2_;
      }
      
      private function getDisplayObjectLayer(param1:DisplayObjectContainer) : *
      {
         if(param1 == null)
         {
            TsLogger.log("getDisplayObjectLayer could not resolve!");
            return -1;
         }
         if(param1 == this.bottomLayer)
         {
            return 0;
         }
         if(param1 == this.semiMiddleLayer)
         {
            return 1;
         }
         if(param1 == this.middleLayer)
         {
            return 2;
         }
         if(param1 == this.topLayer)
         {
            return 3;
         }
         if(param1 == this.superTopLayer)
         {
            return 4;
         }
         return this.getDisplayObjectLayer(param1.parent);
      }
      
      private function sortCompareByLayer(param1:DisplayObjectContainer, param2:DisplayObjectContainer) : int
      {
         var _loc3_:int = this.getDisplayObjectLayer(param1);
         var _loc4_:int = this.getDisplayObjectLayer(param2);
         var _loc5_:int = _loc3_ - _loc4_;
         return _loc5_ > 0 ? 1 : (_loc5_ < 0 ? -1 : 0);
      }
      
      public function notifyClientDataReloaded() : *
      {
         var _loc2_:String = null;
         var _loc3_:BMBaseScreen = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.openedScrenes)
         {
            if(_loc2_ != "")
            {
               _loc1_.push(this[_loc2_]);
            }
         }
         _loc1_.sort(this.sortCompareByLayer);
         for each(_loc3_ in _loc1_)
         {
            _loc3_.notifyClientDataReloaded();
         }
      }
      
      private function traceOpenedScreens(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = "";
         for each(_loc3_ in this.openedScrenes)
         {
            if(_loc3_ != "")
            {
               _loc2_ = _loc2_ + " " + _loc3_;
            }
         }
      }
      
      public function createTextBitmap(param1:String, param2:TextField, param3:String, param4:Sprite) : void
      {
         if(this.textsBitmapData[param1] != null)
         {
            this.textsBitmapData[param1].dispose();
            this.textsBitmapData[param1] = null;
         }
         if(this.textsBitmap[param1] != null)
         {
            if(this.textsBitmap[param1].parent != null)
            {
               this.textsBitmap[param1].parent.removeChild(this.textsBitmap[param1]);
            }
            this.textsBitmap[param1] = null;
         }
         switch(param3)
         {
            case " ":
               break;
            default:
               param2.filters = [new GlowFilter(0,1,2,2,10,3,false,false)];
         }
         if(param2.parent != null)
         {
            param2.parent.removeChild(param2);
         }
         var _loc5_:MovieClip = new MovieClip();
         _loc5_.x = param2.x;
         _loc5_.y = param2.y;
         param2.x = 0;
         param2.y = 0;
         _loc5_.addChild(param2);
         var _loc6_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         var _loc7_:Bitmap = new Bitmap(_loc6_);
         _loc6_.draw(_loc5_);
         _loc7_.smoothing = true;
         _loc7_.x = _loc5_.x;
         _loc7_.y = _loc5_.y;
         _loc5_.removeChild(param2);
         param2.x = _loc5_.x;
         param2.y = _loc5_.y;
         this.textsBitmapData[param1] = _loc6_;
         this.textsBitmap[param1] = _loc7_;
         param2.filters = [];
         param4.addChild(_loc7_);
      }
      
      public function createMultipleTextsBitmap(param1:String, param2:Array, param3:String, param4:Sprite) : void
      {
         var _loc9_:uint = 0;
         this.removeMultipleTextsBitmap(param1);
         var _loc5_:MovieClip = new MovieClip();
         var _loc6_:TextField = param2[0];
         var _loc7_:Number = _loc6_.x;
         var _loc8_:Number = _loc6_.y;
         _loc9_ = 0;
         while(_loc9_ < param2.length)
         {
            _loc6_ = param2[_loc9_];
            switch(param3)
            {
               case " ":
                  break;
               default:
                  _loc6_.filters = [new GlowFilter(0,1,2,2,10,3,false,false)];
            }
            if(_loc7_ > _loc6_.x)
            {
               _loc7_ = _loc6_.x;
            }
            if(_loc8_ > _loc6_.y)
            {
               _loc8_ = _loc6_.y;
            }
            if(_loc6_.parent != null)
            {
               _loc6_.parent.removeChild(_loc6_);
            }
            _loc9_++;
         }
         _loc5_.x = _loc7_;
         _loc5_.y = _loc8_;
         _loc9_ = 0;
         while(_loc9_ < param2.length)
         {
            _loc6_ = param2[_loc9_];
            _loc6_.x -= _loc7_;
            _loc6_.y -= _loc8_;
            _loc5_.addChild(_loc6_);
            _loc9_++;
         }
         var _loc10_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         var _loc11_:Bitmap = new Bitmap(_loc10_);
         _loc10_.draw(_loc5_);
         _loc11_.smoothing = true;
         _loc11_.x = _loc5_.x;
         _loc11_.y = _loc5_.y;
         _loc9_ = 0;
         while(_loc9_ < param2.length)
         {
            _loc6_ = param2[_loc9_];
            _loc5_.removeChild(_loc6_);
            _loc6_.x += _loc7_;
            _loc6_.y += _loc8_;
            _loc6_.filters = [];
            _loc9_++;
         }
         this.textsBitmapData[param1] = _loc10_;
         this.textsBitmap[param1] = _loc11_;
         param4.addChild(_loc11_);
      }
      
      public function removeMultipleTextsBitmap(param1:String) : void
      {
         if(this.textsBitmapData[param1] != null)
         {
            this.textsBitmapData[param1].dispose();
            this.textsBitmapData[param1] = null;
         }
         if(this.textsBitmap[param1] != null)
         {
            if(this.textsBitmap[param1].parent != null)
            {
               this.textsBitmap[param1].parent.removeChild(this.textsBitmap[param1]);
            }
            this.textsBitmap[param1] = null;
         }
      }
      
      public function createAssetsBitmap(param1:Array, param2:Array, param3:Number, param4:Number) : Array
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:MovieClip = null;
         var _loc10_:uint = 0;
         var _loc11_:BitmapData = null;
         var _loc12_:Bitmap = null;
         var _loc13_:Array = null;
         if(param2.length == 0 && param1.length == 0)
         {
            return new Array(new BitmapData(2,2,true,0),new Bitmap());
         }
         if(param1 == null)
         {
            param1 = new Array();
         }
         if(param2 == null)
         {
            param2 = new Array();
         }
         if(param1.length > 0)
         {
            _loc5_ = Number(param1[0].x);
            _loc6_ = Number(param1[0].y);
            _loc7_ = param1[0].x + param1[0].width;
            _loc8_ = param1[0].y + param1[0].height;
         }
         else
         {
            _loc5_ = Number(param2[0].x);
            _loc6_ = Number(param2[0].y);
            _loc7_ = param2[0].x + param2[0].width;
            _loc8_ = param2[0].y + param2[0].height;
         }
         _loc9_ = new MovieClip();
         _loc10_ = 0;
         while(_loc10_ < param2.length)
         {
            if(_loc5_ > param2[_loc10_].x)
            {
               _loc5_ = Number(param2[_loc10_].x);
            }
            if(_loc6_ > param2[_loc10_].y)
            {
               _loc6_ = Number(param2[_loc10_].y);
            }
            if(_loc7_ < param2[_loc10_].x + param2[_loc10_].width)
            {
               _loc7_ = param2[_loc10_].x + param2[_loc10_].width;
            }
            if(_loc8_ < param2[_loc10_].y + param2[_loc10_].height)
            {
               _loc8_ = param2[_loc10_].y + param2[_loc10_].height;
            }
            _loc9_.addChild(param2[_loc10_]);
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < param1.length)
         {
            if(_loc5_ > param1[_loc10_].x)
            {
               _loc5_ = Number(param1[_loc10_].x);
            }
            if(_loc6_ > param1[_loc10_].y)
            {
               _loc6_ = Number(param1[_loc10_].y);
            }
            if(_loc7_ < param1[_loc10_].x + param1[_loc10_].width)
            {
               _loc7_ = param1[_loc10_].x + param1[_loc10_].width;
            }
            if(_loc8_ < param1[_loc10_].y + param1[_loc10_].height)
            {
               _loc8_ = param1[_loc10_].y + param1[_loc10_].height;
            }
            _loc9_.addChild(param1[_loc10_]);
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < param2.length)
         {
            param2[_loc10_].x -= _loc5_ - param3;
            param2[_loc10_].y -= _loc6_ - param4;
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < param1.length)
         {
            param1[_loc10_].x -= _loc5_ - param3;
            param1[_loc10_].y -= _loc6_ - param4;
            _loc10_++;
         }
         if(param3 > 0 || param4 > 0)
         {
            _loc9_.graphics.beginFill(0,0);
            _loc9_.graphics.drawRect(0,0,-_loc5_ + _loc7_ + param3 * 2,-_loc6_ + _loc8_ + param4 * 2);
         }
         _loc11_ = new BitmapData(-_loc5_ + _loc7_ + param3 * 2,-_loc6_ + _loc8_ + param4 * 2,true,0);
         _loc12_ = new Bitmap(_loc11_);
         _loc11_.draw(_loc9_);
         _loc12_.x = _loc5_ - param3;
         _loc12_.y = _loc6_ - param4;
         _loc10_ = 0;
         while(_loc10_ < param2.length)
         {
            param2[_loc10_].x += _loc5_ - param3;
            param2[_loc10_].y += _loc6_ - param4;
            _loc9_.removeChild(param2[_loc10_]);
            if(param2[_loc10_].parent != null)
            {
               param2[_loc10_].parent.removeChild(param2[_loc10_]);
            }
            _loc10_++;
         }
         _loc10_ = 0;
         while(_loc10_ < param1.length)
         {
            param1[_loc10_].x += _loc5_ - param3;
            param1[_loc10_].y += _loc6_ - param4;
            _loc9_.removeChild(param1[_loc10_]);
            if(param1[_loc10_].parent != null)
            {
               param1[_loc10_].parent.removeChild(param1[_loc10_]);
            }
            _loc10_++;
         }
         _loc13_ = new Array();
         _loc13_.push(_loc11_,_loc12_);
         return _loc13_;
      }
      
      private function addTopBottomBordersForMobile() : void
      {
      }
      
      public function topBottomBordersForMobile_displayTitle() : void
      {
         if(this.topBottomBordersForMobile != null)
         {
            this._topBottomBordersForMobile_animationActive = true;
            this._topBottomBordersForMobile_visible = true;
            this._topBottomBordersForMobile_showDelayFrames = 20;
         }
      }
      
      public function topBottomBordersForMobile_hideTitle() : void
      {
         if(this.topBottomBordersForMobile != null)
         {
            this._topBottomBordersForMobile_animationActive = true;
            this._topBottomBordersForMobile_visible = false;
         }
      }
      
      private function topBottomBordersForMobileHandler() : void
      {
         var _loc1_:Number = NaN;
         if(this.topBottomBordersForMobile != null)
         {
            if(this._topBottomBordersForMobile_animationActive)
            {
               _loc1_ = _loc1_ = this._topBottomBordersForMobile_originYPos - this.topBottomBordersForMobile.mcTitle.y;
               if(this._topBottomBordersForMobile_visible)
               {
                  if(this._topBottomBordersForMobile_showDelayFrames > 0)
                  {
                     --this._topBottomBordersForMobile_showDelayFrames;
                  }
                  else if(_loc1_ < 2)
                  {
                     this.topBottomBordersForMobile.mcTitle.y = this._topBottomBordersForMobile_originYPos;
                     this._topBottomBordersForMobile_animationActive = false;
                  }
                  else
                  {
                     this.topBottomBordersForMobile.mcTitle.y += _loc1_ * 0.3;
                  }
               }
               else if(_loc1_ > 98)
               {
                  this.topBottomBordersForMobile.mcTitle.y = this._topBottomBordersForMobile_originYPos - 100;
                  this._topBottomBordersForMobile_animationActive = false;
               }
               else
               {
                  this.topBottomBordersForMobile.mcTitle.y -= _loc1_ + 1;
               }
            }
         }
      }
      
      public function openRegisterScreenFromGuest() : void
      {
         dataM.guestRegistrationActive = true;
         this.addIfNotOpened("screenWelcomeBackground");
         this.addScreen("screenRegister");
         this.screenWelcomeBackground.refreshScreen(true);
         this.screenRegister.refreshScreen();
         if(this.isScreenOpened("screenMissionBaseMap"))
         {
            this.screenMissionBaseMap.removeMe();
            this.removeScreen("screenTopBar");
         }
         else if(this.isScreenOpened("screenNewMenu"))
         {
            this.screenNewMenu.removeCurrentScreen();
            this.screenNewMenu.removeMe();
         }
      }
      
      public function activateFullScreenMode() : void
      {
         stage.displayState = StageDisplayState.FULL_SCREEN;
      }
      
      public function activateWindowMode() : void
      {
         stage.displayState = StageDisplayState.NORMAL;
      }
      
      private function createDebuggerButton() : void
      {
         this.btnDebugger = new BMButton_pictureE();
         this.btnDebugger.initialize("","",externalAssetsM.getAsset("general","interface_debugger"),[],this.debuggerClicked,false);
         this.btnDebugger.x = 80;
         this.btnDebugger.y = 0;
         this.btnDebugger.width = 30;
         this.btnDebugger.height = 30;
         addChild(this.btnDebugger);
         this.btnDebugger.visible = false;
         if(dataM.clientRunningLocally)
         {
            this.btnDebugger.visible = true;
         }
      }
      
      private function debuggerClicked() : void
      {
         this.removeScreen("screenDebugger");
         this.addScreen("screenDebugger");
         this.screenDebugger.refreshScreen();
      }
   }
}

