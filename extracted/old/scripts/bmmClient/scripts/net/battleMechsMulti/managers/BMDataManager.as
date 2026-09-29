package net.battleMechsMulti.managers
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.external.ExternalInterface;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
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
   import flash.utils.getDefinitionByName;
   import libraries.uanalytics.tracker.AppTracker;
   import libraries.uanalytics.tracker.WebTracker;
   import libraries.uanalytics.tracking.Configuration;
   import libraries.uanalytics.tracking.Tracker;
   import net.battleMechsMulti.data.InstallationData;
   import net.battleMechsMulti.data.LocalItemsDB;
   import net.battleMechsMulti.managers.ads.BMAdsManager;
   import net.battleMechsMulti.managers.ads.BMAdsManagerEvents;
   import net.battleMechsMulti.managers.notifications.BMNotificationData;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   import net.battleMechsMulti.mobiles.BMAvatarImage;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMBoostData;
   import net.battleMechsMulti.mobiles.BMChatMessageData;
   import net.battleMechsMulti.mobiles.BMFriendshipData;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.BMReplayAction;
   import net.battleMechsMulti.mobiles.BMReplayData;
   import net.battleMechsMulti.mobiles.BMReplayStatus;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.BMTokenPackage;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapBossData;
   import net.battleMechsMulti.mobiles.worldMap.BMWorldMapLocationData;
   import net.battleMechsMulti.session.BMDomainResolver;
   import net.battleMechsMulti.session.BMPlatformUtils;
   import net.battleMechsMulti.session.LoginServices;
   import net.battleMechsMulti.utils.TokenPolling;
   import net.battlegate.utils.SnowplowAnalyticsDispatcher;
   import net.tacticsoft.global.BMMClientFlashVars;
   import net.tacticsoft.utils.DetectedSettings;
   
   public class BMDataManager extends BMBaseClass
   {
      
      private static var _instance:BMDataManager;
      
      private static var _allowInstantiation:Boolean;
      
      private static const UNIVERSAL_ANALYTICS_TRACKING_ID:String = "UA-1665200-12";
      
      public static const NEWS_CATEGORY_SALE:Number = 1;
      
      public static const TUTORIAL_LEVEL_NOT_SET:uint = 0;
      
      public static const TUTORIAL_LEVEL_MECH1:uint = 1;
      
      public static const TUTORIAL_LEVEL_LONE_BATTLE1:uint = 2;
      
      public static const TUTORIAL_LEVEL_MECH2:uint = 3;
      
      public static const TUTORIAL_LEVEL_LONE_BATTLE2:uint = 4;
      
      public static const TUTORIAL_LEVEL_MECH3:uint = 5;
      
      public static const TUTORIAL_LEVEL_MISSION1:uint = 6;
      
      public static const TUTORIAL_LEVEL_SHOP1:uint = 7;
      
      public static const TUTORIAL_LEVEL_MECH4:uint = 8;
      
      public static const TUTORIAL_LEVEL_MISSION2:uint = 9;
      
      public static const TUTORIAL_LEVEL_MECH5:uint = 10;
      
      public static const TUTORIAL_LEVEL_FUSION:uint = 11;
      
      public static const TUTORIAL_LEVEL_SHOP2:uint = 12;
      
      public static const TUTORIAL_LEVEL_MISSION3:uint = 13;
      
      public static const TUTORIAL_LEVEL_COMPLETED:uint = 14;
      
      public static const TUTORIAL_DESTINATION_NONE:uint = 0;
      
      public static const TUTORIAL_DESTINATION_MECH:uint = 1;
      
      public static const TUTORIAL_DESTINATION_FUSION:uint = 2;
      
      public static const TUTORIAL_DESTINATION_SHOP:uint = 3;
      
      public static const TUTORIAL_DESTINATION_LONE_BATTLE:uint = 4;
      
      public static const TUTORIAL_DESTINATION_MISSION:uint = 5;
      
      public static const GAME_TYPE_NONE:uint = 0;
      
      public static const GAME_TYPE_GUEST:uint = 1;
      
      public static const GAME_TYPE_ONLINE:uint = 2;
      
      public static const GAME_TYPE_REPLAY:uint = 3;
      
      public static const GAME_SUB_TYPE_NONE:uint = 0;
      
      public static const GAME_SUB_TYPE_REPLAY_RANKING_LIST_INSPECT:uint = 1;
      
      public static const GAME_SUB_TYPE_REPLAY_CLAN_INSPECT:uint = 2;
      
      public static const GAME_SUB_TYPE_REPLAY_MENU_CHAT_INSPECT:uint = 3;
      
      public static const GAME_SUB_TYPE_REPLAY_SMTV:uint = 4;
      
      public static const GAME_SUB_TYPE_REPLAY_REGULAR:uint = 5;
      
      public static const MAP_THEME_DESERT:uint = 1;
      
      public static const MAP_THEME_SNOW:uint = 2;
      
      public static const MAP_THEME_CITY:uint = 3;
      
      public static const MAP_THEME_FOREST:uint = 4;
      
      public static const MAP_THEME_SEA:uint = 5;
      
      public static const MAP_THEME_WASTELAND:uint = 6;
      
      public static const MAP_THEME_LAVA:uint = 7;
      
      public static const MAP_THEME_TOWER:uint = 8;
      
      public static const MAP_THEME_SWAMP:uint = 9;
      
      private var universalAnalyticsTracker:Tracker;
      
      private var snowplowAnalyticsTracker:SnowplowAnalyticsDispatcher;
      
      public var clientVersion:String;
      
      public var flashVars:BMMClientFlashVars;
      
      public var bmmSessionSO:SharedObject;
      
      public var useNoConnectionMode:Boolean = false;
      
      public var firstSocketConnectionEstablished:Boolean = false;
      
      public var noConnectionModeActive:Boolean = false;
      
      public var guestSharedObject:SharedObject;
      
      public var guestSharedObjectExists:Boolean = false;
      
      public var guestRegistrationActive:Boolean = false;
      
      public var guestGenerateUserActive:Boolean = false;
      
      public var perUserSharedObject:SharedObject;
      
      public var perUserSharedObjectExists:Boolean = false;
      
      public var sessionID:String = "";
      
      public var uniqueID:String = "";
      
      public var userName:String = "";
      
      public var userEmail:String = "";
      
      public var playerbaseID:uint = 0;
      
      public var userID:Number = 0;
      
      public var userbase:uint;
      
      public var clientRunningLocally:Boolean;
      
      public var lastLoginFromFacebook:Boolean = false;
      
      public var login_userTriedToLogin:Boolean = false;
      
      public var alreadySeenPlayingOnDevAlert:* = false;
      
      public var runAsMobile:Boolean = false;
      
      public var advertisingCampaignID:Number = 0;
      
      public var weightMax:uint = 1000;
      
      public var ladderProgressBase:uint;
      
      public var ladderRankMax:uint;
      
      public var campaignBattleType:uint = 1;
      
      public var battleMaxMechs:uint = 3;
      
      public var inventoryMaxMechs:uint = 3;
      
      public var freeTokens_amount:uint = 10;
      
      public var freeTokens_cooldown:uint = 86400;
      
      public var missionUpgrade_hpRatio:uint = 50;
      
      public var missionUpgrade_energyRatio:uint = 25;
      
      public var missionUpgrade_heatRatio:uint = 25;
      
      public var missionUpgrade_ammoRatio:uint = 50;
      
      public var missionBuy1HardTokensCost:uint = 20;
      
      public var missionBuy6HardTokensCost:uint = 100;
      
      public var missionBuy1InsaneTokensCost:uint = 30;
      
      public var missionBuy6InsaneTokensCost:uint = 150;
      
      public var mission_playerMechStatus:String = "";
      
      public var mission_playerMechDirection:String = "";
      
      public var mission_battleEnded:Boolean = false;
      
      public var mission_battleEnded_playerWon:Boolean = false;
      
      public var mission_battleEnded_hp:uint;
      
      public var mission_battleEnded_bullets:uint;
      
      public var mission_battleEnded_rockets:uint;
      
      public var mission_battleRow:uint;
      
      public var mission_battleColumn:uint;
      
      public var mission_battleEnemyType:String;
      
      public var mission_destroyingMapObjectActive:Boolean;
      
      public var mission_destroyingMapObjectRow:uint;
      
      public var mission_destroyingMapObjectColumn:uint;
      
      public var mission_destroyingMapObjectFrameCounter:uint;
      
      public var missionWorldMap_missionCompletedSlot:Number = -1;
      
      public var mechEquipment_playerItemIDsUpgraded:Object = new Object();
      
      public var welcomeScreenInitialized:Boolean = false;
      
      public var register_termsOfUseChecked:Boolean = false;
      
      public var tutorialEnabled:Boolean = false;
      
      public var supersonic_mobile_afterWins:uint = 0;
      
      public var supersonic_mobile_SPMP:uint = 0;
      
      public var supersonic_useRewardedVideosMobile:Boolean = false;
      
      public var supersonic_rewardedVideosMobile_maxPerDay:uint = 0;
      
      public var supersonic_rewardedVideosMobile_tokens:uint = 0;
      
      public var supersonic_rewardedVideosMobile_gold:uint = 2500;
      
      public var rewardedVideo_tokensReward:Boolean;
      
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
      
      public var battle_backgroundID:Number = 1;
      
      public var onlinePlayersInspect_playerID:Number = 0;
      
      public var chat_initialized:Boolean = false;
      
      public var chat_messages_winningWall:Array = new Array();
      
      public var chat_pendingClanMessages:uint = 0;
      
      public var chat_lastChatChannel:uint = 0;
      
      public var chat_gotRecentClanMessagesThisLogin:Boolean = false;
      
      public var chat_channels:Array = new Array();
      
      public var chat_channelsServer:Array = new Array();
      
      public var chat_channelsAdmins:Array = new Array();
      
      public var chat_channelsClan:Array = new Array();
      
      public var chat_channelsClanMembers:Array = new Array();
      
      public var chat_channelsRegular:Array = new Array();
      
      public var chat_log:Object = new Object();
      
      public var chat_winningWallTexts:Array = new Array();
      
      public var chat_differentUserConnected:Boolean = true;
      
      public var chat_playersData:Object = new Object();
      
      public var chat_totalPlayersInLobby:uint = 0;
      
      public var chat_goToClanChat:Boolean = false;
      
      public var chat_goToSpecificPlayerChatPlayerID:Number = 0;
      
      public var chat_goToInspectPlayerID:Number = 0;
      
      public var chat_goToChatAfterBattleUserID:Number = 0;
      
      public var chat_inviteToClanAfterBattleUserID:Number = 0;
      
      public var chat_addPlayerDataAfterBattleName:String;
      
      public var chat_addPlayerDataAfterBattleClanID:Number;
      
      public var chat_addPlayerDataAfterBattleLevel:uint;
      
      public var chat_addPlayerDataAfterBattleGeo:String;
      
      public var chat_addPlayerDataAfterBattleLadderProgress:uint;
      
      public var chat_sendMessageCooldown:uint = 0;
      
      public var replays_loaded:Boolean = false;
      
      public var topBar_levelUpInProgress:Boolean = false;
      
      public var hanger_newItemsForDisplay:Array = new Array();
      
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
      
      public var logOutClicked:Boolean = false;
      
      public var useClientIsAlive:Boolean = false;
      
      public var useChatBlocks:Boolean = false;
      
      public var chatBlocksRemain:Number = 6;
      
      public var chatBlocksPlayerIDs:Object = new Object();
      
      public var iAmBannedFromChat:Boolean = false;
      
      public var clanWinsGiveReward:Boolean = false;
      
      public var clanWinsRewardType:String;
      
      public var clanWinsRewardValue:Number;
      
      public var clanWinsWinsRequired:Number;
      
      public var clan_tryToAcceptPlayerID:Number = 0;
      
      public var maxItemsPerOnePurchase:uint = 1;
      
      public var showMythicalsStats:Boolean = true;
      
      public var weeklyTopClanRewards:Array;
      
      public var newItemsCreated:Array = new Array();
      
      public var inspectPlayersStatistics:Object = new Object();
      
      public var inspectPlayersClan:Object = new Object();
      
      public var useChatRank1Channels:Boolean = false;
      
      public var useMissionWorldMapInterface:Boolean = false;
      
      public var useMissionWorldMapInterface_web:Boolean = false;
      
      public var levelRequired3V3:uint = 20;
      
      public var useMultipleMechsKitsFix:Boolean = false;
      
      public var destroyMechDamageAddon:Number = 10;
      
      public var itemsDB:Object;
      
      public var itemTypesDB:Array;
      
      public var itemTypesReverseDB:Array;
      
      public var shopItemTypesDB:Array;
      
      public var shopItemTypesReverseDB:Array;
      
      public var shopItemTypesSourceDB:Array;
      
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
      
      public var subTypeOriginDB:Object;
      
      public var subTypeOriginDB_myth:Object;
      
      public var subTypeOriginDB_combined:Object;
      
      public var combinedShopItemIDsPerSubType:Object;
      
      public var replaysDB:Object;
      
      public var loginReplaysDB:Object;
      
      public var levelUpDB:Array;
      
      public var itemTypeSourceDB:Array;
      
      public var colorsDB:Array;
      
      public var boostsDB:Array;
      
      public var battleInterfaceToolTipDB:Object;
      
      public var techDB:Object;
      
      public var tipsDB:Array;
      
      public var musicDB:Array;
      
      public var newsDB:Object;
      
      public var achievementsDB:Object;
      
      public var achievementsSortedDB:Object;
      
      public var helpDB:Array;
      
      public var itemsMaxLevelsDB:Object;
      
      public var wheelsDB:Object;
      
      public var allTokenPackages:Array;
      
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
      
      private var computerNamesDB:Array;
      
      public var missionsDB:Array;
      
      public var missionBossesDB:Array;
      
      public var missionsItemBoxSlots:Object = new Object();
      
      private var missionLayouts_tutorial:Array;
      
      private var missionLayouts_regular:Array;
      
      private var guestFixedItemsDB:Array;
      
      private var missionDisplayNumbers:Array;
      
      public var usePerks:Boolean = false;
      
      public var rankingList_allTime:Object;
      
      public var rankingList_weekly:Object;
      
      public var rankingList_online:Object;
      
      public var playersGeneralData:Object = new Object();
      
      public var inspectPlayerData:Object;
      
      public var itemsDB_online:Object;
      
      private var itemsDB_local:Object;
      
      public var replaysDB_online:Object = new Object();
      
      public var replaysDB_offline:Object = new Object();
      
      public var replaysDB_inspect:Object = new Object();
      
      public var player1PlayerID:Number;
      
      public var player2PlayerID:Number;
      
      public var playersData:Array = new Array();
      
      public var playingVSComputer:Boolean = false;
      
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
      
      public var battle_syncData:Object = new Object();
      
      public var starterPack_goBackToScreen:String = "";
      
      public var starterPack_displayAfterOnlineBattleCounter:uint = 3;
      
      public var starterPack_displayAfterSinglePlayerMissionCounter:uint = 3;
      
      public var createComputerMechs:Boolean = true;
      
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
      
      public var playerData1MechStructure1:BMMechStructure;
      
      public var playerData1MechStructure2:BMMechStructure;
      
      public var playerData1MechStructure3:BMMechStructure;
      
      public var playerData2MechStructure1:BMMechStructure;
      
      public var playerData2MechStructure2:BMMechStructure;
      
      public var playerData2MechStructure3:BMMechStructure;
      
      public var playerData3MechStructure1:BMMechStructure;
      
      public var playerData3MechStructure2:BMMechStructure;
      
      public var playerData3MechStructure3:BMMechStructure;
      
      public var playerData4MechStructure1:BMMechStructure;
      
      public var playerData4MechStructure2:BMMechStructure;
      
      public var playerData4MechStructure3:BMMechStructure;
      
      public var playerData5MechStructure1:BMMechStructure;
      
      public var playerData5MechStructure2:BMMechStructure;
      
      public var playerData5MechStructure3:BMMechStructure;
      
      public var playerData6MechStructure1:BMMechStructure;
      
      public var playerData6MechStructure2:BMMechStructure;
      
      public var playerData6MechStructure3:BMMechStructure;
      
      public var playerData7MechStructure1:BMMechStructure;
      
      public var playerData7MechStructure2:BMMechStructure;
      
      public var playerData7MechStructure3:BMMechStructure;
      
      public var playerData8MechStructure1:BMMechStructure;
      
      public var playerData8MechStructure2:BMMechStructure;
      
      public var playerData8MechStructure3:BMMechStructure;
      
      public var playerData9MechStructure1:BMMechStructure;
      
      public var playerData9MechStructure2:BMMechStructure;
      
      public var playerData9MechStructure3:BMMechStructure;
      
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
      
      public var cheatWeaponDamage:Number = 1110;
      
      public var cheatWeaponDamageComputer:Number = 0;
      
      public var cheatWeaponResistance:Number = 0;
      
      public var cheatExtraHeat:Number = 0;
      
      public var usersOnline:Object = new Object();
      
      public var usersInBattle_ladder:Number = 0;
      
      public var usersInBattle_invitation:Number = 0;
      
      public var usersInBattle_computer:Number = 0;
      
      public var usersSearching:Number = 0;
      
      public var userDeclinedRatingForThisSession:Boolean = false;
      
      public var searchForBattleLevelChangeSeconds:Number = 0;
      
      public var battleInvitations:Object = new Object();
      
      public var clanInvitations:Object = new Object();
      
      public var battleInvitationsEnabled:Boolean = true;
      
      public var breathingEffect:Boolean = true;
      
      public var particleEffects:Boolean = false;
      
      public var seeOpponentPerks:Boolean = true;
      
      public var movieClipParticleEffects:Boolean = true;
      
      public var movieClipParticleEffectsLevel:Number = 1;
      
      public var movieClipParticleEffectsRatio:Number = 0.25;
      
      public var computerBattleID:Number = 0;
      
      public var tryToAddFriend_username:String;
      
      public var currentTime:Number = 0;
      
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
      
      public var dailyLoginStreakData:Array;
      
      public var dailyLoginStreakBonus:Object = new Object();
      
      public var dailyLoginStreakBonusMythical:Boolean = false;
      
      public var battleCreditsMax:uint = 15;
      
      public var battleCreditsMax_supporters:uint = 15;
      
      public var useBattleCreditsPriceIncrease:Boolean = false;
      
      public var nextBattleCreditsPriceReset:Number = 0;
      
      public var battleCreditsPriceSecondsToReset:Number = 0;
      
      public var battleCreditsPriceIncrease:Number = 0;
      
      public var secondsForNewBattleCredit:Number = 1200;
      
      public var secondsForNewBattleCredit_supporters:Number = 1200;
      
      public var battleCreditX1CostGold:uint = 3000;
      
      public var battleCreditX1CostGold_supporters:uint = 3000;
      
      public var battleCreditX6CostGold:uint = 15000;
      
      public var battleCreditX6CostGold_supporters:uint = 15000;
      
      public var useBattleCreditsCap:Boolean = false;
      
      public var battleCreditsCap:uint = 99;
      
      public var goldPerToken:uint = 1000;
      
      public var clanMaxMembers:uint = 6;
      
      public var createClanCost:Number = 5000;
      
      public var clansRankingList:Object;
      
      public var clansAroundMyLadderProgress:Object;
      
      public var useNameChange:Boolean = false;
      
      public var nameChangeCostTokensBase:uint = 0;
      
      public var nameChangeCostTokensAddon:uint = 0;
      
      public var bonusTokensPerLevelUp:uint = 10;
      
      public var bonusTokensForLevel3:uint = 100;
      
      public var useLanguages:Boolean = false;
      
      public var languageFontType:Array = new Array(0,1,1,2,1,1,2,2,2,2,2);
      
      public var replayInspectedPlayerIDs:Array = new Array();
      
      public var allowNameChangeAfterRegister:Boolean = false;
      
      public var setLastNewsIDForANewUser:Boolean = false;
      
      public var skipChallenge:Boolean = false;
      
      public var itemsBoxShop:Boolean = true;
      
      public var languageID:Number = 1;
      
      public var clientLastLanguageID:Number = 1;
      
      public var nextWeeklyReset:String = "";
      
      public var specialUser:Boolean = false;
      
      public var kitsMax:uint = 2;
      
      public var modulesMax:uint = 7;
      
      public var useRateBox:Boolean = false;
      
      public var rateBoxRankRequired:Number = 5;
      
      public var serverRestartTimeDisplay:Number = 0;
      
      private var _rateBoxInitialized:Boolean = false;
      
      private var _createSpecificMechMaxMythicals:Number;
      
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
      
      public var blockedBattleInvitations:Object = new Object();
      
      public var tutorialSkipped:Boolean = false;
      
      public var weeklySoloWinners:Object = new Object();
      
      public var weeklyClanWinners:Object = new Object();
      
      public var weeklyTopClans:Object = new Object();
      
      public var chatDefaultLanguageID:Number = 0;
      
      public var levelForExpandedItemBox:uint = 15;
      
      public var resetRankingListTimer:Boolean = false;
      
      public var dailyBonusOptions:Array = new Array();
      
      public var dungeonMechStructures:* = new Array();
      
      public var dungeonDifficulty:uint = 0;
      
      public var allowSlowCPUMode:Boolean = false;
      
      public var slowCPUModeActivateFPS:Number = 24;
      
      public var slowCPUModeDeactivateFPS:Number = 27;
      
      public var slowCPUMode:Boolean = false;
      
      public var generalSpeedRatio:Number = 1;
      
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
      
      public var useItemComparisonOnInventoryItemClick:Boolean = false;
      
      public var useItemComparisonOnMechItemRollOver:Boolean = true;
      
      public var activeBoosts:Array = new Array();
      
      public var activeBoostsMobile:Array = new Array();
      
      public var sendTokens_allow:Boolean = false;
      
      public var sendTokens_tokensSpentRequired:Number = 0;
      
      public var sendTokens_daysFromFirstPaymentRequired:Number = 0;
      
      public var sendTokens_minTokensToSend:uint = 0;
      
      public var useGooglePlayTempButtons:Boolean = false;
      
      public var getTokens_displayAfterOnlineBattleCounter:uint = 0;
      
      public var getTokens_displayAfterSinglePlayerMissionCounter:uint = 0;
      
      public var battle_gamePaused:Boolean = false;
      
      private var avatarImages:Object = new Object();
      
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
      
      private var ladderRankByProgress:Array;
      
      private var ladderProgressMaxByRank:Array;
      
      private var itemIDsForbiddenForPC:Object;
      
      private var itemIDsAllowedForPC:Array;
      
      public var ladderRanksPerStar:uint = 2;
      
      public var installationData:InstallationData;
      
      private var shopItemDiscountTextFormat:TextFormat;
      
      public const MAX_SIDE_WEAPONS:Number = 4;
      
      public const MAX_TOP_WEAPONS:Number = 2;
      
      public const MAX_DRONES:Number = 1;
      
      public const MAX_TELEPORTS:Number = 1;
      
      public const MAX_SHIELDS:Number = 1;
      
      public const MAX_CHARGES:Number = 1;
      
      public const MAX_HARPOONS:Number = 1;
      
      public const MAX_KITS:Number = 2;
      
      public const MAX_MODULES:Number = 7;
      
      public const MAX_TAUNTS:Number = 6;
      
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
      
      public const OFFLINE_PLAYER_ID:Number = 1;
      
      public const OFFLINE_OPPONENT_ID:Number = 2;
      
      public const ONLINE_PLAYER_ID:Number = 3;
      
      public const ONLINE_OPPONENT_ID:Number = 4;
      
      public const REPLAY_PLAYER1_ID:Number = 5;
      
      public const REPLAY_PLAYER2_ID:Number = 6;
      
      public const INSPECT_PLAYER_ID:Number = 7;
      
      public const TUTORIAL_TORSO_ID:Number = 23;
      
      public const TUTORIAL_LEG_ID:Number = 2;
      
      public const TUTORIAL_WEAPON_ID:Number = 3;
      
      public const TUTORIAL_BUY_TORSO1_ID:Number = 153;
      
      public const TUTORIAL_BUY_TORSO2_ID:Number = 155;
      
      public const TUTORIAL_BUY_SIDE_WEAPON1_ID:Number = 197;
      
      public const TUTORIAL_BUY_SIDE_WEAPON2_ID:Number = 161;
      
      public const TUTORIAL_BUY_SIDE_WEAPON3_ID:Number = 176;
      
      public const TUTORIAL_BUY_SIDE_WEAPON4_ID:Number = 162;
      
      public const TUTORIAL_BUY_TOP_WEAPON1_ID:Number = 708;
      
      public const TUTORIAL_BUY_KIT_ID:Number = 17;
      
      public const TUTORIAL_BUY_MODULE_ID:Number = 56;
      
      public const TUTORIAL_BOX_LEG_ID:Number = 35;
      
      public const TUTORIAL_BOX_DRONE_ID:Number = 1;
      
      public const TUTORIAL_BOX_MODULE_ID:Number = 25;
      
      public const TUTORIAL_BATTLES:Number = 3;
      
      public const MENU_TUTORIAL_BATTLES:Number = 4;
      
      public const WINS_VS_COMPUTER_REQUIRED_FOR_LADDER:Number = 2;
      
      public const STAGE_WIDTH:Number = 800;
      
      public const STAGE_HEIGHT:Number = 480;
      
      public const RARITY_COMMON:Number = 0;
      
      public const RARITY_RARE:Number = 1;
      
      public const RARITY_EPIC:Number = 2;
      
      public const RARITY_LEGENDARY:Number = 3;
      
      public const LEVEL_MAX:Number = 30;
      
      public const CHAT_LANGUAGES:uint = 6;
      
      public const CHAT_CLAN_CHANNEL_PLAYER_ID:uint = 10;
      
      public const CHAT_ONLINE_PLAYER_LADDER_PROGRESS_DIFFERENCE:uint = 10;
      
      public const WINNING_WALL_MAX_MESSAGES:Number = 6;
      
      public var GUEST_MAX_ITEMS:Number = 40;
      
      public var GUEST_MAX_LEVEL:Number = 10;
      
      public var GUEST_MAX_GOLD:Number = 75000;
      
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
      
      public const COLOR_FRIEND:String = "33CC00";
      
      public const COLOR_REGULAR_PLAYER:String = "FF9900";
      
      public const COLOR_SELF:String = "0099FF";
      
      public const COLOR_TIP:String = "FFCC66";
      
      public const COLOR_ADMIN:String = "993399";
      
      public const COLOR_SERVER:String = "FFCC00";
      
      public const COLOR_PRIVATE_MESSAGE:String = "FF6699";
      
      public const COLOR_CLAN_MESSAGE:String = "669966";
      
      public const COLOR_TEXT:String = "DDDDDD";
      
      public const COLOR_BATTLE_INVITATION:String = "FFCC00";
      
      public const COLOR_RARE_ITEM:String = "0099FF";
      
      public const COLOR_EPIC_ITEM:String = "9C3399";
      
      public const COLOR_LEGENDARY_ITEM:String = "FF9900";
      
      public const COLOR_MYTHICAL_ITEM:String = "FF6633";
      
      private const COLOR_MYTHICAL_ITEM_DARK:String = "3A0B00";
      
      public const COLOR_PERK:String = "FFFF33";
      
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
      
      public function BMDataManager()
      {
         this.userbase = GlobalAccess.userbase;
         super();
         if(!_allowInstantiation)
         {
            throw new Error("Error: Instantiation failed: Use BMDataManager.getInstance() instead of new.");
         }
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
      
      public function get sessionManager() : BMSessionManager
      {
         return screensM.clientPointer.sessionManager;
      }
      
      public function getPlatformStoreProducts() : Array
      {
         return null;
      }
      
      public function get arePlatformStoreProductsAvailable() : Boolean
      {
         return true;
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
         this.snowplowAnalyticsTracker = new SnowplowAnalyticsDispatcher(GlobalAccess.stage);
         this.snowplowAnalyticsTracker.setPlatform(BMPlatformUtils.sourcePlatform);
         if(this.userID > 0)
         {
            this.trackSetUserID(this.userID.toString());
         }
         this.snowplowAnalyticsTracker.setDeviceId(this.installationData.deviceId);
         this.snowplowAnalyticsTracker.startAppSessionTracking();
      }
      
      public function trackSetUserID(param1:String) : *
      {
         if(this.universalAnalyticsTracker != null)
         {
            this.universalAnalyticsTracker.set(Tracker.USER_ID,param1);
         }
         if(this.snowplowAnalyticsTracker != null)
         {
            this.snowplowAnalyticsTracker.setUserId(param1);
         }
      }
      
      public function trackEvent(param1:String, param2:String, param3:String = null, param4:Number = NaN) : void
      {
         TsLogger.log("BMDataManager::trackEvent(" + param1 + "," + param2 + "," + param3 + "," + param4 + ")");
         this.trackEventUAnalytics(param1,param2,param3,param4);
         this.trackEventGAnalytics(param1,param2,param3,param4);
         this.trackEventAppsFlyer(param1,param2,param3,param4);
         this.trackSnowplowAnalyticsEvent(param1,param2,param3,param4);
      }
      
      private function trackSnowplowAnalyticsEvent(param1:String, param2:String, param3:String, param4:Number) : void
      {
         var _loc5_:int = 0;
         if(!isNaN(param4))
         {
            _loc5_ = int(param4);
         }
         this.snowplowAnalyticsTracker.trackStructuredEvent(param1,param2,param3,"NULL",_loc5_);
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
      }
      
      public function trackScreenView(param1:String) : *
      {
         this.universalAnalyticsTracker.screenview(param1);
         this.trackGAnalyticsScreenView(param1);
         this.trackAppsFlyerScreenView(param1);
         this.snowplowAnalyticsTracker.trackScreenView(param1);
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
         this.trackEvent(_loc3_,param1,param2);
      }
      
      public function initialize() : void
      {
         TsLogger.log("BMDataManager initialized");
         generateSingletonClassesPointers("dataManager");
         this.installationData = new InstallationData();
         this.initAnalytics();
         this.trackScreenView("Start");
         if(DetectedSettings.isMobile)
         {
            this.runAsMobile = true;
         }
         this.useGooglePlayTempButtons = false;
         if(false)
         {
            this.runAsMobile = true;
         }
         if(this.runAsMobile)
         {
            if(false && false == false)
            {
               this.useLanguages = true;
            }
         }
         else
         {
            this.useLanguages = true;
         }
         this.itemsMaxLevelsDB = new Object();
         this.itemsMaxLevelsDB["torso"] = 10;
         this.itemsMaxLevelsDB["leg"] = 10;
         this.itemsMaxLevelsDB["sideWeapon"] = 10;
         this.itemsMaxLevelsDB["topWeapon"] = 10;
         this.itemsMaxLevelsDB["drone"] = 10;
         this.itemsMaxLevelsDB["shield"] = 10;
         this.itemsMaxLevelsDB["teleport"] = 10;
         this.itemsMaxLevelsDB["charge"] = 10;
         this.itemsMaxLevelsDB["harpoon"] = 10;
         this.itemsMaxLevelsDB["kit_repair"] = 10;
         this.itemsMaxLevelsDB["kit_energy"] = 10;
         this.itemsMaxLevelsDB["kit_heat"] = 10;
         this.itemsMaxLevelsDB["kit_bullets"] = 10;
         this.itemsMaxLevelsDB["kit_rockets"] = 10;
         this.itemsMaxLevelsDB["kit_resistance"] = 10;
         this.itemsMaxLevelsDB["kit_power"] = 10;
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
         this.inspectPlayerData = new Object();
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
         if(this.bmmSessionSO.data.userData != null)
         {
            if(this.bmmSessionSO.data.userData.session != null && this.bmmSessionSO.data.userData.session.SERVER != null)
            {
               if(this.bmmSessionSO.data.userData.session.SERVER.GEOIP_COUNTRY_CODE != null)
               {
                  switch(this.bmmSessionSO.data.userData.session.SERVER.GEOIP_COUNTRY_CODE)
                  {
                     case "DE":
                        this.chatDefaultLanguageID = 1;
                        break;
                     case "ES":
                        this.chatDefaultLanguageID = 2;
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
         if(false)
         {
            this.clientRunningLocally = false;
         }
         if(this.clientRunningLocally)
         {
            this.useGooglePlayTempButtons = true;
         }
         this.usePerks = true;
      }
      
      public function isPlayerIDAdmin(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         switch(param1)
         {
            case 56:
            case 799:
            case 9195889:
            case 9227227:
               _loc2_ = true;
         }
         return _loc2_;
      }
      
      public function initializeOfflineModeForPlayer() : void
      {
         var _loc1_:BMPlayerProfile = null;
         screensM.startCurrentTimeTimer();
         this.createProfile(this.OFFLINE_PLAYER_ID,this.userName,1);
         if(this.guestSharedObjectExists)
         {
            this.loadSharedObjectGuestData();
         }
         else
         {
            _loc1_ = this["player" + this.player1PlayerID + "Profile"];
            _loc1_.gold = 1000;
            _loc1_.battleCredits = this.battleCreditsMax;
            this.createInventoryLocally(this.OFFLINE_PLAYER_ID,1);
         }
         this.createMechLocally(this.OFFLINE_PLAYER_ID,1);
         this.createPlayerData(this.OFFLINE_PLAYER_ID,"initializeOfflineModeForPlayer");
      }
      
      public function initializeOnlineMode() : void
      {
         this.createPlayerData(this.ONLINE_PLAYER_ID,"initializeOnlineMode");
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
      
      public function isConnectedToService(param1:String) : Boolean
      {
         return this.sessionManager.isExternalLoggedIn(param1);
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
      
      public function setGameTypeAndPlayers(param1:uint, param2:uint = 0, param3:String = "") : void
      {
         this.gameType = param1;
         this.gameSubType = param2;
         switch(param1)
         {
            case BMDataManager.GAME_TYPE_NONE:
               this.player1PlayerID = 0;
               this.player2PlayerID = 0;
               this.itemsDB = null;
               this.replaysDB = null;
               break;
            case BMDataManager.GAME_TYPE_GUEST:
               this.player1PlayerID = this.OFFLINE_PLAYER_ID;
               this.player2PlayerID = this.OFFLINE_OPPONENT_ID;
               this.itemsDB = this.itemsDB_local;
               break;
            case BMDataManager.GAME_TYPE_ONLINE:
               this.player1PlayerID = this.ONLINE_PLAYER_ID;
               this.player2PlayerID = this.ONLINE_OPPONENT_ID;
               this.itemsDB = this.itemsDB_online;
               BMSpecialOffersManager.gi().refreshSpecialOffersBoostIDs();
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
                     this.player1PlayerID = this.REPLAY_PLAYER1_ID;
                     this.player2PlayerID = this.REPLAY_PLAYER2_ID;
                     this.replaysDB = this.replaysDB_inspect;
               }
         }
      }
      
      public function getInterfacePlayerID(param1:Number) : Number
      {
         var _loc2_:Number = param1;
         switch(param1)
         {
            case this.OFFLINE_PLAYER_ID:
            case this.ONLINE_PLAYER_ID:
            case this.REPLAY_PLAYER1_ID:
               _loc2_ = 1;
               break;
            case this.OFFLINE_OPPONENT_ID:
            case this.ONLINE_OPPONENT_ID:
            case this.REPLAY_PLAYER2_ID:
               _loc2_ = 2;
         }
         return _loc2_;
      }
      
      public function createProfile(param1:Number, param2:String, param3:Number) : void
      {
         this["player" + param1 + "Profile"] = new BMPlayerProfile();
         var _loc4_:BMPlayerProfile = this["player" + param1 + "Profile"];
         _loc4_.playerID = param1;
         _loc4_.playerName = param2;
         _loc4_.level = param3;
         _loc4_.lastLevel = param3;
         switch(param1)
         {
            case this.ONLINE_PLAYER_ID:
            case this.OFFLINE_PLAYER_ID:
               this.campaignBattleID = 0;
         }
      }
      
      public function get myProfile() : BMPlayerProfile
      {
         return this["player" + this.player1PlayerID + "Profile"];
      }
      
      private function createInventoryLocally(param1:Number, param2:uint = 1) : void
      {
         var _loc3_:BMPlayerProfile = null;
         var _loc4_:BMPlayerProfile = null;
         var _loc7_:Number = NaN;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:uint = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Object = null;
         var _loc14_:uint = 0;
         var _loc15_:Boolean = false;
         var _loc16_:Array = null;
         var _loc17_:Array = null;
         var _loc18_:Boolean = false;
         var _loc19_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:Array = null;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:uint = 0;
         var _loc26_:BMItemData = null;
         var _loc27_:uint = 0;
         if(param2 == 1)
         {
            this["playerData" + param1 + "Inventory"] = new Object();
            this["player" + param1 + "playerItemIDCounter"] = 1;
         }
         _loc3_ = this["player" + param1 + "Profile"];
         var _loc5_:Number = _loc3_.level;
         var _loc6_:Number = _loc3_.level;
         switch(param1)
         {
            case this.OFFLINE_OPPONENT_ID:
            case this.ONLINE_OPPONENT_ID:
               if(_loc5_ >= 13)
               {
                  _loc5_ -= 3;
               }
               else if(_loc5_ >= 7)
               {
                  _loc5_ -= 2;
               }
               else if(_loc5_ >= 3)
               {
                  _loc5_--;
               }
         }
         if(param1 == this.OFFLINE_PLAYER_ID && this.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
            _loc7_ = 10;
            this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],this.TUTORIAL_TORSO_ID,0,"torso",0,0,_loc7_);
            this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],this.TUTORIAL_LEG_ID,0,"leg",0,0,0);
            this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],this.TUTORIAL_WEAPON_ID,0,"sideWeapon",0,0,0);
         }
         else
         {
            switch(this.battleType)
            {
               case "mission":
                  _loc8_ = true;
                  _loc9_ = false;
                  switch(this.battleSubType)
                  {
                     case "tank":
                     case "jeep":
                     case "turret":
                        _loc8_ = false;
                        _loc9_ = false;
                  }
                  _loc4_ = this["player" + this.player1PlayerID + "Profile"];
                  _loc10_ = _loc4_.mission_colorID;
                  _loc11_ = _loc3_.level - 2;
                  _loc12_ = _loc3_.level + 1;
                  _loc13_ = this.missionsDB[_loc4_.currentMissionSlot];
                  _loc14_ = 0;
                  _loc15_ = false;
                  if(_loc13_.subType == "endGame")
                  {
                     _loc15_ = true;
                     _loc14_ = 99;
                  }
                  else if(_loc4_.currentMissionSlot > 70)
                  {
                     _loc24_ = (_loc4_.currentMissionSlot - 70) / 50;
                     _loc14_ = Math.ceil(_loc24_ * 10);
                     _loc15_ = true;
                  }
                  if(_loc15_)
                  {
                     _loc11_ = this.LEVEL_MAX;
                     _loc12_ = this.LEVEL_MAX + 1;
                     _loc5_ = this.LEVEL_MAX;
                     _loc6_ = this.LEVEL_MAX + 1;
                  }
                  _loc16_ = this.getReleventItemIDsFromItemsDB("sideWeapon",_loc11_,_loc12_,_loc8_,_loc9_);
                  _loc17_ = this.getReleventItemIDsFromItemsDB("topWeapon",_loc11_,_loc12_,_loc8_,_loc9_);
                  _loc18_ = false;
                  _loc19_ = Math.ceil(Math.random() * 2);
                  if(_loc19_ == 2)
                  {
                     _loc18_ = true;
                  }
                  _loc21_ = new Array();
                  switch(this.battleSubType)
                  {
                     case "mech":
                        this.createMechStructures_playerItemBased(param1,param2,null,_loc5_,_loc6_,_loc14_);
                        break;
                     case "tank":
                        this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],915,param2,"torso",0,_loc10_,0);
                        this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],917,param2,"leg",0,_loc10_,0);
                        _loc20_ = uint(_loc16_[Math.ceil(Math.random() * _loc16_.length) - 1]);
                        _loc21_.push(_loc20_);
                        this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],_loc20_,param2,"sideWeapon",1,_loc10_,0);
                        if(_loc18_)
                        {
                           _loc20_ = uint(_loc17_[Math.ceil(Math.random() * _loc17_.length) - 1]);
                           _loc21_.push(_loc20_);
                           this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],_loc20_,param2,"topWeapon",2,_loc10_,0);
                        }
                        else
                        {
                           _loc20_ = uint(_loc16_[Math.ceil(Math.random() * _loc16_.length) - 1]);
                           _loc21_.push(_loc20_);
                           this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],_loc20_,param2,"sideWeapon",2,_loc10_,0);
                        }
                        break;
                     case "jeep":
                        this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],914,param2,"torso",0,_loc10_,0);
                        this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],916,param2,"leg",0,_loc10_,0);
                        if(_loc4_.missionsCompleted == 0)
                        {
                           _loc21_.push(162,176);
                           this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],162,param2,"sideWeapon",1,_loc10_,0);
                           this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],176,param2,"sideWeapon",2,_loc10_,0);
                        }
                        else
                        {
                           _loc20_ = uint(_loc16_[Math.ceil(Math.random() * _loc16_.length) - 1]);
                           _loc21_.push(_loc20_);
                           this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],_loc20_,param2,"sideWeapon",1,_loc10_,0);
                           if(_loc18_)
                           {
                              _loc20_ = uint(_loc17_[Math.ceil(Math.random() * _loc17_.length) - 1]);
                              _loc21_.push(_loc20_);
                              this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],_loc20_,param2,"topWeapon",2,_loc10_,0);
                           }
                           else
                           {
                              _loc20_ = uint(_loc16_[Math.ceil(Math.random() * _loc16_.length) - 1]);
                              _loc21_.push(_loc20_);
                              this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],_loc20_,param2,"sideWeapon",2,_loc10_,0);
                           }
                        }
                        break;
                     case "turret":
                        this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],919,param2,"torso",0,_loc10_,0);
                        this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],918,param2,"leg",0,_loc10_,0);
                        _loc20_ = uint(_loc16_[Math.ceil(Math.random() * _loc16_.length) - 1]);
                        _loc21_.push(_loc20_);
                        this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],_loc20_,param2,"sideWeapon",1,_loc10_,0);
                        _loc20_ = uint(_loc16_[Math.ceil(Math.random() * _loc16_.length) - 1]);
                        _loc21_.push(_loc20_);
                        this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],_loc20_,param2,"sideWeapon",2,_loc10_,0);
                        _loc20_ = uint(_loc17_[Math.ceil(Math.random() * _loc17_.length) - 1]);
                        _loc21_.push(_loc20_);
                        this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],_loc20_,param2,"topWeapon",1,_loc10_,0);
                        _loc20_ = uint(_loc17_[Math.ceil(Math.random() * _loc17_.length) - 1]);
                        _loc21_.push(_loc20_);
                        this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],_loc20_,param2,"topWeapon",2,_loc10_,0);
                  }
                  switch(this.battleSubType)
                  {
                     case "jeep":
                     case "tank":
                     case "turret":
                        _loc25_ = 0;
                        while(_loc25_ < _loc21_.length)
                        {
                           _loc26_ = this.itemsDB[_loc21_[_loc25_]];
                           _loc27_ = 0;
                           if(_loc26_.bullets > 0)
                           {
                              _loc27_ = this.getKitOrModuleItemIDByTypeAndLevel("module","bullets",_loc6_);
                           }
                           else if(_loc26_.rockets > 0)
                           {
                              _loc27_ = this.getKitOrModuleItemIDByTypeAndLevel("module","rockets",_loc6_);
                           }
                           if(_loc27_ > 0)
                           {
                              this.addInventoryItem(param1,this["playerData" + param1 + "Inventory"],_loc27_,param2,"module",_loc25_ + 1,0,0);
                           }
                           _loc25_++;
                        }
                  }
                  break;
               default:
                  _loc4_ = this["player" + this.player1PlayerID + "Profile"];
                  _loc22_ = _loc4_.level;
                  _loc23_ = _loc4_.level + 1;
                  if(_loc22_ > this.LEVEL_MAX)
                  {
                     _loc22_ = this.LEVEL_MAX;
                  }
                  if(_loc23_ >= this.LEVEL_MAX + 1)
                  {
                     _loc23_ = this.LEVEL_MAX + 1;
                  }
                  this.createMechStructures_playerItemBased(param1,1,null,_loc22_,_loc23_);
            }
         }
      }
      
      public function createMechLocally(param1:Number, param2:uint) : void
      {
         var _loc8_:Object = null;
         var _loc9_:String = null;
         this["playerData" + param1 + "MechStructure" + param2] = new BMMechStructure();
         var _loc3_:BMMechStructure = this["playerData" + param1 + "MechStructure" + param2];
         _loc3_.initialize(param1,param2);
         var _loc4_:Object = this["playerData" + param1 + "Inventory"];
         var _loc5_:Number;
         var _loc6_:Number = _loc5_ = Number(this["player" + param1 + "playerItemIDCounter"]);
         var _loc7_:uint = 1;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = _loc4_[_loc7_];
            if(_loc8_.equipped == param2)
            {
               _loc9_ = _loc8_.type;
               switch(_loc8_.type)
               {
                  case "sideWeapon":
                  case "topWeapon":
                  case "module":
                  case "kit":
                     _loc9_ = _loc8_.type + _loc8_.equipmentID;
               }
               _loc3_[_loc9_] = _loc8_.playerItemID;
            }
            _loc7_++;
         }
      }
      
      public function createPlayerData(param1:Number, param2:String) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:Object = null;
         var _loc8_:BMMechStructure = null;
         var _loc9_:BMPlayerItemData = null;
         var _loc10_:BMItemData = null;
         var _loc11_:Array = null;
         var _loc12_:uint = 0;
         var _loc13_:BMPlayerItemData = null;
         var _loc3_:Object = this["playerData" + param1 + "Inventory"];
         var _loc4_:BMPlayerData = new BMPlayerData();
         _loc4_.initialize();
         var _loc5_:BMPlayerProfile = this["player" + param1 + "Profile"];
         if(param1 == this.OFFLINE_PLAYER_ID)
         {
            _loc5_.playerName = getGeneralText("guest");
         }
         _loc4_.playerItemIDCounter = 1;
         _loc6_ = 1;
         while(_loc6_ <= this.inventoryMaxMechs)
         {
            _loc8_ = new BMMechStructure();
            _loc8_.initialize(param1,_loc6_);
            _loc4_.mechStructures[_loc6_] = _loc8_;
            _loc6_++;
         }
         for each(_loc7_ in _loc3_)
         {
            _loc9_ = new BMPlayerItemData();
            _loc10_ = this.itemsDB[_loc7_.itemID];
            _loc9_.playerItemID = _loc7_.playerItemID;
            _loc9_.itemID = _loc7_.itemID;
            _loc9_.equipped = _loc7_.equipped;
            _loc9_.equipmentType = _loc7_.type;
            _loc9_.equipmentID = _loc7_.equipmentID;
            _loc9_.power = _loc7_.power;
            _loc9_.weight = _loc7_.weight;
            _loc9_.colorID = _loc7_.colorID;
            if(_loc7_.durability != null)
            {
               _loc9_.durability = _loc7_.durability;
            }
            else
            {
               _loc9_.durability = 0;
            }
            _loc4_.items.push(_loc9_);
            if(_loc4_.playerItemIDCounter <= _loc9_.playerItemID)
            {
               _loc4_.playerItemIDCounter = _loc9_.playerItemID + 1;
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
                  _loc11_ = new Array();
                  _loc11_.push(_loc4_.items[0]);
                  _loc11_.push(_loc4_.items[1]);
                  _loc11_.push(_loc4_.items[2]);
                  if(_loc11_[0].equipped == 0 && _loc11_[1].equipped == 0 && _loc11_[2].equipped == 0)
                  {
                     _loc12_ = 0;
                     while(_loc12_ < 3)
                     {
                        _loc13_ = _loc11_[_loc12_];
                        switch(_loc13_.itemID)
                        {
                           case this.TUTORIAL_TORSO_ID:
                              _loc4_.items[0] = _loc11_[_loc12_];
                              break;
                           case this.TUTORIAL_LEG_ID:
                              _loc4_.items[1] = _loc11_[_loc12_];
                              break;
                           case this.TUTORIAL_WEAPON_ID:
                              _loc4_.items[2] = _loc11_[_loc12_];
                        }
                        _loc12_++;
                     }
                  }
               }
            }
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
      
      public function addPlayerItemDataToInventory(param1:uint, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:uint = 0) : void
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
            if(_loc11_.level > 1)
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
            _loc10_.power = _loc9_.power;
         }
         if(_loc9_.type == "perk")
         {
            _loc11_.hasPerks = true;
         }
         _loc8_.items.push(_loc10_);
         _loc8_.updateExistingPlayerItemIDs();
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
               _loc4_ = _loc6_;
               _loc5_ = _loc3_.items.length;
            }
            _loc5_++;
         }
         return _loc4_;
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
         _loc13_[this.RARITY_COMMON] = new Array();
         _loc13_[this.RARITY_RARE] = new Array();
         _loc13_[this.RARITY_EPIC] = new Array();
         _loc13_[this.RARITY_LEGENDARY] = new Array();
         var _loc14_:Array = new Array();
         for each(_loc15_ in this.itemsDB)
         {
            if(!(_loc10_ && _loc15_.displayLevel != 1))
            {
               if(_loc15_.specialStatus <= this.RARITY_LEGENDARY)
               {
                  _loc19_ = false;
                  switch(_loc15_.specialStatus)
                  {
                     case this.RARITY_COMMON:
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
                        if(_loc15_.type == "kit")
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
                              case "torso":
                              case "leg":
                                 _loc20_ = true;
                           }
                           break;
                        case "weapons":
                           switch(_loc15_.type)
                           {
                              case "sideWeapon":
                              case "topWeapon":
                                 _loc20_ = true;
                           }
                           break;
                        case "modules":
                           switch(_loc15_.type)
                           {
                              case "module":
                                 _loc20_ = true;
                           }
                           break;
                        case "specials":
                           switch(_loc15_.type)
                           {
                              case "drone":
                              case "shield":
                              case "teleport":
                              case "charge":
                              case "harpoon":
                                 _loc20_ = true;
                           }
                           break;
                        case "mix":
                           switch(_loc15_.type)
                           {
                              case "kit":
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
            if(_loc13_[this.RARITY_LEGENDARY].length > 0)
            {
               if(_loc23_ <= param7)
               {
                  _loc22_ = Math.ceil(Math.random() * _loc13_[this.RARITY_LEGENDARY].length) - 1;
                  _loc21_ = Number(_loc13_[this.RARITY_LEGENDARY][_loc22_]);
               }
            }
            if(_loc21_ == -1)
            {
               if(_loc13_[this.RARITY_EPIC].length > 0)
               {
                  if(_loc23_ <= param7 + param6)
                  {
                     _loc22_ = Math.ceil(Math.random() * _loc13_[this.RARITY_EPIC].length) - 1;
                     _loc21_ = Number(_loc13_[this.RARITY_EPIC][_loc22_]);
                  }
               }
            }
            if(_loc21_ == -1)
            {
               if(_loc13_[this.RARITY_RARE].length > 0)
               {
                  if(_loc23_ <= param7 + param6 + param5)
                  {
                     _loc22_ = Math.ceil(Math.random() * _loc13_[this.RARITY_RARE].length) - 1;
                     _loc21_ = Number(_loc13_[this.RARITY_RARE][_loc22_]);
                  }
               }
            }
            if(_loc21_ == -1)
            {
               if(_loc13_[this.RARITY_COMMON].length > 0)
               {
                  _loc22_ = Math.ceil(Math.random() * _loc13_[this.RARITY_COMMON].length) - 1;
                  _loc21_ = Number(_loc13_[this.RARITY_COMMON][_loc22_]);
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
               _loc25_ = Math.ceil(Math.random() * _loc14_.length) - 1;
               _loc12_.push(_loc14_[_loc25_]);
            }
         }
         return _loc12_;
      }
      
      public function isPowerKit(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:BMItemData = this.itemsDB[param1];
         if(_loc3_.type == "kit" && _loc3_.subType == "power")
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public function isColorKit(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:BMItemData = this.itemsDB[param1];
         if(_loc3_.type == "kit" && _loc3_.subType == "color")
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public function updateMechStructure(param1:uint, param2:uint) : void
      {
         var _loc6_:BMPlayerItemData = null;
         var _loc7_:BMItemData = null;
         var _loc8_:String = null;
         var _loc9_:Boolean = false;
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
                  _loc9_ = false;
                  switch(_loc7_.type)
                  {
                     case "torso":
                     case "leg":
                     case "drone":
                     case "shield":
                     case "teleport":
                     case "charge":
                     case "harpoon":
                     case "perk":
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
      
      private function createMechStructures_playerItemBased(param1:Number, param2:uint, param3:BMMechStructure, param4:Number, param5:Number, param6:uint = 0) : void
      {
         var _loc8_:BMMechStructure = null;
         var _loc10_:uint = 0;
         var _loc11_:BMPlayerProfile = null;
         var _loc12_:BMPlayerProfile = null;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc7_:Object = this["playerData" + param1 + "Inventory"];
         if(param3 != null)
         {
            _loc8_ = param3;
         }
         else
         {
            _loc8_ = this.createSpecificMechStructure_ItemBased(param4,param5,param6);
         }
         var _loc9_:uint = 0;
         if(param1 == this.OFFLINE_OPPONENT_ID || this.playingVSComputer && param1 == this.ONLINE_OPPONENT_ID)
         {
            _loc11_ = this["player" + this.player1PlayerID + "Profile"];
            _loc12_ = this["player" + this.player2PlayerID + "Profile"];
            _loc13_ = _loc12_.level - _loc11_.levelByItems;
            if(this.battleType == "mission")
            {
               _loc14_ = _loc11_.mission_colorID;
            }
            else
            {
               _loc14_ = this.getComputerColorID(_loc13_);
            }
            _loc9_ = _loc14_;
            _loc8_.torso_colorID = _loc14_;
            _loc8_.leg_colorID = _loc14_;
            _loc10_ = 1;
            while(_loc10_ <= this.maxEquipment["sideWeapon"])
            {
               _loc8_["sideWeapon" + _loc10_ + "_colorID"] = _loc14_;
               _loc10_++;
            }
            _loc10_ = 1;
            while(_loc10_ <= this.maxEquipment["topWeapon"])
            {
               _loc8_["topWeapon" + _loc10_ + "_colorID"] = _loc14_;
               _loc10_++;
            }
         }
         this.addInventoryItem(param1,_loc7_,_loc8_.torso,param2,"torso",0,_loc8_.torso_colorID,0);
         this.addInventoryItem(param1,_loc7_,_loc8_.leg,param2,"leg",0,_loc8_.leg_colorID,0);
         _loc10_ = 1;
         while(_loc10_ <= this.maxEquipment["sideWeapon"])
         {
            this.addInventoryItem(param1,_loc7_,_loc8_["sideWeapon" + _loc10_],param2,"sideWeapon",_loc10_,_loc8_["sideWeapon" + _loc10_ + "_colorID"],0);
            _loc10_++;
         }
         _loc10_ = 1;
         while(_loc10_ <= this.maxEquipment["topWeapon"])
         {
            this.addInventoryItem(param1,_loc7_,_loc8_["topWeapon" + _loc10_],param2,"topWeapon",_loc10_,_loc8_["topWeapon" + _loc10_ + "_colorID"],0);
            _loc10_++;
         }
         this.addInventoryItem(param1,_loc7_,_loc8_.drone,param2,"drone",0,_loc9_,0);
         this.addInventoryItem(param1,_loc7_,_loc8_.shield,param2,"shield",0,0,0);
         this.addInventoryItem(param1,_loc7_,_loc8_.teleport,param2,"teleport",0,0,0);
         this.addInventoryItem(param1,_loc7_,_loc8_.charge,param2,"charge",0,0,0);
         this.addInventoryItem(param1,_loc7_,_loc8_.harpoon,param2,"harpoon",0,0,0);
         _loc10_ = 1;
         while(_loc10_ <= this.maxEquipment["kit"])
         {
            this.addInventoryItem(param1,_loc7_,_loc8_["kit" + _loc10_],param2,"kit",_loc10_,0,0);
            _loc10_++;
         }
         _loc10_ = 1;
         while(_loc10_ <= this.maxEquipment["module"])
         {
            this.addInventoryItem(param1,_loc7_,_loc8_["module" + _loc10_],param2,"module",_loc10_,0,0);
            _loc10_++;
         }
         this.addInventoryItem(param1,_loc7_,_loc8_.perk,param2,"perk",0,0,0);
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
                  case this.OFFLINE_PLAYER_ID:
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
         var _loc11_:uint = 0;
         var _loc12_:Number = NaN;
         if(param1 > this.itemsMaxLevelsDB["torso"])
         {
            param1 = Number(this.itemsMaxLevelsDB["torso"]);
         }
         var _loc4_:BMMechStructure = new BMMechStructure();
         var _loc7_:Array = new Array();
         _loc4_.initialize(-1,0);
         this._createSpecificMechMaxMythicals = param3;
         _loc7_ = this.getReleventItemIDsFromItemsDB("torso",param1,param2);
         _loc8_ = Math.ceil(Math.random() * _loc7_.length) - 1;
         _loc6_ = this.itemsDB[_loc7_[_loc8_]];
         _loc4_.torso = _loc6_.itemID;
         _loc4_.totalBullets = _loc6_.bullets;
         _loc4_.totalRockets = _loc6_.rockets;
         if(_loc6_.specialStatus == 4)
         {
            --this._createSpecificMechMaxMythicals;
            if(this._createSpecificMechMaxMythicals <= 0 && param2 > this.LEVEL_MAX)
            {
               param1--;
               param2--;
            }
         }
         _loc7_ = this.getReleventItemIDsFromItemsDB("leg",param1,param2);
         _loc8_ = Math.ceil(Math.random() * _loc7_.length) - 1;
         _loc5_ = this.itemsDB[_loc7_[_loc8_]];
         _loc4_.leg = _loc5_.itemID;
         if(_loc5_.specialStatus == 4)
         {
            --this._createSpecificMechMaxMythicals;
            if(this._createSpecificMechMaxMythicals <= 0 && param2 > this.LEVEL_MAX)
            {
               param1--;
               param2--;
            }
         }
         _loc4_ = this.createSpecificMechItemIDsPerType(_loc4_,"sideWeapon",param1,param2,true);
         _loc4_ = this.createSpecificMechItemIDsPerType(_loc4_,"topWeapon",param1,param2,true);
         _loc4_ = this.createSpecificMechItemIDsPerType(_loc4_,"drone",param1,param2,false);
         _loc4_ = this.createSpecificMechItemIDsPerType(_loc4_,"shield",param1,param2,false);
         _loc4_ = this.createSpecificMechItemIDsPerType(_loc4_,"teleport",param1,param2,false);
         _loc4_ = this.createSpecificMechItemIDsPerType(_loc4_,"charge",param1,param2,false);
         _loc4_ = this.createSpecificMechItemIDsPerType(_loc4_,"harpoon",param1,param2,false);
         var _loc9_:Number = 0;
         var _loc10_:Number = 0;
         _loc11_ = 1;
         while(_loc11_ <= this.maxEquipment["sideWeapon"])
         {
            _loc12_ = Number(_loc4_["sideWeapon" + _loc11_]);
            if(_loc12_ > 0)
            {
               _loc5_ = this.itemsDB[_loc12_];
               if(_loc5_.bullets > 0)
               {
                  _loc9_++;
               }
               if(_loc5_.rockets > 0)
               {
                  _loc10_++;
               }
            }
            _loc11_++;
         }
         _loc11_ = 1;
         while(_loc11_ <= this.maxEquipment["topWeapon"])
         {
            _loc12_ = Number(_loc4_["topWeapon" + _loc11_]);
            if(_loc12_ > 0)
            {
               _loc5_ = this.itemsDB[_loc12_];
               if(_loc5_.bullets > 0)
               {
                  _loc9_++;
               }
               if(_loc5_.rockets > 0)
               {
                  _loc10_++;
               }
            }
            _loc11_++;
         }
         if(_loc4_.drone > 0)
         {
            _loc5_ = this.itemsDB[_loc4_.drone];
            if(_loc5_.bullets > 0)
            {
               _loc9_++;
            }
            if(_loc5_.rockets > 0)
            {
               _loc10_++;
            }
         }
         var _loc13_:Array = new Array();
         var _loc14_:Array = new Array();
         if(_loc9_ > 0 && _loc10_ > 0)
         {
            _loc13_.push("bulletsAndRockets");
            if(_loc9_ > 1)
            {
               _loc14_.push("bullets");
            }
            if(_loc10_ > 1)
            {
               _loc14_.push("rockets");
            }
            if(_loc9_ > 2)
            {
               _loc13_.push("bullets");
            }
            else if(_loc10_ > 2)
            {
               _loc13_.push("rockets");
            }
            else
            {
               _loc13_.push("bulletsAndRockets");
            }
         }
         else if(_loc9_ > 0)
         {
            _loc13_.push("bullets");
            _loc14_.push("bullets");
            if(_loc9_ > 2)
            {
               _loc13_.push("bullets");
            }
         }
         else if(_loc10_ > 0)
         {
            _loc13_.push("rockets");
            _loc14_.push("rockets");
            if(_loc10_ > 2)
            {
               if(_loc13_.length <= 1)
               {
                  _loc13_.push("rockets");
               }
            }
         }
         var _loc15_:String = "";
         if(_loc4_.shield > 0)
         {
            _loc5_ = this.itemsDB[_loc4_.shield];
            if(_loc5_.energyPerBlock > 0)
            {
               _loc15_ = "energy";
            }
            else
            {
               _loc15_ = "heat";
            }
         }
         if(_loc15_ == "energy")
         {
            _loc13_.push("energy");
            _loc14_.push("energy");
         }
         else
         {
            _loc13_.push("heat");
            _loc14_.push("heat");
         }
         var _loc16_:Number = Math.ceil(Math.random() * 2);
         if(_loc16_ == 1)
         {
            _loc13_.push("resistance");
         }
         else
         {
            _loc14_.push("resistance");
         }
         _loc14_.push("repair");
         if(_loc15_ == "energy")
         {
            _loc13_.push("energy");
            _loc14_.push("energy");
         }
         else
         {
            _loc13_.push("heat");
            _loc14_.push("heat");
         }
         _loc13_.push("heat");
         if(_loc15_ == "energy")
         {
            _loc13_.push("energy");
         }
         else
         {
            _loc13_.push("heat");
         }
         _loc13_.push("armor");
         _loc13_.push("armor");
         _loc13_.push("armor");
         _loc13_.push("armor");
         _loc14_.push("energy");
         _loc14_.push("heat");
         _loc14_.push("energy");
         _loc14_.push("heat");
         var _loc17_:uint = this.getEquipmentUnlockByLevel(param2,"module");
         if(_loc17_ > 0)
         {
            _loc11_ = 1;
            while(_loc11_ <= _loc17_)
            {
               _loc4_["module" + _loc11_] = this.getKitOrModuleItemIDByTypeAndLevel("module",_loc13_[_loc11_ - 1],param2);
               _loc11_++;
            }
         }
         var _loc18_:uint = this.getEquipmentUnlockByLevel(param2,"kit");
         if(_loc18_ > 0)
         {
            _loc11_ = 1;
            while(_loc11_ <= _loc18_)
            {
               _loc4_["kit" + _loc11_] = this.getKitOrModuleItemIDByTypeAndLevel("kit",_loc14_[_loc11_ - 1],param2);
               _loc11_++;
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
               _loc14_ = Math.ceil(Math.random() * _loc11_.length) - 1;
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
      
      private function createSpecificMechItemIDsPerType(param1:BMMechStructure, param2:String, param3:Number, param4:Number, param5:Boolean) : BMMechStructure
      {
         var _loc7_:Number = NaN;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc11_:Number = NaN;
         var _loc12_:Boolean = false;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:BMItemData = null;
         var _loc16_:String = null;
         var _loc17_:uint = 0;
         var _loc6_:Boolean = true;
         if(this._createSpecificMechMaxMythicals <= 0 && param4 > this.LEVEL_MAX)
         {
            param3--;
            param4--;
         }
         switch(param2)
         {
            case "sideWeapon":
            case "topWeapon":
               _loc7_ = this.getEquipmentUnlockByLevel(param4,param2);
               if(_loc7_ == 0)
               {
                  _loc6_ = false;
               }
               break;
            default:
               _loc7_ = 1;
               break;
            case "module":
            case "kit":
               TsLogger.log("WARNING : dataM.createSpecificMechItemIDsPerType is not built for modules and kits!!!");
         }
         if(_loc6_)
         {
            _loc8_ = 1;
            while(_loc8_ <= _loc7_)
            {
               _loc9_ = param2;
               if(param3 > this.itemsMaxLevelsDB[_loc9_])
               {
                  param3 = this.itemsMaxLevelsDB[_loc9_] - 3;
                  param4 = Number(this.itemsMaxLevelsDB[_loc9_]);
                  if(param3 < 1)
                  {
                     param3 = 1;
                  }
               }
               _loc10_ = this.getReleventItemIDsFromItemsDB(param2,param3,param4);
               if(_loc10_.length > 0)
               {
                  if(param3 > 1 && _loc10_.length == 1)
                  {
                     _loc13_ = param3 = param3 - 3;
                     if(_loc13_ < 1)
                     {
                        _loc13_ = 1;
                     }
                     _loc10_ = this.getReleventItemIDsFromItemsDB(param2,_loc13_,param4);
                  }
                  _loc11_ = 0;
                  _loc12_ = false;
                  while(_loc11_ < 10 && _loc12_ == false)
                  {
                     _loc14_ = Math.ceil(Math.random() * _loc10_.length) - 1;
                     _loc15_ = this.itemsDB[_loc10_[_loc14_]];
                     _loc16_ = param2;
                     switch(_loc16_)
                     {
                        case "sideWeapon":
                        case "topWeapon":
                           _loc16_ = param2 + _loc8_;
                     }
                     _loc12_ = true;
                     if(param5)
                     {
                        switch(param2)
                        {
                           case "sideWeapon":
                           case "topWeapon":
                              _loc17_ = 1;
                              while(_loc17_ < this.maxEquipment[param2])
                              {
                                 if(param1[param2 + _loc17_] == _loc15_.itemID)
                                 {
                                    _loc12_ = false;
                                 }
                                 _loc17_++;
                              }
                        }
                     }
                     if(_loc12_)
                     {
                        param1[_loc16_] = _loc15_.itemID;
                        if(_loc15_.specialStatus == 4)
                        {
                           --this._createSpecificMechMaxMythicals;
                           if(this._createSpecificMechMaxMythicals <= 0 && param4 > this.LEVEL_MAX)
                           {
                              param3--;
                              param4--;
                           }
                        }
                     }
                     _loc11_++;
                  }
               }
               _loc8_++;
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
      
      private function getReleventItemIDsFromItemsDB(param1:String, param2:Number, param3:Number, param4:Boolean = true, param5:Boolean = false) : Array
      {
         var _loc7_:BMItemData = null;
         var _loc8_:int = 0;
         var _loc9_:Boolean = false;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         if(param3 > this.LEVEL_MAX + 1)
         {
            param3 = this.LEVEL_MAX + 1;
         }
         var _loc6_:Array = new Array();
         for each(_loc8_ in this.getItemIDSAllowedForPC())
         {
            _loc7_ = this.itemsDB[_loc8_];
            if(_loc7_.type == param1)
            {
               if(_loc7_.level >= param2 && _loc7_.level <= param3 && _loc7_.itemID != this.TUTORIAL_TORSO_ID)
               {
                  _loc9_ = true;
                  if(param4 == false)
                  {
                     if(_loc7_.animation.substr(0,5) == "sword")
                     {
                        _loc9_ = false;
                     }
                  }
                  if(param5 == false)
                  {
                     if(_loc7_.resist1 >= 8 || _loc7_.resist2 >= 8 || _loc7_.resist3 >= 8)
                     {
                        _loc9_ = false;
                     }
                  }
                  if(_loc9_)
                  {
                     _loc6_.push(_loc7_.itemID);
                  }
               }
            }
         }
         if(_loc6_.length == 0)
         {
            _loc10_ = param2;
            _loc11_ = param3;
            _loc12_ = 0;
            while(_loc6_.length == 0 && _loc12_ <= 50)
            {
               if(--_loc10_ < 1)
               {
                  _loc10_ = 1;
               }
               for each(_loc7_ in this.itemsDB)
               {
                  if(_loc7_.type == param1)
                  {
                     if(_loc7_.level >= _loc10_ && _loc7_.level <= _loc11_ && _loc7_.itemID != this.TUTORIAL_TORSO_ID)
                     {
                        _loc6_.push(_loc7_.itemID);
                     }
                  }
               }
               _loc12_++;
            }
         }
         if(_loc6_.length == 0)
         {
            switch(param1)
            {
               case "torso":
               case "leg":
               case "sideWeapon":
                  this.traceError("dataM >> getReleventItemIDsFromItemsDB >> no " + param1 + "s found");
            }
         }
         return _loc6_;
      }
      
      public function createMissionLocally(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc14_:Object = null;
         var _loc15_:BMPlayerItemData = null;
         var _loc16_:BMItemData = null;
         var _loc17_:uint = 0;
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
            _loc15_ = _loc5_.items[_loc13_];
            if(_loc15_.equipped != _loc5_.selectedMechID)
            {
               continue;
            }
            _loc16_ = this.itemsDB[_loc15_.itemID];
            switch(_loc16_.type)
            {
               case "torso":
               case "leg":
               case "module":
                  _loc6_ += _loc16_.HPBase;
                  _loc7_ += _loc16_.energyBase;
                  _loc8_ += _loc16_.energyAddon;
                  _loc9_ += _loc16_.heatBase;
                  _loc10_ += _loc16_.heatAddon;
                  _loc11_ += _loc16_.bullets;
                  _loc12_ += _loc16_.rockets;
            }
         }
         _loc4_.mission_hp = _loc6_;
         _loc4_.mission_energy = _loc7_;
         _loc4_.mission_energyRegeneration = _loc8_;
         _loc4_.mission_heat = _loc9_;
         _loc4_.mission_heatCooling = _loc10_;
         _loc4_.mission_bullets = _loc11_;
         _loc4_.mission_rockets = _loc12_;
         _loc4_.mission_difficulty = param2;
         _loc4_.mission_themeID = param3;
         _loc4_.mission_progress = new Array();
         _loc4_.mission_upgrades = new Array();
         _loc4_.mission_gold = 0;
         _loc4_.currentMissionSlot = param1;
         if(param1 <= 2)
         {
            _loc14_ = this.missionLayouts_tutorial[param1];
         }
         else
         {
            _loc17_ = Math.ceil(Math.random() * this.missionLayouts_regular[param2].length) - 1;
            _loc14_ = this.missionLayouts_regular[param2][_loc17_];
         }
         _loc4_.mission_layout = _loc14_.layout;
         _loc4_.mission_startingPosition = _loc14_.startLocation;
         _loc4_.mission_playerPosition = _loc14_.startLocation;
         _loc4_.mission_rows = _loc14_.rows;
         _loc4_.mission_columns = _loc14_.columns;
         _loc4_.missionID = _loc4_.currentMissionSlot + 1;
         _loc4_.mission_loot = new Array();
         _loc4_.mission_computerItems = new Object();
         this.saveGuestData("createMissionLocally");
      }
      
      public function getTargetBattleType() : Array
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc1_:BMPlayerProfile = this["player" + this.player1PlayerID + "Profile"];
         var _loc2_:String = "regular";
         var _loc3_:String = "";
         if(_loc1_.missionsCompletedAtLastChallenge < _loc1_.missionsCompleted)
         {
            if(_loc1_.missionsCompleted > 2)
            {
               if(this.skipChallenge == false)
               {
                  _loc4_ = 12;
                  _loc5_ = (_loc1_.missionsCompleted + 1) % _loc4_;
                  if(_loc5_ == 4 && _loc1_.missionsCompleted > _loc4_)
                  {
                     _loc2_ = "challenge";
                     _loc3_ = "damage";
                  }
                  else if(_loc5_ == 8)
                  {
                     _loc2_ = "challenge";
                     _loc3_ = "invisible";
                  }
                  else if(_loc5_ == 0)
                  {
                     _loc2_ = "challenge";
                     _loc3_ = "godMode";
                  }
               }
               if(this.clientRunningLocally)
               {
               }
            }
         }
         return [_loc2_,_loc3_];
      }
      
      public function startBattleVSComputer(param1:String, param2:String, param3:Number = -1, param4:Number = -1, param5:Number = -1) : void
      {
         var _loc6_:BMPlayerProfile = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc14_:BMWorldMapLocationData = null;
         var _loc15_:BMWorldMapBossData = null;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:uint = 0;
         var _loc23_:Boolean = false;
         var _loc24_:String = null;
         var _loc25_:String = null;
         var _loc26_:uint = 0;
         var _loc27_:Boolean = false;
         var _loc28_:Object = null;
         var _loc29_:Array = null;
         var _loc30_:BMPlayerItemData = null;
         var _loc31_:BMPlayerData = null;
         var _loc32_:BMMechStructure = null;
         var _loc33_:BMPlayerItemData = null;
         this.battleMechsPerPlayer = 1;
         if(param1 == "mission")
         {
            this.battleMechsPerPlayer = this.campaignBattleType;
         }
         this.battleType = param1;
         this.battleSubType = param2;
         this.playingVSComputer = true;
         this.skipChallenge = false;
         _loc6_ = this["player" + this.player1PlayerID + "Profile"];
         _loc6_.updateLevelByItems();
         ++_loc6_.battlesVSComputer;
         remoteM.lobby_startedBattleVSComputer();
         this.battleData = new Object();
         this.battleData.startingPlayer = 1;
         switch(_loc6_.winsVSComputer)
         {
            case 0:
               _loc7_ = 5;
               _loc8_ = 1;
               _loc9_ = 3;
               break;
            case 1:
               _loc7_ = 6;
               _loc8_ = 2;
               _loc9_ = 3;
               break;
            case 2:
               _loc7_ = 6;
               _loc8_ = 1;
               _loc9_ = 4;
               break;
            case 3:
            case 4:
               _loc7_ = 7;
               _loc8_ = 1;
               _loc9_ = 5;
               break;
            default:
               _loc23_ = true;
               switch(this.battleType)
               {
                  case "challenge":
                     switch(this.battleSubType)
                     {
                        case "godMode":
                        case "usa":
                        case "japan":
                           _loc23_ = false;
                           _loc7_ = 10;
                           _loc8_ = 3;
                           _loc9_ = 6;
                     }
               }
               if(_loc23_)
               {
                  if(_loc6_.level < 8)
                  {
                     _loc10_ = Math.ceil(Math.random() * 3);
                     _loc7_ = 8;
                     switch(_loc10_)
                     {
                        case 1:
                           _loc8_ = 3;
                           _loc9_ = 4;
                           break;
                        case 2:
                           _loc8_ = 2;
                           _loc9_ = 5;
                           break;
                        case 3:
                           _loc8_ = 1;
                           _loc9_ = 6;
                     }
                  }
                  else
                  {
                     _loc10_ = Math.ceil(Math.random() * 4);
                     _loc7_ = 10;
                     switch(_loc10_)
                     {
                        case 1:
                           _loc8_ = 4;
                           _loc9_ = 5;
                           break;
                        case 2:
                           _loc8_ = 3;
                           _loc9_ = 6;
                           break;
                        case 3:
                           _loc8_ = 2;
                           _loc9_ = 7;
                           break;
                        case 4:
                           _loc8_ = 1;
                           _loc9_ = 8;
                     }
                  }
               }
         }
         if(param3 > -1)
         {
            _loc8_ = param3;
            _loc9_ = param4;
         }
         this.battleData.map = new Object();
         this.battleData.map.stepsTotal = _loc7_;
         var _loc11_:Object = new Object();
         _loc11_.currentStep = _loc8_;
         var _loc12_:Object = new Object();
         _loc12_.currentStep = _loc9_;
         var _loc13_:Boolean = false;
         switch(this.battleType)
         {
            case "challenge":
               switch(this.battleSubType)
               {
                  case "godMode":
                     _loc12_.playerName = getGeneralText("godMode");
                     break;
                  case "usa":
                     _loc12_.playerName = "USA Destructor";
                     break;
                  case "japan":
                     _loc12_.playerName = "Yoshimo X";
                     break;
                  default:
                     _loc13_ = true;
               }
               break;
            case "mission":
               switch(this.battleSubType)
               {
                  case "turret":
                  case "jeep":
                  case "tank":
                     _loc24_ = getSpecificText("missionBaseMap_" + this.battleSubType);
                     _loc12_.playerName = _loc24_;
                     break;
                  case "boss":
                     _loc14_ = this.missionsDB[_loc6_.currentMissionSlot];
                     _loc16_ = _loc14_.bossDataSlot;
                     if(_loc16_ == -1)
                     {
                        trace("WARNING: BOSS DATA SLOT IS NULLED - AUTO SETTING TO FIRST BOSS");
                        _loc16_ = 0;
                     }
                     _loc15_ = this.missionBossesDB[_loc16_];
                     _loc24_ = _loc15_.name;
                     _loc12_.playerName = _loc24_;
                     break;
                  default:
                     _loc13_ = true;
               }
               break;
            default:
               _loc13_ = true;
         }
         if(_loc13_)
         {
            _loc10_ = Math.ceil(Math.random() * this.computerNamesDB.length) - 1;
            _loc25_ = this.computerNamesDB[_loc10_];
            _loc12_.playerName = _loc25_;
         }
         this.battle_clientInverted = false;
         switch(this.battleType)
         {
            case "mission":
               _loc26_ = 1 + Math.ceil(_loc6_.currentMissionSlot / 70 * (this.LEVEL_MAX - 1));
               if(_loc26_ < 2)
               {
                  _loc26_ = 2;
               }
               else if(_loc26_ > this.LEVEL_MAX)
               {
                  _loc26_ = this.LEVEL_MAX;
               }
               _loc12_.level = _loc26_;
               _loc12_.levelByItems = _loc26_;
               break;
            default:
               _loc12_.level = _loc6_.levelByItems + _loc6_.computerLevelAddon;
               _loc12_.levelByItems = _loc12_.level;
               if(_loc12_.level < 1)
               {
                  _loc12_.level = 1;
                  _loc12_.levelByItems = 1;
               }
               else if(_loc12_.level > this.LEVEL_MAX)
               {
                  _loc12_.level = this.LEVEL_MAX;
                  _loc12_.levelByItems = this.LEVEL_MAX;
               }
         }
         switch(this.player1PlayerID)
         {
            case this.OFFLINE_PLAYER_ID:
               _loc17_ = this.OFFLINE_OPPONENT_ID;
               break;
            case this.ONLINE_PLAYER_ID:
               _loc17_ = this.ONLINE_OPPONENT_ID;
         }
         this.battleData.player1 = new Object();
         this.battleData.player1.currentStep = _loc11_.currentStep;
         this.battleData.player2 = new Object();
         this.battleData.player2.currentStep = _loc12_.currentStep;
         this.createProfile(_loc17_,_loc12_.playerName,_loc12_.level);
         var _loc18_:BMPlayerProfile = this["player" + this.player2PlayerID + "Profile"];
         _loc18_.levelByItems = _loc12_.levelByItems;
         this["playerData" + _loc17_ + "Inventory"] = new Object();
         var _loc19_:Object = this["playerData" + _loc17_ + "Inventory"];
         var _loc20_:Boolean = false;
         switch(this.battleType)
         {
            case "challenge":
               switch(this.battleSubType)
               {
                  case "usa":
                     _loc19_[1] = {
                        "playerItemID":1,
                        "itemID":1058,
                        "equipped":1,
                        "type":"torso",
                        "equipmentID":1,
                        "colorID":9
                     };
                     _loc19_[2] = {
                        "playerItemID":2,
                        "itemID":1059,
                        "equipped":1,
                        "type":"leg",
                        "equipmentID":1,
                        "colorID":9
                     };
                     _loc19_[3] = {
                        "playerItemID":3,
                        "itemID":294,
                        "equipped":1,
                        "type":"sideWeapon",
                        "equipmentID":1,
                        "colorID":9
                     };
                     _loc19_[4] = {
                        "playerItemID":4,
                        "itemID":294,
                        "equipped":1,
                        "type":"sideWeapon",
                        "equipmentID":2,
                        "colorID":9
                     };
                     this["player" + _loc17_ + "playerItemIDCounter"] = 4;
                     break;
                  case "japan":
                     _loc19_[1] = {
                        "playerItemID":1,
                        "itemID":1061,
                        "equipped":1,
                        "type":"torso",
                        "equipmentID":1,
                        "colorID":5
                     };
                     _loc19_[2] = {
                        "playerItemID":2,
                        "itemID":1062,
                        "equipped":1,
                        "type":"leg",
                        "equipmentID":1,
                        "colorID":5
                     };
                     _loc19_[3] = {
                        "playerItemID":3,
                        "itemID":1060,
                        "equipped":1,
                        "type":"sideWeapon",
                        "equipmentID":1,
                        "colorID":5
                     };
                     _loc19_[4] = {
                        "playerItemID":4,
                        "itemID":294,
                        "equipped":1,
                        "type":"sideWeapon",
                        "equipmentID":2,
                        "colorID":5
                     };
                     this["player" + _loc17_ + "playerItemIDCounter"] = 4;
                     break;
                  case "godMode":
                     _loc19_[1] = {
                        "playerItemID":1,
                        "itemID":292,
                        "equipped":1,
                        "type":"torso",
                        "equipmentID":1,
                        "colorID":9
                     };
                     _loc19_[2] = {
                        "playerItemID":2,
                        "itemID":293,
                        "equipped":1,
                        "type":"leg",
                        "equipmentID":1,
                        "colorID":9
                     };
                     _loc19_[3] = {
                        "playerItemID":3,
                        "itemID":294,
                        "equipped":1,
                        "type":"sideWeapon",
                        "equipmentID":1,
                        "colorID":9
                     };
                     _loc19_[4] = {
                        "playerItemID":4,
                        "itemID":294,
                        "equipped":1,
                        "type":"sideWeapon",
                        "equipmentID":2,
                        "colorID":9
                     };
                     this["player" + _loc17_ + "playerItemIDCounter"] = 4;
                     break;
                  case "damage":
                     _loc19_[1] = {
                        "playerItemID":1,
                        "itemID":718,
                        "equipped":1,
                        "type":"torso",
                        "equipmentID":1,
                        "colorID":2
                     };
                     _loc19_[2] = {
                        "playerItemID":2,
                        "itemID":719,
                        "equipped":1,
                        "type":"leg",
                        "equipmentID":1,
                        "colorID":2
                     };
                     _loc19_[3] = {
                        "playerItemID":3,
                        "itemID":720,
                        "equipped":1,
                        "type":"sideWeapon",
                        "equipmentID":1,
                        "colorID":2
                     };
                     _loc19_[4] = {
                        "playerItemID":4,
                        "itemID":720,
                        "equipped":1,
                        "type":"sideWeapon",
                        "equipmentID":2,
                        "colorID":2
                     };
                     this["player" + _loc17_ + "playerItemIDCounter"] = 4;
                     break;
                  default:
                     this.createInventoryLocally(_loc17_,1);
               }
               break;
            case "regular":
               switch(_loc6_.winsVSComputer)
               {
                  case 0:
                     _loc19_[1] = {
                        "playerItemID":1,
                        "itemID":this.TUTORIAL_TORSO_ID,
                        "equipped":1,
                        "type":"torso",
                        "equipmentID":1,
                        "colorID":3
                     };
                     _loc19_[2] = {
                        "playerItemID":2,
                        "itemID":this.TUTORIAL_LEG_ID,
                        "equipped":1,
                        "type":"leg",
                        "equipmentID":1,
                        "colorID":3
                     };
                     _loc19_[3] = {
                        "playerItemID":3,
                        "itemID":this.TUTORIAL_WEAPON_ID,
                        "equipped":1,
                        "type":"sideWeapon",
                        "equipmentID":1,
                        "colorID":3
                     };
                     this["player" + _loc17_ + "playerItemIDCounter"] = 3;
                     break;
                  case 1:
                     _loc19_[1] = {
                        "playerItemID":1,
                        "itemID":this.TUTORIAL_BUY_TORSO1_ID,
                        "equipped":1,
                        "type":"torso",
                        "equipmentID":1,
                        "colorID":3
                     };
                     _loc19_[2] = {
                        "playerItemID":2,
                        "itemID":this.TUTORIAL_LEG_ID,
                        "equipped":1,
                        "type":"leg",
                        "equipmentID":1,
                        "colorID":3
                     };
                     _loc19_[3] = {
                        "playerItemID":3,
                        "itemID":this.TUTORIAL_WEAPON_ID,
                        "equipped":1,
                        "type":"sideWeapon",
                        "equipmentID":1,
                        "colorID":3
                     };
                     _loc19_[4] = {
                        "playerItemID":4,
                        "itemID":this.TUTORIAL_WEAPON_ID,
                        "equipped":1,
                        "type":"sideWeapon",
                        "equipmentID":2,
                        "colorID":3
                     };
                     this["player" + _loc17_ + "playerItemIDCounter"] = 4;
                     break;
                  default:
                     this.createInventoryLocally(_loc17_,1);
               }
               break;
            case "mission":
               _loc27_ = false;
               if(param5 > -1)
               {
                  if(_loc6_.mission_computerItems[param5] != null)
                  {
                     _loc27_ = true;
                  }
               }
               if(_loc27_)
               {
                  this["playerData" + _loc17_ + "Inventory"] = new Object();
                  this["player" + _loc17_ + "playerItemIDCounter"] = 1;
                  _loc21_ = 0;
                  while(_loc21_ < _loc6_.mission_computerItems[param5].length)
                  {
                     _loc28_ = _loc6_.mission_computerItems[param5][_loc21_];
                     this.addInventoryItem(_loc17_,this["playerData" + _loc17_ + "Inventory"],_loc28_.itemID,_loc28_.equipped,_loc28_.equipmentType,_loc28_.equipmentID,_loc28_.colorID,_loc28_.power);
                     _loc21_++;
                  }
               }
               else
               {
                  switch(param2)
                  {
                     case "boss":
                        _loc14_ = this.missionsDB[_loc6_.currentMissionSlot];
                        _loc16_ = _loc14_.bossDataSlot;
                        if(_loc16_ == -1)
                        {
                           trace("WARNING: BOSS DATA SLOT IS NULLED - AUTO SETTING TO FIRST BOSS");
                           _loc16_ = 0;
                        }
                        _loc15_ = this.missionBossesDB[_loc16_];
                        this["playerData" + _loc17_ + "Inventory"] = new Object();
                        this["player" + _loc17_ + "playerItemIDCounter"] = 1;
                        _loc29_ = _loc15_.getPlayerItemsData();
                        _loc21_ = 0;
                        while(_loc21_ < _loc29_.length)
                        {
                           _loc30_ = _loc29_[_loc21_];
                           this.addInventoryItem(_loc17_,this["playerData" + _loc17_ + "Inventory"],_loc30_.itemID,1,_loc30_.equipmentType,_loc30_.equipmentID,_loc30_.colorID);
                           _loc21_++;
                        }
                        break;
                     default:
                        _loc22_ = 1;
                        while(_loc22_ <= this.battleMechsPerPlayer)
                        {
                           this.createInventoryLocally(_loc17_,_loc22_);
                           _loc22_++;
                        }
                  }
                  if(_loc6_.currentMissionSlot <= 1)
                  {
                     _loc20_ = true;
                  }
               }
         }
         _loc22_ = 1;
         while(_loc22_ <= this.battleMechsPerPlayer)
         {
            this.createMechLocally(_loc17_,_loc22_);
            _loc22_++;
         }
         this.createPlayerData(_loc17_,"startBattleVSComputer");
         if(_loc20_)
         {
            _loc31_ = this.playersData[_loc17_];
            _loc32_ = _loc31_.mechStructures[_loc31_.selectedMechID];
            _loc32_.topWeapon1 = 0;
            _loc32_.topWeapon2 = 0;
            _loc21_ = _loc31_.items.length - 1;
            while(_loc21_ >= 0)
            {
               _loc33_ = _loc31_.items[_loc21_];
               if(_loc33_.equipmentType == "topWeapon")
               {
                  _loc31_.items.splice(_loc21_,1);
               }
               _loc21_--;
            }
         }
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
      
      public function battle_afterBattleFunctions(param1:Boolean) : void
      {
         var _loc3_:String = null;
         var _loc4_:BMPlayerProfile = null;
         var _loc2_:BMPlayerProfile = this["player" + this.player1PlayerID + "Profile"];
         _loc3_ = "worldMap";
         switch(this.battleType)
         {
            case "mission":
               _loc3_ = "missionBaseMap";
               break;
            default:
               if(this.battleType == "challenge")
               {
                  _loc3_ = "worldMap";
               }
               else if(this.isTutorialActive())
               {
                  _loc3_ = "mainMenu";
               }
               else if(this.gameType == BMDataManager.GAME_TYPE_ONLINE)
               {
                  if(param1 == false)
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
               }
         }
         if(_loc3_ != "missionBaseMap")
         {
            screensM.screenNewMenu.refreshTopBarAfterBattle = true;
         }
         switch(_loc3_)
         {
            case "mainMenu":
               screensM.screenNewMenu.mainScreenSub();
               break;
            case "hanger":
               screensM.screenNewMenu.hangerMechClicked(true);
               soundM.resetMusicTrackParameters();
               break;
            case "ladder":
               screensM.screenNewMenu.multiplayerLadderClicked(true,false);
               screensM.screenTopBar.activateManualBattleCreditsDisplay();
               soundM.resetMusicTrackParameters();
               if(this.topBar_levelUpInProgress == false && this.supersonic_mobile_SPMP == 0 || this.supersonic_mobile_SPMP == 2)
               {
                  this.showAdvertisement();
               }
               break;
            case "chat":
               _loc4_ = this["player" + this.player2PlayerID + "Profile"];
               if(this.battle_goToChatAfterBattle)
               {
                  this.goToChatAfterBattle(_loc4_.userID,_loc4_.playerName,_loc4_.clanID,_loc4_.ladderProgress,_loc4_.level,_loc4_.geo);
               }
               else if(this.battle_inviteToClanAfterBattle)
               {
                  this.inviteToClanAfterBattle(_loc4_.userID,_loc4_.playerName,_loc4_.clanID,_loc4_.ladderProgress,_loc4_.level,_loc4_.geo);
               }
               screensM.screenNewMenu.multiplayerChatClicked(true,false);
               screensM.screenTopBar.activateManualBattleCreditsDisplay();
               soundM.resetMusicTrackParameters();
               if(this.topBar_levelUpInProgress == false && this.supersonic_mobile_SPMP == 0 || this.supersonic_mobile_SPMP == 2)
               {
                  this.showAdvertisement();
               }
               break;
            case "worldMap":
               screensM.screenNewMenu.singlePlayerClicked(true);
               soundM.resetMusicTrackParameters();
               break;
            case "missionBaseMap":
               screensM.addScreen("screenMissionBaseMap");
               screensM.addScreen("screenTopBar");
               screensM.screenMissionBaseMap.refreshScreen(true);
               screensM.screenTopBar.refreshScreen(true);
               if(this.supersonic_mobile_SPMP == 0 || this.supersonic_mobile_SPMP == 1)
               {
                  this.showAdvertisement();
               }
         }
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
         _loc6_ = _loc5_.level;
         _loc7_ = this.getItemCurrentPowerLevel(param1,param2);
         return (_loc7_ - 1) * this.powerLevelsDB_regular[_loc6_].bonusHP;
      }
      
      public function getItemPowerDamageBonus(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:BMPlayerItemData = null;
         var _loc5_:BMItemData = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         _loc3_ = 0;
         _loc4_ = this.getPlayerItemData(param1,param2);
         _loc5_ = this.itemsDB[_loc4_.itemID];
         _loc6_ = _loc5_.level;
         _loc7_ = this.getItemCurrentPowerLevel(param1,param2);
         switch(_loc5_.type)
         {
            case "torso":
            case "leg":
            case "sideWeapon":
            case "topWeapon":
               _loc3_ = (_loc7_ - 1) * this.powerLevelsDB_regular[_loc6_].bonusDamage;
               break;
            default:
               _loc3_ = (_loc7_ - 1) * this.powerLevelsDB_special[_loc6_].bonusDamage;
         }
         return _loc3_;
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
         var _loc4_:BMItemData = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         _loc3_ = this.getPlayerItemData(param1,param2);
         _loc4_ = this.itemsDB[_loc3_.itemID];
         _loc5_ = this.getItemCurrentPowerLevel(param1,param2);
         _loc6_ = _loc5_ - 1;
         if(_loc6_ > 0)
         {
            _loc6_ += 10;
         }
         if(_loc6_ > 20)
         {
            _loc6_ = 20;
         }
         switch(_loc4_.type)
         {
            case "drone":
            case "teleport":
            case "charge":
            case "harpoon":
               _loc6_ = (_loc6_ - 10) * 2 + 10;
         }
         return _loc6_;
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
         if(param8 == false)
         {
            _loc14_.contentLoaded = false;
            _loc14_.contentData_playerItemID = param1;
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
               _loc22_ = this.COLOR_RARE_ITEM;
               break;
            case 2:
               _loc22_ = this.COLOR_EPIC_ITEM;
               break;
            case 3:
               _loc22_ = this.COLOR_LEGENDARY_ITEM;
               break;
            case 4:
               _loc20_ = this.COLOR_MYTHICAL_ITEM_DARK;
               _loc22_ = this.COLOR_MYTHICAL_ITEM;
               break;
            case 5:
               _loc20_ = this.COLOR_MYTHICAL_ITEM_DARK;
               _loc22_ = this.COLOR_PERK;
         }
         switch(_loc11_.type)
         {
            case "drone":
            case "shield":
            case "teleport":
            case "charge":
            case "harpoon":
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
         var _loc21_:BMPlayerProfile = null;
         var _loc22_:String = null;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:MovieClip = null;
         var _loc28_:MovieClip = null;
         var _loc29_:MovieClip = null;
         _loc5_ = this.playersData[param1];
         _loc6_ = 1;
         if(screensM.isScreenOpened("screenHangerMech"))
         {
            _loc6_ = screensM.screenHangerMech.getTargetMechID();
         }
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
            case "module":
            case "kit":
            case "shield":
            case "teleport":
            case "charge":
            case "harpoon":
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
                  case "torso":
                  case "leg":
                  case "sideWeapon":
                  case "topWeapon":
                  case "drone":
                  case "teleport":
                  case "charge":
                  case "harpoon":
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
               _loc21_ = this["player" + this.player1PlayerID + "Profile"];
               _loc11_ = this.EQUIPMENT_TILE_LIST_ITEM_SIZE;
               _loc12_ = this.EQUIPMENT_TILE_LIST_ITEM_SIZE;
               _loc22_ = "occupiedItem";
               switch(_loc10_.type)
               {
                  case "sideWeapon":
                  case "topWeapon":
                     if(_loc10_.bullets > _loc7_.totalBullets || _loc10_.rockets > _loc7_.totalRockets)
                     {
                        _loc22_ = "occupiedItemRed";
                     }
               }
               _loc15_ = externalAssetsM.getAsset("general",_loc22_);
               switch(_loc10_.type)
               {
                  case "module":
                  case "kit":
                  case "shield":
                  case "teleport":
                  case "charge":
                  case "harpoon":
                     _loc14_ = 6;
               }
               switch(_loc10_.type)
               {
                  case "torso":
                  case "leg":
                  case "sideWeapon":
                  case "topWeapon":
                  case "drone":
                  case "teleport":
                  case "charge":
                  case "harpoon":
                     _loc17_ = true;
               }
               if(_loc8_.durability > 0)
               {
                  _loc19_ = true;
               }
         }
         _loc20_ = new MovieClip();
         if(param4)
         {
            _loc20_ = externalAssetsM.getAsset(this.itemTypeSourceDB[_loc10_.type],_loc10_.grp,0,0,true,true);
            if(_loc18_)
            {
               _loc20_.filters = [new GlowFilter(0,1,4,4,7)];
            }
         }
         else
         {
            _loc20_.graphics.beginFill(49778,1);
            _loc20_.graphics.drawRect(0,0,50,50);
         }
         switch(_loc10_.type)
         {
            case "torso":
               if(_loc20_.mcShutdown != null)
               {
                  _loc20_.mcShutdown.visible = false;
               }
         }
         _loc9_.initialize(_loc8_.playerItemID,_loc11_,_loc12_,_loc20_,_loc13_,_loc14_,_loc16_,_loc15_,this.runAsMobile);
         if(_loc17_)
         {
            _loc23_ = this.getItemCurrentPowerLevel(param1,param2);
            if(_loc23_ > 1)
            {
               _loc24_ = 100;
               _loc25_ = 25;
               _loc26_ = 5;
               _loc27_ = new MovieClip();
               _loc27_.graphics.beginFill(0,0);
               _loc27_.graphics.drawRect(0,0,_loc24_,_loc24_);
               _loc28_ = externalAssetsM.getAsset("general","Grp_rank" + _loc23_,_loc25_,_loc25_,false,false);
               _loc28_.x = _loc24_ - _loc25_ - _loc26_;
               _loc28_.y = _loc24_ - _loc25_ - _loc26_;
               _loc27_.addChild(_loc28_);
               _loc27_.filters = [new GlowFilter(0,1,4,4,7)];
               _loc9_.addOverItemGrp1(_loc27_);
            }
         }
         if(_loc19_)
         {
            _loc29_ = externalAssetsM.getAsset("general","icon_itemDurability",_loc11_,_loc12_,false,false);
            _loc9_.addOverItemGrp2(_loc29_);
         }
         if(_loc8_.colorID > 0)
         {
            this.colorItem(_loc9_,_loc8_.colorID);
         }
         else
         {
            this.colorItem(_loc9_,this.getItemPowerColorID(param1,_loc8_.playerItemID));
         }
         return _loc9_;
      }
      
      public function createShopTileListItem_basedOnItemID(param1:Number, param2:String, param3:Function, param4:Function, param5:Function, param6:Function, param7:Function, param8:Boolean) : BMTileListItem
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
               _loc16_ = this.COLOR_RARE_ITEM;
               break;
            case 2:
               _loc16_ = this.COLOR_EPIC_ITEM;
               break;
            case 3:
               _loc16_ = this.COLOR_LEGENDARY_ITEM;
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
                           _loc16_ = this.COLOR_MYTHICAL_ITEM;
                        }
                        else
                        {
                           _loc16_ = this.COLOR_MYTHICAL_ITEM_DARK;
                        }
                     }
                     else if(_loc19_)
                     {
                        _loc16_ = this.COLOR_MYTHICAL_ITEM;
                     }
                     else
                     {
                        _loc14_ = this.COLOR_DARK_GRAY;
                        _loc17_ = 1;
                     }
                     break;
                  case "reward":
                     _loc16_ = this.COLOR_MYTHICAL_ITEM;
               }
               break;
            case 5:
               _loc16_ = this.COLOR_PERK;
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
                     _loc14_ = this.COLOR_MYTHICAL_ITEM_DARK;
                     _loc16_ = this.COLOR_MYTHICAL_ITEM;
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
               if(this.runAsMobile)
               {
                  _loc6_ = this.REWARD_TILE_LIST_ITEM_SIZE;
                  _loc7_ = this.REWARD_TILE_LIST_ITEM_SIZE;
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
            case "torso":
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
                  case "kit":
                  case "module":
                  case "shield":
                  case "teleport":
                  case "charge":
                  case "harpoon":
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
      
      public function createMechIcon(param1:Number, param2:uint, param3:BMMechStructure, param4:Object, param5:Number, param6:Number, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean) : BMItem
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
         _loc16_ = "playerItemID";
         if(param1 <= 0)
         {
            _loc16_ = "itemID";
         }
         _loc14_.initialize(param1,"hanger",_loc16_,1,false);
         if(param4 != null)
         {
            _loc14_.setManualColors(param4);
         }
         _loc14_.centerMech = true;
         _loc14_.buildMech(_loc11_,"dataManager createMechIcon");
         this.resizeMechViewBySizer(_loc14_,_loc13_);
         _loc15_.addChild(_loc13_);
         _loc15_.addChild(_loc14_);
         if(param10)
         {
            _loc15_.scaleX = -1;
            _loc15_.x += _loc15_.width;
         }
         if(param7)
         {
            _loc15_.x -= _loc15_.width / 2;
            _loc15_.y -= _loc15_.height / 2;
         }
         if(param8)
         {
            _loc13_.alpha = 0;
         }
         if(param9 == false)
         {
            _loc17_ = externalAssetsM.getAsset("general","icon_mechBackground");
         }
         _loc12_.initialize(0,param5,param5,_loc15_,0,param6,false,_loc17_,this.runAsMobile);
         return _loc12_;
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
            case this.OFFLINE_PLAYER_ID:
            case this.ONLINE_PLAYER_ID:
               _loc2_ = "power";
               break;
            case this.ONLINE_OPPONENT_ID:
            case this.INSPECT_PLAYER_ID:
               if(this.playingVSComputer == false)
               {
                  _loc2_ = "power";
               }
         }
         return _loc2_;
      }
      
      public function colorItem(param1:BMItem, param2:Number) : void
      {
         var _loc3_:String = null;
         var _loc4_:ColorTransform = null;
         var _loc5_:MovieClip = null;
         var _loc6_:Number = NaN;
         var _loc7_:BitmapData = null;
         var _loc8_:Bitmap = null;
         var _loc9_:BitmapData = null;
         if(param2 > 0)
         {
            if(param1.itemGrp.mcColor != null)
            {
               _loc3_ = GlobalAccess.stage.quality;
               _loc4_ = new ColorTransform();
               _loc4_.color = this.colorsDB[param2];
               _loc5_ = param1.itemGrp.mcColor;
               _loc5_.transform.colorTransform = _loc4_;
               _loc5_.blendMode = BlendMode.OVERLAY;
               if(this.runAsMobile == false && param1.itemGrp.itemBM != null)
               {
                  if(this.runAsMobile == false)
                  {
                  }
                  _loc6_ = 5;
                  _loc7_ = new BitmapData(param1.itemGrp.itemBM.width + _loc6_ * 2,param1.itemGrp.itemBM.height + _loc6_ * 2,true,0);
                  _loc8_ = new Bitmap(_loc7_);
                  _loc8_.smoothing = true;
                  param1.itemGrp.itemBM.x += _loc6_;
                  param1.itemGrp.itemBM.y += _loc6_;
                  if(param1.itemGrp.mcColor != null)
                  {
                     param1.itemGrp.mcColor.x += _loc6_;
                     param1.itemGrp.mcColor.y += _loc6_;
                  }
                  if(param1.itemGrp.mcBarrel != null)
                  {
                     param1.itemGrp.mcBarrel.x += _loc6_;
                     param1.itemGrp.mcBarrel.y += _loc6_;
                  }
                  if(param1.itemGrp.mcLight != null)
                  {
                     param1.itemGrp.mcLight.x += _loc6_;
                     param1.itemGrp.mcLight.y += _loc6_;
                  }
                  if(param1.itemGrp.mcHandle != null)
                  {
                     param1.itemGrp.mcHandle.x += _loc6_;
                     param1.itemGrp.mcHandle.y += _loc6_;
                  }
                  _loc8_.x -= _loc6_;
                  _loc8_.y -= _loc6_;
                  _loc7_.draw(param1.itemGrp);
                  param1.itemGrp.addChild(_loc8_);
                  if(param1.itemGrp.mcBarrel != null)
                  {
                     param1.itemGrp.mcBarrel.parent.removeChild(param1.itemGrp.mcBarrel);
                     param1.itemGrp.addChild(param1.itemGrp.mcBarrel);
                     param1.itemGrp.mcBarrel.x -= _loc6_;
                     param1.itemGrp.mcBarrel.y -= _loc6_;
                  }
                  if(param1.itemGrp.mcLight != null)
                  {
                     param1.itemGrp.mcLight.parent.removeChild(param1.itemGrp.mcLight);
                     param1.itemGrp.addChild(param1.itemGrp.mcLight);
                     param1.itemGrp.mcLight.x -= _loc6_;
                     param1.itemGrp.mcLight.y -= _loc6_;
                  }
                  if(param1.itemGrp.mcHandle != null)
                  {
                     param1.itemGrp.mcHandle.parent.removeChild(param1.itemGrp.mcHandle);
                     param1.itemGrp.addChild(param1.itemGrp.mcHandle);
                     param1.itemGrp.mcHandle.x -= _loc6_;
                     param1.itemGrp.mcHandle.y -= _loc6_;
                  }
                  if(param1.itemGrp.itemBM.parent != null)
                  {
                     param1.itemGrp.itemBM.parent.removeChild(param1.itemGrp.itemBM);
                     param1.itemGrp.itemBMD.dispose();
                  }
                  param1.itemGrp.itemBM = _loc8_;
                  param1.itemGrp.itemBMD = _loc7_;
                  if(param1.itemGrp.mcColor != null)
                  {
                     if(param1.itemGrp.mcColor.parent != null)
                     {
                        param1.itemGrp.mcColor.parent.removeChild(param1.itemGrp.mcColor);
                     }
                  }
                  if(param1.itemGrp.mcShutdown != null)
                  {
                     if(param1.itemGrp.mcShutdown.parent != null)
                     {
                        param1.itemGrp.mcShutdown.parent.removeChild(param1.itemGrp.mcShutdown);
                     }
                     param1.itemGrp.addChild(param1.itemGrp.mcShutdown);
                  }
               }
               if(this.runAsMobile)
               {
                  _loc9_ = new BitmapData(param1.itemGrp.width,param1.itemGrp.height,true,0);
                  _loc9_.draw(param1.itemGrp);
                  param1.itemGrp.gpuImage = new Bitmap(_loc9_,"auto",true);
                  param1.itemGrp.addChild(param1.itemGrp.gpuImage);
                  param1.itemGrp["cacheAsBitmapMatrix"] = new Matrix();
                  param1.itemGrp.cacheAsBitmap = true;
                  GlobalAccess.stage.quality = _loc3_;
                  if(param1.itemGrp.mcShutdown != null)
                  {
                     if(param1.itemGrp.mcShutdown.parent != null)
                     {
                        param1.itemGrp.mcShutdown.parent.removeChild(param1.itemGrp.mcShutdown);
                     }
                     param1.itemGrp.addChild(param1.itemGrp.mcShutdown);
                  }
                  if(param1.itemGrp.mcBarrel != null)
                  {
                     if(param1.itemGrp.mcBarrel.parent != null)
                     {
                        param1.itemGrp.mcBarrel.parent.removeChild(param1.itemGrp.mcBarrel);
                     }
                     param1.itemGrp.addChild(param1.itemGrp.mcBarrel);
                  }
                  if(param1.itemGrp.mcLight != null)
                  {
                     if(param1.itemGrp.mcLight.parent != null)
                     {
                        param1.itemGrp.mcLight.parent.removeChild(param1.itemGrp.mcLight);
                     }
                     param1.itemGrp.addChild(param1.itemGrp.mcLight);
                  }
                  if(param1.itemGrp.mcHandle != null)
                  {
                     if(param1.itemGrp.mcHandle.parent != null)
                     {
                        param1.itemGrp.mcHandle.parent.removeChild(param1.itemGrp.mcHandle);
                     }
                     param1.itemGrp.addChild(param1.itemGrp.mcHandle);
                  }
               }
            }
         }
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
            _loc2_.push("torso");
         }
         if(param1.leg == 0)
         {
            _loc2_.push("leg");
         }
         _loc3_ = true;
         _loc4_ = 1;
         while(_loc4_ <= this.maxEquipment["sideWeapon"])
         {
            if(_loc3_ == true)
            {
               _loc3_ = this.isMechReadyForBattleSub(param1["sideWeapon" + _loc4_]);
            }
            _loc4_++;
         }
         _loc4_ = 1;
         while(_loc4_ <= this.maxEquipment["topWeapon"])
         {
            if(_loc3_ == true)
            {
               _loc3_ = this.isMechReadyForBattleSub(param1["topWeapon" + _loc4_]);
            }
            _loc4_++;
         }
         if(_loc3_)
         {
            _loc2_.push("weapon");
         }
         return _loc2_;
      }
      
      private function isMechReadyForBattleSub(param1:Number) : Boolean
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
         if(param3)
         {
            _loc6_ = screensM.screenHangerMech.getTargetMechID();
         }
         else
         {
            _loc6_ = _loc5_.selectedMechID;
         }
         _loc4_ += this.getResistanceSub(param1,_loc6_,"torso",param2);
         _loc4_ = _loc4_ + this.getResistanceSub(param1,_loc6_,"leg",param2);
         _loc7_ = 1;
         while(_loc7_ <= this.maxEquipment["module"])
         {
            _loc4_ += this.getResistanceSub(param1,_loc6_,"module" + _loc7_,param2);
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
      
      public function isTutorialActive() : Boolean
      {
         var _loc1_:Boolean = false;
         _loc1_ = false;
         if(this.getTutorialDestination() != BMDataManager.TUTORIAL_DESTINATION_NONE)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function setTutorialLevel(param1:Number, param2:String = "") : void
      {
         var _loc3_:BMPlayerProfile = null;
         TsLogger.log("SET TUTORIAL LEVEL: " + param1 + " $caller:" + param2);
         _loc3_ = this["player" + this.player1PlayerID + "Profile"];
         if(_loc3_.tutorialLevel < param1)
         {
            if(param1 == BMDataManager.TUTORIAL_LEVEL_COMPLETED)
            {
               param1 += 100;
            }
            _loc3_.tutorialLevel = param1;
            if(this.isTutorialActive() == false)
            {
               BMSpecialOffersManager.gi().refreshSpecialOffersBoostIDs();
            }
            if(this.gameType == BMDataManager.GAME_TYPE_ONLINE)
            {
               remoteM.lobby_setTutorialLevel(_loc3_.tutorialLevel);
            }
            this.saveGuestData("setTutorialLevel");
         }
      }
      
      public function createServerGeneratedUser() : void
      {
         if(this.canCreateServerGeneratedUser())
         {
            this.guestGenerateUserActive = true;
            BMLoginManager.gi().loginType = BMLoginManager.LOGIN_TYPE_REGISTER_GENERATED;
            BMLoginManager.gi().doExternalLogin(LoginServices.GENERATED_USER,"",this.installationData.deviceId);
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         }
      }
      
      public function canCreateServerGeneratedUser() : Boolean
      {
         var _loc1_:Boolean = false;
         _loc1_ = false;
         if(false == false)
         {
            if(this.myProfile.tutorialLevel >= TUTORIAL_LEVEL_MISSION3 && this.gameType == BMDataManager.GAME_TYPE_GUEST)
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      public function openBuyTokensPage(param1:String, param2:Number = NaN) : void
      {
         this.trackEvent("MonetizationFunnel","OpenShop",param1,param2);
         BMShopManager.gi().showTokens();
      }
      
      public function get needToRegisterToBuyRealMoney() : *
      {
         if(this.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
            return true;
         }
         if(this.installationData.lastLoginService == LoginServices.GENERATED_USER)
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
      
      public function openBuyTokensPage_paypal(param1:uint) : void
      {
         var _loc2_:String = null;
         _loc2_ = BMDomainResolver.getHttpDomain() + "/services/tokenSystem/pp.php?package=" + param1;
         this.openURL(_loc2_,"_blank");
         this.showWaitForTokenPurchaseDialog();
      }
      
      public function showWaitForTokenPurchaseDialog() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("refreshBrowserAfterBuyingTokens");
         this.cancelTokenPolling();
         this.tokenPolling = new TokenPolling(remoteM,this.getCurrentPlayerTokens,this.tokenPollingAddedTokens,this.tokenPollingEnded);
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
         screensM.removeScreen("screenConfirmation");
         this.tokenPolling = null;
      }
      
      private function tokenPollingAddedTokens() : void
      {
         this.tokenPollingEnded();
         screensM.screenConfirmation.displayQuestionOrNotification("buyTokens_thankYou");
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
         if(!this.gotPopupFreePackages)
         {
            return;
         }
         _loc1_ = BMNotificationsManager.gi().getRedeemableNotification();
         _loc2_ = new Array();
         _loc2_.push({
            "type":"freeBox",
            "boostId":_loc1_.boostID,
            "id":_loc1_.id,
            "title":_loc1_.popupText
         });
         screensM.addScreen("screenMissionCompleted");
         screensM.screenMissionCompleted.refreshScreen(_loc2_,"FreePackages");
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
         var _loc2_:BMBoostData = null;
         var _loc3_:Object = null;
         var _loc4_:BMWorldMapBossData = null;
         var _loc5_:Array = null;
         var _loc6_:BMTokenPackage = null;
         var _loc7_:Array = null;
         var _loc8_:BMWorldMapLocationData = null;
         this.shopItemDiscountTextFormat = new TextFormat("American Captain Eternal",23,16777215);
         this.animationDB = new Object();
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
            "effectType":"shield",
            "fireEffect":"",
            "effectColor":"orange",
            "sound":"",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["shield2"] = {
            "effectType":"shield",
            "fireEffect":"",
            "effectColor":"red",
            "sound":"",
            "getHitSoundsLength":0,
            "droneOnHoldFrames":0,
            "bulletShellsInstant":"",
            "bulletShellsFrames":""
         };
         this.animationDB["shield3"] = {
            "effectType":"shield",
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
            "effectColor":"orange",
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
            "effectColor":"orange",
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
            "effectColor":"orange",
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
            "effectColor":"orange",
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
            "effectColor":"orange",
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
            "effectColor":"red",
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
            "effectColor":"red",
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
            "effectColor":"blue",
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
            "effectColor":"blue",
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
            "effectColor":"orange",
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
            "effectColor":"orange",
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
            "effectColor":"red",
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
            "effectColor":"red",
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
            "effectColor":"blue",
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
            "effectColor":"blue",
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
            "effectColor":"orange",
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
            "effectColor":"orange",
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
         this.itemTypesDB[0] = "torso";
         this.itemTypesDB[1] = "leg";
         this.itemTypesDB[2] = "sideWeapon";
         this.itemTypesDB[3] = "topWeapon";
         this.itemTypesDB[4] = "drone";
         this.itemTypesDB[5] = "shield";
         this.itemTypesDB[6] = "teleport";
         this.itemTypesDB[7] = "charge";
         this.itemTypesDB[8] = "harpoon";
         this.itemTypesDB[9] = "module";
         this.itemTypesDB[10] = "kit";
         this.itemTypesDB[11] = "perk";
         this.itemTypesReverseDB = new Array();
         this.itemTypesReverseDB["torso"] = 0;
         this.itemTypesReverseDB["leg"] = 1;
         this.itemTypesReverseDB["sideWeapon"] = 2;
         this.itemTypesReverseDB["topWeapon"] = 3;
         this.itemTypesReverseDB["drone"] = 4;
         this.itemTypesReverseDB["shield"] = 5;
         this.itemTypesReverseDB["teleport"] = 6;
         this.itemTypesReverseDB["charge"] = 7;
         this.itemTypesReverseDB["harpoon"] = 8;
         this.itemTypesReverseDB["module"] = 9;
         this.itemTypesReverseDB["kit"] = 10;
         this.itemTypesReverseDB["perk"] = 11;
         this.shopItemTypesDB = new Array();
         this.shopItemTypesDB[0] = "torsoLeg";
         this.shopItemTypesDB[1] = "sideWeapon";
         this.shopItemTypesDB[2] = "topWeapon";
         this.shopItemTypesDB[3] = "specialModule";
         this.shopItemTypesDB[4] = "kit";
         if(this.runAsMobile)
         {
            this.shopItemTypesDB[0] = "torso";
            this.shopItemTypesDB[1] = "leg";
            this.shopItemTypesDB[2] = "sideWeapon";
            this.shopItemTypesDB[3] = "topWeapon";
            this.shopItemTypesDB[4] = "special";
            this.shopItemTypesDB[5] = "module";
            this.shopItemTypesDB[6] = "kit";
         }
         this.shopItemTypesReverseDB = new Array();
         this.shopItemTypesReverseDB["torsoLeg"] = 0;
         this.shopItemTypesReverseDB["torso"] = 0;
         this.shopItemTypesReverseDB["leg"] = 0;
         this.shopItemTypesReverseDB["sideWeapon"] = 1;
         this.shopItemTypesReverseDB["topWeapon"] = 2;
         this.shopItemTypesReverseDB["specialModule"] = 3;
         this.shopItemTypesReverseDB["drone"] = 3;
         this.shopItemTypesReverseDB["shield"] = 3;
         this.shopItemTypesReverseDB["teleport"] = 3;
         this.shopItemTypesReverseDB["charge"] = 3;
         this.shopItemTypesReverseDB["harpoon"] = 3;
         this.shopItemTypesReverseDB["module"] = 3;
         this.shopItemTypesReverseDB["perk"] = 3;
         this.shopItemTypesReverseDB["kit"] = 4;
         if(this.runAsMobile)
         {
            this.shopItemTypesReverseDB["torso"] = 0;
            this.shopItemTypesReverseDB["leg"] = 1;
            this.shopItemTypesReverseDB["sideWeapon"] = 2;
            this.shopItemTypesReverseDB["topWeapon"] = 3;
            this.shopItemTypesReverseDB["drone"] = 4;
            this.shopItemTypesReverseDB["shield"] = 4;
            this.shopItemTypesReverseDB["teleport"] = 4;
            this.shopItemTypesReverseDB["charge"] = 4;
            this.shopItemTypesReverseDB["harpoon"] = 4;
            this.shopItemTypesReverseDB["special"] = 4;
            this.shopItemTypesReverseDB["perk"] = 4;
            this.shopItemTypesReverseDB["module"] = 5;
            this.shopItemTypesReverseDB["kit"] = 6;
         }
         this.shopItemTypesSourceDB = new Array();
         this.shopItemTypesSourceDB[0] = {
            "source":"items1",
            "iconName":"torsoLeg"
         };
         this.shopItemTypesSourceDB[1] = {
            "source":"items2",
            "iconName":"sideWeapon"
         };
         this.shopItemTypesSourceDB[2] = {
            "source":"items2",
            "iconName":"topWeapon"
         };
         this.shopItemTypesSourceDB[3] = {
            "source":"items3",
            "iconName":"specialModule"
         };
         this.shopItemTypesSourceDB[4] = {
            "source":"items3",
            "iconName":"kit"
         };
         this.shopItemTypesSourceDB[5] = {
            "source":"items3",
            "iconName":"perk"
         };
         if(this.runAsMobile)
         {
            this.shopItemTypesSourceDB[0] = {
               "source":"items1",
               "iconName":"torso"
            };
            this.shopItemTypesSourceDB[1] = {
               "source":"items1",
               "iconName":"leg"
            };
            this.shopItemTypesSourceDB[2] = {
               "source":"items2",
               "iconName":"sideWeapon"
            };
            this.shopItemTypesSourceDB[3] = {
               "source":"items2",
               "iconName":"topWeapon"
            };
            this.shopItemTypesSourceDB[4] = {
               "source":"items1",
               "iconName":"special"
            };
            this.shopItemTypesSourceDB[5] = {
               "source":"items3",
               "iconName":"module"
            };
            this.shopItemTypesSourceDB[6] = {
               "source":"items3",
               "iconName":"kit"
            };
            this.shopItemTypesSourceDB[7] = {
               "source":"items3",
               "iconName":"perk"
            };
         }
         this.maxEquipment = new Object();
         this.maxEquipment["sideWeapon"] = this.MAX_SIDE_WEAPONS;
         this.maxEquipment["topWeapon"] = this.MAX_TOP_WEAPONS;
         this.maxEquipment["drone"] = this.MAX_DRONES;
         this.maxEquipment["shield"] = this.MAX_SHIELDS;
         this.maxEquipment["teleport"] = this.MAX_TELEPORTS;
         this.maxEquipment["charge"] = this.MAX_CHARGES;
         this.maxEquipment["harpoon"] = this.MAX_HARPOONS;
         this.maxEquipment["module"] = this.MAX_MODULES;
         this.maxEquipment["kit"] = this.MAX_KITS;
         this.maxEquipment["taunt"] = this.MAX_TAUNTS;
         this.ladderRankIconsDB = new Array();
         this.ladderRankIconsDB[20] = 1;
         this.ladderRankIconsDB[19] = 2;
         this.ladderRankIconsDB[18] = 3;
         this.ladderRankIconsDB[17] = 4;
         this.ladderRankIconsDB[16] = 5;
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
         this.replayActionsDB = new Object();
         this.replayActionsDB["FW"] = "fireWeapon";
         this.replayActionsDB["SH"] = "shutDown";
         this.replayActionsDB["CM"] = "changeMech";
         this.replayActionsDB["KI"] = "useKit";
         this.replayActionsDB["WL"] = "walkLeft";
         this.replayActionsDB["WR"] = "walkRight";
         this.replayActionsDB["JL"] = "jumpLeft";
         this.replayActionsDB["JR"] = "jumpRight";
         this.replayActionsDB["TP"] = "teleport";
         this.replayActionsDB["CH"] = "charge";
         this.replayActionsDB["HR"] = "harpoon";
         this.replayActionsDB["DA"] = "activateDrone";
         this.replayActionsDB["DD"] = "deactivateDrone";
         this.replayActionsDB["SA"] = "activateShield";
         this.replayActionsDB["SD"] = "deactivateShield";
         this.createInfoTextDB();
         this.levelUpDB = new Array();
         this.levelUpDB[0] = 0;
         this.levelUpDB[1] = 0;
         this.levelUpDB[2] = 75;
         this.levelUpDB[3] = 200;
         this.levelUpDB[4] = 550;
         this.levelUpDB[5] = 950;
         this.levelUpDB[6] = 1400;
         this.levelUpDB[7] = 1900;
         this.levelUpDB[8] = 2450;
         this.levelUpDB[9] = 3050;
         this.levelUpDB[10] = 3700;
         this.levelUpDB[11] = 4400;
         this.levelUpDB[12] = 5150;
         this.levelUpDB[13] = 5950;
         this.levelUpDB[14] = 6850;
         this.levelUpDB[15] = 7850;
         this.levelUpDB[16] = 8950;
         this.levelUpDB[17] = 10150;
         this.levelUpDB[18] = 11450;
         this.levelUpDB[19] = 12900;
         this.levelUpDB[20] = 14500;
         this.levelUpDB[21] = 16250;
         this.levelUpDB[22] = 18150;
         this.levelUpDB[23] = 20200;
         this.levelUpDB[24] = 22400;
         this.levelUpDB[25] = 24750;
         this.levelUpDB[26] = 27250;
         this.levelUpDB[27] = 29900;
         this.levelUpDB[28] = 32700;
         this.levelUpDB[29] = 35650;
         this.levelUpDB[30] = 38600;
         this.levelUpDB[31] = 98536;
         this.levelUpDB[32] = 116830;
         this.levelUpDB[33] = 139697;
         this.levelUpDB[34] = 167138;
         this.levelUpDB[35] = 199153;
         this.levelUpDB[36] = 99999999;
         this.itemTypeSourceDB = new Array();
         this.itemTypeSourceDB["torso"] = "items1";
         this.itemTypeSourceDB["leg"] = "items1";
         this.itemTypeSourceDB["sideWeapon"] = "items2";
         this.itemTypeSourceDB["topWeapon"] = "items2";
         this.itemTypeSourceDB["drone"] = "items1";
         this.itemTypeSourceDB["shield"] = "items3";
         this.itemTypeSourceDB["teleport"] = "items3";
         this.itemTypeSourceDB["charge"] = "items3";
         this.itemTypeSourceDB["harpoon"] = "items3";
         this.itemTypeSourceDB["module"] = "items3";
         this.itemTypeSourceDB["kit"] = "items3";
         this.itemTypeSourceDB["perk"] = "items3";
         this.techDB = new Object();
         this.techDB["drone"] = {
            "name":"Drone",
            "maxLevel":1
         };
         this.techDB["shield"] = {
            "name":"Shield",
            "maxLevel":1
         };
         this.techDB["teleport"] = {
            "name":"Teleport",
            "maxLevel":1
         };
         this.techDB["charge"] = {
            "name":"Charge",
            "maxLevel":1
         };
         this.techDB["harpoon"] = {
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
         this.createTipsDB();
         this.createMusicData();
         this.createBattleInterfaceToolTipDB();
         this.colorsDB = new Array();
         this.colorsDB[1] = 4291559424;
         this.colorsDB[2] = 4278216345;
         this.colorsDB[3] = 4284900864;
         this.colorsDB[4] = 4292892928;
         this.colorsDB[5] = 4292269782;
         this.colorsDB[6] = 4288230246;
         this.colorsDB[7] = 4283705856;
         this.colorsDB[8] = 4294950656;
         this.colorsDB[9] = 4280361249;
         this.colorsDB[11] = 4288510017;
         this.colorsDB[12] = 4291856671;
         this.colorsDB[13] = 4294609408;
         this.colorsDB[14] = 4294079232;
         this.colorsDB[15] = 4293150976;
         this.colorsDB[16] = 4292288768;
         this.colorsDB[17] = 4290510848;
         this.colorsDB[18] = 4287954944;
         this.colorsDB[19] = 4284416000;
         this.colorsDB[20] = 4278321152;
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
         this.itemIDsForbiddenForPC = new Object();
         this.itemIDsForbiddenForPC[1058] = true;
         this.itemIDsForbiddenForPC[1059] = true;
         this.itemIDsForbiddenForPC[1060] = true;
         this.itemIDsForbiddenForPC[1061] = true;
         this.itemIDsForbiddenForPC[1062] = true;
         this.boostsDB = new Array();
         _loc2_ = new BMBoostData();
         _loc2_.initialize(2,getSpecificText("packages_bronze"),"resources",90,90,0,0,0,0,50000,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[2] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(3,getSpecificText("packages_silver"),"resources",170,170,0,0,0,0,100000,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[3] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(4,getSpecificText("packages_gold"),"resources",280,280,0,0,0,0,200000,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[4] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(9,getSpecificText("packages_itemsBox"),"randomItems",0,0,0,0,5000,1,0,3,2,50,10,3,0,50,10,3,0,0,0,0,"",0);
         this.boostsDB[9] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(5,getSpecificText("packages_itemsBoxSilver"),"randomItems",90,90,0,0,0,0,0,5,2,53,30,10,7,3,30,10,7,0,0,0,"",0);
         this.boostsDB[5] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(6,getSpecificText("packages_itemsBoxGold"),"randomItems",140,140,0,0,0,0,0,5,2,5,50,30,15,5,50,30,15,0,0,0,"",0);
         this.boostsDB[6] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(11,getSpecificText("packages_itemsBox"),"randomItems",0,0,0,0,500000,1,0,4,2,55,12,4,0,55,12,4,0,0,0,0,"",0);
         this.boostsDB[11] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(12,getSpecificText("packages_itemsBox"),"randomItems",0,0,0,0,500000,1,0,5,2,60,14,5,0,60,14,5,0,0,0,0,"",0);
         this.boostsDB[12] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(19,getSpecificText("packages_itemsBoxMythical"),"randomItems",600,600,0,0,0,0,0,2,2,0,0,0,100,30,0,0,100,0,0,0,"",0);
         this.boostsDB[19] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(20,getSpecificText("packages_itemsBoxMythical"),"randomItems",220,220,0,0,0,0,0,1,2,0,0,0,100,13,0,0,100,0,0,0,"",0);
         this.boostsDB[20] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(8,getSpecificText("packages_premiumAccount"),"premiumAccount",40,40,86400,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[8] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(10,getSpecificText("packages_premiumAccount"),"premiumAccount",100,100,604800,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[10] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(1,getSpecificText("packages_premiumAccount"),"premiumAccount",250,250,2592000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[1] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(14,"","specificItem",150,150,2592000,0,0,892,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[14] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(15,"","specificItem",150,150,2592000,0,0,920,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[15] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(16,"","freeTokens",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,"",0);
         this.boostsDB[16] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(21,"Torsos and legs Item Box","randomItems",0,0,0,2000,500,0,0,2,3,50,12,4,0,0,50,12,4,0,0,80,"torsoLeg",0);
         this.boostsDB[21] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(22,"Weapons Item Box","randomItems",0,0,0,1500,250,0,0,2,3,50,12,4,0,0,50,12,4,0,0,60,"weapons",0);
         this.boostsDB[22] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(23,"Specials Item Box","randomItems",0,0,0,1500,250,0,0,2,3,50,12,4,0,0,50,12,4,0,0,50,"specials",0);
         this.boostsDB[23] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(24,"Modules Item Box","randomItems",0,0,0,1000,125,0,0,2,3,50,12,4,0,0,50,12,4,0,0,50,"modules",0);
         this.boostsDB[24] = _loc2_;
         _loc2_ = new BMBoostData();
         _loc2_.initialize(25,"Mix Item Box","randomItems",0,0,0,1500,250,0,0,3,3,50,12,4,0,0,50,12,4,0,0,50,"mix",0);
         this.boostsDB[25] = _loc2_;
         this.itemTypeSortDB = new Object();
         this.itemTypeSortDB["torso"] = 10000;
         this.itemTypeSortDB["leg"] = 10050;
         this.itemTypeSortDB["sideWeapon"] = 30000;
         this.itemTypeSortDB["topWeapon"] = 40000;
         this.itemTypeSortDB["drone"] = 50000;
         this.itemTypeSortDB["shield"] = 60000;
         this.itemTypeSortDB["teleport"] = 70000;
         this.itemTypeSortDB["charge"] = 80000;
         this.itemTypeSortDB["harpoon"] = 90000;
         this.itemTypeSortDB["module"] = 110000;
         this.itemTypeSortDB["kit"] = 120000;
         this.itemTypeSortDB["perk"] = 1000;
         this.createPowerLevelsDB();
         this.subTypeOriginDB = new Object();
         this.subTypeOriginDB["torso"] = ["torso"];
         this.subTypeOriginDB["leg"] = ["leg"];
         this.subTypeOriginDB["sideWeapon_physical"] = ["sideWeapon_physical"];
         this.subTypeOriginDB["sideWeapon_explosive"] = ["sideWeapon_explosive"];
         this.subTypeOriginDB["sideWeapon_electric"] = ["sideWeapon_electric"];
         this.subTypeOriginDB["sideWeapon_melee"] = ["sideWeapon_melee"];
         this.subTypeOriginDB["topWeapon_physical"] = ["topWeapon_physical"];
         this.subTypeOriginDB["topWeapon_explosive"] = ["topWeapon_explosive"];
         this.subTypeOriginDB["topWeapon_electric"] = ["topWeapon_electric"];
         this.subTypeOriginDB["drone"] = ["drone"];
         this.subTypeOriginDB["shield"] = ["shield"];
         this.subTypeOriginDB["teleport"] = ["specials"];
         this.subTypeOriginDB["charge"] = ["specials"];
         this.subTypeOriginDB["harpoon"] = ["specials"];
         this.subTypeOriginDB["module_armor"] = ["module_armorResistance"];
         this.subTypeOriginDB["module_energyHeat"] = ["module_energyHeat"];
         this.subTypeOriginDB["module_ammo"] = ["module_bulletsRockets"];
         this.subTypeOriginDB["module_resistance"] = ["module_armorResistance"];
         this.subTypeOriginDB["kit_repair"] = ["kit_repairResistance"];
         this.subTypeOriginDB["kit_energyHeat"] = ["kit_energyHeat"];
         this.subTypeOriginDB["kit_ammo"] = ["kit_bulletsRockets"];
         this.subTypeOriginDB["kit_resistance"] = ["kit_repairResistance"];
         this.subTypeOriginDB["kit_power"] = ["kit_power"];
         this.subTypeOriginDB["kit_color"] = ["kit_color"];
         this.subTypeOriginDB_myth = new Object();
         this.subTypeOriginDB_myth["torso"] = ["torso"];
         this.subTypeOriginDB_myth["leg"] = ["leg"];
         this.subTypeOriginDB_myth["sideWeapon_physical"] = ["sideWeapon_physical"];
         this.subTypeOriginDB_myth["sideWeapon_explosive"] = ["sideWeapon_explosive"];
         this.subTypeOriginDB_myth["sideWeapon_electric"] = ["sideWeapon_electric"];
         this.subTypeOriginDB_myth["sideWeapon_melee"] = ["sideWeapon_melee"];
         this.subTypeOriginDB_myth["topWeapon_physical"] = ["topWeapon_physical"];
         this.subTypeOriginDB_myth["topWeapon_explosive"] = ["topWeapon_explosive"];
         this.subTypeOriginDB_myth["topWeapon_electric"] = ["topWeapon_electric"];
         this.subTypeOriginDB_myth["drone"] = ["drone"];
         this.subTypeOriginDB_myth["shield"] = ["shield"];
         this.subTypeOriginDB_myth["teleport"] = ["specials"];
         this.subTypeOriginDB_myth["charge"] = ["specials"];
         this.subTypeOriginDB_myth["harpoon"] = ["specials"];
         this.subTypeOriginDB_myth["module_armor"] = ["module_armorResistance"];
         this.subTypeOriginDB_myth["module_energyHeat"] = ["module_energyHeat"];
         this.subTypeOriginDB_myth["module_ammo"] = ["module_bulletsRockets"];
         this.subTypeOriginDB_myth["module_resistance"] = ["module_armorResistance"];
         this.subTypeOriginDB_combined = new Object();
         this.subTypeOriginDB_combined["kit_power"] = ["kit_power"];
         this.subTypeOriginDB_combined["kit_color"] = ["kit_color"];
         this.subTypeOriginDB_combined["kit_hp"] = ["kit_hp"];
         this.subTypeOriginDB_combined["kit_resistance"] = ["kit_resistance"];
         this.subTypeOriginDB_combined["kit_energy"] = ["kit_energy"];
         this.subTypeOriginDB_combined["kit_cooling"] = ["kit_cooling"];
         this.subTypeOriginDB_combined = new Object();
         this.subTypeOriginDB_combined["box_regular"] = ["box_regular"];
         this.subTypeOriginDB_combined["box_tokens"] = ["box_tokens"];
         this.subTypeOriginDB_combined["premiumAccount"] = ["premiumAccount"];
         this.subTypeOriginDB_combined["kits"] = ["kits"];
         this.subTypeDB = new Object();
         this.subTypeDB["torso"] = {
            "ID":1,
            "source":"items1",
            "name":"torso",
            "unlockLevel":1
         };
         this.subTypeDB["leg"] = {
            "ID":2,
            "source":"items1",
            "name":"leg",
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
         this.subTypeDB["drone"] = {
            "ID":10,
            "source":"items1",
            "name":"drone",
            "unlockLevel":3
         };
         this.subTypeDB["shield"] = {
            "ID":11,
            "source":"items3",
            "name":"shield",
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
         for each(_loc3_ in this.subTypeDB)
         {
            _loc3_.text = getSpecificText("shop_" + _loc3_.name);
         }
         this.SUB_TYPE_SIDE_WEAPON_PHYSICAL = 3;
         this.SUB_TYPE_TOP_WEAPON_ELECTRIC = 9;
         this.SUB_TYPE_MODULE_BULLETS_ROCKETS = 15;
         this.subTypeDB_myth = new Object();
         this.subTypeDB_myth["torso"] = {
            "ID":1,
            "source":"items1",
            "name":"torso",
            "unlockLevel":1
         };
         this.subTypeDB_myth["leg"] = {
            "ID":2,
            "source":"items1",
            "name":"leg",
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
         this.subTypeDB_myth["drone"] = {
            "ID":10,
            "source":"items1",
            "name":"drone",
            "unlockLevel":3
         };
         this.subTypeDB_myth["shield"] = {
            "ID":11,
            "source":"items3",
            "name":"shield",
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
         for each(_loc3_ in this.subTypeDB_myth)
         {
            _loc3_.text = getSpecificText("shop_" + _loc3_.name);
         }
         this.subTypeDB_combined = new Object();
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
         for each(_loc3_ in this.subTypeDB_combined)
         {
            _loc3_.text = getSpecificText("shop_" + _loc3_.name);
         }
         this.subTypeOrderDB = new Array();
         this.subTypeOrderDB.push({"name":"torso"});
         this.subTypeOrderDB.push({"name":"leg"});
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
         this.subTypeOrderDB.push({"name":"drone"});
         this.subTypeOrderDB.push({"name":"shield"});
         this.subTypeOrderDB.push({"name":"specials"});
         this.subTypeOrderDB.push({"name":"module_armorResistance"});
         this.subTypeOrderDB.push({"name":"module_energyHeat"});
         this.subTypeOrderDB.push({"name":"module_bulletsRockets"});
         this.subTypeOrderDB.push({"name":"kit_repairResistance"});
         this.subTypeOrderDB.push({"name":"kit_energyHeat"});
         this.subTypeOrderDB.push({"name":"kit_bulletsRockets"});
         this.subTypeOrderDB.push({"name":"kit_power"});
         this.subTypeOrderDB.push({"name":"kit_color"});
         this.subTypeOrderDB_myth = new Array();
         this.subTypeOrderDB_myth.push({"name":"torso"});
         this.subTypeOrderDB_myth.push({"name":"leg"});
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
         this.subTypeOrderDB_myth.push({"name":"drone"});
         this.subTypeOrderDB_myth.push({"name":"shield"});
         this.subTypeOrderDB_myth.push({"name":"specials"});
         this.subTypeOrderDB_myth.push({"name":"module_armorResistance"});
         this.subTypeOrderDB_myth.push({"name":"module_energyHeat"});
         this.subTypeOrderDB_myth.push({"name":"module_bulletsRockets"});
         this.subTypeOrderDB_combined = new Array();
         this.subTypeOrderDB_combined.push({"name":"box_regular"});
         this.subTypeOrderDB_combined.push({"name":"box_tokens"});
         this.subTypeOrderDB_combined.push({"name":"premiumAccount"});
         this.subTypeOrderDB_combined.push({"name":"kits"});
         this.missionBossesDB = new Array();
         _loc4_ = new BMWorldMapBossData();
         _loc4_.setName("RAMBOY");
         _loc4_.setItems(417,192,223,223,219,219,0,0,243,101,100,0,0,1159);
         _loc4_.setFixedProperties(200,60,20,60,20,40,0,2,2,2);
         this.missionBossesDB.push(_loc4_);
         _loc4_ = new BMWorldMapBossData();
         _loc4_.setName("EXTERMINATOR");
         _loc4_.setItems(202,259,604,206,0,206,0,208,245,143,145,0,0,1159);
         _loc4_.setFixedProperties(250,80,25,80,25,0,0,3,3,3);
         this.missionBossesDB.push(_loc4_);
         _loc4_ = new BMWorldMapBossData();
         _loc4_.setName("CYBER GOAT");
         _loc4_.setItems(578,585,1000,230,1000,230,218,218,498,327,324,412,0,1159);
         _loc4_.setFixedProperties(300,90,30,90,30,100,50,4,4,4);
         this.missionBossesDB.push(_loc4_);
         _loc4_ = new BMWorldMapBossData();
         _loc4_.setName("MOLOTOV");
         _loc4_.setItems(321,319,465,465,553,553,663,663,506,729,803,811,0,1159);
         _loc4_.setFixedProperties(400,100,40,100,40,80,80,5,5,5);
         this.missionBossesDB.push(_loc4_);
         _loc4_ = new BMWorldMapBossData();
         _loc4_.setName("SABERTOOTH");
         _loc4_.setItems(380,588,476,476,921,921,334,334,658,798,803,811,0,1159);
         _loc4_.setFixedProperties(500,120,45,120,45,80,120,6,6,6);
         this.missionBossesDB.push(_loc4_);
         _loc4_ = new BMWorldMapBossData();
         _loc4_.setName("SENIOR QUADS");
         _loc4_.setItems(892,896,887,887,888,888,1040,1040,661,799,804,812,0,1159);
         _loc4_.setFixedProperties(600,140,50,140,50,180,0,8,8,8);
         this.missionBossesDB.push(_loc4_);
         _loc4_ = new BMWorldMapBossData();
         _loc4_.setName("BIGBOY");
         _loc4_.setItems(1058,1059,1044,1044,1001,1001,1156,1178,1122,1026,1028,1046,0,1159);
         _loc4_.setFixedProperties(700,160,55,160,55,160,160,10,10,10);
         this.missionBossesDB.push(_loc4_);
         this.missionsDB = new Array();
         this.missionDisplayNumbers = new Array();
         this.createWorldMapMissionLocationData(81,249);
         this.createWorldMapMissionLocationData(213,223);
         this.createWorldMapMissionLocationData(358,191);
         this.createWorldMapMissionLocationData(495,136,false,1,BMDataManager.MAP_THEME_DESERT,2);
         this.createWorldMapMissionLocationData(470,267);
         this.createWorldMapMissionLocationData(618,223);
         this.createWorldMapMissionLocationData(746,170,true,1,BMDataManager.MAP_THEME_DESERT,1,0,BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS,0);
         this.createWorldMapItemBoxLocationData(753,231,1,5,2);
         this.createWorldMapMissionLocationData(878,234,true,2,BMDataManager.MAP_THEME_FOREST);
         this.createWorldMapMissionLocationData(1016,111,false,2,BMDataManager.MAP_THEME_FOREST,2);
         this.createWorldMapMissionLocationData(940,325,true,2,BMDataManager.MAP_THEME_FOREST);
         this.createWorldMapMissionLocationData(1090,361,true,2,BMDataManager.MAP_THEME_FOREST);
         this.createWorldMapMissionLocationData(1200,269,true,2,BMDataManager.MAP_THEME_FOREST);
         this.createWorldMapMissionLocationData(1334,272,false,2,BMDataManager.MAP_THEME_FOREST,2);
         this.createWorldMapMissionLocationData(1414,443,false,2,BMDataManager.MAP_THEME_FOREST,3);
         this.createWorldMapMissionLocationData(1264,164,true,2,BMDataManager.MAP_THEME_FOREST);
         this.createWorldMapMissionLocationData(1339,31,false,2,BMDataManager.MAP_THEME_FOREST,3);
         this.createWorldMapMissionLocationData(1406,195,true,2,BMDataManager.MAP_THEME_FOREST);
         this.createWorldMapMissionLocationData(1534,267,true,2,BMDataManager.MAP_THEME_FOREST,1,0,BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS,1);
         this.createWorldMapItemBoxLocationData(1534,336,2,5,5);
         this.createWorldMapMissionLocationData(1698,276,true,3,BMDataManager.MAP_THEME_SEA);
         this.createWorldMapMissionLocationData(1906,391,true,3,BMDataManager.MAP_THEME_SEA);
         this.createWorldMapMissionLocationData(1820,175,true,3,BMDataManager.MAP_THEME_SEA);
         this.createWorldMapMissionLocationData(1647,126,false,3,BMDataManager.MAP_THEME_SEA,2);
         this.createWorldMapMissionLocationData(2043,273,true,3,BMDataManager.MAP_THEME_SEA);
         this.createWorldMapMissionLocationData(2221,317,false,3,BMDataManager.MAP_THEME_SEA,2);
         this.createWorldMapMissionLocationData(1953,71,true,3,BMDataManager.MAP_THEME_SEA);
         this.createWorldMapMissionLocationData(2188,180,true,3,BMDataManager.MAP_THEME_SEA);
         this.createWorldMapMissionLocationData(2291,210,false,3,BMDataManager.MAP_THEME_SEA,3);
         this.createWorldMapMissionLocationData(2285,93,true,3,BMDataManager.MAP_THEME_SEA,2,0,BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS,2);
         this.createWorldMapItemBoxLocationData(2301,143,3,6,10);
         this.createWorldMapMissionLocationData(2494,90,true,4,BMDataManager.MAP_THEME_SNOW);
         this.createWorldMapMissionLocationData(2469,185,false,4,BMDataManager.MAP_THEME_SNOW,2);
         this.createWorldMapMissionLocationData(2458,283,false,4,BMDataManager.MAP_THEME_SNOW,3);
         this.createWorldMapMissionLocationData(2653,92,true,4,BMDataManager.MAP_THEME_SNOW);
         this.createWorldMapMissionLocationData(2824,120,true,4,BMDataManager.MAP_THEME_SNOW);
         this.createWorldMapMissionLocationData(2974,85,false,4,BMDataManager.MAP_THEME_SNOW,2);
         this.createWorldMapMissionLocationData(2746,223,true,4,BMDataManager.MAP_THEME_SNOW);
         this.createWorldMapMissionLocationData(2645,329,true,4,BMDataManager.MAP_THEME_SNOW);
         this.createWorldMapMissionLocationData(2806,376,true,4,BMDataManager.MAP_THEME_SNOW);
         this.createWorldMapMissionLocationData(3012,263,false,4,BMDataManager.MAP_THEME_SNOW,3);
         this.createWorldMapMissionLocationData(2977,377,true,4,BMDataManager.MAP_THEME_SNOW,2,0,BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS,3);
         this.createWorldMapItemBoxLocationData(3041,415,4,6,20);
         this.createWorldMapMissionLocationData(3181,356,true,5,BMDataManager.MAP_THEME_LAVA);
         this.createWorldMapMissionLocationData(3252,209,true,5,BMDataManager.MAP_THEME_LAVA);
         this.createWorldMapMissionLocationData(3315,90,true,5,BMDataManager.MAP_THEME_LAVA);
         this.createWorldMapMissionLocationData(3198,62,false,5,BMDataManager.MAP_THEME_LAVA,2);
         this.createWorldMapMissionLocationData(3480,97,true,5,BMDataManager.MAP_THEME_LAVA);
         this.createWorldMapMissionLocationData(3638,185,false,5,BMDataManager.MAP_THEME_LAVA,2);
         this.createWorldMapMissionLocationData(3749,147,false,5,BMDataManager.MAP_THEME_LAVA,3);
         this.createWorldMapMissionLocationData(3455,250,true,5,BMDataManager.MAP_THEME_LAVA);
         this.createWorldMapMissionLocationData(3518,369,true,5,BMDataManager.MAP_THEME_LAVA);
         this.createWorldMapMissionLocationData(3697,353,true,5,BMDataManager.MAP_THEME_LAVA);
         this.createWorldMapMissionLocationData(3838,248,true,5,BMDataManager.MAP_THEME_LAVA,2,0,BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS,4);
         this.createWorldMapItemBoxLocationData(3838,312,5,6,30);
         this.createWorldMapMissionLocationData(4025,234,true,6,BMDataManager.MAP_THEME_WASTELAND);
         this.createWorldMapMissionLocationData(4181,251,true,6,BMDataManager.MAP_THEME_WASTELAND);
         this.createWorldMapMissionLocationData(4266,191,false,6,BMDataManager.MAP_THEME_WASTELAND,2);
         this.createWorldMapMissionLocationData(4291,112,false,6,BMDataManager.MAP_THEME_WASTELAND,3);
         this.createWorldMapMissionLocationData(4289,341,true,6,BMDataManager.MAP_THEME_WASTELAND);
         this.createWorldMapMissionLocationData(4419,411,true,6,BMDataManager.MAP_THEME_WASTELAND);
         this.createWorldMapMissionLocationData(4563,353,false,6,BMDataManager.MAP_THEME_WASTELAND,2);
         this.createWorldMapMissionLocationData(4461,290,true,6,BMDataManager.MAP_THEME_WASTELAND);
         this.createWorldMapMissionLocationData(4361,186,true,6,BMDataManager.MAP_THEME_WASTELAND);
         this.createWorldMapMissionLocationData(4415,67,true,6,BMDataManager.MAP_THEME_WASTELAND);
         this.createWorldMapMissionLocationData(4566,65,true,6,BMDataManager.MAP_THEME_WASTELAND);
         this.createWorldMapMissionLocationData(4645,180,true,6,BMDataManager.MAP_THEME_WASTELAND);
         this.createWorldMapMissionLocationData(4738,205,false,6,BMDataManager.MAP_THEME_WASTELAND,2);
         this.createWorldMapMissionLocationData(4756,290,false,6,BMDataManager.MAP_THEME_WASTELAND,3);
         this.createWorldMapMissionLocationData(4651,324,true,6,BMDataManager.MAP_THEME_WASTELAND);
         this.createWorldMapMissionLocationData(4770,414,true,6,BMDataManager.MAP_THEME_WASTELAND,3,0,BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS,5);
         this.createWorldMapCustomItemBoxLocationData(4679,437,6,1,40);
         this.createWorldMapMissionLocationData(4906,313,true,7,BMDataManager.MAP_THEME_TOWER);
         this.createWorldMapMissionLocationData(4993,170,true,7,BMDataManager.MAP_THEME_TOWER);
         this.createWorldMapMissionLocationData(4951,67,false,7,BMDataManager.MAP_THEME_TOWER,3);
         this.createWorldMapMissionLocationData(5141,101,true,7,BMDataManager.MAP_THEME_TOWER);
         this.createWorldMapMissionLocationData(5295,141,true,7,BMDataManager.MAP_THEME_TOWER);
         this.createWorldMapMissionLocationData(5438,210,false,7,BMDataManager.MAP_THEME_TOWER,3);
         this.createWorldMapMissionLocationData(5357,271,true,7,BMDataManager.MAP_THEME_TOWER);
         this.createWorldMapMissionLocationData(5298,398,true,7,BMDataManager.MAP_THEME_TOWER);
         this.createWorldMapMissionLocationData(5100,392,true,7,BMDataManager.MAP_THEME_TOWER);
         this.createWorldMapMissionLocationData(5188,274,true,7,BMDataManager.MAP_THEME_TOWER,3,0,BMWorldMapLocationData.SUB_TYPE_MISSION_BOSS,6);
         this.createWorldMapCustomItemBoxLocationData(5184,361,7,2,50);
         _loc5_ = [0,0,0,0,0];
         _loc1_ = 0;
         while(_loc1_ < this.missionsDB.length)
         {
            _loc8_ = this.missionsDB[_loc1_];
            if(_loc8_.type == BMWorldMapLocationData.TYPE_LOOT)
            {
               this.missionsItemBoxSlots[_loc1_] = _loc1_;
            }
            else if(_loc8_.type == BMWorldMapLocationData.TYPE_MISSION)
            {
               ++_loc5_[_loc8_.difficulty];
            }
            _loc1_++;
         }
         TsLogger.log(">>>>>>>>>>>>>>>>>>>>>>>>>>>> difficulty:" + _loc5_);
         this.missionLayouts_tutorial = new Array();
         this.missionLayouts_regular = new Array();
         this.missionLayouts_tutorial[0] = {
            "rows":3,
            "columns":3,
            "startLocation":8,
            "layout":"ME_5|L1_1_3"
         };
         this.missionLayouts_tutorial[1] = {
            "rows":4,
            "columns":3,
            "startLocation":11,
            "layout":"ME_2|X1_7_9|CA1_5|JP_8|L1_1_3"
         };
         this.missionLayouts_tutorial[2] = {
            "rows":5,
            "columns":4,
            "startLocation":18,
            "layout":"CA1_13_16|SI2_5_8|L1_1_4|ME_2|SI1_9_12|JP_14|XX_17_20|TK_3"
         };
         this.missionLayouts_regular[1] = new Array();
         this.missionLayouts_regular[1].push({
            "rows":5,
            "columns":5,
            "startLocation":23,
            "layout":"SD1_11_16|X1_6_7|CA1_15|JP_18|L1_1_2|ME_3|XX_21_22_24_25|CA2_10|TK_5"
         });
         this.missionLayouts_regular[1].push({
            "rows":4,
            "columns":5,
            "startLocation":18,
            "layout":"CA1_1_2|JP_4|L1_6_11|ME_5|SI1_14_15|SI2_9_10|XX_16_17_19_20|TK_13"
         });
         this.missionLayouts_regular[1].push({
            "rows":5,
            "columns":4,
            "startLocation":18,
            "layout":"SH1_10_11|X1_9_12|XX_17_20|SB1_1|L1_3_4|ME_14|JP_6|CA2_13_16|TK_7"
         });
         this.missionLayouts_regular[1].push({
            "rows":3,
            "columns":7,
            "startLocation":18,
            "layout":"CA1_6_7|JP_9|L1_1_8|ME_2|SF1_13_14|XX_15_16_17_19_20_21|TK_11"
         });
         this.missionLayouts_regular[1].push({
            "rows":6,
            "columns":4,
            "startLocation":22,
            "layout":"L2_2|SE1_6_7_14_15|CA1_10_11|ME_3|XX_21_24|TK_18_19"
         });
         this.missionLayouts_regular[1].push({
            "rows":4,
            "columns":5,
            "startLocation":18,
            "layout":"L2_1|CA1_15|JP_11_19|SG1_7_8_9_12_14|ME_2|SA1_13|CA2_20"
         });
         this.missionLayouts_regular[1].push({
            "rows":6,
            "columns":4,
            "startLocation":22,
            "layout":"ME_7|XX_21_24|CA1_17|SB1_4|JP_18_19|L1_3_8|SD1_1_5_9_13|SI1_15_16|SI2_11_12|CA2_20"
         });
         this.missionLayouts_regular[1].push({
            "rows":5,
            "columns":5,
            "startLocation":23,
            "layout":"SH1_7_9|CA1_25|JP_18|L1_2_4|SF1_3_8|CA2_21|TK_12_14|ME_13"
         });
         this.missionLayouts_regular[1].push({
            "rows":5,
            "columns":5,
            "startLocation":23,
            "layout":"CA1_12_13_14|SI2_1_5|L1_7_9|SI1_6_10|JP_17_19|ME_18|TK_8"
         });
         this.missionLayouts_regular[1].push({
            "rows":5,
            "columns":6,
            "startLocation":27,
            "layout":"CA1_5_6|JP_4|TK_22|L1_1_2|ME_8|SI1_16_17_18|SI2_10_11_12|XX_25_26_29_30|SC1_19"
         });
         this.missionLayouts_regular[1].push({
            "rows":4,
            "columns":4,
            "startLocation":14,
            "layout":"ME_10_11|L1_6_7|SG1_1_2|SA1_4|CA1_9_13"
         });
         this.missionLayouts_regular[1].push({
            "rows":5,
            "columns":4,
            "startLocation":18,
            "layout":"TK_2_3_6_7_10_11|SI1_9_12|L1_1_4|XX_17_20|SI2_5_8|CA1_13_16"
         });
         this.missionLayouts_regular[1].push({
            "rows":4,
            "columns":6,
            "startLocation":21,
            "layout":"CA1_24|JP_14_16|SG1_8_9_10|L1_5_6|ME_1|SA1_15|CA2_23"
         });
         this.missionLayouts_regular[1].push({
            "rows":5,
            "columns":5,
            "startLocation":23,
            "layout":"SD1_21_22_24_25|X1_2_3_4_7_9_12_14|CA1_1_5|ME_13|L2_8|TK_6_10"
         });
         this.missionLayouts_regular[1].push({
            "rows":5,
            "columns":5,
            "startLocation":23,
            "layout":"CB1_5|CA1_3|SG1_10_15|L1_11_16|ME_6|X1_7_9_12_14_17_19|SA1_20|XX_21_22_24_25|TK_8_13"
         });
         this.missionLayouts_regular[2] = new Array();
         this.missionLayouts_regular[2].push({
            "rows":5,
            "columns":6,
            "startLocation":27,
            "layout":"SH1_8_13_14|L2_1|SE1_7|CA1_6_23_24|SI2_11_12|L1_2|ME_3_4|SI1_17_18|XX_25_26_29_30|TK_21_22"
         });
         this.missionLayouts_regular[2].push({
            "rows":5,
            "columns":6,
            "startLocation":27,
            "layout":"L2_4|SG1_1_2_5_6_7_12|L1_10|ME_21_22|SA1_8_11|CA2_9|TK_20_23|CA3_3"
         });
         this.missionLayouts_regular[2].push({
            "rows":4,
            "columns":4,
            "startLocation":14,
            "layout":"ME_6_7|L3_2|CA2_10|TK_3|CA3_11"
         });
         this.missionLayouts_regular[2].push({
            "rows":4,
            "columns":5,
            "startLocation":18,
            "layout":"ME_9_10|L2_15|CA1_2|JP_7_8|CA3_12|SD1_1_6_11|SF1_5|XX_16_17_19_20|L1_14"
         });
         this.missionLayouts_regular[2].push({
            "rows":6,
            "columns":6,
            "startLocation":33,
            "layout":"SF1_5|ME_12_14|XX_31_32_35_36|SI2_16|L2_6|TK_11_19|CA2_24_30|SI1_22|SD1_1_2_7_8|L1_13|JP_27_28|CA1_25"
         });
         this.missionLayouts_regular[2].push({
            "rows":5,
            "columns":7,
            "startLocation":31,
            "layout":"SC1_1_8_15_22|CA1_14_21|ME_11_18|L1_5_6_7|TK_17_19_25|JP_28|SE1_13"
         });
         this.missionLayouts_regular[2].push({
            "rows":5,
            "columns":5,
            "startLocation":23,
            "layout":"ME_13_18|TK_12_14|JP_17_19|L3_8|SD1_4_5|SB1_1|CA1_7_9"
         });
         this.missionLayouts_regular[3] = new Array();
         this.missionLayouts_regular[3].push({
            "rows":6,
            "columns":7,
            "startLocation":39,
            "layout":"CB1_29_30|CB2_35|SB1_1_7|SI2_16_17_19_20|L1_2|ME_5_12_13|SI1_23_24_26_27|L3_6|JP_9_10|XX_36_37_38_40_41_42|TK_3_32"
         });
         this.missionLayouts_regular[3].push({
            "rows":5,
            "columns":5,
            "startLocation":23,
            "layout":"L2_13|SB1_8|L1_7_9|ME_12_14_18|CB1_20_25|CB2_21|TK_17_19"
         });
         this.missionLayouts_regular[3].push({
            "rows":5,
            "columns":6,
            "startLocation":27,
            "layout":"L2_6_12|SE1_22_23|SI2_5|SC1_13_19|CA3_1|ME_4_10|CB1_7_24|SI1_11|JP_21|XX_25_26_29_30|TK_2_3_8_9"
         });
         this.missionLayouts_regular[3].push({
            "rows":6,
            "columns":6,
            "startLocation":33,
            "layout":"SD1_6_12_18|JP_27_28|SG1_8_9_10_14_16|L1_2|ME_3_4_7_13|SA1_15|L3_1|XX_31_32_35_36|CA2_25_30"
         });
         this.missionLayouts_regular[3].push({
            "rows":7,
            "columns":5,
            "startLocation":33,
            "layout":"SH1_6_10_11_15|L2_1_5|SE1_7_9_12_14|CA1_22_24|JP_26_30|CA3_23|ME_3_8_13|XX_31_32_34_35|SF1_27_29|CA2_28|TK_16_20"
         });
         this.missionLayouts_regular[3].push({
            "rows":5,
            "columns":7,
            "startLocation":32,
            "layout":"CB1_15_22|SH1_17_19|TK_2_6|ME_18_24_26|CA2_28|SD1_3_5|L1_1_7_8_14|CA3_21|JP_9_13|XX_29_30_31_33_34_35|SE1_4"
         });
         this.missionLayouts_regular[3].push({
            "rows":6,
            "columns":7,
            "startLocation":39,
            "layout":"CB1_28_35|SH1_9_10_16_17|TK_1_7|XX_36_37_38_40_41_42|CB2_22_29|ME_4_31_32_33|L1_2_3_5_6|JP_8_14|SE1_12_13_19_20"
         });
         this.allTokenPackages = new Array();
         _loc6_ = new BMTokenPackage();
         _loc6_.initialize(1,1,1,"27",1,0);
         this.allTokenPackages.push(_loc6_);
         _loc6_ = new BMTokenPackage();
         _loc6_.initialize(2,1,2,"1",2,0);
         this.allTokenPackages.push(_loc6_);
         _loc6_ = new BMTokenPackage();
         _loc6_.initialize(3,1,3,"2",3,0);
         this.allTokenPackages.push(_loc6_);
         _loc6_ = new BMTokenPackage();
         _loc6_.initialize(4,1,4,"3",4,1);
         this.allTokenPackages.push(_loc6_);
         _loc6_ = new BMTokenPackage();
         _loc6_.initialize(5,1,5,"24",5,2);
         this.allTokenPackages.push(_loc6_);
         this.wheelsDB = new Object();
         this.wheelsDB[37] = true;
         this.wheelsDB[194] = true;
         this.wheelsDB[195] = true;
         this.wheelsDB[196] = true;
         this.wheelsDB[260] = true;
         this.wheelsDB[261] = true;
         this.wheelsDB[584] = true;
         this.wheelsDB[338] = true;
         this.wheelsDB[916] = true;
         this.wheelsDB[917] = true;
         this.wheelsDB[981] = true;
         this.wheelsDB[982] = true;
         this.wheelsDB[983] = true;
         this.wheelsDB[1059] = true;
         this.missionUpgradesDB = new Object();
         this.missionUpgradesDB["HP"] = "upgradeHP";
         this.missionUpgradesDB["EN"] = "upgradeEnergy";
         this.missionUpgradesDB["HT"] = "upgradeHeat";
         this.missionUpgradesDB["BL"] = "upgradeBullets";
         this.missionUpgradesDB["RK"] = "upgradeRockets";
         this.missionUpgradesReverseDB = new Object();
         this.missionUpgradesReverseDB["upgradeHP"] = "HP";
         this.missionUpgradesReverseDB["upgradeEnergy"] = "EN";
         this.missionUpgradesReverseDB["upgradeHeat"] = "HT";
         this.missionUpgradesReverseDB["upgradeBullets"] = "BL";
         this.missionUpgradesReverseDB["upgradeRockets"] = "RK";
         this.missionMapObjectDB = new Object();
         this.missionMapObjectDB["TR"] = {
            "code":"TR",
            "type":"enemy",
            "grp":"turret",
            "dirtSize":1
         };
         this.missionMapObjectDB["JP"] = {
            "code":"JP",
            "type":"enemy",
            "grp":"jeep",
            "dirtSize":1
         };
         this.missionMapObjectDB["TK"] = {
            "code":"TK",
            "type":"enemy",
            "grp":"tank",
            "dirtSize":2
         };
         this.missionMapObjectDB["ME"] = {
            "code":"ME",
            "type":"enemy",
            "grp":"mech",
            "dirtSize":2
         };
         this.missionMapObjectDB["BS"] = {
            "code":"BS",
            "type":"enemy",
            "grp":"boss",
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
         this.createEquipmentUnlockedDB(false);
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
         ,"Andrewid","Seth","Joebot","The Unknown","Alexander","Model X","MicroNuke","HellGate","End of the Line","Explosive Dust","Debree","Naplam Strike","Black Mirror","MacroBlast","ElectroQuake","Defence Magnet","Bunker","Rocket Slayer","Mass Detonator","Sparks","Sniper Mark X","Stomp Master","Laser Blade","Explosive Turret","HardCoded","Mythical Theory");
      }
      
      public function getTutorialDestination() : uint
      {
         var _loc1_:uint = 0;
         _loc1_ = TUTORIAL_DESTINATION_NONE;
         if(this.gameType == BMDataManager.GAME_TYPE_GUEST || this.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            if(this.myProfile.tutorialLevel < 100)
            {
               switch(this.myProfile.tutorialLevel)
               {
                  case TUTORIAL_LEVEL_NOT_SET:
                  case TUTORIAL_LEVEL_MECH1:
                     _loc1_ = BMDataManager.TUTORIAL_DESTINATION_MECH;
                     break;
                  case TUTORIAL_LEVEL_LONE_BATTLE1:
                     _loc1_ = BMDataManager.TUTORIAL_DESTINATION_LONE_BATTLE;
                     break;
                  case TUTORIAL_LEVEL_MECH2:
                     _loc1_ = BMDataManager.TUTORIAL_DESTINATION_MECH;
                     break;
                  case TUTORIAL_LEVEL_LONE_BATTLE2:
                     _loc1_ = BMDataManager.TUTORIAL_DESTINATION_LONE_BATTLE;
                     break;
                  case TUTORIAL_LEVEL_MECH3:
                     _loc1_ = BMDataManager.TUTORIAL_DESTINATION_MECH;
                     break;
                  case TUTORIAL_LEVEL_MISSION1:
                     _loc1_ = BMDataManager.TUTORIAL_DESTINATION_MISSION;
                     break;
                  case TUTORIAL_LEVEL_SHOP1:
                     _loc1_ = BMDataManager.TUTORIAL_DESTINATION_SHOP;
                     break;
                  case TUTORIAL_LEVEL_MECH4:
                     _loc1_ = BMDataManager.TUTORIAL_DESTINATION_MECH;
                     break;
                  case TUTORIAL_LEVEL_MISSION2:
                     _loc1_ = BMDataManager.TUTORIAL_DESTINATION_MISSION;
                     break;
                  case TUTORIAL_LEVEL_MECH5:
                     _loc1_ = BMDataManager.TUTORIAL_DESTINATION_MECH;
                     break;
                  case TUTORIAL_LEVEL_FUSION:
                     _loc1_ = BMDataManager.TUTORIAL_DESTINATION_FUSION;
                     break;
                  case TUTORIAL_LEVEL_SHOP2:
                     _loc1_ = BMDataManager.TUTORIAL_DESTINATION_SHOP;
                     break;
                  case TUTORIAL_LEVEL_MISSION3:
                     _loc1_ = BMDataManager.TUTORIAL_DESTINATION_MISSION;
               }
            }
         }
         return _loc1_;
      }
      
      public function traceTutorialDestination() : void
      {
         if(this.myProfile == null)
         {
            return;
         }
         switch(this.myProfile.tutorialLevel)
         {
            case TUTORIAL_LEVEL_NOT_SET:
               trace("TUTORIAL_LEVEL_NOT_SET");
               break;
            case TUTORIAL_LEVEL_MECH1:
               trace("TUTORIAL_LEVEL_MECH1");
               break;
            case TUTORIAL_LEVEL_LONE_BATTLE1:
               trace("TUTORIAL_LEVEL_LONE_BATTLE1");
               break;
            case TUTORIAL_LEVEL_MECH2:
               trace("TUTORIAL_LEVEL_MECH2");
               break;
            case TUTORIAL_LEVEL_LONE_BATTLE2:
               trace("TUTORIAL_LEVEL_LONE_BATTLE2");
               break;
            case TUTORIAL_LEVEL_MECH3:
               trace("TUTORIAL_LEVEL_MECH3");
               break;
            case TUTORIAL_LEVEL_MISSION1:
               trace("TUTORIAL_LEVEL_MISSION1");
               break;
            case TUTORIAL_LEVEL_SHOP1:
               trace("TUTORIAL_LEVEL_SHOP1");
               break;
            case TUTORIAL_LEVEL_MECH4:
               trace("TUTORIAL_LEVEL_MECH4");
               break;
            case TUTORIAL_LEVEL_MISSION2:
               trace("TUTORIAL_LEVEL_MISSION2");
               break;
            case TUTORIAL_LEVEL_MECH5:
               trace("TUTORIAL_LEVEL_MECH5");
               break;
            case TUTORIAL_LEVEL_FUSION:
               trace("TUTORIAL_LEVEL_FUSION");
               break;
            case TUTORIAL_LEVEL_SHOP2:
               trace("TUTORIAL_LEVEL_SHOP2");
               break;
            case TUTORIAL_LEVEL_MISSION3:
               trace("TUTORIAL_LEVEL_MISSION3");
               break;
            default:
               trace("TUTORIAL_LEVEL_COMPLETED");
         }
      }
      
      private function createWorldMapMissionLocationData(param1:uint, param2:uint, param3:Boolean = true, param4:uint = 1, param5:uint = 1, param6:uint = 1, param7:uint = 0, param8:uint = 1, param9:Number = -1) : void
      {
         var _loc10_:BMWorldMapLocationData = null;
         if(param3)
         {
            if(this.missionDisplayNumbers[param5] == null)
            {
               this.missionDisplayNumbers[param5] = 1;
            }
            else
            {
               this.missionDisplayNumbers[param5] += 1;
            }
         }
         _loc10_ = new BMWorldMapLocationData();
         _loc10_.initializeMission(this.missionsDB.length,this.missionDisplayNumbers[param5],param1,param2,param3,param4,param5,param6,param7,param8,param9);
         this.missionsDB.push(_loc10_);
      }
      
      private function createWorldMapItemBoxLocationData(param1:uint, param2:uint, param3:uint = 1, param4:uint = 5, param5:uint = 0) : void
      {
         var _loc6_:BMWorldMapLocationData = null;
         _loc6_ = new BMWorldMapLocationData();
         _loc6_.initializeItemBoxLoot(this.missionsDB.length,param1,param2,param3,param4,param5);
         this.missionsDB.push(_loc6_);
      }
      
      private function createWorldMapCustomItemBoxLocationData(param1:uint, param2:uint, param3:uint = 1, param4:uint = 1, param5:uint = 0) : void
      {
         var _loc6_:BMWorldMapLocationData = null;
         _loc6_ = new BMWorldMapLocationData();
         _loc6_.initializeCustomItemBoxLoot(this.missionsDB.length,param1,param2,param3,param4,param5);
         this.missionsDB.push(_loc6_);
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
      
      public function createTipsDB() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         this.tipsDB = new Array();
         _loc1_ = 1;
         while(_loc1_ <= 30)
         {
            _loc2_ = getSpecificText("tip_" + String(_loc1_));
            if(_loc2_ != "")
            {
               this.tipsDB.push(_loc2_);
            }
            _loc1_++;
         }
         _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            _loc2_ = getSpecificText("tipWeb_" + String(_loc1_));
            if(_loc2_ != "")
            {
               this.tipsDB.push(_loc2_);
            }
            _loc1_++;
         }
         this.tipsManager = BMTipsManager.getInstance();
      }
      
      public function createBattleInterfaceToolTipDB() : void
      {
         this.battleInterfaceToolTipDB = new Object();
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
         this.infoTextDB = new Object();
         this.infoTextDB["walkLeft"] = getSpecificText("battleInterfaceBottom_walkLeft");
         this.infoTextDB["walkRight"] = getSpecificText("battleInterfaceBottom_walkRight");
         this.infoTextDB["jumpLeft"] = getSpecificText("battleInterfaceBottom_jumpLeft");
         this.infoTextDB["jumpRight"] = getSpecificText("battleInterfaceBottom_jumpRight");
         this.infoTextDB["shutDown"] = getSpecificText("battleInterfaceBottom_shutDown");
         this.infoTextDB["droneActivate"] = getSpecificText("battleInterfaceBottom_droneActivate");
         this.infoTextDB["droneDeactivate"] = getSpecificText("battleInterfaceBottom_droneDeactivate");
         this.infoTextDB["shieldActivate"] = getSpecificText("battleInterfaceBottom_shieldActivate");
         this.infoTextDB["shieldDeactivate"] = getSpecificText("battleInterfaceBottom_shieldDeactivate");
         this.infoTextDB["charge"] = getSpecificText("battleInterfaceBottom_charge");
         this.infoTextDB["harpoon"] = getSpecificText("battleInterfaceBottom_harpoon");
         this.infoTextDB["teleport"] = getSpecificText("battleInterfaceBottom_teleport");
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
            "type":"drone",
            "name":getSpecificText("help_droneTitle"),
            "tip":getSpecificText("help_drone")
         });
         this.helpDB.push({
            "type":"shield",
            "name":getSpecificText("help_shieldTitle"),
            "tip":getSpecificText("help_shield")
         });
         this.helpDB.push({
            "type":"charge",
            "name":getSpecificText("help_chargeTitle"),
            "tip":getSpecificText("help_charge")
         });
         this.helpDB.push({
            "type":"teleport",
            "name":getSpecificText("help_teleportTitle"),
            "tip":getSpecificText("help_teleport")
         });
         this.helpDB.push({
            "type":"harpoon",
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
      
      public function createEquipmentUnlockedDB(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Object = null;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         if(param1 == false)
         {
            this.equipmentUnlockDB = new Object();
            this.equipmentUnlockDB["torso"] = {
               "name":"torso",
               "total":1,
               "level":1
            };
            this.equipmentUnlockDB["leg"] = {
               "name":"leg",
               "total":1,
               "level":1
            };
            this.equipmentUnlockDB["sideWeapon1"] = {
               "name":"sideWeapon",
               "total":1,
               "level":1
            };
            this.equipmentUnlockDB["sideWeapon2"] = {
               "name":"sideWeapon",
               "total":2,
               "level":1
            };
            this.equipmentUnlockDB["sideWeapon3"] = {
               "name":"sideWeapon",
               "total":3,
               "level":6
            };
            this.equipmentUnlockDB["sideWeapon4"] = {
               "name":"sideWeapon",
               "total":4,
               "level":9
            };
            this.equipmentUnlockDB["topWeapon1"] = {
               "name":"topWeapon",
               "total":1,
               "level":2
            };
            this.equipmentUnlockDB["topWeapon2"] = {
               "name":"topWeapon",
               "total":2,
               "level":7
            };
            this.equipmentUnlockDB["drone"] = {
               "name":"drone",
               "total":1,
               "level":3
            };
            this.equipmentUnlockDB["shield"] = {
               "name":"shield",
               "total":1,
               "level":6
            };
            this.equipmentUnlockDB["teleport"] = {
               "name":"teleport",
               "total":1,
               "level":4
            };
            this.equipmentUnlockDB["charge"] = {
               "name":"charge",
               "total":1,
               "level":7
            };
            this.equipmentUnlockDB["harpoon"] = {
               "name":"harpoon",
               "total":1,
               "level":5
            };
            this.equipmentUnlockDB["mech2"] = {
               "name":"mech1",
               "total":1,
               "level":10
            };
            this.equipmentUnlockDB["mech3"] = {
               "name":"mech2",
               "total":2,
               "level":10
            };
            this.SECOND_MECH_UNLOCK_LEVEL = this.equipmentUnlockDB["mech2"].level;
            this.equipmentUnlockDB["module1"] = {
               "name":"module",
               "total":1,
               "level":2
            };
            this.equipmentUnlockDB["module2"] = {
               "name":"module",
               "total":2,
               "level":3
            };
            this.equipmentUnlockDB["module3"] = {
               "name":"module",
               "total":3,
               "level":5
            };
            this.equipmentUnlockDB["module4"] = {
               "name":"module",
               "total":4,
               "level":8
            };
            this.equipmentUnlockDB["module5"] = {
               "name":"module",
               "total":5,
               "level":11
            };
            this.equipmentUnlockDB["module6"] = {
               "name":"module",
               "total":6,
               "level":12
            };
            this.equipmentUnlockDB["module7"] = {
               "name":"module",
               "total":7,
               "level":13
            };
            this.equipmentUnlockDB["perk"] = {
               "name":"perk",
               "total":1,
               "level":1
            };
         }
         if(this.inventoryMaxMechs == 6)
         {
            this.equipmentUnlockDB["mech4"] = {
               "name":"mech1",
               "total":4,
               "level":30
            };
            this.equipmentUnlockDB["mech5"] = {
               "name":"mech2",
               "total":5,
               "level":30
            };
            this.equipmentUnlockDB["mech6"] = {
               "name":"mech3",
               "total":6,
               "level":30
            };
         }
         else
         {
            this.equipmentUnlockDB["mech4"] = {
               "name":"mech1",
               "total":4,
               "level":99999999
            };
            this.equipmentUnlockDB["mech5"] = {
               "name":"mech2",
               "total":5,
               "level":99999999
            };
            this.equipmentUnlockDB["mech6"] = {
               "name":"mech3",
               "total":6,
               "level":99999999
            };
         }
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
            this.equipmentUnlockByLevelDB[_loc4_] = new Object();
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
      
      private function overwriteColorsDB() : void
      {
      }
      
      public function getBoostGoldCost(param1:uint) : uint
      {
         var _loc2_:BMBoostData = null;
         var _loc3_:BMPlayerProfile = null;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         _loc2_ = this.boostsDB[param1];
         _loc3_ = this["player" + this.player1PlayerID + "Profile"];
         _loc4_ = _loc3_.level;
         if(_loc4_ >= 3)
         {
            _loc4_ -= 3;
         }
         else
         {
            _loc4_ = 0;
         }
         return _loc2_.costGold + _loc4_ * _loc2_.goldAddonPerLevel;
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
            _loc2_ = this.replaceStringInText(_loc4_,"%AMOUNT%",this.getNumberWithComma(_loc3_));
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
         this.achievementsSortedDB = new Object();
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
         var _loc1_:Boolean = false;
         var _loc2_:BMPlayerProfile = null;
         _loc1_ = false;
         if(this.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            _loc2_ = this.myProfile;
            if(_loc2_ != null && _loc2_.starterPackData != null)
            {
               if(_loc2_.starterPackData.packID > 0)
               {
                  if(_loc2_.starterPackData.starterPackStatus == 0)
                  {
                     if(this.isTutorialActive() == false)
                     {
                        _loc1_ = true;
                     }
                  }
               }
            }
         }
         return _loc1_;
      }
      
      public function updateStarterPackActive() : void
      {
         var _loc1_:BMPlayerProfile = null;
         _loc1_ = this.myProfile;
         if(this.isStarterPackActive())
         {
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
      }
      
      public function missionWorldMapInterfaceActive() : Boolean
      {
         var _loc1_:Boolean = false;
         return false;
      }
      
      public function isMechReadyForBattle(param1:Boolean, param2:uint = 1) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:BMPlayerData = null;
         var _loc5_:uint = 0;
         var _loc6_:BMMechStructure = null;
         var _loc7_:uint = 0;
         _loc3_ = true;
         _loc4_ = this.playersData[this.player1PlayerID];
         if(param1)
         {
            _loc5_ = screensM.screenHangerMech.getTargetMechID();
         }
         else
         {
            _loc7_ = 1;
            while(_loc7_ <= param2)
            {
               _loc6_ = _loc4_.mechStructures[_loc7_];
               if(this.mechMissingPartsForBattle(_loc6_).length > 0)
               {
                  _loc3_ = false;
                  _loc7_ = param2;
               }
               _loc7_++;
            }
         }
         return _loc3_;
      }
      
      public function startedBattleVSComputer(param1:Number) : void
      {
         this.computerBattleID = param1;
      }
      
      public function removeFriendship(param1:Number) : void
      {
         var _loc2_:Object = null;
         var _loc3_:BMFriendshipData = null;
         _loc2_ = new Object();
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
         var _loc5_:Object = null;
         _loc2_ = false;
         _loc3_ = this["player" + this.player1PlayerID + "Profile"];
         if(_loc3_.clanID > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.clan_members.length)
            {
               _loc5_ = _loc3_.clan_members[_loc4_];
               if(_loc5_.playerID == param1)
               {
                  _loc2_ = true;
                  _loc4_ = _loc3_.clan_members.length;
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
      
      public function getRankIconNumber(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         _loc2_ = 62;
         _loc3_ = param1;
         if(_loc3_ < 1)
         {
            _loc3_ = 1;
         }
         else if(_loc3_ > _loc2_)
         {
            _loc3_ = _loc2_;
         }
         return _loc3_;
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
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         this.ladderRankByProgress = new Array();
         this.ladderProgressMaxByRank = new Array();
         _loc1_ = 0;
         _loc2_ = 0;
         while(_loc2_ < this.ladderRankMax)
         {
            _loc3_ = this.ladderRankMax - _loc2_;
            _loc4_ = this.ladderProgressBase + Math.floor((this.ladderRankMax - _loc3_) / this.ladderRanksPerStar) + 1;
            _loc5_ = 1;
            while(_loc5_ <= _loc4_)
            {
               _loc1_ += 1;
               this.ladderRankByProgress[_loc1_] = _loc3_;
               _loc5_++;
            }
            this.ladderProgressMaxByRank[_loc3_] = _loc1_;
            _loc2_++;
         }
      }
      
      public function getLadderRankByProgress(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
         if(this.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            if(this.ladderRankByProgress[param1] != null)
            {
               _loc2_ = uint(this.ladderRankByProgress[param1]);
            }
            else if(param1 > this.ladderProgressMaxByRank[1])
            {
               _loc2_ = 1;
            }
         }
         return _loc2_;
      }
      
      public function getLadderProgressMaxByRank(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         _loc2_ = 0;
         if(this.ladderProgressMaxByRank[param1] != null)
         {
            _loc2_ = uint(this.ladderProgressMaxByRank[param1]);
         }
         return _loc2_;
      }
      
      public function getLadderProgressBaseByRank(param1:uint) : uint
      {
         var _loc2_:uint = 0;
         _loc2_ = 1;
         if(param1 < this.ladderRankMax)
         {
            param1 += 1;
            if(this.ladderProgressMaxByRank[param1] != null)
            {
               _loc2_ = this.ladderProgressMaxByRank[param1] + 1;
            }
         }
         return _loc2_;
      }
      
      public function mechIsOverWeight(param1:Array) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:BMPlayerData = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc2_ = false;
         _loc3_ = this.playersData[this.player1PlayerID];
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = uint(param1[_loc4_]);
            if(_loc3_.mechStructures[_loc5_].mechWeight > this.weightMax)
            {
               _loc2_ = true;
            }
            _loc4_++;
         }
         return _loc2_;
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
         var _loc25_:BMReplayAction = null;
         var _loc26_:String = null;
         var _loc27_:Number = NaN;
         var _loc28_:Boolean = false;
         var _loc29_:String = null;
         var _loc30_:String = null;
         var _loc31_:String = null;
         var _loc32_:BMReplayStatus = null;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
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
            _loc19_ = new BMMechStructure();
            _loc20_ = 1;
            _loc19_.initialize(_loc4_,_loc20_);
            _loc21_ = "";
            _loc33_ = 0;
            while(_loc33_ < _loc18_.length)
            {
               _loc5_ = _loc18_.substr(_loc33_,1);
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
                        _loc22_ = "torso";
                        break;
                     case "LE":
                        _loc22_ = "leg";
                        break;
                     case "SW":
                        _loc22_ = "sideWeapon";
                        break;
                     case "TW":
                        _loc22_ = "topWeapon";
                        break;
                     case "SL":
                        _loc22_ = "shield";
                        break;
                     case "DR":
                        _loc22_ = "drone";
                        break;
                     case "TP":
                        _loc22_ = "teleport";
                        break;
                     case "CH":
                        _loc22_ = "charge";
                        break;
                     case "HR":
                        _loc22_ = "harpoon";
                        break;
                     case "KI":
                        _loc22_ = "kit";
                        break;
                     case "MO":
                        _loc22_ = "module";
                        break;
                     case "PR":
                        _loc22_ = "perk";
                  }
                  if(_loc24_)
                  {
                     _loc3_["player" + _loc4_ + "MechStructures"][_loc20_] = _loc19_;
                     _loc20_++;
                     _loc19_ = new BMMechStructure();
                     _loc19_.initialize(_loc4_,_loc20_);
                     _loc21_ = "";
                  }
                  else
                  {
                     _loc21_ = _loc21_.substr(3,_loc21_.length - 3);
                     switch(_loc22_)
                     {
                        case "torso":
                        case "leg":
                           _loc19_[_loc22_] = int(_loc21_.substr(0,_loc21_.length - 2));
                           _loc19_[_loc22_ + "_colorID"] = int(_loc21_.substr(_loc21_.length - 1,1));
                           break;
                        case "sideWeapon":
                        case "topWeapon":
                           _loc19_[_loc22_ + _loc21_.substr(0,1)] = int(_loc21_.substr(2,_loc21_.length - 4));
                           _loc19_[_loc22_ + _loc21_.substr(0,1) + "_colorID"] = int(_loc21_.substr(_loc21_.length - 1,1));
                           break;
                        case "shield":
                        case "drone":
                        case "teleport":
                        case "charge":
                        case "harpoon":
                        case "perk":
                           _loc19_[_loc22_] = int(_loc21_);
                           break;
                        case "kit":
                        case "module":
                           _loc19_[_loc22_ + _loc21_.substr(0,1)] = int(_loc21_.substr(2,_loc21_.length - 2));
                     }
                     _loc21_ = "";
                     if(_loc33_ == _loc18_.length - 1)
                     {
                        _loc3_["player" + _loc4_ + "MechStructures"][_loc20_] = _loc19_;
                     }
                  }
               }
               else
               {
                  _loc21_ += _loc5_;
               }
               _loc33_++;
            }
            _loc4_++;
         }
         _loc7_ = param1.actions;
         var _loc8_:Number = 0;
         _loc33_ = 0;
         while(_loc33_ < _loc7_.length)
         {
            _loc25_ = new BMReplayAction();
            _loc26_ = _loc7_.substr(_loc33_,1);
            if(_loc26_ == "X")
            {
               _loc25_.actionName = "battleResult";
               _loc33_ += 1;
            }
            else
            {
               _loc27_ = int(_loc26_);
               if(_loc6_)
               {
                  if(_loc27_ == 1)
                  {
                     _loc27_ = 2;
                  }
                  else
                  {
                     _loc27_ = 1;
                  }
               }
               _loc25_.playerNumber = _loc27_;
               _loc33_ += 2;
               _loc26_ = _loc7_.substr(_loc33_,2);
               switch(_loc26_)
               {
                  case "FW":
                     _loc25_.actionName = "fire";
                     _loc33_ += 3;
                     _loc28_ = false;
                     switch(_loc7_.substr(_loc33_,1))
                     {
                        case "S":
                           _loc25_.equipmentType = "sideWeapon";
                           _loc28_ = true;
                           break;
                        case "T":
                           _loc25_.equipmentType = "topWeapon";
                           _loc28_ = true;
                           break;
                        case "D":
                           _loc25_.equipmentType = "drone";
                           break;
                        case "L":
                           _loc25_.equipmentType = "leg";
                     }
                     if(_loc28_)
                     {
                        _loc33_ += 2;
                        _loc25_.equipmentID = int(_loc7_.substr(_loc33_,1));
                     }
                     _loc33_ += 2;
                     break;
                  case "SH":
                     _loc25_.actionName = "shutDown";
                     _loc33_ += 3;
                     break;
                  case "KI":
                     _loc25_.actionName = "useKit";
                     _loc33_ += 3;
                     _loc25_.equipmentID = int(_loc7_.substr(_loc33_,1));
                     _loc33_ += 2;
                     break;
                  case "MV":
                     _loc25_.actionName = "moveMechToStep";
                     _loc33_ += 3;
                     switch(_loc7_.substr(_loc33_,1))
                     {
                        case "W":
                           _loc25_.motionType = "walk";
                           break;
                        case "J":
                           _loc25_.motionType = "jump";
                     }
                     _loc33_ += 2;
                     break;
                  case "TP":
                     _loc25_.actionName = "teleport";
                     _loc33_ += 3;
                     break;
                  case "CH":
                     _loc25_.actionName = "charge";
                     _loc33_ += 3;
                     break;
                  case "HR":
                     _loc25_.actionName = "harpoon";
                     _loc33_ += 3;
                     break;
                  case "DA":
                     _loc25_.actionName = "activateDrone";
                     _loc33_ += 3;
                     break;
                  case "DD":
                     _loc25_.actionName = "deactivateDrone";
                     _loc33_ += 3;
                     break;
                  case "SA":
                     _loc25_.actionName = "activateShield";
                     _loc33_ += 3;
                     break;
                  case "SD":
                     _loc25_.actionName = "deactivateShield";
                     _loc33_ += 3;
                     break;
                  case "SW":
                     _loc25_.actionName = "switchMech";
                     _loc33_ += 3;
                     _loc25_.mechID = int(_loc7_.substr(_loc33_,1));
                     _loc33_ += 2;
                     break;
                  case "QU":
                     _loc3_.quitPlayerID = _loc3_["playerID" + _loc25_.playerNumber];
                     _loc25_.actionName = "quit";
                     _loc33_ += 3;
               }
               _loc3_.actions.push(_loc25_);
            }
         }
         _loc9_ = 0;
         _loc10_ = 0;
         _loc4_ = 1;
         while(_loc4_ <= 2)
         {
            _loc29_ = param1["status" + _loc4_];
            _loc30_ = "AP";
            _loc31_ = "";
            _loc32_ = new BMReplayStatus();
            _loc33_ = 0;
            while(_loc33_ < _loc29_.length)
            {
               _loc5_ = _loc29_.substr(_loc33_,1);
               if(_loc5_ == "_")
               {
                  _loc34_ = int(_loc31_);
                  if(_loc6_ && _loc30_ == "step")
                  {
                     _loc34_ = _loc3_.mapStepsTotal - 1 - _loc34_;
                  }
                  _loc32_[_loc30_] = _loc34_;
                  if(_loc30_ == "HP")
                  {
                     if(_loc34_ <= 0)
                     {
                        _loc35_ = 1;
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
                  switch(_loc30_)
                  {
                     case "AP":
                        _loc30_ = "HP";
                        break;
                     case "HP":
                        _loc30_ = "heat";
                        break;
                     case "heat":
                        _loc30_ = "energy";
                        break;
                     case "energy":
                        _loc30_ = "bullets";
                        break;
                     case "bullets":
                        _loc30_ = "rockets";
                        break;
                     case "rockets":
                        _loc30_ = "step";
                        break;
                     case "step":
                        _loc30_ = "shield";
                        break;
                     case "shield":
                        _loc30_ = "drone";
                        break;
                     case "drone":
                        _loc30_ = "resist1";
                        break;
                     case "resist1":
                        _loc30_ = "resist2";
                        break;
                     case "resist2":
                        _loc30_ = "resist3";
                        break;
                     case "resist3":
                        _loc30_ = "AP";
                  }
                  _loc31_ = "";
               }
               else if(_loc5_ == "X")
               {
                  _loc3_["status" + _loc4_].push(_loc32_);
                  if(_loc33_ < _loc29_.length - 1)
                  {
                     _loc32_ = new BMReplayStatus();
                     _loc31_ = "";
                  }
               }
               else
               {
                  _loc31_ += _loc5_;
               }
               _loc33_++;
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
         var _loc5_:String = null;
         var _loc6_:Number = NaN;
         var _loc7_:String = null;
         var _loc8_:Number = NaN;
         var _loc9_:uint = 0;
         var _loc10_:String = null;
         var _loc11_:Number = NaN;
         var _loc12_:uint = 0;
         var _loc13_:BMPlayerProfile = null;
         var _loc14_:String = null;
         var _loc15_:BMMechStructure = null;
         var _loc16_:String = null;
         var _loc17_:Number = NaN;
         _loc2_ = this.replaysDB[param1];
         this.battleMechsPerPlayer = _loc2_.battleMechsPerPlayer;
         _loc2_.watched = true;
         this.battleData = new Object();
         this.battleData.map = new Object();
         this.battleData.map.stepsTotal = _loc2_.mapStepsTotal;
         this.battleData.startingPlayer = 1;
         this.battleData.player1 = new Object();
         this.battleData.player2 = new Object();
         this.battleData.player1.currentStep = _loc2_.status1[0].step;
         this.battleData.player2.currentStep = _loc2_.status2[0].step;
         _loc3_ = new Object();
         if(_loc2_.floorBuffs != null)
         {
            if(_loc2_.floorBuffs != "")
            {
               _loc5_ = "";
               _loc6_ = 0;
               _loc9_ = 0;
               while(_loc9_ < _loc2_.floorBuffs.length)
               {
                  _loc10_ = _loc2_.floorBuffs.substr(_loc9_,1);
                  if(_loc10_ == "-")
                  {
                     if(_loc2_.replayInverted)
                     {
                        _loc6_ = _loc2_.mapStepsTotal - 1 - int(_loc5_);
                     }
                     else
                     {
                        _loc6_ = int(_loc5_);
                     }
                     _loc5_ = "";
                  }
                  else if(_loc10_ == "_" || _loc9_ == _loc2_.floorBuffs.length - 1)
                  {
                     if(_loc9_ == _loc2_.floorBuffs.length - 1)
                     {
                        _loc5_ += _loc10_;
                     }
                     switch(_loc5_)
                     {
                        case "D1":
                           _loc3_[_loc6_] = {
                              "step":_loc6_,
                              "type":"damage",
                              "subType":1
                           };
                           break;
                        case "D2":
                           _loc3_[_loc6_] = {
                              "step":_loc6_,
                              "type":"damage",
                              "subType":2
                           };
                           break;
                        case "D3":
                           _loc3_[_loc6_] = {
                              "step":_loc6_,
                              "type":"damage",
                              "subType":3
                           };
                           break;
                        case "DH":
                           _loc3_[_loc6_] = {
                              "step":_loc6_,
                              "type":"damageHeat"
                           };
                           break;
                        case "DE":
                           _loc3_[_loc6_] = {
                              "step":_loc6_,
                              "type":"damageEnergy"
                           };
                           break;
                        case "ER":
                           _loc3_[_loc6_] = {
                              "step":_loc6_,
                              "type":"energyRegeneration"
                           };
                           break;
                        case "HC":
                           _loc3_[_loc6_] = {
                              "step":_loc6_,
                              "type":"heatCooling"
                           };
                           break;
                        case "IR":
                           _loc3_[_loc6_] = {
                              "step":_loc6_,
                              "type":"ignoreResistance"
                           };
                     }
                     _loc5_ = "";
                  }
                  else
                  {
                     _loc5_ += _loc10_;
                  }
                  _loc9_++;
               }
               this.battle_floorBuffsData = _loc3_;
            }
         }
         _loc4_ = this.player1PlayerID;
         while(_loc4_ <= this.player2PlayerID)
         {
            _loc11_ = this.getInterfacePlayerID(_loc4_);
            _loc12_ = 1;
            while(_loc12_ <= this.battleMechsPerPlayer)
            {
               _loc15_ = _loc2_["player" + _loc11_ + "MechStructures"][_loc12_];
               if(_loc12_ == 1)
               {
                  this["playerData" + _loc4_ + "Inventory"] = new Object();
                  this["player" + _loc4_ + "playerItemIDCounter"] = 1;
               }
               _loc16_ = this.getCensoredString(_loc2_["playerName" + _loc11_]);
               _loc17_ = Number(_loc2_["level" + _loc11_]);
               this.createProfile(_loc4_,_loc16_,_loc17_);
               this.createMechStructures_playerItemBased(_loc4_,_loc12_,_loc15_,-1,-1);
               this.createMechLocally(_loc4_,_loc12_);
               _loc12_++;
            }
            this.createPlayerData(_loc4_,"screenReplay");
            _loc13_ = this["player" + _loc4_ + "Profile"];
            _loc13_.updateLevelByItems();
            _loc14_ = _loc2_["flag" + _loc11_];
            if(_loc14_ != "")
            {
               _loc13_.clanID = _loc11_;
               _loc13_.clan_flag = _loc2_["flag" + _loc11_];
            }
            _loc4_++;
         }
         this.battle_replayData = this.replaysDB[param1];
         screensM.addBattleScreens();
         if(this.gameType == BMDataManager.GAME_TYPE_REPLAY)
         {
            switch(this.gameSubType)
            {
               case BMDataManager.GAME_SUB_TYPE_REPLAY_REGULAR:
                  screensM.removeScreen("screenTopBar");
                  break;
               case BMDataManager.GAME_SUB_TYPE_REPLAY_RANKING_LIST_INSPECT:
                  screensM.removeScreen("screenInspectPlayer");
                  break;
               case BMDataManager.GAME_SUB_TYPE_REPLAY_MENU_CHAT_INSPECT:
               case BMDataManager.GAME_SUB_TYPE_REPLAY_SMTV:
                  screensM.removeScreen("screenMenuMultiPlayerInspect");
                  screensM.removeScreen("screenInspectPlayer");
                  break;
               case BMDataManager.GAME_SUB_TYPE_REPLAY_CLAN_INSPECT:
                  screensM.removeScreen("screenInspectPlayer");
            }
         }
         screensM.screenNewMenu.removeCurrentScreen();
         screensM.screenNewMenu.removeMe();
      }
      
      public function getBattleCreditX1Cost() : Number
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:Number = NaN;
         _loc1_ = this["player" + this.player1PlayerID + "Profile"];
         _loc2_ = this.battleCreditX1CostGold;
         if(_loc1_.tokensSpent)
         {
            _loc2_ = this.battleCreditX1CostGold_supporters;
         }
         if(this.useBattleCreditsPriceIncrease)
         {
            _loc2_ += Math.ceil(_loc2_ * this.battleCreditsPriceIncrease * _loc1_.battleCreditsBought / 100);
         }
         return _loc2_;
      }
      
      public function getBattleCreditX6Cost() : Number
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:Number = NaN;
         _loc1_ = this["player" + this.player1PlayerID + "Profile"];
         _loc2_ = this.battleCreditX6CostGold;
         if(_loc1_.tokensSpent)
         {
            _loc2_ = this.battleCreditX6CostGold_supporters;
         }
         if(this.useBattleCreditsPriceIncrease)
         {
            _loc2_ += Math.ceil(_loc2_ * this.battleCreditsPriceIncrease * _loc1_.battleCreditsBought / 100);
         }
         return _loc2_;
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
         _loc3_ = new _loc2_();
         if(this.runAsMobile)
         {
            _loc3_["cacheAsBitmapMatrix"] = new Matrix();
         }
         _loc3_.cacheAsBitmap = true;
         return _loc3_;
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
            this.avatarImages[param2] = new Object();
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
      
      public function emailSupport(param1:String = null) : void
      {
         var _loc2_:String = null;
         var _loc3_:URLRequest = null;
         if(param1 == null)
         {
            param1 = "Having trouble logging in";
         }
         _loc2_ = "Hello SuperMechs team,\n\n\n\n\n\n\n\n\n\n" + "============================\n" + "Technical Info-do not delete\n" + "============================\n" + BMExternalAssetsManager.getInstance().versionsString + "\n\n" + BMPlatformUtils.capabilitiesString + "\n\n" + BMPlatformUtils.infoString + "\n\n" + BMPlatformUtils.networkInfoString + "\n\n" + "Log::\n" + TsLogger.getLog() + "\n\n" + "============================\n" + "Technical Info End-do not delete\n" + "============================\n";
         _loc3_ = new URLRequest("mailto:supermechs@tacticsoft.net" + "?subject=" + param1 + "&body=" + _loc2_);
         navigateToURL(_loc3_,"_blank");
         _loc3_.method = URLRequestMethod.POST;
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
      
      public function getNumberWithComma(param1:Number) : String
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         _loc2_ = false;
         if(param1 < 0)
         {
            _loc2_ = true;
            param1 *= -1;
         }
         _loc3_ = String(param1);
         if(_loc3_.length == 4)
         {
            _loc3_ = _loc3_.substr(0,1) + "," + _loc3_.substr(1,3);
         }
         else if(_loc3_.length == 5)
         {
            _loc3_ = _loc3_.substr(0,2) + "," + _loc3_.substr(2,3);
         }
         else if(_loc3_.length == 6)
         {
            _loc3_ = _loc3_.substr(0,3) + "," + _loc3_.substr(3,3);
         }
         else if(_loc3_.length == 7)
         {
            _loc3_ = _loc3_.substr(0,1) + "," + _loc3_.substr(1,3) + "," + _loc3_.substr(4,3);
         }
         else if(_loc3_.length == 8)
         {
            _loc3_ = _loc3_.substr(0,2) + "," + _loc3_.substr(2,3) + "," + _loc3_.substr(5,3);
         }
         else if(_loc3_.length == 9)
         {
            _loc3_ = _loc3_.substr(0,3) + "," + _loc3_.substr(3,3) + "," + _loc3_.substr(6,3);
         }
         else if(_loc3_.length == 10)
         {
            _loc3_ = _loc3_.substr(0,1) + "," + _loc3_.substr(1,3) + "," + _loc3_.substr(4,3) + "," + _loc3_.substr(7,3);
         }
         if(_loc2_)
         {
            _loc3_ = "-" + _loc3_;
         }
         return _loc3_;
      }
      
      public function replaceStringInText(param1:String, param2:String, param3:String) : String
      {
         var _loc4_:uint = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(param1.substr(_loc4_,param2.length) == param2)
            {
               param1 = param1.substr(0,_loc4_) + param3 + param1.substr(_loc4_ + param2.length,param1.length - _loc4_ - (param2.length - 1));
               _loc4_ = _loc4_ + param2.length - 1;
            }
            _loc4_++;
         }
         return param1;
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
         this.weeklySoloWinners = new Object();
         this.weeklyClanWinners = new Object();
         this.weeklyTopClans = new Object();
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
               this.weeklySoloWinners[param1] = new Object();
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
               this.weeklyClanWinners[param1] = new Object();
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
               this.weeklyTopClans[param1] = new Object();
               this.weeklyTopClans[param1].places = new Array();
               this.weeklyTopClans[param1].places[1] = 0;
               this.weeklyTopClans[param1].places[2] = 0;
               this.weeklyTopClans[param1].places[3] = 0;
            }
            ++this.weeklyTopClans[param1].places[param2];
         }
      }
      
      public function showGetTokensScreen() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:BMPlayerProfile = null;
         _loc1_ = false;
         if(this.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            _loc2_ = this["player" + this.player1PlayerID + "Profile"];
            if(_loc2_.tokens < 250)
            {
               if(this.runAsMobile == false && this.usePersonaly)
               {
                  _loc1_ = true;
               }
            }
         }
         return _loc1_;
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
            }
         }
      }
      
      public function saveGuestData(param1:String) : void
      {
         var _loc2_:BMPlayerData = null;
         var _loc3_:uint = 0;
         var _loc4_:BMPlayerProfile = null;
         var _loc5_:BMPlayerItemData = null;
         var _loc6_:Date = null;
         if(this.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
            this.resetGuestSharedObject("saveGuestData");
            _loc2_ = this.playersData[this.OFFLINE_PLAYER_ID];
            this.guestSharedObject.data.items = new Array();
            _loc3_ = 0;
            while(_loc3_ < _loc2_.items.length)
            {
               _loc5_ = _loc2_.items[_loc3_];
               this.guestSharedObject.data.items.push(_loc5_);
               _loc3_++;
            }
            _loc4_ = this["player" + this.OFFLINE_PLAYER_ID + "Profile"];
            this.guestSharedObject.data.profile = new Object();
            this.guestSharedObject.data.profile.gold = _loc4_.gold;
            this.guestSharedObject.data.profile.tokens = _loc4_.tokens;
            this.guestSharedObject.data.profile.totalGoldGained = _loc4_.totalGoldGained;
            this.guestSharedObject.data.profile.XP = _loc4_.XP;
            this.guestSharedObject.data.profile.totalXPGained = _loc4_.totalXPGained;
            this.guestSharedObject.data.profile.level = _loc4_.level;
            this.guestSharedObject.data.profile.battlesVSComputer = _loc4_.battlesVSComputer;
            this.guestSharedObject.data.profile.winsVSComputer = _loc4_.winsVSComputer;
            this.guestSharedObject.data.profile.campaignWins = _loc4_.campaignWins;
            this.guestSharedObject.data.profile.campaignLosesStreak = _loc4_.campaignLosesStreak;
            this.guestSharedObject.data.profile.tutorialLevel = _loc4_.tutorialLevel;
            this.guestSharedObject.data.profile.premiumAccountTime = this.premiumAccountTime;
            this.guestSharedObject.data.profile.freePackages = _loc4_.getFreePackagesString();
            this.guestSharedObject.data.profile.playerName = _loc4_.playerName;
            this.guestSharedObject.data.profile.mission_layout = _loc4_.mission_layout;
            this.guestSharedObject.data.profile.mission_hp = _loc4_.mission_hp;
            this.guestSharedObject.data.profile.mission_energy = _loc4_.mission_energy;
            this.guestSharedObject.data.profile.mission_energyRegeneration = _loc4_.mission_energyRegeneration;
            this.guestSharedObject.data.profile.mission_heat = _loc4_.mission_heat;
            this.guestSharedObject.data.profile.mission_heatCooling = _loc4_.mission_heatCooling;
            this.guestSharedObject.data.profile.mission_bullets = _loc4_.mission_bullets;
            this.guestSharedObject.data.profile.mission_rockets = _loc4_.mission_rockets;
            this.guestSharedObject.data.profile.mission_startingPosition = _loc4_.mission_startingPosition;
            this.guestSharedObject.data.profile.mission_playerPosition = _loc4_.mission_playerPosition;
            this.guestSharedObject.data.profile.mission_themeID = _loc4_.mission_themeID;
            this.guestSharedObject.data.profile.mission_flag = _loc4_.mission_flag;
            this.guestSharedObject.data.profile.mission_rows = _loc4_.mission_rows;
            this.guestSharedObject.data.profile.mission_columns = _loc4_.mission_columns;
            this.guestSharedObject.data.profile.mission_gold = _loc4_.mission_gold;
            this.guestSharedObject.data.profile.mission_difficulty = _loc4_.mission_difficulty;
            this.guestSharedObject.data.profile.mission_colorID = _loc4_.mission_colorID;
            this.guestSharedObject.data.profile.mission_progress = new Array();
            _loc3_ = 0;
            while(_loc3_ < _loc4_.mission_progress.length)
            {
               this.guestSharedObject.data.profile.mission_progress.push(_loc4_.mission_progress[_loc3_]);
               _loc3_++;
            }
            this.guestSharedObject.data.profile.mission_upgrades = new Array();
            _loc3_ = 0;
            while(_loc3_ < _loc4_.mission_upgrades.length)
            {
               this.guestSharedObject.data.profile.mission_upgrades.push(_loc4_.mission_upgrades[_loc3_]);
               _loc3_++;
            }
            this.guestSharedObject.data.profile.mission_loot = new Array();
            _loc3_ = 0;
            while(_loc3_ < _loc4_.mission_loot.length)
            {
               this.guestSharedObject.data.profile.mission_loot.push(_loc4_.mission_loot[_loc3_]);
               _loc3_++;
            }
            this.guestSharedObject.data.profile.mapProgress = new Array();
            _loc3_ = 0;
            while(_loc3_ < _loc4_.mapProgress.length)
            {
               this.guestSharedObject.data.profile.mapProgress.push(_loc4_.mapProgress[_loc3_]);
               _loc3_++;
            }
            this.guestSharedObject.data.profile.missionID = _loc4_.missionID;
            this.guestSharedObject.data.profile.currentMissionSlot = _loc4_.currentMissionSlot;
            if(this.lastBattleCreditAddon == 0)
            {
               _loc6_ = new Date();
               this.lastBattleCreditAddon = Math.ceil(_loc6_.getTime() / 1000);
            }
            this.guestSharedObject.data.profile.battleCredits = _loc4_.battleCredits;
            this.guestSharedObject.data.profile.lastBattleCreditAddon = this.lastBattleCreditAddon;
            this.guestSharedObject.data.profile.itemBoxesBought = _loc4_.itemBoxesBought_guest;
            this.guestSharedObject.flush();
            this.guestSharedObjectExists = true;
         }
      }
      
      public function resetGuestSharedObject(param1:String) : void
      {
         this.guestSharedObject.clear();
         this.guestSharedObject.flush();
         this.guestSharedObjectExists = false;
      }
      
      private function loadSharedObjectGuestData() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMPlayerProfile = null;
         var _loc3_:Object = null;
         var _loc4_:Date = null;
         var _loc5_:Object = null;
         var _loc6_:Number = NaN;
         if(this.guestSharedObjectExists)
         {
            this["playerData" + this.OFFLINE_PLAYER_ID + "Inventory"] = new Object();
            this["player" + this.OFFLINE_PLAYER_ID + "playerItemIDCounter"] = 1;
            _loc1_ = 0;
            while(_loc1_ < this.guestSharedObject.data.items.length)
            {
               _loc5_ = this.guestSharedObject.data.items[_loc1_];
               _loc6_ = 0;
               if(_loc5_.power != null)
               {
                  _loc6_ = Number(_loc5_.power);
               }
               this.addInventoryItem(this.OFFLINE_PLAYER_ID,this["playerData" + this.OFFLINE_PLAYER_ID + "Inventory"],_loc5_.itemID,_loc5_.equipped,_loc5_.equipmentType,_loc5_.equipmentID,_loc5_.colorID,_loc6_);
               _loc1_++;
            }
            _loc2_ = this["player" + this.OFFLINE_PLAYER_ID + "Profile"];
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
               if(this.isTutorialActive() == false)
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
            _loc2_.mission_layout = _loc3_.mission_layout;
            _loc2_.mission_hp = _loc3_.mission_hp;
            _loc2_.mission_energy = _loc3_.mission_energy;
            _loc2_.mission_energyRegeneration = _loc3_.mission_energyRegeneration;
            _loc2_.mission_heat = _loc3_.mission_heat;
            _loc2_.mission_heatCooling = _loc3_.mission_heatCooling;
            _loc2_.mission_bullets = _loc3_.mission_bullets;
            _loc2_.mission_rockets = _loc3_.mission_rockets;
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
            _loc2_.missionID = _loc3_.missionID;
            _loc2_.currentMissionSlot = _loc3_.currentMissionSlot;
            _loc2_.battleCredits = _loc3_.battleCredits;
            this.lastBattleCreditAddon = _loc3_.lastBattleCreditAddon;
            if(_loc3_.itemBoxesBought != null)
            {
               _loc2_.itemBoxesBought_guest = _loc3_.itemBoxesBought;
            }
            _loc4_ = new Date();
            this.currentTime = Math.ceil(_loc4_.getTime() / 1000);
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
               TsLogger.log(">>> GENERAL SHARED OBJECT HAS DATA");
               this.perUserSharedObjectExists = true;
            }
            TsLogger.log(">>>>>>>>>>>>>>>>>>>>>> perUserSharedObject.data.lastLanguageID:" + this.perUserSharedObject.data.lastLanguageID);
            if(this.perUserSharedObject.data.lastLanguageID != null)
            {
               this.languageID = this.perUserSharedObject.data.lastLanguageID;
            }
            else if(this.useLanguages)
            {
               _loc1_ = Capabilities.language;
               TsLogger.log("GGGGGGG----------------GGGGGG:" + _loc1_);
               switch(_loc1_)
               {
                  case "en":
                     this.languageID = 1;
                     break;
                  case "de":
                     this.languageID = 5;
                     break;
                  case "ru":
                     this.languageID = 3;
                     break;
                  case "it":
                     this.languageID = 6;
                     break;
                  case "pt":
                     this.languageID = 7;
                     break;
                  case "es":
                     this.languageID = 8;
                     break;
                  case "pl":
                     this.languageID = 9;
                     break;
                  case "hu":
                     this.languageID = 10;
                     break;
                  case "cs":
                  case "da":
                  case "nl":
                  case "fi":
                  case "ja":
                  case "ko":
                  case "nb":
                  case "xu":
                  case "zh-CN":
                  case "zh-TW":
                  case "sv":
                  case "tr":
               }
            }
            this.createTipsDB();
            this.createInfoTextDB();
            this.createBattleInterfaceToolTipDB();
            this.clientLastLanguageID = this.languageID;
         }
         if(this.perUserSharedObjectExists == false)
         {
            this.perUserSharedObject.data.lastUsername = "";
            this.perUserSharedObject.data.lastPassword = "";
            this.perUserSharedObject.data.lastLanguageID = this.languageID;
            this.perUserSharedObject.data.users = new Object();
            this.perUserSharedObject.flush();
         }
      }
      
      public function saveUsernameData() : void
      {
         if(this.perUserSharedObject != null)
         {
            this.perUserSharedObject.data.lastUsername = this.userName;
            this.perUserSharedObject.flush();
         }
      }
      
      public function savePasswordData(param1:String) : void
      {
         if(this.perUserSharedObject != null)
         {
            this.perUserSharedObject.data.lastPassword = param1;
            this.perUserSharedObject.flush();
         }
      }
      
      public function saveLanguageData() : void
      {
         this.perUserSharedObject.data.lastLanguageID = this.languageID;
         this.perUserSharedObject.flush();
      }
      
      public function savePerUserSharedObjectData() : void
      {
         var _loc1_:BMReplayData = null;
         var _loc2_:BMPlayerProfile = null;
         this.perUserSharedObject.data.lastLanguageID = this.languageID;
         if(this.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            if(screensM.isScreenOpened("screenWelcomeLogin"))
            {
               if(false == false)
               {
                  this.perUserSharedObject.data.lastPassword = "";
                  if(this.runAsMobile || screensM.screenWelcomeLogin.mcRememberPasswordV.visible)
                  {
                     this.perUserSharedObject.data.lastPassword = screensM.screenWelcomeLogin.txtInputPassword.text;
                  }
                  this.perUserSharedObject.data.lastLoginUsername = screensM.screenWelcomeLogin.txtInputUsername.text;
               }
            }
            else
            {
               if(this.perUserSharedObject.data.users == null)
               {
                  this.perUserSharedObject.data.users = new Object();
               }
               if(this.perUserSharedObject.data.users[this.userID] == null)
               {
                  this.perUserSharedObject.data.users[this.userID] = new Object();
               }
               if(this.perUserSharedObject.data.users[this.userID].replaysWatched == null)
               {
                  this.perUserSharedObject.data.users[this.userID].replaysWatched = new Object();
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
                  this.perUserSharedObject.data.users[this.userID].winningLosingStreaks = new Object();
               }
               _loc2_ = this["player" + this.ONLINE_PLAYER_ID + "Profile"];
               this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.winningStreakVSComputer = _loc2_.winningStreakVSComputer;
               this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.winningStreakVSComputerThisLevel = _loc2_.winningStreakVSComputerThisLevel;
               this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.losingStreakVSComputer = _loc2_.losingStreakVSComputer;
               this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.computerLevelAddon = _loc2_.computerLevelAddon;
               this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.campaignLosesStreak = _loc2_.campaignLosesStreak;
               if(this.perUserSharedObject.data.users[this.userID].general == null)
               {
                  this.perUserSharedObject.data.users[this.userID].general = new Object();
               }
               this.perUserSharedObject.data.users[this.userID].general.mechBuilds = new Array();
               this.perUserSharedObject.data.users[this.userID].general.expandedInventory = _loc2_.expandedInventorySortingMessageDisplayed;
            }
         }
         this.perUserSharedObject.flush();
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
         this.perUserSharedObject.flush();
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
            if(this.gameType == BMDataManager.GAME_TYPE_ONLINE)
            {
               if(this.perUserSharedObject.data.users != null)
               {
                  if(this.perUserSharedObject.data.users[this.userID] != null)
                  {
                     if(this.perUserSharedObject.data.users[this.userID].winningLosingStreaks != null)
                     {
                        _loc1_ = this["player" + this.ONLINE_PLAYER_ID + "Profile"];
                        _loc1_.winningStreakVSComputer = this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.winningStreakVSComputer;
                        _loc1_.winningStreakVSComputerThisLevel = this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.winningStreakVSComputerThisLevel;
                        _loc1_.losingStreakVSComputer = this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.losingStreakVSComputer;
                        _loc1_.computerLevelAddon = this.perUserSharedObject.data.users[this.userID].winningLosingStreaks.computerLevelAddon;
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
      
      public function setItemsCategoriesData(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:Object = null;
         var _loc4_:BMItemData = null;
         var _loc5_:Number = NaN;
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
         _loc2_ = 1;
         while(_loc2_ <= 36)
         {
            this.modules_energy[_loc2_] = new Array();
            this.modules_heat[_loc2_] = new Array();
            this.modules_bullets[_loc2_] = new Array();
            this.modules_rockets[_loc2_] = new Array();
            this.modules_bulletsAndRockets[_loc2_] = new Array();
            this.modules_resistance[_loc2_] = new Array();
            this.modules_armor[_loc2_] = new Array();
            this.kits_energy[_loc2_] = new Array();
            this.kits_heat[_loc2_] = new Array();
            this.kits_bullets[_loc2_] = new Array();
            this.kits_rockets[_loc2_] = new Array();
            this.kits_resistance[_loc2_] = new Array();
            this.kits_repair[_loc2_] = new Array();
            _loc2_++;
         }
         _loc3_ = this.itemsDB_local;
         if(param1)
         {
            _loc3_ = this.itemsDB_online;
         }
         for each(_loc4_ in _loc3_)
         {
            if(_loc4_.specialStatus > 3)
            {
               continue;
            }
            _loc5_ = _loc4_.itemID;
            switch(_loc4_.type)
            {
               case "module":
                  if(_loc4_.energyBase > 0 || _loc4_.energyAddon > 0)
                  {
                     this.modules_energy[_loc4_.level].push(_loc5_);
                  }
                  if(_loc4_.heatBase > 0 || _loc4_.heatAddon > 0)
                  {
                     this.modules_heat[_loc4_.level].push(_loc5_);
                  }
                  if(_loc4_.bullets > 0 && _loc4_.rockets > 0)
                  {
                     this.modules_bulletsAndRockets[_loc4_.level].push(_loc5_);
                  }
                  else
                  {
                     if(_loc4_.bullets > 0)
                     {
                        this.modules_bullets[_loc4_.level].push(_loc5_);
                     }
                     if(_loc4_.rockets > 0)
                     {
                        this.modules_rockets[_loc4_.level].push(_loc5_);
                     }
                  }
                  if(_loc4_.resist1 > 0 || _loc4_.resist2 > 0 || _loc4_.resist3 > 0)
                  {
                     this.modules_resistance[_loc4_.level].push(_loc5_);
                  }
                  if(_loc4_.HPBase > 0)
                  {
                     this.modules_armor[_loc4_.level].push(_loc5_);
                  }
                  break;
               case "kit":
                  if(_loc4_.energyBase > 0)
                  {
                     this.kits_energy[_loc4_.level].push(_loc5_);
                  }
                  if(_loc4_.heatBase > 0)
                  {
                     this.kits_heat[_loc4_.level].push(_loc5_);
                  }
                  if(_loc4_.bullets > 0)
                  {
                     this.kits_bullets[_loc4_.level].push(_loc5_);
                  }
                  if(_loc4_.rockets > 0)
                  {
                     this.kits_rockets[_loc4_.level].push(_loc5_);
                  }
                  if(_loc4_.resist1 > 0 || _loc4_.resist2 > 0 || _loc4_.resist3 > 0)
                  {
                     this.kits_resistance[_loc4_.level].push(_loc5_);
                  }
                  if(_loc4_.HPBase > 0)
                  {
                     this.kits_repair[_loc4_.level].push(_loc5_);
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
      
      public function loadNextAdvertisement() : void
      {
         var _loc1_:BMPlayerProfile = null;
         if(!BMAdsManager.gi().isInterstitialAvailable())
         {
            return;
         }
         _loc1_ = this["player" + this.player1PlayerID + "Profile"];
         if(_loc1_.tokens_supporter == 0 && _loc1_.tokensSpent == 0)
         {
            BMAdsManager.gi().loadInterstitial();
         }
      }
      
      public function showAdvertisement() : void
      {
         var _loc1_:BMPlayerProfile = null;
         if(!BMAdsManager.gi().isInterstitialAvailable())
         {
            return;
         }
         _loc1_ = this["player" + this.player1PlayerID + "Profile"];
         if(_loc1_.tokens_supporter == 0 && _loc1_.tokensSpent == 0)
         {
            if(_loc1_.level > 5)
            {
               if(this.supersonic_mobile_afterWins == 0 || this.supersonic_mobile_afterWins == 1 && _loc1_.lastBattleResult == "youWon")
               {
                  BMAdsManager.gi().addEventListener(BMAdsManagerEvents.ON_INTERSTITIAL_COMLETE,this.onShowInterstitialComplete);
                  BMAdsManager.gi().showInterstitial();
               }
            }
         }
      }
      
      private function onShowInterstitialComplete(param1:Event) : void
      {
         BMAdsManager.gi().removeEventListener(BMAdsManagerEvents.ON_INTERSTITIAL_COMLETE,this.onShowInterstitialComplete);
      }
      
      public function isRewardedVideoAvailable(param1:String) : Boolean
      {
         return BMAdsManager.gi().isRewardedVideoAvailable(param1);
      }
      
      public function showRewardedVideo(param1:String) : void
      {
         BMAdsManager.gi().addEventListener(BMAdsManagerEvents.ON_REWARDED_VIDEO_AD_REWARDED,this.onUserRewardedForWatchingVideo);
         BMAdsManager.gi().addEventListener(BMAdsManagerEvents.ON_REWARDED_VIDEO_SHOW_FAIL,this.onCannotShowRewardedVideo);
         BMAdsManager.gi().showRewardedVideo(param1);
      }
      
      private function onUserRewardedForWatchingVideo(param1:Event) : void
      {
         var _loc2_:BMPlayerProfile = null;
         BMAdsManager.gi().removeEventListener(BMAdsManagerEvents.ON_REWARDED_VIDEO_AD_REWARDED,this.onUserRewardedForWatchingVideo);
         BMAdsManager.gi().removeEventListener(BMAdsManagerEvents.ON_REWARDED_VIDEO_SHOW_FAIL,this.onCannotShowRewardedVideo);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         if(this.gameType == BMDataManager.GAME_TYPE_GUEST)
         {
            _loc2_ = this["player" + this.player1PlayerID + "Profile"];
            _loc2_.gold += this.supersonic_rewardedVideosMobile_gold;
            this.saveGuestData("onUserRewardedForWatchingVideo");
            screensM.screenConfirmation.displayQuestionOrNotification("rewardVideosGotGold",this.supersonic_rewardedVideosMobile_gold);
         }
         else
         {
            remoteM.socketM.rewardVideoWatched(this.rewardedVideo_tokensReward);
         }
      }
      
      private function onCannotShowRewardedVideo(param1:Event) : void
      {
         BMAdsManager.gi().removeEventListener(BMAdsManagerEvents.ON_REWARDED_VIDEO_AD_REWARDED,this.onUserRewardedForWatchingVideo);
         BMAdsManager.gi().removeEventListener(BMAdsManagerEvents.ON_REWARDED_VIDEO_SHOW_FAIL,this.onCannotShowRewardedVideo);
         screensM.screenConfirmation.displayQuestionOrNotification("rewardVideosComeBackLater");
      }
      
      public function chat_initialize() : void
      {
         if(this.chat_initialized == false)
         {
            this.chat_playersData = new Object();
            this.chat_channels = new Array();
            this.chat_channelsServer = new Array();
            this.chat_channelsAdmins = new Array();
            this.chat_channelsClan = new Array();
            this.chat_channelsClanMembers = new Array();
            this.chat_channelsRegular = new Array();
            this.chat_pendingClanMessages = 0;
            this.chat_addChannel(0,getSpecificText("multiplayerChat_channel1"));
            this.chat_addChannel(3,getSpecificText("multiplayerChat_channel1TopRanks"));
            this.chat_addChannel(1,getSpecificText("multiplayerChat_channel2"));
            this.chat_addChannel(4,getSpecificText("multiplayerChat_channel2TopRanks"));
            this.chat_addChannel(2,getSpecificText("multiplayerChat_channel3"));
            this.chat_addChannel(5,getSpecificText("multiplayerChat_channel3TopRanks"));
            this.chat_addChannel(this.CHAT_CLAN_CHANNEL_PLAYER_ID,getSpecificText("multiplayerChat_channelClan"));
            this.chat_addMessage_welcome(0,getSpecificText("multiplayerChat_server"),getSpecificText("multiplayerChat_welcome1"));
            this.chat_addMessage_welcome(1,getSpecificText("multiplayerChat_server"),getSpecificText("multiplayerChat_welcome2"));
            this.chat_addMessage_welcome(2,getSpecificText("multiplayerChat_server"),getSpecificText("multiplayerChat_welcome3"));
            this.chat_addMessage_welcome(3,getSpecificText("multiplayerChat_server"),getSpecificText("multiplayerChat_welcome1"));
            this.chat_addMessage_welcome(4,getSpecificText("multiplayerChat_server"),getSpecificText("multiplayerChat_welcome2"));
            this.chat_addMessage_welcome(5,getSpecificText("multiplayerChat_server"),getSpecificText("multiplayerChat_welcome3"));
            this.chat_addMessage_welcome(this.CHAT_CLAN_CHANNEL_PLAYER_ID,getSpecificText("multiplayerChat_server"),getSpecificText("multiplayerChat_welcomeClan"));
            this.chat_totalPlayersInLobby = 0;
            this.chat_winningWallTexts = new Array();
            this.chat_playersData = new Object();
            this.chat_differentUserConnected = true;
            this.chat_goToChatAfterBattleUserID = 0;
            this.chat_inviteToClanAfterBattleUserID = 0;
            this.chat_log = new Object();
            this.chat_initialized = true;
         }
      }
      
      public function chat_channelsLanguageUpdate() : void
      {
         this.chat_channels[this.getChannelSlot(0)].name = getSpecificText("multiplayerChat_channel1");
         this.chat_channels[this.getChannelSlot(3)].name = getSpecificText("multiplayerChat_channel1TopRanks");
         this.chat_channels[this.getChannelSlot(1)].name = getSpecificText("multiplayerChat_channel2");
         this.chat_channels[this.getChannelSlot(4)].name = getSpecificText("multiplayerChat_channel2TopRanks");
         this.chat_channels[this.getChannelSlot(2)].name = getSpecificText("multiplayerChat_channel3");
         this.chat_channels[this.getChannelSlot(5)].name = getSpecificText("multiplayerChat_channel3TopRanks");
         this.chat_channels[this.getChannelSlot(this.CHAT_CLAN_CHANNEL_PLAYER_ID)].name = getSpecificText("multiplayerChat_channel3TopRanks");
         this.chat_playersData[0].playerName = getSpecificText("multiplayerChat_channel1");
         this.chat_playersData[3].playerName = getSpecificText("multiplayerChat_channel1TopRanks");
         this.chat_playersData[1].playerName = getSpecificText("multiplayerChat_channel2");
         this.chat_playersData[4].playerName = getSpecificText("multiplayerChat_channel2TopRanks");
         this.chat_playersData[2].playerName = getSpecificText("multiplayerChat_channel3");
         this.chat_playersData[5].playerName = getSpecificText("multiplayerChat_channel3TopRanks");
         this.chat_playersData[this.CHAT_CLAN_CHANNEL_PLAYER_ID].playerName = getSpecificText("multiplayerChat_channel3TopRanks");
      }
      
      public function chat_addChannel(param1:Number, param2:String) : void
      {
         var _loc3_:uint = 0;
         if(this.getChannelSlot(param1) == -1)
         {
            if(this.getChannelSlot(param1) == -1)
            {
               if(param1 <= this.CHAT_LANGUAGES - 1)
               {
                  this.chat_channelsServer.push({
                     "channelID":param1,
                     "name":param2
                  });
               }
               else if(param1 == this.CHAT_CLAN_CHANNEL_PLAYER_ID)
               {
                  this.chat_channelsClan.push({
                     "channelID":param1,
                     "name":param2
                  });
               }
               else if(this.isPlayerIDAdmin(param1))
               {
                  this.chat_channelsAdmins.push({
                     "channelID":param1,
                     "name":param2
                  });
               }
               else if(this.isMyClanMember(param1))
               {
                  this.chat_channelsClanMembers.push({
                     "channelID":param1,
                     "name":param2
                  });
               }
               else
               {
                  this.chat_channelsRegular.push({
                     "channelID":param1,
                     "name":param2
                  });
               }
            }
            this.chat_channels = new Array();
            _loc3_ = 0;
            while(_loc3_ < this.chat_channelsClan.length)
            {
               this.chat_channels.push({
                  "channelID":this.chat_channelsClan[_loc3_].channelID,
                  "name":this.chat_channelsClan[_loc3_].name,
                  "type":"clan"
               });
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this.chat_channelsServer.length)
            {
               this.chat_channels.push({
                  "channelID":this.chat_channelsServer[_loc3_].channelID,
                  "name":this.chat_channelsServer[_loc3_].name,
                  "type":"server"
               });
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this.chat_channelsAdmins.length)
            {
               this.chat_channels.push({
                  "channelID":this.chat_channelsAdmins[_loc3_].channelID,
                  "name":this.chat_channelsAdmins[_loc3_].name,
                  "type":"admin"
               });
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this.chat_channelsClanMembers.length)
            {
               this.chat_channels.push({
                  "channelID":this.chat_channelsClanMembers[_loc3_].channelID,
                  "name":this.chat_channelsClanMembers[_loc3_].name,
                  "type":"friend"
               });
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < this.chat_channelsRegular.length)
            {
               this.chat_channels.push({
                  "channelID":this.chat_channelsRegular[_loc3_].channelID,
                  "name":this.chat_channelsRegular[_loc3_].name,
                  "type":"regular"
               });
               _loc3_++;
            }
            if(screensM.isScreenOpened("screenMultiPlayerChat"))
            {
               screensM.screenMultiPlayerChat.addAndRefreshChannelsTileList();
            }
         }
      }
      
      public function getChannelSlot(param1:Number) : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:uint = 0;
         _loc2_ = -1;
         _loc3_ = 0;
         while(_loc3_ < this.chat_channels.length)
         {
            if(this.chat_channels[_loc3_].channelID == param1)
            {
               _loc2_ = _loc3_;
               _loc3_ = this.chat_channels.length;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function chat_addMessage_welcome(param1:uint, param2:String, param3:String) : void
      {
         this.chat_addMessage("message",param1,param1,param3,param2,0,0,"",0,0,"",null,0,0,true);
      }
      
      private function chat_addMessage_battleInvitation(param1:String, param2:uint, param3:String, param4:Number, param5:uint) : void
      {
         this.chat_addMessage("battleInvitation",0,this.userID,param3,param1,param2,0,"",0,0,"",null,param4,param5,true);
      }
      
      private function chat_addMessage_clanInvitation(param1:Number, param2:String, param3:Number, param4:String, param5:String) : void
      {
         this.chat_addMessage("clanInvitation",0,this.userID,param5,param4,0,0,"",0,param1,param2,null,param3,0,true);
      }
      
      public function chat_addMessage(param1:String, param2:Number, param3:Number, param4:String, param5:String = "", param6:uint = 0, param7:uint = 0, param8:String = "", param9:uint = 0, param10:Number = 0, param11:String = "", param12:Object = null, param13:Number = 0, param14:uint = 0, param15:Boolean = false) : void
      {
         var _loc16_:Number = NaN;
         var _loc17_:BMChatMessageData = null;
         var _loc18_:uint = 0;
         var _loc19_:String = null;
         var _loc20_:BMPlayerProfile = null;
         var _loc21_:Boolean = false;
         var _loc22_:Boolean = false;
         var _loc23_:uint = 0;
         var _loc24_:Boolean = false;
         var _loc25_:uint = 0;
         var _loc26_:BMChatMessageData = null;
         var _loc27_:String = null;
         var _loc28_:String = null;
         var _loc29_:String = null;
         _loc16_ = param2;
         switch(param1)
         {
            case "privateMessageAlert":
            case "clanMessageAlert":
            case "battleInvitation":
            case "clanInvitation":
               _loc16_ = param13;
         }
         if(_loc16_ != this.userID)
         {
            param5 = this.getCensoredString(param5);
            param4 = this.getCensoredString(param4);
         }
         _loc17_ = new BMChatMessageData();
         switch(param1)
         {
            case "winningWall":
               _loc18_ = this.chat_messages_winningWall.length;
               _loc19_ = getSpecificText("multiplayerChat_winningWallMessage");
               param12.winUsername = this.getCensoredString(param12.winUsername);
               param12.loseUsername = this.getCensoredString(param12.loseUsername);
               _loc19_ = this.replaceStringInText(_loc19_,"%PLAYER1%","<FONT COLOR=\'#" + this.COLOR_REGULAR_PLAYER + "\'>" + param12.winUsername + "</FONT>");
               _loc19_ = this.replaceStringInText(_loc19_,"%PLAYER2%","<FONT COLOR=\'#" + this.COLOR_REGULAR_PLAYER + "\'>" + param12.loseUsername + "</FONT>");
               _loc17_.initializeWinningWall(_loc18_,_loc19_);
               this.chat_messages_winningWall.push(_loc17_);
               if(screensM.isScreenOpened("screenMultiPlayerLadder"))
               {
                  screensM.screenMultiPlayerLadder.addWinningWallMessage(_loc19_);
               }
               break;
            case "battleInvitation":
            case "clanInvitation":
            case "privateMessageAlert":
            case "clanMessageAlert":
            case "message":
               _loc20_ = this["player" + this.player1PlayerID + "Profile"];
               _loc21_ = false;
               _loc22_ = false;
               if(this.chat_playersData[_loc16_] == null)
               {
                  this.chat_addPlayerToChatPlayersData(_loc16_,param5,param6,param10,param7,param8,"");
                  _loc21_ = true;
               }
               else if(this.chat_playersData[_loc16_].blocked)
               {
                  _loc22_ = true;
               }
               if(_loc22_ == false)
               {
                  switch(param1)
                  {
                     case "battleInvitation":
                     case "clanInvitation":
                        _loc23_ = 0;
                        if(screensM.isScreenOpened("screenMultiPlayerChat"))
                        {
                           _loc23_ = screensM.screenMultiPlayerChat.getChannelPlayerID();
                        }
                        this.chat_playersData[_loc16_].removed = false;
                        if(this.chat_log[_loc23_] == null)
                        {
                           this.chat_log[_loc23_] = new Array();
                        }
                        _loc18_ = uint(this.chat_log[_loc23_].length);
                        switch(param1)
                        {
                           case "battleInvitation":
                              _loc17_.initializeBattleInvitation(_loc18_,_loc23_,0,this.userID,param13,param4,param5,param6,param14);
                              break;
                           case "clanInvitation":
                              _loc17_.initializeClanInvitation(_loc18_,_loc23_,0,this.userID,param13,param4,param5,param10,param11);
                        }
                        break;
                     case "privateMessageAlert":
                     case "clanMessageAlert":
                     case "message":
                        if(this.chat_playersData[_loc16_].clanID != param10)
                        {
                           this.chat_playersData[_loc16_].clanID = param10;
                        }
                        this.chat_playersData[_loc16_].removed = false;
                        if(param1 == "message")
                        {
                           _loc23_ = param3;
                           if(param3 == this.userID)
                           {
                              _loc23_ = _loc16_;
                              this.chat_addChannel(_loc23_,param5);
                              if(screensM.isScreenOpened("screenMultiPlayerChat"))
                              {
                                 screensM.screenMultiPlayerChat.addAndRefreshChannelsTileList();
                              }
                           }
                        }
                        else
                        {
                           _loc23_ = 0;
                           if(screensM.isScreenOpened("screenMultiPlayerChat"))
                           {
                              _loc23_ = screensM.screenMultiPlayerChat.getChannelPlayerID();
                           }
                        }
                        if(this.chat_log[_loc23_] == null)
                        {
                           this.chat_log[_loc23_] = new Array();
                        }
                        _loc18_ = uint(this.chat_log[_loc23_].length);
                        switch(param1)
                        {
                           case "privateMessageAlert":
                              _loc17_.initializePrivateMessageAlert(_loc18_,_loc23_,_loc16_,param3,param4,param5,param13);
                              break;
                           case "clanMessageAlert":
                              _loc17_.initializeClanMessageAlert(_loc18_,_loc23_,_loc16_,param3,param4,param5,param13);
                              break;
                           case "message":
                              _loc17_.initializeMessage(_loc18_,_loc23_,_loc16_,param3,param4,param5,param6,param7,param9,param10,param11);
                        }
                  }
                  this.chat_log[_loc23_].push(_loc17_);
                  _loc24_ = false;
                  if(this.chat_log[_loc23_].length > 35)
                  {
                     this.chat_log[_loc23_].splice(0,10);
                     _loc25_ = 0;
                     while(_loc25_ < this.chat_log[_loc23_].length)
                     {
                        _loc26_ = this.chat_log[_loc23_][_loc25_];
                        _loc26_.slot = _loc25_;
                        _loc25_++;
                     }
                     _loc18_ -= 10;
                     _loc24_ = true;
                  }
                  if(screensM.isScreenOpened("screenMultiPlayerChat"))
                  {
                     switch(_loc17_.type)
                     {
                        case "battleInvitation":
                        case "clanInvitation":
                           soundM.createSound("battleInvitationReceived",1);
                     }
                     if(_loc23_ == screensM.screenMultiPlayerChat.getChannelPlayerID())
                     {
                        if(_loc24_)
                        {
                           screensM.screenMultiPlayerChat.refreshChatHistory();
                        }
                        else
                        {
                           screensM.screenMultiPlayerChat.addGlobalChatMessage(_loc23_,_loc18_,true);
                        }
                     }
                     else if(param15)
                     {
                        switch(_loc17_.type)
                        {
                           case "battleInvitation":
                           case "clanInvitation":
                           case "message":
                              screensM.screenMultiPlayerChat.incraseChannelPendingMessages(_loc23_);
                              if(_loc23_ == this.CHAT_CLAN_CHANNEL_PLAYER_ID)
                              {
                                 ++this.chat_pendingClanMessages;
                              }
                              if(param3 == this.userID || param3 == this.CHAT_CLAN_CHANNEL_PLAYER_ID)
                              {
                                 if(param3 == this.CHAT_CLAN_CHANNEL_PLAYER_ID)
                                 {
                                    _loc27_ = getSpecificText("multiplayerChat_clanMessageReceived");
                                    _loc27_ = this.replaceStringInText(_loc27_,"%NAME%",param5);
                                    _loc28_ = "clanMessageAlert";
                                 }
                                 else
                                 {
                                    _loc27_ = getSpecificText("multiplayerChat_privateMessageReceived");
                                    _loc27_ = this.replaceStringInText(_loc27_,"%NAME%",param5);
                                    _loc28_ = "privateMessageAlert";
                                 }
                                 this.chat_addMessage(_loc28_,0,this.userID,_loc27_,getSpecificText("multiplayerChat_server"),0,0,"",0,0,"",null,param2,0,true);
                              }
                        }
                     }
                  }
                  else if(_loc23_ == this.CHAT_CLAN_CHANNEL_PLAYER_ID)
                  {
                     if(screensM.isScreenOpened("screenClan"))
                     {
                        ++this.chat_pendingClanMessages;
                        screensM.screenClan.refreshPendingClanMessagesCounter();
                     }
                  }
               }
         }
         if(screensM.isScreenOpened("screenMultiPlayerLadder") && param15)
         {
            _loc29_ = "";
            switch(param1)
            {
               case "battleInvitation":
                  _loc29_ = "battleInvitation";
                  break;
               case "clanInvitation":
                  _loc29_ = "clanInvitation";
                  break;
               case "message":
                  if(param3 == this.CHAT_CLAN_CHANNEL_PLAYER_ID)
                  {
                     _loc29_ = "message_clan";
                  }
                  else if(param3 == this.userID)
                  {
                     _loc29_ = "message_regular";
                  }
            }
            if(_loc29_ != "")
            {
               screensM.screenMultiPlayerLadder.addChatAlert(_loc29_,_loc16_,param5,param10,param11,param14);
            }
         }
      }
      
      public function chat_addPlayerToChatPlayersData(param1:Number, param2:String, param3:Number, param4:Number, param5:Number, param6:String, param7:String) : void
      {
         var _loc8_:Boolean = false;
         var _loc9_:BMPlayerProfile = null;
         _loc8_ = true;
         if(this.chat_playersData[param1] != null)
         {
            _loc8_ = false;
         }
         if(param1 == this.userID)
         {
            _loc9_ = this["player" + this.player1PlayerID + "Profile"];
            param2 = _loc9_.playerName;
            if(_loc8_ == false)
            {
               this.chat_playersData[param1].playerName = param2;
            }
         }
         if(_loc8_)
         {
            this.chat_playersData[param1] = new Object();
            this.chat_playersData[param1].playerID = param1;
            this.chat_playersData[param1].playerName = param2;
            this.chat_playersData[param1].geo = param6;
            this.chat_playersData[param1].lastDevice = param7;
            this.chat_playersData[param1].blocked = false;
         }
         this.chat_playersData[param1].level = param3;
         this.chat_playersData[param1].clanID = param4;
         this.chat_playersData[param1].ladderProgress = param5;
         this.chat_playersData[param1].removed = false;
      }
      
      public function chat_updatePlayersOnline(param1:Object) : void
      {
         var _loc2_:BMPlayerProfile = null;
         var _loc4_:Object = null;
         var _loc5_:uint = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:Number = NaN;
         _loc2_ = this["player" + this.player1PlayerID + "Profile"];
         var _loc3_:Object = new Object();
         _loc5_ = 0;
         this.chat_totalPlayersInLobby = 0;
         for each(_loc4_ in param1)
         {
            _loc6_ = false;
            if(_loc2_.clanID > 0)
            {
               if(_loc2_.clanID == _loc4_.clanID)
               {
                  _loc6_ = true;
               }
            }
            _loc7_ = false;
            if(_loc6_ == false)
            {
               if(_loc5_ <= 13)
               {
                  if(Math.abs(_loc2_.ladderProgress - _loc4_.ladderProgress) <= this.CHAT_ONLINE_PLAYER_LADDER_PROGRESS_DIFFERENCE)
                  {
                     _loc7_ = true;
                  }
               }
            }
            if(_loc6_ || _loc7_)
            {
               _loc8_ = Number(_loc4_.playerID);
               if(_loc8_ != this.userID)
               {
                  _loc4_.playerName = this.getCensoredString(_loc4_.playerName);
               }
               this.chat_addPlayerToChatPlayersData(_loc8_,_loc4_.playerName,_loc4_.level,_loc4_.clanID,_loc4_.ladderProgress,_loc4_.geo,_loc4_.lastDevice);
            }
            ++this.chat_totalPlayersInLobby;
         }
         if(screensM.isScreenOpened("screenMultiPlayerChat"))
         {
            screensM.screenMultiPlayerChat.addAndRefreshOnlinePlayersTileList(true);
            screensM.screenMultiPlayerChat.refreshPlayersInLobbyText();
         }
         else if(screensM.isScreenOpened("screenMultiPlayerLadder"))
         {
            screensM.screenMultiPlayerLadder.refreshPlayersInLobbyText();
         }
      }
      
      public function chat_updateOnlinePlayerClanID(param1:Number, param2:Number) : void
      {
         if(this.chat_playersData != null)
         {
            if(this.chat_playersData[param1] != null)
            {
               this.chat_playersData[param1].clanID = param2;
            }
         }
      }
      
      public function chat_isPlayerBlocked(param1:*) : Boolean
      {
         var _loc2_:Boolean = false;
         _loc2_ = false;
         if(this.chat_playersData[param1] != null)
         {
            if(this.chat_playersData[param1].blocked)
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      public function goToChatAfterBattle(param1:Number, param2:String, param3:Number, param4:uint, param5:uint, param6:String) : void
      {
         this.chat_goToChatAfterBattleUserID = param1;
         this.chat_addPlayerDataAfterBattleName = param2;
         this.chat_addPlayerDataAfterBattleClanID = param3;
         this.chat_addPlayerDataAfterBattleLadderProgress = param4;
         this.chat_addPlayerDataAfterBattleLevel = param5;
         this.chat_addPlayerDataAfterBattleGeo = param6;
      }
      
      public function inviteToClanAfterBattle(param1:Number, param2:String, param3:Number, param4:uint, param5:uint, param6:String) : void
      {
         this.chat_inviteToClanAfterBattleUserID = param1;
         this.chat_addPlayerDataAfterBattleName = param2;
         this.chat_addPlayerDataAfterBattleClanID = param3;
         this.chat_addPlayerDataAfterBattleLadderProgress = param4;
         this.chat_addPlayerDataAfterBattleLevel = param5;
         this.chat_addPlayerDataAfterBattleGeo = param6;
      }
      
      public function chat_blockPlayer(param1:Number, param2:Boolean) : void
      {
         if(this.chat_playersData[param1] != null)
         {
            this.chat_playersData[param1].blocked = true;
            if(param2)
            {
               if(screensM.isScreenOpened("screenMultiPlayerChat"))
               {
                  screensM.screenMultiPlayerChat.refreshChatHistory();
               }
            }
         }
      }
      
      public function chat_unBlockPlayer(param1:Number, param2:Boolean) : void
      {
         if(this.chat_playersData[param1] != null)
         {
            this.chat_playersData[param1].blocked = false;
            if(param2)
            {
               if(screensM.isScreenOpened("screenMultiPlayerChat"))
               {
                  screensM.screenMultiPlayerChat.refreshChatHistory();
               }
            }
         }
      }
      
      public function battleInvitation_add(param1:Number, param2:String, param3:Number, param4:Number, param5:uint) : void
      {
         var _loc6_:String = null;
         param2 = this.getCensoredString(param2);
         this.battleInvitations[param1] = {
            "playerID":param1,
            "playerName":param2,
            "level":param3,
            "clanID":param4,
            "mechsPerPlayer":param5
         };
         switch(param5)
         {
            case 1:
               _loc6_ = getSpecificText("multiplayerChat_battleInvitationReceived1V1");
               break;
            case 2:
               _loc6_ = getSpecificText("multiplayerChat_battleInvitationReceived2V2");
               break;
            case 3:
               _loc6_ = getSpecificText("multiplayerChat_battleInvitationReceived3V3");
         }
         _loc6_ = "<FONT COLOR=\'#" + this.COLOR_BATTLE_INVITATION + "\'>" + this.replaceStringInText(_loc6_,"%NAME%",param2) + "</FONT>";
         this.chat_addMessage_battleInvitation(param2,param3,_loc6_,param1,param5);
      }
      
      public function battleInvitation_remove(param1:Number) : void
      {
         this.battleInvitations[param1] = null;
      }
      
      public function clan_addInvitation(param1:Number, param2:String, param3:Number, param4:String) : void
      {
         var _loc5_:String = null;
         param2 = this.getCensoredString(param2);
         param4 = this.getCensoredString(param4);
         this.clanInvitations[param1] = {
            "clanID":param1,
            "clanName":param2,
            "leaderID":param3,
            "leaderName":param4
         };
         _loc5_ = getSpecificText("multiplayerChat_clanInvitationReceived");
         _loc5_ = this.replaceStringInText(_loc5_,"%LEADER%",param4);
         _loc5_ = this.replaceStringInText(_loc5_,"%CLAN%",param2);
         _loc5_ = "<FONT COLOR=\'#" + this.COLOR_BATTLE_INVITATION + "\'>" + _loc5_ + "</FONT>";
         if(screensM.isScreenOpened("screenMenuMultiPlayerInspect") && this.onlinePlayersInspect_playerID == param3)
         {
            screensM.screenMenuMultiPlayerInspect.refreshScreen(param3,false,true,false);
         }
         this.chat_addMessage_clanInvitation(param1,param2,param3,param4,_loc5_);
      }
      
      public function clan_removeInvitation(param1:Number) : void
      {
         this.clanInvitations[param1] = null;
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
            this.createTipsDB();
            this.createInfoTextDB();
            this.createBattleInterfaceToolTipDB();
            this.saveLanguageData();
         }
      }
      
      public function getLanguageIcon(param1:uint = 0) : MovieClip
      {
         var _loc2_:MovieClip = null;
         _loc2_ = new MovieClip();
         if(param1 == 0)
         {
            param1 = this.languageID;
         }
         switch(param1)
         {
            case 1:
               _loc2_ = new LanguageFlag_us();
               break;
            case 3:
               _loc2_ = new LanguageFlag_ru();
               break;
            case 4:
               _loc2_ = new LanguageFlag_tr();
               break;
            case 5:
               _loc2_ = new LanguageFlag_de();
               break;
            case 7:
               _loc2_ = new LanguageFlag_pt();
               break;
            case 8:
               _loc2_ = new LanguageFlag_es();
               break;
            case 9:
               _loc2_ = new LanguageFlag_pl();
               break;
            case 10:
               _loc2_ = new LanguageFlag_hu();
               break;
            default:
               _loc2_ = new LanguageFlag_tt();
         }
         return _loc2_;
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
   }
}

