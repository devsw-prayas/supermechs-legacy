package net.battleMechsMulti.managers
{
   import com.distriqt.extension.application.Application;
   import com.distriqt.extension.application.Device;
   import com.distriqt.extension.applicationrater.ApplicationRater;
   import com.distriqt.extension.applicationrater.events.ApplicationIDEvent;
   import com.distriqt.extension.applicationrater.events.ApplicationRaterEvent;
   import com.distriqt.extension.core.Core;
   import com.greensock.TweenMax;
   import deng.fzip.FZip;
   import deng.fzip.FZipFile;
   import fl.motion.Color;
   import flash.desktop.NativeApplication;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageQuality;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.InvokeEvent;
   import flash.events.ProgressEvent;
   import flash.events.UncaughtErrorEvent;
   import flash.external.ExternalInterface;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.globalization.DateTimeFormatter;
   import flash.net.LocalConnection;
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.navigateToURL;
   import flash.system.ApplicationDomain;
   import flash.system.Capabilities;
   import flash.system.LoaderContext;
   import flash.system.fscommand;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import libraries.uanalytics.tracker.AppTracker;
   import libraries.uanalytics.tracker.WebTracker;
   import libraries.uanalytics.tracking.Configuration;
   import libraries.uanalytics.tracking.Tracker;
   import mx.utils.Base64Encoder;
   import net.battleMechsMulti.data.BMBoostConfigDB;
   import net.battleMechsMulti.data.BMClanData;
   import net.battleMechsMulti.data.BMClanMemberData;
   import net.battleMechsMulti.data.BMDisplayRewardData;
   import net.battleMechsMulti.data.BMLevelUpData;
   import net.battleMechsMulti.data.BMMissionDefinitionRepository;
   import net.battleMechsMulti.data.BMRewardData;
   import net.battleMechsMulti.data.BattleTypeResolver;
   import net.battleMechsMulti.data.ClanWarPlayerData;
   import net.battleMechsMulti.data.InstallationData;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.data.LocalItemsDB;
   import net.battleMechsMulti.events.AndroidStoreEvent;
   import net.battleMechsMulti.helpers.BMCampaignMechsHelper;
   import net.battleMechsMulti.managers.ads.BMAdsManager;
   import net.battleMechsMulti.managers.ads.BMAdsManagerEvents;
   import net.battleMechsMulti.managers.basebuilding.BMBaseBuildingManager;
   import net.battleMechsMulti.managers.chat.BMChatData;
   import net.battleMechsMulti.managers.clanWars.BMClanWarsManager;
   import net.battleMechsMulti.managers.gameOfWhales.BMGameOfWhalesManager;
   import net.battleMechsMulti.managers.kin.BMKinManager;
   import net.battleMechsMulti.managers.mechBuilds.BMMechBuildsManager;
   import net.battleMechsMulti.managers.notifications.BMNotificationData;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   import net.battleMechsMulti.managers.quests.BMQuestsManager;
   import net.battleMechsMulti.managers.raid.BMRaidData;
   import net.battleMechsMulti.managers.shop.BMChainDiscountsResolver;
   import net.battleMechsMulti.managers.shop.BMGachaMachineData;
   import net.battleMechsMulti.managers.shop.BMPremiumPackageData;
   import net.battleMechsMulti.managers.shop.BMShopManager;
   import net.battleMechsMulti.managers.shop.BMVIPAccountData;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.managers.skills.BMMechStatsResolver;
   import net.battleMechsMulti.managers.skills.BMPlayerSkillsManager;
   import net.battleMechsMulti.managers.specialOffers.BMSpecialOffersManager;
   import net.battleMechsMulti.mobiles.BMAvatarImage;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMFriendshipData;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerItemDataTemplate;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMReplayAction;
   import net.battleMechsMulti.mobiles.BMReplayData;
   import net.battleMechsMulti.mobiles.BMReplayStatus;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.BMTokenPackage;
   import net.battleMechsMulti.mobiles.baseMapAssets.BMBaseMapTurret;
   import net.battleMechsMulti.mobiles.effects.BMEffectFireBeam;
   import net.battleMechsMulti.mobiles.itemComparison.BMMechBoostRecommender;
   import net.battleMechsMulti.mobiles.itemComparison.BMMechEquipmentRecommender;
   import net.battleMechsMulti.mobiles.itemComparison.BMOneClickBoostProperties;
   import net.battleMechsMulti.mobiles.mechView.BMMechViewManualColors;
   import net.battleMechsMulti.mobiles.unlockedMechSlotsResolver.BMUnlockedMechSlotsResolver;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapBossData;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   import net.battleMechsMulti.screens.BMScreenWatchRewardedVideo;
   import net.battleMechsMulti.screens.buyStarterPack.BMBuyStarterPackScreenChooser;
   import net.battleMechsMulti.screens.contentPackLibrary.BMContentPackResolver;
   import net.battleMechsMulti.screens.hanger.upgrade.BMMassSelectionData;
   import net.battleMechsMulti.screens.inventory.BMInventoryTileListItem;
   import net.battleMechsMulti.screens.ladderSeasonInfo.BMLadderSeasonEndRewardData;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   import net.battleMechsMulti.screens.missionBaseMap.BMMissionMechStats;
   import net.battleMechsMulti.screens.missionBaseMap.BMMissionServerToClientStats;
   import net.battleMechsMulti.screens.missionBaseMap.BMScreenMissionBaseMap;
   import net.battleMechsMulti.screens.multiplayerLadder.BMPVPWinningRewardPredictionData;
   import net.battleMechsMulti.screens.news.BMNewsHandler;
   import net.battleMechsMulti.screens.rewards.BMScreenDisplayReward;
   import net.battleMechsMulti.screens.screensDirector.BMScreensDirectorTask;
   import net.battleMechsMulti.screens.shop.BMClanShopData;
   import net.battleMechsMulti.screens.shop.BMItemsExtraChanceData;
   import net.battleMechsMulti.session.BMDomainResolver;
   import net.battleMechsMulti.session.BMPlatformUtils;
   import net.battleMechsMulti.session.LoginServices;
   import net.battleMechsMulti.utils.BMItemShadowImage;
   import net.battleMechsMulti.utils.BMPubSub;
   import net.battleMechsMulti.utils.FeatureFlags;
   import net.battleMechsMulti.utils.NameGenerator;
   import net.battleMechsMulti.utils.SyncRandom;
   import net.battleMechsMulti.utils.TextUtils;
   import net.battleMechsMulti.utils.TokenPolling;
   import net.tacticsoft.global.BMMClientFlashConsts;
   import net.tacticsoft.global.BMMClientFlashVars;
   import net.tacticsoft.utils.DetectedSettings;
   import net.tacticsoft.utils.RandomUtils;
   import net.tacticsoft.utils.SafeInt;
   
   public class BMDataManager extends BMBaseClass
   {
      
      private static var _instance:BMDataManager;
      
      private static var _allowInstantiation:Boolean;
      
      private static const UNIVERSAL_ANALYTICS_TRACKING_ID:String = "UA-1665200-12";
      
      public static const NEWS_CATEGORY_SALE:Number = 1;
      
      public static const BATTLE_RESULT_WIN:String = "youWon";
      
      public static const BATTLE_RESULT_LOSS:String = "youLost";
      
      public static const BATTLE_RESULT_OPPONENT_QUIT:String = "opponentQuit";
      
      public static const BATTLE_RESULT_PLAYER_QUIT:String = "playerQuit";
      
      public static const GAME_TYPE_NONE:uint = 0;
      
      public static const GAME_TYPE_TUTORIAL:uint = 1;
      
      public static const GAME_TYPE_TUTORIAL_PVE:uint = 2;
      
      public static const GAME_TYPE_DEFAULT:uint = 3;
      
      public static const GAME_TYPE_REPLAY:uint = 4;
      
      public static const GAME_TYPE_PVE:uint = 5;
      
      public static const GAME_TYPE_PVP:uint = 6;
      
      public static const GAME_TYPE_PVE_ON_SERVER:uint = 7;
      
      public static const GAME_TYPE_CLAN_WAR:uint = 8;
      
      public static const GAME_SUB_TYPE_NONE:uint = 0;
      
      public static const GAME_SUB_TYPE_PVP_DEFAULT:uint = 1;
      
      public static const GAME_SUB_TYPE_PVP_BATTLE_INVITATION:uint = 2;
      
      public static const GAME_SUB_TYPE_PVP_BOT:uint = 3;
      
      public static const GAME_SUB_TYPE_REPLAY_RANKING_LIST_INSPECT:uint = 1;
      
      public static const GAME_SUB_TYPE_REPLAY_CLAN_INSPECT:uint = 2;
      
      public static const GAME_SUB_TYPE_REPLAY_MENU_CHAT_INSPECT:uint = 3;
      
      public static const GAME_SUB_TYPE_REPLAY_SMTV:uint = 4;
      
      public static const GAME_SUB_TYPE_REPLAY_REGULAR:uint = 5;
      
      public static const GAME_SUB_TYPE_REPLAY_RAID_LEADERBOARD_INSPECT:uint = 6;
      
      public static const REGULAR_GACHA_MACHINE_ID:uint = 1;
      
      public static const GENERAL_SPEED_RATIO_NORMAL:uint = 1;
      
      public static const GENERAL_SPEED_RATIO_DOUBLE:uint = 2;
      
      private static var _didInitCrashHandling:Boolean = false;
      
      public static const ANALYTICS_PRIORITY_HIGHEST:int = 1;
      
      public static const ANALYTICS_PRIORITY_LOWEST:int = 5;
      
      public static const AD_TYPE_INTERSTITIAL_VIDEO:String = "Interstiail";
      
      public static const AD_TYPE_REWARDED_VIDEO:String = "Rewarded";
      
      public static const AD_ACTION_WATCHED:String = "Watched";
      
      public static const AD_ACTION_SKIPPED:String = "Skipped";
      
      public static const PATTERN_COLORS_FIRST_ID:uint = 500;
      
      private static const GOOGLE_ANALYTICS_TRACKING_ID:String = "UA-1665200-10";
      
      public static const ONESIGNAL_APP_ID:String = "50bdd4ea-589b-4ce2-8834-b1b182d8addd";
      
      public static const GCM_PROJECT_NUMBER:String = "542358169198";
      
      private var universalAnalyticsTracker:Tracker;
      
      public var clientVersion:String;
      
      public var flashVars:BMMClientFlashVars;
      
      public var bmmSessionSO:SharedObject;
      
      public var useNoConnectionMode:Boolean = false;
      
      public var firstSocketConnectionEstablished:Boolean = false;
      
      public var noConnectionModeActive:Boolean = false;
      
      public var appSharedObject:SharedObject;
      
      public var guestSharedObject:SharedObject;
      
      public var guestSharedObjectExists:Boolean = false;
      
      public var perUserSharedObject:SharedObject;
      
      public var perUserSharedObjectExists:Boolean = false;
      
      public var externalLibrarySharedObject:SharedObject;
      
      public var externalLibrarySharedObjectExists:Boolean = false;
      
      public var sessionID:String = "";
      
      public var uniqueID:String = "";
      
      public var userName:String = "";
      
      public var userEmail:String = "";
      
      public var playerbaseID:uint = 0;
      
      public var userID:Number = 0;
      
      public var userbase:uint;
      
      public var fpsToRemoveParticleEffects:uint = 0;
      
      public var clientRunningLocally:Boolean;
      
      public var lastLoginFromFacebook:Boolean = false;
      
      public var login_userTriedToLogin:Boolean = false;
      
      public var alreadySeenPlayingOnDevAlert:* = false;
      
      public var runAsMobile:Boolean = false;
      
      public var advertisingCampaignID:Number = 0;
      
      public var weightMax:uint = 1000;
      
      private var _weightOverload:uint = 0;
      
      public var weightOverloadHPPenalty:uint = 0;
      
      public var rankPerLadderProgressList:Array;
      
      public var totalStarsPerLadderProgressList:Array;
      
      public var ladderProgressBasePerRank:Array;
      
      public var ladderProgressMaxByRank:Array;
      
      public var battleMaxMechs:uint = 3;
      
      public var inventoryMaxMechs:uint = 3;
      
      public var freeTokens_amount:uint = 10;
      
      public var freeTokens_cooldown:uint = 86400;
      
      public var singlePlayerHarvestingData:Object = null;
      
      public var oneClickBoostData:BMOneClickBoostProperties = null;
      
      public var missionUpgrade_hpRatio:uint = 50;
      
      public var missionUpgrade_energyRatio:uint = 25;
      
      public var missionUpgrade_heatRatio:uint = 25;
      
      public var missionUpgrade_ammoRatio:uint = 50;
      
      public var showStarterPackAfterMissionLoss:Boolean = false;
      
      public var mission_playerMechStatus:String = "";
      
      public var mission_playerMechDirection:String = "";
      
      public var mission_battleEnded:Boolean = false;
      
      public var mission_battleEnded_playerWon:Boolean = false;
      
      public var mission_battleEnded_mechsStats:Array;
      
      public var mission_battleRow:uint;
      
      public var mission_battleColumn:uint;
      
      public var mission_battleEnemyType:String;
      
      public var mission_destroyingMapObjectActive:Boolean;
      
      public var mission_destroyingMapObjectRow:uint;
      
      public var mission_destroyingMapObjectColumn:uint;
      
      public var mission_destroyingMapObjectFrameCounter:uint;
      
      public var missionWorldMap_lastBossDialogShown:Number = -1;
      
      public var mechEquipment_playerItemIDsUpgraded:Object = {};
      
      public var welcomeScreenInitialized:Boolean = false;
      
      public var register_termsOfUseChecked:Boolean = false;
      
      public var supersonic_mobile_afterWins:uint = 0;
      
      public var supersonic_mobile_SPMP:uint = 0;
      
      public var supersonic_useRewardedVideosMobile:Boolean = false;
      
      public var supersonic_rewardedVideosMobile_maxPerDay:uint = 0;
      
      public var supersonic_rewardedVideosMobile_tokens:uint = 0;
      
      public var supersonic_rewardedVideosMobile_gold:uint = 2500;
      
      public var rewardedVideo_placement:String;
      
      public var maxRewardVideosPerDay:int = -1;
      
      public var rewardVideosSeen:int = -1;
      
      public var packages_markSpecificPackageID:uint = 0;
      
      public var packages_markPremiumFromBattle:Boolean = false;
      
      public var packages_markPremiumFromTutorial:Boolean = false;
      
      public var packages_markItemBoxFromTutorial:Boolean = false;
      
      public var packages_markFreeGoldPackageFromHanger:Boolean = false;
      
      public var packages_markGoldPackage:Boolean = false;
      
      public var packages_markItemsBox:Boolean = false;
      
      public var packages_openPowerKits:Boolean = false;
      
      public var battle_replayData:Object;
      
      public var battle_floorBuffsData:Object;
      
      public var battle_goToChatAfterBattle:Boolean = false;
      
      public var battle_inviteToClanAfterBattle:Boolean = false;
      
      public var battle_isCurrentBattlePvPWithPickMechs:Boolean = false;
      
      public var battle_backgroundID:Number = 1;
      
      public var battle_battleID:String = null;
      
      public var onlinePlayersInspect_playerID:Number = 0;
      
      public var replays_loaded:Boolean = false;
      
      public var topBar_levelUpInProgress:Boolean = false;
      
      public var hanger_sawInventory:Boolean = false;
      
      public var rankingList_gettingBackToRankingListFromAReplay:Boolean = false;
      
      public var inspectPlayer_playerID:Number = 0;
      
      public var inspectPlayer_activeMechIDs:Array;
      
      public var inspectPlayer_currentMechSlot:Number = 0;
      
      public var inspectPlayer_currentMechID:Number;
      
      public var inspectPlayer_selectedTab:String = "";
      
      public var inspectPlayer_lastTab:String = "";
      
      public var inspectPlayer_outsideRankingList:Boolean;
      
      public var inspectPlayer_name:String;
      
      public var inspectPlayer_level:Number;
      
      public var inspectPlayer_ladderProgress:Number;
      
      public var inspectPlayer_clanID:Number;
      
      public var inspectPlayer_goToTab:String;
      
      public var mainMenuLastMechID:Number = -1;
      
      public var mainMenuLastMechDisplayPowerRating:Number = -1;
      
      public var useDecals:Boolean = true;
      
      public var logOutClicked:Boolean = false;
      
      public var useClientIsAlive:Boolean = false;
      
      public var clanWinsGiveReward:Boolean = false;
      
      public var clanWinsRewardType:String;
      
      public var clanWinsRewardValue:Number;
      
      public var clanWinsWinsRequired:Number;
      
      public var clanRewards:Array;
      
      public var clan_tryToAcceptPlayerID:Number = 0;
      
      public var clanBossBattlesMax:uint = 0;
      
      public var clanBossCurrentDay:uint = 0;
      
      public var clanBossStartDay:uint = 0;
      
      public var clanBossActiveDays:uint = 0;
      
      public var clanBossInactiveDays:uint = 0;
      
      public var noneMovableTorsoItemIDs:Array = new Array();
      
      public var maxItemsPerOnePurchase:uint = 1;
      
      public var showMythicalsStats:Boolean = true;
      
      public var weeklyTopClanRewards:Array;
      
      public var newItemsCreated:Array = new Array();
      
      public var inspectPlayersStatistics:Object = {};
      
      public var inspectPlayersClan:Vector.<BMClanData> = new Vector.<BMClanData>();
      
      public var levelRequired3V3:uint = 20;
      
      public var useMultipleMechsKitsFix:Boolean = false;
      
      public var itemsDB:Object;
      
      public var itemsByTypeAndPowerRating:Object = {};
      
      public var itemsByChainIDs:Object = {};
      
      public var itemTypesDB:Array;
      
      public var itemTypesReverseDB:Array;
      
      public var animationDB:Object;
      
      public var replayActionsDB:Object;
      
      public var infoTextDB:Object;
      
      public var friendsDB:Object;
      
      public var itemTypeSortDB:Object;
      
      public var powerLevelsDB_regular:Array;
      
      public var powerLevelsDB_special:Array;
      
      public var subTypeDB:Object;
      
      public var subTypeDB_myth:Object;
      
      public var subTypeDB_combined:Object;
      
      public var subTypeOrderDB:Array;
      
      public var subTypeOrderDB_myth:Array;
      
      public var subTypeOrderDB_combined:Array;
      
      public var replaysDB:Object;
      
      public var loginReplaysDB:Object;
      
      public var levelUpDB:Array;
      
      public var itemTypeSourceDB:Array;
      
      public var colorsDB:Array;
      
      public var boostsDB:Array;
      
      public var battleInterfaceToolTipDB:Object;
      
      public var techDB:Object;
      
      public var musicDB:Array;
      
      public var achievementsDB:Object;
      
      public var achievementsSortedDB:Object;
      
      public var helpDB:Array;
      
      public var itemsMaxLevelsDB:Object;
      
      public var goldPackagesDB:Object;
      
      public var mechShopData:Object;
      
      public var premiumPackages:Vector.<BMPremiumPackageData>;
      
      public var allTokenPackages:Array;
      
      public var gachaMachinesArray:Array;
      
      public var gachaMachinesDB:Dictionary;
      
      public var questsManager:BMQuestsManager;
      
      public var newsHandler:BMNewsHandler;
      
      public var kinM:BMKinManager;
      
      public var missionBossData:Object;
      
      public var tipsManager:BMTipsManager;
      
      public var subTypeItemsAmount:Object;
      
      public var subTypeItemsAmount_myth:Object;
      
      public var subTypeItemsAmount_kits:Object;
      
      private var wordFilterDB:Array;
      
      private var ladderRankIconsDB:Array;
      
      public var equipmentUnlockDB:Object;
      
      public var equipmentUnlockByLevelDB:Array;
      
      public var missionUpgradesDB:Object;
      
      public var missionUpgradesReverseDB:Object;
      
      public var missionMapObjectDB:Object;
      
      public var mandatoryMissionMapObjects:Object;
      
      private var computerNamesDB:Array;
      
      public var singlePlayerM:BMSinglePlayerManager;
      
      public var mechBuildsM:BMMechBuildsManager;
      
      public var gameOfWhalesM:BMGameOfWhalesManager;
      
      public var clanWarsM:BMClanWarsManager;
      
      public var raidData:BMRaidData;
      
      public var chatData:BMChatData;
      
      public var contentPackResolver:BMContentPackResolver;
      
      public var chainDiscountsResolver:BMChainDiscountsResolver;
      
      public var itemsExtraChanceData:BMItemsExtraChanceData;
      
      public var playerSkillsManager:BMPlayerSkillsManager;
      
      public var baseBuildingManager:BMBaseBuildingManager;
      
      public var boxFragmentsManager:BMBoxFragmentsManager;
      
      public var pvpWinningRewardPredictionData:BMPVPWinningRewardPredictionData;
      
      public var clanShopItems:Vector.<BMClanShopData> = new Vector.<BMClanShopData>();
      
      public var kinShopItems:Vector.<BMClanShopData> = new Vector.<BMClanShopData>();
      
      public var mechEquipmentRecommander:BMMechEquipmentRecommender;
      
      public var mechBoostRecommender:BMMechBoostRecommender;
      
      private var missionLayouts_tutorial:Array;
      
      private var missionLayouts_regular:Array;
      
      private var guestFixedItemsDB:Array;
      
      public var usePerks:Boolean = false;
      
      public var rankingList_allTime:Object;
      
      public var rankingList_weekly:Object;
      
      public var rankingList_online:Object;
      
      public var playersGeneralData:Object = {};
      
      public var inspectPlayerData:Object;
      
      public var battleCreditsManager:BMBattleCreditsManager;
      
      public var itemsDB_online:Object;
      
      private var itemsDB_local:Object;
      
      public var notReleasedItemChainIDs:Vector.<int> = new Vector.<int>();
      
      public var replaysDB_online:Object = {};
      
      public var replaysDB_offline:Object = {};
      
      public var replaysDB_inspect:Object = {};
      
      public var abTestData:Object = {};
      
      public var player1PlayerID:Number;
      
      public var player2PlayerID:Number;
      
      public var playersData:Array = new Array();
      
      public var battleType:String = "none";
      
      public var battleSubType:String = "";
      
      public var battleMechsPerPlayer:uint = 0;
      
      public var campaignBattleDifficulty:Number;
      
      public var campaignBattleID:Number;
      
      public var totalOfflineReplays:Number;
      
      public var maxEquipment:Object;
      
      public var gameType:uint = 0;
      
      public var gameSubType:uint = 0;
      
      public var battle_inBattleInvitation:Boolean = false;
      
      public var battle_clientInverted:Boolean = false;
      
      public var battle_syncData:Object = {};
      
      public var battle_syncRandom:SyncRandom;
      
      public var missionReviveTokensCost:uint = 10;
      
      public var starterPack_goBackToScreen:String = "";
      
      public var starterPack_displayAfterOnlineBattleCounter:uint = 3;
      
      public var starterPack_displayAfterSinglePlayerMissionCounter:uint = 3;
      
      public var useExtraMusicTracksForMobile:Boolean = false;
      
      public var usePersonaly:Boolean = false;
      
      public var personalyGeos:Array = new Array();
      
      public var player1Profile:BMPlayerProfile;
      
      public var player2Profile:BMPlayerProfile;
      
      public var player3Profile:BMPlayerProfile;
      
      public var player4Profile:BMPlayerProfile;
      
      public var player5Profile:BMPlayerProfile;
      
      public var player6Profile:BMPlayerProfile;
      
      public var player7Profile:BMPlayerProfile;
      
      public var player8Profile:BMPlayerProfile;
      
      public var player9Profile:BMPlayerProfile;
      
      public var playerData1Inventory:Object;
      
      public var playerData2Inventory:Object;
      
      public var playerData3Inventory:Object;
      
      public var playerData4Inventory:Object;
      
      public var playerData5Inventory:Object;
      
      public var playerData6Inventory:Object;
      
      public var playerData7Inventory:Object;
      
      public var playerData8Inventory:Object;
      
      public var playerData9Inventory:Object;
      
      public var player1playerItemIDCounter:Number;
      
      public var player2playerItemIDCounter:Number;
      
      public var player3playerItemIDCounter:Number;
      
      public var player4playerItemIDCounter:Number;
      
      public var player5playerItemIDCounter:Number;
      
      public var player6playerItemIDCounter:Number;
      
      public var player7playerItemIDCounter:Number;
      
      public var player8playerItemIDCounter:Number;
      
      public var player9playerItemIDCounter:Number;
      
      public var battleData:Object;
      
      public var battleLaunchScreen:String;
      
      public var savingReplay:Boolean;
      
      public var replaySaveData:Object;
      
      public var newXP:Number;
      
      public var newGold:Number;
      
      public var cheatWeaponDamageComputer:Number = 0;
      
      public var cheatWeaponResistance:Number = 0;
      
      public var cheatExtraHeat:Number = 0;
      
      public var usersOnline:Object = {};
      
      public var usersInBattle_ladder:Number = 0;
      
      public var usersInBattle_invitation:Number = 0;
      
      public var usersInBattle_computer:Number = 0;
      
      public var usersSearching:Number = 0;
      
      public var userDeclinedRatingForThisSession:Boolean = false;
      
      public var searchForBattleLevelChangeSeconds:Number = 0;
      
      public var breathingEffect:Boolean = true;
      
      public var particleEffects:Boolean = false;
      
      public var seeOpponentPerks:Boolean = true;
      
      public var movieClipParticleEffects:Boolean = true;
      
      public var movieClipParticleEffectsLevel:Number = 1;
      
      public var movieClipParticleEffectsRatio:Number = 0.25;
      
      public var computerBattleID:Number = 0;
      
      public var computerMechStructures:Vector.<BMMechStructure> = null;
      
      public var computerDifficultyMultiplier:Number = NaN;
      
      public var computerActions:Array = null;
      
      private var computerBattlePhase2Object:Object = null;
      
      private var computerStartBattleSuccessHandler:Function = null;
      
      public var tryToAddFriend_username:String;
      
      private var _currentTime:Number = 0;
      
      private var _lastSetCurrentTimeValue:Number = 0;
      
      private var _lastSetCurrentTimeDate:Number = 0;
      
      public var premiumAccountTime:Number = 0;
      
      public var lastBattleCreditAddon:Number = 0;
      
      public var serverTimeDifferece:Number = 0;
      
      public var turnsForQuitPenalty:Number = 0;
      
      public var advancedMatchmakingBlockLevel:Number = 20;
      
      public var randomItemsAmount:Number = 5;
      
      public var useFreeItemBoxes:Boolean = false;
      
      public var maxFreeItemBoxes:uint = 0;
      
      public var secondsForFreeItemBox:Number = 0;
      
      public var useCraftMythicals:Boolean = false;
      
      public var craftMythicals_level:uint = 20;
      
      public var craftPower_torso:uint = 0;
      
      public var craftPower_leg:uint = 0;
      
      public var craftPower_sideWeapon:uint = 0;
      
      public var craftPower_topWeapon:uint = 0;
      
      public var craftPower_special:uint = 0;
      
      public var craftPower_module:uint = 0;
      
      public var dailyLoginStreakData:Dictionary;
      
      public var dailyLoginStreakBonus:Object = {};
      
      public var battleCreditsMax:uint = 8;
      
      public var battleCreditsFillTokensCost:uint = 20;
      
      public var secondsForNewBattleCredit:Number = 1200;
      
      public var secondsForNewBattleCredit_supporters:Number = 1200;
      
      public var battleCredits_missionCost_normal:uint = 2;
      
      public var battleCredits_missionCost_hard:uint = 3;
      
      public var battleCredits_missionCost_insane:uint = 4;
      
      public var battleCredits_missionCost_boss:uint = 5;
      
      public var generalSettings:Object = {};
      
      public var goldPerToken:uint = 1000;
      
      public var clanMaxMembers:uint = 6;
      
      public var createClanCost:Number = 5000;
      
      public var clansRankingList:Object;
      
      public var clansAroundMyLadderProgress:Object;
      
      public var ladderSeasonEndRewardsData:Array;
      
      public var useNameChange:Boolean = false;
      
      public var nameChangeCostTokensBase:uint = 0;
      
      public var nameChangeCostTokensAddon:uint = 0;
      
      public var bonusTokensPerLevelUp:uint = 10;
      
      public var bonusTokensForLevel3:uint = 100;
      
      public var useLanguages:Boolean = true;
      
      public var languageFontType:Array = new Array(0,1,1,2,1,1,2,2,2,2,2);
      
      public var userAutopilot:Boolean = false;
      
      public var lastUserAutopilotInCampaign:Boolean = false;
      
      public var replayInspectedPlayerIDs:Array = new Array();
      
      public var setLastNewsIDForANewUser:Boolean = false;
      
      public var skipChallenge:Boolean = false;
      
      public var itemsBoxShop:Boolean = true;
      
      public var languageID:uint = 1;
      
      public var recommendedLanguageID:uint = 1;
      
      public var clientLastLanguageID:Number = 1;
      
      public var nextWeeklyReset:String = "";
      
      public var specialUser:Boolean = false;
      
      public var kitsMax:uint = 2;
      
      public var modulesMax:uint = 7;
      
      public var useRateBox:Boolean = false;
      
      public var rateBoxRankRequired:Number = 5;
      
      public var serverRestartTimeDisplay:Number = 0;
      
      private var _rateBoxInitialized:Boolean = false;
      
      public var useGiftSystem:Boolean = false;
      
      public var giftKeyGold:Number = 0;
      
      public var giftKeysUseMaxLevel:uint = 0;
      
      public var giftKeysBonus1Level:uint = 0;
      
      public var giftKeysBonus2Level:uint = 0;
      
      public var giftKeysBonus3Level:uint = 0;
      
      public var giftKeysBonus1Gold:uint = 0;
      
      public var giftKeysBonus2Gold:uint = 0;
      
      public var useSilverBoxesForGifts:Boolean = false;
      
      public var avatarLink:String = "";
      
      public var callingRankingListEnabled:Boolean = true;
      
      public var tutorialSkipped:Boolean = false;
      
      public var weeklySoloWinners:Object = {};
      
      public var weeklyClanWinners:Object = {};
      
      public var weeklyTopClans:Object = {};
      
      public var levelForExpandedItemBox:uint = 15;
      
      public var resetRankingListTimer:Boolean = false;
      
      public var dailyBonusOptions:Array = new Array();
      
      public var dungeonMechStructures:* = new Array();
      
      public var dungeonDifficulty:uint = 0;
      
      private var _generalSpeedRatio:Number = 1;
      
      public var lastGeneralSpeedRatioInCampaign:uint = 1;
      
      public var rewardSPWinGold:uint = 500;
      
      public var rewardSPWinXP:uint = 50;
      
      public var rewardMPWinGold:uint = 1000;
      
      public var rewardMPWinXP:uint = 100;
      
      public var rewardSPLoseGold:uint = 250;
      
      public var rewardSPLoseXP:uint = 25;
      
      public var rewardMPLoseGold:uint = 250;
      
      public var rewardMPLoseXP:uint = 25;
      
      public var floorBuff_damageAddon:Number = 25;
      
      public var floorBuff_energyRegenerationAddon:Number = 50;
      
      public var floorBuff_energyDamageAddon:Number = 25;
      
      public var floorBuff_heatCoolingAddon:Number = 50;
      
      public var floorBuff_heatDamageAddon:Number = 25;
      
      public var floorBuff_resistanceDelta:Number = 50;
      
      public var floorBuff_regenHP:Number = 100;
      
      public var useItemComparisonOnInventoryItemClick:Boolean = false;
      
      public var useItemComparisonOnMechItemRollOver:Boolean = true;
      
      public var activeBoosts:Array = new Array();
      
      public var activeBoostsMobile:Array = new Array();
      
      public var useGooglePlayTempButtons:Boolean = false;
      
      public var getTokens_displayAfterOnlineBattleCounter:uint = 0;
      
      public var getTokens_displayAfterSinglePlayerMissionCounter:uint = 0;
      
      public var campaignMissionRewardsRepository:BMMissionDefinitionRepository;
      
      public var minimalCampaignOpponentPowerRatingRatio:Number = 0.5;
      
      public var battle_gamePaused:Boolean = false;
      
      public var minedTokens_mainMenuAvailabilityChecks:uint = 0;
      
      public var minedTokens_showIndicatorInShopTab:Boolean = false;
      
      private var avatarImages:Object = {};
      
      private var modules_energy:Array = new Array();
      
      private var modules_heat:Array = new Array();
      
      private var modules_bullets:Array = new Array();
      
      private var modules_rockets:Array = new Array();
      
      private var modules_bulletsAndRockets:Array = new Array();
      
      private var modules_resistance:Array = new Array();
      
      private var modules_armor:Array = new Array();
      
      private var kits_energy:Array = new Array();
      
      private var kits_heat:Array = new Array();
      
      private var kits_bullets:Array = new Array();
      
      private var kits_rockets:Array = new Array();
      
      private var kits_resistance:Array = new Array();
      
      private var kits_repair:Array = new Array();
      
      private var highestRepairKitLevel:Number = 0;
      
      private var highestEnergyKitLevel:Number = 0;
      
      private var highestCoolingKitLevel:Number = 0;
      
      private var highestBulletsKitLevel:Number = 0;
      
      private var highestRocketsKitLevel:Number = 0;
      
      private var itemIDsForbiddenForPC:Object;
      
      private var itemIDsAllowedForPC:Array;
      
      public var installationData:InstallationData;
      
      public var starterPackData:Dictionary;
      
      private var shopItemDiscountTextFormat:TextFormat;
      
      public var boostConfigDB:BMBoostConfigDB;
      
      public var vipAccountData:BMVIPAccountData;
      
      public const MAX_SIDE_WEAPONS:Number = 4;
      
      public const MAX_TOP_WEAPONS:Number = 2;
      
      public const MAX_DRONES:Number = 1;
      
      public const MAX_TELEPORTS:Number = 1;
      
      public const MAX_SHIELDS:Number = 1;
      
      public const MAX_CHARGES:Number = 1;
      
      public const MAX_HARPOONS:Number = 1;
      
      public const MAX_KITS:Number = 2;
      
      public const MAX_MODULES:Number = 8;
      
      public const MAX_TAUNTS:Number = 6;
      
      public const MAX_ENHANCERS:Number = 5;
      
      public const SELL_ORIGINAL_VALUE_RATIO:Number = 0.25;
      
      public const SHOP_REGULAR_TILE_LIST_ITEM_SIZE:Number = 90;
      
      public const SHOP_REGULAR_TILE_LIST_ITEM_SIZE_MOBILE:Number = 93;
      
      public const SHOP_COMBINED_TILE_LIST_ITEM_SIZE:Number = 90;
      
      public const SHOP_COMBINED_TILE_LIST_ITEM_SIZE_MOBILE:Number = 95;
      
      public const STARTER_PACK_SIZE:uint = 70;
      
      public const NEWS_TILE_LIST_ITEM_SIZE:uint = 140;
      
      public const MECH_GENERATOR_TILE_LIST_ITEM_SIZE:uint = 60;
      
      public const REWARD_TILE_LIST_ITEM_SIZE:uint = 56;
      
      public const REWARD_TILE_LIST_ITEM_SIZE_MOBILE:uint = 56;
      
      public const INVENTORY_TILE_LIST_ROWS:Number = 5;
      
      public const INVENTORY_TILE_LIST_COLUMNS:Number = 4;
      
      public const INVENTORY_TILE_LIST_ITEM_SIZE:Number = 69;
      
      public const INVENTORY_TILE_LIST_ROWS_MOBILE:Number = 5;
      
      public const INVENTORY_TILE_LIST_COLUMNS_MOBILE:Number = 3;
      
      public const INVENTORY_TILE_LIST_ITEM_SIZE_MOBILE:Number = 75;
      
      public const DRAG_TILE_LIST_ITEM_SIZE:Number = 80;
      
      public const EQUIPMENT_TILE_LIST_ITEM_SIZE:Number = 50;
      
      public const LOCAL_PLAYER_ID:Number = 1;
      
      public const LOCAL_OPPONENT_ID:Number = 2;
      
      public const ONLINE_PLAYER_ID:Number = 3;
      
      public const ONLINE_OPPONENT_ID:Number = 4;
      
      public const REPLAY_PLAYER1_ID:Number = 5;
      
      public const REPLAY_PLAYER2_ID:Number = 6;
      
      public const INSPECT_PLAYER_ID:Number = 7;
      
      public const TUTORIAL_BATTLES:Number = 3;
      
      public const MENU_TUTORIAL_BATTLES:Number = 4;
      
      public const WINS_VS_COMPUTER_REQUIRED_FOR_LADDER:Number = 2;
      
      public const STAGE_WIDTH:Number = 800;
      
      public const STAGE_HEIGHT:Number = 480;
      
      public var LEVEL_MAX:Number = 150;
      
      public const WINNING_WALL_MAX_MESSAGES:Number = 6;
      
      public var BAD_AVERAGE_FPS:Number = 10;
      
      public var MULTIPLAYER_UNLOCK_LEVEL:Number = 3;
      
      public var CREDITS_ITEMS_BOX_BOOST_ID:Number = 9;
      
      public var DISPLAY_GET_TOKENS_COUNTER_MAX:uint = 6;
      
      public const DISPLAY_STARTER_PACK_COUNTER_MAX:uint = 3;
      
      private var FREE_PACKAGES_DEFAULT_STRING:String = "8,9";
      
      private var FREE_PACKAGES_DEFAULT_STRING_NEW:String = "8";
      
      public var SUB_TYPE_SIDE_WEAPON_PHYSICAL:uint;
      
      public var SUB_TYPE_TOP_WEAPON_ELECTRIC:uint;
      
      public var SUB_TYPE_MODULE_BULLETS_ROCKETS:uint;
      
      public var SECOND_MECH_UNLOCK_LEVEL:uint = 99;
      
      public const COLOR_GOLD:String = "FF9900";
      
      public const COLOR_TOKENS:String = "CC0000";
      
      public const COLOR_BAD:String = "CC0000";
      
      public const COLOR_GOOD:String = "33CC00";
      
      public const COLOR_HARD:String = "FF9900";
      
      public const COLOR_INSANE:String = "CC0000";
      
      public const COLOR_GIFT_KEY:String = "FFFF00";
      
      public const CLAN_FLAG_CENTER_FRAMES:uint = 27;
      
      public const CLAN_FLAG_SIDES_FRAMES:uint = 11;
      
      public const CLAN_FLAG_COLORS:uint = 18;
      
      private const COLOR_BLUE:String = "0099FF";
      
      private const COLOR_ORANGE:String = "FF9900";
      
      private const COLOR_DARK_GREEN:String = "005400";
      
      private const COLOR_GREEN:String = "33CC00";
      
      private const COLOR_PURPLE:String = "9C3399";
      
      private const COLOR_DARK_RED:String = "831E09";
      
      private const COLOR_DARK_RED_DARK:String = "311E09";
      
      private const COLOR_DARK_GRAY:String = "282828";
      
      private const COLOR_LIGHT_GRAY:String = "545454";
      
      private const COLOR_BLACK:String = "000000";
      
      private const COLOR_YELLOW:String = "FFCC00";
      
      private var tokenPolling:TokenPolling;
      
      private var didInitAnalytics:Boolean = false;
      
      private var lastScreensAdded:Array = new Array();
      
      private var lastScreenAddedTime:Number = 0;
      
      private const lastScreenAddedBlacklist:Array = [BMScreensManager.SCR_TOP_BAR];
      
      private var lastExceptionTime:Number = 0;
      
      public var geoipCountryCode:String;
      
      private var waitForDisplayRewardToCloseToken:Number;
      
      public var unpackingMechManually:Boolean = false;
      
      public var unpackingMechManually_mechID:uint;
      
      private const REPLAY_STRUCTURE_SKILLS:String = "skills";
      
      private var _lastInterstitialTimestamp:Number = 0;
      
      private var _wasLastInterstitialABanner:Boolean = true;
      
      private var _isShowingAdvertisement:Boolean;
      
      private var waitingToShowAdvertisement:Boolean = false;
      
      public var afInterface:AppsFlyerInterface;
      
      public function BMDataManager()
      {
         this.userbase = GlobalAccess.userbase;
         super();
         if(!_allowInstantiation)
         {
            throw new Error("Error: Instantiation failed: Use BMDataManager.getInstance() instead of new.");
         }
         this.appSharedObject = SharedObject.getLocal("superMechsApp");
      }
      
      public static function getInstance() : BMDataManager
      {
         if(_instance == null)
         {
            _allowInstantiation = true;
            _instance = new BMDataManager();
            _allowInstantiation = false;
         }
         return _instance;
      }
      
      public static function get platformID() : uint
      {
         return 3;
      }
      
      public static function initCrashHandling() : void
      {
         if(_didInitCrashHandling)
         {
            return;
         }
         _didInitCrashHandling = true;
      }
      
      public function get sessionManager() : BMSessionManager
      {
         return screensM.clientPointer.sessionManager;
      }
      
      public function getPlatformStoreProducts() : Array
      {
         return BMAndroidStoreKitManager.gi().getValidProducts();
      }
      
      public function get arePlatformStoreProductsAvailable() : Boolean
      {
         return BMAndroidStoreKitManager.gi().productsAvailable;
      }
      
      public function syncPlatformStoreProducts() : void
      {
         var _loc3_:BMTokenPackage = null;
         var _loc4_:Object = null;
         var _loc1_:Array = this.getPlatformStoreProducts();
         if(_loc1_ == null)
         {
            return;
         }
         TsLogger.log("BMDataManager :: syncPlatformStoreProducts()");
         var _loc2_:int = 0;
         while(_loc2_ < this.allTokenPackages.length)
         {
            _loc3_ = this.allTokenPackages[_loc2_];
            for each(_loc4_ in _loc1_)
            {
               if(_loc3_.tokenSystemPackageID == _loc4_.productId)
               {
                  _loc3_.price = _loc4_.displayPrice;
                  break;
               }
            }
            _loc2_++;
         }
      }
      
      public function initAnalytics() : *
      {
         if(this.didInitAnalytics)
         {
            return;
         }
         this.didInitAnalytics = true;
         var _loc1_:Configuration = new Configuration();
         this.setFlashVarsPointer();
         if(this.runAsMobile)
         {
            this.universalAnalyticsTracker = new AppTracker(UNIVERSAL_ANALYTICS_TRACKING_ID,_loc1_);
         }
         else
         {
            this.universalAnalyticsTracker = new WebTracker(UNIVERSAL_ANALYTICS_TRACKING_ID,_loc1_);
         }
         this.universalAnalyticsTracker.set(Tracker.APP_NAME,"supermechs");
         this.universalAnalyticsTracker.set("&dimension2",BMPlatformUtils.sourcePlatform);
         var _loc2_:String = this.getABBucket();
         this.setABBucket(_loc2_);
         BMPubSub.sub(BMPubSub.MESSAGE_SCREEN_OPENED,this.handleScreenAdded);
         this.handleUncaughtError(null,null);
         BMPubSub.sub(BMPubSub.MESSAGE_UNCAUGHT_ERROR,this.handleUncaughtError);
         BMPubSub.sub(BMPubSub.MESSAGE_SECOND_PASSED,this.handleSecondPassed);
      }
      
      public function forceCrash() : void
      {
      }
      
      public function trackSetUserID(param1:String) : *
      {
         if(this.universalAnalyticsTracker != null)
         {
            this.universalAnalyticsTracker.set(Tracker.USER_ID,param1);
         }
      }
      
      private function getLowestAnalyticsPriorityToSend() : int
      {
         var _loc1_:int = ANALYTICS_PRIORITY_HIGHEST;
         if(this.hasPlayerProfile && this.isPayingUser())
         {
            _loc1_ = 4;
         }
         else
         {
            _loc1_ = 3;
         }
         if(BMMClientFlashConsts.minimalAnalyticsPriorityToAlwaysSend > _loc1_)
         {
            _loc1_ = BMMClientFlashConsts.minimalAnalyticsPriorityToAlwaysSend;
         }
         return _loc1_;
      }
      
      private function shouldTrackEvent(param1:int) : *
      {
         if(param1 < ANALYTICS_PRIORITY_HIGHEST || param1 > ANALYTICS_PRIORITY_LOWEST)
         {
            throw Error("Invalid event priority " + param1);
         }
         var _loc2_:int = this.getLowestAnalyticsPriorityToSend();
         return param1 <= _loc2_;
      }
      
      public function trackEvent(param1:int, param2:String, param3:String, param4:String = null, param5:Number = NaN, ... rest) : void
      {
         this.updateTrackingEventsState();
         var _loc7_:* = "eventPriority_" + param2 + "_" + BMPlatformUtils.shortSourcePlatform;
         param1 = this.getGeneralSetting(_loc7_,param1);
         _loc7_ = "eventPriority_" + param2 + "_" + param3 + "_" + BMPlatformUtils.shortSourcePlatform;
         param1 = this.getGeneralSetting(_loc7_,param1);
         var _loc8_:Boolean = this.shouldTrackEvent(param1);
         if(!_loc8_)
         {
            return;
         }
      }
      
      private function setCustomAttribute(param1:String, param2:String, param3:Boolean) : *
      {
         if(param3)
         {
         }
      }
      
      private function handleScreenAdded(param1:String, param2:Object) : void
      {
         if(this.lastScreenAddedBlacklist.indexOf(param2.screen) >= 0)
         {
            return;
         }
         this.lastScreensAdded.push(this.getScreenShortName(param2.screen));
         while(this.lastScreensAdded.length > 3)
         {
            this.lastScreensAdded.shift();
         }
         this.setCustomAttribute("scrs",this.lastScreensAdded.join(","),false);
         this.lastScreenAddedTime = new Date().getTime();
      }
      
      private function handleUncaughtError(param1:String, param2:Object) : void
      {
         var _loc4_:String = null;
         if(param2 == null)
         {
            this.lastExceptionTime = 0;
            this.setCustomAttribute("ex","",false);
            return;
         }
         var _loc3_:UncaughtErrorEvent = param2.uncaughtErrorEvent;
         if(_loc3_.error is Error)
         {
            _loc4_ = Error(_loc3_.error).message + " \n " + Error(_loc3_.error).getStackTrace();
         }
         else if(_loc3_.error is ErrorEvent)
         {
            _loc4_ = ErrorEvent(_loc3_.error).text;
         }
         else
         {
            _loc4_ = _loc3_.error.toString();
         }
         this.lastExceptionTime = new Date().getTime();
         this.setCustomAttribute("ex",_loc4_,false);
      }
      
      private function getScreenShortName(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return param1.substr(6);
      }
      
      private function handleSecondPassed(param1:String, param2:Object) : *
      {
         this.updateTimeSensitiveTrackingEvents();
      }
      
      private function updateTimeSensitiveTrackingEvents() : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc1_:String = this.getScreenShortName(screensM.getTopMostScreenName());
         this.setCustomAttribute("tms",_loc1_ != null ? _loc1_ : "NA",false);
         if(this.lastScreenAddedTime > 0)
         {
            _loc2_ = (new Date().getTime() - this.lastScreenAddedTime) * 0.001;
            this.setCustomAttribute("lss",int(_loc2_).toString(),false);
         }
         if(this.lastExceptionTime > 0)
         {
            _loc3_ = (new Date().getTime() - this.lastExceptionTime) * 0.001;
            this.setCustomAttribute("exs",int(_loc3_).toString(),false);
         }
      }
      
      private function updateTrackingEventsState() : *
      {
         var _loc3_:uint = 0;
         if(this.hasPlayerProfile == false)
         {
            return;
         }
         var _loc1_:BMPlayerProfile = this.myProfile;
         this.setCustomAttribute("wg",_loc1_.gold.toString(),true);
         this.setCustomAttribute("wt",_loc1_.tokens.toString(),true);
         this.setCustomAttribute("wbc",_loc1_.battleCredits.toString(),true);
         if(this.singlePlayerM != null)
         {
            _loc3_ = uint(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1);
            this.setCustomAttribute("cl",this.singlePlayerM.getLastCompleteMissionSlotOnPath(_loc3_,0).toString(),true);
         }
         this.setCustomAttribute("ll",_loc1_.ladderProgress.toString(),true);
         var _loc2_:String = _loc1_.timeToFirstPayment > 0 ? "1" : "0";
         this.setCustomAttribute("pp",_loc2_,true);
         this.setCustomAttribute("pr",this.myPlayerData.getMechPowerRatingPrecise(1,false).toString(),true);
         this.setCustomAttribute("xp",_loc1_.level.toString(),true);
         this.updateTimeSensitiveTrackingEvents();
      }
      
      private function trackSnowplowAnalyticsEvent(param1:String, param2:String, param3:String, param4:Number, ... rest) : void
      {
         var _loc6_:int = 0;
         if(!isNaN(param4))
         {
            _loc6_ = int(param4);
         }
      }
      
      public function trackEventUAnalytics(param1:String, param2:String, param3:String = null, param4:Number = NaN) : *
      {
         if(param3 == null)
         {
            param3 = "";
         }
         if(isNaN(param4))
         {
            param4 = -1;
         }
         this.universalAnalyticsTracker.event(param1,param2,param3,param4);
      }
      
      private function trackEventGAnalytics(param1:String, param2:String, param3:String = null, param4:Number = NaN) : void
      {
      }
      
      private function trackEventAppsFlyer(param1:String, param2:String, param3:String = null, param4:Number = NaN) : void
      {
         if(!isNaN(param4))
         {
            this.sendAppsFlyerTracking(param3,"{\"value\":" + param4 + "}");
         }
         else if(param3 != null)
         {
            this.sendAppsFlyerTracking(param2,"{\"label\":\"" + param3 + "\"}");
         }
         else
         {
            this.sendAppsFlyerTracking(param1,"{\"action\":\"" + param2 + "\"}");
         }
      }
      
      public function sendAppsFlyerTracking(param1:String, param2:String) : void
      {
         TsLogger.log("sendAppsFlyerTracking " + param1 + ":" + param2);
      }
      
      public function trackScreenView(param1:String, param2:int = 5) : *
      {
         var _loc3_:Boolean = this.shouldTrackEvent(param2);
         TsLogger.log("trackScreenView " + param1 + ", " + param2 + " S=" + _loc3_);
         if(!_loc3_)
         {
            return;
         }
      }
      
      private function trackGAnalyticsScreenView(param1:String) : *
      {
      }
      
      private function trackAppsFlyerScreenView(param1:String) : *
      {
         this.sendAppsFlyerTracking("screen","{\"value\":\"" + param1 + "\"}");
      }
      
      public function trackError(param1:String, param2:String) : *
      {
         var _loc3_:String = null;
         switch(BMLoginManager.gi().loginState)
         {
            case BMLoginManager.STATE_LOGGING_IN:
               _loc3_ = "LoginFlow";
               break;
            case BMLoginManager.STATE_SILENT_LOGGING_IN:
               _loc3_ = "SilentLoginFlow";
               break;
            default:
               _loc3_ = "Error";
         }
         this.trackEvent(2,_loc3_,param1,param2);
      }
      
      public function trackAdvertisingEvent(param1:String, param2:String, param3:String, param4:Number = NaN) : *
      {
         var _loc5_:int = param1 == AD_TYPE_REWARDED_VIDEO ? 3 : 5;
         if(param1 == AD_TYPE_REWARDED_VIDEO && param2 == AD_ACTION_WATCHED)
         {
            _loc5_ = ANALYTICS_PRIORITY_HIGHEST;
         }
         this.trackEvent(_loc5_,"Advertisement",param2,param1 + param3,param4);
      }
      
      public function initialize() : void
      {
         TsLogger.log("BMDataManager initialized");
         generateSingletonClassesPointers("dataManager");
         this.singlePlayerM = BMSinglePlayerManager.gi();
         this.mechBuildsM = new BMMechBuildsManager();
         this.gameOfWhalesM = new BMGameOfWhalesManager();
         this.kinM = new BMKinManager();
         this.clanWarsM = new BMClanWarsManager();
         this.raidData = new BMRaidData();
         this.chatData = new BMChatData();
         this.contentPackResolver = new BMContentPackResolver();
         this.chainDiscountsResolver = new BMChainDiscountsResolver();
         this.itemsExtraChanceData = new BMItemsExtraChanceData();
         this.playerSkillsManager = new BMPlayerSkillsManager();
         this.baseBuildingManager = new BMBaseBuildingManager();
         this.boxFragmentsManager = new BMBoxFragmentsManager();
         this.pvpWinningRewardPredictionData = new BMPVPWinningRewardPredictionData();
         this.installationData = new InstallationData();
         this.vipAccountData = new BMVIPAccountData();
         this.mechEquipmentRecommander = new BMMechEquipmentRecommender();
         this.mechBoostRecommender = new BMMechBoostRecommender();
         this.initAnalytics();
         initCrashHandling();
         SafeInt.eventHandler = this.cheatEventHandler;
         Core.init();
         BMAndroidStoreKitManager.getInstance().addEventListener(AndroidStoreEvent.PURCHASE_SUCCEEDED,this.storeKitPurchaseComplete);
         this.trackScreenView("Start");
         if(DetectedSettings.isMobile)
         {
            this.runAsMobile = true;
         }
         this.useGooglePlayTempButtons = true;
         this.runAsMobile = true;
         NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE,function(param1:Event):*
         {
            BMPubSub.pub(BMPubSub.MESSAGE_APP_ACTIVAED);
         });
         this.itemsMaxLevelsDB = {};
         this.itemsMaxLevelsDB[BMMechStructure.TORSO] = 10;
         this.itemsMaxLevelsDB[BMMechStructure.LEG] = 10;
         this.itemsMaxLevelsDB[BMMechStructure.SIDE_WEAPON] = 10;
         this.itemsMaxLevelsDB[BMMechStructure.TOP_WEAPON] = 10;
         this.itemsMaxLevelsDB[BMMechStructure.DRONE] = 10;
         this.itemsMaxLevelsDB[BMMechStructure.SHIELD] = 10;
         this.itemsMaxLevelsDB[BMMechStructure.TELEPORT] = 10;
         this.itemsMaxLevelsDB[BMMechStructure.CHARGE] = 10;
         this.itemsMaxLevelsDB[BMMechStructure.HARPOON] = 10;
         this.itemsMaxLevelsDB["kit_repair"] = 10;
         this.itemsMaxLevelsDB["kit_energy"] = 10;
         this.itemsMaxLevelsDB["kit_heat"] = 10;
         this.itemsMaxLevelsDB["kit_bullets"] = 10;
         this.itemsMaxLevelsDB["kit_rockets"] = 10;
         this.itemsMaxLevelsDB["kit_resistance"] = 10;
         this.itemsMaxLevelsDB["kit_power"] = 10;
         this.itemsMaxLevelsDB["kit_transform"] = 10;
         this.itemsMaxLevelsDB["module_armor"] = 10;
         this.itemsMaxLevelsDB["module_energy"] = 10;
         this.itemsMaxLevelsDB["module_heat"] = 10;
         this.itemsMaxLevelsDB["module_bullets"] = 10;
         this.itemsMaxLevelsDB["module_rockets"] = 10;
         this.itemsMaxLevelsDB["module_bulletsAndRockets"] = 10;
         this.itemsMaxLevelsDB["module_resistance"] = 10;
         this.createGeneralDataBases();
         this.createItemsDataBaseLocally();
         this.setItemsCategoriesData(false);
         this.createLocalReplays();
         this.initializeGuestSharedObject();
         this.initializePerUserSharedObject();
         this.initializeExternalLibrarySharedObject();
         this.inspectPlayerData = {};
         this.battleCreditsManager = new BMBattleCreditsManager();
         this.questsManager = new BMQuestsManager();
         this.newsHandler = new BMNewsHandler();
      }
      
      public function setFlashVarsPointer() : void
      {
         if(GlobalAccess.stage == null)
         {
            return;
         }
         this.flashVars = new BMMClientFlashVars(GlobalAccess.stage);
         this.bmmSessionSO = SharedObject.getLocal(this.flashVars.soName,"/");
         this.clientVersion = this.flashVars.version;
         this.geoipCountryCode = "en";
         if(this.bmmSessionSO.data.userData != null)
         {
            if(this.bmmSessionSO.data.userData.session != null && this.bmmSessionSO.data.userData.session.SERVER != null)
            {
               if(this.bmmSessionSO.data.userData.session.SERVER.GEOIP_COUNTRY_CODE != null)
               {
                  this.geoipCountryCode = this.bmmSessionSO.data.userData.session.SERVER.GEOIP_COUNTRY_CODE;
                  if(BMLanguageManager.getLanguageIDByCode(this.geoipCountryCode) == BMLanguageManager.LANGUAGE_GERMAN)
                  {
                     this.chatData.chatDefaultLanguageID = 1;
                  }
                  else if(BMLanguageManager.getLanguageIDByCode(this.geoipCountryCode) == BMLanguageManager.LANGUAGE_SPANISH)
                  {
                     this.chatData.chatDefaultLanguageID = 2;
                  }
               }
            }
            if(this.bmmSessionSO.data.userData.session != null)
            {
               this.sessionID = this.bmmSessionSO.data.userData.session.session_id;
               this.uniqueID = this.bmmSessionSO.data.userData.session.unique_id;
               this.userName = this.bmmSessionSO.data.userData.session.username;
               this.avatarLink = this.bmmSessionSO.data.userData.avatar_data.avatar_link;
               this.userID = this.bmmSessionSO.data.userData.user_id;
               this.userEmail = this.bmmSessionSO.data.userData.user_email;
            }
            this.saveUsernameData();
            this.trackSetUserID(this.userID.toString());
         }
         this.specialUser = false;
         switch(this.userID)
         {
            case 56:
            case 799:
            case 9195889:
            case 9227227:
            case 3198:
            case 3816606:
               this.specialUser = true;
         }
         if(this.specialUser)
         {
            this.overwriteColorsDB();
         }
         this.clientRunningLocally = true;
         var _loc1_:LocalConnection = new LocalConnection();
         var _loc2_:* = _loc1_.domain;
         if(_loc2_ != "localhost" && _loc2_ != null)
         {
            this.clientRunningLocally = false;
         }
         this.clientRunningLocally = false;
         if(this.clientRunningLocally)
         {
            this.useGooglePlayTempButtons = true;
         }
         this.usePerks = true;
      }
      
      public function isPlayerIDAdmin(param1:Number) : Boolean
      {
         if(this.userID == param1 && this.myProfile.isAdmin)
         {
            return true;
         }
         switch(param1)
         {
            case 56:
            case 799:
            case 9195889:
            case 9227227:
            case 3198:
            case 3816606:
               return true;
            default:
               return false;
         }
      }
      
      public function initializeLocalMode() : void
      {
         var _loc2_:Object = null;
         var _loc3_:BMPlayerProfile = null;
         var _loc4_:BMMissionServerToClientStats = null;
         var _loc5_:BMMissionMechStats = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:Object = null;
         this.setGameTypeAndPlayers(GAME_TYPE_TUTORIAL,GAME_SUB_TYPE_NONE,"dataManager_initializeLocalMode");
         this.battleCreditsManager.activateMe();
         screensM.startCurrentTimeTimer();
         this.createProfile(this.LOCAL_PLAYER_ID,this.userName,1);
         var _loc1_:Boolean = false;
         if(this.clientRunningLocally && _loc1_)
         {
            _loc2_ = {};
            _loc2_.name = "tutorial tester";
            _loc2_.XP = 215;
            _loc2_.level = 3;
            _loc2_.gold = 8469;
            _loc2_.winsTotal = 5;
            _loc2_.winsVSComputer = 5;
            _loc2_.tutorialLevel = 12;
            _loc2_.battleCredits = 16;
            _loc2_.mapProgress = "vv";
            _loc2_.mission_colorID = 0;
            _loc2_.mission_columns = 0;
            _loc2_.mission_difficulty = 1;
            _loc2_.mission_energy = 0;
            _loc2_.mission_energyRegeneration = 0;
            _loc2_.mission_heat = 0;
            _loc2_.mission_heatCooling = 0;
            _loc2_.mission_hp = 0;
            _loc2_.mission_hpMax = 0;
            _loc2_.mission_gold = 0;
            _loc2_.mission_layout = "";
            _loc2_.mission_loot = [];
            _loc2_.mission_mode = 0;
            _loc2_.mission_playerPosition = 0;
            _loc2_.mission_progress = [];
            _loc2_.mission_rows = 0;
            _loc2_.mission_startingPosition = 0;
            _loc2_.mission_themeID = 0;
            _loc2_.mission_upgrades = [];
            _loc2_.mission_xp = 0;
            _loc2_.missionID = 0;
            _loc2_.missionsCompleted = 2;
            _loc2_.currentMissionSlot = -1;
            _loc2_.currentMissionMode = 0;
            _loc2_.items = new Array();
            _loc2_.items.push({
               "itemID":9355,
               "playerItemID":2,
               "equipmentID":0,
               "equipmentType":"leg",
               "equipped":1,
               "power":0,
               "weight":138
            });
            _loc2_.items.push({
               "itemID":15245,
               "playerItemID":3,
               "equipmentID":1,
               "equipmentType":"sideWeapon",
               "equipped":1,
               "power":0,
               "weight":67
            });
            _loc2_.items.push({
               "itemID":29655,
               "playerItemID":5,
               "equipmentID":2,
               "equipmentType":"sideWeapon",
               "equipped":1,
               "power":0,
               "weight":53
            });
            _loc2_.items.push({
               "itemID":19295,
               "playerItemID":6,
               "equipmentID":1,
               "equipmentType":"topWeapon",
               "equipped":1,
               "power":0,
               "weight":50
            });
            _loc2_.items.push({
               "itemID":9805,
               "playerItemID":7,
               "equipmentID":1,
               "equipmentType":"module",
               "equipped":1,
               "power":0,
               "weight":40
            });
            _loc2_.items.push({
               "itemID":25607,
               "playerItemID":8,
               "equipmentID":0,
               "equipmentType":"torso",
               "equipped":1,
               "power":800,
               "weight":318
            });
            _loc2_.items.push({
               "itemID":11555,
               "playerItemID":9,
               "equipmentID":0,
               "equipmentType":"drone",
               "equipped":1,
               "power":0,
               "weight":31
            });
         }
         if(this.clientRunningLocally && _loc2_ != null)
         {
            _loc3_ = this["player" + this.LOCAL_PLAYER_ID + "Profile"];
            _loc3_.playerName = _loc2_.name;
            _loc3_.XP = _loc2_.XP;
            _loc3_.level = _loc2_.level;
            _loc3_.gold = _loc2_.gold;
            _loc3_.winsTotal = _loc2_.winsTotal;
            _loc3_.winsVSComputer = _loc2_.winsVSComputer;
            _loc3_.tutorialLevel = _loc2_.tutorialLevel;
            _loc3_.battleCredits = _loc2_.battleCredits;
            _loc3_.setMapProgress(0,_loc2_.mapProgress);
            _loc3_.currentStoryID = BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1;
            _loc4_ = new BMMissionServerToClientStats();
            _loc5_ = new BMMissionMechStats();
            _loc5_.hp = _loc2_.mission_hp;
            _loc5_.hpMax = _loc2_.mission_hpMax;
            _loc5_.energy = _loc2_.mission_energy;
            _loc5_.energyRegeneration = _loc2_.mission_energyRegeneration;
            _loc5_.heat = _loc2_.mission_heat;
            _loc5_.heatCooling = _loc2_.mission_heatCooling;
            _loc5_.bullets = _loc2_.mission_bullets;
            _loc5_.rockets = _loc2_.mission_rockets;
            _loc4_.colorID = _loc2_.mission_colorID;
            _loc4_.rows = _loc2_.mission_rows;
            _loc4_.columns = _loc2_.mission_columns;
            _loc4_.difficulty = _loc2_.mission_difficulty;
            _loc4_.gold = _loc2_.mission_gold;
            _loc4_.layout = _loc2_.mission_layout;
            _loc4_.loot = _loc2_.mission_loot;
            _loc4_.mode = _loc2_.mission_mode;
            _loc4_.playerPosition = _loc2_.mission_playerPosition;
            _loc4_.progress = _loc2_.mission_progress;
            _loc4_.startingPosition = _loc2_.mission_startingPosition;
            _loc4_.themeID = _loc2_.mission_themeID;
            _loc4_.upgrades = _loc2_.mission_upgrades;
            _loc4_.xp = _loc2_.mission_xp;
            _loc4_.missionID = _loc2_.missionID;
            _loc4_.mechsStats[0] = _loc5_;
            _loc3_.updateMissionData(_loc4_);
            _loc3_.missionsCompleted = _loc2_.missionsCompleted;
            _loc6_ = uint(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1);
            _loc3_.setCurrentMissionSlot(_loc2_.currentMissionSlot);
            _loc3_.setCurrentMissionMode(_loc2_.currentMissionMode);
            this["playerData" + this.LOCAL_PLAYER_ID + "Inventory"] = {};
            this["player" + this.LOCAL_PLAYER_ID + "playerItemIDCounter"] = 1;
            _loc7_ = 0;
            while(_loc7_ < _loc2_.items.length)
            {
               _loc8_ = _loc2_.items[_loc7_];
               this.addInventoryItem(this.LOCAL_PLAYER_ID,this["playerData" + this.LOCAL_PLAYER_ID + "Inventory"],_loc8_.itemID,_loc8_.equipped,_loc8_.equipmentType,_loc8_.equipmentID,_loc8_.colorID,_loc8_.power);
               _loc7_++;
            }
         }
         else if(this.guestSharedObjectExists)
         {
            this.loadSharedObjectGuestData();
         }
         else
         {
            _loc3_ = this["player" + this.player1PlayerID + "Profile"];
            _loc3_.gold = 4100;
            _loc3_.battleCredits = this.battleCreditsMax;
            this.createPlayerInventoryLocally();
         }
         this.createPlayerData(this.LOCAL_PLAYER_ID,"initializeLocalMode");
      }
      
      public function initializeOnlineMode() : void
      {
         this.battleCreditsManager.activateMe();
         this.chatData.isInChatChannel = false;
         var _loc1_:BMPlayerProfile = this["player" + this.ONLINE_PLAYER_ID + "Profile"];
         if(_loc1_.tutorialLevel < BMTutorialManager.TUTORIAL_LEVEL_MISSION3)
         {
            this.initializeLocalMode();
         }
         else
         {
            this.setGameTypeAndPlayers(GAME_TYPE_DEFAULT,GAME_SUB_TYPE_NONE,"dataManager_initializeOnlineMode");
            this.createPlayerData(this.ONLINE_PLAYER_ID);
            this.mechBuildsM.parseDataIfPending();
         }
         this.gameOfWhalesM.init(this.geoipCountryCode);
      }
      
      public function getConnectedServices() : Array
      {
         var _loc1_:Array = new Array();
         var _loc2_:int = 0;
         while(_loc2_ < LoginServices.ALL_SERVICES.length)
         {
            if(this.sessionManager.isExternalLoggedIn(LoginServices.ALL_SERVICES[_loc2_]))
            {
               _loc1_.push(LoginServices.ALL_SERVICES[_loc2_]);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function isConnectedToMajorService() : Boolean
      {
         var _loc1_:int = 0;
         while(_loc1_ < LoginServices.MAJOR_SERVICES.length)
         {
            if(this.sessionManager.isExternalLoggedIn(LoginServices.MAJOR_SERVICES[_loc1_]))
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function isConnectedToService(param1:String) : Boolean
      {
         return this.sessionManager.isExternalLoggedIn(param1);
      }
      
      public function isGeneratedUser() : Boolean
      {
         return this.installationData.lastLoginService == LoginServices.GENERATED_USER;
      }
      
      public function canDisconnectFromService(param1:String) : Boolean
      {
         if(param1 == LoginServices.SUPERMECHS)
         {
            return false;
         }
         if(param1 == LoginServices.FACEBOOK)
         {
            if(BMPlatformUtils.isFaceBook)
            {
               return false;
            }
         }
         var _loc2_:Array = this.getConnectedServices();
         if(_loc2_.length <= 1)
         {
            return false;
         }
         return true;
      }
      
      public function isNeedToSaveProgress() : Boolean
      {
         return !this.saveProgressSeen && this.myProfile.level >= 5 && !this.isConnectedToMajorService();
      }
      
      public function get saveProgressSeen() : Boolean
      {
         if(!this.perUserSharedObject.data.hasOwnProperty("saveProgressSeen"))
         {
            return false;
         }
         return this.perUserSharedObject.data.saveProgressSeen;
      }
      
      public function set saveProgressSeen(param1:Boolean) : void
      {
         this.perUserSharedObject.data.saveProgressSeen = param1;
         this.flushPerUserSharedObject();
      }
      
      public function setGameTypeAndPlayersToDefault() : void
      {
         var _loc1_:uint = GAME_TYPE_DEFAULT;
         if(tutorialM.isTutorialActive())
         {
            _loc1_ = GAME_TYPE_TUTORIAL;
         }
         this.setGameTypeAndPlayers(_loc1_,GAME_SUB_TYPE_NONE,"dataManager_setGameTypeAndPlayersToDefault");
      }
      
      public function setGameTypeAndPlayers(param1:uint, param2:uint = 0, param3:String = "") : void
      {
         var _loc4_:Array = new Array();
         _loc4_[0] = "GAME_TYPE_NONE";
         _loc4_[1] = "GAME_TYPE_TUTORIAL";
         _loc4_[2] = "GAME_TYPE_TUTORIAL_PVE";
         _loc4_[3] = "GAME_TYPE_DEFAULT";
         _loc4_[4] = "GAME_TYPE_REPLAY";
         _loc4_[5] = "GAME_TYPE_PVE";
         _loc4_[6] = "GAME_TYPE_PVP";
         this.gameType = param1;
         this.gameSubType = param2;
         switch(param1)
         {
            case BMDataManager.GAME_TYPE_NONE:
               this.player1PlayerID = 0;
               this.player2PlayerID = 0;
               this.itemsDB = this.itemsDB_local;
               break;
            case BMDataManager.GAME_TYPE_TUTORIAL:
            case BMDataManager.GAME_TYPE_TUTORIAL_PVE:
               this.player1PlayerID = this.LOCAL_PLAYER_ID;
               this.player2PlayerID = this.LOCAL_OPPONENT_ID;
               this.itemsDB = this.itemsDB_local;
               this.setItemsCategoriesData(false);
               break;
            case BMDataManager.GAME_TYPE_DEFAULT:
            case BMDataManager.GAME_TYPE_PVE:
            case BMDataManager.GAME_TYPE_PVP:
            case BMDataManager.GAME_TYPE_PVE_ON_SERVER:
            case BMDataManager.GAME_TYPE_CLAN_WAR:
               this.player1PlayerID = this.ONLINE_PLAYER_ID;
               this.player2PlayerID = this.ONLINE_OPPONENT_ID;
               this.itemsDB = this.itemsDB_online;
               BMSpecialOffersManager.gi().refreshSpecialOffersBoostIDs();
               this.contentPackResolver.setLastStatusData();
               break;
            case BMDataManager.GAME_TYPE_REPLAY:
               switch(this.gameSubType)
               {
                  case BMDataManager.GAME_SUB_TYPE_REPLAY_REGULAR:
                     this.player1PlayerID = this.REPLAY_PLAYER1_ID;
                     this.player2PlayerID = this.REPLAY_PLAYER2_ID;
                     this.replaysDB = this.replaysDB_online;
                     break;
                  case BMDataManager.GAME_SUB_TYPE_REPLAY_RANKING_LIST_INSPECT:
                  case BMDataManager.GAME_SUB_TYPE_REPLAY_MENU_CHAT_INSPECT:
                  case BMDataManager.GAME_SUB_TYPE_REPLAY_CLAN_INSPECT:
                  case BMDataManager.GAME_SUB_TYPE_REPLAY_SMTV:
                  case BMDataManager.GAME_SUB_TYPE_REPLAY_RAID_LEADERBOARD_INSPECT:
                     this.player1PlayerID = this.REPLAY_PLAYER1_ID;
                     this.player2PlayerID = this.REPLAY_PLAYER2_ID;
                     this.replaysDB = this.replaysDB_inspect;
               }
         }
      }
      
      public function get playingVSComputer() : Boolean
      {
         if(this.gameType == GAME_TYPE_TUTORIAL_PVE)
         {
            return true;
         }
         if(this.gameType == GAME_TYPE_PVE)
         {
            return true;
         }
         if(this.gameType == GAME_TYPE_PVP && this.gameSubType == GAME_SUB_TYPE_PVP_BOT)
         {
            return true;
         }
         return false;
      }
      
      public function getInterfacePlayerID(param1:Number) : Number
      {
         var _loc2_:Number = param1;
         switch(param1)
         {
            case this.LOCAL_PLAYER_ID:
            case this.ONLINE_PLAYER_ID:
            case this.REPLAY_PLAYER1_ID:
               _loc2_ = 1;
               break;
            case this.LOCAL_OPPONENT_ID:
            case this.ONLINE_OPPONENT_ID:
            case this.REPLAY_PLAYER2_ID:
               _loc2_ = 2;
         }
         return _loc2_;
      }
      
      public function createProfile(param1:Number, param2:String, param3:Number) : void
      {
         var _loc6_:ClanWarPlayerData = null;
         var _loc4_:BMPlayerProfile = this["player" + param1 + "Profile"];
         this["player" + param1 + "Profile"] = new BMPlayerProfile();
         var _loc5_:BMPlayerProfile = this["player" + param1 + "Profile"];
         _loc5_.playerID = param1;
         _loc5_.playerName = param2;
         _loc5_.level = param3;
         _loc5_.lastLevel = param3;
         if(_loc4_ != null)
         {
            _loc5_.setCurrentMissionSlot(_loc4_.currentMissionSlot);
            _loc5_.setCurrentMissionMode(_loc4_.currentMissionMode);
         }
         if(param1 == this.ONLINE_OPPONENT_ID && BattleTypeResolver.isClanWar)
         {
            _loc6_ = this.clanWarsM.getPlayerData(this.clanWarsM.currentOpponentPlayerID,BMClanWarsManager.ALIGNMENT_ENEMY_CLAN);
            _loc5_.skills = _loc6_.skills.concat();
         }
         switch(param1)
         {
            case this.ONLINE_PLAYER_ID:
            case this.LOCAL_PLAYER_ID:
               this.campaignBattleID = 0;
         }
      }
      
      public function get myProfile() : BMPlayerProfile
      {
         return this["player" + this.player1PlayerID + "Profile"];
      }
      
      public function get hasPlayerProfile() : Boolean
      {
         return hasOwnProperty("player" + this.player1PlayerID + "Profile");
      }
      
      public function get myPlayerData() : BMPlayerData
      {
         return this.playersData[this.player1PlayerID];
      }
      
      private function chooseRandomItemIDFromItemIDList(param1:Array) : int
      {
         return RandomUtils.chooseRandomElement(param1);
      }
      
      private function createPlayerInventoryLocally() : void
      {
         this["playerData" + this.LOCAL_PLAYER_ID + "Inventory"] = {};
         this["player" + this.LOCAL_PLAYER_ID + "playerItemIDCounter"] = 1;
         this.addMultipleInventoryItems(this.LOCAL_PLAYER_ID,BMCampaignMechsHelper.getTutorialItems_hanger1());
      }
      
      private function createComputerOpponentInventoryLocally(param1:Number, param2:uint = 1) : void
      {
         var _loc6_:BMWorldMapLocationData = null;
         var _loc7_:uint = 0;
         var _loc8_:BMPlayerData = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:uint = 0;
         var _loc12_:Boolean = false;
         var _loc13_:uint = 0;
         var _loc14_:Array = null;
         var _loc15_:Array = null;
         var _loc16_:Array = null;
         if(param2 == 1)
         {
            this["playerData" + param1 + "Inventory"] = {};
            this["player" + param1 + "playerItemIDCounter"] = 1;
         }
         var _loc3_:Number = 1;
         if(tutorialM.isTutorialActive() == false && this.battleSubType != BMSinglePlayerManager.ENEMY_TYPE_CLAN_BOSS && this.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION && this.raidData.isRaidInProgress() == false)
         {
            _loc6_ = this.myProfile.getCurrentMission();
            _loc3_ = this.campaignMissionRewardsRepository.getMissionEnemyPowerRating(this.myProfile.currentStoryID,_loc6_.campaignID,this.myProfile.currentMissionMode);
            _loc7_ = 0;
            if(this.myProfile.currentMissionMode == _loc7_ && this.singlePlayerM.didCompleteSlot(this.myProfile.currentStoryID,this.myProfile.currentMissionSlot,_loc7_) == false)
            {
               _loc8_ = this.playersData[this.player1PlayerID];
               _loc9_ = this.campaignMissionRewardsRepository.getMissionDifficultyMultiplier(this.myProfile.currentStoryID,_loc6_.campaignID,this.myProfile.currentMissionMode,this.myProfile.mission_difficulty);
               _loc10_ = _loc8_.getMechPowerRating(1,true) / _loc9_;
               _loc11_ = Math.ceil(_loc10_ * this.minimalCampaignOpponentPowerRatingRatio);
               if(_loc3_ < _loc11_)
               {
                  trace("BUFFING OPPONENT\'S POWER RATING FROM " + _loc3_ + " TO " + _loc11_);
                  _loc3_ = _loc11_;
               }
            }
         }
         var _loc4_:Number = _loc3_;
         var _loc5_:Number = _loc3_;
         if(_loc4_ >= 13)
         {
            _loc4_ -= 3;
         }
         else if(_loc4_ >= 7)
         {
            _loc4_ -= 2;
         }
         else if(_loc4_ >= 3)
         {
            _loc4_--;
         }
         switch(this.battleSubType)
         {
            case BMSinglePlayerManager.ENEMY_TYPE_MECH:
            case BMSinglePlayerManager.ENEMY_TYPE_BOSS:
            case BMSinglePlayerManager.ENEMY_TYPE_CLAN_BOSS:
               if(tutorialM.isTutorialActive())
               {
                  switch(this.myProfile.missionsCompleted)
                  {
                     case 0:
                        this.addMultipleInventoryItems(param1,BMCampaignMechsHelper.getTutorialEnemyMech_mission1(),BMSinglePlayerManager.MISSION_COLOR_NORMAL);
                        break;
                     case 1:
                        this.addMultipleInventoryItems(param1,BMCampaignMechsHelper.getTutorialEnemyMech_mission2(),BMSinglePlayerManager.MISSION_COLOR_NORMAL);
                  }
               }
               else
               {
                  this.createMechStructures_playerItemBased(param1,param2,this.computerMechStructures[param2 - 1],_loc4_,_loc5_);
               }
               break;
            default:
               if(tutorialM.isTutorialActive() == false)
               {
                  this.createMechStructures_playerItemBased(param1,param2,this.computerMechStructures[param2 - 1],_loc4_,_loc5_);
                  break;
               }
               _loc12_ = false;
               _loc13_ = this.myProfile.mission_colorID;
               _loc14_ = this.getEnemyAllowedDamageTypesInCampaign();
               _loc15_ = this.getReleventItemIDsFromItemsDB(BMMechStructure.SIDE_WEAPON,_loc4_,_loc5_,_loc12_,_loc14_);
               _loc16_ = this.getReleventItemIDsFromItemsDB(BMMechStructure.TOP_WEAPON,_loc4_,_loc5_,_loc12_,_loc14_);
               switch(this.battleSubType)
               {
                  case BMSinglePlayerManager.ENEMY_TYPE_TANK:
                     this.addMultipleInventoryItems(param1,BMCampaignMechsHelper.getCampaignEnemyTank(_loc15_,_loc16_),_loc13_);
                     break;
                  case BMSinglePlayerManager.ENEMY_TYPE_JEEP:
                     if(tutorialM.isTutorialActive())
                     {
                        this.addMultipleInventoryItems(param1,BMCampaignMechsHelper.getTutorialEnemyJeep_mission2(),_loc13_);
                     }
                     else
                     {
                        this.addMultipleInventoryItems(param1,BMCampaignMechsHelper.getCampaignEnemyJeep(_loc15_,_loc16_),_loc13_);
                     }
               }
         }
      }
      
      public function createPlayerData(param1:Number, param2:String = "") : void
      {
         var _loc6_:uint = 0;
         var _loc8_:Object = null;
         var _loc9_:BMMechStructure = null;
         var _loc10_:BMPlayerItemData = null;
         var _loc11_:BMItemData = null;
         var _loc12_:Array = null;
         var _loc13_:uint = 0;
         var _loc14_:BMPlayerItemData = null;
         var _loc3_:Object = this["playerData" + param1 + "Inventory"];
         var _loc4_:BMPlayerData = new BMPlayerData();
         _loc4_.initialize(param1);
         var _loc5_:BMPlayerProfile = this["player" + param1 + "Profile"];
         if(param1 == this.LOCAL_PLAYER_ID)
         {
            _loc5_.playerName = getGeneralText("guest");
         }
         _loc4_.playerItemIDCounter = 1;
         _loc6_ = 1;
         while(_loc6_ <= this.inventoryMaxMechs)
         {
            _loc9_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID);
            _loc9_.initialize(param1,_loc6_);
            _loc4_.mechStructures[_loc6_] = _loc9_;
            _loc6_++;
         }
         var _loc7_:uint = 0;
         if(BattleTypeResolver.isCampaignOnServer || BattleTypeResolver.isRaidOnServer)
         {
            if(this.getInterfacePlayerID(param1) == 2)
            {
               _loc7_ = this.myProfile.mission_colorID;
               if(this.battleSubType == BMSinglePlayerManager.ENEMY_TYPE_BOSS)
               {
                  _loc7_ = BMSinglePlayerManager.MISSION_COLOR_BOSS;
               }
            }
         }
         for each(_loc8_ in _loc3_)
         {
            _loc10_ = new BMPlayerItemData();
            _loc11_ = this.itemsDB[_loc8_.itemID];
            _loc10_.playerItemID = _loc8_.playerItemID;
            _loc10_.itemID = _loc8_.itemID;
            _loc10_.equipped = _loc8_.equipped;
            _loc10_.equipmentType = _loc8_.type;
            _loc10_.equipmentID = _loc8_.equipmentID;
            _loc10_.power = _loc8_.power;
            _loc10_.weight = _loc8_.weight;
            _loc10_.colorID = _loc8_.colorID;
            if(_loc7_ > 0)
            {
               _loc10_.colorID = _loc7_;
            }
            if(_loc8_.durability != null)
            {
               _loc10_.durability = _loc8_.durability;
            }
            else
            {
               _loc10_.durability = 0;
            }
            _loc4_.items.push(_loc10_);
            if(_loc4_.playerItemIDCounter <= _loc10_.playerItemID)
            {
               _loc4_.playerItemIDCounter = _loc10_.playerItemID + 1;
            }
         }
         _loc4_.updateExistingPlayerItemIDs();
         _loc4_.updateMechsWeight();
         this.playersData[param1] = _loc4_;
         if(param1 == this.ONLINE_PLAYER_ID)
         {
            if(_loc5_.level == 1 && _loc5_.onlineBattles == 0 && _loc5_.battlesVSComputer == 0)
            {
               if(_loc4_.items.length == 3)
               {
                  _loc12_ = new Array();
                  _loc12_.push(_loc4_.items[0]);
                  _loc12_.push(_loc4_.items[1]);
                  _loc12_.push(_loc4_.items[2]);
                  if(_loc12_[0].equipped == 0 && _loc12_[1].equipped == 0 && _loc12_[2].equipped == 0)
                  {
                     _loc13_ = 0;
                     while(_loc13_ < 3)
                     {
                        _loc14_ = _loc12_[_loc13_];
                        switch(_loc14_.itemID)
                        {
                           case BMCampaignMechsHelper.getTutorial_hanger1_torso():
                              _loc4_.items[0] = _loc12_[_loc13_];
                              break;
                           case BMCampaignMechsHelper.getTutorial_hanger1_leg():
                              _loc4_.items[1] = _loc12_[_loc13_];
                              break;
                           case BMCampaignMechsHelper.getTutorial_hanger1_sideWeapon():
                              _loc4_.items[2] = _loc12_[_loc13_];
                        }
                        _loc13_++;
                     }
                  }
               }
            }
            this.singlePlayerM.premiumBoxTutorialManager.beginTrackingUserProgress();
         }
         _loc6_ = 1;
         while(_loc6_ <= this.inventoryMaxMechs)
         {
            this.updateMechStructure(param1,_loc6_);
            _loc6_++;
         }
         _loc4_.selectedMechID = _loc5_.initialSelectedMechID;
      }
      
      private function updateEquipmentIDInInventory(param1:BMMechStructure, param2:Object, param3:String, param4:Number) : void
      {
         var _loc5_:Number = Number(param1[param3 + param4]);
         if(_loc5_ > 0)
         {
            param2[_loc5_].equipmentID = param4;
         }
      }
      
      public function giveRewardPopup(param1:BMRewardData, param2:String = "", param3:Boolean = false, param4:int = -1, param5:uint = 0) : *
      {
         var _loc7_:BMDisplayRewardData = null;
         var _loc10_:int = 0;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc13_:Array = null;
         var _loc14_:uint = 0;
         var _loc15_:BMPlayerItemData = null;
         var _loc16_:Boolean = false;
         var _loc6_:Array = new Array();
         var _loc8_:String = BMGameOfWhalesManager.SOURCE_MISSION_WIN;
         var _loc9_:String = BMGameOfWhalesManager.PLACE_CAMPAIGN;
         if(BattleTypeResolver.isLadderBattle)
         {
            _loc8_ = BMGameOfWhalesManager.SOURCE_LADDER_WIN;
            _loc9_ = BMGameOfWhalesManager.PLACE_LADDER;
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_DAILY_LOGIN_STREAK_BONUS))
         {
            _loc8_ = BMGameOfWhalesManager.SOURCE_DAILY_BONUS;
            _loc9_ = BMGameOfWhalesManager.PLACE_DAILY_BONUS;
         }
         else if(screensM.isScreenOpened(BMScreensManager.SCR_RAID_MENU))
         {
            _loc8_ = BMGameOfWhalesManager.SOURCE_RAID;
            _loc9_ = BMGameOfWhalesManager.PLACE_RAID;
         }
         if(param1.gold > 0)
         {
            _loc7_ = new BMDisplayRewardData();
            _loc7_.type = BMScreenDisplayReward.REWARD_TYPE_GOLD;
            _loc7_.amount = param1.gold;
            _loc6_.push(_loc7_);
            if(param3)
            {
               this.myProfile.gold -= param1.gold;
            }
            this.gameOfWhalesM.resourceAcquired(BMGameOfWhalesManager.RESOURCE_GOLD,param1.gold,_loc8_,_loc9_);
         }
         if(param1.tokens > 0)
         {
            _loc7_ = new BMDisplayRewardData();
            _loc7_.type = BMScreenDisplayReward.REWARD_TYPE_TOKENS;
            _loc7_.amount = param1.tokens;
            _loc6_.push(_loc7_);
            if(param3)
            {
               this.myProfile.tokens -= param1.tokens;
            }
            this.gameOfWhalesM.resourceAcquired(BMGameOfWhalesManager.RESOURCE_TOKENS,param1.tokens,_loc8_,_loc9_);
         }
         if(param1.clanCoins > 0)
         {
            _loc7_ = new BMDisplayRewardData();
            _loc7_.type = BMScreenDisplayReward.REWARD_TYPE_CLAN_COINS;
            _loc7_.amount = param1.clanCoins;
            _loc6_.push(_loc7_);
            if(param3)
            {
               this.myProfile.clanCoins -= param1.clanCoins;
            }
            this.gameOfWhalesM.resourceAcquired(BMGameOfWhalesManager.RESOURCE_CLAN_COINS,param1.clanCoins,_loc8_,_loc9_);
         }
         if(param1.xp > 0)
         {
            _loc7_ = new BMDisplayRewardData();
            _loc7_.type = BMScreenDisplayReward.REWARD_TYPE_XP;
            _loc7_.amount = param1.xp;
            _loc6_.push(_loc7_);
            if(param3)
            {
               this.myProfile.XP -= param1.xp;
               if(this.levelUpDB[this.myProfile.level] > this.myProfile.XP)
               {
                  --this.myProfile.level;
               }
            }
            this.gameOfWhalesM.resourceAcquired(BMGameOfWhalesManager.RESOURCE_XP,param1.xp,_loc8_,_loc9_);
         }
         if(param1.battleCredits > 0)
         {
            _loc7_ = new BMDisplayRewardData();
            _loc7_.type = BMScreenDisplayReward.REWARD_TYPE_BATTLE_CREDITS;
            _loc7_.amount = param1.battleCredits;
            _loc6_.push(_loc7_);
            if(param3)
            {
               this.myProfile.battleCredits -= param1.battleCredits;
            }
            this.gameOfWhalesM.resourceAcquired(BMGameOfWhalesManager.RESOURCE_BATTLE_CREDITS,param1.battleCredits,_loc8_,_loc9_);
         }
         if(param1.boxes.length > 0)
         {
            _loc10_ = 0;
            while(_loc10_ < param1.boxes.length)
            {
               _loc7_ = new BMDisplayRewardData();
               _loc7_.type = BMScreenDisplayReward.REWARD_TYPE_FREE_BOX;
               _loc7_.boostID = param1.boxes[_loc10_];
               _loc6_.push(_loc7_);
               _loc10_++;
            }
            if(!param3)
            {
               this.myProfile.addFreePackages(param1.boxes);
            }
         }
         if(param1.hasBoxFragments)
         {
            for(_loc11_ in param1.boxFragments)
            {
               _loc12_ = int(_loc11_);
               _loc7_ = new BMDisplayRewardData();
               _loc7_.type = BMScreenDisplayReward.REWARD_TYPE_BOX_FRAGMENTS;
               _loc7_.gachaMachineID = _loc12_;
               _loc7_.amount = param1.boxFragments[_loc12_];
               _loc7_.fillAnim_amountBefore = this.boxFragmentsManager.getNumberOfFragmentsOwned(_loc12_) % this.boxFragmentsManager.getFragmentsRequiredForBox(_loc12_);
               _loc7_.fillAnim_amountMax = this.boxFragmentsManager.getFragmentsRequiredForBox(_loc12_);
               _loc6_.push(_loc7_);
            }
            if(!param3)
            {
               this.boxFragmentsManager.addFragmentAmounts(param1.boxFragments);
            }
         }
         if(param1.items.length > 0)
         {
            _loc13_ = new Array();
            _loc14_ = 15;
            _loc10_ = 0;
            while(_loc10_ < param1.items.length)
            {
               _loc15_ = param1.items[_loc10_];
               _loc13_.push({
                  "itemID":_loc15_.itemID,
                  "playerItemID":_loc15_.playerItemID
               });
               if(!param3)
               {
                  this.addPlayerItemDataToInventory(this.player1PlayerID,_loc15_.itemID,_loc15_.playerItemID,0,0,_loc15_.power);
               }
               _loc16_ = false;
               if(_loc10_ % _loc14_ == _loc14_ - 1 || _loc10_ == param1.items.length - 1)
               {
                  _loc16_ = true;
               }
               if(_loc16_)
               {
                  _loc7_ = new BMDisplayRewardData();
                  _loc7_.type = BMScreenDisplayReward.REWARD_TYPE_FREE_BOX;
                  _loc7_.items = _loc13_;
                  _loc7_.gachaMachineID = param5;
                  _loc6_.push(_loc7_);
                  _loc13_ = new Array();
               }
               _loc10_++;
            }
         }
         if(param1.levelUpData != null)
         {
            this.myProfile.levelUpData = param1.levelUpData;
         }
         if(param4 != BMNotificationsManager.NO_NOTIFICATION_ID)
         {
            _loc10_ = 0;
            while(_loc10_ < _loc6_.length)
            {
               _loc6_[_loc10_].id = param4;
               _loc10_++;
            }
         }
         screensM.addScreen(BMScreensManager.SCR_DISPLAY_REWARD);
         screensM.screenDisplayReward.refreshScreen(_loc6_,param2,false);
      }
      
      public function addMultiplePlayerItemDatasToInventory(param1:uint, param2:Array) : void
      {
         var _loc4_:Object = null;
         var _loc5_:uint = 0;
         var _loc6_:BMItemData = null;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < param2.length)
         {
            _loc4_ = param2[_loc3_];
            _loc5_ = uint(_loc4_.itemID);
            _loc6_ = this.itemsDB[_loc5_];
            _loc7_ = 0;
            if(_loc4_.equipmentID != null)
            {
               _loc7_ = uint(_loc4_.equipmentID);
            }
            _loc8_ = 0;
            if(_loc4_.equipped != null)
            {
               _loc8_ = uint(_loc4_.equipped);
            }
            _loc9_ = 0;
            if(_loc4_.colorID != null)
            {
               _loc9_ = uint(_loc4_.colorID);
            }
            _loc10_ = 0;
            if(_loc4_.power != null)
            {
               _loc10_ = uint(_loc4_.power);
            }
            this.addPlayerItemDataToInventory(param1,_loc5_,_loc4_.playerItemID,_loc7_,_loc8_,_loc10_,_loc9_);
            _loc3_++;
         }
      }
      
      public function addPlayerItemDataToInventory(param1:uint, param2:Number, param3:Number, param4:Number = 0, param5:Number = 0, param6:Number = 0, param7:uint = 0) : uint
      {
         var _loc8_:BMPlayerData = this.playersData[param1];
         var _loc9_:BMItemData = this.itemsDB[param2];
         var _loc10_:BMPlayerItemData = new BMPlayerItemData();
         var _loc11_:BMPlayerProfile = this["player" + param1 + "Profile"];
         if(param3 > 0)
         {
            _loc10_.playerItemID = param3;
         }
         else
         {
            _loc10_.playerItemID = _loc8_.playerItemIDCounter;
            if(tutorialM.isTutorialActive() == false || _loc11_.tutorialLevel > BMTutorialManager.TUTORIAL_LEVEL_MECH1)
            {
               _loc11_.newItemsPurchased.push(_loc8_.playerItemIDCounter);
            }
            ++_loc8_.playerItemIDCounter;
         }
         _loc10_.itemID = param2;
         _loc10_.equipmentType = _loc9_.type;
         _loc10_.equipmentID = param4;
         _loc10_.equipped = param5;
         _loc10_.colorID = param7;
         _loc10_.weight = _loc9_.weight;
         if(param6 > 0)
         {
            _loc10_.power = param6;
         }
         else
         {
            _loc10_.power = _loc9_.minPowerToHave;
         }
         if(_loc9_.type == BMMechStructure.PERK)
         {
            _loc11_.hasPerks = true;
         }
         _loc8_.items.push(_loc10_);
         _loc8_.updateExistingPlayerItemIDs();
         return _loc10_.playerItemID;
      }
      
      public function removePlayerItemData(param1:uint, param2:Number) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:BMPlayerItemData = null;
         var _loc3_:BMPlayerData = this.playersData[param1];
         if(_loc3_.items.length > 0)
         {
            _loc4_ = _loc3_.items.length - 1;
            while(_loc4_ >= 0)
            {
               _loc5_ = _loc3_.items[_loc4_];
               if(_loc5_.playerItemID == param2)
               {
                  _loc3_.items.splice(_loc4_,1);
               }
               _loc4_--;
            }
         }
         _loc3_.updateExistingPlayerItemIDs();
      }
      
      public function getPlayerItemData(param1:uint, param2:Number) : BMPlayerItemData
      {
         var _loc4_:BMPlayerItemData = null;
         var _loc6_:BMPlayerItemData = null;
         var _loc3_:BMPlayerData = this.playersData[param1];
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_.items.length)
         {
            _loc6_ = _loc3_.items[_loc5_];
            if(_loc6_.playerItemID == param2)
            {
               return _loc6_;
            }
            _loc5_++;
         }
         return null;
      }
      
      public function getItemByPlayerItemID(param1:Number, param2:uint = 0) : BMItemData
      {
         var _loc4_:String = null;
         var _loc3_:uint = this.getItemIDByPlayerItemID(param1,param2);
         if(this.itemsDB[_loc3_] == null)
         {
            _loc4_ = "DataManager getItemByPlayerItemID cannot find itemID " + _loc3_ + " in itemsDB";
            throw Error(_loc4_);
         }
         return this.itemsDB[_loc3_];
      }
      
      public function getItemIDByPlayerItemID(param1:Number, param2:uint = 0) : uint
      {
         if(param1 == 0)
         {
            return 0;
         }
         if(param2 == 0)
         {
            param2 = this.player1PlayerID;
         }
         var _loc3_:BMPlayerItemData = this.getPlayerItemData(param2,param1);
         return _loc3_.itemID;
      }
      
      public function removeMultipleInventoryItems(param1:Array, param2:Number = -1) : void
      {
         if(param2 == -1)
         {
            param2 = this.player1PlayerID;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            this.removePlayerItemData(param2,param1[_loc3_]);
            _loc3_++;
         }
      }
      
      public function getBonusItems(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:String = "", param9:uint = 0) : Array
      {
         var _loc15_:BMItemData = null;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc19_:Boolean = false;
         var _loc20_:Boolean = false;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:uint = 0;
         var _loc25_:uint = 0;
         var _loc10_:Boolean = true;
         var _loc11_:BMPlayerProfile = this["player" + this.player1PlayerID + "Profile"];
         var _loc12_:Array = new Array();
         var _loc13_:Array = new Array();
         if(param1 < 3)
         {
            param1 = 3;
         }
         if(param2 < 3)
         {
            param2 = 3;
         }
         if(param3 < 3)
         {
            param3 = 3;
         }
         _loc13_[ItemRarityResolver.RARITY_COMMON] = new Array();
         _loc13_[ItemRarityResolver.RARITY_RARE] = new Array();
         _loc13_[ItemRarityResolver.RARITY_EPIC] = new Array();
         _loc13_[ItemRarityResolver.RARITY_LEGENDARY] = new Array();
         var _loc14_:Array = new Array();
         for each(_loc15_ in this.itemsDB)
         {
            if(!(_loc10_ && _loc15_.displayLevel != 1))
            {
               if(_loc15_.specialStatus <= ItemRarityResolver.RARITY_LEGENDARY)
               {
                  _loc19_ = false;
                  switch(_loc15_.specialStatus)
                  {
                     case ItemRarityResolver.RARITY_COMMON:
                        if(_loc15_.level >= param2 && _loc15_.level <= param3)
                        {
                           _loc19_ = true;
                        }
                        break;
                     default:
                        if(_loc15_.level >= param1 && _loc15_.level <= param3)
                        {
                           _loc19_ = true;
                        }
                  }
                  if(_loc19_)
                  {
                     _loc20_ = false;
                     if(param9 > 0)
                     {
                        if(_loc15_.type == BMMechStructure.KIT)
                        {
                           if(this.isPowerKit(_loc15_.itemID))
                           {
                              _loc14_.push(_loc15_.itemID);
                           }
                        }
                     }
                     switch(param8)
                     {
                        case "torsoLeg":
                           switch(_loc15_.type)
                           {
                              case BMMechStructure.TORSO:
                              case BMMechStructure.LEG:
                                 _loc20_ = true;
                           }
                           break;
                        case "weapons":
                           switch(_loc15_.type)
                           {
                              case BMMechStructure.SIDE_WEAPON:
                              case BMMechStructure.TOP_WEAPON:
                                 _loc20_ = true;
                           }
                           break;
                        case "modules":
                           switch(_loc15_.type)
                           {
                              case BMMechStructure.MODULE:
                                 _loc20_ = true;
                           }
                           break;
                        case "specials":
                           switch(_loc15_.type)
                           {
                              case BMMechStructure.DRONE:
                              case BMMechStructure.SHIELD:
                              case BMMechStructure.TELEPORT:
                              case BMMechStructure.CHARGE:
                              case BMMechStructure.HARPOON:
                                 _loc20_ = true;
                           }
                           break;
                        case "mix":
                           switch(_loc15_.type)
                           {
                              case BMMechStructure.KIT:
                                 break;
                              default:
                                 _loc20_ = true;
                           }
                           break;
                        default:
                           _loc20_ = true;
                     }
                     if(_loc20_)
                     {
                        _loc13_[_loc15_.specialStatus].push(_loc15_.itemID);
                     }
                  }
               }
            }
         }
         _loc16_ = 0;
         _loc17_ = 0;
         if(_loc11_.itemBoxesBought_guest < this.guestFixedItemsDB.length)
         {
            _loc16_ = uint(this.guestFixedItemsDB[_loc11_.itemBoxesBought_guest].rarity);
            _loc17_ = uint(this.guestFixedItemsDB[_loc11_.itemBoxesBought_guest].amount);
            param9 = 0;
         }
         var _loc18_:uint = 1;
         while(_loc18_ <= param4)
         {
            _loc21_ = -1;
            _loc23_ = Math.random() * 100;
            if(_loc16_ > 0)
            {
               if(_loc17_ > 0)
               {
                  switch(_loc16_)
                  {
                     case 1:
                        _loc23_ = param5;
                        break;
                     case 2:
                        _loc23_ = param6;
                        break;
                     case 3:
                        _loc23_ = param7;
                  }
                  _loc17_--;
               }
               else
               {
                  _loc23_ = 100;
               }
            }
            if(_loc13_[ItemRarityResolver.RARITY_LEGENDARY].length > 0)
            {
               if(_loc23_ <= param7)
               {
                  _loc22_ = RandomUtils.chooseRandomIndex(_loc13_[ItemRarityResolver.RARITY_LEGENDARY]);
                  _loc21_ = Number(_loc13_[ItemRarityResolver.RARITY_LEGENDARY][_loc22_]);
               }
            }
            if(_loc21_ == -1)
            {
               if(_loc13_[ItemRarityResolver.RARITY_EPIC].length > 0)
               {
                  if(_loc23_ <= param7 + param6)
                  {
                     _loc22_ = RandomUtils.chooseRandomIndex(_loc13_[ItemRarityResolver.RARITY_EPIC]);
                     _loc21_ = Number(_loc13_[ItemRarityResolver.RARITY_EPIC][_loc22_]);
                  }
               }
            }
            if(_loc21_ == -1)
            {
               if(_loc13_[ItemRarityResolver.RARITY_RARE].length > 0)
               {
                  if(_loc23_ <= param7 + param6 + param5)
                  {
                     _loc22_ = RandomUtils.chooseRandomIndex(_loc13_[ItemRarityResolver.RARITY_RARE]);
                     _loc21_ = Number(_loc13_[ItemRarityResolver.RARITY_RARE][_loc22_]);
                  }
               }
            }
            if(_loc21_ == -1)
            {
               if(_loc13_[ItemRarityResolver.RARITY_COMMON].length > 0)
               {
                  _loc22_ = RandomUtils.chooseRandomIndex(_loc13_[ItemRarityResolver.RARITY_COMMON]);
                  _loc21_ = Number(_loc13_[ItemRarityResolver.RARITY_COMMON][_loc22_]);
               }
            }
            _loc12_.push(_loc21_);
            _loc18_++;
         }
         if(param9 > 0 && _loc14_.length > 0)
         {
            _loc24_ = Math.ceil(Math.random() * 100);
            if(_loc24_ <= param9)
            {
               _loc25_ = uint(RandomUtils.chooseRandomIndex(_loc14_));
               _loc12_.push(_loc14_[_loc25_]);
            }
         }
         return _loc12_;
      }
      
      public function handleGotRewardData(param1:BMRewardData, param2:int, param3:String = "", param4:int = -1) : void
      {
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         TsLogger.log("handleGotRewardData::handleGotRewardData " + param2);
         if(param1.gold > 0 || param1.tokens > 0 || param1.xp > 0 || param1.clanCoins > 0 || param1.battleCredits > 0 || param1.hasBoxFragments)
         {
            this.giveRewardPopup(param1,param3,false,param4,param2);
         }
         else
         {
            if(param1.hasBoxes)
            {
               this.myProfile.addFreePackages(param1.boxes);
            }
            if(param1.hasItems)
            {
               _loc5_ = new Array();
               _loc6_ = new Array();
               for each(_loc7_ in param1.items)
               {
                  this.addPlayerItemDataToInventory(this.player1PlayerID,_loc7_.itemID,_loc7_.playerItemID,0,0,_loc7_.power,_loc7_.colorID);
                  _loc5_.push(_loc7_.itemID);
                  _loc6_.push(_loc7_.playerItemID);
                  this.myProfile.newItemsPurchased.push(_loc7_.playerItemID);
               }
               _loc8_ = BMShopManager.getInstance().showExtraCardInItemCardsScreen(param2);
               _loc9_ = false;
               screensM.addScreen(BMScreensManager.SCR_ITEM_CARDS);
               screensM.screenItemCards.refreshScreen(_loc5_,_loc6_,param2,_loc9_,_loc8_);
               if(screensM.isScreenOpened(BMScreensManager.SCR_HANGER_UPGRADE))
               {
                  screensM.screenHangerUpgrade.onInventoryChanged();
               }
            }
            else
            {
               screensM.addScreen(BMScreensManager.SCR_GET_ITEMS_NO_SPACE);
            }
         }
         if(BMShopManager.gi().isScreenOpened())
         {
            BMShopManager.gi().refresh();
         }
      }
      
      public function isPowerKit(param1:Number) : Boolean
      {
         var _loc2_:BMItemData = this.itemsDB[param1];
         if(_loc2_.type == BMMechStructure.KIT && _loc2_.subType == "power")
         {
            return true;
         }
         return false;
      }
      
      public function updateMechStructure(param1:uint, param2:uint) : void
      {
         var _loc6_:BMPlayerItemData = null;
         var _loc7_:BMItemData = null;
         var _loc8_:String = null;
         var _loc9_:Boolean = false;
         var _loc10_:String = null;
         var _loc3_:BMPlayerData = this.playersData[param1];
         var _loc4_:BMMechStructure = _loc3_.mechStructures[param2];
         _loc4_.resetStructure();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_.items.length)
         {
            _loc6_ = _loc3_.items[_loc5_];
            if(this.itemsDB[_loc6_.itemID] != null)
            {
               _loc7_ = this.itemsDB[_loc6_.itemID];
               if(_loc6_.equipped == param2)
               {
                  if(_loc7_.type != _loc6_.equipmentType)
                  {
                     _loc10_ = "ItemDB<->PlayerItemData mismatch! ItemDB of type " + _loc7_.type + " while equipmentType is of type " + _loc6_.equipmentType;
                     throw Error(_loc10_);
                  }
                  _loc9_ = false;
                  switch(_loc7_.type)
                  {
                     case BMMechStructure.TORSO:
                     case BMMechStructure.LEG:
                     case BMMechStructure.DRONE:
                     case BMMechStructure.SHIELD:
                     case BMMechStructure.TELEPORT:
                     case BMMechStructure.CHARGE:
                     case BMMechStructure.HARPOON:
                     case BMMechStructure.PERK:
                        _loc8_ = _loc6_.equipmentType;
                        break;
                     default:
                        _loc8_ = _loc6_.equipmentType + _loc6_.equipmentID;
                        if(_loc6_.equipmentID == 0)
                        {
                           _loc9_ = true;
                        }
                  }
                  if(_loc9_ == false)
                  {
                     _loc4_[_loc8_] = _loc6_.playerItemID;
                  }
                  else
                  {
                     TsLogger.log("ERROR partName:" + _loc8_);
                  }
               }
            }
            else
            {
               TsLogger.log(" ! ! ! ERROR - ITEM ID " + _loc6_.itemID + " DOES NOT EXIST");
            }
            _loc5_++;
         }
      }
      
      private function createMechStructures_playerItemBased(param1:Number, param2:uint, param3:BMMechStructure, param4:Number, param5:Number) : void
      {
         var _loc7_:BMMechStructure = null;
         var _loc9_:uint = 0;
         var _loc10_:BMPlayerProfile = null;
         var _loc11_:BMPlayerProfile = null;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc6_:Object = this["playerData" + param1 + "Inventory"];
         if(param3 != null)
         {
            _loc7_ = param3;
         }
         else
         {
            _loc7_ = this.createSpecificMechStructure_ItemBased(param4,param5);
         }
         var _loc8_:uint = 0;
         if(param1 == this.LOCAL_OPPONENT_ID || this.gameType == GAME_TYPE_PVE && param1 == this.ONLINE_OPPONENT_ID)
         {
            _loc10_ = this["player" + this.player1PlayerID + "Profile"];
            _loc11_ = this["player" + this.player2PlayerID + "Profile"];
            _loc12_ = _loc11_.level - _loc10_.levelByItems;
            if(this.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION)
            {
               if(this.battleSubType == BMSinglePlayerManager.ENEMY_TYPE_BOSS)
               {
                  _loc13_ = _loc7_.torso_colorID;
               }
               else
               {
                  _loc13_ = _loc10_.mission_colorID;
               }
            }
            else if(this.battleType == BMSinglePlayerManager.BATTLE_TYPE_CLAN_BOSS)
            {
               _loc13_ = this.myProfile.clanBossData.colorID;
            }
            else
            {
               _loc13_ = this.getComputerColorID(_loc12_);
            }
            _loc8_ = _loc13_;
            _loc7_.torso_colorID = _loc13_;
            _loc7_.leg_colorID = _loc13_;
            _loc9_ = 1;
            while(_loc9_ <= this.maxEquipment[BMMechStructure.SIDE_WEAPON])
            {
               _loc7_[BMMechStructure.SIDE_WEAPON + _loc9_ + "_colorID"] = _loc13_;
               _loc9_++;
            }
            _loc9_ = 1;
            while(_loc9_ <= this.maxEquipment[BMMechStructure.TOP_WEAPON])
            {
               _loc7_[BMMechStructure.TOP_WEAPON + _loc9_ + "_colorID"] = _loc13_;
               _loc9_++;
            }
         }
         this.addInventoryItem(param1,_loc6_,_loc7_.torso,param2,BMMechStructure.TORSO,0,_loc7_.torso_colorID,0);
         this.addInventoryItem(param1,_loc6_,_loc7_.leg,param2,BMMechStructure.LEG,0,_loc7_.leg_colorID,0);
         _loc9_ = 1;
         while(_loc9_ <= this.maxEquipment[BMMechStructure.SIDE_WEAPON])
         {
            this.addInventoryItem(param1,_loc6_,_loc7_[BMMechStructure.SIDE_WEAPON + _loc9_],param2,BMMechStructure.SIDE_WEAPON,_loc9_,_loc7_[BMMechStructure.SIDE_WEAPON + _loc9_ + "_colorID"],0);
            _loc9_++;
         }
         _loc9_ = 1;
         while(_loc9_ <= this.maxEquipment[BMMechStructure.TOP_WEAPON])
         {
            this.addInventoryItem(param1,_loc6_,_loc7_[BMMechStructure.TOP_WEAPON + _loc9_],param2,BMMechStructure.TOP_WEAPON,_loc9_,_loc7_[BMMechStructure.TOP_WEAPON + _loc9_ + "_colorID"],0);
            _loc9_++;
         }
         this.addInventoryItem(param1,_loc6_,_loc7_.drone,param2,BMMechStructure.DRONE,0,_loc8_,0);
         this.addInventoryItem(param1,_loc6_,_loc7_.shield,param2,BMMechStructure.SHIELD,0,0,0);
         this.addInventoryItem(param1,_loc6_,_loc7_.teleport,param2,BMMechStructure.TELEPORT,0,0,0);
         this.addInventoryItem(param1,_loc6_,_loc7_.charge,param2,BMMechStructure.CHARGE,0,0,0);
         this.addInventoryItem(param1,_loc6_,_loc7_.harpoon,param2,BMMechStructure.HARPOON,0,0,0);
         _loc9_ = 1;
         while(_loc9_ <= this.maxEquipment[BMMechStructure.KIT])
         {
            this.addInventoryItem(param1,_loc6_,_loc7_[BMMechStructure.KIT + _loc9_],param2,BMMechStructure.KIT,_loc9_,0,0);
            _loc9_++;
         }
         _loc9_ = 1;
         while(_loc9_ <= this.maxEquipment[BMMechStructure.MODULE])
         {
            this.addInventoryItem(param1,_loc6_,_loc7_[BMMechStructure.MODULE + _loc9_],param2,BMMechStructure.MODULE,_loc9_,0,0);
            _loc9_++;
         }
         this.addInventoryItem(param1,_loc6_,_loc7_.perk,param2,BMMechStructure.PERK,0,0,0);
      }
      
      public function getComputerColorID(param1:Number) : Number
      {
         var _loc2_:Number = 0;
         if(param1 < 0)
         {
            _loc2_ = 3;
         }
         else if(param1 == 0)
         {
            _loc2_ = 4;
         }
         else if(param1 == 1)
         {
            _loc2_ = 1;
         }
         else if(param1 == 2)
         {
            _loc2_ = 8;
         }
         else if(param1 == 3)
         {
            _loc2_ = 5;
         }
         else if(param1 > 3)
         {
            _loc2_ = 9;
         }
         return _loc2_;
      }
      
      public function addMultipleInventoryItems(param1:uint, param2:Array, param3:uint = 0) : void
      {
         var _loc5_:BMPlayerItemDataTemplate = null;
         var _loc4_:uint = 0;
         while(_loc4_ < param2.length)
         {
            _loc5_ = param2[_loc4_];
            if(param3 > 0)
            {
               _loc5_.colorID = param3;
            }
            this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],_loc5_.itemID,_loc5_.equipped,_loc5_.equipmentType,_loc5_.equipmentID,_loc5_.colorID,_loc5_.power);
            _loc4_++;
         }
      }
      
      public function addInventoryItem(param1:Number, param2:Object, param3:Number, param4:Number, param5:String, param6:Number = 0, param7:Number = 0, param8:Number = 0) : void
      {
         var _loc9_:Number = NaN;
         var _loc10_:BMItemData = null;
         var _loc11_:Object = null;
         if(param3 > 0)
         {
            _loc9_ = Number(this["player" + param1 + "playerItemIDCounter"]);
            if(param8 == 0)
            {
               switch(param1)
               {
                  case this.LOCAL_PLAYER_ID:
                  case this.ONLINE_PLAYER_ID:
                     param8 = Number(this.itemsDB[param3].power);
               }
            }
            _loc10_ = this.itemsDB[param3];
            _loc11_ = {
               "playerItemID":_loc9_,
               "itemID":param3,
               "equipped":param4,
               "type":param5,
               "equipmentID":param6,
               "colorID":param7,
               "power":param8,
               "weight":_loc10_.weight
            };
            param2[_loc9_] = _loc11_;
            this["player" + param1 + "playerItemIDCounter"] = _loc9_ + 1;
         }
      }
      
      public function createSpecificMechStructure_ItemBased(param1:Number, param2:Number, param3:uint = 0) : BMMechStructure
      {
         var _loc5_:BMItemData = null;
         var _loc6_:BMItemData = null;
         var _loc8_:Number = NaN;
         var _loc10_:uint = 0;
         var _loc11_:Number = NaN;
         var _loc4_:BMMechStructure = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
         var _loc7_:Array = new Array();
         var _loc9_:Array = this.getEnemyAllowedDamageTypesInCampaign();
         if(param3 > 0)
         {
            _loc9_ = new Array();
            _loc9_.push(param3);
         }
         _loc4_.initialize(-1,0);
         param1 = Math.min(param1,150);
         param2 = Math.min(param2,150);
         _loc7_ = this.getReleventItemIDsFromItemsDB(BMMechStructure.TORSO,param1,param2,true,_loc9_);
         _loc8_ = this.chooseRandomItemIDFromItemIDList(_loc7_);
         _loc6_ = this.itemsDB[_loc8_];
         _loc4_.torso = _loc6_.itemID;
         _loc7_ = this.getReleventItemIDsFromItemsDB(BMMechStructure.LEG,param1,param2,true,_loc9_);
         _loc8_ = this.chooseRandomItemIDFromItemIDList(_loc7_);
         _loc5_ = this.itemsDB[_loc8_];
         _loc4_.leg = _loc5_.itemID;
         _loc4_ = this.createSpecificMechItemIDsPerType(_loc4_,BMMechStructure.SIDE_WEAPON,param1,param2,true,param3);
         _loc4_ = this.createSpecificMechItemIDsPerType(_loc4_,BMMechStructure.TOP_WEAPON,param1,param2,true,param3);
         _loc4_ = this.createSpecificMechItemIDsPerType(_loc4_,BMMechStructure.DRONE,param1,param2,false);
         _loc4_ = this.createSpecificMechItemIDsPerType(_loc4_,BMMechStructure.SHIELD,param1,param2,false);
         _loc4_ = this.createSpecificMechItemIDsPerType(_loc4_,BMMechStructure.TELEPORT,param1,param2,false);
         _loc4_ = this.createSpecificMechItemIDsPerType(_loc4_,BMMechStructure.CHARGE,param1,param2,false);
         _loc4_ = this.createSpecificMechItemIDsPerType(_loc4_,BMMechStructure.HARPOON,param1,param2,false);
         var _loc12_:Array = new Array();
         var _loc13_:String = "";
         if(_loc4_.shield > 0)
         {
            _loc5_ = this.itemsDB[_loc4_.shield];
            if(_loc5_.energyPerBlock > 0)
            {
               _loc13_ = "energy";
            }
            else
            {
               _loc13_ = "heat";
            }
         }
         if(_loc13_ == "energy")
         {
            _loc12_.push("energy");
         }
         else
         {
            _loc12_.push("heat");
         }
         var _loc14_:Number = Math.ceil(Math.random() * 2);
         if(_loc14_ == 1)
         {
            _loc12_.push("resistance");
         }
         if(_loc13_ == "energy")
         {
            _loc12_.push("energy");
         }
         else
         {
            _loc12_.push("heat");
         }
         _loc12_.push("heat");
         if(_loc13_ == "energy")
         {
            _loc12_.push("energy");
         }
         else
         {
            _loc12_.push("heat");
         }
         _loc12_.push("armor");
         _loc12_.push("armor");
         _loc12_.push("armor");
         _loc12_.push("armor");
         var _loc15_:uint = this.getEquipmentUnlockByLevel(param2,BMMechStructure.MODULE);
         if(_loc15_ > 0)
         {
            _loc10_ = 1;
            while(_loc10_ <= _loc15_)
            {
               _loc4_[BMMechStructure.MODULE + _loc10_] = this.getKitOrModuleItemIDByTypeAndLevel(BMMechStructure.MODULE,_loc12_[_loc10_ - 1],param2);
               _loc10_++;
            }
         }
         return _loc4_;
      }
      
      private function getKitOrModuleItemIDByTypeAndLevel(param1:String, param2:String, param3:Number) : Number
      {
         var _loc11_:Array = null;
         var _loc12_:Number = NaN;
         var _loc13_:uint = 0;
         var _loc14_:Number = NaN;
         var _loc4_:String = param1 + "_" + param2;
         var _loc5_:Number = Number(this.itemsMaxLevelsDB[_loc4_]);
         if(param3 > _loc5_)
         {
            param3 = _loc5_;
         }
         var _loc6_:Number = param3;
         var _loc7_:Number = param3;
         var _loc8_:Array = this[param1 + "s_" + param2];
         var _loc9_:uint = 1;
         var _loc10_:Number = 0;
         while(_loc9_ <= 3 && _loc10_ == 0)
         {
            _loc11_ = new Array();
            _loc12_ = _loc6_;
            while(_loc12_ <= _loc7_)
            {
               if(_loc8_[_loc12_] != null)
               {
                  _loc13_ = 0;
                  while(_loc13_ < _loc8_[_loc12_].length)
                  {
                     _loc11_.push(_loc8_[_loc12_][_loc13_]);
                     _loc13_++;
                  }
               }
               _loc12_++;
            }
            if(_loc11_.length > 0)
            {
               _loc14_ = RandomUtils.chooseRandomIndex(_loc11_);
               _loc10_ = Number(_loc11_[_loc14_]);
            }
            _loc7_++;
            if(--_loc6_ < 1)
            {
               _loc6_ = 1;
            }
            if(_loc7_ > this.LEVEL_MAX)
            {
               _loc7_ = this.LEVEL_MAX;
            }
            _loc9_++;
         }
         if(_loc10_ == 0)
         {
            TsLogger.log("combinedType:" + _loc4_ + " itemLevelMax:" + _loc5_ + " MISSING");
         }
         return _loc10_;
      }
      
      private function createSpecificMechItemIDsPerType(param1:BMMechStructure, param2:String, param3:Number, param4:Number, param5:Boolean, param6:uint = 0) : BMMechStructure
      {
         var _loc8_:Number = NaN;
         var _loc9_:uint = 0;
         var _loc10_:String = null;
         var _loc11_:Array = null;
         var _loc12_:Array = null;
         var _loc13_:Number = NaN;
         var _loc14_:Boolean = false;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:BMItemData = null;
         var _loc18_:String = null;
         var _loc19_:uint = 0;
         var _loc7_:Boolean = true;
         switch(param2)
         {
            case BMMechStructure.SIDE_WEAPON:
            case BMMechStructure.TOP_WEAPON:
               _loc8_ = this.getEquipmentUnlockByLevel(param4,param2);
               if(_loc8_ == 0)
               {
                  _loc7_ = false;
               }
               break;
            default:
               _loc8_ = 1;
               break;
            case BMMechStructure.MODULE:
            case BMMechStructure.KIT:
               TsLogger.log("WARNING : createSpecificMechItemIDsPerType is not built for modules and kits!!!");
         }
         if(_loc7_)
         {
            _loc9_ = 1;
            while(_loc9_ <= _loc8_)
            {
               _loc10_ = param2;
               if(param3 > this.itemsMaxLevelsDB[_loc10_])
               {
                  param3 = this.itemsMaxLevelsDB[_loc10_] - 3;
                  param4 = Number(this.itemsMaxLevelsDB[_loc10_]);
                  if(param3 < 1)
                  {
                     param3 = 1;
                  }
               }
               _loc11_ = this.getEnemyAllowedDamageTypesInCampaign();
               _loc12_ = this.getReleventItemIDsFromItemsDB(param2,param3,param4,true,_loc11_);
               if(_loc12_.length > 0)
               {
                  if(param3 > 1 && _loc12_.length == 1)
                  {
                     _loc15_ = param3 = param3 - 3;
                     if(_loc15_ < 1)
                     {
                        _loc15_ = 1;
                     }
                     _loc12_ = this.getReleventItemIDsFromItemsDB(param2,_loc15_,param4,true,_loc11_);
                  }
                  _loc13_ = 0;
                  _loc14_ = false;
                  while(_loc13_ < 10 && _loc14_ == false)
                  {
                     _loc16_ = this.chooseRandomItemIDFromItemIDList(_loc12_);
                     _loc17_ = this.itemsDB[_loc16_];
                     _loc14_ = true;
                     if(param6 > 0 && _loc17_.damageType != param6)
                     {
                        _loc14_ = false;
                     }
                     _loc18_ = param2;
                     switch(_loc18_)
                     {
                        case BMMechStructure.SIDE_WEAPON:
                        case BMMechStructure.TOP_WEAPON:
                           _loc18_ = param2 + _loc9_;
                     }
                     if(param5)
                     {
                        switch(param2)
                        {
                           case BMMechStructure.SIDE_WEAPON:
                           case BMMechStructure.TOP_WEAPON:
                              _loc19_ = 1;
                              while(_loc19_ < this.maxEquipment[param2])
                              {
                                 if(param1[param2 + _loc19_] == _loc17_.itemID)
                                 {
                                    _loc14_ = false;
                                 }
                                 _loc19_++;
                              }
                        }
                     }
                     if(_loc14_)
                     {
                        param1[_loc18_] = _loc17_.itemID;
                     }
                     _loc13_++;
                  }
               }
               _loc9_++;
            }
         }
         return param1;
      }
      
      public function resetItemsCache() : void
      {
         this.itemIDsAllowedForPC = null;
      }
      
      private function getItemIDSAllowedForPC() : Array
      {
         var _loc1_:BMItemData = null;
         if(!this.itemIDsAllowedForPC)
         {
            this.itemIDsAllowedForPC = new Array();
            for each(_loc1_ in this.itemsDB)
            {
               if(this.itemIDsForbiddenForPC[_loc1_.itemID] == null && _loc1_.displayLevel == 1)
               {
                  this.itemIDsAllowedForPC.push(_loc1_.itemID);
               }
            }
         }
         return this.itemIDsAllowedForPC;
      }
      
      private function getEnemyAllowedDamageTypesInCampaign() : Array
      {
         var _loc1_:Array = [1,2,3];
         if(this.myProfile.currentStoryID != BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1)
         {
            return _loc1_;
         }
         if(this.myProfile.mapProgress.length - 2 < this.singlePlayerM.getBossSlotForChapter(this.myProfile.currentStoryID,1))
         {
            _loc1_ = [1];
         }
         else if(this.myProfile.mapProgress.length - 2 < this.singlePlayerM.getBossSlotForChapter(this.myProfile.currentStoryID,2))
         {
            _loc1_ = [1,2];
         }
         return _loc1_;
      }
      
      private function getReleventItemIDsFromItemsDB(param1:String, param2:Number, param3:Number, param4:Boolean = true, param5:Array = null) : Array
      {
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:BMItemData = null;
         var _loc6_:Array = new Array();
         if(param5 == null)
         {
            param5 = [1,2,3];
         }
         var _loc7_:uint = param2;
         while(_loc7_ <= param3)
         {
            if(this.itemsByTypeAndPowerRating[param1] != null)
            {
               if(this.itemsByTypeAndPowerRating[param1][_loc7_] != null)
               {
                  _loc8_ = 0;
                  for(; _loc8_ < this.itemsByTypeAndPowerRating[param1][_loc7_].length; _loc8_++)
                  {
                     _loc9_ = uint(this.itemsByTypeAndPowerRating[param1][_loc7_][_loc8_]);
                     _loc10_ = this.itemsDB[_loc9_];
                     if(_loc10_ != null)
                     {
                        if(!(_loc10_.damageType > 0 && param5.indexOf(_loc10_.damageType) == -1))
                        {
                           if(param4 == false)
                           {
                              if(_loc10_.animation.substr(0,5) == "sword")
                              {
                                 continue;
                              }
                           }
                           if(!(Boolean(this.notReleasedItemChainIDs) && this.notReleasedItemChainIDs.indexOf(_loc10_.chainID) !== -1))
                           {
                              _loc6_.push(_loc9_);
                           }
                        }
                     }
                  }
               }
            }
            _loc7_++;
         }
         return _loc6_;
      }
      
      public function getOverloadHPPenaltyForWeight(param1:uint) : int
      {
         if(param1 > this.weightMax)
         {
            return (param1 - this.weightMax) * this.weightOverloadHPPenalty;
         }
         return 0;
      }
      
      public function getOverloadHPPenalty(param1:Array, param2:Boolean) : int
      {
         var _loc5_:BMPlayerItemData = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            if(param2)
            {
               _loc5_ = param1[_loc4_];
               _loc3_ += _loc5_.weight;
            }
            _loc4_++;
         }
         return this.getOverloadHPPenaltyForWeight(_loc3_);
      }
      
      public function createMissionLocally(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc14_:Object = null;
         var _loc17_:BMPlayerItemData = null;
         var _loc18_:BMItemData = null;
         var _loc19_:uint = 0;
         var _loc4_:BMPlayerProfile = this["player" + this.player1PlayerID + "Profile"];
         var _loc5_:BMPlayerData = this.playersData[this.player1PlayerID];
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         for(; _loc13_ < _loc5_.items.length; _loc13_++)
         {
            _loc17_ = _loc5_.items[_loc13_];
            if(_loc17_.equipped != _loc5_.selectedMechID)
            {
               continue;
            }
            _loc18_ = this.itemsDB[_loc17_.itemID];
            switch(_loc18_.type)
            {
               case BMMechStructure.TORSO:
               case BMMechStructure.LEG:
               case BMMechStructure.MODULE:
                  _loc6_ += _loc18_.HPBase;
                  _loc7_ += _loc18_.energyBase;
                  _loc8_ += _loc18_.energyAddon;
                  _loc9_ += _loc18_.heatBase;
                  _loc10_ += _loc18_.heatAddon;
                  _loc11_ += _loc18_.bullets;
                  _loc12_ += _loc18_.rockets;
            }
         }
         _loc6_ -= this.getOverloadHPPenalty(_loc5_.items,true);
         _loc4_.setCurrentMissionSlot(param1);
         if(param1 <= 2)
         {
            _loc14_ = this.singlePlayerM.missionLayouts_tutorial[param1];
         }
         else
         {
            _loc19_ = uint(RandomUtils.chooseRandomIndex(this.singlePlayerM.missionLayouts_regular[param2]));
            _loc14_ = this.singlePlayerM.missionLayouts_regular[param2][_loc19_];
         }
         var _loc15_:BMMissionServerToClientStats = new BMMissionServerToClientStats();
         var _loc16_:BMMissionMechStats = new BMMissionMechStats();
         _loc15_.rows = _loc14_.rows;
         _loc15_.columns = _loc14_.columns;
         _loc15_.difficulty = param2;
         _loc15_.layout = _loc14_.layout;
         _loc15_.playerPosition = _loc14_.startLocation;
         _loc15_.startingPosition = _loc14_.startLocation;
         _loc15_.missionID = _loc4_.currentMissionSlot + 1;
         _loc16_.hp = _loc6_;
         _loc16_.hpMax = _loc6_;
         _loc16_.energy = _loc7_;
         _loc16_.energyRegeneration = _loc8_;
         _loc16_.heat = _loc9_;
         _loc16_.heatCooling = _loc10_;
         _loc16_.bullets = _loc11_;
         _loc16_.rockets = _loc12_;
         _loc15_.mechsStats[0] = _loc16_;
         _loc4_.updateMissionData(_loc15_);
         this.saveGuestData("createMissionLocally");
      }
      
      public function getTargetBattleType() : Array
      {
         var _loc1_:BMPlayerProfile = this["player" + this.player1PlayerID + "Profile"];
         var _loc2_:String = BMSinglePlayerManager.BATTLE_TYPE_REGULAR;
         var _loc3_:String = "";
         return [_loc2_,_loc3_];
      }
      
      public function getCurrentMissionMechsPerPlayer() : uint
      {
         if(tutorialM.isTutorialActive())
         {
            return 1;
         }
         return BMSinglePlayerManager.MECHS_PER_STORY_ID[this.myProfile.currentStoryID];
      }
      
      public function startBattleVSComputer(param1:String, param2:String = "", param3:Number = -1, param4:Number = -1, param5:Number = -1, param6:Function = null, param7:* = false, param8:uint = 0) : void
      {
         var _loc9_:BMPlayerProfile = null;
         var _loc10_:uint = 0;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Object = null;
         var _loc16_:Object = null;
         var _loc17_:Boolean = false;
         var _loc18_:BMWorldMapLocationData = null;
         var _loc19_:BMWorldMapBossData = null;
         var _loc20_:String = null;
         var _loc21_:Number = NaN;
         var _loc22_:String = null;
         var _loc23_:String = null;
         var _loc24_:uint = 0;
         var _loc25_:Boolean = false;
         if(this.gameType == GAME_TYPE_TUTORIAL || this.gameType == GAME_TYPE_TUTORIAL_PVE)
         {
            this.setGameTypeAndPlayers(GAME_TYPE_TUTORIAL_PVE,GAME_SUB_TYPE_NONE,"dataManager_startBattleVSComputer");
         }
         else if(this.gameType == GAME_TYPE_PVP)
         {
            this.setGameTypeAndPlayers(GAME_TYPE_PVP,GAME_SUB_TYPE_PVP_BOT,"dataManager_startBattleVSComputer");
         }
         else if(param7)
         {
            if(param8 > 0)
            {
               this.setGameTypeAndPlayers(GAME_TYPE_CLAN_WAR,GAME_SUB_TYPE_NONE,"dataManager_startBattleVSComputer");
            }
            else
            {
               this.setGameTypeAndPlayers(GAME_TYPE_PVE_ON_SERVER,GAME_SUB_TYPE_NONE,"dataManager_startBattleVSComputer");
            }
         }
         else
         {
            this.setGameTypeAndPlayers(GAME_TYPE_PVE,GAME_SUB_TYPE_NONE,"dataManager_startBattleVSComputer");
         }
         this.battleMechsPerPlayer = 1;
         if(param1 == BMSinglePlayerManager.BATTLE_TYPE_MISSION)
         {
            this.battleMechsPerPlayer = this.getCurrentMissionMechsPerPlayer();
         }
         this.battleType = param1;
         this.battleSubType = param2;
         this.skipChallenge = false;
         _loc9_ = this.myProfile;
         _loc9_.updateLevelByItems();
         ++_loc9_.battlesVSComputer;
         this.computerBattleID = 0;
         this.computerMechStructures = null;
         this.computerDifficultyMultiplier = NaN;
         this.battleData = {};
         this.battleData.startingPlayer = 1;
         if(this.gameType == GAME_TYPE_PVP)
         {
            this.battleData.general = {};
            this.battleData.general.secondsInTurn = 30;
            this.battleData.general.firstTurnSecondsAddon = 2;
         }
         var _loc11_:Array = this.getMapTotalStepsAndPlayerPositions(this.battleType,this.battleSubType,_loc9_.level,_loc9_.winsVSComputer);
         _loc12_ = Number(_loc11_[0]);
         _loc13_ = Number(_loc11_[1]);
         _loc14_ = Number(_loc11_[2]);
         if(param3 > -1)
         {
            _loc13_ = param3;
            _loc14_ = param4;
         }
         this.battleData.map = {};
         this.battleData.map.stepsTotal = _loc12_;
         _loc15_ = {};
         _loc15_.currentStep = _loc13_;
         _loc16_ = {};
         _loc16_.currentStep = _loc14_;
         _loc17_ = false;
         switch(this.battleType)
         {
            case BMSinglePlayerManager.BATTLE_TYPE_MISSION:
               switch(this.battleSubType)
               {
                  case BMSinglePlayerManager.ENEMY_TYPE_TURRET:
                  case BMSinglePlayerManager.ENEMY_TYPE_JEEP:
                  case BMSinglePlayerManager.ENEMY_TYPE_TANK:
                     _loc22_ = getSpecificText("missionBaseMap_" + this.battleSubType);
                     _loc16_.playerName = _loc22_;
                     break;
                  case BMSinglePlayerManager.ENEMY_TYPE_BOSS:
                     if(this.raidData.isRaidInProgress())
                     {
                        _loc22_ = "BASE DEFENDER MARK " + (this.raidData.currentLevel + 1);
                     }
                     else
                     {
                        _loc18_ = this.singlePlayerM.currentMissionDB;
                        _loc20_ = _loc18_.bossID;
                        _loc19_ = this.singlePlayerM.getMissionBossData(_loc9_.currentStoryID,_loc18_.campaignID,_loc20_,_loc9_.currentMissionMode);
                        _loc22_ = _loc19_.name;
                     }
                     _loc16_.playerName = _loc22_;
                     break;
                  default:
                     _loc17_ = true;
               }
               break;
            case BMSinglePlayerManager.BATTLE_TYPE_CLAN_BOSS:
               _loc16_.playerName = this.myProfile.clanBossData.name;
               break;
            case BMSinglePlayerManager.BATTLE_TYPE_CLAN_WAR:
               _loc16_.playerName = this.clanWarsM.getPlayerData(param8,BMClanWarsManager.ALIGNMENT_ENEMY_CLAN).playerName;
               break;
            default:
               _loc17_ = true;
         }
         if(_loc17_)
         {
            _loc10_ = uint(RandomUtils.chooseRandomIndex(this.computerNamesDB));
            _loc23_ = this.computerNamesDB[_loc10_];
            _loc16_.playerName = _loc23_;
         }
         this.battle_clientInverted = false;
         switch(this.battleType)
         {
            case BMSinglePlayerManager.BATTLE_TYPE_MISSION:
               _loc24_ = 1 + Math.ceil(_loc9_.currentMissionSlot / 70 * (this.LEVEL_MAX - 1));
               if(_loc24_ < 2)
               {
                  _loc24_ = 2;
               }
               else if(_loc24_ > this.LEVEL_MAX)
               {
                  _loc24_ = this.LEVEL_MAX;
               }
               _loc16_.level = _loc24_;
               _loc16_.levelByItems = _loc24_;
               break;
            default:
               _loc16_.level = _loc9_.levelByItems;
               _loc16_.levelByItems = _loc16_.level;
         }
         switch(this.player1PlayerID)
         {
            case this.LOCAL_PLAYER_ID:
               _loc21_ = this.LOCAL_OPPONENT_ID;
               break;
            case this.ONLINE_PLAYER_ID:
               _loc21_ = this.ONLINE_OPPONENT_ID;
         }
         this.battleData.player1 = {};
         this.battleData.player1.currentStep = _loc15_.currentStep;
         this.battleData.player2 = {};
         this.battleData.player2.currentStep = _loc16_.currentStep;
         this.computerBattlePhase2Object = {};
         this.computerBattlePhase2Object.opponentPlayerID = _loc21_;
         this.computerBattlePhase2Object.opponentPlayerDataObject = _loc16_;
         this.computerBattlePhase2Object.battlePosition = param5;
         this.computerBattlePhase2Object.bossID = _loc20_;
         this.computerBattlePhase2Object.targetBossData = _loc19_;
         this.computerBattlePhase2Object.battleSubType = param2;
         this.computerBattlePhase2Object.targetMissionData = _loc18_;
         this.computerStartBattleSuccessHandler = param6;
         if(BattleTypeResolver.isTutorial)
         {
            this.startBattleVsComputer_phase2();
            return;
         }
         if(BattleTypeResolver.isLadderPvPBot)
         {
            return;
         }
         if(BattleTypeResolver.isPvEOnServer)
         {
            _loc25_ = param2 == BMSinglePlayerManager.ENEMY_TYPE_CLAN_BOSS;
            remoteM.socketM.lobby_startedOnlineBattleVSComputer(param5,this.myProfile.missionCurrentMechID,_loc25_,param8);
            return;
         }
         if(param6 == null)
         {
            throw Error("startBattleVsComputer is asynchronous and requires a successHandler");
         }
         if(param2 == BMSinglePlayerManager.ENEMY_TYPE_CLAN_BOSS)
         {
            remoteM.socketM.lobby_startedClanBossBattle();
            return;
         }
         remoteM.lobby_startedBattleVSComputer(param5);
      }
      
      private function startBattleVsComputer_phase2() : *
      {
         var _loc1_:Number = NaN;
         var _loc2_:Object = null;
         var _loc3_:BMPlayerProfile = null;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:BMWorldMapBossData = null;
         var _loc7_:BMWorldMapLocationData = null;
         var _loc8_:String = null;
         var _loc9_:BMPlayerProfile = null;
         var _loc10_:Object = null;
         var _loc11_:Number = NaN;
         var _loc12_:uint = 0;
         var _loc13_:Boolean = false;
         var _loc14_:Boolean = false;
         var _loc15_:Object = null;
         var _loc16_:Array = null;
         var _loc17_:BMPlayerItemData = null;
         var _loc18_:uint = 0;
         var _loc19_:Function = null;
         _loc1_ = Number(this.computerBattlePhase2Object.opponentPlayerID);
         _loc2_ = this.computerBattlePhase2Object.opponentPlayerDataObject;
         _loc3_ = this.myProfile;
         _loc4_ = Number(this.computerBattlePhase2Object.battlePosition);
         _loc5_ = this.computerBattlePhase2Object.bossID;
         _loc6_ = this.computerBattlePhase2Object.targetBossData;
         _loc7_ = this.computerBattlePhase2Object.targetMissionData;
         _loc8_ = this.computerBattlePhase2Object.battleSubType;
         this.computerBattlePhase2Object = null;
         if(this.gameSubType == GAME_SUB_TYPE_PVP_BOT)
         {
            _loc2_.playerName = NameGenerator.GenerateName();
         }
         this.createProfile(_loc1_,_loc2_.playerName,_loc2_.level);
         _loc9_ = this["player" + this.player2PlayerID + "Profile"];
         _loc9_.levelByItems = _loc2_.levelByItems;
         this["playerData" + _loc1_ + "Inventory"] = {};
         _loc10_ = this["playerData" + _loc1_ + "Inventory"];
         _loc13_ = false;
         switch(this.battleType)
         {
            case BMSinglePlayerManager.BATTLE_TYPE_REGULAR:
               switch(_loc3_.winsVSComputer)
               {
                  case 0:
                     _loc10_[1] = {
                        "playerItemID":1,
                        "itemID":BMCampaignMechsHelper.getTutorial_opponent1_torso(),
                        "equipped":1,
                        "type":BMMechStructure.TORSO,
                        "equipmentID":1,
                        "colorID":BMSinglePlayerManager.MISSION_COLOR_NORMAL
                     };
                     _loc10_[2] = {
                        "playerItemID":2,
                        "itemID":BMCampaignMechsHelper.getTutorial_opponent1_leg(),
                        "equipped":1,
                        "type":BMMechStructure.LEG,
                        "equipmentID":1,
                        "colorID":BMSinglePlayerManager.MISSION_COLOR_NORMAL
                     };
                     _loc10_[3] = {
                        "playerItemID":3,
                        "itemID":BMCampaignMechsHelper.getTutorial_opponent1_sideweapon(),
                        "equipped":1,
                        "type":BMMechStructure.SIDE_WEAPON,
                        "equipmentID":1,
                        "colorID":BMSinglePlayerManager.MISSION_COLOR_NORMAL
                     };
                     this["player" + _loc1_ + "playerItemIDCounter"] = 3;
                     break;
                  case 1:
                     _loc10_[1] = {
                        "playerItemID":1,
                        "itemID":BMCampaignMechsHelper.getTutorial_opponent2_torso(),
                        "equipped":1,
                        "type":BMMechStructure.TORSO,
                        "equipmentID":1,
                        "colorID":BMSinglePlayerManager.MISSION_COLOR_NORMAL
                     };
                     _loc10_[2] = {
                        "playerItemID":2,
                        "itemID":BMCampaignMechsHelper.getTutorial_opponent1_leg(),
                        "equipped":1,
                        "type":BMMechStructure.LEG,
                        "equipmentID":1,
                        "colorID":BMSinglePlayerManager.MISSION_COLOR_NORMAL
                     };
                     _loc10_[3] = {
                        "playerItemID":3,
                        "itemID":BMCampaignMechsHelper.getTutorial_opponent1_sideweapon(),
                        "equipped":1,
                        "type":BMMechStructure.SIDE_WEAPON,
                        "equipmentID":1,
                        "colorID":BMSinglePlayerManager.MISSION_COLOR_NORMAL
                     };
                     _loc10_[4] = {
                        "playerItemID":4,
                        "itemID":BMCampaignMechsHelper.getTutorial_opponent1_sideweapon(),
                        "equipped":1,
                        "type":BMMechStructure.SIDE_WEAPON,
                        "equipmentID":2,
                        "colorID":BMSinglePlayerManager.MISSION_COLOR_NORMAL
                     };
                     this["player" + _loc1_ + "playerItemIDCounter"] = 4;
                     break;
                  default:
                     _loc13_ = true;
               }
               break;
            case BMSinglePlayerManager.BATTLE_TYPE_MISSION:
            case BMSinglePlayerManager.BATTLE_TYPE_CLAN_BOSS:
            case BMSinglePlayerManager.BATTLE_TYPE_CLAN_WAR:
               _loc13_ = true;
         }
         if(_loc13_)
         {
            _loc14_ = false;
            if(BattleTypeResolver.isClanWar == false && this.raidData.isRaidInProgress() == false && _loc4_ > -1)
            {
               if(_loc3_.mission_computerItems[_loc4_] != null)
               {
                  _loc14_ = true;
               }
            }
            if(_loc14_)
            {
               this["playerData" + _loc1_ + "Inventory"] = {};
               this["player" + _loc1_ + "playerItemIDCounter"] = 1;
               _loc11_ = 0;
               while(_loc11_ < _loc3_.mission_computerItems[_loc4_].length)
               {
                  _loc15_ = _loc3_.mission_computerItems[_loc4_][_loc11_];
                  this.addInventoryItem(_loc1_,this["playerData" + _loc1_ + "Inventory"],_loc15_.itemID,_loc15_.equipped,_loc15_.equipmentType,_loc15_.equipmentID,_loc15_.colorID,_loc15_.power);
                  _loc11_++;
               }
            }
            else if(_loc8_ == BMSinglePlayerManager.ENEMY_TYPE_BOSS && this.computerMechStructures == null)
            {
               _loc7_ = this.singlePlayerM.currentMissionDB;
               _loc5_ = _loc7_.bossID;
               _loc6_ = this.singlePlayerM.getMissionBossData(_loc3_.currentStoryID,_loc7_.campaignID,_loc5_,_loc3_.currentMissionMode);
               this["playerData" + _loc1_ + "Inventory"] = {};
               this["player" + _loc1_ + "playerItemIDCounter"] = 1;
               _loc16_ = _loc6_.getPlayerItemsData();
               _loc11_ = 0;
               while(_loc11_ < _loc16_.length)
               {
                  _loc17_ = _loc16_[_loc11_];
                  _loc18_ = 1;
                  this.addInventoryItem(_loc1_,this["playerData" + _loc1_ + "Inventory"],_loc17_.itemID,_loc18_,_loc17_.equipmentType,_loc17_.equipmentID,_loc17_.colorID);
                  _loc11_++;
               }
            }
            else
            {
               _loc12_ = 1;
               while(_loc12_ <= this.battleMechsPerPlayer)
               {
                  this.createComputerOpponentInventoryLocally(_loc1_,_loc12_);
                  _loc12_++;
               }
            }
         }
         this.createPlayerData(_loc1_,"startBattleVSComputer");
         this.playersData[this.player1PlayerID].battlePlayerID = 1;
         this.playersData[this.player2PlayerID].battlePlayerID = 2;
         if(this.computerStartBattleSuccessHandler != null)
         {
            _loc19_ = this.computerStartBattleSuccessHandler;
            this.computerStartBattleSuccessHandler = null;
            _loc19_(true);
         }
      }
      
      public function handleResultForFinishBattleVSComputer(param1:Boolean, param2:Number, param3:Number, param4:Number, param5:Number, param6:Vector.<BMPlayerItemData>, param7:Object, param8:String, param9:Boolean = false, param10:uint = 0, param11:Array = null, param12:Object = null, param13:uint = 0, param14:uint = 0) : void
      {
         var _loc15_:BMLevelUpData = null;
         var _loc16_:uint = 0;
         if(isNaN(param10))
         {
            this.myProfile.lastLadderProgress = this.myProfile.ladderProgress;
            param10 = this.myProfile.ladderProgress;
         }
         if(param12 != null)
         {
            this.myProfile.updateClanData(param12);
            this.myProfile.clan_bossDamageDealtInLastBattle = param13;
         }
         if(this.gameType == GAME_TYPE_PVP && param9)
         {
            this.myProfile.lastLadderProgress = this.myProfile.ladderProgress;
            this.myProfile.ladderProgress = param10;
            screensM.screenBattle.surrenderSuccess();
            return;
         }
         if(BattleTypeResolver.isClanWar)
         {
            this.clanWarsM.userFinishedBattle(param14);
         }
         _loc15_ = BMLevelUpData.create(param7);
         screensM.screenBattle.finishBattleVSComputerSuccess(param2,param3,param4,param5,param6,param10,_loc15_);
         if(param11 != null)
         {
            this.myProfile.applyDurabilityChanges(param11);
         }
         if(param1 == false)
         {
            if(this.myProfile.wonLastBattleVSComputer && this.myProfile.level > 4 && this.myProfile.missionID > 0)
            {
               this.myProfile.abortCurrentMission = true;
            }
         }
         if(param8 != null)
         {
            _loc16_ = uint(int(param8));
            if(this.premiumAccountTime < _loc16_)
            {
               this.premiumAccountTime = _loc16_;
            }
         }
      }
      
      private function getMapTotalStepsAndPlayerPositions(param1:String, param2:String, param3:uint, param4:uint) : Array
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         switch(param4)
         {
            case 0:
               _loc5_ = 5;
               _loc6_ = 1;
               _loc7_ = 3;
               break;
            case 1:
               _loc5_ = 6;
               _loc6_ = 2;
               _loc7_ = 3;
               break;
            case 2:
               _loc5_ = 6;
               _loc6_ = 1;
               _loc7_ = 4;
               break;
            case 3:
            case 4:
               _loc5_ = 7;
               _loc6_ = 1;
               _loc7_ = 5;
               break;
            default:
               _loc9_ = true;
               switch(param1)
               {
                  case BMSinglePlayerManager.BATTLE_TYPE_CHALLENGE:
                     switch(param2)
                     {
                        case BMSinglePlayerManager.CHALLENGE_GODMODE:
                           _loc9_ = false;
                           _loc5_ = 10;
                           _loc6_ = 3;
                           _loc7_ = 6;
                     }
               }
               if(_loc9_)
               {
                  _loc10_ = this.raidData.isRaidInProgress();
                  if(param3 < 8)
                  {
                     _loc8_ = Math.ceil(Math.random() * 3);
                     if(_loc10_)
                     {
                        _loc8_ = 1 + this.singlePlayerM.getCurrentMissionPosition() % 3;
                     }
                     _loc5_ = 8;
                     switch(_loc8_)
                     {
                        case 1:
                           _loc6_ = 3;
                           _loc7_ = 4;
                           break;
                        case 2:
                           _loc6_ = 2;
                           _loc7_ = 5;
                           break;
                        case 3:
                           _loc6_ = 1;
                           _loc7_ = 6;
                     }
                  }
                  else
                  {
                     _loc8_ = Math.ceil(Math.random() * 4);
                     if(_loc10_)
                     {
                        _loc8_ = 1 + this.singlePlayerM.getCurrentMissionPosition() % 4;
                     }
                     _loc5_ = 10;
                     switch(_loc8_)
                     {
                        case 1:
                           _loc6_ = 4;
                           _loc7_ = 5;
                           break;
                        case 2:
                           _loc6_ = 3;
                           _loc7_ = 6;
                           break;
                        case 3:
                           _loc6_ = 2;
                           _loc7_ = 7;
                           break;
                        case 4:
                           _loc6_ = 1;
                           _loc7_ = 8;
                     }
                  }
               }
         }
         return [_loc5_,_loc6_,_loc7_];
      }
      
      public function getCampaignComputerHPRatio(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         _loc3_ = 100;
         if(param1 <= 5)
         {
            switch(param2)
            {
               case 1:
                  _loc3_ = 75;
                  break;
               case 2:
                  _loc3_ = 100;
                  break;
               case 3:
                  _loc3_ = 120;
            }
         }
         else if(param1 <= 10)
         {
            switch(param2)
            {
               case 1:
                  _loc3_ = 85;
                  break;
               case 2:
                  _loc3_ = 100;
                  break;
               case 3:
                  _loc3_ = 120;
            }
         }
         else if(param1 <= 15)
         {
            switch(param2)
            {
               case 1:
                  _loc3_ = 90;
                  break;
               case 2:
                  _loc3_ = 105;
                  break;
               case 3:
                  _loc3_ = 120;
            }
         }
         else if(param1 <= 20)
         {
            switch(param2)
            {
               case 1:
                  _loc3_ = 95;
                  break;
               case 2:
                  _loc3_ = 110;
                  break;
               case 3:
                  _loc3_ = 120;
            }
         }
         else if(param1 <= 25)
         {
            switch(param2)
            {
               case 1:
                  _loc3_ = 100;
                  break;
               case 2:
                  _loc3_ = 110;
                  break;
               case 3:
                  _loc3_ = 125;
            }
         }
         else
         {
            switch(param2)
            {
               case 1:
                  _loc3_ = 100;
                  break;
               case 2:
                  _loc3_ = 115;
                  break;
               case 3:
                  _loc3_ = 130;
            }
         }
         return _loc3_;
      }
      
      public function battle_afterBattleFunctions(param1:uint) : void
      {
         var _loc3_:String = null;
         var _loc4_:BMPlayerProfile = null;
         var _loc2_:BMPlayerProfile = this["player" + this.player1PlayerID + "Profile"];
         _loc3_ = "worldMap";
         switch(this.battleType)
         {
            case BMSinglePlayerManager.BATTLE_TYPE_MISSION:
               _loc3_ = "missionBaseMap";
               break;
            default:
               if(this.battleType == BMSinglePlayerManager.BATTLE_TYPE_CHALLENGE)
               {
                  _loc3_ = "worldMap";
               }
               else if(tutorialM.isTutorialActive())
               {
                  _loc3_ = "mainMenu";
               }
               else if(param1 == BMDataManager.GAME_TYPE_PVP)
               {
                  if(this.battle_goToChatAfterBattle || this.battle_inviteToClanAfterBattle)
                  {
                     _loc3_ = "chat";
                  }
                  else if(this.battle_inBattleInvitation)
                  {
                     _loc3_ = "chat";
                  }
                  else
                  {
                     _loc3_ = "ladder";
                  }
               }
               else if(param1 == BMDataManager.GAME_TYPE_CLAN_WAR)
               {
                  _loc3_ = "clanWarBase";
               }
         }
         if(_loc3_ != "missionBaseMap")
         {
            screensM.screenTransitionsManager.refreshTopBarAfterBattle = true;
         }
         switch(_loc3_)
         {
            case "clanWarBase":
               screensM.screenTransitionsManager.clanWarBaseClicked(BMClanWarsManager.ALIGNMENT_ENEMY_CLAN,this.clanWarsM.currentOpponentPlayerID,true);
               break;
            case "mainMenu":
               screensM.screenTransitionsManager.mainScreenSub();
               break;
            case "hanger":
               screensM.screenTransitionsManager.hangerMechClicked(true);
               soundM.resetMusicTrackParameters();
               break;
            case "ladder":
               screensM.screenTransitionsManager.multiplayerLadderClicked(true,false);
               soundM.resetMusicTrackParameters();
               break;
            case "chat":
               _loc4_ = this["player" + this.player2PlayerID + "Profile"];
               if(this.battle_goToChatAfterBattle)
               {
                  this.chatData.goToChatAfterBattle(_loc4_.userID,_loc4_.playerName,_loc4_.clanID,_loc4_.ladderProgress,_loc4_.level,_loc4_.geo);
               }
               else if(this.battle_inviteToClanAfterBattle)
               {
                  this.chatData.inviteToClanAfterBattle(_loc4_.userID,_loc4_.playerName,_loc4_.clanID,_loc4_.ladderProgress,_loc4_.level,_loc4_.geo);
               }
               screensM.screenTransitionsManager.multiplayerChatClicked(true,false);
               soundM.resetMusicTrackParameters();
               break;
            case "worldMap":
               screensM.screenTransitionsManager.singlePlayerClicked(true);
               soundM.resetMusicTrackParameters();
               break;
            case "missionBaseMap":
               if(this.useHiddenBaseMap == false)
               {
                  screensM.addScreen(BMScreensManager.SCR_MISSION_BASE_MAP);
                  if(this.chatData.useCampaignChat)
                  {
                     screensM.addScreen(BMScreensManager.SCR_TOP_BAR,true,BMScreenTopBarClone3);
                  }
                  else
                  {
                     screensM.addScreen(BMScreensManager.SCR_TOP_BAR);
                  }
                  screensM.screenMissionBaseMap.refreshScreen(true);
                  screensM.screenTopBar.refreshScreen(true);
               }
               if(this.canShowSuperSonicAdvertisement())
               {
                  this.showAdvertisement();
               }
         }
      }
      
      private function canShowSuperSonicAdvertisement() : Boolean
      {
         return this.supersonic_mobile_SPMP == 0 || this.supersonic_mobile_SPMP == 1;
      }
      
      public function setDelayedAdvertisement() : void
      {
         if(this.canShowSuperSonicAdvertisement())
         {
            this.waitingToShowAdvertisement = true;
         }
      }
      
      public function startPvPPickMechFlow(param1:String, param2:Array) : *
      {
         this.battle_battleID = param1;
         this.setGameTypeAndPlayers(BMDataManager.GAME_TYPE_PVP);
         this.battleType = BMSinglePlayerManager.BATTLE_TYPE_REGULAR;
         if(screensM.isScreenOpened(BMScreensManager.SCR_VS) == false)
         {
            this.battle_inBattleInvitation = true;
            screensM.addScreen(BMScreensManager.SCR_VS);
            screensM.screenVS.activateScreen();
            screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         }
         screensM.screenVS.startPickMechFlow(param2);
         this.battle_isCurrentBattlePvPWithPickMechs = true;
      }
      
      public function get1v1to2v2TransitionRank() : int
      {
         return this.getGeneralSetting("1v1to2v2transitionRank",0);
      }
      
      public function getTopRankBattlesMinimumRank() : int
      {
         return this.getGeneralSetting("minLadderRankForTopRankBattles",5);
      }
      
      public function getTopRankBattlesMechsPerPlayer() : int
      {
         return this.getGeneralSetting("topRankBattlesMechsPerPlayer",2);
      }
      
      public function notifyServerConfirmedPickMechSelection() : *
      {
         screensM.screenVS.notifyMechSelectionConfirmed();
      }
      
      public function pickMechs(param1:Array) : *
      {
         remoteM.battle_pickMechs(this.battle_battleID,param1);
      }
      
      public function getItemCurrentPowerLevel(param1:Number, param2:Number) : Number
      {
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:BMItemData = null;
         _loc3_ = this.getPlayerItemData(param1,param2);
         _loc4_ = this.itemsDB[_loc3_.itemID];
         return this.getItemPowerLevel(_loc4_);
      }
      
      public function getItemPowerLevel(param1:BMItemData) : *
      {
         return param1.displayLevel;
      }
      
      public function getItemNextPowerLevel(param1:Number, param2:Number) : Number
      {
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:BMItemData = null;
         var _loc5_:BMItemData = null;
         _loc3_ = this.getPlayerItemData(param1,param2);
         _loc4_ = this.itemsDB[_loc3_.itemID];
         _loc5_ = _loc4_[_loc4_.upgradeToItemID];
         if(_loc5_)
         {
            return this.getItemPowerLevel(_loc5_);
         }
         return this.getItemPowerLevel(_loc4_);
      }
      
      public function getItemPowerHPBonus(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:BMItemData = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         _loc3_ = 0;
         _loc4_ = this.getPlayerItemData(param1,param2);
         _loc5_ = this.itemsDB[_loc4_.itemID];
         _loc6_ = this.getItemPowerLevel(_loc5_);
         _loc7_ = this.getItemCurrentPowerLevel(param1,param2);
         return (_loc7_ - 1) * this.powerLevelsDB_regular[_loc6_].bonusHP;
      }
      
      public function getGeneralPowerHPBonus(param1:Number, param2:Number, param3:String = "regular") : Number
      {
         var _loc4_:Number = NaN;
         _loc4_ = 0;
         if(param3 == "regular")
         {
            _loc4_ = (param2 - 1) * this.powerLevelsDB_regular[param1].bonusHP;
         }
         else
         {
            _loc4_ = (param2 - 1) * this.powerLevelsDB_special[param1].bonusHP;
         }
         return _loc4_;
      }
      
      public function getGeneralPowerDamageBonus(param1:Number, param2:Number, param3:String = "regular") : Number
      {
         var _loc4_:Number = NaN;
         _loc4_ = 0;
         if(param3 == "regular")
         {
            _loc4_ = (param2 - 1) * this.powerLevelsDB_regular[param1].bonusDamage;
         }
         else
         {
            _loc4_ = (param2 - 1) * this.powerLevelsDB_special[param1].bonusDamage;
         }
         return _loc4_;
      }
      
      public function getGeneralPowerRepairBonus(param1:Number, param2:Number, param3:String = "regular") : Number
      {
         var _loc4_:Number = NaN;
         _loc4_ = 0;
         if(param3 == "regular")
         {
            _loc4_ = (param2 - 1) * this.powerLevelsDB_regular[param1].bonusRepair;
         }
         else
         {
            _loc4_ = (param2 - 1) * this.powerLevelsDB_special[param1].bonusRepair;
         }
         return _loc4_;
      }
      
      public function getItemPowerColorID(param1:Number, param2:Number) : Number
      {
         var _loc3_:BMPlayerItemData = null;
         _loc3_ = this.getPlayerItemData(param1,param2);
         return this.getItemIDPowerColorID(_loc3_.itemID);
      }
      
      public function getItemIDPowerColorID(param1:int) : *
      {
         var _loc2_:BMItemData = null;
         _loc2_ = this.itemsDB[param1];
         return this.getItemColorByLevel(_loc2_.specialStatus,_loc2_.displayLevel,_loc2_.type);
      }
      
      public function getItemColorByLevel(param1:uint, param2:Number, param3:String) : Number
      {
         if(param1 == ItemRarityResolver.RARITY_ASCENDED)
         {
            return 21;
         }
         if(param2 == 1)
         {
            return 0;
         }
         if(param2 < 6)
         {
            return 11;
         }
         if(param2 < 11)
         {
            return 12;
         }
         if(param2 < 16)
         {
            return 13;
         }
         if(param2 < 21)
         {
            return 14;
         }
         if(param2 < 26)
         {
            return 15;
         }
         if(param2 < 31)
         {
            return 16;
         }
         if(param2 < 36)
         {
            return 17;
         }
         if(param2 < 41)
         {
            return 18;
         }
         if(param2 < 46)
         {
            return 19;
         }
         if(param2 < 50)
         {
            return 20;
         }
         return 21;
      }
      
      public function recommendBoostMaterials() : Boolean
      {
         if(this.myProfile.level <= this.getGeneralSetting("recommendBoostMaterialsMaxLevel",0))
         {
            return true;
         }
         return false;
      }
      
      public function getRecommendedBoostMaterialPlayerItemIDs() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:uint = 0;
         var _loc3_:BMPlayerItemData = null;
         if(this.recommendBoostMaterials() == false)
         {
            return [];
         }
         _loc1_ = new Array();
         _loc2_ = 0;
         while(_loc2_ < this.myPlayerData.items.length)
         {
            _loc3_ = this.myPlayerData.items[_loc2_];
            if(_loc3_.equipped <= 0)
            {
               if(this.isPowerKit(_loc3_.itemID) != false)
               {
                  _loc1_.push(_loc3_.playerItemID);
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getMaxPlayerLevelToOnlyAllowBoostingEquippedItems() : uint
      {
         return this.getGeneralSetting("maxPlayerLevelToOnlyAllowBoostingEquippedItems",0);
      }
      
      public function getMassBoostMaterialPlayerItemIDs(param1:BMMassSelectionData) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:BMItemData = null;
         var _loc6_:String = null;
         _loc2_ = new Array();
         _loc3_ = 0;
         for(; _loc3_ < this.myPlayerData.items.length; _loc3_++)
         {
            _loc4_ = this.myPlayerData.items[_loc3_];
            if(_loc4_.equipped <= 0)
            {
               if(this.mechBuildsM.isEnabled)
               {
                  if(this.mechBuildsM.isItemInAnyBuild(_loc4_.playerItemID))
                  {
                     continue;
                  }
               }
               _loc5_ = this.getItemByPlayerItemID(_loc4_.playerItemID);
               if(!_loc5_.isTransformKit)
               {
                  if(param1.getRarity(_loc5_.specialStatus) != false)
                  {
                     _loc6_ = BMContentPackResolver.getPackTypeByItemType(_loc5_.type);
                     if(param1.getItemTypeByTypeName(_loc6_) != false)
                     {
                        if(!(_loc5_.isColorKit || _loc5_.isAscensionKit))
                        {
                           if(!_loc5_.isPowerKit)
                           {
                              if(!param1.areAllDamageTypesEnabled())
                              {
                                 if(param1.getDamageType(_loc5_.getItemElement()) == false)
                                 {
                                    continue;
                                 }
                              }
                           }
                           _loc2_.push(_loc4_.playerItemID);
                        }
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public function createInventoryTileListItem2(param1:Number, param2:Function, param3:Number, param4:Function = null, param5:Function = null, param6:Boolean = true, param7:Boolean = false, param8:Boolean = false, param9:uint = 0) : BMInventoryTileListItem
      {
         var _loc10_:BMInventoryTileListItem = null;
         var _loc11_:uint = 0;
         var _loc13_:BMPlayerItemData = null;
         var _loc14_:BMItemData = null;
         var _loc15_:String = null;
         var _loc16_:MovieClip = null;
         var _loc17_:Array = null;
         var _loc18_:String = null;
         var _loc19_:MovieClip = null;
         _loc10_ = new BMInventoryTileListItem();
         _loc11_ = 1;
         if(param7)
         {
            _loc11_ = 0;
         }
         _loc10_.graphics.beginFill(0,_loc11_);
         _loc10_.graphics.drawRect(0,0,param3,param3);
         _loc10_.tileListItemID = param1;
         var _loc12_:BMPlayerProfile = this["player" + this.player1PlayerID + "Profile"];
         _loc13_ = this.getPlayerItemData(this.player1PlayerID,param1);
         _loc14_ = this.itemsDB[_loc13_.itemID];
         if(param7 == false)
         {
            _loc18_ = "icon_tier" + _loc14_.specialStatus;
            _loc19_ = externalAssetsM.getAsset("general",_loc18_,param3 - 3,param3 - 3,false,false);
            _loc19_.x = 1.5;
            _loc19_.y = 1.5;
            _loc19_.mouseChildren = false;
            _loc19_.mouseEnabled = false;
            _loc10_.addChild(_loc19_);
            _loc10_.mcBg = _loc19_;
            _loc10_.isSelected = false;
         }
         _loc15_ = _loc14_.grp;
         _loc16_ = externalAssetsM.getAsset(this.itemTypeSourceDB[_loc14_.type],_loc15_,0,0,true,true);
         _loc17_ = new Array();
         _loc17_.push(_loc10_,param1,param2,param3,param4,param5,param6,param7,param8,param9);
         if(_loc16_.loading)
         {
            externalAssetsM.modifyExternalAssetDuplicationContainer(_loc16_,true,0,this.createInventoryTileListItem2Sub,_loc17_);
         }
         else
         {
            this.createInventoryTileListItem2Sub(_loc16_,_loc17_);
         }
         return _loc10_;
      }
      
      private function createInventoryTileListItem2Sub(param1:MovieClip, param2:Array) : void
      {
         var _loc3_:BMInventoryTileListItem = null;
         var _loc4_:Number = NaN;
         var _loc5_:Function = null;
         var _loc6_:Number = NaN;
         var _loc7_:Function = null;
         var _loc8_:Function = null;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:uint = 0;
         var _loc14_:BMPlayerItemData = null;
         var _loc15_:BMItemData = null;
         var _loc16_:BMItem = null;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:Number = NaN;
         var _loc21_:Boolean = false;
         var _loc22_:int = 0;
         var _loc23_:TextHolder = null;
         var _loc24_:MovieClip = null;
         var _loc25_:TextHolder = null;
         var _loc26_:MovieClip = null;
         var _loc27_:String = null;
         param1.x = 0;
         param1.y = 0;
         _loc3_ = param2[0];
         _loc4_ = Number(param2[1]);
         _loc5_ = param2[2];
         _loc6_ = Number(param2[3]);
         _loc7_ = param2[4];
         _loc8_ = param2[5];
         _loc9_ = Boolean(param2[6]);
         _loc10_ = Boolean(param2[7]);
         _loc11_ = Boolean(param2[8]);
         _loc12_ = uint(param2[9]);
         var _loc13_:BMPlayerProfile = this["player" + this.player1PlayerID + "Profile"];
         _loc14_ = this.getPlayerItemData(this.player1PlayerID,_loc4_);
         _loc15_ = this.itemsDB[_loc14_.itemID];
         _loc16_ = new BMItem();
         _loc17_ = 7;
         _loc18_ = 7;
         if(_loc15_.isColorKit)
         {
            _loc18_ = 0;
         }
         if(param1.mcIgnoreBlackBorder == null)
         {
            param1.filters = [new GlowFilter(0,1,2,2,5)];
         }
         _loc16_.initialize(_loc14_.playerItemID,_loc6_,_loc6_,param1,_loc17_,_loc18_,false,null,false);
         if(_loc10_ == false)
         {
            _loc16_.addBg(this.createItemBackgroundByDamageType(_loc15_));
         }
         if(_loc14_.colorID > 0)
         {
            _loc19_ = _loc14_.colorID;
         }
         else
         {
            _loc19_ = this.getItemPowerColorID(this.player1PlayerID,_loc14_.playerItemID);
         }
         this.colorItem(_loc16_,_loc19_);
         if(_loc9_ == false)
         {
            _loc3_.contentLoaded = false;
            _loc3_.contentData_justBought = false;
            _loc3_.contentData_removeHoldersMC = true;
            _loc3_.contentData_clicked = _loc5_;
            _loc3_.contentData_size = _loc6_;
            _loc3_.contentData_mouseDown = null;
            _loc3_.contentData_mouseUp = null;
            _loc3_.contentData_dataType = "playerItemID2";
            _loc3_.contentData_name = _loc15_.fullName;
            _loc3_.contentData_createFunction = this.createInventoryTileListItem2;
         }
         _loc3_.contentData_playerItemID = _loc4_;
         _loc3_.contentData_clicked = _loc5_;
         _loc20_ = _loc3_.tileID;
         _loc3_.initialize(_loc6_,_loc6_,_loc16_,"","","",5,_loc5_,_loc7_,_loc8_,null,null,false);
         if(_loc20_ > -1)
         {
            _loc3_.tileID = _loc20_;
         }
         if(_loc3_.mcBg != null)
         {
            _loc3_.mcBg.parent.removeChild(_loc3_.mcBg);
            _loc3_.addChild(_loc3_.mcBg);
         }
         if(_loc10_ == false)
         {
            _loc23_ = new listItemLevel();
            this.addToTileListItem(_loc3_,_loc23_,_loc6_);
            if(_loc12_ > 0)
            {
               if(_loc12_ > 99)
               {
                  _loc23_.text = "99+";
               }
               else
               {
                  _loc23_.text = "x" + _loc12_;
               }
            }
            else if(_loc15_.isMaxEvolved)
            {
               _loc23_.text = "";
               _loc23_.gotoAndStop(2);
            }
            else
            {
               _loc23_.text = _loc15_.displayLevel.toString();
            }
         }
         if(_loc15_.canEvolve())
         {
            _loc24_ = new listItemTransform();
            this.addToTileListItem(_loc3_,_loc24_,_loc6_);
            TweenMax.to(_loc24_,0.3,{
               "y":-2,
               "repeat":-1,
               "yoyo":true
            });
         }
         _loc21_ = false;
         if(_loc11_ && this.mechBuildsM.isEnabled)
         {
            _loc21_ = this.mechBuildsM.isItemInAnyBuild(_loc14_.playerItemID);
         }
         if(_loc14_.equipped >= 1 || _loc21_)
         {
            _loc25_ = new icon_itemEquipped2();
            this.addToTileListItem(_loc3_,_loc25_,_loc6_);
            if(_loc14_.equipped >= 1)
            {
               _loc25_.text = _loc14_.equipped.toString();
               _loc25_.mcIcon.visible = false;
            }
            else
            {
               _loc25_.text = "";
               _loc25_.mcIcon.visible = true;
            }
         }
         _loc22_ = this.myProfile.newItemsPurchased.indexOf(_loc4_);
         if(_loc22_ != -1)
         {
            if(this.languageID == BMLanguageManager.LANGUAGE_ENGLISH)
            {
               _loc26_ = new listItemNew();
            }
            else
            {
               _loc26_ = new listItemNewTranslated();
               _loc27_ = languageM.getText("general_newCaps");
               updateTextAndFormat(_loc26_.txtNew,_loc27_);
               screensM.createMultipleTextsBitmap(_loc26_.name + "_new",[_loc26_.txtNew],"",_loc26_);
            }
            this.addToTileListItem(_loc3_,_loc26_,_loc6_);
            this.myProfile.newItemsPurchased.splice(_loc22_,1);
         }
      }
      
      private function addToTileListItem(param1:BMInventoryTileListItem, param2:MovieClip, param3:*) : void
      {
         param2.width = param2.height = param3;
         param2.mouseChildren = false;
         param2.mouseEnabled = false;
         param1.addChild(param2);
      }
      
      private function addDamageTypeAndRange(param1:BMItem, param2:BMItemData) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         _loc3_ = new listItemDamageTypeAndRange();
         _loc4_ = "";
         if(param2.type == BMMechStructure.SIDE_WEAPON || param2.type == BMMechStructure.TOP_WEAPON)
         {
            if(param2.rangeBase == 0)
            {
               _loc4_ = "1";
            }
            else if(param2.rangeBase <= 2)
            {
               _loc4_ = "2";
            }
            else
            {
               _loc4_ = "3";
            }
         }
         _loc5_ = param2.getItemElement();
         switch(_loc5_)
         {
            case BMItemData.ELEMENT_PHYSICAL:
               _loc3_.gotoAndStop(2);
               break;
            case BMItemData.ELEMENT_HEAT:
               _loc3_.gotoAndStop(3);
               break;
            case BMItemData.ELEMENT_ENERGY:
               _loc3_.gotoAndStop(4);
         }
         _loc4_ = param2.displayLevel.toString();
         _loc3_.txtRange.text = _loc4_;
         param1.addOverItemGrp1(_loc3_);
      }
      
      private function createItemBackgroundByDamageType(param1:BMItemData) : MovieClip
      {
         var _loc2_:MovieClip = null;
         _loc2_ = new listItemDamageType();
         if(param1.isDeprecated != 0)
         {
            return _loc2_;
         }
         if(param1.damageType > 0)
         {
            _loc2_.gotoAndStop(param1.damageType + 1);
            return _loc2_;
         }
         if(param1.type == BMMechStructure.MODULE)
         {
            if(!(param1.resist1 > 0 && param1.resist2 > 0 && param1.resist3 > 0))
            {
               if(param1.HPBase > 0 || param1.resist1 > 0)
               {
                  _loc2_.gotoAndStop(2);
               }
               else if(param1.heatBase > 0 || param1.heatAddon > 0 || param1.resist2 > 0)
               {
                  _loc2_.gotoAndStop(3);
               }
               else if(param1.energyBase > 0 || param1.energyAddon > 0 || param1.resist3 > 0)
               {
                  _loc2_.gotoAndStop(4);
               }
            }
         }
         if(param1.type == BMMechStructure.TORSO)
         {
            if(param1.energyBase == param1.heatBase)
            {
               _loc2_.gotoAndStop(2);
            }
            else if(param1.energyBase < param1.heatBase)
            {
               _loc2_.gotoAndStop(3);
            }
            else
            {
               _loc2_.gotoAndStop(4);
            }
         }
         return _loc2_;
      }
      
      public function createEmptyInvntoryTileList2(param1:Number, param2:int = 0, param3:Number = 0.5) : BMTileListItem
      {
         var _loc4_:BMTileListItem = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Color = null;
         _loc4_ = new BMTileListItem();
         _loc4_.mouseChildren = false;
         _loc4_.mouseEnabled = false;
         _loc4_.initialize(param1,param1,new BMItem(),"","","",5,null,null,null,null,null,false);
         _loc5_ = externalAssetsM.getAsset("general","icon_tier_empty" + param2,param1 - 3,param1 - 3,false,false);
         _loc5_.x = 1.5;
         _loc5_.y = 1.5;
         _loc6_ = new Color();
         _loc6_.setTint(0,param3);
         _loc5_.transform.colorTransform = _loc6_;
         _loc4_.addChildAt(_loc5_,0);
         return _loc4_;
      }
      
      public function createUnoccupiedTile(param1:Number) : BMTileListItem
      {
         return this.createEmptyInvntoryTileList2(param1,0,0);
      }
      
      public function createInventorySizeTile(param1:Number) : BMTileListItem
      {
         var _loc2_:TextHolder = null;
         var _loc3_:BMItem = null;
         var _loc4_:BMTileListItem = null;
         _loc2_ = new BMWorkshopInventorySizeTile();
         if(this.isInventoryFull(false))
         {
            _loc2_.textField.textColor = 16711680;
         }
         _loc2_.text = this.getNumOfInventoryItemsForInventorySize() + "/" + this.myProfile.inventorySizeState.maxSize;
         _loc3_ = new BMItem();
         _loc3_.initialize(-1,param1,param1,_loc2_,0,0,false,null,false);
         _loc4_ = this.createEmptyInvntoryTileList2(param1,0,0);
         _loc4_.initialize(param1,param1,_loc3_,"","","",5,this.onInventorySizeTileClick,null,null,null,null,false);
         if(tutorialM.isTutorialActive())
         {
            _loc4_.mouseChildren = false;
            _loc4_.mouseEnabled = false;
         }
         else
         {
            _loc4_.mouseChildren = true;
            _loc4_.mouseEnabled = true;
         }
         return _loc4_;
      }
      
      private function isItemCountsForInventoryLimitFilter(param1:BMPlayerItemData, param2:int, param3:Array) : Boolean
      {
         return this.getGeneralSetting("ignoreKitsForInventoryLimit",1) == 0 || this.itemsDB[param1.itemID].type != "kit";
      }
      
      public function getNumOfInventoryItemsForInventorySize() : uint
      {
         return this.myPlayerData.items.filter(this.isItemCountsForInventoryLimitFilter).length;
      }
      
      public function isInventoryFull(param1:Boolean, param2:uint = 0) : Boolean
      {
         if(param1)
         {
            if(this.myProfile.inventorySizeState.isInGracePeriod())
            {
               return false;
            }
         }
         return this.getNumOfInventoryItemsForInventorySize() >= this.myProfile.inventorySizeState.maxSize + param2;
      }
      
      public function isAboveInventoryLimit() : Boolean
      {
         return this.getNumOfInventoryItemsForInventorySize() > this.myProfile.inventorySizeState.maxSize;
      }
      
      public function onInventorySizeTileClick(param1:Number, param2:Number) : void
      {
         if(tutorialM.isTutorialActive())
         {
            return;
         }
         if(this.isInventoryFull(false))
         {
            screensM.addScreen(BMScreensManager.SCR_INVENTORY_FULL);
         }
         else
         {
            screensM.addScreen(BMScreensManager.SCR_INVENTORY_EXPAND);
         }
      }
      
      public function inventoryBuyExpansion() : *
      {
         if(this.myProfile.tokens < this.myProfile.inventorySizeState.expansionTokensCost)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("notEnoughTokens_noValue");
            return;
         }
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         remoteM.socketM.inventory_buyExpansion();
      }
      
      public function createInventoryTileListItem(param1:Number, param2:Boolean, param3:Function, param4:Function, param5:Function, param6:Function, param7:Function, param8:Boolean) : BMTileListItem
      {
         var _loc9_:BMPlayerProfile = null;
         var _loc10_:BMPlayerItemData = null;
         var _loc11_:BMItemData = null;
         var _loc12_:BMItem = null;
         var _loc13_:Number = NaN;
         var _loc14_:BMTileListItem = null;
         var _loc15_:Function = null;
         var _loc16_:Function = null;
         var _loc17_:Function = null;
         var _loc18_:Function = null;
         var _loc19_:Function = null;
         var _loc20_:String = null;
         var _loc21_:String = null;
         var _loc22_:String = null;
         var _loc23_:Number = NaN;
         var _loc24_:MovieClip = null;
         var _loc25_:MovieClip = null;
         _loc9_ = this["player" + this.player1PlayerID + "Profile"];
         _loc10_ = this.getPlayerItemData(this.player1PlayerID,param1);
         _loc11_ = this.itemsDB[_loc10_.itemID];
         _loc12_ = this.createItem_basedOnPlayerItemID(this.player1PlayerID,param1,"inventory",param8);
         _loc13_ = this.INVENTORY_TILE_LIST_ITEM_SIZE;
         if(this.runAsMobile)
         {
            _loc13_ = this.INVENTORY_TILE_LIST_ITEM_SIZE_MOBILE;
         }
         _loc14_ = new BMTileListItem();
         _loc15_ = param3;
         _loc16_ = param4;
         _loc17_ = param5;
         _loc18_ = param6;
         _loc19_ = param7;
         if(this.runAsMobile)
         {
            _loc15_ = null;
            _loc16_ = null;
            _loc17_ = null;
            _loc18_ = null;
            _loc19_ = null;
         }
         _loc14_.contentData_playerItemID = param1;
         if(param8 == false)
         {
            _loc14_.contentLoaded = false;
            _loc14_.contentData_justBought = param2;
            _loc14_.contentData_removeHoldersMC = true;
            _loc14_.contentData_clicked = _loc15_;
            _loc14_.contentData_mouseDown = _loc16_;
            _loc14_.contentData_mouseUp = _loc17_;
            _loc14_.contentData_mouseOver = _loc18_;
            _loc14_.contentData_mouseOut = _loc19_;
            _loc14_.contentData_dataType = "playerItemID";
            _loc14_.contentData_name = this.itemsDB[_loc10_.itemID].fullName;
            _loc14_.contentData_createFunction = this.createInventoryTileListItem;
         }
         if(_loc10_.equipped >= 1)
         {
            _loc24_ = externalAssetsM.getAsset("general","icon_itemEquipped",_loc13_,_loc13_,false,false);
            if(_loc9_.level >= this.SECOND_MECH_UNLOCK_LEVEL && this.inventoryMaxMechs > 1)
            {
               _loc24_.gotoAndStop("mech" + _loc10_.equipped);
            }
            _loc12_.addOverItemGrp1(_loc24_);
         }
         else if(param2)
         {
            _loc25_ = externalAssetsM.getAsset("general","icon_itemNew",_loc13_,_loc13_,false,false);
            _loc12_.addOverItemGrp1(_loc25_);
         }
         if(_loc10_.colorID > 0)
         {
            this.colorItem(_loc12_,_loc10_.colorID);
         }
         else
         {
            this.colorItem(_loc12_,this.getItemPowerColorID(this.player1PlayerID,param1));
         }
         _loc20_ = "";
         _loc21_ = "";
         _loc22_ = this.COLOR_LIGHT_GRAY;
         switch(_loc11_.specialStatus)
         {
            case 1:
               _loc22_ = ItemRarityResolver.COLOR_RARE_ITEM;
               break;
            case 2:
               _loc22_ = ItemRarityResolver.COLOR_EPIC_ITEM;
               break;
            case 3:
               _loc22_ = ItemRarityResolver.COLOR_LEGENDARY_ITEM;
               break;
            case 4:
               _loc20_ = ItemRarityResolver.COLOR_MYTHICAL_ITEM_DARK;
               _loc22_ = ItemRarityResolver.COLOR_MYTHICAL_ITEM;
               break;
            case 5:
               _loc20_ = ItemRarityResolver.COLOR_MYTHICAL_ITEM_DARK;
               _loc22_ = ItemRarityResolver.COLOR_PERK;
         }
         switch(_loc11_.type)
         {
            case BMMechStructure.DRONE:
            case BMMechStructure.SHIELD:
            case BMMechStructure.TELEPORT:
            case BMMechStructure.CHARGE:
            case BMMechStructure.HARPOON:
               if(_loc9_.level < this.equipmentUnlockDB[_loc11_.type].level)
               {
                  _loc20_ = "";
                  _loc21_ = this.COLOR_DARK_RED_DARK;
                  _loc22_ = this.COLOR_DARK_RED;
               }
         }
         _loc23_ = 5;
         _loc14_.initialize(_loc13_,_loc13_,_loc12_,_loc20_,_loc21_,_loc22_,_loc23_,_loc15_,_loc16_,_loc17_,_loc18_,_loc19_,this.runAsMobile);
         return _loc14_;
      }
      
      public function createItem_basedOnPlayerItemID(param1:Number, param2:Number, param3:String, param4:Boolean) : BMItem
      {
         var _loc5_:BMPlayerData = null;
         var _loc6_:uint = 0;
         var _loc7_:BMMechStructure = null;
         var _loc8_:BMPlayerItemData = null;
         var _loc9_:BMItem = null;
         var _loc10_:BMItemData = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:MovieClip = null;
         var _loc16_:Boolean = false;
         var _loc17_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc19_:Boolean = false;
         var _loc20_:MovieClip = null;
         var _loc21_:uint = 0;
         var _loc22_:GlowFilter = null;
         var _loc23_:BMPlayerProfile = null;
         var _loc24_:String = null;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:MovieClip = null;
         var _loc30_:MovieClip = null;
         var _loc31_:MovieClip = null;
         _loc5_ = this.playersData[param1];
         _loc6_ = 1;
         _loc7_ = _loc5_.mechStructures[_loc6_];
         _loc8_ = this.getPlayerItemData(param1,param2);
         _loc9_ = new BMItem();
         if(this.itemsDB[_loc8_.itemID] == null)
         {
            this.traceError("itemID " + _loc8_.itemID + " doesn\'t exist");
         }
         _loc10_ = this.itemsDB[_loc8_.itemID];
         _loc13_ = this.getIconFrameSize(param3,_loc10_.type);
         _loc14_ = 0;
         _loc15_ = null;
         _loc16_ = false;
         _loc17_ = false;
         _loc18_ = false;
         _loc19_ = false;
         switch(_loc10_.type)
         {
            case BMMechStructure.ENHANCER:
            case BMMechStructure.MODULE:
            case BMMechStructure.KIT:
            case BMMechStructure.SHIELD:
            case BMMechStructure.TELEPORT:
            case BMMechStructure.CHARGE:
            case BMMechStructure.HARPOON:
               _loc18_ = true;
         }
         switch(param3)
         {
            case "inventory":
               _loc11_ = this.INVENTORY_TILE_LIST_ITEM_SIZE;
               _loc12_ = this.INVENTORY_TILE_LIST_ITEM_SIZE;
               if(this.runAsMobile)
               {
                  _loc11_ = this.INVENTORY_TILE_LIST_ITEM_SIZE_MOBILE;
                  _loc12_ = this.INVENTORY_TILE_LIST_ITEM_SIZE_MOBILE;
               }
               _loc14_ = 5;
               switch(_loc10_.type)
               {
                  case BMMechStructure.TORSO:
                  case BMMechStructure.LEG:
                  case BMMechStructure.SIDE_WEAPON:
                  case BMMechStructure.TOP_WEAPON:
                  case BMMechStructure.DRONE:
                  case BMMechStructure.TELEPORT:
                  case BMMechStructure.CHARGE:
                  case BMMechStructure.HARPOON:
                     _loc17_ = true;
               }
               if(_loc8_.durability > 0)
               {
                  _loc19_ = true;
               }
               break;
            case "drag":
               _loc11_ = this.DRAG_TILE_LIST_ITEM_SIZE;
               _loc12_ = this.DRAG_TILE_LIST_ITEM_SIZE;
               _loc16_ = true;
               break;
            case "equipment":
               _loc23_ = this["player" + this.player1PlayerID + "Profile"];
               _loc11_ = this.EQUIPMENT_TILE_LIST_ITEM_SIZE;
               _loc12_ = this.EQUIPMENT_TILE_LIST_ITEM_SIZE;
               _loc24_ = "occupiedItem";
               switch(_loc10_.type)
               {
                  case BMMechStructure.SIDE_WEAPON:
                  case BMMechStructure.TOP_WEAPON:
                     if(_loc10_.bullets > _loc7_.totalBullets || _loc10_.rockets > _loc7_.totalRockets)
                     {
                        _loc24_ = "occupiedItemRed";
                     }
               }
               _loc15_ = externalAssetsM.getAsset("general",_loc24_);
               switch(_loc10_.type)
               {
                  case BMMechStructure.ENHANCER:
                  case BMMechStructure.MODULE:
                  case BMMechStructure.KIT:
                  case BMMechStructure.SHIELD:
                  case BMMechStructure.TELEPORT:
                  case BMMechStructure.CHARGE:
                  case BMMechStructure.HARPOON:
                     _loc14_ = 6;
               }
               switch(_loc10_.type)
               {
                  case BMMechStructure.TORSO:
                  case BMMechStructure.LEG:
                  case BMMechStructure.SIDE_WEAPON:
                  case BMMechStructure.TOP_WEAPON:
                  case BMMechStructure.DRONE:
                  case BMMechStructure.TELEPORT:
                  case BMMechStructure.CHARGE:
                  case BMMechStructure.HARPOON:
                     _loc17_ = true;
               }
               if(_loc8_.durability > 0)
               {
                  _loc19_ = true;
               }
         }
         _loc20_ = new MovieClip();
         if(_loc8_.colorID > 0)
         {
            _loc21_ = _loc8_.colorID;
         }
         else
         {
            _loc21_ = this.getItemPowerColorID(param1,_loc8_.playerItemID);
         }
         _loc22_ = null;
         if(param4)
         {
            _loc20_ = externalAssetsM.getAsset(this.itemTypeSourceDB[_loc10_.type],_loc10_.grp,0,0,true,true);
            if(_loc18_)
            {
               if(_loc20_.loading)
               {
                  _loc22_ = new GlowFilter(0,1,4,4,7);
               }
               else
               {
                  _loc20_.filters = [new GlowFilter(0,1,4,4,7)];
               }
            }
         }
         else
         {
            _loc20_.graphics.beginFill(49778,1);
            _loc20_.graphics.drawRect(0,0,50,50);
         }
         switch(_loc10_.type)
         {
            case BMMechStructure.TORSO:
               if(_loc20_.mcShutdown != null)
               {
                  _loc20_.mcShutdown.visible = false;
               }
         }
         if(_loc20_.loading)
         {
            externalAssetsM.modifyExternalAssetDuplicationContainer(_loc20_,false,_loc14_,this.itemGrpLoaded,[_loc9_,_loc21_,_loc22_]);
         }
         _loc9_.initialize(_loc8_.playerItemID,_loc11_,_loc12_,_loc20_,_loc13_,_loc14_,_loc16_,_loc15_,this.runAsMobile);
         if(_loc17_)
         {
            _loc25_ = this.getItemCurrentPowerLevel(param1,param2);
            if(_loc25_ > 1)
            {
               _loc26_ = 100;
               _loc27_ = 25;
               _loc28_ = 5;
               _loc29_ = new MovieClip();
               _loc29_.graphics.beginFill(0,0);
               _loc29_.graphics.drawRect(0,0,_loc26_,_loc26_);
               _loc30_ = externalAssetsM.getAsset("general","Grp_rank" + _loc25_,_loc27_,_loc27_,false,false);
               _loc30_.x = _loc26_ - _loc27_ - _loc28_;
               _loc30_.y = _loc26_ - _loc27_ - _loc28_;
               _loc29_.addChild(_loc30_);
               _loc29_.filters = [new GlowFilter(0,1,4,4,7)];
               _loc9_.addOverItemGrp1(_loc29_);
            }
         }
         if(_loc19_)
         {
            _loc31_ = externalAssetsM.getAsset("general","icon_itemDurability",_loc11_,_loc12_,false,false);
            _loc9_.addOverItemGrp2(_loc31_);
         }
         this.colorItem(_loc9_,_loc21_);
         return _loc9_;
      }
      
      private function itemGrpLoaded(param1:MovieClip, param2:Array) : void
      {
         var _loc3_:BMItem = null;
         var _loc4_:uint = 0;
         var _loc5_:GlowFilter = null;
         _loc3_ = param2[0];
         if(_loc3_ == null)
         {
            return;
         }
         _loc4_ = uint(param2[1]);
         _loc5_ = param2[2];
         _loc3_.itemGrp = param1;
         if(_loc5_ != null)
         {
            _loc3_.itemGrp.filters = [_loc5_];
         }
         this.colorItem(_loc3_,_loc4_);
      }
      
      public function createItemFragmentTileListItem(param1:Number, param2:Number, param3:Function = null, param4:Boolean = false) : BMInventoryTileListItem
      {
         var _loc5_:uint = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:Function = null;
         var _loc9_:Function = null;
         _loc5_ = 0;
         _loc6_ = false;
         _loc7_ = true;
         _loc8_ = null;
         _loc9_ = null;
         return this.createItemTileListItem(param1,param2,_loc5_,_loc6_,param3,_loc8_,_loc9_,param4,_loc7_);
      }
      
      public function createItemTileListItem(param1:Number, param2:Number, param3:uint = 0, param4:Boolean = false, param5:Function = null, param6:Function = null, param7:Function = null, param8:Boolean = false, param9:Boolean = false) : BMInventoryTileListItem
      {
         var _loc10_:BMItemData = null;
         var _loc11_:BMItem = null;
         var _loc12_:MovieClip = null;
         var _loc13_:MovieClip = null;
         var _loc14_:BMInventoryTileListItem = null;
         var _loc15_:Boolean = false;
         var _loc16_:String = null;
         var _loc17_:MovieClip = null;
         var _loc18_:uint = 0;
         var _loc19_:uint = 0;
         var _loc20_:String = null;
         var _loc21_:MovieClip = null;
         _loc10_ = this.itemsDB[param1];
         _loc11_ = new BMItem();
         _loc12_ = externalAssetsM.getAsset(this.itemTypeSourceDB[_loc10_.type],_loc10_.grp,0,0,true,true);
         if(param4)
         {
            _loc18_ = 0;
            _loc19_ = 0;
            _loc20_ = ItemRarityResolver.getItemTierColor(_loc10_.specialStatus);
            if(_loc20_ != "")
            {
               _loc19_ = uint("0x" + _loc20_);
            }
            _loc13_ = _loc21_ = BMItemShadowImage.createItemShadowImage(_loc12_,param2,true,_loc18_,_loc19_,false,this.runAsMobile);
         }
         else
         {
            if(_loc12_.mcIgnoreBlackBorder == null)
            {
               _loc12_.filters = [new GlowFilter(0,1,2,2,5)];
            }
            _loc13_ = _loc12_;
         }
         _loc11_.initialize(param1,param2,param2,_loc13_,7,7,false,null,this.runAsMobile);
         _loc11_.addBg(this.createItemBackgroundByDamageType(_loc10_));
         if(param3 > 0)
         {
            this.colorItem(_loc11_,param3);
         }
         _loc14_ = new BMInventoryTileListItem();
         _loc14_.contentData_itemID = param1;
         _loc14_.contentData_clicked = param5;
         _loc15_ = this.runAsMobile;
         if(param8)
         {
            _loc15_ = false;
         }
         _loc14_.initialize(param2,param2,_loc11_,"","","",5,param5,param6,param7,null,null,_loc15_);
         _loc16_ = "icon_tier" + _loc10_.specialStatus;
         if(param9)
         {
            _loc16_ += "_forFragment";
         }
         else
         {
            _loc16_ += "_forLibrary";
         }
         _loc17_ = externalAssetsM.getAsset("general",_loc16_,param2 - 3,param2 - 3,false,false);
         _loc17_.x = 1.5;
         _loc17_.y = 1.5;
         _loc17_.mouseChildren = false;
         _loc17_.mouseEnabled = false;
         _loc14_.addChild(_loc17_);
         _loc14_.mcBg = _loc17_;
         _loc14_.isSelected = false;
         return _loc14_;
      }
      
      public function createShopTileListItem_basedOnItemID(param1:Number, param2:String, param3:Function = null, param4:Function = null, param5:Function = null, param6:Function = null, param7:Function = null, param8:Boolean = true) : BMTileListItem
      {
         var _loc9_:BMItem = null;
         var _loc10_:BMTileListItem = null;
         var _loc11_:BMPlayerData = null;
         var _loc12_:BMPlayerProfile = null;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:Number = NaN;
         var _loc18_:String = null;
         var _loc19_:Boolean = false;
         var _loc20_:BMItemData = null;
         var _loc21_:Boolean = false;
         var _loc22_:Function = null;
         var _loc23_:Function = null;
         var _loc24_:Function = null;
         var _loc25_:Function = null;
         var _loc26_:Function = null;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Boolean = false;
         var _loc31_:Boolean = false;
         var _loc32_:MovieClip = null;
         var _loc33_:Number = NaN;
         var _loc34_:TextField = null;
         var _loc35_:BitmapData = null;
         var _loc36_:Bitmap = null;
         var _loc37_:String = null;
         _loc9_ = this.createItem_basedOnItemID(param1,param2,param8);
         _loc10_ = new BMTileListItem();
         _loc11_ = this.playersData[this.player1PlayerID];
         _loc12_ = this["player" + this.player1PlayerID + "Profile"];
         var _loc13_:String = "";
         _loc14_ = "";
         _loc15_ = "";
         _loc16_ = "";
         _loc17_ = 0;
         _loc18_ = "";
         _loc19_ = false;
         if(_loc11_.existingItemsIDs[param1] != null)
         {
            _loc19_ = true;
         }
         _loc19_ = false;
         _loc20_ = this.itemsDB[param1];
         switch(_loc20_.specialStatus)
         {
            case 0:
               _loc16_ = this.COLOR_LIGHT_GRAY;
               break;
            case 1:
               _loc16_ = ItemRarityResolver.COLOR_RARE_ITEM;
               break;
            case 2:
               _loc16_ = ItemRarityResolver.COLOR_EPIC_ITEM;
               break;
            case 3:
               _loc16_ = ItemRarityResolver.COLOR_LEGENDARY_ITEM;
               switch(param2)
               {
                  case "shop":
                  case "shopCombined":
                  case "news":
                     _loc18_ = "icon_itemBox";
               }
               break;
            case 4:
               switch(param2)
               {
                  case "shop":
                  case "shopCombined":
                  case "news":
                  case "mechGenerator":
                     if(this.showMythicalsStats)
                     {
                        if(_loc19_)
                        {
                           _loc16_ = ItemRarityResolver.COLOR_MYTHICAL_ITEM;
                        }
                        else
                        {
                           _loc16_ = ItemRarityResolver.COLOR_MYTHICAL_ITEM_DARK;
                        }
                     }
                     else if(_loc19_)
                     {
                        _loc16_ = ItemRarityResolver.COLOR_MYTHICAL_ITEM;
                     }
                     else
                     {
                        _loc14_ = this.COLOR_DARK_GRAY;
                        _loc17_ = 1;
                     }
                     break;
                  case "reward":
                  case "contentPackItem":
                  case "contentPackItemLocked":
                     _loc16_ = ItemRarityResolver.COLOR_MYTHICAL_ITEM;
               }
               break;
            case 5:
               _loc16_ = ItemRarityResolver.COLOR_PERK;
         }
         switch(param2)
         {
            case "starterPack":
               switch(_loc20_.specialStatus)
               {
                  case 0:
                     _loc14_ = this.COLOR_DARK_GRAY;
                     break;
                  case 1:
                     _loc14_ = "001F42";
                     break;
                  case 2:
                     _loc14_ = "300C30";
                     break;
                  case 3:
                     _loc14_ = "382100";
                     break;
                  case 4:
                     _loc14_ = ItemRarityResolver.COLOR_MYTHICAL_ITEM_DARK;
                     _loc16_ = ItemRarityResolver.COLOR_MYTHICAL_ITEM;
               }
         }
         _loc21_ = true;
         switch(param2)
         {
            case "shop":
            case "shopCombined":
               if(_loc20_.specialStatus <= 3)
               {
                  if(_loc19_)
                  {
                     _loc16_ = this.COLOR_GREEN;
                  }
                  if(_loc20_.level > _loc12_.level && _loc20_.subType != "power")
                  {
                     _loc17_ = 0.7;
                     _loc16_ = this.COLOR_DARK_GRAY;
                     _loc21_ = false;
                  }
               }
               break;
            case "contentPackItemLocked":
               _loc17_ = 0.7;
               _loc16_ = this.COLOR_DARK_GRAY;
               _loc21_ = false;
               break;
            case "news":
            case "mechGenerator":
               if(_loc20_.specialStatus <= 3)
               {
                  if(_loc19_)
                  {
                     _loc16_ = this.COLOR_GREEN;
                  }
               }
               break;
            case "packageItem":
               _loc16_ = "";
         }
         if(param8 && _loc21_)
         {
            switch(param2)
            {
               case "shop":
               case "shopCombined":
               case "news":
                  if(_loc20_.specialStatus < 3)
                  {
                     _loc30_ = false;
                     _loc31_ = false;
                     if(_loc20_.costTokens == 0)
                     {
                        if(_loc20_.costGold > _loc12_.gold)
                        {
                           _loc30_ = true;
                        }
                     }
                     if(_loc20_.costTokens > _loc12_.tokens)
                     {
                        _loc31_ = true;
                     }
                     if(_loc30_)
                     {
                        if(!_loc31_)
                        {
                           _loc18_ = "icon_notEnoughGold";
                        }
                     }
                     else if(_loc20_.costTokens)
                     {
                        if(_loc20_.costTokensDefault > _loc20_.costTokens)
                        {
                           _loc18_ = "icon_costTokensAndDiscount";
                        }
                        else
                        {
                           _loc18_ = "icon_costTokens";
                        }
                     }
                  }
            }
         }
         _loc22_ = param3;
         _loc23_ = param4;
         _loc24_ = param5;
         _loc25_ = param6;
         _loc26_ = param7;
         if(this.runAsMobile)
         {
            _loc22_ = null;
            _loc23_ = null;
            _loc24_ = null;
            _loc25_ = null;
            _loc26_ = null;
         }
         if(param8 == false)
         {
            _loc10_.contentLoaded = false;
            _loc10_.contentData_itemID = param1;
            _loc10_.contentData_tileListType = param2;
            _loc10_.contentData_removeHoldersMC = true;
            _loc10_.contentData_removeColorMC = true;
            _loc10_.contentData_clicked = _loc22_;
            _loc10_.contentData_mouseDown = _loc23_;
            _loc10_.contentData_mouseUp = _loc24_;
            _loc10_.contentData_mouseOver = _loc25_;
            _loc10_.contentData_mouseOut = _loc26_;
            _loc10_.contentData_dataType = "itemID";
            _loc10_.contentData_name = this.itemsDB[param1].fullName;
            _loc10_.contentData_createFunction = this.createShopTileListItem_basedOnItemID;
         }
         _loc27_ = this.SHOP_REGULAR_TILE_LIST_ITEM_SIZE;
         _loc28_ = this.SHOP_REGULAR_TILE_LIST_ITEM_SIZE;
         switch(param2)
         {
            case "starterPack":
               _loc27_ = this.STARTER_PACK_SIZE;
               _loc28_ = this.STARTER_PACK_SIZE;
               break;
            case "news":
               _loc27_ = this.NEWS_TILE_LIST_ITEM_SIZE;
               _loc28_ = this.NEWS_TILE_LIST_ITEM_SIZE;
               break;
            case "mechGenerator":
               _loc27_ = this.MECH_GENERATOR_TILE_LIST_ITEM_SIZE;
               _loc28_ = this.MECH_GENERATOR_TILE_LIST_ITEM_SIZE;
               break;
            case "reward":
            case "contentPackItem":
            case "contentPackItemLocked":
               if(this.runAsMobile)
               {
                  _loc27_ = this.REWARD_TILE_LIST_ITEM_SIZE;
                  _loc28_ = this.REWARD_TILE_LIST_ITEM_SIZE;
               }
               else
               {
                  _loc27_ = this.REWARD_TILE_LIST_ITEM_SIZE_MOBILE;
                  _loc28_ = this.REWARD_TILE_LIST_ITEM_SIZE_MOBILE;
               }
               break;
            case "shopCombined":
               if(this.runAsMobile)
               {
                  _loc27_ = this.SHOP_COMBINED_TILE_LIST_ITEM_SIZE_MOBILE;
                  _loc28_ = this.SHOP_COMBINED_TILE_LIST_ITEM_SIZE_MOBILE;
               }
               else
               {
                  _loc27_ = this.SHOP_COMBINED_TILE_LIST_ITEM_SIZE;
                  _loc28_ = this.SHOP_COMBINED_TILE_LIST_ITEM_SIZE;
               }
               break;
            default:
               if(this.runAsMobile)
               {
                  _loc27_ = this.SHOP_REGULAR_TILE_LIST_ITEM_SIZE_MOBILE;
                  _loc28_ = this.SHOP_REGULAR_TILE_LIST_ITEM_SIZE_MOBILE;
               }
         }
         _loc29_ = 5;
         _loc10_.initialize(_loc27_,_loc28_,_loc9_,_loc14_,_loc15_,_loc16_,_loc29_,_loc22_,_loc23_,_loc24_,_loc25_,_loc26_,this.runAsMobile);
         if(_loc18_ != "")
         {
            _loc32_ = externalAssetsM.getAsset("general",_loc18_,_loc27_,_loc28_,false,false);
            if(_loc18_ == "icon_costTokensAndDiscount")
            {
               _loc33_ = Math.floor((_loc20_.costTokensDefault - _loc20_.costTokens) / _loc20_.costTokensDefault * 100);
               _loc34_ = new TextField();
               _loc34_.defaultTextFormat = this.shopItemDiscountTextFormat;
               _loc34_.text = "-" + _loc33_ + "%";
               _loc34_.width = _loc34_.textWidth + 5;
               _loc34_.height = _loc34_.textHeight;
               _loc34_.filters = [new GlowFilter(0,1,4,4,7)];
               if(this.runAsMobile)
               {
                  _loc35_ = new BitmapData(_loc34_.width,_loc34_.height,true,0);
                  _loc36_ = new Bitmap(_loc35_);
                  _loc35_.draw(_loc34_);
                  _loc36_.x = 4;
                  _loc36_.y = _loc28_ - 31;
                  _loc32_.addChild(_loc36_);
                  _loc34_ = null;
               }
               else
               {
                  _loc34_.x = 4;
                  _loc34_.y = _loc28_ - 27;
                  _loc32_.addChild(_loc34_);
               }
            }
            _loc9_.addOverItemGrp1(_loc32_);
         }
         if(param8)
         {
            if(_loc19_)
            {
               _loc37_ = "icon_itemBought";
               if(_loc18_ != "")
               {
                  _loc37_ = "icon_itemBought2";
               }
               _loc9_.addOverItemGrp2(externalAssetsM.getAsset("general",_loc37_,_loc27_,_loc28_,false,false));
            }
         }
         if(_loc17_ > 0)
         {
            _loc10_.setItemTint(_loc17_);
         }
         return _loc10_;
      }
      
      private function createItem_basedOnItemID(param1:Number, param2:String, param3:Boolean) : BMItem
      {
         var _loc4_:BMItem = null;
         var _loc5_:BMItemData = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Boolean = false;
         var _loc11_:String = null;
         var _loc12_:MovieClip = null;
         _loc4_ = new BMItem();
         _loc5_ = this.itemsDB[param1];
         _loc8_ = this.getIconFrameSize(param2,_loc5_.type);
         _loc9_ = 0;
         _loc10_ = false;
         switch(param2)
         {
            case "shop":
            case "shopCombined":
            case "packageItem":
               _loc6_ = this.SHOP_REGULAR_TILE_LIST_ITEM_SIZE;
               _loc7_ = this.SHOP_REGULAR_TILE_LIST_ITEM_SIZE;
               if(this.runAsMobile)
               {
                  _loc6_ = this.SHOP_REGULAR_TILE_LIST_ITEM_SIZE_MOBILE;
                  _loc7_ = this.SHOP_REGULAR_TILE_LIST_ITEM_SIZE_MOBILE;
               }
               _loc9_ = 5;
               break;
            case "reward":
            case "contentPackItem":
            case "contentPackItemLocked":
               if(this.runAsMobile)
               {
                  _loc6_ = this.REWARD_TILE_LIST_ITEM_SIZE;
                  _loc7_ = this.REWARD_TILE_LIST_ITEM_SIZE;
                  _loc9_ = 3;
               }
               else
               {
                  _loc6_ = this.REWARD_TILE_LIST_ITEM_SIZE_MOBILE;
                  _loc7_ = this.REWARD_TILE_LIST_ITEM_SIZE_MOBILE;
               }
               break;
            case "starterPack":
               _loc6_ = this.STARTER_PACK_SIZE;
               _loc7_ = this.STARTER_PACK_SIZE;
               if(this.runAsMobile)
               {
                  _loc6_ = this.STARTER_PACK_SIZE;
                  _loc7_ = this.STARTER_PACK_SIZE;
               }
               _loc9_ = 5;
               break;
            case "drag":
               _loc6_ = this.DRAG_TILE_LIST_ITEM_SIZE;
               _loc7_ = this.DRAG_TILE_LIST_ITEM_SIZE;
               _loc10_ = true;
               break;
            case "news":
               _loc6_ = this.NEWS_TILE_LIST_ITEM_SIZE;
               _loc7_ = this.NEWS_TILE_LIST_ITEM_SIZE;
               _loc9_ = 2;
               break;
            case "mechGenerator":
               _loc6_ = this.MECH_GENERATOR_TILE_LIST_ITEM_SIZE;
               _loc7_ = this.MECH_GENERATOR_TILE_LIST_ITEM_SIZE;
               _loc9_ = 2;
         }
         _loc11_ = _loc5_.grp;
         if(_loc11_ == "")
         {
            _loc11_ = "missingItemPicture";
         }
         _loc12_ = new MovieClip();
         if(param3)
         {
            _loc12_ = externalAssetsM.getAsset(this.itemTypeSourceDB[_loc5_.type],_loc11_,0,0,true,true);
            _loc12_.filters = [new GlowFilter(0,1,4,4,7)];
         }
         else
         {
            _loc12_.graphics.beginFill(49778,1);
            _loc12_.graphics.drawRect(0,0,50,50);
         }
         switch(_loc5_.type)
         {
            case BMMechStructure.TORSO:
               if(_loc12_.mcShutdown != null)
               {
                  _loc12_.mcShutdown.visible = false;
               }
         }
         _loc4_.initialize(param1,_loc6_,_loc7_,_loc12_,_loc8_,_loc9_,_loc10_,null,this.runAsMobile);
         return _loc4_;
      }
      
      private function getIconFrameSize(param1:String, param2:String) : Number
      {
         var _loc3_:Number = NaN;
         _loc3_ = 0;
         switch(param1)
         {
            case "inventory":
            case "shop":
            case "shopCombined":
               switch(param2)
               {
                  case BMMechStructure.KIT:
                  case BMMechStructure.MODULE:
                  case BMMechStructure.ENHANCER:
                  case BMMechStructure.SHIELD:
                  case BMMechStructure.TELEPORT:
                  case BMMechStructure.CHARGE:
                  case BMMechStructure.HARPOON:
                     _loc3_ = 4;
                     break;
                  default:
                     _loc3_ = 5;
               }
               break;
            case "equipment":
            case "drag":
         }
         return _loc3_;
      }
      
      public function equipSpecificItem(param1:uint, param2:uint) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:BMItemData = null;
         var _loc6_:String = null;
         var _loc7_:BMMechStructure = null;
         var _loc8_:uint = 0;
         var _loc9_:BMPlayerItemData = null;
         _loc3_ = 1;
         _loc4_ = this.getPlayerItemData(this.player1PlayerID,param1);
         _loc5_ = this.itemsDB[_loc4_.itemID];
         _loc6_ = BMMechStructure.getEquipmentSlotByTypeAndID(_loc5_.type,param2);
         _loc7_ = this.myPlayerData.mechStructures[_loc3_];
         _loc8_ = uint(_loc7_[_loc6_]);
         if(_loc8_ > 0)
         {
            _loc9_ = this.getPlayerItemData(this.player1PlayerID,_loc8_);
            _loc9_.resetEquippedData();
         }
         _loc4_.equipped = _loc3_;
         _loc4_.setSlotName(_loc6_);
         this.updateMechStructure(this.player1PlayerID,_loc3_);
         this.myPlayerData.updateMechsWeight();
         remoteM.inventory_updateMechs(true,[],this.createPlayerItemsArr(),false,_loc3_);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         this.mechEquipmentRecommander.checkRecommendationForNextItem();
      }
      
      public function createPlayerItemsArr() : Array
      {
         var _loc1_:BMPlayerData = null;
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:Number = NaN;
         var _loc6_:String = null;
         _loc1_ = this.playersData[this.player1PlayerID];
         _loc2_ = new Array();
         _loc3_ = 0;
         while(_loc3_ < _loc1_.items.length)
         {
            _loc4_ = _loc1_.items[_loc3_];
            _loc5_ = _loc4_.equipped;
            if(_loc5_ >= 1)
            {
               _loc6_ = _loc4_.equipmentID == 0 ? _loc4_.equipmentType : _loc4_.equipmentType + _loc4_.equipmentID;
               _loc2_.push({
                  "slotName":_loc6_,
                  "equipped":_loc5_,
                  "playerItemID":_loc4_.playerItemID
               });
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function createMechIcon(param1:Number, param2:uint, param3:BMMechStructure, param4:BMMechViewManualColors, param5:Number, param6:Number, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean) : BMItem
      {
         var _loc11_:BMMechStructure = null;
         var _loc12_:BMItem = null;
         var _loc13_:Sprite = null;
         var _loc14_:BMMechView = null;
         var _loc15_:MovieClip = null;
         var _loc16_:String = null;
         var _loc17_:MovieClip = null;
         var _loc18_:BMPlayerData = null;
         if(param1 > 0)
         {
            _loc18_ = this.playersData[param1];
            _loc11_ = _loc18_.mechStructures[param2];
         }
         else
         {
            _loc11_ = param3;
         }
         _loc12_ = new BMItem();
         _loc13_ = externalAssetsM.getAsset("general","icon_mechBackground");
         _loc13_.width *= 2;
         _loc13_.height *= 2;
         _loc14_ = new BMMechView();
         _loc15_ = new MovieClip();
         _loc16_ = BMMechStructure.ITEM_TYPE_PLAYER_ITEM_ID;
         if(param1 <= 0)
         {
            _loc16_ = BMMechStructure.ITEM_TYPE_ITEM_ID;
         }
         _loc14_.initialize(param1,"hanger",_loc16_,1,false);
         if(param4 != null)
         {
            _loc14_.setManualColors(param4);
         }
         _loc14_.centerMech = true;
         _loc14_.buildMech(_loc11_,this.createMechIconSub,[_loc14_,_loc13_,_loc15_,param7]);
         _loc15_.addChild(_loc13_);
         _loc15_.addChild(_loc14_);
         if(param8)
         {
            _loc13_.alpha = 0;
         }
         if(param9 == false)
         {
            _loc17_ = externalAssetsM.getAsset("general","icon_mechBackground");
         }
         _loc12_.initialize(0,param5,param5,_loc15_,0,param6,false,_loc17_,this.runAsMobile);
         if(param10)
         {
            _loc12_.scaleX = -1;
            _loc12_.x += _loc12_.width;
         }
         return _loc12_;
      }
      
      private function createMechIconSub(param1:Array) : void
      {
         var _loc2_:BMMechView = null;
         var _loc3_:Sprite = null;
         var _loc4_:MovieClip = null;
         var _loc5_:Boolean = false;
         _loc2_ = param1[0];
         _loc3_ = param1[1];
         _loc4_ = param1[2];
         _loc5_ = Boolean(param1[3]);
         this.resizeMechViewBySizer(_loc2_,_loc3_);
         if(_loc5_)
         {
            _loc4_.x -= _loc4_.width / 2;
            _loc4_.y -= _loc4_.height / 2;
         }
      }
      
      public function resizeMechViewBySizer(param1:BMMechView, param2:Sprite) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         _loc3_ = param1.width / param2.width;
         _loc4_ = param1.height / param2.height;
         _loc5_ = 1 / _loc3_;
         if(_loc3_ < _loc4_)
         {
            _loc5_ = 1 / _loc4_;
         }
         param1.width *= _loc5_;
         param1.height *= _loc5_;
         param1.x = param1.width / 2;
         param1.y = param1.height / 2;
         if(param1.width < param2.width)
         {
            param1.x += (param2.width - param1.width) / 2;
         }
         if(param1.height < param2.height)
         {
            param1.y += (param2.height - param1.height) / 2;
         }
      }
      
      public function getColoringType(param1:Number) : String
      {
         var _loc2_:String = null;
         _loc2_ = "colorID";
         switch(param1)
         {
            case this.LOCAL_PLAYER_ID:
            case this.ONLINE_PLAYER_ID:
               _loc2_ = "power";
               break;
            case this.ONLINE_OPPONENT_ID:
            case this.INSPECT_PLAYER_ID:
               switch(this.gameType)
               {
                  case BMDataManager.GAME_TYPE_PVP:
                  case BMDataManager.GAME_TYPE_REPLAY:
                  case BMDataManager.GAME_TYPE_CLAN_WAR:
                     _loc2_ = "power";
               }
         }
         return _loc2_;
      }
      
      public function colorItemGrp(param1:MovieClip, param2:Number, param3:Boolean = false) : void
      {
         var _loc4_:String = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Sprite = null;
         var _loc7_:BitmapData = null;
         var _loc8_:Sprite = null;
         var _loc9_:ColorTransform = null;
         var _loc10_:Number = NaN;
         var _loc11_:BitmapData = null;
         var _loc12_:Bitmap = null;
         var _loc13_:uint = 0;
         var _loc14_:BitmapData = null;
         if(param2 <= 0)
         {
            return;
         }
         if(param1.mcColor != null)
         {
            _loc4_ = GlobalAccess.stage.quality;
            if(param3)
            {
               GlobalAccess.stage.quality = StageQuality.MEDIUM;
            }
            else
            {
               GlobalAccess.stage.quality = "low";
            }
            _loc5_ = param1.mcColor;
            if(param2 >= PATTERN_COLORS_FIRST_ID)
            {
               _loc6_ = externalAssetsM.getAsset("general","ColorPattern" + param2);
               _loc7_ = new BitmapData(_loc6_.width,_loc6_.height,true);
               _loc7_.draw(_loc6_);
               _loc8_ = new Sprite();
               _loc8_.graphics.beginBitmapFill(_loc7_);
               _loc8_.graphics.drawRect(0,0,param1.width / param1.scaleX,param1.height / param1.scaleY);
               param1.camoHolder = new MovieClip();
               _loc5_.parent.removeChild(_loc5_);
               param1.camoHolder.addChild(_loc5_);
               param1.camoHolder.addChild(_loc8_);
               _loc8_.mask = _loc5_;
               param1.camoHolder.blendMode = BlendMode.OVERLAY;
               param1.addChild(param1.camoHolder);
            }
            else
            {
               _loc9_ = new ColorTransform();
               _loc9_.color = this.colorsDB[param2];
               _loc5_.transform.colorTransform = _loc9_;
               _loc5_.blendMode = BlendMode.OVERLAY;
            }
            if(this.runAsMobile == false && param1.itemBM != null)
            {
               _loc10_ = 5;
               _loc11_ = new BitmapData(param1.itemBM.width + _loc10_ * 2,param1.itemBM.height + _loc10_ * 2,true,0);
               _loc12_ = new Bitmap(_loc11_);
               _loc12_.smoothing = true;
               param1.itemBM.x += _loc10_;
               param1.itemBM.y += _loc10_;
               if(param1.mcColor != null)
               {
                  param1.mcColor.x += _loc10_;
                  param1.mcColor.y += _loc10_;
               }
               if(param1.mcBarrel != null)
               {
                  param1.mcBarrel.x += _loc10_;
                  param1.mcBarrel.y += _loc10_;
               }
               if(param1.mcGlow != null)
               {
                  param1.mcGlow.x += _loc10_;
                  param1.mcGlow.y += _loc10_;
               }
               if(param1.mcLight != null)
               {
                  param1.mcLight.x += _loc10_;
                  param1.mcLight.y += _loc10_;
               }
               if(param1.mcHandle != null)
               {
                  param1.mcHandle.x += _loc10_;
                  param1.mcHandle.y += _loc10_;
               }
               _loc12_.x -= _loc10_;
               _loc12_.y -= _loc10_;
               _loc11_.draw(param1);
               param1.addChild(_loc12_);
               if(param1.mcBarrel != null)
               {
                  param1.mcBarrel.parent.removeChild(param1.mcBarrel);
                  param1.addChild(param1.mcBarrel);
                  param1.mcBarrel.x -= _loc10_;
                  param1.mcBarrel.y -= _loc10_;
               }
               if(param1.mcGlow != null)
               {
                  param1.mcGlow.parent.removeChild(param1.mcGlow);
                  param1.addChild(param1.mcGlow);
                  param1.mcGlow.x -= _loc10_;
                  param1.mcGlow.y -= _loc10_;
               }
               if(param1.mcLight != null)
               {
                  param1.mcLight.parent.removeChild(param1.mcLight);
                  param1.addChild(param1.mcLight);
                  param1.mcLight.x -= _loc10_;
                  param1.mcLight.y -= _loc10_;
               }
               if(param1.mcHandle != null)
               {
                  param1.mcHandle.parent.removeChild(param1.mcHandle);
                  param1.addChild(param1.mcHandle);
                  param1.mcHandle.x -= _loc10_;
                  param1.mcHandle.y -= _loc10_;
               }
               if(param1.itemBM.parent != null)
               {
                  param1.itemBM.parent.removeChild(param1.itemBM);
                  param1.itemBMD.dispose();
               }
               param1.itemBM = _loc12_;
               param1.itemBMD = _loc11_;
               if(param1.mcColor != null)
               {
                  if(param1.mcColor.parent != null)
                  {
                     param1.mcColor.parent.removeChild(param1.mcColor);
                  }
               }
               if(param1.camoHolder != null)
               {
                  if(param1.camoHolder.parent != null)
                  {
                     param1.camoHolder.parent.removeChild(param1.camoHolder);
                  }
               }
               if(param1.mcShutdown != null)
               {
                  if(param1.mcShutdown.parent != null)
                  {
                     param1.mcShutdown.parent.removeChild(param1.mcShutdown);
                  }
                  param1.addChild(param1.mcShutdown);
               }
            }
            if(this.runAsMobile)
            {
               _loc13_ = 12;
               param1.x += _loc13_;
               param1.y += _loc13_;
               _loc14_ = new BitmapData(param1.width + _loc13_ * 2,param1.height + _loc13_ * 2,true,0);
               _loc14_.draw(param1);
               param1.gpuImage = new Bitmap(_loc14_,"auto",true);
               param1.addChild(param1.gpuImage);
               param1["cacheAsBitmapMatrix"] = new Matrix();
               param1.cacheAsBitmap = true;
               GlobalAccess.stage.quality = _loc4_;
               if(param1.mcShutdown != null)
               {
                  if(param1.mcShutdown.parent != null)
                  {
                     param1.mcShutdown.parent.removeChild(param1.mcShutdown);
                  }
                  param1.addChild(param1.mcShutdown);
               }
               if(param1.mcBarrel != null)
               {
                  if(param1.mcBarrel.parent != null)
                  {
                     param1.mcBarrel.parent.removeChild(param1.mcBarrel);
                  }
                  param1.addChild(param1.mcBarrel);
               }
               if(param1.mcGlow != null)
               {
                  if(param1.mcGlow.parent != null)
                  {
                     param1.mcGlow.parent.removeChild(param1.mcGlow);
                  }
                  param1.addChild(param1.mcGlow);
               }
               if(param1.mcLight != null)
               {
                  if(param1.mcLight.parent != null)
                  {
                     param1.mcLight.parent.removeChild(param1.mcLight);
                  }
                  param1.addChild(param1.mcLight);
               }
               if(param1.mcHandle != null)
               {
                  if(param1.mcHandle.parent != null)
                  {
                     param1.mcHandle.parent.removeChild(param1.mcHandle);
                  }
                  param1.addChild(param1.mcHandle);
               }
               if(param1.camoHolder != null)
               {
                  if(param1.camoHolder.parent != null)
                  {
                     param1.camoHolder.parent.removeChild(param1.camoHolder);
                  }
               }
               param1.x -= _loc13_;
               param1.y -= _loc13_;
            }
         }
      }
      
      public function colorItem(param1:BMItem, param2:Number, param3:Boolean = false) : void
      {
         this.colorItemGrp(param1.itemGrp,param2,param3);
      }
      
      public function colorMovieClip(param1:MovieClip, param2:Number) : void
      {
         var _loc3_:String = null;
         var _loc4_:ColorTransform = null;
         if(param2 > 0)
         {
            _loc3_ = GlobalAccess.stage.quality;
            if(this.runAsMobile)
            {
               GlobalAccess.stage.quality = "low";
            }
            _loc4_ = new ColorTransform();
            _loc4_.color = this.colorsDB[param2];
            param1.transform.colorTransform = _loc4_;
            param1.blendMode = BlendMode.OVERLAY;
            GlobalAccess.stage.quality = _loc3_;
         }
      }
      
      public function getClientInvertedDirection(param1:String) : String
      {
         var _loc2_:String = null;
         _loc2_ = param1;
         if(this.battle_clientInverted)
         {
            if(_loc2_ == "left")
            {
               _loc2_ = "right";
            }
            else
            {
               _loc2_ = "left";
            }
         }
         return _loc2_;
      }
      
      public function getClientInvertedStep(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         _loc2_ = param1;
         if(this.battle_clientInverted)
         {
            _loc2_ = this.battleData.map.stepsTotal - 1 - param1;
         }
         return _loc2_;
      }
      
      public function mechMissingPartsForBattle(param1:BMMechStructure) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         _loc2_ = new Array();
         if(param1.torso == 0)
         {
            _loc2_.push(BMMechStructure.TORSO);
         }
         if(param1.leg == 0)
         {
            _loc2_.push(BMMechStructure.LEG);
         }
         _loc3_ = true;
         _loc4_ = 1;
         while(_loc4_ <= this.maxEquipment[BMMechStructure.SIDE_WEAPON])
         {
            if(_loc3_ == true)
            {
               _loc3_ = this.mechMissingPartsForBattleSub(param1[BMMechStructure.SIDE_WEAPON + _loc4_]);
            }
            _loc4_++;
         }
         _loc4_ = 1;
         while(_loc4_ <= this.maxEquipment[BMMechStructure.TOP_WEAPON])
         {
            if(_loc3_ == true)
            {
               _loc3_ = this.mechMissingPartsForBattleSub(param1[BMMechStructure.TOP_WEAPON + _loc4_]);
            }
            _loc4_++;
         }
         if(_loc3_)
         {
            _loc2_.push("weapon");
         }
         return _loc2_;
      }
      
      private function mechMissingPartsForBattleSub(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         _loc2_ = true;
         if(param1 > 0)
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      public function getResistance(param1:Number, param2:Number, param3:Boolean) : Number
      {
         var _loc4_:Number = NaN;
         var _loc5_:BMPlayerData = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc4_ = 0;
         _loc5_ = this.playersData[param1];
         _loc6_ = _loc5_.selectedMechID;
         _loc4_ += this.getResistanceSub(param1,_loc6_,BMMechStructure.TORSO,param2);
         _loc4_ = _loc4_ + this.getResistanceSub(param1,_loc6_,BMMechStructure.LEG,param2);
         _loc7_ = 1;
         while(_loc7_ <= this.maxEquipment[BMMechStructure.MODULE])
         {
            _loc4_ += this.getResistanceSub(param1,_loc6_,BMMechStructure.MODULE + _loc7_,param2);
            _loc7_++;
         }
         return _loc4_;
      }
      
      private function getResistanceSub(param1:Number, param2:uint, param3:String, param4:Number) : Number
      {
         var _loc5_:BMPlayerData = null;
         var _loc6_:BMMechStructure = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:BMPlayerItemData = null;
         var _loc10_:BMItemData = null;
         _loc5_ = this.playersData[param1];
         _loc6_ = _loc5_.mechStructures[param2];
         _loc7_ = Number(_loc6_[param3]);
         _loc8_ = 0;
         if(_loc7_ > 0)
         {
            _loc9_ = this.getPlayerItemData(param1,_loc7_);
            _loc10_ = this.itemsDB[_loc9_.itemID];
            _loc8_ = Number(_loc10_["resist" + param4]);
         }
         return _loc8_;
      }
      
      public function missionCompletedSuccess(param1:uint, param2:Array, param3:Object, param4:BMLevelUpData = null, param5:Boolean = false) : void
      {
         var _loc6_:BMRewardData = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         if(this.raidData.isRaidInProgress() == false)
         {
            this.singlePlayerM.finishMissionForFirstTime = this.myProfile.getCurrentMissionProgress(param1) == BMSinglePlayerManager.MAP_PROGRESS_IN_PROGRESS;
            this.myProfile.updateCurrentMissionProgress(param1,BMSinglePlayerManager.MAP_PROGRESS_COMPLETE);
         }
         if(param2 != null)
         {
            _loc6_ = this.convertLootDataToRewardData(param2);
         }
         else
         {
            _loc6_ = new BMRewardData(param3);
         }
         _loc6_.levelUpData = param4;
         _loc7_ = BMGameOfWhalesManager.SOURCE_MISSION_WIN;
         _loc8_ = BMGameOfWhalesManager.PLACE_CAMPAIGN;
         this.gameOfWhalesM.resourceAcquired(BMGameOfWhalesManager.RESOURCE_GOLD,_loc6_.gold,_loc7_,_loc8_);
         this.gameOfWhalesM.resourceAcquired(BMGameOfWhalesManager.RESOURCE_XP,_loc6_.xp,_loc7_,_loc8_);
         this.gameOfWhalesM.resourceAcquired(BMGameOfWhalesManager.RESOURCE_TOKENS,_loc6_.tokens,_loc7_,_loc8_);
         this.myProfile.mission_gold = 0;
         this.myProfile.mission_xp = 0;
         this.myProfile.lastXPGained = _loc6_.xp;
         this.myProfile.XP += _loc6_.xp;
         this.myProfile.lastGoldGained = _loc6_.gold;
         this.myProfile.gold += _loc6_.gold;
         this.myProfile.tokens += _loc6_.tokens;
         this.myProfile.tokens_bonus += _loc6_.tokens;
         _loc9_ = 0;
         _loc10_ = 0;
         if(param5)
         {
            screensM.addScreen(BMScreensManager.SCR_BATTLE_RESULT,true,BMScreenBattleResultNextMission);
         }
         else
         {
            screensM.addScreen(BMScreensManager.SCR_BATTLE_RESULT);
         }
         screensM.screenBattleResult.setPrizes(_loc6_.gold,_loc6_.xp,_loc9_,_loc10_,_loc6_);
         screensM.screenBattleResult.refreshScreen();
         if(this.myProfile.tutorialLevel == BMTutorialManager.TUTORIAL_LEVEL_MISSION1)
         {
            tutorialM.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_MISSION1 + 1,"screenMissionBaseMap exitScreenSub");
         }
         else if(this.myProfile.tutorialLevel == BMTutorialManager.TUTORIAL_LEVEL_MISSION2)
         {
            tutorialM.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_MISSION2 + 1,"screenMissionBaseMap exitScreenSub");
         }
         else
         {
            this.saveGuestData("missionBaseMap exitScreenSub");
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_TOP_BAR))
         {
            screensM.screenTopBar.refreshScreen(true);
         }
         if(this.useHiddenBaseMap)
         {
            screensM.screenBattle.hiddenBaseMissionCompleted();
         }
      }
      
      private function convertLootDataToRewardData(param1:Array) : BMRewardData
      {
         var _loc2_:BMRewardData = null;
         var _loc3_:int = 0;
         _loc2_ = new BMRewardData();
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            switch(param1[_loc3_].type)
            {
               case "tokens":
                  _loc2_.tokens += param1[_loc3_].amount;
                  break;
               case "itemBox":
                  _loc2_.parseItems(param1[_loc3_].items);
                  break;
               case "freeBox":
                  _loc2_.boxes.push(param1[_loc3_].boostID);
                  break;
               case "gold":
                  _loc2_.gold += param1[_loc3_].amount;
                  break;
               case "xp":
                  _loc2_.xp += param1[_loc3_].amount;
                  break;
               case "clanBossTickets":
                  _loc2_.clanBossTickets += param1[_loc3_].amount;
                  break;
               case "boxFragments":
                  _loc2_.boxFragments = BMBoxFragmentsManager.parseFragmentAmountObject(param1[_loc3_].boxFragments);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function openBuyTokensPage(param1:String, param2:Number = NaN) : void
      {
         this.trackEvent(ANALYTICS_PRIORITY_HIGHEST,"MonetizationFunnel","OpenShop",param1,param2);
         BMShopManager.gi().showTokens();
      }
      
      public function get needToRegisterToBuyRealMoney() : *
      {
         if(loginM.isConnected == false)
         {
            return true;
         }
         if(false && this.installationData.lastLoginService == LoginServices.GENERATED_USER)
         {
            return true;
         }
         return false;
      }
      
      public function openBuyTokensPage_payPalAndDao() : void
      {
         this.openURL(BMDomainResolver.getHttpDomain() + "/packages/","_blank");
         this.showWaitForTokenPurchaseDialog();
      }
      
      public function openBuyTokensPage_fortumo() : void
      {
         this.openURL("http://pay.fortumo.com/mobile_payments/34b58cd1d222cad65f605f416ecee2a0?cuid=" + this.userID + "&service_id=34b58cd1d222cad65f605f416ecee2a0","_blank");
         this.showWaitForTokenPurchaseDialog();
      }
      
      public function openBuyTokensPage_dao() : void
      {
         var _loc1_:String = null;
         _loc1_ = BMDomainResolver.getHttpDomain() + "/services/tokenSystem/dp.php?package=1";
         this.openURL(_loc1_,"_blank");
         this.showWaitForTokenPurchaseDialog();
      }
      
      private function get useEXOrderFunctions() : Boolean
      {
         return this.getGeneralSetting("paypalPurchaseEX",0) == 1;
      }
      
      public function openBuyTokensPage_paypal(param1:uint) : void
      {
         var _loc2_:String = null;
         _loc2_ = BMDomainResolver.getHttpDomain() + "/services/tokenSystem/pp.php?package=" + param1;
         if(this.useEXOrderFunctions)
         {
            _loc2_ = BMDomainResolver.getHttpDomain() + "/services/tokenSystem/ppex.php?package=" + param1 + "&userid=" + this.userID;
         }
         this.openURL(_loc2_,"_blank");
         this.showWaitForTokenPurchaseDialog(this.getTokensPackageByTokenSystemPackageID(param1));
      }
      
      public function showWaitForTokenPurchaseDialog(param1:BMTokenPackage = null) : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("refreshBrowserAfterBuyingTokens");
         this.cancelTokenPolling();
         this.tokenPolling = new TokenPolling(remoteM,this.getCurrentPlayerTokens,this.tokenPollingAddedTokens,this.tokenPollingEnded,param1);
      }
      
      public function cancelTokenPolling() : void
      {
         if(this.tokenPolling != null)
         {
            this.tokenPolling.cancel();
         }
      }
      
      public function refreshBrowserAfterBuyingTokensCancelClicked() : void
      {
         if(this.tokenPolling != null)
         {
            this.tokenPolling.dismiss();
         }
      }
      
      private function tokenPollingEnded() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         this.tokenPolling = null;
      }
      
      private function tokenPollingAddedTokens(param1:BMTokenPackage) : void
      {
         this.tokenPollingEnded();
         screensM.screenConfirmation.displayQuestionOrNotification("buyTokens_thankYou");
         if(param1 != null)
         {
            TsLogger.log("              PAYPAL TRANSACTION COMPLETED >> PRICE: " + param1.priceWithoutCurrency + " CURRENCY: " + param1.currency + " TOKENS: " + param1.tokens);
            this.gameOfWhalesM.tokensPurchased(param1.priceWithoutCurrency,param1.currencyCode,param1.tokens,param1.title);
         }
      }
      
      private function getCurrentPlayerTokens() : int
      {
         var _loc1_:BMPlayerProfile = null;
         _loc1_ = this["player" + this.player1PlayerID + "Profile"];
         return _loc1_.tokens;
      }
      
      public function getCurrentDomain() : String
      {
         var _loc1_:String = null;
         var _loc2_:LocalConnection = null;
         _loc1_ = "";
         _loc2_ = new LocalConnection();
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.domain;
         }
         return _loc1_;
      }
      
      public function popupFreePackages() : void
      {
         var _loc1_:BMNotificationData = null;
         var _loc2_:Array = null;
         var _loc3_:BMDisplayRewardData = null;
         if(!this.gotPopupFreePackages)
         {
            return;
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_DISPLAY_REWARD))
         {
            this.waitForDisplayRewardToCloseToken = BMPubSub.sub(BMPubSub.MESSAGE_SCREEN_CLOSED,this.handleScreenClosedWhileWaitingToPopupFreePackages);
            return;
         }
         _loc1_ = BMNotificationsManager.gi().getRedeemableNotification();
         _loc2_ = new Array();
         _loc3_ = new BMDisplayRewardData();
         _loc3_.type = BMScreenDisplayReward.REWARD_TYPE_FREE_BOX;
         _loc3_.boostID = _loc1_.boostID;
         _loc3_.id = _loc1_.id;
         _loc3_.title = _loc1_.popupText;
         _loc2_.push(_loc3_);
         screensM.addScreen(BMScreensManager.SCR_DISPLAY_REWARD);
         screensM.screenDisplayReward.refreshScreen(_loc2_,"FreePackages");
      }
      
      private function handleScreenClosedWhileWaitingToPopupFreePackages(param1:String, param2:Object) : *
      {
         if(param2.screen == BMScreensManager.SCR_DISPLAY_REWARD)
         {
            BMPubSub.remove(this.waitForDisplayRewardToCloseToken);
            this.waitForDisplayRewardToCloseToken = 0;
            this.popupFreePackages();
         }
      }
      
      public function get gotPopupFreePackages() : Boolean
      {
         return BMNotificationsManager.gi().hasRedeemableNotification;
      }
      
      public function getVectorAngle(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         _loc3_ = Math.atan2(param2,param1) * 180 / Math.PI;
         if(_loc3_ < 0)
         {
            _loc3_ += 360;
         }
         return _loc3_;
      }
      
      public function getVectorSize(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         return Math.sqrt(param1 * param1 + param2 * param2);
      }
      
      public function getVectorSizeOnXAxis(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         _loc3_ = param1 * Math.cos(param2 / 180 * Math.PI);
         if(Math.abs(_loc3_) < 0.0001)
         {
            _loc3_ = 0;
         }
         return _loc3_;
      }
      
      public function getVectorSizeOnYAxis(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         _loc3_ = param1 * Math.sin(param2 / 180 * Math.PI);
         if(Math.abs(_loc3_) < 0.0001)
         {
            _loc3_ = 0;
         }
         return _loc3_;
      }
      
      public function createGeneralDataBases() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Object = null;
         var _loc3_:BMBoostData = null;
         var _loc4_:Object = null;
         var _loc5_:BMTokenPackage = null;
         var _loc6_:Object = null;
         var _loc7_:Array = null;
         this.shopItemDiscountTextFormat = new TextFormat("American Captain Eternal",23,16777215);
         this.animationDB = {};
         this.animationDB["stomp1"] = {
            "effectType":"stomp",
            "fireEffect":"stompFire1",
            "effectColor":"orange",
            "sound":"stomp1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["stomp2"] = {
            "effectType":"stomp",
            "fireEffect":"stompFire2",
            "effectColor":"red",
            "sound":"stomp1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["stomp3"] = {
            "effectType":"stomp",
            "fireEffect":"stompFire3",
            "effectColor":"blue",
            "sound":"stomp1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["sword1"] = {
            "effectType":"sword",
            "fireEffect":"",
            "effectColor":"orange",
            "sound":"",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["sword2"] = {
            "effectType":"sword",
            "fireEffect":"",
            "effectColor":"red",
            "sound":"",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["sword3"] = {
            "effectType":"sword",
            "fireEffect":"",
            "effectColor":"blue",
            "sound":"",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["shield1"] = {
            "effectType":BMMechStructure.SHIELD,
            "fireEffect":"",
            "effectColor":"orange",
            "sound":"",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["shield2"] = {
            "effectType":BMMechStructure.SHIELD,
            "fireEffect":"",
            "effectColor":"red",
            "sound":"",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["shield3"] = {
            "effectType":BMMechStructure.SHIELD,
            "fireEffect":"",
            "effectColor":"blue",
            "sound":"",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["bullet1"] = {
            "effectType":"projectile",
            "projectile":"bullet1",
            "fireEffect":"bulletFire1",
            "effectColor":"orange",
            "sound":"fireBullet1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["bullet2"] = {
            "effectType":"projectile",
            "projectile":"bullet2",
            "fireEffect":"bulletFire2",
            "effectColor":"orange",
            "sound":"fireBullet1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["bullet3"] = {
            "effectType":"projectile",
            "projectile":"bullet3",
            "fireEffect":"bulletFire3",
            "effectColor":"orange",
            "sound":"fireBullet2",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["grenade1"] = {
            "effectType":"grenade",
            "projectile":"grenade1",
            "fireEffect":"bulletFire1",
            "effectColor":"orange",
            "sound":"fireGrenade1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["grenade2"] = {
            "effectType":"grenade",
            "projectile":"grenade2",
            "fireEffect":"bulletFire1",
            "effectColor":"red",
            "sound":"fireGrenade1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["grenade3"] = {
            "effectType":"grenade",
            "projectile":"grenade3",
            "fireEffect":"bulletFire1",
            "effectColor":"blue",
            "sound":"fireGrenade1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["chicken"] = {
            "effectType":"grenade",
            "projectile":"chicken",
            "fireEffect":"bulletFire1",
            "effectColor":"orange",
            "sound":"chicken",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["grenadePull1"] = {
            "effectType":"grenadePull",
            "projectile":"grenadePull1",
            "fireEffect":"bulletFire1",
            "effectColor":"orange",
            "sound":"fireGrenade1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["grenadePull2"] = {
            "effectType":"grenadePull",
            "projectile":"grenadePull2",
            "fireEffect":"bulletFire1",
            "effectColor":"red",
            "sound":"fireGrenade1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["grenadePull3"] = {
            "effectType":"grenadePull",
            "projectile":"grenadePull3",
            "fireEffect":"bulletFire1",
            "effectColor":"blue",
            "sound":"fireGrenade1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["bulletCharge1"] = {
            "effectType":"chargeProjectile",
            "projectile":"bulletCharge1",
            "fireEffect":"bulletFire1",
            "effectColor":"orange",
            "sound":"fireCharge1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["laser1"] = {
            "effectType":"projectile",
            "projectile":"laser1",
            "fireEffect":"laserFire1",
            "effectColor":"blue",
            "sound":"fireLaser1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["laser2"] = {
            "effectType":"projectile",
            "projectile":"laser2",
            "fireEffect":"laserFire2",
            "effectColor":"blue",
            "sound":"fireLaser2",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["laser3"] = {
            "effectType":"projectile",
            "projectile":"laser3",
            "fireEffect":"laserFire2",
            "effectColor":"blue",
            "sound":"fireBullet2",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["laserCharge1"] = {
            "effectType":"chargeProjectile",
            "projectile":"laserCharge1",
            "fireEffect":"laserFire1",
            "effectColor":"blue",
            "sound":"fireCharge2",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["heat1"] = {
            "effectType":"projectile",
            "projectile":"heat1",
            "fireEffect":"heatFire1",
            "effectColor":"red",
            "sound":"fireLaser2",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["heat2"] = {
            "effectType":"projectile",
            "projectile":"heat2",
            "fireEffect":"heatFire2",
            "effectColor":"red",
            "sound":"fireLaser2",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["heat3"] = {
            "effectType":"projectile",
            "projectile":"heat2",
            "fireEffect":"heatFire2",
            "effectColor":"red",
            "sound":"fireBullet2",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["heatCharge1"] = {
            "effectType":"chargeProjectile",
            "projectile":"heatCharge1",
            "fireEffect":"heatFire1",
            "effectColor":"red",
            "sound":"fireCharge3",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["machineGun1"] = {
            "effectType":"immediate1",
            "fireEffect":"machineGunFire1",
            "effectColor":"orange",
            "sound":"fireMachineGun1",
            "getHitSoundsLength":40,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":"mcBulletShell1"
         };
         this.animationDB["machineGun2"] = {
            "effectType":"immediate1",
            "fireEffect":"machineGunFire2",
            "effectColor":"orange",
            "sound":"fireMachineGun2",
            "getHitSoundsLength":40,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":"mcBulletShell1"
         };
         this.animationDB["machineGun3"] = {
            "effectType":"immediate1",
            "fireEffect":"machineGunFire3",
            "effectColor":"orange",
            "sound":"fireMachineGun2",
            "getHitSoundsLength":40,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":"mcBulletShell1"
         };
         this.animationDB["shotgun1"] = {
            "effectType":"immediate2",
            "fireEffect":"shotgunFire1",
            "effectColor":"orange",
            "sound":"fireShotgun1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"mcBulletShell2",
            "bulletShellsFrames":""
         };
         this.animationDB["shotgun2"] = {
            "effectType":"immediate2",
            "fireEffect":"shotgunFire2",
            "effectColor":"red",
            "sound":"fireShotgun1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"mcBulletShell2",
            "bulletShellsFrames":""
         };
         this.animationDB["shotgun3"] = {
            "effectType":"immediate2",
            "fireEffect":"shotgunFire3",
            "effectColor":"blue",
            "sound":"fireShotgun1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"mcBulletShell2",
            "bulletShellsFrames":""
         };
         this.animationDB["rocketBarrage1"] = {
            "effectType":"rocket",
            "rocket":"rocket1",
            "fireEffect":"rocketFire1",
            "effectColor":"red",
            "sound":"fireRocket1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["rocketBarrage2"] = {
            "effectType":"rocketMassive",
            "rocket":"rocket2",
            "fireEffect":"rocketFire2",
            "effectColor":"red",
            "sound":"fireRocket2",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["rocketBarrage3"] = {
            "effectType":"rocketStraight",
            "rocket":"rocket1",
            "fireEffect":"rocketFire1",
            "effectColor":"red",
            "sound":"fireRocket1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["artilleryBarrage1"] = {
            "effectType":"artillery",
            "rocket":"rocket1",
            "fireEffect":"rocketFire1",
            "effectColor":"red",
            "sound":"fireRocket2",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["artilleryDiagonal1"] = {
            "effectType":"artilleryDiagonal",
            "rocket":"rocket1",
            "fireEffect":"rocketFire1",
            "effectColor":"red",
            "sound":"fireRocket2",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["flame1"] = {
            "effectType":"flame",
            "fireEffect":"flameFire1",
            "effectColor":"orange",
            "sound":"flameThrower",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["flame2"] = {
            "effectType":"flame",
            "fireEffect":"flameFireB1",
            "effectColor":"blue",
            "sound":"flameThrower",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["flame3"] = {
            "effectType":"flame",
            "fireEffect":"flameFireC1",
            "effectColor":"green",
            "sound":"flameThrower",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["flame4"] = {
            "effectType":"flame",
            "fireEffect":"flameFireD1",
            "effectColor":"purple",
            "sound":"flameThrower",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["beamRed1"] = {
            "effectType":"beam",
            "size":1,
            "effectShape":"straight",
            "effectColor":BMEffectFireBeam.COLOR_RED,
            "sound":"fireCharge1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["beamRed2"] = {
            "effectType":"beam",
            "size":2,
            "effectShape":"straight",
            "effectColor":BMEffectFireBeam.COLOR_RED,
            "sound":"fireCharge1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["beamBlue1"] = {
            "effectType":"beam",
            "size":1,
            "effectShape":"straight",
            "effectColor":BMEffectFireBeam.COLOR_BLUE,
            "sound":"fireCharge1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["beamBlue2"] = {
            "effectType":"beam",
            "size":2,
            "effectShape":"straight",
            "effectColor":BMEffectFireBeam.COLOR_BLUE,
            "sound":"fireCharge1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["beamYellow1"] = {
            "effectType":"beam",
            "size":1,
            "effectShape":"straight",
            "effectColor":BMEffectFireBeam.COLOR_ORANGE,
            "sound":"fireCharge1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["beamYellow2"] = {
            "effectType":"beam",
            "size":2,
            "effectShape":"straight",
            "effectColor":BMEffectFireBeam.COLOR_ORANGE,
            "sound":"fireCharge1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["beamRoundRed1"] = {
            "effectType":"beam",
            "size":1,
            "effectShape":"round",
            "effectColor":BMEffectFireBeam.COLOR_RED,
            "sound":"fireCharge1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["beamRoundRed2"] = {
            "effectType":"beam",
            "size":2,
            "effectShape":"round",
            "effectColor":BMEffectFireBeam.COLOR_RED,
            "sound":"fireCharge1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["beamRoundBlue1"] = {
            "effectType":"beam",
            "size":1,
            "effectShape":"round",
            "effectColor":BMEffectFireBeam.COLOR_BLUE,
            "sound":"fireCharge1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["beamRoundBlue2"] = {
            "effectType":"beam",
            "size":2,
            "effectShape":"round",
            "effectColor":BMEffectFireBeam.COLOR_BLUE,
            "sound":"fireCharge1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["beamRoundYellow1"] = {
            "effectType":"beam",
            "size":1,
            "effectShape":"round",
            "effectColor":BMEffectFireBeam.COLOR_ORANGE,
            "sound":"fireCharge1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["beamRoundYellow2"] = {
            "effectType":"beam",
            "size":2,
            "effectShape":"round",
            "effectColor":BMEffectFireBeam.COLOR_ORANGE,
            "sound":"fireCharge1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["orbRed1"] = {
            "effectType":"orb",
            "projectile":"orbRed1",
            "fireEffect":"orbFireRed1",
            "effectColor":"red",
            "sound":"fireGrenade1",
            "tailEffect":"orbTailRed1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["orbBlue1"] = {
            "effectType":"orb",
            "projectile":"orbBlue1",
            "fireEffect":"orbFireBlue1",
            "effectColor":"blue",
            "sound":"fireGrenade1",
            "tailEffect":"orbTailBlue1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["orbOrange1"] = {
            "effectType":"orb",
            "projectile":"orbOrange1",
            "fireEffect":"orbFireOrange1",
            "effectColor":"orange",
            "sound":"fireGrenade1",
            "tailEffect":"orbTailOrange1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["heatBomb1"] = {
            "effectType":"heatBomb",
            "projectile":"orbRed1",
            "fireEffect":"orbFireRed1",
            "effectColor":"red",
            "sound":"fireGrenade1",
            "tailEffect":"orbTailRed1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["energyBomb1"] = {
            "effectType":"energyBomb",
            "projectile":"orbBlue1",
            "fireEffect":"orbFireBlue1",
            "effectColor":"blue",
            "sound":"fireGrenade1",
            "tailEffect":"orbTailBlue1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["shockWaveBlue1"] = {
            "effectType":"shockWave",
            "projectile":"shockWaveShotBlue1",
            "fireEffect":"laserFire2",
            "effectColor":"blue",
            "sound":"fireLaser3",
            "tailEffect":"shockWaveTailBlue1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["shockWaveRed1"] = {
            "effectType":"shockWave",
            "projectile":"shockWaveShotRed1",
            "fireEffect":"heatFire2",
            "effectColor":"red",
            "sound":"fireLaser3",
            "tailEffect":"shockWaveTailRed1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["shockWaveOrange1"] = {
            "effectType":"shockWave",
            "projectile":"shockWaveShotOrange1",
            "fireEffect":"bulletFire3",
            "effectColor":"orange",
            "sound":"fireLaser3",
            "tailEffect":"shockWaveTailOrange1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["wand1"] = {
            "effectType":"wand",
            "projectile":"skullFire1",
            "fireEffect":"",
            "effectColor":"red",
            "sound":"fireCharge1",
            "tailEffect":"orbTailRed1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["wand2"] = {
            "effectType":"wand",
            "projectile":"skullFire1",
            "fireEffect":"",
            "effectColor":"red",
            "sound":"fireCharge1",
            "tailEffect":"orbTailRed1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["wand3"] = {
            "effectType":"wand",
            "projectile":"skullFire1",
            "fireEffect":"",
            "effectColor":"red",
            "sound":"fireCharge1",
            "tailEffect":"orbTailRed1",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["specialPhysical1"] = {
            "effectType":"megaProjectile",
            "projectile":"bullet4",
            "fireEffect":"bulletFire3",
            "tailEffect":"smallExplosionAnim1",
            "effectColor":"orange",
            "sound":"fireLaser2",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["specialExplosive1"] = {
            "effectType":"megaProjectile",
            "projectile":"heat3",
            "fireEffect":"heatFire2",
            "tailEffect":"electricityRedBig1",
            "effectColor":"red",
            "sound":"fireLaser2",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["specialElectric1"] = {
            "effectType":"megaProjectile",
            "projectile":"laser2",
            "fireEffect":"laserFire1",
            "tailEffect":"electricityBig1",
            "effectColor":"blue",
            "sound":"fireLaser2",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["repair1"] = {
            "effectType":"repair",
            "fireEffect":"repair1",
            "effectColor":"blue",
            "sound":"fireLaser2",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":40,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.itemTypesDB = new Array();
         this.itemTypesDB[0] = BMMechStructure.TORSO;
         this.itemTypesDB[1] = BMMechStructure.LEG;
         this.itemTypesDB[2] = BMMechStructure.SIDE_WEAPON;
         this.itemTypesDB[3] = BMMechStructure.TOP_WEAPON;
         this.itemTypesDB[4] = BMMechStructure.DRONE;
         this.itemTypesDB[5] = BMMechStructure.SHIELD;
         this.itemTypesDB[6] = BMMechStructure.TELEPORT;
         this.itemTypesDB[7] = BMMechStructure.CHARGE;
         this.itemTypesDB[8] = BMMechStructure.HARPOON;
         this.itemTypesDB[9] = BMMechStructure.MODULE;
         this.itemTypesDB[10] = BMMechStructure.KIT;
         this.itemTypesDB[11] = BMMechStructure.PERK;
         this.itemTypesDB[12] = BMMechStructure.ENHANCER;
         this.itemTypesReverseDB = new Array();
         this.itemTypesReverseDB[BMMechStructure.TORSO] = 0;
         this.itemTypesReverseDB[BMMechStructure.LEG] = 1;
         this.itemTypesReverseDB[BMMechStructure.SIDE_WEAPON] = 2;
         this.itemTypesReverseDB[BMMechStructure.TOP_WEAPON] = 3;
         this.itemTypesReverseDB[BMMechStructure.DRONE] = 4;
         this.itemTypesReverseDB[BMMechStructure.SHIELD] = 5;
         this.itemTypesReverseDB[BMMechStructure.TELEPORT] = 6;
         this.itemTypesReverseDB[BMMechStructure.CHARGE] = 7;
         this.itemTypesReverseDB[BMMechStructure.HARPOON] = 8;
         this.itemTypesReverseDB[BMMechStructure.MODULE] = 9;
         this.itemTypesReverseDB[BMMechStructure.KIT] = 10;
         this.itemTypesReverseDB[BMMechStructure.PERK] = 11;
         this.itemTypesReverseDB[BMMechStructure.ENHANCER] = 12;
         this.maxEquipment = {};
         this.maxEquipment[BMMechStructure.SIDE_WEAPON] = this.MAX_SIDE_WEAPONS;
         this.maxEquipment[BMMechStructure.TOP_WEAPON] = this.MAX_TOP_WEAPONS;
         this.maxEquipment[BMMechStructure.DRONE] = this.MAX_DRONES;
         this.maxEquipment[BMMechStructure.SHIELD] = this.MAX_SHIELDS;
         this.maxEquipment[BMMechStructure.TELEPORT] = this.MAX_TELEPORTS;
         this.maxEquipment[BMMechStructure.CHARGE] = this.MAX_CHARGES;
         this.maxEquipment[BMMechStructure.HARPOON] = this.MAX_HARPOONS;
         this.maxEquipment[BMMechStructure.MODULE] = this.MAX_MODULES;
         this.maxEquipment[BMMechStructure.KIT] = this.MAX_KITS;
         this.maxEquipment["taunt"] = this.MAX_TAUNTS;
         this.maxEquipment[BMMechStructure.ENHANCER] = this.MAX_ENHANCERS;
         this.ladderRankIconsDB = new Array();
         this.ladderRankIconsDB[25] = 1;
         this.ladderRankIconsDB[24] = 2;
         this.ladderRankIconsDB[23] = 3;
         this.ladderRankIconsDB[22] = 4;
         this.ladderRankIconsDB[21] = 5;
         this.ladderRankIconsDB[20] = 6;
         this.ladderRankIconsDB[19] = 7;
         this.ladderRankIconsDB[18] = 8;
         this.ladderRankIconsDB[17] = 9;
         this.ladderRankIconsDB[16] = 13;
         this.ladderRankIconsDB[15] = 24;
         this.ladderRankIconsDB[14] = 25;
         this.ladderRankIconsDB[13] = 26;
         this.ladderRankIconsDB[12] = 33;
         this.ladderRankIconsDB[11] = 34;
         this.ladderRankIconsDB[10] = 35;
         this.ladderRankIconsDB[9] = 40;
         this.ladderRankIconsDB[8] = 41;
         this.ladderRankIconsDB[7] = 42;
         this.ladderRankIconsDB[6] = 56;
         this.ladderRankIconsDB[5] = 57;
         this.ladderRankIconsDB[4] = 59;
         this.ladderRankIconsDB[3] = 60;
         this.ladderRankIconsDB[2] = 61;
         this.ladderRankIconsDB[1] = 62;
         this.replayActionsDB = {};
         this.replayActionsDB["FW"] = "fireWeapon";
         this.replayActionsDB["SH"] = "shutDown";
         this.replayActionsDB["CM"] = "changeMech";
         this.replayActionsDB["KI"] = "useKit";
         this.replayActionsDB["WL"] = "walkLeft";
         this.replayActionsDB["WR"] = "walkRight";
         this.replayActionsDB["JL"] = "jumpLeft";
         this.replayActionsDB["JR"] = "jumpRight";
         this.replayActionsDB["TP"] = BMMechStructure.TELEPORT;
         this.replayActionsDB["CH"] = BMMechStructure.CHARGE;
         this.replayActionsDB["HR"] = BMMechStructure.HARPOON;
         this.replayActionsDB["DA"] = "activateDrone";
         this.replayActionsDB["DD"] = "deactivateDrone";
         this.replayActionsDB["SA"] = "activateShield";
         this.replayActionsDB["SD"] = "deactivateShield";
         this.createInfoTextDB();
         _loc2_ = {};
         _loc2_[1] = 0;
         _loc2_[2] = 100;
         _loc2_[3] = 200;
         _loc2_[4] = 500;
         this.updateLevelUpDB(_loc2_);
         this.itemTypeSourceDB = new Array();
         this.itemTypeSourceDB[BMMechStructure.TORSO] = "items1";
         this.itemTypeSourceDB[BMMechStructure.LEG] = "items1";
         this.itemTypeSourceDB[BMMechStructure.SIDE_WEAPON] = "items2";
         this.itemTypeSourceDB[BMMechStructure.TOP_WEAPON] = "items2";
         this.itemTypeSourceDB[BMMechStructure.DRONE] = "items1";
         this.itemTypeSourceDB[BMMechStructure.SHIELD] = "items3";
         this.itemTypeSourceDB[BMMechStructure.TELEPORT] = "items3";
         this.itemTypeSourceDB[BMMechStructure.CHARGE] = "items3";
         this.itemTypeSourceDB[BMMechStructure.HARPOON] = "items3";
         this.itemTypeSourceDB[BMMechStructure.MODULE] = "items3";
         this.itemTypeSourceDB[BMMechStructure.KIT] = "items3";
         this.itemTypeSourceDB[BMMechStructure.PERK] = "items3";
         this.itemTypeSourceDB[BMMechStructure.ENHANCER] = "items3";
         this.techDB = {};
         this.techDB[BMMechStructure.DRONE] = {
            "name":BMMechStructure.DRONE,
            "maxLevel":1
         };
         this.techDB[BMMechStructure.SHIELD] = {
            "name":BMMechStructure.SHIELD,
            "maxLevel":1
         };
         this.techDB[BMMechStructure.TELEPORT] = {
            "name":BMMechStructure.TELEPORT,
            "maxLevel":1
         };
         this.techDB[BMMechStructure.CHARGE] = {
            "name":BMMechStructure.CHARGE,
            "maxLevel":1
         };
         this.techDB[BMMechStructure.HARPOON] = {
            "name":"Grappling hook",
            "maxLevel":1
         };
         this.techDB["damage1"] = {
            "name":"Physical damage mastery",
            "maxLevel":12,
            "damageType":1,
            "addon":2,
            "addonText1":"+",
            "addonText2":" to physical damage",
            "color":"FFCC00"
         };
         this.techDB["damage2"] = {
            "name":"Explosive damage mastery",
            "maxLevel":12,
            "damageType":1,
            "addon":2,
            "addonText1":"+",
            "addonText2":" to explosive damage",
            "color":"FF6600"
         };
         this.techDB["damage3"] = {
            "name":"Electric damage mastery",
            "maxLevel":12,
            "damageType":1,
            "addon":2,
            "addonText1":"+",
            "addonText2":" to electric damage",
            "color":"00CCFF"
         };
         this.techDB["resist1"] = {
            "name":"Physical resistance mastery",
            "maxLevel":12,
            "damageType":1,
            "addon":2,
            "addonText1":"+",
            "addonText2":" to physical resistance",
            "color":"FFCC00"
         };
         this.techDB["resist2"] = {
            "name":"Explosive resistance mastery",
            "maxLevel":12,
            "damageType":1,
            "addon":2,
            "addonText1":"+",
            "addonText2":" to explosive resistance",
            "color":"FF6600"
         };
         this.techDB["resist3"] = {
            "name":"Electric resistance mastery",
            "maxLevel":12,
            "damageType":1,
            "addon":2,
            "addonText1":"+",
            "addonText2":" to electric resistance",
            "color":"00CCFF"
         };
         this.techDB["critical"] = {
            "name":"Critical damage mastery",
            "maxLevel":12,
            "damageType":1,
            "addon":2,
            "addonText1":"",
            "addonText2":"% for critical hit",
            "color":"FFCC00"
         };
         this.techDB["stomp"] = {
            "name":"Stomp damage addon",
            "maxLevel":12,
            "damageType":1,
            "addon":2,
            "addonText1":"+",
            "addonText2":"% stomp damage",
            "color":"FFCC00"
         };
         this.techDB["discount"] = {
            "name":"Shop discount",
            "maxLevel":12,
            "damageType":1,
            "addon":2,
            "addonText1":"",
            "addonText2":"% discount",
            "color":"FF9900"
         };
         this.gachaMachinesArray = new Array();
         this.gachaMachinesArray.push(new BMGachaMachineData(1,"gachaMachine_silverBox","gachaMachine_silverBoxDesc",3400,0,0,1,true,false,false,[],false));
         this.gachaMachinesArray.push(new BMGachaMachineData(2,"gachaMachine_premiumBox","gachaMachine_premiumBoxDesc1",0,150,150,2,true,false,false,[],false));
         this._createGacheMachineDBfromArray();
         this.tipsManager = new BMTipsManager();
         this.createMusicData();
         this.createBattleInterfaceToolTipDB();
         this.colorsDB = new Array();
         this.colorsDB[1] = 15359140;
         this.colorsDB[2] = 7034090;
         this.colorsDB[3] = 98549;
         this.colorsDB[4] = 6851841;
         this.colorsDB[5] = 10644831;
         this.colorsDB[6] = 16116480;
         this.colorsDB[7] = 12690456;
         this.colorsDB[8] = 15270145;
         this.colorsDB[9] = 16777215;
         this.colorsDB[11] = 10135447;
         this.colorsDB[12] = 6584425;
         this.colorsDB[13] = 7434074;
         this.colorsDB[14] = 8482107;
         this.colorsDB[15] = 10582025;
         this.colorsDB[16] = 13872195;
         this.colorsDB[17] = 14860842;
         this.colorsDB[18] = 16750848;
         this.colorsDB[19] = 14428714;
         this.colorsDB[20] = 9699328;
         this.colorsDB[21] = 2105376;
         this.colorsDB[100] = 4288217088;
         this.colorsDB[101] = 4278216396;
         this.colorsDB[102] = 4278216345;
         this.colorsDB[103] = 4292367872;
         this.colorsDB[201] = 4278190080;
         this.colorsDB[202] = 4281545523;
         this.colorsDB[203] = 4284900966;
         this.colorsDB[204] = 4288256409;
         this.colorsDB[205] = 4294967295;
         this.colorsDB[206] = 4288230246;
         this.colorsDB[207] = 4291585587;
         this.colorsDB[208] = 4288217088;
         this.colorsDB[209] = 4294901760;
         this.colorsDB[210] = 4294927872;
         this.colorsDB[211] = 4294940928;
         this.colorsDB[212] = 4281571584;
         this.colorsDB[213] = 4278216192;
         this.colorsDB[214] = 4284900864;
         this.colorsDB[215] = 4278216294;
         this.colorsDB[216] = 4278216345;
         this.colorsDB[217] = 4278203238;
         this.colorsDB[218] = 4281545472;
         this.colorsDB[301] = 4284900864;
         this.colorsDB[302] = 4292892928;
         this.colorsDB[303] = 4291559424;
         this.itemIDsForbiddenForPC = {};
         this.itemIDsForbiddenForPC[1058] = true;
         this.itemIDsForbiddenForPC[1059] = true;
         this.itemIDsForbiddenForPC[1060] = true;
         this.itemIDsForbiddenForPC[1061] = true;
         this.itemIDsForbiddenForPC[1062] = true;
         this.boostsDB = new Array();
         _loc3_ = new BMBoostData();
         _loc3_.initialize(2,getSpecificText("packages_bronze"),"resources",90,90,0,0,0,0,50000,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[2] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(3,getSpecificText("packages_silver"),"resources",170,170,0,0,0,0,100000,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[3] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(4,getSpecificText("packages_gold"),"resources",280,280,0,0,0,0,200000,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[4] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(9,getSpecificText("packages_itemsBox"),"randomItems",0,0,0,0,5000,1,0,3,2,50,10,3,0,50,10,3,0,0,0,0,"",0);
         this.boostsDB[9] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(5,getSpecificText("packages_itemsBoxSilver"),"randomItems",90,90,0,0,0,0,0,5,2,53,30,10,7,3,30,10,7,0,0,0,"",0);
         this.boostsDB[5] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(6,getSpecificText("packages_itemsBoxGold"),"randomItems",140,140,0,0,0,0,0,5,2,5,50,30,15,5,50,30,15,0,0,0,"",0);
         this.boostsDB[6] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(11,getSpecificText("packages_itemsBox"),"randomItems",0,0,0,0,500000,1,0,4,2,55,12,4,0,55,12,4,0,0,0,0,"",0);
         this.boostsDB[11] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(12,getSpecificText("packages_itemsBox"),"randomItems",0,0,0,0,500000,1,0,5,2,60,14,5,0,60,14,5,0,0,0,0,"",0);
         this.boostsDB[12] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(19,getSpecificText("packages_itemsBoxMythical"),"randomItems",600,600,0,0,0,0,0,2,2,0,0,0,100,30,0,0,100,0,0,0,"",0);
         this.boostsDB[19] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(20,getSpecificText("packages_itemsBoxMythical"),"randomItems",220,220,0,0,0,0,0,1,2,0,0,0,100,13,0,0,100,0,0,0,"",0);
         this.boostsDB[20] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(8,getSpecificText("packages_premiumAccount"),"premiumAccount",40,40,86400,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[8] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(10,getSpecificText("packages_premiumAccount"),"premiumAccount",100,100,604800,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[10] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(1,getSpecificText("packages_premiumAccount"),"premiumAccount",250,250,2592000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[1] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(14,"","specificItem",150,150,2592000,0,0,892,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[14] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(15,"","specificItem",150,150,2592000,0,0,920,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[15] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(16,"","freeTokens",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[16] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(21,"Torsos and legs Item Box","randomItems",0,0,0,2000,500,0,0,2,3,50,12,4,0,0,50,12,4,0,0,80,"torsoLeg",0);
         this.boostsDB[21] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(22,"Weapons Item Box","randomItems",0,0,0,1500,250,0,0,2,3,50,12,4,0,0,50,12,4,0,0,60,"weapons",0);
         this.boostsDB[22] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(23,"Specials Item Box","randomItems",0,0,0,1500,250,0,0,2,3,50,12,4,0,0,50,12,4,0,0,50,"specials",0);
         this.boostsDB[23] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(24,"Modules Item Box","randomItems",0,0,0,1000,125,0,0,2,3,50,12,4,0,0,50,12,4,0,0,50,"modules",0);
         this.boostsDB[24] = _loc3_;
         _loc3_ = new BMBoostData();
         _loc3_.initialize(25,"Mix Item Box","randomItems",0,0,0,1500,250,0,0,3,3,50,12,4,0,0,50,12,4,0,0,50,"mix",0);
         this.boostsDB[25] = _loc3_;
         this.itemTypeSortDB = {};
         this.itemTypeSortDB[BMMechStructure.TORSO] = 1000000;
         this.itemTypeSortDB[BMMechStructure.LEG] = 1005000;
         this.itemTypeSortDB[BMMechStructure.SIDE_WEAPON] = 3000000;
         this.itemTypeSortDB[BMMechStructure.TOP_WEAPON] = 4000000;
         this.itemTypeSortDB[BMMechStructure.DRONE] = 5000000;
         this.itemTypeSortDB[BMMechStructure.SHIELD] = 6000000;
         this.itemTypeSortDB[BMMechStructure.TELEPORT] = 7000000;
         this.itemTypeSortDB[BMMechStructure.CHARGE] = 8000000;
         this.itemTypeSortDB[BMMechStructure.HARPOON] = 9000000;
         this.itemTypeSortDB[BMMechStructure.MODULE] = 11000000;
         this.itemTypeSortDB[BMMechStructure.KIT] = 12000000;
         this.itemTypeSortDB[BMMechStructure.PERK] = 100000;
         this.createPowerLevelsDB();
         this.subTypeDB = {};
         this.subTypeDB[BMMechStructure.TORSO] = {
            "ID":1,
            "source":"items1",
            "name":BMMechStructure.TORSO,
            "unlockLevel":1
         };
         this.subTypeDB[BMMechStructure.LEG] = {
            "ID":2,
            "source":"items1",
            "name":BMMechStructure.LEG,
            "unlockLevel":1
         };
         this.subTypeDB["sideWeapon_physical"] = {
            "ID":3,
            "source":"items2",
            "name":"sideWeapon_physical",
            "unlockLevel":1
         };
         this.subTypeDB["sideWeapon_explosive"] = {
            "ID":4,
            "source":"items2",
            "name":"sideWeapon_explosive",
            "unlockLevel":3
         };
         this.subTypeDB["sideWeapon_electric"] = {
            "ID":5,
            "source":"items2",
            "name":"sideWeapon_electric",
            "unlockLevel":2
         };
         this.subTypeDB["sideWeapon_melee"] = {
            "ID":6,
            "source":"items2",
            "name":"sideWeapon_melee",
            "unlockLevel":3
         };
         this.subTypeDB["topWeapon_physical"] = {
            "ID":7,
            "source":"items2",
            "name":"topWeapon_physical",
            "unlockLevel":3
         };
         this.subTypeDB["topWeapon_explosive"] = {
            "ID":8,
            "source":"items2",
            "name":"topWeapon_explosive",
            "unlockLevel":3
         };
         this.subTypeDB["topWeapon_electric"] = {
            "ID":9,
            "source":"items2",
            "name":"topWeapon_electric",
            "unlockLevel":2
         };
         this.subTypeDB[BMMechStructure.DRONE] = {
            "ID":10,
            "source":"items1",
            "name":BMMechStructure.DRONE,
            "unlockLevel":3
         };
         this.subTypeDB[BMMechStructure.SHIELD] = {
            "ID":11,
            "source":"items3",
            "name":BMMechStructure.SHIELD,
            "unlockLevel":5
         };
         this.subTypeDB["specials"] = {
            "ID":12,
            "source":"items3",
            "name":"specials",
            "unlockLevel":4
         };
         this.subTypeDB["module_armorResistance"] = {
            "ID":13,
            "source":"items3",
            "name":"module_armorResistance",
            "unlockLevel":3
         };
         this.subTypeDB["module_energyHeat"] = {
            "ID":14,
            "source":"items3",
            "name":"module_energyHeat",
            "unlockLevel":3
         };
         this.subTypeDB["module_bulletsRockets"] = {
            "ID":15,
            "source":"items3",
            "name":"module_bulletsRockets",
            "unlockLevel":2
         };
         this.subTypeDB["kit_repairResistance"] = {
            "ID":16,
            "source":"items3",
            "name":"kit_repairResistance",
            "unlockLevel":2
         };
         this.subTypeDB["kit_energyHeat"] = {
            "ID":17,
            "source":"items3",
            "name":"kit_energyHeat",
            "unlockLevel":3
         };
         this.subTypeDB["kit_bulletsRockets"] = {
            "ID":18,
            "source":"items3",
            "name":"kit_bulletsRockets",
            "unlockLevel":3
         };
         this.subTypeDB["kit_power"] = {
            "ID":19,
            "source":"items3",
            "name":"kit_power",
            "unlockLevel":3
         };
         this.subTypeDB["kit_color"] = {
            "ID":20,
            "source":"items3",
            "name":"kit_color",
            "unlockLevel":3
         };
         this.subTypeDB["kit_transform"] = {
            "ID":21,
            "source":"items3",
            "name":"kit_transform",
            "unlockLevel":3
         };
         for each(_loc4_ in this.subTypeDB)
         {
            _loc4_.text = getSpecificText("shop_" + _loc4_.name);
         }
         this.SUB_TYPE_SIDE_WEAPON_PHYSICAL = 3;
         this.SUB_TYPE_TOP_WEAPON_ELECTRIC = 9;
         this.SUB_TYPE_MODULE_BULLETS_ROCKETS = 15;
         this.subTypeDB_myth = {};
         this.subTypeDB_myth[BMMechStructure.TORSO] = {
            "ID":1,
            "source":"items1",
            "name":BMMechStructure.TORSO,
            "unlockLevel":1
         };
         this.subTypeDB_myth[BMMechStructure.LEG] = {
            "ID":2,
            "source":"items1",
            "name":BMMechStructure.LEG,
            "unlockLevel":1
         };
         this.subTypeDB_myth["sideWeapon_physical"] = {
            "ID":3,
            "source":"items2",
            "name":"sideWeapon_physical",
            "unlockLevel":1
         };
         this.subTypeDB_myth["sideWeapon_explosive"] = {
            "ID":4,
            "source":"items2",
            "name":"sideWeapon_explosive",
            "unlockLevel":3
         };
         this.subTypeDB_myth["sideWeapon_electric"] = {
            "ID":5,
            "source":"items2",
            "name":"sideWeapon_electric",
            "unlockLevel":2
         };
         this.subTypeDB_myth["sideWeapon_melee"] = {
            "ID":6,
            "source":"items2",
            "name":"sideWeapon_melee",
            "unlockLevel":3
         };
         this.subTypeDB_myth["topWeapon_physical"] = {
            "ID":7,
            "source":"items2",
            "name":"topWeapon_physical",
            "unlockLevel":3
         };
         this.subTypeDB_myth["topWeapon_explosive"] = {
            "ID":8,
            "source":"items2",
            "name":"topWeapon_explosive",
            "unlockLevel":3
         };
         this.subTypeDB_myth["topWeapon_electric"] = {
            "ID":9,
            "source":"items2",
            "name":"topWeapon_electric",
            "unlockLevel":2
         };
         this.subTypeDB_myth[BMMechStructure.DRONE] = {
            "ID":10,
            "source":"items1",
            "name":BMMechStructure.DRONE,
            "unlockLevel":3
         };
         this.subTypeDB_myth[BMMechStructure.SHIELD] = {
            "ID":11,
            "source":"items3",
            "name":BMMechStructure.SHIELD,
            "unlockLevel":5
         };
         this.subTypeDB_myth["specials"] = {
            "ID":12,
            "source":"items3",
            "name":"specials",
            "unlockLevel":4
         };
         this.subTypeDB_myth["module_armorResistance"] = {
            "ID":13,
            "source":"items3",
            "name":"module_armorResistance",
            "unlockLevel":3
         };
         this.subTypeDB_myth["module_energyHeat"] = {
            "ID":14,
            "source":"items3",
            "name":"module_energyHeat",
            "unlockLevel":3
         };
         this.subTypeDB_myth["module_bulletsRockets"] = {
            "ID":15,
            "source":"items3",
            "name":"module_bulletsRockets",
            "unlockLevel":2
         };
         for each(_loc4_ in this.subTypeDB_myth)
         {
            _loc4_.text = getSpecificText("shop_" + _loc4_.name);
         }
         this.subTypeDB_combined = {};
         this.subTypeDB_combined["box_regular"] = {
            "ID":1,
            "name":"box_regular",
            "color":"blue",
            "unlockLevel":1
         };
         this.subTypeDB_combined["box_tokens"] = {
            "ID":2,
            "name":"box_tokens",
            "color":"orange",
            "unlockLevel":1
         };
         this.subTypeDB_combined["premiumAccount"] = {
            "ID":3,
            "name":"premiumAccount",
            "color":"orange",
            "unlockLevel":1
         };
         this.subTypeDB_combined["kits"] = {
            "ID":4,
            "name":"kits",
            "color":"blue",
            "unlockLevel":1
         };
         for each(_loc4_ in this.subTypeDB_combined)
         {
            _loc4_.text = getSpecificText("shop_" + _loc4_.name);
         }
         this.subTypeOrderDB = new Array();
         this.subTypeOrderDB.push({"name":BMMechStructure.TORSO});
         this.subTypeOrderDB.push({"name":BMMechStructure.LEG});
         this.subTypeOrderDB.push({
            "name":"sideWeapon_physical",
            "color":"yellow"
         });
         this.subTypeOrderDB.push({
            "name":"sideWeapon_explosive",
            "color":"red"
         });
         this.subTypeOrderDB.push({
            "name":"sideWeapon_electric",
            "color":"blue"
         });
         this.subTypeOrderDB.push({"name":"sideWeapon_melee"});
         this.subTypeOrderDB.push({
            "name":"topWeapon_physical",
            "color":"yellow"
         });
         this.subTypeOrderDB.push({
            "name":"topWeapon_explosive",
            "color":"red"
         });
         this.subTypeOrderDB.push({
            "name":"topWeapon_electric",
            "color":"blue"
         });
         this.subTypeOrderDB.push({"name":BMMechStructure.DRONE});
         this.subTypeOrderDB.push({"name":BMMechStructure.SHIELD});
         this.subTypeOrderDB.push({"name":"specials"});
         this.subTypeOrderDB.push({"name":"module_armorResistance"});
         this.subTypeOrderDB.push({"name":"module_energyHeat"});
         this.subTypeOrderDB.push({"name":"module_bulletsRockets"});
         this.subTypeOrderDB.push({"name":"kit_repairResistance"});
         this.subTypeOrderDB.push({"name":"kit_energyHeat"});
         this.subTypeOrderDB.push({"name":"kit_bulletsRockets"});
         this.subTypeOrderDB.push({"name":"kit_power"});
         this.subTypeOrderDB.push({"name":"kit_transform"});
         this.subTypeOrderDB.push({"name":"kit_color"});
         this.subTypeOrderDB_myth = new Array();
         this.subTypeOrderDB_myth.push({"name":BMMechStructure.TORSO});
         this.subTypeOrderDB_myth.push({"name":BMMechStructure.LEG});
         this.subTypeOrderDB_myth.push({
            "name":"sideWeapon_physical",
            "color":"yellow"
         });
         this.subTypeOrderDB_myth.push({
            "name":"sideWeapon_explosive",
            "color":"red"
         });
         this.subTypeOrderDB_myth.push({
            "name":"sideWeapon_electric",
            "color":"blue"
         });
         this.subTypeOrderDB_myth.push({"name":"sideWeapon_melee"});
         this.subTypeOrderDB_myth.push({
            "name":"topWeapon_physical",
            "color":"yellow"
         });
         this.subTypeOrderDB_myth.push({
            "name":"topWeapon_explosive",
            "color":"red"
         });
         this.subTypeOrderDB_myth.push({
            "name":"topWeapon_electric",
            "color":"blue"
         });
         this.subTypeOrderDB_myth.push({"name":BMMechStructure.DRONE});
         this.subTypeOrderDB_myth.push({"name":BMMechStructure.SHIELD});
         this.subTypeOrderDB_myth.push({"name":"specials"});
         this.subTypeOrderDB_myth.push({"name":"module_armorResistance"});
         this.subTypeOrderDB_myth.push({"name":"module_energyHeat"});
         this.subTypeOrderDB_myth.push({"name":"module_bulletsRockets"});
         this.subTypeOrderDB_combined = new Array();
         this.subTypeOrderDB_combined.push({"name":"box_regular"});
         this.subTypeOrderDB_combined.push({"name":"box_tokens"});
         this.subTypeOrderDB_combined.push({"name":"premiumAccount"});
         this.subTypeOrderDB_combined.push({"name":"kits"});
         this.allTokenPackages = new Array();
         _loc5_ = new BMTokenPackage();
         _loc5_.initialize(1,1,1,"27",1,0);
         this.allTokenPackages.push(_loc5_);
         _loc5_ = new BMTokenPackage();
         _loc5_.initialize(2,1,2,"1",2,0);
         this.allTokenPackages.push(_loc5_);
         _loc5_ = new BMTokenPackage();
         _loc5_.initialize(3,1,3,"2",3,0);
         this.allTokenPackages.push(_loc5_);
         _loc5_ = new BMTokenPackage();
         _loc5_.initialize(4,1,4,"3",4,1);
         this.allTokenPackages.push(_loc5_);
         _loc5_ = new BMTokenPackage();
         _loc5_.initialize(5,1,5,"24",5,2);
         this.allTokenPackages.push(_loc5_);
         this.missionUpgradesDB = {};
         this.missionUpgradesDB[BMScreenMissionBaseMap.UPGRADE_HP] = "upgradeHP";
         this.missionUpgradesDB[BMScreenMissionBaseMap.UPGRADE_ENERGY] = "upgradeEnergy";
         this.missionUpgradesDB[BMScreenMissionBaseMap.UPGRADE_HEAT] = "upgradeHeat";
         this.missionUpgradesDB["BL"] = "upgradeBullets";
         this.missionUpgradesDB["RK"] = "upgradeRockets";
         this.missionUpgradesReverseDB = {};
         this.missionUpgradesReverseDB["upgradeHP"] = BMScreenMissionBaseMap.UPGRADE_HP;
         this.missionUpgradesReverseDB["upgradeEnergy"] = BMScreenMissionBaseMap.UPGRADE_ENERGY;
         this.missionUpgradesReverseDB["upgradeHeat"] = BMScreenMissionBaseMap.UPGRADE_HEAT;
         this.missionUpgradesReverseDB["upgradeBullets"] = "BL";
         this.missionUpgradesReverseDB["upgradeRockets"] = "RK";
         this.missionMapObjectDB = {};
         this.missionMapObjectDB["GA1D"] = {
            "code":"GA1D",
            "type":"structure",
            "subType":"turret",
            "weaponAnimation":"laser1",
            "damage":10,
            "damageAddonPerMission":0.4,
            "grp":"turretA1D",
            "direction":BMBaseMapTurret.DIRECTION_DOWN,
            "dirtSize":1
         };
         this.missionMapObjectDB["GA1L"] = {
            "code":"GA1L",
            "type":"structure",
            "subType":"turret",
            "weaponAnimation":"laser1",
            "damage":10,
            "damageAddonPerMission":0.4,
            "grp":"turretA1L",
            "direction":BMBaseMapTurret.DIRECTION_LEFT,
            "dirtSize":1
         };
         this.missionMapObjectDB["GA1R"] = {
            "code":"GA1R",
            "type":"structure",
            "subType":"turret",
            "weaponAnimation":"laser1",
            "damage":10,
            "damageAddonPerMission":0.4,
            "grp":"turretA1R",
            "direction":BMBaseMapTurret.DIRECTION_RIGHT,
            "dirtSize":1
         };
         this.missionMapObjectDB["GA2D"] = {
            "code":"GA2D",
            "type":"structure",
            "subType":"turret",
            "weaponAnimation":"laser1",
            "damage":20,
            "damageAddonPerMission":0.4,
            "grp":"turretA1D",
            "direction":BMBaseMapTurret.DIRECTION_DOWN,
            "dirtSize":1
         };
         this.missionMapObjectDB["GA2L"] = {
            "code":"GA2L",
            "type":"structure",
            "subType":"turret",
            "weaponAnimation":"laser1",
            "damage":20,
            "damageAddonPerMission":0.4,
            "grp":"turretA1L",
            "direction":BMBaseMapTurret.DIRECTION_LEFT,
            "dirtSize":1
         };
         this.missionMapObjectDB["GA2R"] = {
            "code":"GA2R",
            "type":"structure",
            "subType":"turret",
            "weaponAnimation":"laser1",
            "damage":20,
            "damageAddonPerMission":0.4,
            "grp":"turretA1R",
            "direction":BMBaseMapTurret.DIRECTION_RIGHT,
            "dirtSize":1
         };
         this.missionMapObjectDB["GA3D"] = {
            "code":"GA3D",
            "type":"structure",
            "subType":"turret",
            "weaponAnimation":"laser1",
            "damage":30,
            "damageAddonPerMission":0.4,
            "grp":"turretA1D",
            "direction":BMBaseMapTurret.DIRECTION_DOWN,
            "dirtSize":2
         };
         this.missionMapObjectDB["GA3L"] = {
            "code":"GA3L",
            "type":"structure",
            "subType":"turret",
            "weaponAnimation":"laser1",
            "damage":30,
            "damageAddonPerMission":0.4,
            "grp":"turretA1L",
            "direction":BMBaseMapTurret.DIRECTION_LEFT,
            "dirtSize":2
         };
         this.missionMapObjectDB["GA3R"] = {
            "code":"GA3R",
            "type":"structure",
            "subType":"turret",
            "weaponAnimation":"laser1",
            "damage":30,
            "damageAddonPerMission":0.4,
            "grp":"turretA1R",
            "direction":BMBaseMapTurret.DIRECTION_RIGHT,
            "dirtSize":2
         };
         this.missionMapObjectDB["JP"] = {
            "code":"JP",
            "type":"enemy",
            "subType":"jeep",
            "grp":"jeep",
            "dirtSize":1
         };
         this.missionMapObjectDB["J1"] = {
            "code":"J1",
            "type":"enemy",
            "subType":"jeep",
            "grp":"jeep_1",
            "dirtSize":1
         };
         this.missionMapObjectDB["J2"] = {
            "code":"J2",
            "type":"enemy",
            "subType":"jeep",
            "grp":"jeep_2",
            "dirtSize":1
         };
         this.missionMapObjectDB["J3"] = {
            "code":"J3",
            "type":"enemy",
            "subType":"jeep",
            "grp":"jeep_3",
            "dirtSize":1
         };
         this.missionMapObjectDB["TK"] = {
            "code":"TK",
            "type":"enemy",
            "subType":"tank",
            "grp":"tank",
            "dirtSize":2
         };
         this.missionMapObjectDB["T1"] = {
            "code":"T1",
            "type":"enemy",
            "subType":"tank",
            "grp":"tank_1",
            "dirtSize":2
         };
         this.missionMapObjectDB["T2"] = {
            "code":"T2",
            "type":"enemy",
            "subType":"tank",
            "grp":"tank_2",
            "dirtSize":2
         };
         this.missionMapObjectDB["T3"] = {
            "code":"T3",
            "type":"enemy",
            "subType":"tank",
            "grp":"tank_3",
            "dirtSize":2
         };
         this.missionMapObjectDB["ME"] = {
            "code":"ME",
            "type":"enemy",
            "subType":"mech",
            "grp":"mech",
            "dirtSize":2
         };
         this.missionMapObjectDB["M1"] = {
            "code":"M1",
            "type":"enemy",
            "subType":"mech",
            "grp":"mech_1",
            "dirtSize":2
         };
         this.missionMapObjectDB["M2"] = {
            "code":"M2",
            "type":"enemy",
            "subType":"mech",
            "grp":"mech_2",
            "dirtSize":2
         };
         this.missionMapObjectDB["M3"] = {
            "code":"M3",
            "type":"enemy",
            "subType":"mech",
            "grp":"mech_3",
            "dirtSize":2
         };
         this.missionMapObjectDB["BS"] = {
            "code":"BS",
            "type":"enemy",
            "subType":"boss",
            "grp":"boss",
            "dirtSize":3
         };
         this.missionMapObjectDB["B1"] = {
            "code":"B1",
            "type":"enemy",
            "subType":"boss",
            "grp":"boss_1",
            "dirtSize":3
         };
         this.missionMapObjectDB["B2"] = {
            "code":"B2",
            "type":"enemy",
            "subType":"boss",
            "grp":"boss_2",
            "dirtSize":3
         };
         this.missionMapObjectDB["B3"] = {
            "code":"B3",
            "type":"enemy",
            "subType":"boss",
            "grp":"boss_3",
            "dirtSize":3
         };
         this.missionMapObjectDB["B4"] = {
            "code":"B4",
            "type":"enemy",
            "subType":"boss",
            "grp":"specialBoss1",
            "dirtSize":3
         };
         this.missionMapObjectDB["L1"] = {
            "code":"L1",
            "type":"loot",
            "grp":"loot1",
            "pickups":1
         };
         this.missionMapObjectDB["L2"] = {
            "code":"L2",
            "type":"loot",
            "grp":"loot2",
            "pickups":2
         };
         this.missionMapObjectDB["L3"] = {
            "code":"L3",
            "type":"loot",
            "grp":"loot3",
            "pickups":3
         };
         this.missionMapObjectDB["SA1"] = {
            "code":"SA1",
            "type":"structure",
            "grp":"structureA1",
            "dirtSize":3
         };
         this.missionMapObjectDB["SB1"] = {
            "code":"SB1",
            "type":"structure",
            "grp":"structureB1",
            "dirtSize":3
         };
         this.missionMapObjectDB["SC1"] = {
            "code":"SC1",
            "type":"structure",
            "grp":"structureC1",
            "dirtSize":3
         };
         this.missionMapObjectDB["SD1"] = {
            "code":"SD1",
            "type":"structure",
            "grp":"structureD1",
            "dirtSize":3
         };
         this.missionMapObjectDB["SE1"] = {
            "code":"SE1",
            "type":"structure",
            "grp":"structureE1",
            "dirtSize":3
         };
         this.missionMapObjectDB["SF1"] = {
            "code":"SF1",
            "type":"structure",
            "grp":"structureF1",
            "dirtSize":3
         };
         this.missionMapObjectDB["SG1"] = {
            "code":"SG1",
            "type":"structure",
            "grp":"structureG1",
            "dirtSize":3
         };
         this.missionMapObjectDB["SH1"] = {
            "code":"SH1",
            "type":"structure",
            "grp":"structureH1",
            "dirtSize":3
         };
         this.missionMapObjectDB["SI1"] = {
            "code":"SI1",
            "type":"structure",
            "grp":"structureI1",
            "dirtSize":3
         };
         this.missionMapObjectDB["SI2"] = {
            "code":"SI2",
            "type":"structure",
            "grp":"structureI2",
            "dirtSize":3
         };
         this.missionMapObjectDB["SJ1"] = {
            "code":"SJ1",
            "type":"structure",
            "grp":"structureJ1",
            "dirtSize":2
         };
         this.missionMapObjectDB["SX1"] = {
            "code":"SX1",
            "type":"structure",
            "grp":"explosiveA1",
            "explosive":true,
            "megaExplosion":false,
            "dirtSize":2
         };
         this.missionMapObjectDB["SX2"] = {
            "code":"SX2",
            "type":"structure",
            "grp":"explosiveA2",
            "explosive":true,
            "megaExplosion":false,
            "dirtSize":2
         };
         this.missionMapObjectDB["SX3"] = {
            "code":"SX3",
            "type":"structure",
            "grp":"explosiveA3",
            "explosive":true,
            "megaExplosion":false,
            "dirtSize":2
         };
         this.missionMapObjectDB["SX4"] = {
            "code":"SX4",
            "type":"structure",
            "grp":"explosiveA4",
            "explosive":true,
            "megaExplosion":true,
            "dirtSize":2
         };
         this.missionMapObjectDB["FA1"] = {
            "code":"FA1",
            "type":"floor",
            "grp":"damageFloorA1",
            "damageEffect":"flame",
            "color":"red",
            "cooldown":125,
            "damageFrames":20,
            "damage":12
         };
         this.missionMapObjectDB["CA1"] = {
            "code":"CA1",
            "type":"crate",
            "grp":"crateA1",
            "dirtSize":1
         };
         this.missionMapObjectDB["CA2"] = {
            "code":"CA2",
            "type":"crate",
            "grp":"crateA2",
            "dirtSize":1
         };
         this.missionMapObjectDB["CA3"] = {
            "code":"CA3",
            "type":"crate",
            "grp":"crateA3",
            "dirtSize":1
         };
         this.missionMapObjectDB["CB1"] = {
            "code":"CB1",
            "type":"crate",
            "grp":"crateB1",
            "dirtSize":1
         };
         this.missionMapObjectDB["CB2"] = {
            "code":"CB2",
            "type":"crate",
            "grp":"crateB2",
            "dirtSize":1
         };
         this.missionMapObjectDB["XX"] = {
            "code":"XX",
            "type":"invisibleBlock",
            "grp":""
         };
         this.missionMapObjectDB["X1"] = {
            "code":"X1",
            "type":"regularBlock",
            "grp":"X1",
            "dirtSize":1
         };
         this.missionMapObjectDB["X2"] = {
            "code":"X2",
            "type":"regularBlock",
            "grp":"X2",
            "dirtSize":1
         };
         this.missionMapObjectDB["X3"] = {
            "code":"X3",
            "type":"regularBlock",
            "grp":"X3",
            "dirtSize":1
         };
         this.missionMapObjectDB["X4"] = {
            "code":"X4",
            "type":"regularBlock",
            "grp":"X4",
            "dirtSize":1
         };
         this.missionMapObjectDB["X5"] = {
            "code":"X5",
            "type":"regularBlock",
            "grp":"X5",
            "dirtSize":1
         };
         this.missionMapObjectDB["X6"] = {
            "code":"X6",
            "type":"regularBlock",
            "grp":"X6",
            "dirtSize":1
         };
         this.missionMapObjectDB["X7"] = {
            "code":"X7",
            "type":"regularBlock",
            "grp":"X7",
            "dirtSize":1
         };
         this.missionMapObjectDB["X8"] = {
            "code":"X8",
            "type":"regularBlock",
            "grp":"X8",
            "dirtSize":1
         };
         this.missionMapObjectDB["X9"] = {
            "code":"X9",
            "type":"regularBlock",
            "grp":"X9",
            "dirtSize":1
         };
         this.missionMapObjectDB["X10"] = {
            "code":"X10",
            "type":"regularBlock",
            "grp":"X10",
            "dirtSize":1
         };
         this.missionMapObjectDB["X11"] = {
            "code":"X11",
            "type":"regularBlock",
            "grp":"X11",
            "dirtSize":1
         };
         this.missionMapObjectDB["X12"] = {
            "code":"X12",
            "type":"regularBlock",
            "grp":"X12",
            "dirtSize":1
         };
         this.missionMapObjectDB["X13"] = {
            "code":"X13",
            "type":"regularBlock",
            "grp":"X13",
            "dirtSize":1
         };
         this.missionMapObjectDB["X14"] = {
            "code":"X14",
            "type":"regularBlock",
            "grp":"X14",
            "dirtSize":1
         };
         this.missionMapObjectDB["X15"] = {
            "code":"X15",
            "type":"regularBlock",
            "grp":"X15",
            "dirtSize":1
         };
         this.missionMapObjectDB["X16"] = {
            "code":"X16",
            "type":"regularBlock",
            "grp":"X16",
            "dirtSize":1
         };
         this.missionMapObjectDB["X17"] = {
            "code":"X17",
            "type":"regularBlock",
            "grp":"X17",
            "dirtSize":1
         };
         this.mandatoryMissionMapObjects = {};
         this.mandatoryMissionMapObjects["TR"] = true;
         this.mandatoryMissionMapObjects["JP"] = true;
         this.mandatoryMissionMapObjects["J1"] = true;
         this.mandatoryMissionMapObjects["J2"] = true;
         this.mandatoryMissionMapObjects["J3"] = true;
         this.mandatoryMissionMapObjects["TK"] = true;
         this.mandatoryMissionMapObjects["T1"] = true;
         this.mandatoryMissionMapObjects["T2"] = true;
         this.mandatoryMissionMapObjects["T3"] = true;
         this.mandatoryMissionMapObjects["ME"] = true;
         this.mandatoryMissionMapObjects["M1"] = true;
         this.mandatoryMissionMapObjects["M2"] = true;
         this.mandatoryMissionMapObjects["M3"] = true;
         this.mandatoryMissionMapObjects["BS"] = true;
         this.mandatoryMissionMapObjects["B1"] = true;
         this.mandatoryMissionMapObjects["B2"] = true;
         this.mandatoryMissionMapObjects["B3"] = true;
         this.mandatoryMissionMapObjects["B4"] = true;
         this.mandatoryMissionMapObjects["CA1"] = true;
         this.mandatoryMissionMapObjects["CA2"] = true;
         this.mandatoryMissionMapObjects["CA3"] = true;
         this.mandatoryMissionMapObjects["CB1"] = true;
         this.mandatoryMissionMapObjects["CB2"] = true;
         this.mandatoryMissionMapObjects["XX"] = true;
         this.mandatoryMissionMapObjects["X1"] = true;
         this.mandatoryMissionMapObjects["X2"] = true;
         this.guestFixedItemsDB = new Array();
         this.guestFixedItemsDB.push({
            "rarity":1,
            "amount":1
         });
         this.guestFixedItemsDB.push({
            "rarity":1,
            "amount":1
         });
         this.guestFixedItemsDB.push({
            "rarity":1,
            "amount":2
         });
         this.guestFixedItemsDB.push({
            "rarity":2,
            "amount":1
         });
         this.guestFixedItemsDB.push({
            "rarity":1,
            "amount":1
         });
         this.guestFixedItemsDB.push({
            "rarity":1,
            "amount":2
         });
         this.guestFixedItemsDB.push({
            "rarity":1,
            "amount":1
         });
         this.guestFixedItemsDB.push({
            "rarity":2,
            "amount":1
         });
         this.guestFixedItemsDB.push({
            "rarity":1,
            "amount":1
         });
         this.guestFixedItemsDB.push({
            "rarity":1,
            "amount":1
         });
         this.guestFixedItemsDB.push({
            "rarity":1,
            "amount":3
         });
         this.guestFixedItemsDB.push({
            "rarity":3,
            "amount":1
         });
         _loc6_ = {};
         _loc6_[BMMechStructure.TORSO] = {
            "name":BMMechStructure.TORSO,
            "total":1,
            "level":1
         };
         _loc6_[BMMechStructure.LEG] = {
            "name":BMMechStructure.LEG,
            "total":1,
            "level":1
         };
         _loc6_["sideWeapon1"] = {
            "name":BMMechStructure.SIDE_WEAPON,
            "total":1,
            "level":1
         };
         _loc6_["sideWeapon2"] = {
            "name":BMMechStructure.SIDE_WEAPON,
            "total":2,
            "level":1
         };
         _loc6_["sideWeapon3"] = {
            "name":BMMechStructure.SIDE_WEAPON,
            "total":3,
            "level":6
         };
         _loc6_["sideWeapon4"] = {
            "name":BMMechStructure.SIDE_WEAPON,
            "total":4,
            "level":9
         };
         _loc6_["topWeapon1"] = {
            "name":BMMechStructure.TOP_WEAPON,
            "total":1,
            "level":2
         };
         _loc6_["topWeapon2"] = {
            "name":BMMechStructure.TOP_WEAPON,
            "total":2,
            "level":7
         };
         _loc6_[BMMechStructure.DRONE] = {
            "name":BMMechStructure.DRONE,
            "total":1,
            "level":3
         };
         _loc6_[BMMechStructure.SHIELD] = {
            "name":BMMechStructure.SHIELD,
            "total":1,
            "level":6
         };
         _loc6_[BMMechStructure.TELEPORT] = {
            "name":BMMechStructure.TELEPORT,
            "total":1,
            "level":4
         };
         _loc6_[BMMechStructure.CHARGE] = {
            "name":BMMechStructure.CHARGE,
            "total":1,
            "level":7
         };
         _loc6_[BMMechStructure.HARPOON] = {
            "name":BMMechStructure.HARPOON,
            "total":1,
            "level":5
         };
         _loc6_["mech2"] = {
            "name":"mech2",
            "total":2,
            "level":10
         };
         _loc6_["mech3"] = {
            "name":"mech3",
            "total":3,
            "level":10
         };
         _loc6_["module1"] = {
            "name":BMMechStructure.MODULE,
            "total":1,
            "level":2
         };
         _loc6_["module2"] = {
            "name":BMMechStructure.MODULE,
            "total":2,
            "level":3
         };
         _loc6_["module3"] = {
            "name":BMMechStructure.MODULE,
            "total":3,
            "level":5
         };
         _loc6_["module4"] = {
            "name":BMMechStructure.MODULE,
            "total":4,
            "level":8
         };
         _loc6_["module5"] = {
            "name":BMMechStructure.MODULE,
            "total":5,
            "level":11
         };
         _loc6_["module6"] = {
            "name":BMMechStructure.MODULE,
            "total":6,
            "level":12
         };
         _loc6_["module7"] = {
            "name":BMMechStructure.MODULE,
            "total":7,
            "level":13
         };
         _loc6_["module8"] = {
            "name":BMMechStructure.MODULE,
            "total":8,
            "level":14,
            "hide":true
         };
         _loc6_[BMMechStructure.PERK] = {
            "name":BMMechStructure.PERK,
            "total":1,
            "level":4
         };
         this.createEquipmentUnlockedDB(_loc6_);
         _loc7_ = new Array();
         _loc7_.push("a55"," anal","anal "," anus","anus ","ar5e","arrse","arse","ass","fukka","asshole","assholes","asswhole","a_s_s","b!tch","b00bs","b17ch");
         _loc7_.push("b1tch","ball","bastard","beastial","beastiality","bellend","bestial","bestiality","bi+ch","biatch","bitch","bloody","blow job","blowjob","blowjobs");
         _loc7_.push("boiolas","bollock","bollok","boner","boob","boobs","booobs","boooobs","booooobs","booooooobs","breasts","buceta","bugger","bum","butt");
         _loc7_.push("butthole","buttmuch","buttplug","c0ck","carpet muncher","cawk","chink","cipa","cl1t","cnut","cock","cok","cokmuncher","coksucka","coon","cox","crap");
         _loc7_.push("cum","cummer","cumming","cums","cumshot","cunilingus","cunillingus","cunnilingus","cunt","cuntlick","cuntlicker","cuntlicking","cunts","cyalis","cyberfuc");
         _loc7_.push("d1ck","damn","dick","dickhead","dildo","dildos","dink","dinks","dirsa","dlck");
         _loc7_.push("doggin","dogging","donkeyribber","doosh","duche","dyke","ejaculate","ejaculated","ejaculates","ejaculating","ejaculatings","ejaculation","ejakulate","f u c k");
         _loc7_.push("f u c k e r","f4nny","fag","fagging","faggitt","faggot","faggs","fagot","fagots","fags","fanny","fannyflaps","fanyy","fatass","fu ck","fcuk","fcuker");
         _loc7_.push("fcuking","feck","fecker","felching","fellate","fellatio");
         _loc7_.push("flange","fook","fooker","fuck","f uck","fucka","fucked","fucker");
         _loc7_.push("fudge packer","fudgepacker","fuk","fuker","fukker","dogystyle","dogy style","isis","sharia");
         _loc7_.push("fukkin","fuks","fukwhit","fukwit","fux","fux0r","f_u_c_k","gangbang","gangbanged","gangbangs","gaylord","gaysex","goatse","god-dam","god-damned","goddamn");
         _loc7_.push("goddamned","hardcoresex","heshe","hitler","hoar","hoare","hoer","homo","hore","horniest","horny","hotsex","jack-off","jackoff","jerk-off","jism","jiz");
         _loc7_.push("jizm","jizz","kawk","knob","knobead","knobed","knobend","knobhead","knobjocky","knobjokey","kock","kondum","kondums","kum","kummer","kumming","kums","kunilingus");
         _loc7_.push("l3i+ch","l3itch","labia","lmfao","lust","lusting","m0f0","m0fo","m45terbate","ma5terb8","ma5terbate","masochist","master-bate","masterb8","masterbat","masterbat3");
         _loc7_.push("motha","masterbate","masterbation","masterbations","masturbate","mo-fo","mof0","mofo","mother","mothafuck","mothafucka");
         _loc7_.push("muff","mutha","muthafecker","muthafuckker","muther","mutherfucker","n1gga","n1gger","nazi","nigg3r","nigg4h","nigga","niggah","niggas","niggaz","nigger","niggers");
         _loc7_.push("nob","nobhead","nobjocky","nobjokey","numbnuts","nutsack","orgasim","orgasims","orgasm","orgasms","p0rn","pawn","pecker","penis","phonesex","phuck","phuk");
         _loc7_.push("phuked","phuking","phukked","phukking","phuks","phuq","pigfucker","pimpis","piss","pissed","pisser","pissers","pisses","pissflaps","pissin","pissing","pissoff","poop");
         _loc7_.push("porn","porno","pornography","pornos","prick","pron","pube","pusse","pussi","pussies","pussy","rape","rapist","rectum","retard","rimjaw","rimming","s.o.b.","sadist","schlong","screwing");
         _loc7_.push("scroat","scrote","scrotum","semen","sex","sh!+","sh!t","sh1t","shag","shagger","shaggin","shagging","shemale","shit","shitdick","shite");
         _loc7_.push("shitfull","shithead","shiting","shits","shitted","shitter","shitting","shitty","skank","slut","sluts","smegma","smut","snatch","son-of-a-bitch","spac","spunk","s_h_i_t");
         _loc7_.push("t1tt1e5","t1tties","teets","teez","testical","testicle","tit ","tits","tittywank","titwank","tosser","turd");
         _loc7_.push("tw4t","twat","twathead","twatty","twunt","twunter","v14gra","v1gra","vagina","viagra","vulva","w00se","wang","wank","wanker","wanky","whoar","whore","willies","willy","xrated");
         _loc7_.push("arsch","ärsche","blödmann","bummsen","bumsen","fick","fotze","hosenpisser","hosenscheißer","hühnerficker","huhrensohn","hundeficker","idiot");
         _loc7_.push("judensau","kacke","kanacke","kanake","kanaken","kinderficker","kinderporno","lutscher","miststück","möse","muschi","nutte","pimmel","piss","sack");
         _loc7_.push("scheisse","schwanz","sieg heil","spasti","titten","volldepp","vollhorst","vollidiot","vollpfosten","vollspack","vollspacken","vollspasti","vorhaut","wichser");
         _loc7_.push("wixer","wixx");
         this.wordFilterDB = new Array();
         _loc1_ = 0;
         while(_loc1_ < _loc7_.length)
         {
            this.wordFilterDB.push({
               "badWord":_loc7_[_loc1_],
               "fix":"###"
            });
            _loc1_++;
         }
         this.computerNamesDB = new Array();
         this.computerNamesDB.push("Executor","X-Ray","Ilona Mark V","Terminator","Garbage Collector","TK 4022","Behemoth Mark 8","Diesel","Engine","Mass Breaker","Tornado","Deefus","Annihalator Mark 3","Defender Mark II","A-T-O-M","Air Strike","Meteor","Xond","A-Bot","Bullet Proof","Heat Blast","Desolator","Maximum Damage","Tech Pro","Detonator","A-R-D Mark 7","Lucky Shot","Metal Breaker","Pyro Blast","Gun Shot","ShotGun","Metro","TS 2K","Metalcrusher","Exterminator 4K","Disintegrator","RT model IV","Hellhound","Desert hunter","Hammer RX","Pathfinder 27X","Model 570X","Death v.II","Quaker","Scrape Yard 2K","The Machine","Destructor","Holster IV","Zed","BeanBag","Boomer","Glorious","BigBang VI","Gearcrusher 2K","Gizmo GT","OutDated Model","RustBucket","Overlord","F8 Crusher","MT-10K","R-Age Machine","Bio-NV","Magnificus","Spartacus XII","Solomon Miner","Goliath 6-cervo","Model1337","C4K-L1E 4K","F0SS1L M4kR","F41L-S4F3 ","W4R-D0G","Biotic-NV","Mode1337 ","Mikobox","Kane","Sentinel 9K","J.U.L.I.U.S"
         ,"Andrewid","Seth","Joebot","The Unknown","Alexander","Model X","MicroNuke","HellGate","End of the Line","Explosive Dust","Debree","Naplam Strike","Black Mirror","MacroBlast","ElectroQuake","Defence Magnet","Bunker","Rocket Slayer","Mass Detonator","Sparks","Sniper Mark X","Stomp Master","Laser Blade","Explosive Turret","HardCoded","Mythical Theory","Talok the Decayed","McEvil","Mechatron","Death Awakens","Evil Mechnival","Master of Metal","Sparkles Fairy");
      }
      
      public function isMandatoryMissionMapObject(param1:String) : Boolean
      {
         if(this.useHiddenBaseMap == false)
         {
            return true;
         }
         if(this.mandatoryMissionMapObjects[param1] == null)
         {
            return false;
         }
         return this.mandatoryMissionMapObjects[param1];
      }
      
      public function get useHiddenBaseMap() : Boolean
      {
         if(tutorialM.isTutorialActive())
         {
            if(this.myProfile.tutorialLevel < BMTutorialManager.TUTORIAL_LEVEL_MISSION1)
            {
               return false;
            }
         }
         return int(this.getGeneralSetting("hideBaseMaps",0)) == 1;
      }
      
      public function isDeprecatedItemGrpThatSupportsDecals(param1:String) : Boolean
      {
         switch(param1)
         {
            case "torso1002_1":
            case "torso1002_2":
            case "torso1002_3":
            case "torso1003_1":
            case "torso1003_2":
            case "torso1003_3":
            case "leg1003_1":
            case "leg1003_2":
            case "leg1003_3":
               return true;
            default:
               return false;
         }
      }
      
      public function updateLevelUpDB(param1:Object) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         this.levelUpDB = new Array();
         _loc2_ = 0;
         for each(_loc3_ in param1)
         {
            _loc2_++;
            this.levelUpDB[_loc2_] = _loc3_;
         }
         this.LEVEL_MAX = _loc2_;
      }
      
      public function getTokenPackageByID(param1:uint) : BMTokenPackage
      {
         var _loc2_:BMTokenPackage = null;
         var _loc3_:uint = 0;
         var _loc4_:BMTokenPackage = null;
         _loc3_ = 0;
         while(_loc3_ < this.allTokenPackages.length)
         {
            _loc4_ = this.allTokenPackages[_loc3_];
            if(_loc4_.packageID == param1)
            {
               _loc2_ = this.allTokenPackages[_loc3_];
               _loc3_ = this.allTokenPackages.length;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getTokensPackageByTokenSystemPackageID(param1:*) : BMTokenPackage
      {
         var _loc2_:BMTokenPackage = null;
         var _loc3_:uint = 0;
         var _loc4_:BMTokenPackage = null;
         _loc3_ = 0;
         while(_loc3_ < this.allTokenPackages.length)
         {
            _loc4_ = this.allTokenPackages[_loc3_];
            if(_loc4_.tokenSystemPackageID == param1)
            {
               _loc2_ = this.allTokenPackages[_loc3_];
               _loc3_ = this.allTokenPackages.length;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getTokenPackageByStarterPackID(param1:*) : *
      {
         var _loc2_:int = 0;
         var _loc3_:BMTokenPackage = null;
         _loc2_ = 0;
         while(_loc2_ < this.allTokenPackages.length)
         {
            _loc3_ = this.allTokenPackages[_loc2_];
            if(_loc3_.starterPackID == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function isPayingUser() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:BMPlayerProfile = null;
         _loc1_ = false;
         _loc2_ = this["player" + this.ONLINE_PLAYER_ID + "Profile"];
         if(_loc2_ != null && (_loc2_.tokens_supporter > 0 || _loc2_.tokensSpent > 0))
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function estimatedDollarsSpent() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:BMPlayerProfile = null;
         _loc1_ = 0;
         if(this.isPayingUser())
         {
            _loc2_ = this["player" + this.ONLINE_PLAYER_ID + "Profile"];
            _loc1_ = Math.ceil((_loc2_.tokens_supporter + _loc2_.tokensSpent) * 0.015);
         }
         return _loc1_;
      }
      
      public function hoursPlayed() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:BMPlayerProfile = null;
         _loc1_ = -1;
         _loc2_ = this["player" + this.ONLINE_PLAYER_ID + "Profile"];
         if(_loc2_.playTime > 0)
         {
            _loc1_ = Math.ceil(_loc2_.playTime / 3600);
         }
         return _loc1_;
      }
      
      public function hoursSinceRegistration() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:BMPlayerProfile = null;
         _loc1_ = -1;
         _loc2_ = this["player" + this.ONLINE_PLAYER_ID + "Profile"];
         if(_loc2_ != null && _loc2_.firstSessionDate > 0)
         {
            _loc1_ = Math.ceil((this.currentTime - _loc2_.firstSessionDate) / 3600);
         }
         return _loc1_;
      }
      
      public function daysSinceRegistration() : Number
      {
         return this.hoursSinceRegistration() / 24;
      }
      
      public function tryToUnpackMechAutomatically() : Boolean
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:BMMechStructure = null;
         if(this.myProfile.pendingStarterPackMech == 0)
         {
            return false;
         }
         _loc1_ = 0;
         _loc2_ = 1;
         while(_loc2_ <= 3)
         {
            _loc3_ = this.myPlayerData.mechStructures[_loc2_];
            if(_loc3_.isEmpty() != false)
            {
               _loc1_ = _loc2_;
               _loc2_ = 3;
            }
            _loc2_++;
         }
         if(_loc1_ == 0)
         {
            return false;
         }
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         this.unpackingMechManually = true;
         this.unpackingMechManually_mechID = _loc1_;
         this.makeSurePlayerCanEquipThisMech(_loc1_);
         remoteM.socketM.lobby_redeemStarterPackMech(_loc1_);
         return true;
      }
      
      public function finishUnpackingMechManually() : void
      {
         this.unpackingMechManually = false;
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(!screensM.isScreenOpened(BMScreensManager.SCR_MAIN_MENU))
         {
            screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_MAIN_MENU);
         }
         screensM.screensDirector.addLocationTask(BMScreensDirectorTask.LOCATION_WORKSHOP);
         if(this.unpackingMechManually_mechID > 1)
         {
            screensM.screensDirector.addUserActionTask(BMScreensDirectorTask.USER_ACTION_WORKSHOP_SWITCH_TO_MECH_X,{"mechID":this.unpackingMechManually_mechID});
         }
      }
      
      public function createBattleInterfaceToolTipDB() : void
      {
         this.battleInterfaceToolTipDB = {};
         this.battleInterfaceToolTipDB["HP"] = {
            "title":getSpecificText("tooltip_HP"),
            "text":getSpecificText("battleInterfaceTop_HPInfo")
         };
         this.battleInterfaceToolTipDB["energy"] = {
            "title":getSpecificText("tooltip_energy"),
            "text":getSpecificText("battleInterfaceTop_energyInfo")
         };
         this.battleInterfaceToolTipDB["heat"] = {
            "title":getSpecificText("tooltip_heat"),
            "text":getSpecificText("battleInterfaceTop_heatInfo")
         };
         this.battleInterfaceToolTipDB["bullets"] = {
            "title":getSpecificText("tooltip_bullets"),
            "text":getSpecificText("battleInterfaceTop_bulletsInfo")
         };
         this.battleInterfaceToolTipDB["rockets"] = {
            "title":getSpecificText("tooltip_rockets"),
            "text":getSpecificText("battleInterfaceTop_rocketsInfo")
         };
         this.battleInterfaceToolTipDB["resist1"] = {
            "title":getSpecificText("tooltip_resist1"),
            "text":getSpecificText("battleInterfaceTop_resist1Info")
         };
         this.battleInterfaceToolTipDB["resist2"] = {
            "title":getSpecificText("tooltip_resist2"),
            "text":getSpecificText("battleInterfaceTop_resist2Info")
         };
         this.battleInterfaceToolTipDB["resist3"] = {
            "title":getSpecificText("tooltip_resist3"),
            "text":getSpecificText("battleInterfaceTop_resist3Info")
         };
         this.battleInterfaceToolTipDB["AP"] = {
            "title":getSpecificText("battleInterfaceTop_actionPoints"),
            "color":"",
            "text":getSpecificText("battleInterfaceTop_actionPointsInfo")
         };
         this.battleInterfaceToolTipDB["level"] = {
            "title":getGeneralText("matchMakingLevel"),
            "color":"",
            "text":getGeneralText("matchMakingLevel")
         };
      }
      
      public function createInfoTextDB() : void
      {
         this.infoTextDB = {};
         this.infoTextDB["walkLeft"] = getSpecificText("battleInterfaceBottom_walkLeft");
         this.infoTextDB["walkRight"] = getSpecificText("battleInterfaceBottom_walkRight");
         this.infoTextDB["jumpLeft"] = getSpecificText("battleInterfaceBottom_jumpLeft");
         this.infoTextDB["jumpRight"] = getSpecificText("battleInterfaceBottom_jumpRight");
         this.infoTextDB["shutDown"] = getSpecificText("battleInterfaceBottom_shutDown");
         this.infoTextDB["droneActivate"] = getSpecificText("battleInterfaceBottom_droneActivate");
         this.infoTextDB["droneDeactivate"] = getSpecificText("battleInterfaceBottom_droneDeactivate");
         this.infoTextDB["shieldActivate"] = getSpecificText("battleInterfaceBottom_shieldActivate");
         this.infoTextDB["shieldDeactivate"] = getSpecificText("battleInterfaceBottom_shieldDeactivate");
         this.infoTextDB[BMMechStructure.CHARGE] = getSpecificText("battleInterfaceBottom_charge");
         this.infoTextDB[BMMechStructure.HARPOON] = getSpecificText("battleInterfaceBottom_harpoon");
         this.infoTextDB[BMMechStructure.TELEPORT] = getSpecificText("battleInterfaceBottom_teleport");
         this.infoTextDB["weapons"] = getSpecificText("battleInterfaceBottom_weapons");
         this.infoTextDB["movement"] = getSpecificText("battleInterfaceBottom_movement");
         this.infoTextDB["specials"] = getSpecificText("battleInterfaceBottom_specials");
         this.infoTextDB["kits"] = getSpecificText("battleInterfaceBottom_kits");
         this.infoTextDB["back"] = getSpecificText("battleInterfaceBottom_back");
         this.infoTextDB["cancel"] = getSpecificText("battleInterfaceBottom_cancel");
         this.infoTextDB["switchMech"] = getSpecificText("battleInterfaceBottom_switchMech");
         this.infoTextDB["selectMech"] = getSpecificText("battleInterfaceBottom_selectMech");
      }
      
      public function updateSubTypeNames() : void
      {
         var _loc1_:Object = null;
         for each(_loc1_ in this.subTypeDB)
         {
            _loc1_.text = getSpecificText("shop_" + _loc1_.name);
         }
         for each(_loc1_ in this.subTypeDB_myth)
         {
            _loc1_.text = getSpecificText("shop_" + _loc1_.name);
         }
         for each(_loc1_ in this.subTypeDB_combined)
         {
            _loc1_.text = getSpecificText("shop_" + _loc1_.name);
         }
      }
      
      public function updateBoostNames() : void
      {
         var _loc1_:BMBoostData = null;
         _loc1_ = new BMBoostData();
         _loc1_ = this.boostsDB[2];
         _loc1_.boostName = getSpecificText("packages_bronze");
         _loc1_ = this.boostsDB[3];
         _loc1_.boostName = getSpecificText("packages_silver");
         _loc1_ = this.boostsDB[4];
         _loc1_.boostName = getSpecificText("packages_gold");
         _loc1_ = this.boostsDB[9];
         _loc1_.boostName = getSpecificText("packages_itemsBox");
         _loc1_ = this.boostsDB[5];
         _loc1_.boostName = getSpecificText("packages_itemsBoxSilver");
         _loc1_ = this.boostsDB[6];
         _loc1_.boostName = getSpecificText("packages_itemsBoxGold");
         _loc1_ = this.boostsDB[11];
         _loc1_.boostName = getSpecificText("packages_itemsBox");
         _loc1_ = this.boostsDB[12];
         _loc1_.boostName = getSpecificText("packages_itemsBox");
         _loc1_ = this.boostsDB[19];
         _loc1_.boostName = getSpecificText("packages_itemsBoxMythical");
         _loc1_ = this.boostsDB[20];
         _loc1_.boostName = getSpecificText("packages_itemsBoxMythical");
         _loc1_ = this.boostsDB[8];
         _loc1_.boostName = getSpecificText("packages_premiumAccount");
         _loc1_ = this.boostsDB[10];
         _loc1_.boostName = getSpecificText("packages_premiumAccount");
         _loc1_ = this.boostsDB[1];
         _loc1_.boostName = getSpecificText("packages_premiumAccount");
      }
      
      public function createHelpData() : void
      {
         this.helpDB = new Array();
         this.helpDB.push({
            "type":"costEnergy",
            "name":getSpecificText("help_energyWeaponsTitle"),
            "tip":getSpecificText("help_energyWeapons")
         });
         this.helpDB.push({
            "type":"costBullets",
            "name":getSpecificText("help_bulletWeaponsTitle"),
            "tip":getSpecificText("help_bulletWeapons")
         });
         this.helpDB.push({
            "type":"costRockets",
            "name":getSpecificText("help_rocketWeaponsTitle"),
            "tip":getSpecificText("help_rocketWeapons")
         });
         this.helpDB.push({
            "type":"costHeat",
            "name":getSpecificText("tooltip_heat"),
            "tip":getSpecificText("help_heatDamage")
         });
         this.helpDB.push({
            "type":"range",
            "name":getSpecificText("tooltip_range"),
            "tip":getSpecificText("help_range")
         });
         this.helpDB.push({
            "type":"shutdown",
            "name":getSpecificText("help_shutdownTitle"),
            "tip":getSpecificText("help_shutdown")
         });
         this.helpDB.push({
            "type":BMMechStructure.DRONE,
            "name":getSpecificText("help_droneTitle"),
            "tip":getSpecificText("help_drone")
         });
         this.helpDB.push({
            "type":BMMechStructure.SHIELD,
            "name":getSpecificText("help_shieldTitle"),
            "tip":getSpecificText("help_shield")
         });
         this.helpDB.push({
            "type":BMMechStructure.CHARGE,
            "name":getSpecificText("help_chargeTitle"),
            "tip":getSpecificText("help_charge")
         });
         this.helpDB.push({
            "type":BMMechStructure.TELEPORT,
            "name":getSpecificText("help_teleportTitle"),
            "tip":getSpecificText("help_teleport")
         });
         this.helpDB.push({
            "type":BMMechStructure.HARPOON,
            "name":getSpecificText("help_harpoonTitle"),
            "tip":getSpecificText("help_harpoon")
         });
         this.helpDB.push({
            "type":"physicalDamage",
            "name":getSpecificText("tooltip_physicalDamage"),
            "tip":getSpecificText("help_physicalDamage")
         });
         this.helpDB.push({
            "type":"explosiveDamage",
            "name":getSpecificText("tooltip_explosiveDamage"),
            "tip":getSpecificText("help_explosiveDamage")
         });
         this.helpDB.push({
            "type":"electricDamage",
            "name":getSpecificText("tooltip_electricDamage"),
            "tip":getSpecificText("help_electricDamage")
         });
         this.helpDB.push({
            "type":"resistPhysical",
            "name":getSpecificText("tooltip_resist1"),
            "tip":getSpecificText("help_resist1")
         });
         this.helpDB.push({
            "type":"resistExplosive",
            "name":getSpecificText("tooltip_resist2"),
            "tip":getSpecificText("help_resist2")
         });
         this.helpDB.push({
            "type":"resistElectric",
            "name":getSpecificText("tooltip_resist3"),
            "tip":getSpecificText("help_resist3")
         });
      }
      
      public function createMusicData() : void
      {
         this.musicDB = new Array();
         this.musicDB.push({
            "base":"music3",
            "loop":"music3"
         });
         this.musicDB.push({
            "base":"music4",
            "loop":"music4"
         });
         this.musicDB.push({
            "base":"music5",
            "loop":"music5"
         });
         this.musicDB.push({
            "base":"music6",
            "loop":"music6"
         });
         this.musicDB.push({
            "base":"music7",
            "loop":"music7"
         });
         this.musicDB.push({
            "base":"music2",
            "loop":"music2"
         });
         this.musicDB.push({
            "base":"music8_base",
            "loop":"music8_loop"
         });
         this.musicDB.push({
            "base":"music9_base",
            "loop":"music9_loop"
         });
      }
      
      public function createPowerLevelsDB() : void
      {
         this.powerLevelsDB_regular = new Array();
         this.powerLevelsDB_regular[1] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,30,60,120,240,480,960,1920,3840,7680,15360,23040,30720,38400,46080,53760]
         };
         this.powerLevelsDB_regular[2] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,30,60,120,240,480,960,1920,3840,7680,15360,23040,30720,38400,46080,53760]
         };
         this.powerLevelsDB_regular[3] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,30,60,120,240,480,960,1920,3840,7680,15360,23040,30720,38400,46080,53760]
         };
         this.powerLevelsDB_regular[4] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,40,80,160,320,640,1280,2560,5120,10240,20480,30720,40960,51200,61440,71680]
         };
         this.powerLevelsDB_regular[5] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,50,100,200,400,800,1600,3200,6400,12800,25600,38400,51200,64000,76800,89600]
         };
         this.powerLevelsDB_regular[6] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,60,120,240,480,960,1920,3840,7680,15360,30720,46080,61440,76800,92160,107520]
         };
         this.powerLevelsDB_regular[7] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,70,140,280,560,1120,2240,4480,8960,17920,35840,53760,71680,89600,107520,125440]
         };
         this.powerLevelsDB_regular[8] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,80,160,320,640,1280,2560,5120,10240,20480,40960,61440,81920,102400,122880,143360]
         };
         this.powerLevelsDB_regular[9] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,90,180,360,720,1440,2880,5760,11520,23040,46080,69120,92160,115200,138240,161280]
         };
         this.powerLevelsDB_regular[10] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,100,200,400,800,1600,3200,6400,12800,25600,51200,76800,102400,128000,153600,179200]
         };
         this.powerLevelsDB_regular[11] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,110,220,440,880,1760,3520,7040,14080,28160,56320,84480,112640,140800,168960,197120]
         };
         this.powerLevelsDB_regular[12] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,120,240,480,960,1920,3840,7680,15360,30720,61440,92160,122880,153600,184320,215040]
         };
         this.powerLevelsDB_regular[13] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,130,260,520,1040,2080,4160,8320,16640,33280,66560,99840,133120,166400,199680,232960]
         };
         this.powerLevelsDB_regular[14] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,140,280,560,1120,2240,4480,8960,17920,35840,71680,107520,143360,179200,215040,250880]
         };
         this.powerLevelsDB_regular[15] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,150,300,600,1200,2400,4800,9600,19200,38400,76800,115200,153600,192000,230400,268800]
         };
         this.powerLevelsDB_regular[16] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,160,320,640,1280,2560,5120,10240,20480,40960,81920,122880,163840,204800,245760,286720]
         };
         this.powerLevelsDB_regular[17] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,170,340,680,1360,2720,5440,10880,21760,43520,87040,130560,174080,217600,261120,304640]
         };
         this.powerLevelsDB_regular[18] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,180,360,720,1440,2880,5760,11520,23040,46080,92160,138240,184320,230400,276480,322560]
         };
         this.powerLevelsDB_regular[19] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,190,380,760,1520,3040,6080,12160,24320,48640,97280,145920,194560,243200,291840,340480]
         };
         this.powerLevelsDB_regular[20] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,200,400,800,1600,3200,6400,12800,25600,51200,102400,153600,204800,256000,307200,358400]
         };
         this.powerLevelsDB_regular[21] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,210,420,840,1680,3360,6720,13440,26880,53760,107520,161280,215040,268800,322560,376320]
         };
         this.powerLevelsDB_regular[22] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,220,440,880,1760,3520,7040,14080,28160,56320,112640,168960,225280,281600,337920,394240]
         };
         this.powerLevelsDB_regular[23] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,230,460,920,1840,3680,7360,14720,29440,58880,117760,176640,235520,294400,353280,412160]
         };
         this.powerLevelsDB_regular[24] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,240,480,960,1920,3840,7680,15360,30720,61440,122880,184320,245760,307200,368640,430080]
         };
         this.powerLevelsDB_regular[25] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,250,500,1000,2000,4000,8000,16000,32000,64000,128000,192000,256000,320000,384000,448000]
         };
         this.powerLevelsDB_regular[26] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,260,520,1040,2080,4160,8320,16640,33280,66560,133120,199680,266240,332800,399360,465920]
         };
         this.powerLevelsDB_regular[27] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,270,540,1080,2160,4320,8640,17280,34560,69120,138240,207360,276480,345600,414720,483840]
         };
         this.powerLevelsDB_regular[28] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,280,560,1120,2240,4480,8960,17920,35840,71680,143360,215040,286720,358400,430080,501760]
         };
         this.powerLevelsDB_regular[29] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,290,580,1160,2320,4640,9280,18560,37120,74240,148480,222720,296960,371200,445440,519680]
         };
         this.powerLevelsDB_regular[30] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,300,600,1200,2400,4800,9600,19200,38400,76800,153600,230400,307200,384000,460800,537600]
         };
         this.powerLevelsDB_regular[31] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,300,600,1200,2400,4800,9600,19200,38400,76800,153600,230400,307200,384000,460800,537600]
         };
         this.powerLevelsDB_regular[32] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,300,600,1200,2400,4800,9600,19200,38400,76800,153600,230400,307200,384000,460800,537600]
         };
         this.powerLevelsDB_regular[33] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,300,600,1200,2400,4800,9600,19200,38400,76800,153600,230400,307200,384000,460800,537600]
         };
         this.powerLevelsDB_regular[34] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,300,600,1200,2400,4800,9600,19200,38400,76800,153600,230400,307200,384000,460800,537600]
         };
         this.powerLevelsDB_regular[35] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,300,600,1200,2400,4800,9600,19200,38400,76800,153600,230400,307200,384000,460800,537600]
         };
         this.powerLevelsDB_regular[36] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,300,600,1200,2400,4800,9600,19200,38400,76800,153600,230400,307200,384000,460800,537600]
         };
         this.powerLevelsDB_special = new Array();
         this.powerLevelsDB_special[1] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,60,240,960,3840,15360]
         };
         this.powerLevelsDB_special[2] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,60,240,960,3840,15360]
         };
         this.powerLevelsDB_special[3] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,60,240,960,3840,15360]
         };
         this.powerLevelsDB_special[4] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,80,320,1280,5120,20480]
         };
         this.powerLevelsDB_special[5] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,100,400,1600,6400,25600]
         };
         this.powerLevelsDB_special[6] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,120,480,1920,7680,30720]
         };
         this.powerLevelsDB_special[7] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,140,560,2240,8960,35840]
         };
         this.powerLevelsDB_special[8] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,160,640,2560,10240,40960]
         };
         this.powerLevelsDB_special[9] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,180,720,2880,11520,46080]
         };
         this.powerLevelsDB_special[10] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,200,800,3200,12800,51200]
         };
         this.powerLevelsDB_special[11] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,220,880,3520,14080,56320]
         };
         this.powerLevelsDB_special[12] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,240,960,3840,15360,61440]
         };
         this.powerLevelsDB_special[13] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,260,1040,4160,16640,66560]
         };
         this.powerLevelsDB_special[14] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,280,1120,4480,17920,71680]
         };
         this.powerLevelsDB_special[15] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,300,1200,4800,19200,76800]
         };
         this.powerLevelsDB_special[16] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,320,1280,5120,20480,81920]
         };
         this.powerLevelsDB_special[17] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,340,1360,5440,21760,87040]
         };
         this.powerLevelsDB_special[18] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,360,1440,5760,23040,92160]
         };
         this.powerLevelsDB_special[19] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,380,1520,6080,24320,97280]
         };
         this.powerLevelsDB_special[20] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,400,1600,6400,25600,102400]
         };
         this.powerLevelsDB_special[21] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,420,1680,6720,26880,107520]
         };
         this.powerLevelsDB_special[22] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,440,1760,7040,28160,112640]
         };
         this.powerLevelsDB_special[23] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,460,1840,7360,29440,117760]
         };
         this.powerLevelsDB_special[24] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,480,1920,7680,30720,122880]
         };
         this.powerLevelsDB_special[25] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,500,2000,8000,32000,128000]
         };
         this.powerLevelsDB_special[26] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,520,2080,8320,33280,133120]
         };
         this.powerLevelsDB_special[27] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,540,2160,8640,34560,138240]
         };
         this.powerLevelsDB_special[28] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,560,2240,8960,35840,143360]
         };
         this.powerLevelsDB_special[29] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,580,2320,9280,37120,148480]
         };
         this.powerLevelsDB_special[30] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,600,2400,9600,38400,153600]
         };
         this.powerLevelsDB_special[31] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,600,2400,9600,38400,153600]
         };
         this.powerLevelsDB_special[32] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,600,2400,9600,38400,153600]
         };
         this.powerLevelsDB_special[33] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,600,2400,9600,38400,153600]
         };
         this.powerLevelsDB_special[34] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,600,2400,9600,38400,153600]
         };
         this.powerLevelsDB_special[35] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,600,2400,9600,38400,153600]
         };
         this.powerLevelsDB_special[36] = {
            "bonusHP":5,
            "bonusDamage":1,
            "bonusRepair":1,
            "power":[0,0,600,2400,9600,38400,153600]
         };
      }
      
      public function createEquipmentUnlockedDB(param1:Object) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Object = null;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         this.equipmentUnlockDB = param1;
         this.SECOND_MECH_UNLOCK_LEVEL = this.equipmentUnlockDB["mech2"].level;
         this.equipmentUnlockByLevelDB = new Array();
         _loc2_ = 0;
         for each(_loc3_ in this.equipmentUnlockDB)
         {
            switch(_loc3_.name)
            {
               case "mech1":
               case "mech2":
               case "mech3":
                  break;
               default:
                  if(_loc3_.level < 99)
                  {
                     if(_loc2_ < _loc3_.level)
                     {
                        _loc2_ = uint(_loc3_.level);
                     }
                  }
            }
         }
         _loc4_ = 1;
         while(_loc4_ <= _loc2_)
         {
            this.equipmentUnlockByLevelDB[_loc4_] = {};
            this.equipmentUnlockByLevelDB[_loc4_].sideWeapon = 0;
            this.equipmentUnlockByLevelDB[_loc4_].topWeapon = 0;
            this.equipmentUnlockByLevelDB[_loc4_].drone = 0;
            this.equipmentUnlockByLevelDB[_loc4_].shield = 0;
            this.equipmentUnlockByLevelDB[_loc4_].teleport = 0;
            this.equipmentUnlockByLevelDB[_loc4_].charge = 0;
            this.equipmentUnlockByLevelDB[_loc4_].harpoon = 0;
            this.equipmentUnlockByLevelDB[_loc4_].module = 0;
            this.equipmentUnlockByLevelDB[_loc4_].kit = 0;
            for each(_loc3_ in this.equipmentUnlockDB)
            {
               if(_loc4_ >= _loc3_.level)
               {
                  _loc5_ = _loc3_.name;
                  if(this.equipmentUnlockByLevelDB[_loc4_][_loc5_] < _loc3_.total)
                  {
                     this.equipmentUnlockByLevelDB[_loc4_][_loc5_] = _loc3_.total;
                  }
               }
            }
            _loc4_++;
         }
      }
      
      public function getEquipmentUnlockByLevel(param1:uint, param2:String) : uint
      {
         var _loc3_:uint = 0;
         _loc3_ = 0;
         if(this.equipmentUnlockByLevelDB[param1] != null)
         {
            _loc3_ = uint(this.equipmentUnlockByLevelDB[param1][param2]);
         }
         else
         {
            _loc3_ = uint(this.equipmentUnlockByLevelDB[this.equipmentUnlockByLevelDB.length - 1][param2]);
         }
         return _loc3_;
      }
      
      public function getEquipmentUnlockedListAtLevel(param1:uint) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:Object = null;
         _loc2_ = new Array();
         for each(_loc3_ in this.equipmentUnlockDB)
         {
            if(_loc3_.level == param1)
            {
               _loc2_.push(_loc3_.name);
            }
         }
         return _loc2_;
      }
      
      public function getNumberOfMechsUnlocked() : uint
      {
         var _loc1_:Number = NaN;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         _loc1_ = this.myProfile.level;
         _loc2_ = 1;
         _loc3_ = 2;
         while(_loc3_ <= this.inventoryMaxMechs)
         {
            _loc4_ = "mech" + _loc3_;
            if(this.equipmentUnlockDB.hasOwnProperty(_loc4_))
            {
               _loc5_ = uint(this.equipmentUnlockDB[_loc4_].level);
               if(_loc1_ >= _loc5_)
               {
                  _loc2_ += 1;
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function makeSurePlayerCanEquipThisItem(param1:String, param2:uint) : void
      {
         var _loc3_:uint = 0;
         if(BMUnlockedMechSlotsResolver.areMechSlotsUnlockedByCampaign())
         {
            return;
         }
         _loc3_ = this.getEquipmentUnlockByLevel(this.myProfile.level,param1);
         if(param2 > _loc3_ || param2 == 0 && _loc3_ == 0)
         {
            if(this.equipmentUnlockDB.hasOwnProperty(param1))
            {
               this.equipmentUnlockDB[param1].level = Math.min(this.equipmentUnlockDB[param1].level,this.myProfile.level);
            }
            else if(this.equipmentUnlockByLevelDB.hasOwnProperty(this.myProfile.level))
            {
               this.equipmentUnlockByLevelDB[this.myProfile.level][param1] = param2;
            }
         }
      }
      
      public function makeSurePlayerCanEquipThisMech(param1:uint) : void
      {
         var _loc2_:String = null;
         if(BMUnlockedMechSlotsResolver.areMechSlotsUnlockedByCampaign())
         {
            return;
         }
         _loc2_ = "mech" + param1;
         if(this.equipmentUnlockDB.hasOwnProperty("mech" + param1))
         {
            this.equipmentUnlockDB[_loc2_].level = Math.min(this.myProfile.level,this.equipmentUnlockDB[_loc2_].level);
            this.SECOND_MECH_UNLOCK_LEVEL = Math.min(this.myProfile.level,this.SECOND_MECH_UNLOCK_LEVEL);
         }
      }
      
      public function isWheels(param1:BMItemData) : Boolean
      {
         if(param1.type == BMMechStructure.LEG && (param1.grp.substr(0,6) == "wheels" || param1.grp.substr(0,7) == "leg1002" || param1.grp.substr(0,7) == "leg1003"))
         {
            return true;
         }
         return false;
      }
      
      private function overwriteColorsDB() : void
      {
      }
      
      public function getBoostGoldCost(param1:uint) : uint
      {
         var _loc2_:BMBoostData = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = this.boostsDB[param1];
         _loc3_ = _loc2_.costGold;
         if(_loc2_.costGoldMaxLevel > 0)
         {
            _loc4_ = uint(this.myProfile.level);
            if(_loc4_ >= 3)
            {
               _loc4_ -= 3;
            }
            else
            {
               _loc4_ = 0;
            }
            _loc3_ += Math.ceil(_loc4_ / (this.LEVEL_MAX - 3) * (_loc2_.costGoldMaxLevel - _loc2_.costGold));
            _loc3_ = Math.ceil(_loc3_ / 250) * 250;
         }
         return _loc3_;
      }
      
      public function getAchievmentDescriptionText(param1:Object) : String
      {
         var _loc2_:String = null;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         if(param1.requirement > 1)
         {
            if(param1.type == "highestLadderProgress")
            {
               _loc3_ = this.getLadderRankByProgress(param1.requirement);
            }
            else
            {
               _loc3_ = Number(param1.requirement);
            }
            _loc4_ = getSpecificText("achievements_" + param1.type);
            _loc2_ = this.replaceStringInText(_loc4_,"%AMOUNT%",TextUtils.getNumberWithComma(_loc3_));
         }
         else
         {
            switch(param1.type)
            {
               case "chargeKills":
               case "droneKills":
               case "teleportKills":
               case "harpoonKills":
               case "swordCombos":
               case "shotgunCombos":
               case "stompCombos":
               case "machineGunCombos":
               case "flameThrowerCombos":
                  _loc2_ = getSpecificText("achievements_" + param1.type + "_1");
                  break;
               default:
                  _loc2_ = getSpecificText("achievements_" + param1.type);
            }
         }
         return _loc2_;
      }
      
      public function sortAchievements() : void
      {
         var _loc1_:Object = null;
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         this.achievementsSortedDB = {};
         for each(_loc1_ in this.achievementsDB)
         {
            _loc2_ = _loc1_.type;
            _loc3_ = uint(_loc1_.level);
            if(this.achievementsSortedDB[_loc2_] == null)
            {
               this.achievementsSortedDB[_loc2_] = new Array();
            }
            this.achievementsSortedDB[_loc2_][_loc3_] = _loc1_.achievementID;
         }
      }
      
      public function isStarterPackActive() : Boolean
      {
         var _loc1_:BMPlayerProfile = null;
         if(FeatureFlags.BLOCK_SPECIAL_OFFERS)
         {
            return false;
         }
         if(loginM.isConnected == false)
         {
            return false;
         }
         _loc1_ = this.myProfile;
         if(_loc1_ == null)
         {
            return false;
         }
         if(_loc1_.starterPackData == null)
         {
            return false;
         }
         if(_loc1_.starterPackData.packID == 0)
         {
            return false;
         }
         if(_loc1_.starterPackData.starterPackStatus > 0)
         {
            return false;
         }
         if(BMBuyStarterPackScreenChooser.isStarterPackLegit() == false)
         {
            return false;
         }
         if(tutorialM.isTutorialActive())
         {
            return false;
         }
         return true;
      }
      
      public function isPostMythicalStarterPackActive() : Boolean
      {
         if(!loginM.isConnected)
         {
            return false;
         }
         if(tutorialM.isTutorialActive())
         {
            return false;
         }
         if(!this.hasPlayerProfile)
         {
            return false;
         }
         return this.myProfile.postMythicalStarterPackData.packID > 0 && this.myProfile.postMythicalStarterPackData.starterPackStatus == 0;
      }
      
      public function updateStarterPackActive() : void
      {
         var _loc1_:BMPlayerProfile = null;
         _loc1_ = this.myProfile;
         if(this.isStarterPackActive() == false)
         {
            return;
         }
         if(_loc1_.starterPackData.starterPackStartDate == 0)
         {
            remoteM.socketM.lobby_setStarterPackStartDate();
            _loc1_.starterPackData.starterPackStartDate = this.currentTime;
         }
         if(_loc1_.starterPackData.starterPackStartDate + _loc1_.starterPackData.offerDuration <= this.currentTime)
         {
            remoteM.socketM.lobby_setStarterPackTimeOut();
            _loc1_.starterPackData.starterPackStatus = 3;
         }
      }
      
      public function updateProfileStarterPackData() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:uint = 0;
         var _loc3_:BMTokenPackage = null;
         if(this.myProfile.starterPackData.tokenPackageID == 0)
         {
            _loc1_ = false;
            _loc2_ = 0;
            while(_loc2_ < this.allTokenPackages.length)
            {
               _loc3_ = this.allTokenPackages[_loc2_];
               if(_loc3_.starterPackID == this.myProfile.starterPackData.packID)
               {
                  this.myProfile.starterPackData.tokenPackageID = _loc3_.packageID;
                  this.myProfile.starterPackData.bonusTokens = _loc3_.tokens;
                  this.myProfile.starterPackData.price = _loc3_.price;
                  _loc1_ = true;
                  break;
               }
               _loc2_++;
            }
            if(!_loc1_)
            {
               TsLogger.log("BMDataManager :: updateProfileStarterPackData ERROR could not find starterPackID " + this.myProfile.starterPackData.packID + " in allTokenPackages");
            }
         }
      }
      
      public function areMechsReadyForBattle(param1:uint = 1) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         _loc2_ = true;
         _loc4_ = 1;
         while(_loc4_ <= param1)
         {
            if(this.isMechReadyForBattle(_loc4_) == false)
            {
               _loc2_ = false;
               _loc4_ = param1;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function isMechReadyForBattle(param1:uint, param2:Number = -1) : Boolean
      {
         var _loc3_:BMPlayerData = null;
         var _loc4_:BMMechStructure = null;
         if(param2 == -1)
         {
            param2 = this.player1PlayerID;
         }
         _loc3_ = this.playersData[param2];
         if(_loc3_ == null)
         {
            return false;
         }
         _loc4_ = _loc3_.mechStructures[param1];
         return this.isMechStructureReadyForBattle(_loc4_);
      }
      
      public function isMechStructureReadyForBattle(param1:BMMechStructure) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return this.mechMissingPartsForBattle(param1).length == 0;
      }
      
      public function startedBattleVSComputer(param1:Number, param2:Vector.<BMMechStructure>, param3:Number, param4:Boolean = false, param5:int = -1, param6:int = -1, param7:Array = null) : void
      {
         var _loc8_:int = 0;
         if(param5 > -1)
         {
            this.battleData.player1.currentStep = param5;
            this.battleData.player2.currentStep = param6;
         }
         this.computerBattleID = param1;
         this.computerMechStructures = param2;
         this.computerDifficultyMultiplier = param3;
         this.computerActions = param7;
         this.battle_syncRandom = new SyncRandom(param1);
         this.battleMechsPerPlayer = this.computerMechStructures.length;
         if(this.computerMechStructures != null)
         {
            _loc8_ = 0;
            while(_loc8_ < this.computerMechStructures.length)
            {
               this.computerMechStructures[_loc8_].playerID = this.LOCAL_OPPONENT_ID;
               _loc8_++;
            }
         }
         this.startBattleVsComputer_phase2();
      }
      
      public function startedBattleVSComputerFailed() : void
      {
         var _loc1_:Function = null;
         if(this.computerStartBattleSuccessHandler != null)
         {
            _loc1_ = this.computerStartBattleSuccessHandler;
            this.computerStartBattleSuccessHandler = null;
            _loc1_(false);
         }
      }
      
      public function removeFriendship(param1:Number) : void
      {
         var _loc2_:Object = null;
         var _loc3_:BMFriendshipData = null;
         _loc2_ = {};
         for each(_loc3_ in this.friendsDB)
         {
            if(_loc3_.friendshipID != param1)
            {
               _loc2_[_loc3_.friendshipID] = _loc3_;
            }
         }
         this.friendsDB = _loc2_;
      }
      
      public function addNewFriendship(param1:Number) : void
      {
         var _loc2_:BMFriendshipData = null;
         _loc2_ = new BMFriendshipData();
         _loc2_.playerID = 0;
         _loc2_.playerName = this.tryToAddFriend_username;
         _loc2_.friendshipSentByMe = true;
         _loc2_.friendshipID = param1;
         _loc2_.friendshipStatus = 0;
         _loc2_.overallRank = 1;
         _loc2_.XP = 1;
         _loc2_.level = 1;
         this.friendsDB[_loc2_.friendshipID] = _loc2_;
      }
      
      public function addFriendship(param1:Object) : void
      {
         var _loc2_:BMFriendshipData = null;
         var _loc3_:BMPlayerProfile = null;
         _loc2_ = new BMFriendshipData();
         _loc3_ = this["player" + this.ONLINE_PLAYER_ID + "Profile"];
         if(_loc3_.playerName == param1.playerName1)
         {
            _loc2_.playerName = param1.playerName2;
            _loc2_.friendshipSentByMe = true;
         }
         else
         {
            _loc2_.playerName = param1.playerName1;
            _loc2_.friendshipSentByMe = false;
         }
         _loc2_.friendshipID = param1.friendshipID;
         _loc2_.friendshipStatus = param1.status;
         _loc2_.playerID = param1.friendData.playerID;
         _loc2_.overallRank = param1.friendData.overallRank;
         _loc2_.XP = param1.friendData.XP;
         _loc2_.level = param1.friendData.level;
         if(param1.friendData.facebook == 1)
         {
            _loc2_.facebook = true;
         }
         if(param1.friendData.isOnline == 1)
         {
            _loc2_.isOnline = true;
         }
         this.friendsDB[_loc2_.friendshipID] = _loc2_;
      }
      
      public function isMyClanMember(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:BMPlayerProfile = null;
         var _loc4_:uint = 0;
         var _loc5_:BMClanMemberData = null;
         _loc2_ = false;
         _loc3_ = this["player" + this.player1PlayerID + "Profile"];
         if(_loc3_.clanID > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.clanMembers)
            {
               _loc5_ = _loc3_.clanData.members[_loc4_];
               if(_loc5_.playerID == param1)
               {
                  _loc2_ = true;
                  _loc4_ = uint(_loc3_.clanMembers);
               }
               _loc4_++;
            }
         }
         return _loc2_;
      }
      
      public function isMyFriend(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:BMFriendshipData = null;
         _loc2_ = false;
         for each(_loc3_ in this.friendsDB)
         {
            if(_loc3_.playerID == param1)
            {
               if(_loc3_.friendshipStatus == 1)
               {
                  _loc2_ = true;
               }
            }
         }
         return _loc2_;
      }
      
      public function friendOnline(param1:Number, param2:Boolean) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:BMFriendshipData = null;
         _loc3_ = false;
         if(param1 != this.userID)
         {
            for each(_loc4_ in this.friendsDB)
            {
               if(_loc3_ == false)
               {
                  if(_loc4_.playerID == param1)
                  {
                     _loc4_.isOnline = param2;
                     if(_loc4_.isOnline == false)
                     {
                        _loc4_.battleInvitation = false;
                     }
                     _loc3_ = true;
                  }
               }
            }
         }
      }
      
      public function updateUsersStatistics(param1:Object, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         this.usersOnline = param1;
         this.usersInBattle_ladder = param2;
         this.usersInBattle_invitation = param3;
         this.usersInBattle_computer = param4;
         this.usersSearching = param5;
      }
      
      public function getSecondsLeftToLeagueEnding() : Number
      {
         var _loc1_:Number = NaN;
         _loc1_ = int(this.nextWeeklyReset) - this.currentTime;
         return Math.max(0,_loc1_);
      }
      
      public function getLowestLadderRank() : uint
      {
         return this.getLadderRankByProgress(1);
      }
      
      public function showRankingListPosition() : Boolean
      {
         if(this.gameType != GAME_TYPE_REPLAY && this.getLadderRankByProgress(this.myProfile.ladderProgress) == 1)
         {
            return true;
         }
         return false;
      }
      
      public function getLadderRankIconNumber(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         _loc2_ = 1;
         if(this.ladderRankIconsDB[param1] != null)
         {
            _loc2_ = Number(this.ladderRankIconsDB[param1]);
         }
         return _loc2_;
      }
      
      public function createLadderProgressData() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Boolean = false;
         var _loc5_:uint = 0;
         this.ladderProgressBasePerRank = new Array();
         this.ladderProgressMaxByRank = new Array();
         this.totalStarsPerLadderProgressList = new Array();
         _loc1_ = 0;
         _loc2_ = 1;
         while(_loc2_ < this.rankPerLadderProgressList.length)
         {
            _loc3_ = uint(this.rankPerLadderProgressList[_loc2_]);
            _loc4_ = false;
            if(this.ladderProgressBasePerRank[_loc3_] == null)
            {
               this.ladderProgressBasePerRank[_loc3_] = _loc2_;
               _loc4_ = true;
            }
            else if(_loc2_ == this.rankPerLadderProgressList.length - 1)
            {
               this.ladderProgressMaxByRank[1] = _loc2_;
            }
            else
            {
               _loc5_ = uint(this.rankPerLadderProgressList[_loc2_ + 1]);
               if(_loc5_ < _loc3_)
               {
                  this.ladderProgressMaxByRank[_loc3_] = _loc2_;
               }
            }
            if(_loc4_ == false)
            {
               _loc1_++;
            }
            this.totalStarsPerLadderProgressList[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      public function getLadderRankByProgress(param1:uint) : uint
      {
         if(this.rankPerLadderProgressList == null || param1 == 0)
         {
            return 25;
         }
         return this.rankPerLadderProgressList[param1];
      }
      
      public function getLadderProgressMaxByRank(param1:uint) : uint
      {
         if(this.ladderProgressMaxByRank == null)
         {
            return 3;
         }
         return this.ladderProgressMaxByRank[param1];
      }
      
      public function getLadderProgressBaseByRank(param1:uint) : uint
      {
         if(this.ladderProgressBasePerRank == null)
         {
            return 1;
         }
         return this.ladderProgressBasePerRank[param1];
      }
      
      public function setLadderSeasonEndRewardsData(param1:Array) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:BMLadderSeasonEndRewardData = null;
         this.ladderSeasonEndRewardsData = new Array();
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = new BMLadderSeasonEndRewardData(_loc2_,param1.length,param1[_loc2_].groupName,param1[_loc2_].ladderLevelRequired,param1[_loc2_].rewardGachaMachineIDs);
            this.ladderSeasonEndRewardsData.push(_loc3_);
            _loc2_++;
         }
         this.ladderSeasonEndRewardsData.sortOn("ladderLevelRequired",Array.NUMERIC | Array.DESCENDING);
      }
      
      public function updatePlayerPositionInLadderSeasonEndRewards() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:BMLadderSeasonEndRewardData = null;
         var _loc4_:BMLadderSeasonEndRewardData = null;
         if(this.myProfile.currentSeasonHighestLadderProgress == 0)
         {
            this.myProfile.currentSeasonHighestLadderProgress = 1;
         }
         _loc1_ = uint(this.rankPerLadderProgressList[this.myProfile.currentSeasonHighestLadderProgress]);
         _loc2_ = 0;
         while(_loc2_ < this.ladderSeasonEndRewardsData.length)
         {
            _loc3_ = this.ladderSeasonEndRewardsData[_loc2_];
            if(_loc2_ == this.ladderSeasonEndRewardsData.length - 1)
            {
               _loc3_.playerIsHere = true;
               break;
            }
            _loc4_ = this.ladderSeasonEndRewardsData[_loc2_ + 1];
            if(_loc1_ <= _loc3_.ladderLevelRequired && _loc1_ > _loc4_.ladderLevelRequired)
            {
               _loc3_.playerIsHere = true;
               break;
            }
            _loc3_.playerIsHere = false;
            _loc2_++;
         }
      }
      
      public function getPlayerPositionInLadderSeasonEndRewards() : uint
      {
         var _loc1_:uint = 0;
         var _loc2_:BMLadderSeasonEndRewardData = null;
         _loc1_ = 0;
         while(_loc1_ < this.ladderSeasonEndRewardsData.length)
         {
            _loc2_ = this.ladderSeasonEndRewardsData[_loc1_];
            if(_loc2_.playerIsHere)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return 0;
      }
      
      public function getStationaryMechsWithFireJumpWeapons(param1:Array) : Array
      {
         var _loc2_:BMPlayerData = null;
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:BMMechStructure = null;
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:BMItemData = null;
         var _loc9_:Array = null;
         _loc2_ = this.playersData[this.player1PlayerID];
         _loc3_ = new Array();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = uint(param1[_loc4_]);
            _loc6_ = _loc2_.mechStructures[_loc5_];
            if(_loc6_.leg != 0)
            {
               _loc7_ = this.getPlayerItemData(this.player1PlayerID,_loc6_.leg);
               _loc8_ = this.itemsDB[_loc7_.itemID];
               if(_loc8_.isNoJumpingLeg != false)
               {
                  _loc9_ = this.getMechFireJumpWeaponPlayerItemIDs(_loc5_);
                  if(_loc9_.length > 0)
                  {
                     _loc3_.push(_loc5_);
                  }
               }
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getMechFireJumpWeaponPlayerItemIDs(param1:uint) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:BMPlayerData = null;
         var _loc4_:BMMechStructure = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:BMPlayerItemData = null;
         var _loc8_:Array = null;
         var _loc10_:uint = 0;
         var _loc11_:BMItemData = null;
         _loc2_ = new Array();
         _loc3_ = this.playersData[this.player1PlayerID];
         _loc4_ = _loc3_.mechStructures[param1];
         if(_loc4_.has_sideWeapons == false && _loc4_.has_topWeapons == false)
         {
            return _loc2_;
         }
         _loc8_ = new Array();
         _loc5_ = 1;
         while(_loc5_ <= this.MAX_SIDE_WEAPONS)
         {
            _loc6_ = uint(_loc4_[BMMechStructure.SIDE_WEAPON + _loc5_]);
            if(_loc6_ > 0)
            {
               _loc8_.push(_loc6_);
            }
            _loc5_++;
         }
         _loc5_ = 1;
         while(_loc5_ <= this.MAX_TOP_WEAPONS)
         {
            _loc6_ = uint(_loc4_[BMMechStructure.TOP_WEAPON + _loc5_]);
            if(_loc6_ > 0)
            {
               _loc8_.push(_loc6_);
            }
            _loc5_++;
         }
         var _loc9_:Boolean = false;
         _loc10_ = 0;
         while(_loc10_ < _loc8_.length)
         {
            _loc6_ = uint(_loc8_[_loc10_]);
            _loc7_ = this.getPlayerItemData(this.player1PlayerID,_loc6_);
            _loc11_ = this.itemsDB[_loc7_.itemID];
            if(_loc11_.isFireJumpWeapon)
            {
               _loc2_.push(_loc6_);
            }
            _loc10_++;
         }
         return _loc2_;
      }
      
      public function doesMechHaveInvalidHPDueToOverload(param1:uint) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:BMPlayerData = null;
         var _loc4_:BMMechStructure = null;
         var _loc5_:uint = 0;
         var _loc6_:BMPlayerItemData = null;
         var _loc7_:BMItemData = null;
         _loc2_ = 0;
         _loc3_ = this.playersData[this.player1PlayerID];
         _loc4_ = _loc3_.mechStructures[param1];
         if(_loc4_.torso == 0 || _loc4_.leg == 0)
         {
            return false;
         }
         _loc5_ = 0;
         for(; _loc5_ < _loc3_.items.length; _loc5_++)
         {
            _loc6_ = _loc3_.items[_loc5_];
            if(_loc6_.equipped != param1)
            {
               continue;
            }
            _loc7_ = this.itemsDB[_loc6_.itemID];
            switch(_loc7_.type)
            {
               case BMMechStructure.TORSO:
               case BMMechStructure.LEG:
               case BMMechStructure.MODULE:
                  _loc2_ += _loc7_.HPBase;
            }
         }
         _loc2_ = int(BMMechStatsResolver.getHPMax(_loc2_,this.player1PlayerID));
         _loc2_ -= this.getOverloadHPPenaltyForWeight(_loc4_.mechWeight);
         return _loc2_ < 1;
      }
      
      public function mechIsOverWeight(param1:Array) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:BMPlayerData = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc2_ = 0;
         _loc3_ = this.playersData[this.player1PlayerID];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = uint(param1[_loc4_]);
            if(_loc3_.mechStructures[_loc5_].mechWeight > this.weightMax + this.weightOverload)
            {
               _loc2_ = _loc5_;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function get weightOverload() : uint
      {
         var _loc1_:uint = 0;
         if(this._weightOverload == 0)
         {
            return 0;
         }
         _loc1_ = this.getGeneralSetting("weightOverloadXPLevelRequired",1);
         if(this.myProfile.level < _loc1_)
         {
            return 0;
         }
         return this._weightOverload;
      }
      
      public function set weightOverload(param1:uint) : void
      {
         this._weightOverload = param1;
      }
      
      private function traceReplayData(param1:Object) : void
      {
         TsLogger.log("offlineReplayDB[" + param1.replayID + "] = { replayID:" + param1.replayID + ", playerID1:" + param1.playerID1 + ", playerID2:" + param1.playerID2 + ", name1:\'" + param1.name1 + "\', name2:\'" + param1.name2 + "\', level1:" + param1.level1 + ", level2:" + param1.level2 + ", mapStepsTotal:" + param1.mapStepsTotal + ", structure1:\'" + param1.structure1 + "\', structure2:\'" + param1.structure2 + "\', actions:\'" + param1.actions + "\', status1:\'" + param1.status1 + "\', status2:\'" + param1.status2 + "\', numberOfTurns:" + param1.numberOfTurns + "};");
      }
      
      private function createLocalReplays() : void
      {
      }
      
      public function addOnlineReplayData(param1:Object, param2:String) : void
      {
         var _loc3_:BMReplayData = null;
         var _loc4_:Number = NaN;
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc7_:String = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:Boolean = false;
         var _loc12_:Number = NaN;
         var _loc13_:String = null;
         var _loc14_:Number = NaN;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         var _loc18_:String = null;
         var _loc19_:BMMechStructure = null;
         var _loc20_:uint = 0;
         var _loc21_:String = null;
         var _loc22_:String = null;
         var _loc23_:String = null;
         var _loc24_:Boolean = false;
         var _loc25_:String = null;
         var _loc26_:Array = null;
         var _loc27_:uint = 0;
         var _loc28_:uint = 0;
         var _loc29_:BMItemData = null;
         var _loc30_:uint = 0;
         var _loc31_:String = null;
         var _loc32_:String = null;
         var _loc33_:String = null;
         var _loc34_:BMReplayAction = null;
         var _loc35_:String = null;
         var _loc36_:Number = NaN;
         var _loc37_:Boolean = false;
         var _loc38_:String = null;
         var _loc39_:String = null;
         var _loc40_:String = null;
         var _loc41_:BMReplayStatus = null;
         var _loc42_:Number = NaN;
         var _loc43_:Number = NaN;
         var _loc44_:Number = NaN;
         _loc3_ = new BMReplayData();
         _loc6_ = false;
         if(param1.playerID2 == this.userID)
         {
            _loc12_ = Number(param1.playerID1);
            param1.playerID1 = param1.playerID2;
            param1.playerID2 = _loc12_;
            _loc13_ = param1.name1;
            param1.name1 = param1.name2;
            param1.name2 = _loc13_;
            _loc14_ = Number(param1.level1);
            param1.level1 = param1.level2;
            param1.level2 = _loc14_;
            _loc15_ = param1.flag1;
            param1.flag1 = param1.flag2;
            param1.flag2 = _loc15_;
            _loc16_ = param1.structure1;
            param1.structure1 = param1.structure2;
            param1.structure2 = _loc16_;
            _loc17_ = param1.status1;
            param1.status1 = param1.status2;
            param1.status2 = _loc17_;
            _loc3_.replayInverted = true;
            _loc6_ = true;
         }
         _loc3_.replayID = param1.replayID;
         _loc3_.tsCreated = param1.tsCreated;
         _loc3_.playerID1 = param1.playerID1;
         _loc3_.playerID2 = param1.playerID2;
         _loc3_.playerName1 = param1.name1;
         _loc3_.playerName2 = param1.name2;
         _loc3_.level1 = param1.level1;
         _loc3_.level2 = param1.level2;
         _loc3_.flag1 = param1.flag1;
         _loc3_.flag2 = param1.flag2;
         _loc3_.mapStepsTotal = param1.mapStepsTotal;
         _loc3_.floorBuffs = param1.floorBuffs;
         if(param1.mechsPerPlayer != null)
         {
            _loc3_.battleMechsPerPlayer = param1.mechsPerPlayer;
         }
         _loc4_ = 1;
         while(_loc4_ <= 2)
         {
            _loc18_ = param1["structure" + _loc4_];
            _loc19_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
            _loc20_ = 1;
            _loc19_.initialize(_loc4_,_loc20_);
            _loc21_ = "";
            _loc42_ = 0;
            while(_loc42_ < _loc18_.length)
            {
               _loc5_ = _loc18_.substr(_loc42_,1);
               if(_loc5_ == "_")
               {
                  _loc22_ = "";
                  _loc23_ = _loc21_.substr(0,2);
                  _loc24_ = false;
                  switch(_loc23_)
                  {
                     case "M2":
                     case "M3":
                        _loc24_ = true;
                        break;
                     case "TO":
                        _loc22_ = BMMechStructure.TORSO;
                        break;
                     case "LE":
                        _loc22_ = BMMechStructure.LEG;
                        break;
                     case "SW":
                        _loc22_ = BMMechStructure.SIDE_WEAPON;
                        break;
                     case "TW":
                        _loc22_ = BMMechStructure.TOP_WEAPON;
                        break;
                     case "SL":
                        _loc22_ = BMMechStructure.SHIELD;
                        break;
                     case "DR":
                        _loc22_ = BMMechStructure.DRONE;
                        break;
                     case "TP":
                        _loc22_ = BMMechStructure.TELEPORT;
                        break;
                     case "CH":
                        _loc22_ = BMMechStructure.CHARGE;
                        break;
                     case "HR":
                        _loc22_ = BMMechStructure.HARPOON;
                        break;
                     case "KI":
                        _loc22_ = BMMechStructure.KIT;
                        break;
                     case "MO":
                        _loc22_ = BMMechStructure.MODULE;
                        break;
                     case "PR":
                        _loc22_ = BMMechStructure.PERK;
                        break;
                     case "SK":
                        _loc22_ = this.REPLAY_STRUCTURE_SKILLS;
                        _loc25_ = _loc18_.substr(_loc42_ - 1,_loc18_.length - (_loc42_ - 1));
                        _loc26_ = _loc25_.split("_");
                        _loc3_["player" + _loc4_ + "Skills"] = _loc26_;
                  }
                  if(_loc22_ == this.REPLAY_STRUCTURE_SKILLS)
                  {
                     _loc3_["player" + _loc4_ + "MechStructures"][_loc20_] = _loc19_;
                     _loc42_ = _loc18_.length;
                  }
                  else if(_loc24_)
                  {
                     _loc3_["player" + _loc4_ + "MechStructures"][_loc20_] = _loc19_;
                     _loc20_++;
                     _loc19_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
                     _loc19_.initialize(_loc4_,_loc20_);
                     _loc21_ = "";
                  }
                  else
                  {
                     _loc21_ = _loc21_.substr(3,_loc21_.length - 3);
                     _loc27_ = 0;
                     _loc28_ = 0;
                     switch(_loc22_)
                     {
                        case BMMechStructure.TORSO:
                        case BMMechStructure.LEG:
                        case BMMechStructure.SIDE_WEAPON:
                        case BMMechStructure.TOP_WEAPON:
                           _loc31_ = _loc21_.substr(_loc21_.length - 1,1);
                           _loc32_ = _loc21_.substr(_loc21_.length - 2,1);
                           _loc33_ = _loc21_.substr(_loc21_.length - 3,1);
                           if(_loc32_ == "-")
                           {
                              _loc30_ = 1;
                           }
                           else if(_loc33_ == "-")
                           {
                              _loc30_ = 2;
                           }
                           else
                           {
                              _loc30_ = 3;
                           }
                     }
                     switch(_loc22_)
                     {
                        case BMMechStructure.TORSO:
                        case BMMechStructure.LEG:
                           _loc27_ = uint(int(_loc21_.substr(0,_loc21_.length - (_loc30_ + 1))));
                           _loc19_[_loc22_] = _loc27_;
                           _loc28_ = uint(int(_loc21_.substr(_loc21_.length - _loc30_,_loc30_)));
                           if(_loc27_ > 0 && _loc28_ == 0)
                           {
                              _loc29_ = this.itemsDB[_loc27_];
                              _loc28_ = this.getItemColorByLevel(_loc29_.specialStatus,_loc29_.displayLevel,_loc29_.type);
                           }
                           _loc19_[_loc22_ + "_colorID"] = _loc28_;
                           break;
                        case BMMechStructure.SIDE_WEAPON:
                        case BMMechStructure.TOP_WEAPON:
                           _loc27_ = uint(int(_loc21_.substr(2,_loc21_.length - (_loc30_ + 3))));
                           _loc19_[_loc22_ + _loc21_.substr(0,1)] = _loc27_;
                           _loc28_ = uint(int(_loc21_.substr(_loc21_.length - _loc30_,_loc30_)));
                           if(_loc27_ > 0 && _loc28_ == 0)
                           {
                              _loc29_ = this.itemsDB[_loc27_];
                              _loc28_ = this.getItemColorByLevel(_loc29_.specialStatus,_loc29_.displayLevel,_loc29_.type);
                           }
                           _loc19_[_loc22_ + _loc21_.substr(0,1) + "_colorID"] = _loc28_;
                           break;
                        case BMMechStructure.SHIELD:
                        case BMMechStructure.DRONE:
                        case BMMechStructure.TELEPORT:
                        case BMMechStructure.CHARGE:
                        case BMMechStructure.HARPOON:
                        case BMMechStructure.PERK:
                           _loc19_[_loc22_] = int(_loc21_);
                           break;
                        case BMMechStructure.KIT:
                        case BMMechStructure.MODULE:
                           _loc19_[_loc22_ + _loc21_.substr(0,1)] = int(_loc21_.substr(2,_loc21_.length - 2));
                     }
                     _loc21_ = "";
                     if(_loc42_ == _loc18_.length - 1)
                     {
                        _loc3_["player" + _loc4_ + "MechStructures"][_loc20_] = _loc19_;
                     }
                  }
               }
               else
               {
                  _loc21_ += _loc5_;
               }
               _loc42_++;
            }
            _loc4_++;
         }
         _loc7_ = param1.actions;
         var _loc8_:Number = 0;
         _loc42_ = 0;
         while(_loc42_ < _loc7_.length)
         {
            _loc34_ = new BMReplayAction();
            _loc35_ = _loc7_.substr(_loc42_,1);
            if(_loc35_ == "X")
            {
               _loc34_.actionName = "battleResult";
               _loc42_ += 1;
            }
            else
            {
               _loc36_ = int(_loc35_);
               if(_loc6_)
               {
                  if(_loc36_ == 1)
                  {
                     _loc36_ = 2;
                  }
                  else
                  {
                     _loc36_ = 1;
                  }
               }
               _loc34_.playerNumber = _loc36_;
               _loc42_ += 2;
               _loc35_ = _loc7_.substr(_loc42_,2);
               switch(_loc35_)
               {
                  case "FW":
                     _loc34_.actionName = "fire";
                     _loc42_ += 3;
                     _loc37_ = false;
                     switch(_loc7_.substr(_loc42_,1))
                     {
                        case "S":
                           _loc34_.equipmentType = BMMechStructure.SIDE_WEAPON;
                           _loc37_ = true;
                           break;
                        case "T":
                           _loc34_.equipmentType = BMMechStructure.TOP_WEAPON;
                           _loc37_ = true;
                           break;
                        case "D":
                           _loc34_.equipmentType = BMMechStructure.DRONE;
                           break;
                        case "L":
                           _loc34_.equipmentType = BMMechStructure.LEG;
                     }
                     if(_loc37_)
                     {
                        _loc42_ += 2;
                        _loc34_.equipmentID = int(_loc7_.substr(_loc42_,1));
                     }
                     _loc42_ += 2;
                     break;
                  case "SH":
                     _loc34_.actionName = "shutDown";
                     _loc42_ += 3;
                     break;
                  case "KI":
                     _loc34_.actionName = "useKit";
                     _loc42_ += 3;
                     _loc34_.equipmentID = int(_loc7_.substr(_loc42_,1));
                     _loc42_ += 2;
                     break;
                  case "MV":
                     _loc34_.actionName = "moveMechToStep";
                     _loc42_ += 3;
                     switch(_loc7_.substr(_loc42_,1))
                     {
                        case "W":
                           _loc34_.motionType = "walk";
                           break;
                        case "J":
                           _loc34_.motionType = "jump";
                     }
                     _loc42_ += 2;
                     break;
                  case "TP":
                     _loc34_.actionName = BMMechStructure.TELEPORT;
                     _loc42_ += 3;
                     break;
                  case "CH":
                     _loc34_.actionName = BMMechStructure.CHARGE;
                     _loc42_ += 3;
                     break;
                  case "HR":
                     _loc34_.actionName = BMMechStructure.HARPOON;
                     _loc42_ += 3;
                     break;
                  case "DA":
                     _loc34_.actionName = "activateDrone";
                     _loc42_ += 3;
                     break;
                  case "DD":
                     _loc34_.actionName = "deactivateDrone";
                     _loc42_ += 3;
                     break;
                  case "SA":
                     _loc34_.actionName = "activateShield";
                     _loc42_ += 3;
                     break;
                  case "SD":
                     _loc34_.actionName = "deactivateShield";
                     _loc42_ += 3;
                     break;
                  case "SW":
                     _loc34_.actionName = "switchMech";
                     _loc42_ += 3;
                     _loc34_.mechID = int(_loc7_.substr(_loc42_,1));
                     _loc42_ += 2;
                     break;
                  case "OS":
                     _loc34_.actionName = "opponentSwitchMechAfterLosingMech";
                     _loc42_ += 3;
                     _loc34_.mechID = int(_loc7_.substr(_loc42_,1));
                     _loc42_ += 2;
                     break;
                  case "QU":
                     _loc3_.quitPlayerID = _loc3_["playerID" + _loc34_.playerNumber];
                     _loc34_.actionName = "quit";
                     _loc42_ += 3;
               }
               _loc5_ = _loc7_.substr(_loc42_ - 1,1);
               while(_loc42_ < _loc7_.length && _loc5_ == BMReplayAction.ACTION_SPECIAL_ABILITY_SEPARATOR)
               {
                  if("0123456789".indexOf(_loc7_.substr(_loc42_ + 1,1)) > -1)
                  {
                     _loc35_ = _loc7_.substr(_loc42_,2);
                     _loc42_ += 3;
                  }
                  else
                  {
                     _loc35_ = _loc7_.substr(_loc42_,1);
                     _loc42_ += 2;
                  }
                  _loc34_.specialAbilities.push(_loc35_);
                  _loc5_ = _loc7_.substr(_loc42_ - 1,1);
               }
               _loc3_.actions.push(_loc34_);
            }
         }
         _loc9_ = 0;
         _loc10_ = 0;
         _loc4_ = 1;
         while(_loc4_ <= 2)
         {
            _loc38_ = param1["status" + _loc4_];
            _loc39_ = "AP";
            _loc40_ = "";
            _loc41_ = new BMReplayStatus();
            _loc42_ = 0;
            while(_loc42_ < _loc38_.length)
            {
               _loc5_ = _loc38_.substr(_loc42_,1);
               if(_loc5_ == "_")
               {
                  _loc43_ = int(_loc40_);
                  if(_loc6_ && _loc39_ == "step")
                  {
                     _loc43_ = _loc3_.mapStepsTotal - 1 - _loc43_;
                  }
                  _loc41_[_loc39_] = _loc43_;
                  if(_loc39_ == "HP")
                  {
                     if(_loc43_ <= 0)
                     {
                        _loc44_ = 1;
                        if(_loc4_ == 1)
                        {
                           _loc9_++;
                        }
                        else
                        {
                           _loc10_++;
                        }
                     }
                  }
                  switch(_loc39_)
                  {
                     case "AP":
                        _loc39_ = "HP";
                        break;
                     case "HP":
                        _loc39_ = "heat";
                        break;
                     case "heat":
                        _loc39_ = "energy";
                        break;
                     case "energy":
                        _loc39_ = "bullets";
                        break;
                     case "bullets":
                        _loc39_ = "rockets";
                        break;
                     case "rockets":
                        _loc39_ = "step";
                        break;
                     case "step":
                        _loc39_ = BMMechStructure.SHIELD;
                        break;
                     case BMMechStructure.SHIELD:
                        _loc39_ = BMMechStructure.DRONE;
                        break;
                     case BMMechStructure.DRONE:
                        _loc39_ = "resist1";
                        break;
                     case "resist1":
                        _loc39_ = "resist2";
                        break;
                     case "resist2":
                        _loc39_ = "resist3";
                        break;
                     case "resist3":
                        _loc39_ = "AP";
                  }
                  _loc40_ = "";
               }
               else if(_loc5_ == "X")
               {
                  _loc3_["status" + _loc4_].push(_loc41_);
                  if(_loc42_ < _loc38_.length - 1)
                  {
                     _loc41_ = new BMReplayStatus();
                     _loc40_ = "";
                  }
               }
               else
               {
                  _loc40_ += _loc5_;
               }
               _loc42_++;
            }
            _loc4_++;
         }
         if(_loc3_.quitPlayerID == 0)
         {
            if(_loc9_ > _loc10_)
            {
               _loc3_.wonPlayerID = _loc3_.playerID2;
            }
            else
            {
               _loc3_.wonPlayerID = _loc3_.playerID1;
            }
         }
         _loc3_.numberOfTurns = param1.numberOfTurns;
         _loc11_ = false;
         switch(param2)
         {
            case "online":
               if(this.replaysDB_online[_loc3_.replayID] != null)
               {
                  _loc11_ = Boolean(this.replaysDB_online[_loc3_.replayID].watched);
               }
               if(this.perUserSharedObjectExists)
               {
                  if(this.perUserSharedObject.data.users != null)
                  {
                     if(this.perUserSharedObject.data.users[this.userID] != null)
                     {
                        if(this.perUserSharedObject.data.users[this.userID].replaysWatched != null)
                        {
                           if(this.perUserSharedObject.data.users[this.userID].replaysWatched[_loc3_.replayID] != null)
                           {
                              _loc11_ = true;
                           }
                        }
                     }
                  }
               }
               _loc3_.watched = _loc11_;
               this.replaysDB_online[_loc3_.replayID] = _loc3_;
               break;
            case "inspect":
               if(this.replaysDB_inspect[_loc3_.replayID] != null)
               {
                  _loc11_ = Boolean(this.replaysDB_inspect[_loc3_.replayID].watched);
               }
               if(this.perUserSharedObjectExists)
               {
                  if(this.perUserSharedObject.data.users != null)
                  {
                     if(this.perUserSharedObject.data.users[this.userID] != null)
                     {
                        if(this.perUserSharedObject.data.users[this.userID].replaysWatched != null)
                        {
                           if(this.perUserSharedObject.data.users[this.userID].replaysWatched[_loc3_.replayID] != null)
                           {
                              _loc11_ = true;
                           }
                        }
                     }
                  }
               }
               _loc3_.watched = _loc11_;
               this.replaysDB_inspect[_loc3_.replayID] = _loc3_;
               break;
            case "offline":
               this.replaysDB_offline[_loc3_.replayID] = _loc3_;
         }
      }
      
      public function unpackReplay(param1:Number) : void
      {
         var _loc2_:BMReplayData = null;
         var _loc3_:Object = null;
         var _loc4_:uint = 0;
         var _loc5_:BMPlayerData = null;
         var _loc6_:String = null;
         var _loc7_:Number = NaN;
         var _loc8_:String = null;
         var _loc9_:Number = NaN;
         var _loc10_:uint = 0;
         var _loc11_:String = null;
         var _loc12_:Number = NaN;
         var _loc13_:String = null;
         var _loc14_:Number = NaN;
         var _loc15_:uint = 0;
         var _loc16_:BMPlayerProfile = null;
         var _loc17_:String = null;
         var _loc18_:BMMechStructure = null;
         _loc2_ = this.replaysDB[param1];
         this.battleMechsPerPlayer = _loc2_.battleMechsPerPlayer;
         _loc2_.watched = true;
         this.battleData = {};
         this.battleData.map = {};
         this.battleData.map.stepsTotal = _loc2_.mapStepsTotal;
         this.battleData.startingPlayer = 1;
         this.battleData.player1 = {};
         this.battleData.player2 = {};
         this.battleData.player1.currentStep = _loc2_.status1[0].step;
         this.battleData.player2.currentStep = _loc2_.status2[0].step;
         _loc3_ = {};
         if(_loc2_.floorBuffs != null)
         {
            if(_loc2_.floorBuffs != "")
            {
               _loc6_ = "";
               _loc7_ = 0;
               _loc10_ = 0;
               while(_loc10_ < _loc2_.floorBuffs.length)
               {
                  _loc11_ = _loc2_.floorBuffs.substr(_loc10_,1);
                  if(_loc11_ == "-")
                  {
                     if(_loc2_.replayInverted)
                     {
                        _loc7_ = _loc2_.mapStepsTotal - 1 - int(_loc6_);
                     }
                     else
                     {
                        _loc7_ = int(_loc6_);
                     }
                     _loc6_ = "";
                  }
                  else if(_loc11_ == "_" || _loc10_ == _loc2_.floorBuffs.length - 1)
                  {
                     if(_loc10_ == _loc2_.floorBuffs.length - 1)
                     {
                        _loc6_ += _loc11_;
                     }
                     switch(_loc6_)
                     {
                        case "D1":
                           _loc3_[_loc7_] = {
                              "step":_loc7_,
                              "type":"damage",
                              "subType":1
                           };
                           break;
                        case "D2":
                           _loc3_[_loc7_] = {
                              "step":_loc7_,
                              "type":"damage",
                              "subType":2
                           };
                           break;
                        case "D3":
                           _loc3_[_loc7_] = {
                              "step":_loc7_,
                              "type":"damage",
                              "subType":3
                           };
                           break;
                        case "DH":
                           _loc3_[_loc7_] = {
                              "step":_loc7_,
                              "type":"damageHeat"
                           };
                           break;
                        case "DE":
                           _loc3_[_loc7_] = {
                              "step":_loc7_,
                              "type":"damageEnergy"
                           };
                           break;
                        case "ER":
                           _loc3_[_loc7_] = {
                              "step":_loc7_,
                              "type":"energyRegeneration"
                           };
                           break;
                        case "HC":
                           _loc3_[_loc7_] = {
                              "step":_loc7_,
                              "type":"heatCooling"
                           };
                           break;
                        case "IR":
                           _loc3_[_loc7_] = {
                              "step":_loc7_,
                              "type":"ignoreResistance"
                           };
                           break;
                        case "RI":
                           _loc3_[_loc7_] = {
                              "step":_loc7_,
                              "type":"resistanceIncrease"
                           };
                           break;
                        case "RD":
                           _loc3_[_loc7_] = {
                              "step":_loc7_,
                              "type":"resistanceDecrease"
                           };
                           break;
                        case "RH":
                           _loc3_[_loc7_] = {
                              "step":_loc7_,
                              "type":"regenHP"
                           };
                     }
                     _loc6_ = "";
                  }
                  else
                  {
                     _loc6_ += _loc11_;
                  }
                  _loc10_++;
               }
               this.battle_floorBuffsData = _loc3_;
            }
         }
         _loc4_ = this.player1PlayerID;
         while(_loc4_ <= this.player2PlayerID)
         {
            _loc12_ = this.getInterfacePlayerID(_loc4_);
            _loc13_ = this.getCensoredString(_loc2_["playerName" + _loc12_]);
            _loc14_ = Number(_loc2_["level" + _loc12_]);
            _loc15_ = 1;
            while(_loc15_ <= this.battleMechsPerPlayer)
            {
               _loc18_ = _loc2_["player" + _loc12_ + "MechStructures"][_loc15_];
               if(_loc15_ == 1)
               {
                  this["playerData" + _loc4_ + "Inventory"] = {};
                  this["player" + _loc4_ + "playerItemIDCounter"] = 1;
               }
               this.createProfile(_loc4_,_loc13_,_loc14_);
               this.createMechStructures_playerItemBased(_loc4_,_loc15_,_loc18_,-1,-1);
               _loc15_++;
            }
            this.createPlayerData(_loc4_,"screenReplay");
            _loc16_ = this["player" + _loc4_ + "Profile"];
            _loc16_.updateLevelByItems();
            _loc16_.ladderProgress = _loc14_;
            _loc16_.onlineRank = _loc14_;
            _loc16_.overallRank = _loc14_;
            _loc16_.skills = _loc2_["player" + _loc12_ + "Skills"].concat();
            _loc17_ = _loc2_["flag" + _loc12_];
            if(_loc17_ != "")
            {
               _loc16_.clanID = _loc12_;
               _loc16_.clanData = new BMClanData();
               _loc16_.clanData.flag = _loc2_["flag" + _loc12_];
            }
            _loc4_++;
         }
         this.battle_replayData = this.replaysDB[param1];
         screensM.addScreen(BMScreensManager.SCR_VS,true,null,[false]);
         screensM.screenVS.addStartPVEBattleFunction(this.startReplayBattle);
         screensM.screenVS.activateScreen();
         _loc5_ = this.playersData[this.player2PlayerID];
         screensM.screenVS.battleStarted(_loc5_.mechStructures[1]);
         screensM.screenVS.addInstantMultipleMechs();
      }
      
      private function startReplayBattle() : void
      {
         screensM.addBattleScreens();
         switch(this.gameSubType)
         {
            case BMDataManager.GAME_SUB_TYPE_REPLAY_REGULAR:
               screensM.removeScreen(BMScreensManager.SCR_TOP_BAR);
               break;
            case BMDataManager.GAME_SUB_TYPE_REPLAY_RANKING_LIST_INSPECT:
               screensM.removeScreen(BMScreensManager.SCR_INSPECT_PLAYER);
               break;
            case BMDataManager.GAME_SUB_TYPE_REPLAY_MENU_CHAT_INSPECT:
            case BMDataManager.GAME_SUB_TYPE_REPLAY_SMTV:
               screensM.removeScreen(BMScreensManager.SCR_MENU_MULTIPLAYER_INSPECT);
               screensM.removeScreen(BMScreensManager.SCR_INSPECT_PLAYER);
               break;
            case BMDataManager.GAME_SUB_TYPE_REPLAY_CLAN_INSPECT:
               screensM.removeScreen(BMScreensManager.SCR_INSPECT_PLAYER);
         }
         screensM.screenTransitionsManager.removeCurrentScreen();
         screensM.screenTransitionsManager.removeMe();
      }
      
      public function refreshMovieClipParticlesRatio() : void
      {
         this.movieClipParticleEffects = true;
         switch(this.movieClipParticleEffectsLevel)
         {
            case 0:
               this.movieClipParticleEffectsRatio = 0;
               this.movieClipParticleEffects = false;
               break;
            case 1:
               this.movieClipParticleEffectsRatio = 0.2;
               break;
            case 2:
               this.movieClipParticleEffectsRatio = 0.5;
               break;
            case 3:
               this.movieClipParticleEffectsRatio = 1;
         }
      }
      
      public function getLocalGraphicIcon(param1:String) : MovieClip
      {
         var _loc3_:MovieClip = null;
         var _loc2_:Class = Class(getDefinitionByName(param1));
         return new _loc2_();
      }
      
      public function getAvatarImage(param1:String) : BMAvatarImage
      {
         var _loc2_:BMAvatarImage = null;
         var _loc3_:String = null;
         _loc2_ = new BMAvatarImage();
         _loc3_ = "http://images.battlegate.net/Misc/flags/" + param1.toLowerCase() + ".png";
         _loc2_.initialize(0,_loc3_,17,12);
         return _loc2_;
      }
      
      public function applyForNewAvatarImage(param1:BMAvatarImage, param2:String, param3:Number, param4:Number) : void
      {
         var _loc5_:Loader = null;
         var _loc6_:LoaderContext = null;
         if(this.avatarImages[param2] == null)
         {
            _loc5_ = new Loader();
            _loc5_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.avatarImageDoneLoad);
            _loc5_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.avatarImageLoadingError);
            _loc5_.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.avatarImageUpdateInfo);
            _loc6_ = new LoaderContext(true,ApplicationDomain.currentDomain,null);
            _loc5_.load(new URLRequest(param2),_loc6_);
            this.avatarImages[param2] = {};
            this.avatarImages[param2].status = "loading";
            this.avatarImages[param2].requests = new Array();
            this.avatarImages[param2].url = param2;
            this.avatarImages[param2].loader = _loc5_;
            this.avatarImages[param2].width = param3;
            this.avatarImages[param2].height = param4;
         }
         this.avatarImages[param2].requests.push(param1);
         if(this.avatarImages[param2].status == "complete")
         {
            this.sendAvatarImageToAllRequests(param2);
         }
      }
      
      internal function avatarImageUpdateInfo(param1:ProgressEvent) : void
      {
      }
      
      internal function avatarImageLoadingError(param1:IOErrorEvent) : void
      {
      }
      
      internal function avatarImageDoneLoad(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         _loc2_ = param1.target.url;
         _loc3_ = this.avatarImages[_loc2_];
         _loc3_.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.avatarImageDoneLoad);
         _loc3_.loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.avatarImageUpdateInfo);
         _loc3_.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.avatarImageLoadingError);
         _loc3_.status = "complete";
         this.sendAvatarImageToAllRequests(_loc2_);
      }
      
      private function sendAvatarImageToAllRequests(param1:String) : void
      {
         var _loc2_:Object = null;
         var _loc3_:uint = 0;
         var _loc4_:Bitmap = null;
         _loc2_ = this.avatarImages[param1];
         _loc3_ = 0;
         while(_loc3_ < _loc2_.requests.length)
         {
            if(_loc2_.requests[_loc3_] != null)
            {
               _loc4_ = new Bitmap(Bitmap(_loc2_.loader.content).bitmapData);
               _loc2_.requests[_loc3_].setAvatarImage(_loc4_);
            }
            _loc3_++;
         }
         _loc2_.requests = new Array();
      }
      
      public function openURL(param1:String, param2:String) : void
      {
         navigateToURL(new URLRequest(param1),param2);
      }
      
      public function refreshClient() : void
      {
         var _loc1_:String = null;
         _loc1_ = ExternalInterface.call("window.location.href.toString");
         if(_loc1_)
         {
            navigateToURL(new URLRequest(_loc1_),"_self");
         }
         else
         {
            navigateToURL(new URLRequest("/"),"_self");
         }
      }
      
      public function emailSuperMechs() : void
      {
         var _loc1_:URLRequest = null;
         _loc1_ = new URLRequest("mailto:supermechs@tacticsoft.net" + "?subject=Video for YouTube channel" + "&body=Hello SuperMechs team,");
         navigateToURL(_loc1_,"_blank");
         _loc1_.method = URLRequestMethod.POST;
      }
      
      public function emailSupport(param1:String) : void
      {
         var body:String = null;
         var encoder:Base64Encoder = null;
         var request:URLRequest = null;
         var dtf:DateTimeFormatter = null;
         var date:Date = null;
         var subject:String = param1;
         body = "Hello SuperMechs team,\n\n\n\n\n\n\n";
         body += "================================================================\n";
         body += "[ Data for support - do not modify ]\n";
         body += "Username:" + this.userName + "\n";
         body += "User ID:" + this.userID + "\n";
         body += "Platform:" + BMPlatformUtils.sourcePlatform + " \n";
         var getDeviceDetails:Function = function():String
         {
            var _loc1_:Device = null;
            _loc1_ = Application.service.device;
            return JSON.stringify({
               "device":_loc1_.device,
               "brand":_loc1_.brand,
               "model":_loc1_.model,
               "product":_loc1_.product,
               "yearClass":_loc1_.yearClass,
               "manufacturer":_loc1_.manufacturer,
               "name":_loc1_.name
            });
         };
         body += "Device Data:" + getDeviceDetails() + " \n";
         body += "Version:" + externalAssetsM.CLIENT_VERSION_PC + " \n";
         body += "Accounts:" + this.getConnectedServices().join(",") + " \n";
         if(this.hasPlayerProfile)
         {
            body += "User Since:" + this.myProfile.dRegistration + "+\n";
            body += "Rank:" + this.getLadderRankByProgress(this.myProfile.ladderProgress) + "\n";
            body += "Level:" + this.myProfile.level + " \n";
            body += "Clan Name:" + this.myProfile.clanName + " \n";
            body += "Clan Leader:" + this.myProfile.isClanLeader + " \n";
            if(this.myProfile.timeToFirstPayment > 0)
            {
               dtf = new DateTimeFormatter("en-US");
               dtf.setDateTimePattern("dd-MM-yyyy \'at\' hh:mm:ssa");
               date = new Date();
               date.setTime(this.myProfile.timeToFirstPayment * 1000);
               body += "Flag:" + dtf.format(date) + " \n";
            }
            else
            {
               body += "Flag:0 \n";
            }
            body += "Status:" + (this.myProfile.tokensBought > 5000) + " \n";
         }
         encoder = new Base64Encoder();
         encoder.encodeUTFBytes(TsLogger.getLog());
         body += encoder.toString();
         request = new URLRequest("mailto:supermechs@tacticsoft.net" + "?subject=" + subject + "&body=" + body);
         navigateToURL(request,"_blank");
         request.method = URLRequestMethod.POST;
      }
      
      public function openSupportForm(param1:String) : *
      {
         screensM.addScreen(BMScreensManager.SCR_SUPPORT_TICKET);
         screensM.screenSupportTicket.setSubject(param1);
      }
      
      public function isAutopilotAllowed(param1:Boolean = false) : Boolean
      {
         if(param1)
         {
            if(tutorialM.isTutorialActive())
            {
               return false;
            }
         }
         else if(tutorialM.isTutorialActive() && this.useHiddenBaseMap == false)
         {
            return false;
         }
         if(this.getGeneralSetting("enableAutopilot",0) == 0)
         {
            return false;
         }
         switch(this.gameType)
         {
            case GAME_TYPE_PVP:
            case GAME_TYPE_REPLAY:
               return false;
            default:
               return true;
         }
      }
      
      public function setUserAutopilotOn(param1:Boolean = true) : void
      {
         this.userAutopilot = true;
         if(param1)
         {
            this.lastUserAutopilotInCampaign = true;
         }
      }
      
      public function setUserAutopilotOff(param1:Boolean = true) : void
      {
         this.userAutopilot = false;
         if(param1)
         {
            this.lastUserAutopilotInCampaign = false;
         }
      }
      
      public function setGeneralSpeedRatioAsNormal(param1:Boolean = true) : void
      {
         this.generalSpeedRatio = GENERAL_SPEED_RATIO_NORMAL;
         if(param1)
         {
            this.lastGeneralSpeedRatioInCampaign = GENERAL_SPEED_RATIO_NORMAL;
         }
      }
      
      public function setGeneralSpeedRatioAsDouble(param1:Boolean = true) : void
      {
         this.generalSpeedRatio = GENERAL_SPEED_RATIO_DOUBLE;
         if(param1)
         {
            this.lastGeneralSpeedRatioInCampaign = GENERAL_SPEED_RATIO_DOUBLE;
         }
      }
      
      public function setPVPAndReplaysDoubleSpeed() : void
      {
         var _loc1_:uint = 0;
         if(this.gameType != GAME_TYPE_PVP && this.gameType != GAME_TYPE_REPLAY)
         {
            return;
         }
         _loc1_ = this.getLadderRankByProgress(this.myProfile.ladderProgress);
         if(_loc1_ <= this.getGeneralSetting("pvpDoubleSpeedRequiredRank",0))
         {
            this.generalSpeedRatio = BMDataManager.GENERAL_SPEED_RATIO_DOUBLE;
         }
      }
      
      public function removePVPAndReplaysDoubleSpeed() : void
      {
         if(this.gameType != GAME_TYPE_PVP && this.gameType != GAME_TYPE_REPLAY)
         {
            return;
         }
         this.generalSpeedRatio = BMDataManager.GENERAL_SPEED_RATIO_NORMAL;
      }
      
      public function get currentTime() : Number
      {
         return this._currentTime;
      }
      
      public function set currentTime(param1:Number) : void
      {
         this._currentTime = param1;
         this._lastSetCurrentTimeDate = new Date().getTime();
         this._lastSetCurrentTimeValue = param1;
      }
      
      public function updateCurrentTime() : void
      {
         var _loc1_:Date = null;
         var _loc2_:Number = NaN;
         _loc1_ = new Date();
         _loc2_ = (_loc1_.getTime() - this._lastSetCurrentTimeDate) / 1000;
         this._currentTime = this._lastSetCurrentTimeValue + _loc2_;
      }
      
      public function goToDownloadOldClintPage() : void
      {
         this.openURL("http://www.supermechs.com/android_beta","_blank");
      }
      
      public function convertStringIntoDate(param1:String) : Date
      {
         var _loc2_:Date = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         _loc3_ = int(param1.substr(0,4));
         _loc4_ = int(param1.substr(5,2));
         _loc5_ = int(param1.substr(8,2));
         _loc6_ = int(param1.substr(11,2));
         _loc7_ = int(param1.substr(14,2));
         _loc8_ = int(param1.substr(17,2));
         return new Date(_loc3_,_loc4_ - 1,_loc5_,_loc6_,_loc7_,_loc8_);
      }
      
      public function replaceStringInText(param1:String, param2:String, param3:String) : String
      {
         return param1.replace(param2,param3);
      }
      
      public function createWeeklyWinnersData(param1:Object) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:uint = 0;
         this.weeklySoloWinners = {};
         this.weeklyClanWinners = {};
         this.weeklyTopClans = {};
         if(param1 != null)
         {
            for each(_loc2_ in param1)
            {
               _loc3_ = _loc2_.topList.split(",");
               this.addWeeklySoloWin(_loc3_[0],1);
               this.addWeeklySoloWin(_loc3_[1],2);
               this.addWeeklySoloWin(_loc3_[2],3);
               if(_loc2_.clanRank1PlayerIDs != null)
               {
                  _loc5_ = _loc2_.clanRank1PlayerIDs.split(",");
                  _loc4_ = 0;
                  while(_loc4_ < _loc5_.length)
                  {
                     this.addWeeklyClanWin(_loc5_[_loc4_],1);
                     _loc4_++;
                  }
                  _loc6_ = _loc2_.clanRank2PlayerIDs.split(",");
                  _loc4_ = 0;
                  while(_loc4_ < _loc6_.length)
                  {
                     this.addWeeklyClanWin(_loc6_[_loc4_],2);
                     _loc4_++;
                  }
                  _loc7_ = _loc2_.clanRank3PlayerIDs.split(",");
                  _loc4_ = 0;
                  while(_loc4_ < _loc7_.length)
                  {
                     this.addWeeklyClanWin(_loc7_[_loc4_],3);
                     _loc4_++;
                  }
                  _loc8_ = _loc2_.topClans.split(",");
                  _loc4_ = 0;
                  while(_loc4_ < _loc8_.length)
                  {
                     this.addWeeklyTopClan(_loc8_[_loc4_],_loc4_ + 1);
                     _loc4_++;
                  }
               }
            }
         }
         if(this.clientRunningLocally)
         {
            this.addWeeklySoloWin(11725,1);
            this.addWeeklySoloWin(11725,2);
            this.addWeeklySoloWin(11725,1);
            _loc9_ = 0;
            while(_loc9_ < 34)
            {
               this.addWeeklyClanWin(11725,3);
               this.addWeeklyClanWin(11725,2);
               this.addWeeklyClanWin(11725,3);
               this.addWeeklyTopClan(127752,1);
               _loc9_++;
            }
         }
      }
      
      private function addWeeklySoloWin(param1:Number, param2:Number) : void
      {
         if(param1 > 0)
         {
            if(this.weeklySoloWinners[param1] == null)
            {
               this.weeklySoloWinners[param1] = {};
               this.weeklySoloWinners[param1].places = new Array();
               this.weeklySoloWinners[param1].places[1] = 0;
               this.weeklySoloWinners[param1].places[2] = 0;
               this.weeklySoloWinners[param1].places[3] = 0;
            }
            ++this.weeklySoloWinners[param1].places[param2];
         }
      }
      
      private function addWeeklyClanWin(param1:Number, param2:Number) : void
      {
         if(param1 > 0)
         {
            if(this.weeklyClanWinners[param1] == null)
            {
               this.weeklyClanWinners[param1] = {};
               this.weeklyClanWinners[param1].places = new Array();
               this.weeklyClanWinners[param1].places[1] = 0;
               this.weeklyClanWinners[param1].places[2] = 0;
               this.weeklyClanWinners[param1].places[3] = 0;
            }
            ++this.weeklyClanWinners[param1].places[param2];
         }
      }
      
      private function addWeeklyTopClan(param1:Number, param2:Number) : void
      {
         if(param1 > 0)
         {
            if(this.weeklyTopClans[param1] == null)
            {
               this.weeklyTopClans[param1] = {};
               this.weeklyTopClans[param1].places = new Array();
               this.weeklyTopClans[param1].places[1] = 0;
               this.weeklyTopClans[param1].places[2] = 0;
               this.weeklyTopClans[param1].places[3] = 0;
            }
            ++this.weeklyTopClans[param1].places[param2];
         }
      }
      
      private function initializeGuestSharedObject() : void
      {
         TsLogger.log("!!! GUEST SHARED OBJECT INITIALIZED");
         this.guestSharedObject = SharedObject.getLocal("superMechsGuest");
         if(this.guestSharedObject.data != null)
         {
            if(this.guestSharedObject.data.items != undefined)
            {
               TsLogger.log(">>> GUEST SHARED OBJECT HAS DATA");
               this.guestSharedObjectExists = true;
               languageM.offerUserToSwitchToDetectedLanguage = false;
            }
         }
      }
      
      public function saveGuestData(param1:String) : void
      {
         var playerData:BMPlayerData = null;
         var slot:uint = 0;
         var guestProfile:BMPlayerProfile = null;
         var storyID:uint = 0;
         var playerItemData:BMPlayerItemData = null;
         var $caller:String = param1;
         switch(this.gameType)
         {
            case BMDataManager.GAME_TYPE_TUTORIAL:
            case BMDataManager.GAME_TYPE_TUTORIAL_PVE:
               this.resetGuestSharedObject("saveGuestData");
               playerData = this.playersData[this.LOCAL_PLAYER_ID];
               this.guestSharedObject.data.items = new Array();
               slot = 0;
               while(slot < playerData.items.length)
               {
                  playerItemData = playerData.items[slot];
                  this.guestSharedObject.data.items.push(playerItemData);
                  slot++;
               }
               guestProfile = this["player" + this.LOCAL_PLAYER_ID + "Profile"];
               this.guestSharedObject.data.profile = {};
               this.guestSharedObject.data.profile.gold = guestProfile.gold;
               this.guestSharedObject.data.profile.tokens = guestProfile.tokens;
               this.guestSharedObject.data.profile.totalGoldGained = guestProfile.totalGoldGained;
               this.guestSharedObject.data.profile.XP = guestProfile.XP;
               this.guestSharedObject.data.profile.totalXPGained = guestProfile.totalXPGained;
               this.guestSharedObject.data.profile.level = guestProfile.level;
               this.guestSharedObject.data.profile.battlesVSComputer = guestProfile.battlesVSComputer;
               this.guestSharedObject.data.profile.winsVSComputer = guestProfile.winsVSComputer;
               this.guestSharedObject.data.profile.campaignWins = guestProfile.campaignWins;
               this.guestSharedObject.data.profile.campaignLosesStreak = guestProfile.campaignLosesStreak;
               this.guestSharedObject.data.profile.tutorialLevel = guestProfile.tutorialLevel;
               this.guestSharedObject.data.profile.premiumAccountTime = this.premiumAccountTime;
               this.guestSharedObject.data.profile.freePackages = guestProfile.getFreePackagesString();
               this.guestSharedObject.data.profile.playerName = guestProfile.playerName;
               this.guestSharedObject.data.profile.mission_layout = guestProfile.mission_layout;
               this.guestSharedObject.data.profile.mission_hp = 0;
               this.guestSharedObject.data.profile.mission_energy = 0;
               this.guestSharedObject.data.profile.mission_energyRegeneration = 0;
               this.guestSharedObject.data.profile.mission_heat = 0;
               this.guestSharedObject.data.profile.mission_heatCooling = 0;
               this.guestSharedObject.data.profile.mission_bullets = 0;
               this.guestSharedObject.data.profile.mission_rockets = 0;
               if(guestProfile.missionCurrentMechStats != null)
               {
                  this.guestSharedObject.data.profile.mission_hp = guestProfile.missionCurrentMechStats.hp;
                  this.guestSharedObject.data.profile.mission_energy = guestProfile.missionCurrentMechStats.energy;
                  this.guestSharedObject.data.profile.mission_energyRegeneration = guestProfile.missionCurrentMechStats.energyRegeneration;
                  this.guestSharedObject.data.profile.mission_heat = guestProfile.missionCurrentMechStats.heat;
                  this.guestSharedObject.data.profile.mission_heatCooling = guestProfile.missionCurrentMechStats.heatCooling;
                  this.guestSharedObject.data.profile.mission_bullets = guestProfile.missionCurrentMechStats.bullets;
                  this.guestSharedObject.data.profile.mission_rockets = guestProfile.missionCurrentMechStats.rockets;
               }
               this.guestSharedObject.data.profile.mission_startingPosition = guestProfile.mission_startingPosition;
               this.guestSharedObject.data.profile.mission_playerPosition = guestProfile.mission_playerPosition;
               this.guestSharedObject.data.profile.mission_themeID = guestProfile.mission_themeID;
               this.guestSharedObject.data.profile.mission_flag = guestProfile.mission_flag;
               this.guestSharedObject.data.profile.mission_rows = guestProfile.mission_rows;
               this.guestSharedObject.data.profile.mission_columns = guestProfile.mission_columns;
               this.guestSharedObject.data.profile.mission_gold = guestProfile.mission_gold;
               this.guestSharedObject.data.profile.mission_difficulty = guestProfile.mission_difficulty;
               this.guestSharedObject.data.profile.mission_colorID = guestProfile.mission_colorID;
               this.guestSharedObject.data.profile.mission_progress = new Array();
               slot = 0;
               while(slot < guestProfile.mission_progress.length)
               {
                  this.guestSharedObject.data.profile.mission_progress.push(guestProfile.mission_progress[slot]);
                  slot++;
               }
               this.guestSharedObject.data.profile.mission_upgrades = new Array();
               slot = 0;
               while(slot < guestProfile.mission_upgrades.length)
               {
                  this.guestSharedObject.data.profile.mission_upgrades.push(guestProfile.mission_upgrades[slot]);
                  slot++;
               }
               this.guestSharedObject.data.profile.mission_loot = new Array();
               slot = 0;
               while(slot < guestProfile.mission_loot.length)
               {
                  this.guestSharedObject.data.profile.mission_loot.push(guestProfile.mission_loot[slot]);
                  slot++;
               }
               this.guestSharedObject.data.profile.mapProgress = new Array();
               slot = 0;
               while(slot < guestProfile.mapProgress.length)
               {
                  this.guestSharedObject.data.profile.mapProgress.push(guestProfile.mapProgress[slot]);
                  slot++;
               }
               storyID = uint(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1);
               this.guestSharedObject.data.profile.missionID = guestProfile.missionID;
               this.guestSharedObject.data.profile.currentMissionSlot = guestProfile.currentMissionSlot;
               this.guestSharedObject.data.profile.battleCredits = guestProfile.battleCredits;
               this.guestSharedObject.data.profile.lastBattleCreditAddon = this.lastBattleCreditAddon;
               this.guestSharedObject.data.profile.itemBoxesBought = guestProfile.itemBoxesBought_guest;
               try
               {
                  this.guestSharedObject.flush();
               }
               catch(err:Error)
               {
                  TsLogger.log("ERROR: shared object couldn\'t flush");
               }
               this.guestSharedObjectExists = true;
               languageM.offerUserToSwitchToDetectedLanguage = false;
         }
      }
      
      public function resetGuestSharedObject(param1:String) : void
      {
         var $caller:String = param1;
         this.guestSharedObject.clear();
         try
         {
            this.guestSharedObject.flush();
         }
         catch(err:Error)
         {
            TsLogger.log("ERROR: shared object couldn\'t flush");
         }
         this.guestSharedObjectExists = false;
      }
      
      private function loadSharedObjectGuestData() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:Object = null;
         var _loc4_:uint = 0;
         var _loc5_:Date = null;
         var _loc6_:Object = null;
         var _loc7_:Number = NaN;
         if(this.guestSharedObjectExists)
         {
            this["playerData" + this.LOCAL_PLAYER_ID + "Inventory"] = {};
            this["player" + this.LOCAL_PLAYER_ID + "playerItemIDCounter"] = 1;
            _loc1_ = 0;
            while(_loc1_ < this.guestSharedObject.data.items.length)
            {
               _loc6_ = this.guestSharedObject.data.items[_loc1_];
               _loc7_ = 0;
               if(_loc6_.power != null)
               {
                  _loc7_ = Number(_loc6_.power);
               }
               this.addInventoryItem(this.LOCAL_PLAYER_ID,this["playerData" + this.LOCAL_PLAYER_ID + "Inventory"],_loc6_.itemID,_loc6_.equipped,_loc6_.equipmentType,_loc6_.equipmentID,_loc6_.colorID,_loc7_);
               _loc1_++;
            }
            _loc2_ = this["player" + this.LOCAL_PLAYER_ID + "Profile"];
            _loc3_ = this.guestSharedObject.data.profile;
            _loc2_.gold = _loc3_.gold;
            _loc2_.totalGoldGained = _loc3_.totalGoldGained;
            _loc2_.XP = _loc3_.XP;
            _loc2_.totalXPGained = _loc3_.totalXPGained;
            _loc2_.level = _loc3_.level;
            _loc2_.lastLevel = _loc2_.level;
            _loc2_.battlesVSComputer = _loc3_.battlesVSComputer;
            _loc2_.winsVSComputer = _loc3_.winsVSComputer;
            if(_loc3_.ladderWins != null)
            {
               _loc2_.campaignWins = _loc3_.ladderWins;
            }
            if(_loc3_.campaignWins != null)
            {
               _loc2_.campaignWins = _loc3_.campaignWins;
            }
            if(_loc3_.ladderLosesStreak != null)
            {
               _loc2_.campaignLosesStreak = _loc3_.ladderLosesStreak;
            }
            if(_loc3_.campaignLosesStreak != null)
            {
               _loc2_.campaignLosesStreak = _loc3_.campaignLosesStreak;
            }
            if(_loc3_.tutorialLevel != null)
            {
               _loc2_.tutorialLevel = _loc3_.tutorialLevel;
               if(tutorialM.isTutorialActive() == false)
               {
                  this.tutorialSkipped = true;
               }
            }
            if(_loc3_.premiumAccountTime != null)
            {
               this.premiumAccountTime = _loc3_.premiumAccountTime;
            }
            if(_loc3_.tokens != null)
            {
               _loc2_.tokens = _loc3_.tokens;
            }
            if(_loc3_.freePackages != null)
            {
               if(_loc3_.freePackages != "")
               {
                  _loc2_.setFreePackages(_loc3_.freePackages);
               }
            }
            else
            {
               _loc2_.setFreePackages(this.FREE_PACKAGES_DEFAULT_STRING);
            }
            if(_loc3_.playerName != null)
            {
               _loc2_.playerName = _loc3_.playerName;
            }
            else
            {
               _loc2_.playerName = getGeneralText("guest");
            }
            _loc2_.missionCurrentMechID = 1;
            _loc2_.mission_layout = _loc3_.mission_layout;
            if(_loc2_.mission_layout != "")
            {
               _loc2_.currentStoryID = BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1;
               _loc2_.mission_mechStats[0] = new BMMissionMechStats();
               _loc2_.missionCurrentMechStats.hp = _loc3_.mission_hp;
               _loc2_.missionCurrentMechStats.energy = _loc3_.mission_energy;
               _loc2_.missionCurrentMechStats.energyRegeneration = _loc3_.mission_energyRegeneration;
               _loc2_.missionCurrentMechStats.heat = _loc3_.mission_heat;
               _loc2_.missionCurrentMechStats.heatCooling = _loc3_.mission_heatCooling;
               _loc2_.missionCurrentMechStats.bullets = _loc3_.mission_bullets;
               _loc2_.missionCurrentMechStats.rockets = _loc3_.mission_rockets;
            }
            _loc2_.mission_startingPosition = _loc3_.mission_startingPosition;
            _loc2_.mission_playerPosition = _loc3_.mission_startingPosition;
            _loc2_.mission_themeID = _loc3_.mission_themeID;
            _loc2_.mission_flag = _loc3_.mission_flag;
            _loc2_.mission_rows = _loc3_.mission_rows;
            _loc2_.mission_columns = _loc3_.mission_columns;
            _loc2_.mission_gold = _loc3_.mission_gold;
            _loc2_.mission_difficulty = _loc3_.mission_difficulty;
            _loc2_.mission_colorID = _loc3_.mission_colorID;
            if(_loc3_.mission_progress != null)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc3_.mission_progress.length)
               {
                  _loc2_.mission_progress.push(_loc3_.mission_progress[_loc1_]);
                  _loc1_++;
               }
            }
            if(_loc3_.mission_upgrades != null)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc3_.mission_upgrades.length)
               {
                  _loc2_.mission_upgrades.push(_loc3_.mission_upgrades[_loc1_]);
                  _loc1_++;
               }
            }
            if(_loc3_.mission_loot != null)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc3_.mission_loot.length)
               {
                  _loc2_.mission_loot.push(_loc3_.mission_loot[_loc1_]);
                  _loc1_++;
               }
            }
            if(_loc3_.mapProgress != null)
            {
               _loc1_ = 0;
               while(_loc1_ < _loc3_.mapProgress.length)
               {
                  _loc2_.mapProgress.push(_loc3_.mapProgress[_loc1_]);
                  _loc1_++;
               }
            }
            _loc4_ = uint(BMSinglePlayerManager.STORY_ID_CAMPAIGN_1V1);
            _loc2_.missionID = _loc3_.missionID;
            _loc2_.setCurrentMissionSlot(_loc3_.currentMissionSlot);
            _loc2_.battleCredits = _loc3_.battleCredits;
            this.lastBattleCreditAddon = _loc3_.lastBattleCreditAddon;
            if(_loc3_.itemBoxesBought != null)
            {
               _loc2_.itemBoxesBought_guest = _loc3_.itemBoxesBought;
            }
            _loc5_ = new Date();
            this.currentTime = Math.ceil(_loc5_.getTime() / 1000);
            _loc2_.updateWinsTotal();
         }
      }
      
      private function initializePerUserSharedObject() : void
      {
         var _loc1_:String = null;
         TsLogger.log("!!! GENERAL SHARED OBJECT INITIALIZED");
         this.perUserSharedObject = SharedObject.getLocal("superMechsGeneral");
         if(this.perUserSharedObject.data != null)
         {
            if(this.perUserSharedObject.data.lastUsername != undefined)
            {
               this.perUserSharedObjectExists = true;
               languageM.offerUserToSwitchToDetectedLanguage = false;
            }
            if(this.perUserSharedObject.data.lastLanguageID != null)
            {
               this.languageID = this.perUserSharedObject.data.lastLanguageID;
            }
            else if(this.useLanguages)
            {
               _loc1_ = Capabilities.language;
               _loc1_ = Capabilities.languages[0];
               _loc1_ = _loc1_.split("-")[0];
               TsLogger.log(">>>>>>>>>>>>>>>>>>>> LANGUAGE CODE: " + _loc1_);
               trace(">>>>>>>>>>>>>>>>>>>> LANGUAGE CODE: " + _loc1_);
               if(BMLanguageManager.LANGUAGE_ID_BY_CODE[_loc1_] != null)
               {
                  this.recommendedLanguageID = BMLanguageManager.LANGUAGE_ID_BY_CODE[_loc1_];
               }
            }
            this.createInfoTextDB();
            this.createBattleInterfaceToolTipDB();
            this.clientLastLanguageID = this.languageID;
         }
         if(this.perUserSharedObjectExists == false)
         {
            this.perUserSharedObject.data.lastUsername = "";
            this.perUserSharedObject.data.lastPassword = "";
            this.perUserSharedObject.data.lastLanguageID = this.languageID;
            this.perUserSharedObject.data.users = {};
            this.flushPerUserSharedObject();
         }
      }
      
      private function flushPerUserSharedObject() : void
      {
         try
         {
            this.perUserSharedObject.flush();
         }
         catch(err:Error)
         {
            TsLogger.log("ERROR: shared object couldn\'t flush");
         }
      }
      
      public function saveUsernameData() : void
      {
         if(this.perUserSharedObject != null)
         {
            this.perUserSharedObject.data.lastUsername = this.userName;
            this.flushPerUserSharedObject();
         }
      }
      
      public function savePasswordData(param1:String) : void
      {
         if(this.perUserSharedObject != null)
         {
            this.perUserSharedObject.data.lastPassword = param1;
            this.flushPerUserSharedObject();
         }
      }
      
      public function saveLanguageData() : void
      {
         this.perUserSharedObject.data.lastLanguageID = this.languageID;
         this.flushPerUserSharedObject();
      }
      
      public function get userWasOfferedToEnableBaseBuilding() : Boolean
      {
         if(this.perUserSharedObjectExists == false)
         {
            return false;
         }
         if(this.perUserSharedObject.data.users[this.userID] == null)
         {
            this.savePerUserSharedObjectData();
         }
         if(this.perUserSharedObject.data.users[this.userID].offeredToEnableBaseBuilding == null)
         {
            return false;
         }
         return this.perUserSharedObject.data.users[this.userID].offeredToEnableBaseBuilding;
      }
      
      public function set userWasOfferedToEnableBaseBuilding(param1:Boolean) : void
      {
         if(this.perUserSharedObjectExists == false)
         {
            this.savePerUserSharedObjectData();
         }
         if(this.perUserSharedObject.data.users[this.userID] == null)
         {
            this.savePerUserSharedObjectData();
         }
         this.perUserSharedObject.data.users[this.userID].offeredToEnableBaseBuilding = param1;
         this.savePerUserSharedObjectData();
      }
      
      public function savePerUserSharedObjectData() : void
      {
         var _loc1_:BMReplayData = null;
         var _loc2_:BMPlayerProfile = null;
         this.perUserSharedObject.data.lastLanguageID = this.languageID;
         if(loginM.isConnected)
         {
            if(this.perUserSharedObject.data.users == null)
            {
               this.perUserSharedObject.data.users = {};
            }
            if(this.perUserSharedObject.data.users[this.userID] == null)
            {
               this.perUserSharedObject.data.users[this.userID] = {};
            }
            if(this.perUserSharedObject.data.users[this.userID].replaysWatched == null)
            {
               this.perUserSharedObject.data.users[this.userID].replaysWatched = {};
            }
            if(this.perUserSharedObject.data.users[this.userID].offeredToEnableBaseBuilding == null)
            {
               this.perUserSharedObject.data.users[this.userID].offeredToEnableBaseBuilding = false;
            }
            for each(_loc1_ in this.replaysDB_inspect)
            {
               if(_loc1_.watched)
               {
                  this.perUserSharedObject.data.users[this.userID].replaysWatched[_loc1_.replayID] = true;
               }
            }
            if(this.perUserSharedObject.data.users[this.userID].winningLosingStreaks == null)
            {
               this.perUserSharedObject.data.users[this.userID].winningLosingStreaks = {};
            }
            _loc2_ = this["player" + this.ONLINE_PLAYER_ID + "Profile"];
            this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.winningStreakVSComputer = _loc2_.winningStreakVSComputer;
            this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.losingStreakVSComputer = _loc2_.losingStreakVSComputer;
            this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.campaignLosesStreak = _loc2_.campaignLosesStreak;
            if(this.perUserSharedObject.data.users[this.userID].general == null)
            {
               this.perUserSharedObject.data.users[this.userID].general = {};
            }
            this.perUserSharedObject.data.users[this.userID].general.mechBuilds = new Array();
            this.perUserSharedObject.data.users[this.userID].general.expandedInventory = _loc2_.expandedInventorySortingMessageDisplayed;
         }
         this.flushPerUserSharedObject();
      }
      
      public function resetPerUserSharedObject() : void
      {
         var _loc1_:String = null;
         _loc1_ = "";
         if(this.perUserSharedObject.data != null)
         {
            if(this.perUserSharedObject.data.lastUsername != null)
            {
               _loc1_ = this.perUserSharedObject.data.lastUsername;
            }
         }
         this.perUserSharedObject.clear();
         this.flushPerUserSharedObject();
         if(_loc1_ != "")
         {
            this.perUserSharedObject.data.lastUsername = _loc1_;
            this.perUserSharedObject.data.lastLanguageID = this.languageID;
         }
      }
      
      public function loadPerUserSharedObjectData() : void
      {
         var _loc1_:BMPlayerProfile = null;
         if(this.perUserSharedObjectExists)
         {
            if(loginM.isConnected)
            {
               if(this.perUserSharedObject.data.users != null)
               {
                  if(this.perUserSharedObject.data.users[this.userID] != null)
                  {
                     if(this.perUserSharedObject.data.users[this.userID].winningLosingStreaks != null)
                     {
                        _loc1_ = this["player" + this.ONLINE_PLAYER_ID + "Profile"];
                        _loc1_.winningStreakVSComputer = this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.winningStreakVSComputer;
                        _loc1_.losingStreakVSComputer = this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.losingStreakVSComputer;
                        if(this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.ladderLosesStreak != null)
                        {
                           _loc1_.campaignLosesStreak = this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.ladderLosesStreak;
                        }
                        if(this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.campaignLosesStreak != null)
                        {
                           _loc1_.campaignLosesStreak = this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.campaignLosesStreak;
                        }
                        if(this.perUserSharedObject.data.users[this.userID].general != null)
                        {
                           if(this.perUserSharedObject.data.users[this.userID].general.expandedInventory != null)
                           {
                              _loc1_.expandedInventorySortingMessageDisplayed = this.perUserSharedObject.data.users[this.userID].general.expandedInventory;
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function getSharedObjectLastLoginUsername() : String
      {
         var _loc1_:String = null;
         _loc1_ = "";
         if(this.perUserSharedObject.data != null)
         {
            if(this.perUserSharedObject.data.lastLoginUsername != null)
            {
               _loc1_ = this.perUserSharedObject.data.lastLoginUsername;
            }
         }
         return _loc1_;
      }
      
      public function getSharedObjectLastPassword() : String
      {
         var _loc1_:String = null;
         _loc1_ = "";
         if(this.perUserSharedObject.data != null)
         {
            if(this.perUserSharedObject.data.lastPassword != null)
            {
               _loc1_ = this.perUserSharedObject.data.lastPassword;
            }
         }
         return _loc1_;
      }
      
      private function initializeExternalLibrarySharedObject() : void
      {
         TsLogger.log("!!! EXTERNAL LIBRARY SHARED OBJECT INITIALIZED");
         this.externalLibrarySharedObject = SharedObject.getLocal("superMechsExternalLibrary");
         if(this.externalLibrarySharedObject.data != null)
         {
            if(this.externalLibrarySharedObject.data[BMExternalAssetsManager.EXTERNAL_LIBRARY_VERSION_FILE_NAME] != null)
            {
               this.externalLibrarySharedObjectExists = true;
            }
         }
      }
      
      public function saveExternalLibrarySharedObjectData(param1:FZip) : void
      {
         var slot:uint = 0;
         var zipFile:FZipFile = null;
         var $zip:FZip = param1;
         this.resetExternalLibrarySharedObject();
         this.externalLibrarySharedObjectExists = true;
         slot = 0;
         while(slot < $zip.getFileCount())
         {
            zipFile = $zip.getFileAt(slot);
            this.externalLibrarySharedObject.data[zipFile.filename] = zipFile.content;
            slot++;
         }
         this.externalLibrarySharedObject.data.url = this.externalLibraryURL;
         try
         {
            this.externalLibrarySharedObject.flush();
         }
         catch(err:Error)
         {
            TsLogger.log("ERROR: shared object couldn\'t flush");
         }
      }
      
      public function resetExternalLibrarySharedObject() : void
      {
         TsLogger.log(" ! ! ! EXTERNAL LIBRARY SHARED OBJECT CLEARED");
         this.externalLibrarySharedObject.clear();
         try
         {
            this.externalLibrarySharedObject.flush();
         }
         catch(err:Error)
         {
            TsLogger.log("ERROR: shared object couldn\'t flush");
         }
      }
      
      public function get externalLibraryURL() : String
      {
         return this.getGeneralSetting("externalLibraryURL","https://supermechs.com/resources/external/external.zip");
      }
      
      public function getLegacyItemsMaterialPowerContributionPerRarity() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:uint = 0;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:BMItemData = null;
         _loc1_ = [0,0,0,0,0];
         _loc2_ = 0;
         while(_loc2_ < this.myPlayerData.items.length)
         {
            _loc3_ = this.myPlayerData.items[_loc2_];
            if(_loc3_.equipped <= 0)
            {
               _loc4_ = this.itemsDB[_loc3_.itemID];
               if(!(_loc4_.isDeprecated == 0 || _loc4_.specialStatus > 4))
               {
                  _loc1_[_loc4_.specialStatus] += _loc4_.materialPowerContribution;
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getLegacyItemsAmountPerRarity() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:uint = 0;
         var _loc3_:BMPlayerItemData = null;
         var _loc4_:BMItemData = null;
         _loc1_ = [0,0,0,0,0];
         _loc2_ = 0;
         while(_loc2_ < this.myPlayerData.items.length)
         {
            _loc3_ = this.myPlayerData.items[_loc2_];
            if(_loc3_.equipped <= 0)
            {
               _loc4_ = this.itemsDB[_loc3_.itemID];
               if(!(_loc4_.isDeprecated == 0 || _loc4_.specialStatus > 4 || _loc4_.isColorKit))
               {
                  _loc1_[_loc4_.specialStatus] += 1;
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function getLegacyItemsAmountTotal() : uint
      {
         var _loc1_:Array = null;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc1_ = this.getLegacyItemsAmountPerRarity();
         _loc2_ = 0;
         _loc3_ = 0;
         while(_loc3_ <= 4)
         {
            _loc2_ += _loc1_[_loc3_];
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function createTierAndPowerRatingBasedData(param1:Boolean) : void
      {
         var _loc2_:Object = null;
         var _loc3_:BMItemData = null;
         _loc2_ = this.itemsDB_local;
         if(param1)
         {
            _loc2_ = this.itemsDB_online;
         }
         this.itemsByTypeAndPowerRating = {};
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.isDeprecated == false)
            {
               if(this.itemsByTypeAndPowerRating[_loc3_.type] == null)
               {
                  this.itemsByTypeAndPowerRating[_loc3_.type] = {};
               }
               if(this.itemsByTypeAndPowerRating[_loc3_.type][_loc3_.powerRating] == null)
               {
                  this.itemsByTypeAndPowerRating[_loc3_.type][_loc3_.powerRating] = new Array();
               }
               this.itemsByTypeAndPowerRating[_loc3_.type][_loc3_.powerRating].push(_loc3_.itemID);
               if(_loc3_.chainID > 0)
               {
                  if(this.itemsByChainIDs[_loc3_.chainID] == null)
                  {
                     this.itemsByChainIDs[_loc3_.chainID] = new Array();
                  }
                  this.itemsByChainIDs[_loc3_.chainID][_loc3_.powerRating] = _loc3_.itemID;
               }
            }
         }
      }
      
      public function showItemTransformRange(param1:BMItemData, param2:MovieClip) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:BMItemData = null;
         var _loc6_:BMItemData = null;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         var _loc10_:Boolean = false;
         var _loc11_:uint = 0;
         var _loc12_:String = null;
         _loc3_ = BMSinglePlayerManager.gi().getItemFromChainByPowerRating(param1.itemID,1);
         _loc4_ = BMSinglePlayerManager.gi().getItemFromChainByPowerRating(param1.itemID,uint.MAX_VALUE);
         _loc5_ = this.itemsDB[_loc3_];
         _loc6_ = this.itemsDB[_loc4_];
         param2.graphics.clear();
         _loc7_ = 5;
         _loc8_ = 15;
         _loc9_ = uint(_loc5_.specialStatus);
         _loc10_ = false;
         _loc11_ = 0;
         while(_loc10_ == false)
         {
            _loc12_ = ItemRarityResolver.getItemTierColor(_loc9_);
            param2.graphics.beginFill(uint("0x" + _loc12_));
            param2.graphics.drawCircle(_loc11_ * _loc8_ + _loc7_,0,_loc7_);
            if(_loc9_ != param1.specialStatus)
            {
               param2.graphics.beginFill(uint("0x000000"));
               param2.graphics.drawCircle(_loc11_ * _loc8_ + _loc7_,0,_loc7_ - 2);
            }
            if(_loc9_ == _loc6_.specialStatus)
            {
               _loc10_ = true;
            }
            else
            {
               _loc9_ = ItemRarityResolver.nextRarity(_loc9_);
               _loc11_ += 1;
            }
         }
      }
      
      public function setItemsCategoriesData(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         var _loc5_:BMItemData = null;
         var _loc6_:Number = NaN;
         this.createTierAndPowerRatingBasedData(param1);
         this.modules_energy = new Array();
         this.modules_heat = new Array();
         this.modules_bullets = new Array();
         this.modules_rockets = new Array();
         this.modules_bulletsAndRockets = new Array();
         this.modules_resistance = new Array();
         this.modules_armor = new Array();
         this.kits_energy = new Array();
         this.kits_heat = new Array();
         this.kits_bullets = new Array();
         this.kits_rockets = new Array();
         this.kits_resistance = new Array();
         this.kits_repair = new Array();
         _loc2_ = 240;
         _loc3_ = 1;
         while(_loc3_ <= _loc2_)
         {
            this.modules_energy[_loc3_] = new Array();
            this.modules_heat[_loc3_] = new Array();
            this.modules_bullets[_loc3_] = new Array();
            this.modules_rockets[_loc3_] = new Array();
            this.modules_bulletsAndRockets[_loc3_] = new Array();
            this.modules_resistance[_loc3_] = new Array();
            this.modules_armor[_loc3_] = new Array();
            this.kits_energy[_loc3_] = new Array();
            this.kits_heat[_loc3_] = new Array();
            this.kits_bullets[_loc3_] = new Array();
            this.kits_rockets[_loc3_] = new Array();
            this.kits_resistance[_loc3_] = new Array();
            this.kits_repair[_loc3_] = new Array();
            _loc3_++;
         }
         _loc4_ = this.itemsDB_local;
         if(param1)
         {
            _loc4_ = this.itemsDB_online;
         }
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.specialStatus > 3)
            {
               continue;
            }
            _loc6_ = _loc5_.itemID;
            switch(_loc5_.type)
            {
               case BMMechStructure.MODULE:
                  if(_loc5_.energyBase > 0 || _loc5_.energyAddon > 0)
                  {
                     this.modules_energy[_loc5_.level].push(_loc6_);
                  }
                  if(_loc5_.heatBase > 0 || _loc5_.heatAddon > 0)
                  {
                     this.modules_heat[_loc5_.level].push(_loc6_);
                  }
                  if(_loc5_.bullets > 0 && _loc5_.rockets > 0)
                  {
                     this.modules_bulletsAndRockets[_loc5_.level].push(_loc6_);
                  }
                  else
                  {
                     if(_loc5_.bullets > 0)
                     {
                        this.modules_bullets[_loc5_.level].push(_loc6_);
                     }
                     if(_loc5_.rockets > 0)
                     {
                        this.modules_rockets[_loc5_.level].push(_loc6_);
                     }
                  }
                  if(_loc5_.resist1 > 0 || _loc5_.resist2 > 0 || _loc5_.resist3 > 0)
                  {
                     this.modules_resistance[_loc5_.level].push(_loc6_);
                  }
                  if(_loc5_.HPBase > 0)
                  {
                     if(this.modules_armor[_loc5_.level] == null)
                     {
                        trace(_loc5_.itemID + " " + _loc5_.fullName + " " + _loc5_.level);
                     }
                     this.modules_armor[_loc5_.level].push(_loc6_);
                  }
                  break;
               case BMMechStructure.KIT:
                  if(_loc5_.energyBase > 0)
                  {
                     this.kits_energy[_loc5_.level].push(_loc6_);
                  }
                  if(_loc5_.heatBase > 0)
                  {
                     this.kits_heat[_loc5_.level].push(_loc6_);
                  }
                  if(_loc5_.bullets > 0)
                  {
                     this.kits_bullets[_loc5_.level].push(_loc6_);
                  }
                  if(_loc5_.rockets > 0)
                  {
                     this.kits_rockets[_loc5_.level].push(_loc6_);
                  }
                  if(_loc5_.resist1 > 0 || _loc5_.resist2 > 0 || _loc5_.resist3 > 0)
                  {
                     this.kits_resistance[_loc5_.level].push(_loc6_);
                  }
                  if(_loc5_.HPBase > 0)
                  {
                     this.kits_repair[_loc5_.level].push(_loc6_);
                  }
            }
         }
      }
      
      public function getClanFlagData(param1:String) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:Boolean = false;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         _loc2_ = new Array();
         if(param1 != null)
         {
            if(param1 != "")
            {
               _loc3_ = "";
               _loc4_ = true;
               _loc5_ = 0;
               while(_loc5_ < param1.length)
               {
                  _loc6_ = param1.substr(_loc5_,1);
                  if(_loc6_ == "_" || _loc5_ == param1.length - 1)
                  {
                     if(_loc5_ == param1.length - 1)
                     {
                        _loc3_ += _loc6_;
                     }
                     if(int(_loc3_) < 1)
                     {
                        _loc4_ = false;
                        _loc5_ = uint(param1.length);
                     }
                     else
                     {
                        _loc2_.push(int(_loc3_));
                        _loc3_ = "";
                     }
                  }
                  else
                  {
                     _loc3_ += _loc6_;
                  }
                  _loc5_++;
               }
               if(_loc2_.length != 5)
               {
                  _loc4_ = false;
               }
               if(_loc4_ == false)
               {
                  _loc2_ = new Array();
               }
            }
         }
         return _loc2_;
      }
      
      private function canShowAdvertisementToPlayer() : Boolean
      {
         var _loc1_:BMPlayerProfile = null;
         if(this.hasPlayerProfile)
         {
            _loc1_ = this.myProfile;
            return _loc1_ != null && _loc1_.tokens_supporter == 0 && _loc1_.tokensSpent == 0 && !this.isPremiumAccountActive() && _loc1_.level >= 5;
         }
         return false;
      }
      
      private function isPlayerInHighLTVCountry() : Boolean
      {
         var _loc1_:String = null;
         var _loc2_:Array = null;
         _loc1_ = this.getGeneralSetting("adGeos","");
         _loc2_ = _loc1_.split(",");
         return _loc2_.indexOf(this.myProfile.geo.toUpperCase()) >= 0;
      }
      
      public function loadNextAdvertisement() : void
      {
         if(FeatureFlags.DISABLE_ADS)
         {
            return;
         }
         if(this.canShowAdvertisementToPlayer() == false)
         {
            return;
         }
         if(!BMAdsManager.gi().isInterstitialAvailable())
         {
            return;
         }
         BMAdsManager.gi().loadInterstitial();
      }
      
      public function get isShowingAdvertisement() : Boolean
      {
         return this._isShowingAdvertisement;
      }
      
      public function showDelayedAdvertisement() : void
      {
         if(this.waitingToShowAdvertisement == false)
         {
            return;
         }
         this.waitingToShowAdvertisement = false;
         this.showAdvertisement();
      }
      
      public function showAdvertisement() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         if(FeatureFlags.DISABLE_ADS)
         {
            return;
         }
         if(!this.canShowAdvertisementToPlayer())
         {
            return;
         }
         _loc1_ = this.supersonic_mobile_afterWins == 0 || this.supersonic_mobile_afterWins == 1 && this.myProfile.lastBattleResult == BATTLE_RESULT_WIN;
         if(!_loc1_)
         {
            return;
         }
         _loc2_ = this.getGeneralSetting("allowInterstitials",1) == 1;
         _loc3_ = this.isPlayerInHighLTVCountry();
         _loc4_ = 0;
         var _loc5_:Boolean = false;
         if(_loc3_)
         {
            _loc4_ = this.getGeneralSetting("secondsBetweenInterstitialHigh",300);
            _loc5_ = this.getGeneralSetting("allowBannersHigh",0) == 1;
         }
         else
         {
            _loc4_ = this.getGeneralSetting("secondsBetweenInterstitialLow",300);
            _loc5_ = this.getGeneralSetting("allowBannersLow",0) == 1;
         }
         _loc6_ = new Date().getTime();
         _loc7_ = (_loc6_ - this._lastInterstitialTimestamp) / 1000;
         if(_loc7_ < _loc4_)
         {
            return;
         }
         _loc8_ = _loc2_ && BMAdsManager.gi().isInterstitialAvailable();
         _loc9_ = false;
         _loc10_ = false;
         if(_loc9_)
         {
            this._wasLastInterstitialABanner = true;
            this._lastInterstitialTimestamp = _loc6_;
         }
         else if(_loc8_)
         {
            this._wasLastInterstitialABanner = false;
            this._lastInterstitialTimestamp = _loc6_;
            this._isShowingAdvertisement = true;
            BMAdsManager.gi().addEventListener(BMAdsManagerEvents.ON_INTERSTITIAL_COMLETE,this.onShowInterstitialComplete);
            BMAdsManager.gi().showInterstitial();
         }
         else if(_loc10_)
         {
            this._wasLastInterstitialABanner = true;
            this._lastInterstitialTimestamp = _loc6_;
         }
      }
      
      private function onShowInterstitialComplete(param1:Event) : void
      {
         this._isShowingAdvertisement = false;
         BMAdsManager.gi().removeEventListener(BMAdsManagerEvents.ON_INTERSTITIAL_COMLETE,this.onShowInterstitialComplete);
      }
      
      public function isRewardedVideoAvailable(param1:String, param2:Boolean = true) : Boolean
      {
         if(FeatureFlags.DISABLE_ADS)
         {
            return false;
         }
         if(!loginM.isConnected)
         {
            return false;
         }
         if(param1 == BMScreenWatchRewardedVideo.PLACEMENT_COMPLETE_MISSION)
         {
            return false;
         }
         if(param2 && this.isPremiumAccountActive())
         {
            return false;
         }
         return BMAdsManager.gi().isRewardedVideoAvailable(param1);
      }
      
      public function showRewardedVideo(param1:String) : void
      {
         BMAdsManager.gi().addEventListener(BMAdsManagerEvents.ON_REWARDED_VIDEO_AD_REWARDED,this.onUserRewardedForWatchingVideo);
         BMAdsManager.gi().addEventListener(BMAdsManagerEvents.ON_REWARDED_VIDEO_SHOW_FAIL,this.onCannotShowRewardedVideo);
         this._isShowingAdvertisement = true;
         BMAdsManager.gi().showRewardedVideo(param1);
      }
      
      private function onUserRewardedForWatchingVideo(param1:Event) : void
      {
         var _loc2_:BMPlayerProfile = null;
         this._isShowingAdvertisement = false;
         BMAdsManager.gi().removeEventListener(BMAdsManagerEvents.ON_REWARDED_VIDEO_AD_REWARDED,this.onUserRewardedForWatchingVideo);
         BMAdsManager.gi().removeEventListener(BMAdsManagerEvents.ON_REWARDED_VIDEO_SHOW_FAIL,this.onCannotShowRewardedVideo);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         if(loginM.isConnected == false)
         {
            _loc2_ = this["player" + this.player1PlayerID + "Profile"];
            _loc2_.gold += this.supersonic_rewardedVideosMobile_gold;
            this.saveGuestData("onUserRewardedForWatchingVideo");
            screensM.screenConfirmation.displayQuestionOrNotification("rewardVideosGotGold",this.supersonic_rewardedVideosMobile_gold);
         }
         else
         {
            remoteM.socketM.rewardVideoWatched(this.rewardedVideo_placement);
         }
      }
      
      private function onCannotShowRewardedVideo(param1:Event) : void
      {
         this._isShowingAdvertisement = false;
         BMAdsManager.gi().removeEventListener(BMAdsManagerEvents.ON_REWARDED_VIDEO_AD_REWARDED,this.onUserRewardedForWatchingVideo);
         BMAdsManager.gi().removeEventListener(BMAdsManagerEvents.ON_REWARDED_VIDEO_SHOW_FAIL,this.onCannotShowRewardedVideo);
         screensM.screenConfirmation.displayQuestionOrNotification("rewardVideosComeBackLater");
         if(screensM.isScreenOpened(BMScreensManager.SCR_ITEM_CARDS))
         {
            screensM.screenItemCards.watchingVideoForExtraCardFailed();
         }
      }
      
      public function rateBox_initializeAndDisplay() : void
      {
         if(ApplicationRater.isSupported)
         {
            if(this._rateBoxInitialized)
            {
               this.rateBox_showRatingDialog();
               return;
            }
            ApplicationRater.service.setDialogTitle("Rate My App");
            ApplicationRater.service.setDialogMessage("If you like this app, please rate it 5 stars!");
            ApplicationRater.service.autoPrompt = true;
            ApplicationRater.service.setApplicationId("864103912",ApplicationRater.IMPLEMENTATION_IOS);
            ApplicationRater.service.retrieveApplicationId();
            NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE,this.rateBox_onInvoke);
            ApplicationRater.service.addEventListener(ApplicationRaterEvent.SELECTED_RATE,this.applicationRater_selectedRateHandler);
            ApplicationRater.service.addEventListener(ApplicationRaterEvent.SELECTED_LATER,this.applicationRater_selectedLaterHandler);
            ApplicationRater.service.addEventListener(ApplicationRaterEvent.SELECTED_DECLINE,this.applicationRater_selectedDeclineHandler);
            ApplicationRater.service.addEventListener(ApplicationIDEvent.RETRIEVED,function(param1:ApplicationIDEvent):void
            {
               rateBox_showRatingDialog();
            });
            this._rateBoxInitialized = true;
         }
      }
      
      public function rateBox_incrementEventCounter() : void
      {
         ApplicationRater.service.userDidSignificantEvent();
      }
      
      public function rateBox_showRatingDialog() : void
      {
         ApplicationRater.service.setDialogTitle(languageM.getText("rateBox_title"));
         ApplicationRater.service.setDialogMessage(languageM.getText("rateBox_description"));
         ApplicationRater.service.showRateDialog();
      }
      
      public function rateBox_showRatingsPageNow() : void
      {
         ApplicationRater.service.rate();
      }
      
      public function rateBox_resetRateBox() : void
      {
         ApplicationRater.service.reset();
      }
      
      private function rateBox_onInvoke(param1:InvokeEvent) : void
      {
         ApplicationRater.service.applicationLaunched();
      }
      
      private function applicationRater_selectedRateHandler(param1:ApplicationRaterEvent) : void
      {
         var _loc2_:BMPlayerProfile = null;
         screensM.screenConfirmation.displayUrgentMessage("rateBox_usedRated");
         _loc2_ = this["player" + this.player1PlayerID + "Profile"];
         _loc2_.rateStatus = "V";
         remoteM.socketM.lobby_setRateStatus("V");
      }
      
      private function applicationRater_selectedLaterHandler(param1:ApplicationRaterEvent) : void
      {
         var _loc2_:BMPlayerProfile = null;
         this.userDeclinedRatingForThisSession = true;
         _loc2_ = this["player" + this.player1PlayerID + "Profile"];
         _loc2_.rateStatus = "D";
         remoteM.socketM.lobby_setRateStatus("D");
      }
      
      private function applicationRater_selectedDeclineHandler(param1:ApplicationRaterEvent) : void
      {
         var _loc2_:BMPlayerProfile = null;
         _loc2_ = this["player" + this.player1PlayerID + "Profile"];
         _loc2_.rateStatus = "X";
         remoteM.socketM.lobby_setRateStatus("X");
      }
      
      public function callFSCommandPixel(param1:String, param2:String) : void
      {
         fscommand(param1,param2);
      }
      
      public function traceError(param1:String) : void
      {
         TsLogger.log("//////////////////");
         TsLogger.log("//////////////////");
         TsLogger.log("");
         TsLogger.log("ERROR : " + param1);
         TsLogger.log("");
         TsLogger.log("//////////////////");
         TsLogger.log("//////////////////");
      }
      
      public function setLanguageID(param1:uint) : void
      {
         if(this.languageID != param1)
         {
            this.languageID = param1;
            this.createInfoTextDB();
            this.createBattleInterfaceToolTipDB();
            this.saveLanguageData();
         }
      }
      
      public function getLanguageIcon(param1:uint = 0) : MovieClip
      {
         var _loc3_:String = null;
         var _loc2_:MovieClip = new MovieClip();
         if(param1 == 0)
         {
            param1 = this.languageID;
         }
         _loc3_ = languageM.getFlagIconNameByLanguageID(param1);
         return this.getLocalGraphicIcon(_loc3_);
      }
      
      public function getCensoredString(param1:String) : String
      {
         var _loc2_:uint = 0;
         var _loc3_:RegExp = null;
         _loc2_ = 0;
         while(_loc2_ < this.wordFilterDB.length)
         {
            _loc3_ = new RegExp(this.wordFilterDB[_loc2_].badWord,"/gi");
            param1 = param1.replace(_loc3_,this.wordFilterDB[_loc2_].fix);
            _loc2_++;
         }
         return param1;
      }
      
      public function traceItemsDB(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Object = null;
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         _loc2_ = new Array();
         for each(_loc3_ in this.itemsDB_online)
         {
            _loc2_[_loc3_.itemID] = _loc3_;
         }
         TsLogger.log("");
         TsLogger.log("");
         TsLogger.log("");
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_];
            if(_loc3_ != null)
            {
               _loc5_ = false;
               if(_loc3_.level > 24)
               {
                  if(param1 == "" || param1 == _loc3_.type)
                  {
                     _loc5_ = true;
                  }
               }
               if(_loc5_)
               {
                  _loc6_ = "";
                  _loc7_ = "";
                  _loc8_ = Number(_loc3_.itemID);
                  _loc6_ = "itemsDB_local[" + _loc8_ + "] = new Array(" + _loc3_.itemID + ",\'" + _loc3_.fullName + "\'," + _loc3_.sortID + "," + _loc3_.finalSortID + ",\'" + _loc3_.type + "\',\'" + _loc3_.subType + "\'," + _loc3_.level + "," + _loc3_.HPBase + "," + _loc3_.HPAddon + ",";
                  _loc6_ = _loc6_ + _loc3_.energyBase + "," + _loc3_.energyAddon + "," + _loc3_.heatBase + "," + _loc3_.heatAddon + "," + _loc3_.bullets + "," + _loc3_.rockets + "," + _loc3_.damageBase + "," + _loc3_.damageAddon + ",";
                  _loc6_ = _loc6_ + _loc3_.damageType + "," + _loc3_.damageHeat + "," + _loc3_.damageEnergy + "," + _loc3_.uses + "," + _loc3_.push + "," + _loc3_.resist1 + "," + _loc3_.resist2 + "," + _loc3_.resist3 + ",";
                  _loc6_ = _loc6_ + _loc3_.rangeBase + "," + _loc3_.rangeAddon + "," + _loc3_.stepsPerWalk + "," + _loc3_.stepsPerJump + "," + _loc3_.energyPerBlock + "," + _loc3_.heatPerBlock + "," + _loc3_.HPPerBlock + ",";
                  _loc6_ = _loc6_ + _loc3_.absorbRatio + "," + _loc3_.costHeat + "," + _loc3_.costEnergy + "," + _loc3_.costGold + "," + _loc3_.costTokens + ",\'";
                  _loc6_ = _loc6_ + _loc3_.animation + "\',\'" + _loc3_.grp + "\'," + _loc3_.specialStatus + "," + _loc3_.power + "," + _loc3_.weight + ");";
                  TsLogger.log(_loc6_);
               }
            }
            _loc4_++;
         }
         TsLogger.log("");
         TsLogger.log("");
      }
      
      private function createItemsDataBaseLocally() : void
      {
         this.itemsDB_local = LocalItemsDB.getItemsArray();
      }
      
      public function _createGacheMachineDBfromArray() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMGachaMachineData = null;
         this.gachaMachinesDB = new Dictionary(true);
         _loc1_ = 0;
         while(_loc1_ < this.gachaMachinesArray.length)
         {
            _loc2_ = this.gachaMachinesArray[_loc1_];
            this.gachaMachinesDB[_loc2_.gachaMachineID] = _loc2_;
            _loc1_++;
         }
      }
      
      public function getGacheMachine(param1:uint) : BMGachaMachineData
      {
         return this.gachaMachinesDB[param1];
      }
      
      public function hasGacheMachine(param1:uint) : Boolean
      {
         return this.gachaMachinesDB.hasOwnProperty(param1);
      }
      
      public function getLevelForXp(param1:int, param2:int = 0) : int
      {
         var _loc3_:int = 0;
         _loc3_ = param2;
         while(_loc3_ <= this.LEVEL_MAX)
         {
            if(param1 < this.levelUpDB[_loc3_])
            {
               return _loc3_ - 1;
            }
            _loc3_++;
         }
         return this.LEVEL_MAX;
      }
      
      public function getXpForLevel(param1:int) : int
      {
         if(param1 >= this.levelUpDB.length)
         {
            param1 = this.levelUpDB.length - 1;
         }
         return this.levelUpDB[param1];
      }
      
      public function isPremiumAccountActive() : Boolean
      {
         return this.premiumAccountTime > this.currentTime;
      }
      
      public function getPremiumPackage(param1:int) : BMPremiumPackageData
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.premiumPackages.length)
         {
            if(this.premiumPackages[_loc2_].id == param1)
            {
               return this.premiumPackages[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function hasHpBonus() : Boolean
      {
         return (this.isPremiumAccountActive() || this.myProfile.nextMissionBonus == BMPlayerProfile.MISSION_BONUS_HP) && !this.raidData.isRaidInProgress();
      }
      
      private function getABBucket() : String
      {
         if(this.appSharedObject.data.hasOwnProperty("abTestBucket"))
         {
            return this.appSharedObject.data.abTestBucket;
         }
         return "NeverHadUser";
      }
      
      public function setABBucket(param1:String) : void
      {
         TsLogger.log("Setting ABTestBucket to " + param1);
         this.appSharedObject.data.abTestBucket = param1;
      }
      
      public function getGeneralSetting(param1:String, param2:*, param3:Boolean = false) : *
      {
         if(this.generalSettings != null && this.generalSettings.hasOwnProperty(param1))
         {
            return this.generalSettings[param1];
         }
         if((param3 || tutorialM.isTutorialActive()) && BMGuestABTestManager.hasData() && BMGuestABTestManager.hasKey(param1))
         {
            return BMGuestABTestManager.getValue(param1);
         }
         return param2;
      }
      
      public function isNoneMovableTorso(param1:uint) : Boolean
      {
         return this.noneMovableTorsoItemIDs.indexOf(param1) > -1;
      }
      
      private function cheatEventHandler(param1:int, param2:int) : *
      {
         this.trackEvent(ANALYTICS_PRIORITY_HIGHEST,"Sec","Memory",param1.toString(),param2);
      }
      
      public function get shouldForceDoubleSpeed() : Boolean
      {
         return this.getGeneralSetting("forceDoubleSpeed",0) == 1;
      }
      
      public function get generalSpeedRatio() : Number
      {
         if(this.shouldForceDoubleSpeed)
         {
            return GENERAL_SPEED_RATIO_DOUBLE;
         }
         return this._generalSpeedRatio;
      }
      
      public function set generalSpeedRatio(param1:Number) : void
      {
         this._generalSpeedRatio = param1;
      }
      
      public function syncPlayerItemsWithServerData(param1:Object) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Array = null;
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:BMItemData = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Object = null;
         var _loc10_:uint = 0;
         var _loc11_:BMPlayerData = null;
         if(param1 == null)
         {
            return;
         }
         _loc2_ = 0;
         _loc3_ = new Array();
         _loc6_ = 1;
         while(_loc6_ <= this.battleMaxMechs)
         {
            for each(_loc9_ in param1[_loc6_])
            {
               _loc7_ = Math.max(_loc6_,_loc7_);
               _loc5_ = this.itemsDB_online[_loc9_.itemID];
               _loc9_.equipmentID = 0;
               _loc9_.type = _loc5_.type;
               if(_loc5_.isMultiEquipmentItem)
               {
                  _loc10_ = uint(int(_loc9_.slotName.substr(_loc9_.slotName.length - 1,1)));
                  _loc9_.equipmentID = _loc10_;
               }
               _loc4_ = this.getPlayerItemData(this.player1PlayerID,_loc9_.playerItemID);
               if(_loc4_.equipmentID != _loc9_.equipmentID)
               {
                  _loc4_.equipmentID = _loc9_.equipmentID;
                  _loc2_++;
                  TsLogger.log("WARNING 1: pve player equipment mismatch for playerItemID: " + _loc9_.playerItemID + " " + _loc5_.fullName);
               }
               if(_loc4_.equipped != _loc6_)
               {
                  _loc4_.equipped = _loc6_;
                  _loc2_++;
                  TsLogger.log("WARNING 2: pve player equipped mismatch for playerItemID: " + _loc9_.playerItemID + " " + _loc5_.fullName);
               }
               _loc3_.push(int(_loc9_.playerItemID));
            }
            _loc6_++;
         }
         _loc8_ = 0;
         while(_loc8_ < this.playersData[this.player1PlayerID].items.length)
         {
            _loc4_ = this.playersData[this.player1PlayerID].items[_loc8_];
            if(!(_loc4_.equipped == 0 || _loc4_.equipped > _loc7_))
            {
               if(_loc3_.indexOf(int(_loc4_.playerItemID)) == -1)
               {
                  _loc4_.resetEquippedData();
                  _loc2_++;
                  _loc5_ = this.itemsDB_online[_loc4_.itemID];
                  TsLogger.log("WARNING 3: pve player equipment mismatch for playerItemID: " + _loc4_.playerItemID + " " + _loc5_.fullName);
               }
            }
            _loc8_++;
         }
         if(_loc2_ > 0)
         {
            this.trackEvent(ANALYTICS_PRIORITY_HIGHEST,"Desync","PvE","itemsOutOfSync",_loc2_);
            _loc6_ = 1;
            while(_loc6_ <= 3)
            {
               this.updateMechStructure(this.player1PlayerID,_loc6_);
               _loc6_++;
            }
            _loc11_ = this.playersData[this.player1PlayerID];
            _loc11_.updateMechsWeight();
         }
      }
      
      public function AddInspectPlayersClanData(param1:BMClanData) : void
      {
         var _loc2_:* = 0;
         if(this.inspectPlayersClan.length > 0)
         {
            _loc2_ = int(this.inspectPlayersClan.length - 1);
            while(_loc2_ >= 0)
            {
               if(this.inspectPlayersClan[_loc2_].clanID == param1.clanID)
               {
                  this.inspectPlayersClan.splice(_loc2_,1);
               }
               _loc2_--;
            }
         }
         this.inspectPlayersClan.push(param1);
      }
      
      public function GetInspectClanData(param1:uint) : BMClanData
      {
         var _loc2_:BMClanData = null;
         for each(_loc2_ in this.inspectPlayersClan)
         {
            if(_loc2_.clanID == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get newVisualEffects() : Boolean
      {
         return int(this.getGeneralSetting("newVisualEffectsEnabled",0)) == 1;
      }
      
      public function useMissionGameplayImprovements(param1:uint, param2:uint) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         if(tutorialM.isTutorialActive())
         {
            return false;
         }
         if(this.raidData != null && this.raidData.isRaidInProgress())
         {
            return false;
         }
         if(int(this.getGeneralSetting("missionGameplayImprovements",0)) == 0)
         {
            return false;
         }
         _loc3_ = this.getGeneralSetting("highestMissionPerStoryID","");
         if(_loc3_ == "")
         {
            return false;
         }
         _loc4_ = _loc3_.split(",");
         if(_loc4_[param1] == null)
         {
            return false;
         }
         return _loc4_[param1] >= param2;
      }
      
      public function get missionExplosiveChainDamageReduction() : uint
      {
         return uint(this.getGeneralSetting("missionExplosiveChainDamageReduction",0));
      }
      
      public function get clanBossEnabled() : Boolean
      {
         return int(this.getGeneralSetting("clanBossEnabled",0)) == 1;
      }
      
      public function onAFConversionData(param1:AppsFlyerEvent) : void
      {
         TsLogger.log("!!!!!!!!!AND!!!!!!!!!!!!!    BMDataManager :: onAFConversionData()");
         TsLogger.log("\n-- Event: " + param1.type + "; \nData: " + param1.data + " \n");
      }
      
      private function storeKitPurchaseComplete(param1:AndroidStoreEvent) : void
      {
         TsLogger.log("!!!!!!!!AND!!!!!!!!!!!!!!    BMDataManager :: storeKitPurchaseComplete()");
         if(param1.data != null)
         {
            this.afInterface.setCurrency(param1.data.localizedCurrency);
         }
      }
   }
}

