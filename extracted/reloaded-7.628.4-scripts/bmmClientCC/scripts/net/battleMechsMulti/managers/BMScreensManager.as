package net.battleMechsMulti.managers
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.net.LocalConnection;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Timer;
   import net.battleMechsMulti.helpers.BMGameShortcutsHelper;
   import net.battleMechsMulti.managers.specialOffers.BMSpecialOffersManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMItemCard;
   import net.battleMechsMulti.mobiles.BMMultiplayerLadderChatAlert;
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
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.screens.BMScreenBattle;
   import net.battleMechsMulti.screens.BMScreenBattleInterfaceBottom;
   import net.battleMechsMulti.screens.BMScreenBattleInterfaceEmotes;
   import net.battleMechsMulti.screens.BMScreenBattleInterfaceTop;
   import net.battleMechsMulti.screens.BMScreenBattleOptions;
   import net.battleMechsMulti.screens.BMScreenBlack;
   import net.battleMechsMulti.screens.BMScreenBuyConfirmation;
   import net.battleMechsMulti.screens.BMScreenChangeMechsOrder;
   import net.battleMechsMulti.screens.BMScreenChangeName;
   import net.battleMechsMulti.screens.BMScreenConfirmation;
   import net.battleMechsMulti.screens.BMScreenDailyLoginStreakBonus;
   import net.battleMechsMulti.screens.BMScreenDebugger;
   import net.battleMechsMulti.screens.BMScreenFPSTracker;
   import net.battleMechsMulti.screens.BMScreenHelp;
   import net.battleMechsMulti.screens.BMScreenInspectPlayer;
   import net.battleMechsMulti.screens.BMScreenLadderStatus;
   import net.battleMechsMulti.screens.BMScreenLostConnection;
   import net.battleMechsMulti.screens.BMScreenMenuMultiPlayerInspect;
   import net.battleMechsMulti.screens.BMScreenMorePaymentOptions;
   import net.battleMechsMulti.screens.BMScreenMultiPlayerChat;
   import net.battleMechsMulti.screens.BMScreenMultiPlayerLadder;
   import net.battleMechsMulti.screens.BMScreenPopUp;
   import net.battleMechsMulti.screens.BMScreenProfileAccounts;
   import net.battleMechsMulti.screens.BMScreenProfileInfo;
   import net.battleMechsMulti.screens.BMScreenProfileOptions;
   import net.battleMechsMulti.screens.BMScreenQuestStatusUpdate;
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
   import net.battleMechsMulti.screens.BMScreenServerRestartCountdown;
   import net.battleMechsMulti.screens.BMScreenSkipTutorial;
   import net.battleMechsMulti.screens.BMScreenSupportTicket;
   import net.battleMechsMulti.screens.BMScreenTransitionsManager;
   import net.battleMechsMulti.screens.BMScreenWatchRewardedVideo;
   import net.battleMechsMulti.screens.BMScreenWelcomeBackground;
   import net.battleMechsMulti.screens.BMScreenWelcomeLogin;
   import net.battleMechsMulti.screens.BMScreenWelcomeLoginAs;
   import net.battleMechsMulti.screens.BMScreenWelcomeLoginWarning;
   import net.battleMechsMulti.screens.BMScreenWelcomeNewExisting;
   import net.battleMechsMulti.screens.BMScreenYouTubeVidsGuide;
   import net.battleMechsMulti.screens.adminTools.BMScreenAdminItemTierList;
   import net.battleMechsMulti.screens.adminTools.BMScreenAdminTools;
   import net.battleMechsMulti.screens.adminTools.BMScreenMechGenerator;
   import net.battleMechsMulti.screens.animationSequences.BMScreenCampaignEndingSequence;
   import net.battleMechsMulti.screens.animationSequences.BMScreenCampaignOpeningSequence;
   import net.battleMechsMulti.screens.animationSequences.BMScreenOpeningSequence;
   import net.battleMechsMulti.screens.battleCredits.BMScreenBattleCreditsFull;
   import net.battleMechsMulti.screens.battleCredits.BMScreenFillBattleCredits;
   import net.battleMechsMulti.screens.battleResult.BMScreenBattleResult;
   import net.battleMechsMulti.screens.battleResult.BMScreenBattleResultBase;
   import net.battleMechsMulti.screens.beta.BMScreenBetaOptIn;
   import net.battleMechsMulti.screens.buyStarterPack.BMScreenBuyStarterPack;
   import net.battleMechsMulti.screens.buyStarterPack.BMScreenBuyStarterPackBoxesAndCurrency;
   import net.battleMechsMulti.screens.buyStarterPack.BMScreenBuyStarterPackBoxesOnly;
   import net.battleMechsMulti.screens.buyStarterPack.BMScreenBuyStarterPackBundle;
   import net.battleMechsMulti.screens.buyStarterPack.BMScreenBuyStarterPackGold;
   import net.battleMechsMulti.screens.buyStarterPack.BMScreenBuyStarterPackGoldAndTokens;
   import net.battleMechsMulti.screens.buyStarterPack.BMScreenBuyStarterPackGold_withBadge;
   import net.battleMechsMulti.screens.buyStarterPack.BMScreenBuyStarterPackGuaranteedLegendaryBox;
   import net.battleMechsMulti.screens.buyStarterPack.BMScreenBuyStarterPackImproveYourMech;
   import net.battleMechsMulti.screens.buyStarterPack.BMScreenBuyStarterPackItemAndTokens;
   import net.battleMechsMulti.screens.buyStarterPack.BMScreenBuyStarterPackMechAndCurrency;
   import net.battleMechsMulti.screens.buyStarterPack.BMScreenBuyStarterPackMechOnly;
   import net.battleMechsMulti.screens.buyStarterPack.BMScreenBuyStarterPackTokens;
   import net.battleMechsMulti.screens.buyStarterPack.BMScreenBuyStarterPackTokens_withBadge;
   import net.battleMechsMulti.screens.campaignsMenu.BMScreenCampaignsMenu;
   import net.battleMechsMulti.screens.clan.BMScreenClanChat;
   import net.battleMechsMulti.screens.clan.BMScreenClanCreate;
   import net.battleMechsMulti.screens.clan.BMScreenClanMembers;
   import net.battleMechsMulti.screens.clan.BMScreenClanMenu;
   import net.battleMechsMulti.screens.clan.BMScreenClanSettings;
   import net.battleMechsMulti.screens.clan.BMScreenClanWarInspectPlayer;
   import net.battleMechsMulti.screens.convertLegacyItems.BMScreenConvertLegacyItems;
   import net.battleMechsMulti.screens.extraOptions.BMScreenExtraOptions;
   import net.battleMechsMulti.screens.hanger.upgrade.BMScreenHangerBoostComplete;
   import net.battleMechsMulti.screens.hanger.upgrade.BMScreenHangerTransformComplete;
   import net.battleMechsMulti.screens.hanger.upgrade.BMScreenHangerTransformPreview;
   import net.battleMechsMulti.screens.hanger.upgrade.BMScreenHangerUpgrade;
   import net.battleMechsMulti.screens.inventory.BMScreenGetItemsNoSpace;
   import net.battleMechsMulti.screens.inventory.BMScreenInventoryExpand;
   import net.battleMechsMulti.screens.inventory.BMScreenInventoryFull;
   import net.battleMechsMulti.screens.inventory.BMScreenUnclaimedBoxes;
   import net.battleMechsMulti.screens.inventoryGracePeriodInfo.BMScreenInventoryGracePeriodInfo;
   import net.battleMechsMulti.screens.itemCards.BMScreenItemCards;
   import net.battleMechsMulti.screens.itemCards.BMScreenItemInfo;
   import net.battleMechsMulti.screens.ladderSeasonInfo.BMScreenLadderSeasonEndNewLadderProgress;
   import net.battleMechsMulti.screens.ladderSeasonInfo.BMScreenLadderSeasonEndReward;
   import net.battleMechsMulti.screens.ladderSeasonInfo.BMScreenLadderSeasonHighestLadderProgress;
   import net.battleMechsMulti.screens.ladderSeasonInfo.BMScreenLadderSeasonInfo;
   import net.battleMechsMulti.screens.languages.BMScreenLanguageSelection;
   import net.battleMechsMulti.screens.legalAndTerms.BMScreenLegalAndTerms;
   import net.battleMechsMulti.screens.levelUp.BMScreenLevelUpNew;
   import net.battleMechsMulti.screens.mainMenu.BMScreenMainMenu;
   import net.battleMechsMulti.screens.mechBuilds.BMScreenMechBuilds;
   import net.battleMechsMulti.screens.missionBaseMap.BMScreenMissionBaseMap;
   import net.battleMechsMulti.screens.missionDifficulty.BMScreenDifficultyUnlocked;
   import net.battleMechsMulti.screens.multiplayerLadder.BMScreen1V1To2V2TransitionWarning;
   import net.battleMechsMulti.screens.newEconomyGoldConvertion.BMScreenNewEconomyGoldConvertion;
   import net.battleMechsMulti.screens.news.BMScreenNews;
   import net.battleMechsMulti.screens.popups.BMScreenBoostItemRecommendation;
   import net.battleMechsMulti.screens.popups.BMScreenEquipBetterItemRecommendation;
   import net.battleMechsMulti.screens.popups.BMScreenVIPSubscriptionStatus;
   import net.battleMechsMulti.screens.popups.BMScreenYesNoPopup;
   import net.battleMechsMulti.screens.quests.BMScreenQuests;
   import net.battleMechsMulti.screens.rewards.BMScreenDisplayReward;
   import net.battleMechsMulti.screens.screensDirector.BMScreensDirector;
   import net.battleMechsMulti.screens.shop.BMScreenGlobalShop;
   import net.battleMechsMulti.screens.shop.BMScreenShopItemInfo;
   import net.battleMechsMulti.screens.specialOffers.BMScreenItemSpecialOffers;
   import net.battleMechsMulti.screens.specialOffers.BMScreenOneTimeSpecialOffers;
   import net.battleMechsMulti.screens.specialOffers.BMScreenSpecialOffersBase;
   import net.battleMechsMulti.screens.topBar.BMScreenTopBar;
   import net.battleMechsMulti.screens.vs.BMScreenVS;
   import net.battleMechsMulti.screens.webView.BMScreenWebView;
   import net.battleMechsMulti.screens.workshop.BMScreenWorkshop;
   import net.battleMechsMulti.screens.worldMap.BMScreenMissionWorldMap;
   import net.battleMechsMulti.utils.BMPubSub;
   
   public class BMScreensManager extends BMBaseClass
   {
      
      private static var _instance:BMScreensManager;
      
      private static var _allowInstantiation:Boolean;
      
      public static var CLIENT_READY:String = "bmSCREENS_CLIENT_READY";
      
      public static const SCREEN_TRANSITIONS_MANAGER:String = "screenTransitionsManager";
      
      public static const SCR_CONFIRMATION:String = "screenConfirmation";
      
      public static const SCR_WELCOME_BACKGROUND:String = "screenWelcomeBackground";
      
      public static const SCR_WELCOME_LOGIN:String = "screenWelcomeLogin";
      
      public static const SCR_BLACK:String = "screenBlack";
      
      public static const SCR_FPS_TRACKER:String = "screenFPSTracker";
      
      public static const SCR_LOST_CONNECTION:String = "screenLostConnection";
      
      public static const SCR_DEBUGGER:String = "screenDebugger";
      
      public static const SCR_ECONOMY_GOLD_CONVERSION:String = "screenNewEconomyGoldConvertion";
      
      public static const SCR_CONVERT_LEGACY_ITEMS:String = "screenConvertLegacyItems";
      
      public static const SCR_CAMPAIGNS_MENU:String = "screenCampaignsMenu";
      
      public static const SCR_SELECT_BATTLE_MECHS_PER_PLAYER:String = "screenSelectBattleMechsPerPlayer";
      
      public static const SCR_SUPPORT_TICKET:String = "screenSupportTicket";
      
      public static const SCR_WELCOME_LOGIN_AS:String = "screenWelcomeLoginAs";
      
      public static const SCR_WELCOME_LOGIN_WARNING:String = "screenWelcomeLoginWarning";
      
      public static const SCR_WELCOME_NEW_EXISITNG:String = "screenWelcomeNewExisting";
      
      public static const SCR_SMTV:String = "screenSMTV";
      
      public static const SCR_GLOBAL_SHOP:String = "screenGlobalShop";
      
      public static const SCR_CLAIM_MINED_TOKENS:String = "screenClaimMinedTokens";
      
      public static const SCR_MORE_PAYMENT_OPTIONS:String = "screenMorePaymentOptions";
      
      public static const SCR_ONE_TIME_SPECIAL_OFFERS:String = "screenOneTimeSpecialOffers";
      
      public static const SCR_ITEM_SPECIAL_OFFERS:String = "screenItemSpecialOffers";
      
      public static const SCR_BUY_STARTER_PACK:String = "screenBuyStarterPack";
      
      public static const SCR_BUY_STARTER_PACK_BOXES_AND_CURRENCY:String = "screenBuyStarterPackBoxesAndCurrency";
      
      public static const SCR_BUY_STARTER_PACK_BOXES_ONLY:String = "screenBuyStarterPackBoxesOnly";
      
      public static const SCR_BUY_STARTER_PACK_MECH_ONLY:String = "screenBuyStarterPackMechOnly";
      
      public static const SCR_BUY_STARTER_PACK_MECH_AND_CURRENCY:String = "screenBuyStarterPackMechAndCurrency";
      
      public static const SCR_BUY_STARTER_PACK_IMPROVE_YOUR_MECH:String = "screenBuyStarterPackImproveYourMech";
      
      public static const SCR_BUY_STARTER_PACK_TOKENS:String = "screenBuyStarterPackTokens";
      
      public static const SCR_BUY_STARTER_PACK_TOKENS_WITH_BADGE:String = "screenBuyStarterPackTokens_withBadge";
      
      public static const SCR_BUY_STARTER_PACK_GOLD:String = "screenBuyStarterPackGold";
      
      public static const SCR_BUY_STARTER_PACK_GOLD_WITH_BADGE:String = "screenBuyStarterPackGold_withBadge";
      
      public static const SCR_BUY_STARTER_PACK_GOLD_AND_TOKENS:String = "screenBuyStarterPackGoldAndTokens";
      
      public static const SCR_BUY_STARTER_PACK_ITEM_AND_TOKENS:String = "screenBuyStarterPackItemAndTokens";
      
      public static const SCR_BUY_STARTER_PACK_GUARANTEED_LEGENDARY_BOX:String = "screenBuyStarterPackGuaranteedLegendaryBox";
      
      public static const SCR_BUY_STARTER_PACK_BUNDLE:String = "screenBuyStarterPackBundle";
      
      public static const SCR_REGISTER:String = "screenRegister";
      
      public static const SCR_REGISTER_OFFER:String = "screenRegisterOffer";
      
      public static const SCR_MULTIPLAYER_CHAT:String = "screenMultiPlayerChat";
      
      public static const SCR_MULTIPLAYER_LADDER:String = "screenMultiPlayerLadder";
      
      public static const SCR_BATTLE:String = "screenBattle";
      
      public static const SCR_BATTLE_RESULT:String = "screenBattleResult";
      
      public static const SCR_SHOP_ITEM_INFO:String = "screenShopItemInfo";
      
      public static const SCR_BUY_CONFIRMATION:String = "screenBuyConfirmation";
      
      public static const SCR_EXTRA_OPTIONS:String = "screenExtraOptions";
      
      public static const SCR_INVENTORY_GRACE_PERIOD:String = "screenInventoryGracePeriodInfo";
      
      public static const SCR_YES_NO_POPUP:String = "screenYesNoPopup";
      
      public static const SCR_EQUIP_BETTER_ITEM_RECOMMENDATION:String = "screenEquipBetterItemRecommendation";
      
      public static const SCR_BOOST_ITEM_RECOMMENDATION:String = "screenBoostItemRecommendation";
      
      public static const SCR_1V1_TO_2V2_TRANSITION_WARNING:String = "screen1V1To2V2TransitionWarning";
      
      public static const SCR_QUESTS:String = "screenQuests";
      
      public static const SCR_VIP_SUBSCRIPTION_STATUS:String = "screenVIPSubscriptionStatus";
      
      public static const SCR_BATTLE_INTERFACE_BOTTOM:String = "screenBattleInterfaceBottom";
      
      public static const SCR_BATTLE_INTERFACE_EMOTES:String = "screenBattleInterfaceEmotes";
      
      public static const SCR_BATTLE_INTERFACE_TOP:String = "screenBattleInterfaceTop";
      
      public static const SCR_RANKING_LIST:String = "screenRankingList";
      
      public static const SCR_SEACH_FOR_CLAN:String = "screenSearchForClan";
      
      public static const SCR_CLAN_MENU:String = "screenClanMenu";
      
      public static const SCR_CLAN_CHAT:String = "screenClanChat";
      
      public static const SCR_CLAN_MEMBERS:String = "screenClanMembers";
      
      public static const SCR_CLAN_BOSS:String = "screenClanBoss";
      
      public static const SCR_CLAN_BOSS_CLAIM_REWARD:String = "screenClanBossClaimReward";
      
      public static const SCR_CLAN_SHOP:String = "screenClanShop";
      
      public static const SCR_CLAN_BOSS_MISSION_DETAILS:String = "screenClanBossMissionDetails";
      
      public static const SCR_SERVER_RESTART_COUNTDOWN:String = "screenServerRestartCountdown";
      
      public static const SCR_TOP_BAR:String = "screenTopBar";
      
      public static const SCR_VS:String = "screenVS";
      
      public static const SCR_REPLAYS:String = "screenReplays";
      
      public static const SCR_SKIP_TUTORIAL:String = "screenSkipTutorial";
      
      public static const SCR_HELP:String = "screenHelp";
      
      public static const SCR_ADMIN_TOOLS:String = "screenAdminTools";
      
      public static const SCR_ADMIN_ITEM_TIER_LIST:String = "screenAdminItemTierList";
      
      public static const SCR_LADDER_SEASON_INFO:String = "screenLadderSeasonInfo";
      
      public static const SCR_LADDER_SEASON_END_NEW_LADDER_PROGRESS:String = "screenLadderSeasonEndNewLadderProgress";
      
      public static const SCR_LADDER_SEASON_HIGHEST_LADDER_PROGRESS:String = "screenLadderSeasonHighestLadderProgress";
      
      public static const SCR_LADDER_SEASON_END_REWARD:String = "screenLadderSeasonEndReward";
      
      public static const SCR_CAMPAIGN_CHAT:String = "screenCampaignChat";
      
      public static const SCR_SPECIAL_OFFERS:String = "screenSpecialOffers";
      
      public static const SCR_NEWS:String = "screenNews";
      
      public static const SCR_MAIN_MENU:String = "screenMainMenu";
      
      public static const SCR_LEGAL_AND_TERMS:String = "screenLegalAndTerms";
      
      public static const SCR_BATTLE_OPTIONS:String = "screenBattleOptions";
      
      public static const SCR_PROFILE_OPTIONS:String = "screenProfileOptions";
      
      public static const SCR_PROFILE_ACCOUNTS:String = "screenProfileAccounts";
      
      public static const SCR_INSPECT_PLAYER:String = "screenInspectPlayer";
      
      public static const SCR_POPUP:String = "screenPopUp";
      
      public static const SCR_PROFILE_INFO:String = "screenProfileInfo";
      
      public static const SCR_QUEST_STATUS_UPDATE:String = "screenQuestStatusUpdate";
      
      public static const SCR_ITEM_CARDS:String = "screenItemCards";
      
      public static const SCR_ITEM_INFO:String = "screenItemInfo";
      
      public static const SCR_HANGER_UPGRADE:String = "screenHangerUpgrade";
      
      public static const SCR_WORKSHOP:String = "screenWorkshop";
      
      public static const SCR_HANGER_TRANSFORM_COMPLETE:String = "screenHangerTransformComplete";
      
      public static const SCR_HANGER_BOOST_COMPLETE:String = "screenHangerBoostComplete";
      
      public static const SCR_HANGER_UPGRADE_MASS_SELECTION:String = "screenHangerUpgradeMassSelection";
      
      public static const SCR_HANGER_TRANSFORM_PREVIEW:String = "screenHangerTransformPreview";
      
      public static const SCR_MENU_MULTIPLAYER_INSPECT:String = "screenMenuMultiPlayerInspect";
      
      public static const SCR_LADDER_STATUS:String = "screenLadderStatus";
      
      public static const SCR_LEVEL_UP_NEW:String = "screenLevelUpNew";
      
      public static const SCR_WEB_VIEW:String = "screenWebView";
      
      public static const SCR_INVENTORY_EXPAND:String = "screenInventoryExpand";
      
      public static const SCR_INVENTORY_FULL:String = "screenInventoryFull";
      
      public static const SCR_GET_ITEMS_NO_SPACE:String = "screenGetItemsNoSpace";
      
      public static const SCR_UNCLAIMED_BOXES:String = "screenUnclaimedBoxes";
      
      public static const SCR_BETA_OPT_IN:String = "screenBetaOptIn";
      
      public static const SCR_CLAN_CREATE:String = "screenClanCreate";
      
      public static const SCR_CLAN_SETTINGS:String = "screenClanSettings";
      
      public static const SCR_CLAN_WAR_JOIN:String = "screenClanWarJoin";
      
      public static const SCR_CLAN_WAR_PREPARATION:String = "screenClanWarPreparation";
      
      public static const SCR_CLAN_WAR_BATTLE:String = "screenClanWarBattle";
      
      public static const SCR_CLAN_WAR_BASE:String = "screenClanWarBase";
      
      public static const SCR_CLAN_WAR_LAST_WAR:String = "screenClanWarLastWar";
      
      public static const SCR_CLAN_WAR_INSPECT_PLAYER:String = "screenClanWarInspectPlayer";
      
      public static const SCR_CHANGE_NAME:String = "screenChangeName";
      
      public static const SCR_OPENING_SEQUENCE:String = "screenOpeningSequence";
      
      public static const SCR_CAMPAIGN_OPENING_SEQUENCE:String = "screenCampaignOpeningSequence";
      
      public static const SCR_CAMPAIGN_ENDING_SEQUENCE:String = "screenCampaignEndingSequence";
      
      public static const SCR_CHANGE_MECHS_ORDER:String = "screenChangeMechsOrder";
      
      public static const SCR_DAILY_LOGIN_STREAK_BONUS:String = "screenDailyLoginStreakBonus";
      
      public static const SCR_MISSION_BASE_MAP:String = "screenMissionBaseMap";
      
      public static const SCR_MISSION_WORLD_MAP:String = "screenMissionWorldMap";
      
      public static const SCR_DISPLAY_REWARD:String = "screenDisplayReward";
      
      public static const SCR_DIFFICULTY_UNLOCKED:String = "screenDifficultyUnlocked";
      
      public static const SCR_SEARCH_FOR_PLAYER:String = "screenSearchForPlayer";
      
      public static const SCR_YOUTUBE_VIDS_GUID:String = "screenYouTubeVidsGuide";
      
      public static const SCR_SELECT_ACCOUNT:String = "screenSelectAccount";
      
      public static const SCR_WATCH_REWARDED_VIDEO:String = "screenWatchRewardedVideo";
      
      public static const SCR_LANGUAGE_SELECTION:String = "screenLanguageSelection";
      
      public static const SCR_RECONNECTING:String = "screenReconnecting";
      
      public static const SCR_FILL_BATTLE_CREDITS:String = "screenFillBattleCredits";
      
      public static const SCR_BATTLE_CREDITS_FULL:String = "screenBattleCreditsFull";
      
      public static const SCR_KIN_SHOP:String = "screenKinShop";
      
      public static const SCR_MECH_GENERATOR:String = "screenMechGenerator";
      
      public static const SCR_RAID_BATTLE:String = "screenRaidBattle";
      
      public static const SCR_RAID_LEADERBOARD:String = "screenRaidLeaderboard";
      
      public static const SCR_RAID_MENU:String = "screenRaidMenu";
      
      public static const SCR_RAID_CLAIM_REWARD:String = "screenRaidClaimReward";
      
      public static const SCR_RAID_RULES:String = "screenRaidRules";
      
      public static const SCR_LAUNCH_NUKES:String = "screenLaunchNukes";
      
      public static const SCR_CONTENT_PACK_LIBRARY:String = "screenContentPackLibrary";
      
      public static const SCR_CONTENT_PACK_ITEM_INFO:String = "screenContentPackItemInfo";
      
      public static const SCR_ARENA_SHOP:String = "screenArenaShop";
      
      public static const SCR_BASE_BUILDING_MAIN:String = "screenBaseBuildingMain";
      
      public static const SCR_BASE_BUILDING_STRUCTURES_MENU:String = "screenBaseBuildingStructuresMenu";
      
      public static const SCR_BASE_BUILDING_ITEM_FACTORY:String = "screenBaseBuildingItemFactory";
      
      public static const SCR_BASE_BUILDING_STRUCTURE_INFO:String = "screenBaseBuildingStructureInfo";
      
      public static const SCR_LOAD_EXTERNAL_LIBRARY:String = "screenLoadExternalLibrary";
      
      public static const SCR_MECH_BUILDS:String = "screenMechBuilds";
      
      private static var allStarterPackScreenNames:Array = [SCR_BUY_STARTER_PACK_BOXES_AND_CURRENCY,SCR_BUY_STARTER_PACK_BOXES_ONLY,SCR_BUY_STARTER_PACK_MECH_ONLY,SCR_BUY_STARTER_PACK_MECH_AND_CURRENCY,SCR_BUY_STARTER_PACK_IMPROVE_YOUR_MECH,SCR_BUY_STARTER_PACK_TOKENS,SCR_BUY_STARTER_PACK_GOLD,SCR_BUY_STARTER_PACK_GOLD_WITH_BADGE,SCR_BUY_STARTER_PACK_TOKENS_WITH_BADGE,SCR_BUY_STARTER_PACK_GOLD_AND_TOKENS,SCR_BUY_STARTER_PACK_ITEM_AND_TOKENS,SCR_BUY_STARTER_PACK_GUARANTEED_LEGENDARY_BOX,SCR_BUY_STARTER_PACK_BUNDLE];
      
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
      
      public var screensDirector:BMScreensDirector;
      
      public var screenWelcomeBackground:BMScreenWelcomeBackground;
      
      public var screenSelectBattleMechsPerPlayer:BMScreenSelectBattleMechsPerPlayer;
      
      public var screenWelcomeLogin:BMScreenWelcomeLogin;
      
      public var screenSupportTicket:BMScreenSupportTicket;
      
      public var screenWelcomeLoginAs:BMScreenWelcomeLoginAs;
      
      public var screenWelcomeLoginWarning:BMScreenWelcomeLoginWarning;
      
      public var screenWelcomeNewExisting:BMScreenWelcomeNewExisting;
      
      public var screenSMTV:BMScreenSMTV;
      
      public var screenGlobalShop:BMScreenGlobalShop;
      
      public var screenClaimMinedTokens:BMScreenClaimMinedTokens;
      
      public var screenMorePaymentOptions:BMScreenMorePaymentOptions;
      
      public var screenOneTimeSpecialOffers:BMScreenOneTimeSpecialOffers;
      
      public var screenItemSpecialOffers:BMScreenItemSpecialOffers;
      
      public var screenLostConnection:BMScreenLostConnection;
      
      public var screenBuyStarterPack:BMScreenBuyStarterPack;
      
      public var screenBuyStarterPackBoxesAndCurrency:BMScreenBuyStarterPackBoxesAndCurrency;
      
      public var screenBuyStarterPackBoxesOnly:BMScreenBuyStarterPackBoxesOnly;
      
      public var screenBuyStarterPackMechAndCurrency:BMScreenBuyStarterPackMechAndCurrency;
      
      public var screenBuyStarterPackMechOnly:BMScreenBuyStarterPackMechOnly;
      
      public var screenBuyStarterPackImproveYourMech:BMScreenBuyStarterPackImproveYourMech;
      
      public var screenBuyStarterPackTokens:BMScreenBuyStarterPackTokens;
      
      public var screenBuyStarterPackTokens_withBadge:BMScreenBuyStarterPackTokens_withBadge;
      
      public var screenBuyStarterPackGold:BMScreenBuyStarterPackGold;
      
      public var screenBuyStarterPackGoldAndTokens:BMScreenBuyStarterPackGoldAndTokens;
      
      public var screenBuyStarterPackGold_withBadge:BMScreenBuyStarterPackGold_withBadge;
      
      public var screenBuyStarterPackItemAndTokens:BMScreenBuyStarterPackItemAndTokens;
      
      public var screenBuyStarterPackGuaranteedLegendaryBox:BMScreenBuyStarterPackGuaranteedLegendaryBox;
      
      public var screenBuyStarterPackBundle:BMScreenBuyStarterPackBundle;
      
      public var screenRegister:BMScreenRegister;
      
      public var screenRegisterOffer:BMScreenRegisterOffer;
      
      public var screenMultiPlayerChat:BMScreenMultiPlayerChat;
      
      public var screenMultiPlayerLadder:BMScreenMultiPlayerLadder;
      
      public var screenBattle:BMScreenBattle;
      
      public var screenBattleResult:BMScreenBattleResultBase;
      
      public var screenShopItemInfo:BMScreenShopItemInfo;
      
      public var screenNewEconomyGoldConvertion:BMScreenNewEconomyGoldConvertion;
      
      public var screenConvertLegacyItems:BMScreenConvertLegacyItems;
      
      public var screenCampaignsMenu:BMScreenCampaignsMenu;
      
      public var screenOpeningSequence:BMScreenOpeningSequence;
      
      public var screenCampaignOpeningSequence:BMScreenCampaignOpeningSequence;
      
      public var screenCampaignEndingSequence:BMScreenCampaignEndingSequence;
      
      public var screenConfirmation:BMScreenConfirmation;
      
      public var screenBuyConfirmation:BMScreenBuyConfirmation;
      
      public var screenExtraOptions:BMScreenExtraOptions;
      
      public var screenInventoryGracePeriodInfo:BMScreenInventoryGracePeriodInfo;
      
      public var screenYesNoPopup:BMScreenYesNoPopup;
      
      public var screenEquipBetterItemRecommendation:BMScreenEquipBetterItemRecommendation;
      
      public var screenBoostItemRecommendation:BMScreenBoostItemRecommendation;
      
      public var screen1V1To2V2TransitionWarning:BMScreen1V1To2V2TransitionWarning;
      
      public var screenQuests:BMScreenQuests;
      
      public var screenVIPSubscriptionStatus:BMScreenVIPSubscriptionStatus;
      
      public var screenBattleInterfaceBottom:BMScreenBattleInterfaceBottom;
      
      public var screenBattleInterfaceEmotes:BMScreenBattleInterfaceEmotes;
      
      public var screenBattleInterfaceTop:BMScreenBattleInterfaceTop;
      
      public var screenRankingList:BMScreenRankingList;
      
      public var screenSearchForClan:BMScreenSearchForClan;
      
      public var screenClanMenu:BMScreenClanMenu;
      
      public var screenClanChat:BMScreenClanChat;
      
      public var screenClanMembers:BMScreenClanMembers;
      
      public var screenClanBoss:BMScreenClanBoss;
      
      public var screenClanBossClaimReward:BMScreenClanBossClaimReward;
      
      public var screenClanShop:BMScreenClanShop;
      
      public var screenClanBossMissionDetails:BMScreenClanBossMissionDetails;
      
      public var screenServerRestartCountdown:BMScreenServerRestartCountdown;
      
      public var screenClanWarJoin:BMScreenClanWarJoin;
      
      public var screenClanWarPreparation:BMScreenClanWarPreparation;
      
      public var screenClanWarBattle:BMScreenClanWarBattle;
      
      public var screenClanWarBase:BMScreenClanWarBase;
      
      public var screenClanWarLastWar:BMScreenClanWarLastWar;
      
      public var screenClanWarInspectPlayer:BMScreenClanWarInspectPlayer;
      
      public var screenTopBar:BMScreenTopBar;
      
      public var screenVS:BMScreenVS;
      
      public var screenFPSTracker:BMScreenFPSTracker;
      
      public var screenBlack:BMScreenBlack;
      
      public var screenReplays:BMScreenReplays;
      
      public var screenSkipTutorial:BMScreenSkipTutorial;
      
      public var screenHelp:BMScreenHelp;
      
      public var screenAdminTools:BMScreenAdminTools;
      
      public var screenAdminItemTierList:BMScreenAdminItemTierList;
      
      public var screenLadderSeasonInfo:BMScreenLadderSeasonInfo;
      
      public var screenLadderSeasonEndNewLadderProgress:BMScreenLadderSeasonEndNewLadderProgress;
      
      public var screenLadderSeasonHighestLadderProgress:BMScreenLadderSeasonHighestLadderProgress;
      
      public var screenLadderSeasonEndReward:BMScreenLadderSeasonEndReward;
      
      public var screenCampaignChat:BMScreenCampaignChat;
      
      public var screenSpecialOffers:BMScreenSpecialOffersBase;
      
      public var screenNews:BMScreenNews;
      
      public var screenMainMenu:BMScreenMainMenu;
      
      public var screenLegalAndTerms:BMScreenLegalAndTerms;
      
      public var screenTransitionsManager:BMScreenTransitionsManager;
      
      public var screenBattleOptions:BMScreenBattleOptions;
      
      public var screenProfileOptions:BMScreenProfileOptions;
      
      public var screenProfileAccounts:BMScreenProfileAccounts;
      
      public var screenInspectPlayer:BMScreenInspectPlayer;
      
      public var screenMechGenerator:BMScreenMechGenerator;
      
      public var screenPopUp:BMScreenPopUp;
      
      public var screenProfileInfo:BMScreenProfileInfo;
      
      public var screenQuestStatusUpdate:BMScreenQuestStatusUpdate;
      
      public var screenItemCards:BMScreenItemCards;
      
      public var screenItemInfo:BMScreenItemInfo;
      
      public var screenHangerUpgrade:BMScreenHangerUpgrade;
      
      public var screenWorkshop:BMScreenWorkshop;
      
      public var screenHangerTransformComplete:BMScreenHangerTransformComplete;
      
      public var screenHangerBoostComplete:BMScreenHangerBoostComplete;
      
      public var screenHangerUpgradeMassSelection:BMScreenHangerUpgradeMassSelection;
      
      public var screenHangerTransformPreview:BMScreenHangerTransformPreview;
      
      public var screenMenuMultiPlayerInspect:BMScreenMenuMultiPlayerInspect;
      
      public var screenLadderStatus:BMScreenLadderStatus;
      
      public var screenLevelUpNew:BMScreenLevelUpNew;
      
      public var screenWebView:BMScreenWebView;
      
      public var screenInventoryExpand:BMScreenInventoryExpand;
      
      public var screenInventoryFull:BMScreenInventoryFull;
      
      public var screenGetItemsNoSpace:BMScreenGetItemsNoSpace;
      
      public var screenUnclaimedBoxes:BMScreenUnclaimedBoxes;
      
      public var screenBetaOptIn:BMScreenBetaOptIn;
      
      public var screenClanCreate:BMScreenClanCreate;
      
      public var screenClanSettings:BMScreenClanSettings;
      
      public var screenChangeName:BMScreenChangeName;
      
      public var screenChangeMechsOrder:BMScreenChangeMechsOrder;
      
      public var screenDailyLoginStreakBonus:BMScreenDailyLoginStreakBonus;
      
      public var screenMissionBaseMap:BMScreenMissionBaseMap;
      
      public var screenMissionWorldMap:BMScreenMissionWorldMap;
      
      public var screenDisplayReward:BMScreenDisplayReward;
      
      public var screenDifficultyUnlocked:BMScreenDifficultyUnlocked;
      
      public var screenSearchForPlayer:BMScreenSearchForPlayer;
      
      public var screenYouTubeVidsGuide:BMScreenYouTubeVidsGuide;
      
      public var screenSelectAccount:BMScreenSelectAccount;
      
      public var screenWatchRewardedVideo:BMScreenWatchRewardedVideo;
      
      public var screenLanguageSelection:BMScreenLanguageSelection;
      
      public var screenReconnecting:BMScreenReconnecting;
      
      public var screenRaidBattle:BMScreenRaidBattle;
      
      public var screenRaidRules:BMScreenRaidRules;
      
      public var screenLaunchNukes:BMScreenLaunchNukes;
      
      public var screenContentPackLibrary:BMScreenContentPackLibrary;
      
      public var screenContentPackItemInfo:BMScreenContentPackItemInfo;
      
      public var screenArenaShop:BMScreenArenaShop;
      
      public var screenBaseBuildingMain:BMScreenBaseBuildingMain;
      
      public var screenBaseBuildingStructuresMenu:BMScreenBaseBuildingStructuresMenu;
      
      public var screenBaseBuildingItemFactory:BMScreenBaseBuildingItemFactory;
      
      public var screenBaseBuildingStructureInfo:BMScreenBaseBuildingStructureInfo;
      
      public var screenLoadExternalLibrary:BMScreenLoadExternalLibrary;
      
      public var screenMechBuilds:BMScreenMechBuilds;
      
      public var screenRaidLeaderboard:BMScreenRaidLeaderboard;
      
      public var screenRaidMenu:BMScreenRaidMenu;
      
      public var screenRaidClaimReward:BMScreenRaidClaimReward;
      
      public var screenFillBattleCredits:BMScreenFillBattleCredits;
      
      public var screenBattleCreditsFull:BMScreenBattleCreditsFull;
      
      public var screenKinShop:BMScreenKinShop;
      
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
      
      private var _preloginScreensCreated:Boolean = false;
      
      private var _screensWithOnOnterFrameFunction:Object = new Object();
      
      private var _returnToMainMenuWhenBlackScreenIsInactive:Boolean = false;
      
      public var USE_FPS_TRACKER:Boolean = true;
      
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
         var _loc2_:uint = 480;
         this.clientPointer.mcMainHolder.addChild(this.bottomLayer);
         this.clientPointer.mcMainHolder.addChild(this.semiMiddleLayer);
         this.clientPointer.mcMainHolder.addChild(this.middleLayer);
         this.clientPointer.mcMainHolder.addChild(this.topLayer);
         this.clientPointer.mcMainHolder.addChild(this.superTopLayer);
      }
      
      public function initialize(param1:BMClient) : void
      {
         TsLogger.log("BMScreensManager initialize");
         generateSingletonClassesPointers("screensManager");
         this.screensDirector = new BMScreensDirector();
         BMPubSub.sub(BMPubSub.MESSAGE_BLACK_SCREEN_INACTIVE,this.screnBlackInactive);
         this.clientPointer = param1;
         dataM.setFlashVarsPointer();
         var _loc2_:Boolean = false;
         if(this.clientPointer.loadedFromGlobalLoader)
         {
            _loc2_ = true;
         }
         externalAssetsM.initialize(this.loadingResourcesOnEnterFrame,this.resourcesLoaded,this.updateLoadingStatus,dataM.clientVersion,dataM.clientRunningLocally,_loc2_);
         this._screensWithOnOnterFrameFunction[SCR_WELCOME_BACKGROUND] = true;
         this._screensWithOnOnterFrameFunction[SCR_WELCOME_NEW_EXISITNG] = true;
         this._screensWithOnOnterFrameFunction[SCR_BATTLE] = true;
         this._screensWithOnOnterFrameFunction[SCR_BATTLE_INTERFACE_BOTTOM] = true;
         this._screensWithOnOnterFrameFunction[SCR_BATTLE_INTERFACE_TOP] = true;
         this._screensWithOnOnterFrameFunction[SCR_BATTLE_INTERFACE_EMOTES] = true;
         this._screensWithOnOnterFrameFunction[SCR_BATTLE_RESULT] = true;
         this._screensWithOnOnterFrameFunction[SCR_LADDER_STATUS] = true;
         this._screensWithOnOnterFrameFunction[SCR_DAILY_LOGIN_STREAK_BONUS] = true;
         this._screensWithOnOnterFrameFunction[SCR_DISPLAY_REWARD] = true;
         this._screensWithOnOnterFrameFunction[SCR_DIFFICULTY_UNLOCKED] = true;
         this._screensWithOnOnterFrameFunction[SCR_DAILY_LOGIN_STREAK_BONUS] = true;
         this._screensWithOnOnterFrameFunction[SCR_CHANGE_MECHS_ORDER] = true;
         this._screensWithOnOnterFrameFunction[SCR_MISSION_BASE_MAP] = true;
         this._screensWithOnOnterFrameFunction[SCR_MISSION_WORLD_MAP] = true;
         this._screensWithOnOnterFrameFunction[SCR_REGISTER_OFFER] = true;
         this._screensWithOnOnterFrameFunction[SCR_SPECIAL_OFFERS] = true;
         this._screensWithOnOnterFrameFunction[SCR_MULTIPLAYER_LADDER] = true;
         this._screensWithOnOnterFrameFunction[SCR_SMTV] = true;
         this._screensWithOnOnterFrameFunction[SCR_MULTIPLAYER_CHAT] = true;
         this._screensWithOnOnterFrameFunction[SCR_SEARCH_FOR_PLAYER] = true;
         this._screensWithOnOnterFrameFunction[SCR_PROFILE_INFO] = true;
         this._screensWithOnOnterFrameFunction[SCR_POPUP] = true;
         this._screensWithOnOnterFrameFunction[SCR_VS] = true;
         this._screensWithOnOnterFrameFunction[SCR_TOP_BAR] = true;
         this._screensWithOnOnterFrameFunction[SCR_HELP] = true;
         this._screensWithOnOnterFrameFunction[SCR_ITEM_CARDS] = true;
         this._screensWithOnOnterFrameFunction[SCR_QUEST_STATUS_UPDATE] = true;
         this._screensWithOnOnterFrameFunction[SCR_RANKING_LIST] = true;
         this._screensWithOnOnterFrameFunction[SCR_SEACH_FOR_CLAN] = true;
         this._screensWithOnOnterFrameFunction[SCR_CLAN_MENU] = true;
         this._screensWithOnOnterFrameFunction[SCR_INSPECT_PLAYER] = true;
         this._screensWithOnOnterFrameFunction[SCR_REPLAYS] = true;
         this._screensWithOnOnterFrameFunction[SCR_NEWS] = true;
         this._screensWithOnOnterFrameFunction[SCR_BUY_STARTER_PACK] = true;
         this._screensWithOnOnterFrameFunction[SCR_BUY_STARTER_PACK_BOXES_AND_CURRENCY] = true;
         this._screensWithOnOnterFrameFunction[SCR_BUY_STARTER_PACK_MECH_AND_CURRENCY] = true;
         this._screensWithOnOnterFrameFunction[SCR_BUY_STARTER_PACK_MECH_ONLY] = true;
         this._screensWithOnOnterFrameFunction[SCR_BUY_STARTER_PACK_IMPROVE_YOUR_MECH] = true;
         this._screensWithOnOnterFrameFunction[SCR_BUY_STARTER_PACK_TOKENS] = true;
         this._screensWithOnOnterFrameFunction[SCR_BUY_STARTER_PACK_GOLD] = true;
         this._screensWithOnOnterFrameFunction[SCR_BUY_STARTER_PACK_GOLD_WITH_BADGE] = true;
         this._screensWithOnOnterFrameFunction[SCR_BUY_STARTER_PACK_TOKENS_WITH_BADGE] = true;
         this._screensWithOnOnterFrameFunction[SCR_BUY_STARTER_PACK_GOLD_AND_TOKENS] = true;
         this._screensWithOnOnterFrameFunction[SCR_BUY_STARTER_PACK_ITEM_AND_TOKENS] = true;
         this._screensWithOnOnterFrameFunction[SCR_ONE_TIME_SPECIAL_OFFERS] = true;
         this._screensWithOnOnterFrameFunction[SCR_BUY_STARTER_PACK_BUNDLE] = true;
         this._screensWithOnOnterFrameFunction[SCR_SHOP_ITEM_INFO] = true;
         this._screensWithOnOnterFrameFunction[SCR_WATCH_REWARDED_VIDEO] = true;
         this._screensWithOnOnterFrameFunction[SCR_GLOBAL_SHOP] = true;
         this._screensWithOnOnterFrameFunction[SCR_MAIN_MENU] = true;
         this._screensWithOnOnterFrameFunction[SCR_HANGER_UPGRADE] = true;
         this._screensWithOnOnterFrameFunction[SCR_WORKSHOP] = true;
         this._screensWithOnOnterFrameFunction[SCR_QUESTS] = true;
         this._screensWithOnOnterFrameFunction[SCR_RAID_LEADERBOARD] = true;
         this._screensWithOnOnterFrameFunction[SCR_RAID_BATTLE] = true;
         this._screensWithOnOnterFrameFunction[SCR_CLAN_MEMBERS] = true;
         this._screensWithOnOnterFrameFunction[SCR_CLAN_BOSS] = true;
         this._screensWithOnOnterFrameFunction[SCR_CAMPAIGN_CHAT] = true;
         this._screensWithOnOnterFrameFunction[SCR_BUY_STARTER_PACK_BOXES_ONLY] = true;
         this._screensWithOnOnterFrameFunction[SCR_BUY_STARTER_PACK_GUARANTEED_LEGENDARY_BOX] = true;
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
         if(this.clientPointer.parent.parent != null)
         {
            this.clientPointer.parent["parent"].progressHandler_resourcesLoaded();
         }
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
         var _loc2_:LocalConnection = null;
         var _loc3_:* = undefined;
         TsLogger.log("createPreLoginScreens caller : " + param1);
         if(this._preloginScreensCreated == false)
         {
            this._preloginScreensCreated = true;
            this.addScreen(SCR_DEBUGGER,false);
            this.addDebuggerText("createPreLoginScreens");
            this.addDebuggerText("_socketConnectionEstablished : " + this._socketConnectionEstablished);
            this.addDebuggerText("_socketConnectionFailed : " + this._socketConnectionFailed);
            this.addDebuggerText("_resourcesLoaded : " + this._resourcesLoaded);
            if(this._resourcesLoaded)
            {
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
               if(BMGameShortcutsHelper.gameSpeedShortcut())
               {
                  this.setOnEnterFrameType("timer10");
               }
               this._secondsTimer = new Timer(1000,0);
               this._secondsTimer.addEventListener(TimerEvent.TIMER,this.seocndTimerEvent);
               this._secondsTimer.start();
               this.createDebuggerButton();
               _loc2_ = new LocalConnection();
               _loc3_ = _loc2_.domain;
               this.addScreen(SCREEN_TRANSITIONS_MANAGER,false);
               this.screenTransitionsManager.refreshScreen();
               this.addScreen(SCR_CONFIRMATION,false);
               this.addScreen(SCR_WELCOME_BACKGROUND);
               this.addScreen(SCR_WELCOME_LOGIN,false);
               this.addScreen(SCR_BLACK);
               this.screenDebugger.addTrace("Current domain : " + _loc3_);
               if(this.USE_FPS_TRACKER)
               {
                  this.addScreen(SCR_FPS_TRACKER,false);
               }
               this.superTopLayer.addChild(this.screenBlack);
               if(this.clientPointer.launchScreen != null)
               {
               }
               if(this.USE_FPS_TRACKER)
               {
               }
               this.screenBlack.activateBlackScreen(null,false,true,null,0);
               this.addScreen(SCR_WELCOME_BACKGROUND);
               this.screenWelcomeBackground.refreshScreen(true);
               addEventListener(Event.ENTER_FRAME,this.waitForSetup);
            }
            this.addDebuggerText("createPreLoginScreens completed");
         }
         else
         {
            TsLogger.log("CONNECTION LOST: CREATE PRELOGIN SCREENS");
            this.addIfNotOpened(SCR_LOST_CONNECTION);
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
         if(BMClient.isInForeground == false)
         {
            return;
         }
         dataM.updateCurrentTime();
         if(dataM.premiumAccountTime > dataM.currentTime)
         {
            if(this.isScreenOpened(SCR_PROFILE_INFO))
            {
               this.screenProfileInfo.refreshPremiumAccountText();
            }
         }
         BMPubSub.pub(BMPubSub.MESSAGE_SECOND_PASSED);
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
                     this.addScreen(SCR_WELCOME_LOGIN);
                     this.screenWelcomeLogin.refreshScreen();
                  }
                  else
                  {
                     this.addScreen(SCR_WELCOME_NEW_EXISITNG);
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
         if(loginM.isConnected && dataM.userID > 0)
         {
            if(this.isScreenOpened(SCR_PROFILE_INFO))
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
         this.mobileToolTipHandler();
         if(dataM.chatData.sendMessageCooldown > 0)
         {
            --dataM.chatData.sendMessageCooldown;
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
         this.disableNextClickForMobile = false;
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
         var _loc9_:BMMultiplayerLadderChatAlert = null;
         var _loc10_:BMTileListItem = null;
         var _loc11_:Number = NaN;
         var _loc12_:BMButtonBattle = null;
         var _loc13_:Object = null;
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
                     case SCR_CONFIRMATION:
                        if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnCancel"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCancel"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnCancelOnly"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCancelOnly"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnCancelSmall"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCancelSmall"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnConfirm"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnConfirm"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnOKOnly"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnOKOnly"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnRegister"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnRegister"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnLater"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLater"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnHanger"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnHanger"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnAppStore"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnAppStore"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnGetCredits"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnGetCredits"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnGetTokens"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnGetTokens"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnSuperMechs"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSuperMechs"
                           });
                        }
                        break;
                     case SCR_BATTLE_OPTIONS:
                        if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnMusicOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnMusicOn"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnMusicOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnMusicOff"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnSoundOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSoundOn"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnSoundOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSoundOff"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnParticlesMinus"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnParticlesMinus"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnParticlesPlus"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnParticlesPlus"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnBreathingOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBreathingOff"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnBreathingOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBreathingOn"
                           });
                        }
                        break;
                     case SCR_TOP_BAR:
                        if(this.isScreenOpened(SCR_TOP_BAR))
                        {
                           if(mouseY <= 45)
                           {
                              if(this.screenTopBar.canClickOnButton())
                              {
                                 if(this.isButtonInCoordinates(SCR_TOP_BAR,"btnGetGold"))
                                 {
                                    _loc6_.push({
                                       "screen":_loc5_[_loc7_],
                                       "button":"btnGetGold"
                                    });
                                    this.setMobileToolTipActivation(this.screenTopBar.getGoldMouseOver);
                                 }
                                 else if(this.isButtonInCoordinates(SCR_TOP_BAR,"btnGetTokens"))
                                 {
                                    _loc6_.push({
                                       "screen":_loc5_[_loc7_],
                                       "button":"btnGetTokens"
                                    });
                                    this.setMobileToolTipActivation(this.screenTopBar.getTokensMouseOver);
                                 }
                                 else if(this.isButtonInCoordinates(SCR_TOP_BAR,"btnKin"))
                                 {
                                    _loc6_.push({
                                       "screen":_loc5_[_loc7_],
                                       "button":"btnKin"
                                    });
                                 }
                                 else if(this.isSpriteInCoordinates(this.screenTopBar.mcTooltip_gold) || this.isButtonInCoordinates(SCR_TOP_BAR,"btnGetGold"))
                                 {
                                    this.setMobileToolTipActivation(this.screenTopBar.tooltipMouseOverSub,-1,"gold");
                                 }
                                 else if(this.isSpriteInCoordinates(this.screenTopBar.mcTooltip_tokens) || this.isButtonInCoordinates(SCR_TOP_BAR,"btnGetTokens"))
                                 {
                                    this.setMobileToolTipActivation(this.screenTopBar.tooltipMouseOverSub,-1,"tokens");
                                 }
                              }
                              if(this.isSpriteInCoordinates(this.screenTopBar.mcLevelAndXp.mcTooltip_XP,this.screenTopBar.mcLevelAndXp.x,this.screenTopBar.mcLevelAndXp.y))
                              {
                                 this.setMobileToolTipActivation(this.screenTopBar.tooltipMouseOverSub,-1,"XP");
                              }
                              else if(this.isSpriteInCoordinates(this.screenTopBar.mcLevelAndXp.mcTooltip_level,this.screenTopBar.mcLevelAndXp.x,this.screenTopBar.mcLevelAndXp.y))
                              {
                                 this.setMobileToolTipActivation(this.screenTopBar.tooltipMouseOverSub,-1,"level");
                              }
                           }
                        }
                        break;
                     case SCR_POPUP:
                        if(this.isButtonInCoordinates(SCR_POPUP,"btnOK"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnOK"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_POPUP,"btnFacebookPublish"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnFacebookPublish"
                           });
                        }
                        break;
                     case SCR_ITEM_CARDS:
                        if(this.isButtonInCoordinates(SCR_ITEM_CARDS,"btnOK"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnOK"
                           });
                        }
                        break;
                     case SCR_CHANGE_MECHS_ORDER:
                        if(this.isButtonInCoordinates(SCR_CHANGE_MECHS_ORDER,"btnBack"))
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
                     case SCR_INSPECT_PLAYER:
                        if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnPreviousMech"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnPreviousMech"
                           });
                           this.setMobileToolTipActivation(this.screenInspectPlayer.previousMechButtonMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnNextMech"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnNextMech"
                           });
                           this.setMobileToolTipActivation(this.screenInspectPlayer.nextMechButtonMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnUp"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnUp"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnDown"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnDown"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnMechs"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnMechs"
                           });
                           this.setMobileToolTipActivation(this.screenInspectPlayer.mechsMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnReplays"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnReplays"
                           });
                           this.setMobileToolTipActivation(this.screenInspectPlayer.replaysMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnAchievements"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnAchievements"
                           });
                           this.setMobileToolTipActivation(this.screenInspectPlayer.achievementsMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnClan"))
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
                     case SCR_SELECT_BATTLE_MECHS_PER_PLAYER:
                        if(this.isButtonInCoordinates_screenNotOnZeroCoords(SCR_SELECT_BATTLE_MECHS_PER_PLAYER,"btn1V1"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btn1V1"
                           });
                        }
                        else if(this.isButtonInCoordinates_screenNotOnZeroCoords(SCR_SELECT_BATTLE_MECHS_PER_PLAYER,"btn2V2"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btn2V2"
                           });
                        }
                        else if(this.isButtonInCoordinates_screenNotOnZeroCoords(SCR_SELECT_BATTLE_MECHS_PER_PLAYER,"btn3V3"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btn3V3"
                           });
                        }
                        break;
                     case SCR_MENU_MULTIPLAYER_INSPECT:
                        if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnSendBattleInvitation"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSendBattleInvitation"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.sendBattleInvitationMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnAcceptBattleInvitation"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnAcceptBattleInvitation"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.acceptBattleInvitationMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnDeclineBattleInvitation"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnDeclineBattleInvitation"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.declineBattleInvitationMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnBlock"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBlock"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.blockMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnUnBlock"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnUnBlock"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.unBlockMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnChat"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnChat"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.chatMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnInspect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnInspect"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.inspectMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnClose"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClose"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnAcceptClanInvitation"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnAcceptClanInvitation"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.acceptClanInvitationMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnDeclineClanInvitation"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnDeclineClanInvitation"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.declineClanInvitationMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnSendClanInvitation"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSendClanInvitation"
                           });
                           this.setMobileToolTipActivation(this.screenMenuMultiPlayerInspect.sendClanInvitationMouseOver);
                        }
                        break;
                     case SCR_MULTIPLAYER_LADDER:
                        if(this.screenMultiPlayerLadder.chatAlerts.length > 0)
                        {
                           if(this.isSpriteInCoordinates(this.screenMultiPlayerLadder.mcSizer_chatAlertsHitArea))
                           {
                              _loc4_ = 0;
                              while(_loc4_ < this.screenMultiPlayerLadder.chatAlerts.length)
                              {
                                 _loc9_ = this.screenMultiPlayerLadder.chatAlerts[_loc4_];
                                 if(this.isChatAlertInCoordinates(_loc9_))
                                 {
                                    _loc9_.mouseHitAreaMouseOverSub();
                                    _loc4_ = this.screenMultiPlayerLadder.chatAlerts.length;
                                 }
                                 _loc4_++;
                              }
                           }
                        }
                        break;
                     case SCR_VS:
                        if(this.isButtonInCoordinates(SCR_VS,"btnCancel"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCancel"
                           });
                        }
                        break;
                     case SCR_MULTIPLAYER_CHAT:
                        if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnBackToLadder"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBackToLadder"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnChannelsList"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnChannelsList"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnSearchForPlayer"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSearchForPlayer"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnSendMessage"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSendMessage"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnBattleInvitationsEnabled"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBattleInvitationsEnabled"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnBattleInvitationsDisabled"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBattleInvitationsDisabled"
                           });
                        }
                        break;
                     case SCR_SEARCH_FOR_PLAYER:
                        if(this.isButtonInCoordinates(SCR_SEARCH_FOR_PLAYER,"btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_SEARCH_FOR_PLAYER,"btnSearch"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSearch"
                           });
                        }
                        break;
                     case SCR_CLAN_MEMBERS:
                        if(this.isButtonInCoordinates(SCR_CLAN_MEMBERS,"btnAcceptRequest"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnAcceptRequest"
                           });
                           this.setMobileToolTipActivation(this.screenClanMembers.acceptRequestMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_CLAN_MEMBERS,"btnDeclineRequest"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnDeclineRequest"
                           });
                           this.setMobileToolTipActivation(this.screenClanMembers.declineRequestMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_CLAN_MEMBERS,"btnInspect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnInspect"
                           });
                           this.setMobileToolTipActivation(this.screenClanMembers.inspectMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_CLAN_MEMBERS,"btnKickMember"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnKickMember"
                           });
                           this.setMobileToolTipActivation(this.screenClanMembers.kickMemberMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_CLAN_MEMBERS,"btnLeaveClan"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLeaveClan"
                           });
                           this.setMobileToolTipActivation(this.screenClanMembers.leaveClanMouseOver);
                        }
                        break;
                     case SCR_CLAN_CHAT:
                        if(this.isSpriteInCoordinates(this.screenClanChat.mcTooltipMedals))
                        {
                           this.setMobileToolTipActivation(this.screenClanChat.medalsMouseOverSub);
                        }
                        break;
                     case SCR_NEWS:
                        _loc8_ = false;
                        if(this.screenNews.mcWeeklyWins.visible)
                        {
                           if(this.screenNews.rewardsTileListItems.length > 0)
                           {
                              _loc4_ = 0;
                              while(_loc4_ < this.screenNews.rewardsTileListItems.length)
                              {
                                 _loc10_ = this.screenNews.rewardsTileListItems[_loc4_];
                                 if(this.isTileListItemInCoordinates(_loc10_,this.screenNews.mcWeeklyWins.x,this.screenNews.mcWeeklyWins.y))
                                 {
                                    _loc11_ = this.screenNews.mcWeeklyWins.x + _loc10_.x - 285;
                                    tooltip.showToolTip("newsItem","",_loc10_.item.ID);
                                    tooltip.allowRepositionForMobile = true;
                                    tooltip.mcMainHolder.x = _loc11_;
                                    _loc4_ = this.screenNews.rewardsTileListItems.length;
                                    _loc8_ = true;
                                 }
                                 _loc4_++;
                              }
                           }
                        }
                        if(_loc8_ == false)
                        {
                           if(this.isButtonInCoordinates(SCR_NEWS,"btnBack"))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnBack"
                              });
                           }
                           else if(this.isButtonInCoordinates(SCR_NEWS,"btnPrevious"))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnPrevious"
                              });
                           }
                           else if(this.isButtonInCoordinates(SCR_NEWS,"btnNext"))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":"btnNext"
                              });
                           }
                        }
                        break;
                     case SCR_HELP:
                        if(this.isButtonInCoordinates(SCR_HELP,"btnWiki"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnWiki"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_HELP,"btnReplay"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnReplay"
                           });
                        }
                        break;
                     case SCR_PROFILE_INFO:
                        if(this.isButtonInCoordinates(SCR_PROFILE_INFO,"btnChangeName"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnChangeName"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_INFO,"btnAdminTools"))
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
                     case SCR_PROFILE_OPTIONS:
                        if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnBreathingOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBreathingOff"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnBreathingOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBreathingOn"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnLanguages"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLanguages"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnMusicOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnMusicOff"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnMusicOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnMusicOn"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnParticlesMinus"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnParticlesMinus"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnParticlesPlus"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnParticlesPlus"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnSoundOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSoundOff"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnSoundOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSoundOn"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnPushNotificationsOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnPushNotificationsOff"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnPushNotificationsOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnPushNotificationsOn"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnSeePerksOn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSeePerksOn"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnSeePerksOff"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSeePerksOff"
                           });
                        }
                        break;
                     case SCR_PROFILE_ACCOUNTS:
                        if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnSuperMechsConnect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSuperMechsConnect"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnGooglePlayConnect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnGooglePlayConnect"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnFacebookConnect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnFacebookConnect"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnSuperMechsDisconnect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSuperMechsDisconnect"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnGooglePlayDisconnect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnGooglePlayDisconnect"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnFacebookDisconnect"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnFacebookDisconnect"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnLogout"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLogout"
                           });
                        }
                        break;
                     case SCR_WELCOME_NEW_EXISITNG:
                        if(this.isButtonInCoordinates(SCR_WELCOME_NEW_EXISITNG,"btnNewPlayer"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnNewPlayer"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_WELCOME_NEW_EXISITNG,"btnExistingPlayer"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnExistingPlayer"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_WELCOME_NEW_EXISITNG,"btnAlreadyHasAccount"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnAlreadyHasAccount"
                           });
                        }
                        break;
                     case SCR_WELCOME_LOGIN:
                        if(this.isButtonInCoordinates(SCR_WELCOME_LOGIN,"btnLogin"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnLogin"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_WELCOME_LOGIN,"btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_WELCOME_LOGIN,"btnRegister"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnRegister"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_WELCOME_LOGIN,"btnFacebookLogin"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnFacebookLogin"
                           });
                        }
                        break;
                     case SCR_CHANGE_NAME:
                        if(this.isButtonInCoordinates(SCR_CHANGE_NAME,"btnCancel"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCancel"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_CHANGE_NAME,"btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_CHANGE_NAME,"btnChange"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnChange"
                           });
                        }
                        break;
                     case SCR_ADMIN_TOOLS:
                        if(this.isButtonInCoordinates(SCR_ADMIN_TOOLS,"btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_ADMIN_TOOLS,"btnActivateReset"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnActivateReset"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_ADMIN_TOOLS,"btnUpdateBoost"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnUpdateBoost"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_ADMIN_TOOLS,"btnResetRateBox"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnResetRateBox"
                           });
                        }
                        break;
                     case SCR_SPECIAL_OFFERS:
                        if(this.isButtonInCoordinates_screenNotOnZeroCoords(SCR_SPECIAL_OFFERS,"btnBuy"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBuy"
                           });
                        }
                        break;
                     case SCR_REGISTER:
                        if(this.isButtonInCoordinates(SCR_REGISTER,"btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_REGISTER,"btnRegister"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnRegister"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_REGISTER,"btnCopyName"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCopyName"
                           });
                        }
                        break;
                     case SCR_GLOBAL_SHOP:
                        if(this.isButtonInCoordinates(SCR_GLOBAL_SHOP,"btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_GLOBAL_SHOP,"btnClose"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClose"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_GLOBAL_SHOP,"btnBuyTokens"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBuyTokens"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_GLOBAL_SHOP,"btnBuyGold"))
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
                     case SCR_MISSION_WORLD_MAP:
                        if(this.isButtonInCoordinates(SCR_MISSION_WORLD_MAP,"btnGoToHighestMission"))
                        {
                           _loc6_.push({
                              "screen":SCR_MISSION_WORLD_MAP,
                              "button":"btnGoToHighestMission"
                           });
                        }
                        break;
                     case SCR_DISPLAY_REWARD:
                        if(this.isButtonInCoordinates(SCR_DISPLAY_REWARD,"btnClose"))
                        {
                           _loc6_.push({
                              "screen":SCR_DISPLAY_REWARD,
                              "button":"btnClose"
                           });
                        }
                        break;
                     case SCR_REGISTER_OFFER:
                        if(this.isButtonInCoordinates_screenNotOnZeroCoords(SCR_REGISTER_OFFER,"btnRegister"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnRegister"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_REGISTER_OFFER,"btnFacebookLogin"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnFacebookLogin"
                           });
                        }
                        break;
                     case SCR_RANKING_LIST:
                        if(this.isButtonInCoordinates(SCR_RANKING_LIST,"btnPlayers"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnPlayers"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_RANKING_LIST,"btnClans"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClans"
                           });
                        }
                        break;
                     case SCR_SEACH_FOR_CLAN:
                        if(this.isButtonInCoordinates(SCR_SEACH_FOR_CLAN,"btnClanCreate"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClanCreate"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_SEACH_FOR_CLAN,"btnClanSearch"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClanSearch"
                           });
                        }
                        break;
                     case SCR_WATCH_REWARDED_VIDEO:
                        if(this.isButtonInCoordinates(SCR_WATCH_REWARDED_VIDEO,"btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        break;
                     case SCR_RECONNECTING:
                        break;
                     case SCR_FILL_BATTLE_CREDITS:
                        break;
                     case SCR_BATTLE_CREDITS_FULL:
                        break;
                     case SCR_YOUTUBE_VIDS_GUID:
                        if(this.isButtonInCoordinates(SCR_YOUTUBE_VIDS_GUID,"btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        break;
                     case SCR_SELECT_ACCOUNT:
                        break;
                     case SCR_CLAN_CREATE:
                        if(this.isButtonInCoordinates(SCR_CLAN_CREATE,"btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_CLAN_CREATE,"btnCreate"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCreate"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_CLAN_CREATE,"btnCancel"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnCancel"
                           });
                        }
                        break;
                     case SCR_BATTLE_INTERFACE_TOP:
                        if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnZoomIn"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnZoomIn"
                           });
                           this.setMobileToolTipActivation(this.screenBattleInterfaceTop.zoomInMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnZoomOut"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnZoomOut"
                           });
                           this.setMobileToolTipActivation(this.screenBattleInterfaceTop.zoomOutMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnQuit"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnQuit"
                           });
                           this.setMobileToolTipActivation(this.screenBattleInterfaceTop.quitMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnOptions"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnOptions"
                           });
                           this.setMobileToolTipActivation(this.screenBattleInterfaceTop.optionsMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnEmotesOpen"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnEmotesOpen"
                           });
                           this.setMobileToolTipActivation(this.screenBattleInterfaceTop.emotesOpenMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnEmotesClose"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnEmotesClose"
                           });
                           this.setMobileToolTipActivation(this.screenBattleInterfaceTop.emotesCloseMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnPauseReplay"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnPauseReplay"
                           });
                           this.setMobileToolTipActivation(this.screenBattleInterfaceTop.pauseReplayMouseOver);
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnPlayReplay"))
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
                           }
                        }
                        break;
                     case SCR_BATTLE_INTERFACE_EMOTES:
                        if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_EMOTES,"btnSendMessage"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnSendMessage"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_EMOTES,"btnChatEnable"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnChatEnable"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_EMOTES,"btnChatDisable"))
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
                     case SCR_BATTLE_INTERFACE_BOTTOM:
                        _loc4_ = 0;
                        while(_loc4_ < this.screenBattleInterfaceBottom.allButtons.length)
                        {
                           _loc12_ = this.screenBattleInterfaceBottom.allButtons[_loc4_];
                           if(this.isBattleButtonInCoordinates(_loc12_,this.screenBattleInterfaceBottom.x,this.screenBattleInterfaceBottom.y))
                           {
                              _loc6_.push({
                                 "screen":_loc5_[_loc7_],
                                 "button":_loc12_.name
                              });
                              _loc4_ = this.screenBattleInterfaceBottom.allButtons.length;
                           }
                           _loc4_++;
                        }
                        break;
                     case SCR_LADDER_STATUS:
                        if(this.isButtonInCoordinates(SCR_LADDER_STATUS,"btnClose"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnClose"
                           });
                        }
                        break;
                     case SCR_BATTLE_RESULT:
                        break;
                     case SCR_LOST_CONNECTION:
                        if(this.isButtonInCoordinates(SCR_LOST_CONNECTION,"btnBack"))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":"btnBack"
                           });
                        }
                        else if(this.isButtonInCoordinates(SCR_LOST_CONNECTION,"btnRefresh"))
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
                  _loc13_ = _loc6_[_loc4_];
                  this[_loc13_.screen][_loc13_.button].buttonCore.hitAreaMouseDownSub();
                  this._buttonsActiveMouseDownEffect.push({
                     "screen":_loc13_.screen,
                     "button":_loc13_.button
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
         var _loc8_:BMButtonBattle = null;
         var _loc9_:Object = null;
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
                  case SCR_CONFIRMATION:
                     if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnCancel"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCancel"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnCancelOnly"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCancelOnly"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnCancelSmall"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCancelSmall"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnConfirm"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnConfirm"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnOKOnly"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnOKOnly"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnRegister"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnRegister"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnLater"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLater"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnHanger"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnHanger"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnAppStore"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAppStore"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnAppStore"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAppStore"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnGetCredits"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnGetCredits"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnGetTokens"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnGetTokens"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnSuperMechs"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSuperMechs"
                        });
                     }
                     break;
                  case SCR_BATTLE_OPTIONS:
                     if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnMusicOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnMusicOn"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnMusicOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnMusicOff"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnSoundOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSoundOn"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnSoundOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSoundOff"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnParticlesMinus"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnParticlesMinus"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnParticlesPlus"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnParticlesPlus"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnBreathingOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBreathingOn"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnBreathingOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBreathingOff"
                        });
                     }
                     break;
                  case SCR_TOP_BAR:
                     if(this.isScreenOpened(SCR_TOP_BAR))
                     {
                        if(mouseY <= 45)
                        {
                           if(this.screenTopBar.canClickOnButton())
                           {
                              if(this.isButtonInCoordinates(SCR_TOP_BAR,"btnGetGold"))
                              {
                                 _loc6_.push({
                                    "screen":_loc5_[_loc7_],
                                    "button":"btnGetGold"
                                 });
                              }
                              else if(this.isButtonInCoordinates(SCR_TOP_BAR,"btnGetTokens"))
                              {
                                 _loc6_.push({
                                    "screen":_loc5_[_loc7_],
                                    "button":"btnGetTokens"
                                 });
                              }
                              else if(this.isButtonInCoordinates(SCR_TOP_BAR,"btnKin"))
                              {
                                 _loc6_.push({
                                    "screen":_loc5_[_loc7_],
                                    "button":"btnKin"
                                 });
                              }
                           }
                        }
                        this.screenTopBar.tooltipMouseOutSub();
                     }
                     break;
                  case SCR_POPUP:
                     if(this.isButtonInCoordinates(SCR_POPUP,"btnOK"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnOK"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_POPUP,"btnFacebookPublish"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnFacebookPublish"
                        });
                     }
                     break;
                  case SCR_ITEM_CARDS:
                     if(this.isButtonInCoordinates(SCR_ITEM_CARDS,"btnOK"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnOK"
                        });
                     }
                     break;
                  case SCR_GLOBAL_SHOP:
                     if(this.isButtonInCoordinates(SCR_GLOBAL_SHOP,"btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_GLOBAL_SHOP,"btnClose"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClose"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_GLOBAL_SHOP,"btnBuyTokens"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBuyTokens"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_GLOBAL_SHOP,"btnBuyGold"))
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
                  case SCR_BUY_STARTER_PACK:
                     tooltip.hideToolTip();
                     if(this.isButtonInCoordinates(SCR_BUY_STARTER_PACK,"btnBackOrange"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBackOrange"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BUY_STARTER_PACK,"btnBackRed"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBackRed"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BUY_STARTER_PACK,"btnBuyOrange"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBuyOrange"
                        });
                     }
                     break;
                  case SCR_BATTLE_INTERFACE_TOP:
                     if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnZoomIn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnZoomIn"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnZoomOut"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnZoomOut"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnQuit"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnQuit"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnOptions"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnOptions"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnEmotesOpen"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnEmotesOpen"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnEmotesClose"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnEmotesClose"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnPauseReplay"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPauseReplay"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnPlayReplay"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPlayReplay"
                        });
                     }
                     tooltip.hideToolTip();
                     break;
                  case SCR_BATTLE_INTERFACE_EMOTES:
                     if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_EMOTES,"btnSendMessage"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSendMessage"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_EMOTES,"btnChatEnable"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnChatEnable"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_EMOTES,"btnChatDisable"))
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
                  case SCR_BATTLE_INTERFACE_BOTTOM:
                     _loc1_ = 0;
                     while(_loc1_ < this.screenBattleInterfaceBottom.allButtons.length)
                     {
                        _loc8_ = this.screenBattleInterfaceBottom.allButtons[_loc1_];
                        if(this.isBattleButtonInCoordinates(_loc8_,this.screenBattleInterfaceBottom.x,this.screenBattleInterfaceBottom.y))
                        {
                           _loc6_.push({
                              "screen":_loc5_[_loc7_],
                              "button":_loc8_.name
                           });
                           _loc1_ = this.screenBattleInterfaceBottom.allButtons.length;
                        }
                        _loc1_++;
                     }
                     break;
                  case SCR_LADDER_STATUS:
                     if(this.isButtonInCoordinates(SCR_LADDER_STATUS,"btnClose"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClose"
                        });
                     }
                     break;
                  case SCR_BATTLE_RESULT:
                     break;
                  case SCR_LOST_CONNECTION:
                     if(this.isButtonInCoordinates(SCR_LOST_CONNECTION,"btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_LOST_CONNECTION,"btnRefresh"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnRefresh"
                        });
                     }
                     break;
                  case SCR_HELP:
                     _loc3_ = this.screenHelp.cancelFingerWheeling;
                     if(this.isButtonInCoordinates(SCR_HELP,"btnWiki"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnWiki"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_HELP,"btnReplay"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnReplay"
                        });
                     }
                     break;
                  case SCR_PROFILE_INFO:
                     if(this.isButtonInCoordinates(SCR_PROFILE_INFO,"btnChangeName"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnChangeName"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_INFO,"btnAdminTools"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAdminTools"
                        });
                     }
                     break;
                  case SCR_PROFILE_OPTIONS:
                     if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnBreathingOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBreathingOff"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnBreathingOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBreathingOn"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnLanguages"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLanguages"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnMusicOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnMusicOff"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnMusicOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnMusicOn"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnParticlesMinus"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnParticlesMinus"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnParticlesPlus"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnParticlesPlus"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnSoundOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSoundOff"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnSoundOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSoundOn"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnPushNotificationsOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPushNotificationsOff"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnPushNotificationsOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPushNotificationsOn"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnSeePerksOn"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSeePerksOn"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnSeePerksOff"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSeePerksOff"
                        });
                     }
                     break;
                  case SCR_PROFILE_ACCOUNTS:
                     if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnSuperMechsConnect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSuperMechsConnect"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnGooglePlayConnect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnGooglePlayConnect"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnFacebookConnect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnFacebookConnect"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnSuperMechsDisconnect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSuperMechsDisconnect"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnGooglePlayDisconnect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnGooglePlayDisconnect"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnFacebookDisconnect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnFacebookDisconnect"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnLogout"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLogout"
                        });
                     }
                     break;
                  case SCR_REPLAYS:
                     _loc3_ = this.screenReplays.cancelFingerWheeling;
                     break;
                  case SCR_RAID_LEADERBOARD:
                     _loc3_ = this.screenRaidLeaderboard.cancelFingerWheeling;
                     break;
                  case SCR_CLAN_MEMBERS:
                     _loc3_ = this.screenClanMembers.cancelFingerWheeling;
                     if(this.isButtonInCoordinates(SCR_CLAN_MEMBERS,"btnAcceptRequest"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAcceptRequest"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CLAN_MEMBERS,"btnDeclineRequest"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnDeclineRequest"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CLAN_MEMBERS,"btnInspect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnInspect"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CLAN_MEMBERS,"btnKickMember"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnKickMember"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CLAN_MEMBERS,"btnLeaveClan"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLeaveClan"
                        });
                     }
                     break;
                  case SCR_CLAN_BOSS:
                     _loc3_ = this.screenClanBoss.cancelFingerWheeling;
                     break;
                  case SCR_NEWS:
                     if(this.isButtonInCoordinates(SCR_NEWS,"btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_NEWS,"btnPrevious"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPrevious"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_NEWS,"btnNext"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnNext"
                        });
                     }
                     break;
                  case SCR_CHANGE_MECHS_ORDER:
                     if(this.isButtonInCoordinates(SCR_CHANGE_MECHS_ORDER,"btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     this.screenChangeMechsOrder.mechsMouseUpSub();
                     break;
                  case SCR_SELECT_BATTLE_MECHS_PER_PLAYER:
                     if(this.isButtonInCoordinates_screenNotOnZeroCoords(SCR_SELECT_BATTLE_MECHS_PER_PLAYER,"btn1V1"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btn1V1"
                        });
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords(SCR_SELECT_BATTLE_MECHS_PER_PLAYER,"btn2V2"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btn2V2"
                        });
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords(SCR_SELECT_BATTLE_MECHS_PER_PLAYER,"btn3V3"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btn3V3"
                        });
                     }
                     break;
                  case SCR_MENU_MULTIPLAYER_INSPECT:
                     if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnSendBattleInvitation"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSendBattleInvitation"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnAcceptBattleInvitation"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAcceptBattleInvitation"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnDeclineBattleInvitation"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnDeclineBattleInvitation"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnBlock"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBlock"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnUnBlock"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnUnBlock"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnChat"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnChat"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnInspect"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnInspect"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnClose"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClose"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnAcceptClanInvitation"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAcceptClanInvitation"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnDeclineClanInvitation"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnDeclineClanInvitation"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnSendClanInvitation"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSendClanInvitation"
                        });
                     }
                     break;
                  case SCR_MULTIPLAYER_LADDER:
                     break;
                  case SCR_VS:
                     if(this.isButtonInCoordinates(SCR_VS,"btnCancel"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCancel"
                        });
                     }
                     break;
                  case SCR_MULTIPLAYER_CHAT:
                     _loc3_ = this.screenMultiPlayerChat.cancelFingerWheeling;
                     if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnBackToLadder"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBackToLadder"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnChannelsList"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnChannelsList"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnSearchForPlayer"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSearchForPlayer"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnSendMessage"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSendMessage"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnBattleInvitationsEnabled"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBattleInvitationsEnabled"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnBattleInvitationsDisabled"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBattleInvitationsDisabled"
                        });
                     }
                     break;
                  case SCR_SEARCH_FOR_PLAYER:
                     _loc3_ = this.screenSearchForPlayer.cancelFingerWheeling;
                     if(this.isButtonInCoordinates(SCR_SEARCH_FOR_PLAYER,"btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_SEARCH_FOR_PLAYER,"btnSearch"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnSearch"
                        });
                     }
                     break;
                  case SCR_WELCOME_NEW_EXISITNG:
                     if(this.isButtonInCoordinates(SCR_WELCOME_NEW_EXISITNG,"btnNewPlayer"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnNewPlayer"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_WELCOME_NEW_EXISITNG,"btnExistingPlayer"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnExistingPlayer"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_WELCOME_NEW_EXISITNG,"btnAlreadyHasAccount"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAlreadyHasAccount"
                        });
                     }
                     break;
                  case SCR_WELCOME_LOGIN:
                     if(this.isButtonInCoordinates(SCR_WELCOME_LOGIN,"btnLogin"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnLogin"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_WELCOME_LOGIN,"btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_WELCOME_LOGIN,"btnRegister"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnRegister"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_WELCOME_LOGIN,"btnFacebookLogin"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnFacebookLogin"
                        });
                     }
                     break;
                  case SCR_CHANGE_NAME:
                     if(this.isButtonInCoordinates(SCR_CHANGE_NAME,"btnCancel"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCancel"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CHANGE_NAME,"btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CHANGE_NAME,"btnChange"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnChange"
                        });
                     }
                     break;
                  case SCR_ADMIN_TOOLS:
                     if(this.isButtonInCoordinates(SCR_ADMIN_TOOLS,"btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_ADMIN_TOOLS,"btnActivateReset"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnActivateReset"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_ADMIN_TOOLS,"btnUpdateBoost"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnUpdateBoost"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_ADMIN_TOOLS,"btnResetRateBox"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnResetRateBox"
                        });
                     }
                     break;
                  case SCR_SPECIAL_OFFERS:
                     if(this.isButtonInCoordinates_screenNotOnZeroCoords(SCR_SPECIAL_OFFERS,"btnBuy"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBuy"
                        });
                     }
                     break;
                  case SCR_MISSION_WORLD_MAP:
                     if(this.isButtonInCoordinates(SCR_MISSION_WORLD_MAP,"btnGoToHighestMission"))
                     {
                        _loc6_.push({
                           "screen":SCR_MISSION_WORLD_MAP,
                           "button":"btnGoToHighestMission"
                        });
                     }
                     break;
                  case SCR_DISPLAY_REWARD:
                     if(this.isButtonInCoordinates(SCR_DISPLAY_REWARD,"btnClose"))
                     {
                        _loc6_.push({
                           "screen":SCR_DISPLAY_REWARD,
                           "button":"btnClose"
                        });
                     }
                     break;
                  case SCR_REGISTER_OFFER:
                     if(this.isButtonInCoordinates_screenNotOnZeroCoords(SCR_REGISTER_OFFER,"btnRegister"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnRegister"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_REGISTER_OFFER,"btnFacebookLogin"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnFacebookLogin"
                        });
                     }
                     break;
                  case SCR_RANKING_LIST:
                     _loc3_ = this.screenRankingList.cancelFingerWheeling;
                     if(this.isButtonInCoordinates(SCR_RANKING_LIST,"btnPlayers"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPlayers"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_RANKING_LIST,"btnClans"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClans"
                        });
                     }
                     break;
                  case SCR_SEACH_FOR_CLAN:
                     _loc3_ = this.screenSearchForClan.cancelFingerWheeling;
                     if(this.isButtonInCoordinates(SCR_SEACH_FOR_CLAN,"btnClanCreate"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClanCreate"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_SEACH_FOR_CLAN,"btnClanSearch"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClanSearch"
                        });
                     }
                     break;
                  case SCR_HANGER_UPGRADE:
                     _loc3_ = this.screenHangerUpgrade.cancelFingerWheeling;
                     break;
                  case SCR_WATCH_REWARDED_VIDEO:
                     if(this.isButtonInCoordinates(SCR_WATCH_REWARDED_VIDEO,"btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     break;
                  case SCR_RECONNECTING:
                     break;
                  case SCR_FILL_BATTLE_CREDITS:
                     break;
                  case SCR_BATTLE_CREDITS_FULL:
                     break;
                  case SCR_YOUTUBE_VIDS_GUID:
                     if(this.isButtonInCoordinates(SCR_YOUTUBE_VIDS_GUID,"btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     break;
                  case SCR_SELECT_ACCOUNT:
                     break;
                  case SCR_CLAN_CREATE:
                     if(this.isButtonInCoordinates(SCR_CLAN_CREATE,"btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CLAN_CREATE,"btnCreate"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCreate"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_CLAN_CREATE,"btnCancel"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnCancel"
                        });
                     }
                     break;
                  case SCR_INSPECT_PLAYER:
                     _loc3_ = this.screenInspectPlayer.cancelFingerWheeling;
                     if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnPreviousMech"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnPreviousMech"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnNextMech"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnNextMech"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnUp"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnUp"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnDown"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnDown"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnMechs"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnMechs"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnReplays"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnReplays"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnAchievements"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnAchievements"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnClan"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnClan"
                        });
                     }
                     this.screenInspectPlayer.generalTooltipMouseOutSub();
                     break;
                  case SCR_REGISTER:
                     if(this.isButtonInCoordinates(SCR_REGISTER,"btnBack"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnBack"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_REGISTER,"btnRegister"))
                     {
                        _loc6_.push({
                           "screen":_loc5_[_loc7_],
                           "button":"btnRegister"
                        });
                     }
                     else if(this.isButtonInCoordinates(SCR_REGISTER,"btnCopyName"))
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
               _loc9_ = _loc6_[_loc1_];
               this[_loc9_.screen][_loc9_.button].buttonCore.hitAreaMouseUpSub();
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
                  case SCR_DEBUGGER:
                     if(this.isButtonInCoordinates(SCR_DEBUGGER,"btnClear"))
                     {
                        _loc2_ = this.screenDebugger.clearClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_DEBUGGER,"btnClose"))
                     {
                        _loc2_ = this.screenDebugger.closeClicked;
                     }
                     break;
                  case SCR_CONFIRMATION:
                     if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnLater") || this.isButtonInCoordinates(SCR_CONFIRMATION,"btnCancel") || this.isButtonInCoordinates(SCR_CONFIRMATION,"btnCancelOnly") || this.isButtonInCoordinates(SCR_CONFIRMATION,"btnCancelSmall"))
                     {
                        _loc2_ = this.screenConfirmation.cancelClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnConfirm") || this.isButtonInCoordinates(SCR_CONFIRMATION,"btnOKOnly"))
                     {
                        _loc2_ = this.screenConfirmation.confirmClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnRegister"))
                     {
                        _loc2_ = this.screenConfirmation.registerClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnHanger"))
                     {
                        _loc2_ = this.screenConfirmation.hangerClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnAppStore"))
                     {
                        _loc2_ = this.screenConfirmation.appStoreClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnGetCredits"))
                     {
                        _loc2_ = this.screenConfirmation.getCreditsClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnGetTokens"))
                     {
                        _loc2_ = this.screenConfirmation.getTokensClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_CONFIRMATION,"btnSuperMechs"))
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
                  case SCR_DEBUGGER:
                     if(this.isButtonInCoordinates(SCR_DEBUGGER,"btnClose"))
                     {
                        _loc2_ = this.screenDebugger.closeClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_DEBUGGER,"btnClear"))
                     {
                        _loc2_ = this.screenDebugger.clearClicked;
                     }
                     break;
                  case SCR_GLOBAL_SHOP:
                     if(this.isButtonInCoordinates(SCR_GLOBAL_SHOP,"btnClose"))
                     {
                        _loc2_ = this.screenGlobalShop.closeClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_GLOBAL_SHOP,"btnGetTokens"))
                     {
                        _loc2_ = this.screenGlobalShop.buyTokensClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_GLOBAL_SHOP,"btnGetGold"))
                     {
                        _loc2_ = this.screenGlobalShop.buyGoldClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenGlobalShop.mcFingerWheeling))
                     {
                        _loc2_ = this.screenGlobalShop.scrollerClicked;
                     }
                     break;
                  case SCR_BATTLE_OPTIONS:
                     if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnBreathingOn"))
                     {
                        _loc2_ = this.screenBattleOptions.breathingOnClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnBreathingOff"))
                     {
                        _loc2_ = this.screenBattleOptions.breathingOffClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnParticlesMinus"))
                     {
                        _loc2_ = this.screenBattleOptions.particlesMinusClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnParticlesPlus"))
                     {
                        _loc2_ = this.screenBattleOptions.particlesPlusClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnMusicOn"))
                     {
                        _loc2_ = this.screenBattleOptions.musicOnClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnMusicOff"))
                     {
                        _loc2_ = this.screenBattleOptions.musicOffClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnSoundOn"))
                     {
                        _loc2_ = this.screenBattleOptions.soundOnClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnSoundOff"))
                     {
                        _loc2_ = this.screenBattleOptions.soundOffClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnBack"))
                     {
                        _loc2_ = this.screenBattleOptions.backClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnPerformanceFrame"))
                     {
                        _loc2_ = this.screenBattleOptions.performanceClicked;
                        _loc3_.push("frame");
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnPerformanceTimer1"))
                     {
                        _loc2_ = this.screenBattleOptions.performanceClicked;
                        _loc3_.push("timer1");
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnPerformanceTimer2"))
                     {
                        _loc2_ = this.screenBattleOptions.performanceClicked;
                        _loc3_.push("timer2");
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnPerformanceTimer3"))
                     {
                        _loc2_ = this.screenBattleOptions.performanceClicked;
                        _loc3_.push("timer3");
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnPerformanceTimer10"))
                     {
                        _loc2_ = this.screenBattleOptions.performanceClicked;
                        _loc3_.push("timer10");
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnSlowCPUOff"))
                     {
                        _loc2_ = this.screenBattleOptions.performanceClicked;
                        _loc3_.push("slowOff");
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_OPTIONS,"btnSlowCPUOn"))
                     {
                        _loc2_ = this.screenBattleOptions.performanceClicked;
                        _loc3_.push("slowOn");
                     }
                     break;
                  case SCR_REGISTER:
                     if(this.isButtonInCoordinates(SCR_REGISTER,"btnBack"))
                     {
                        _loc2_ = this.screenRegister.backClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_REGISTER,"btnRegister"))
                     {
                        _loc2_ = this.screenRegister.registerClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_REGISTER,"btnCopyName"))
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
                  case SCR_POPUP:
                     if(this.isButtonInCoordinates(SCR_POPUP,"btnOK"))
                     {
                        _loc2_ = this.screenPopUp.OKClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_POPUP,"btnFacebookPublish"))
                     {
                        _loc2_ = this.screenPopUp.facebookPublishClicked;
                     }
                     break;
                  case SCR_TOP_BAR:
                     if(mouseY <= 45)
                     {
                        if(this.screenTopBar.canClickOnButton())
                        {
                           if(this.isButtonInCoordinates(SCR_TOP_BAR,"btnGetGold"))
                           {
                              _loc2_ = this.screenTopBar.getGoldClicked;
                           }
                           else if(this.isButtonInCoordinates(SCR_TOP_BAR,"btnGetTokens"))
                           {
                              _loc2_ = this.screenTopBar.getTokensClicked;
                           }
                           else if(this.isButtonInCoordinates(SCR_TOP_BAR,"btnKin"))
                           {
                              _loc2_ = this.screenTopBar.kinClicked;
                           }
                        }
                     }
                     break;
                  case SCR_CLAN_MEMBERS:
                     if(this.isButtonInCoordinates(SCR_CLAN_MEMBERS,"btnAcceptRequest"))
                     {
                        _loc2_ = this.screenClanMembers.acceptRequestClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_CLAN_MEMBERS,"btnDeclineRequest"))
                     {
                        _loc2_ = this.screenClanMembers.declineRequestClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_CLAN_MEMBERS,"btnInspect"))
                     {
                        _loc2_ = this.screenClanMembers.inspectClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_CLAN_MEMBERS,"btnKickMember"))
                     {
                        _loc2_ = this.screenClanMembers.kickMemberClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_CLAN_MEMBERS,"btnLeaveClan"))
                     {
                        _loc2_ = this.screenClanMembers.leaveClanClicked;
                     }
                     break;
                  case SCR_NEWS:
                     if(this.isButtonInCoordinates(SCR_NEWS,"btnBack"))
                     {
                        _loc2_ = this.screenNews.backClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenNews.mcMouseHitArea))
                     {
                        _loc2_ = this.screenNews.mouseHitAreaClickedSub;
                     }
                     else if(this.isButtonInCoordinates(SCR_NEWS,"btnPrevious"))
                     {
                        _loc2_ = this.screenNews.previousClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_NEWS,"btnNext"))
                     {
                        _loc2_ = this.screenNews.nextClicked;
                     }
                     break;
                  case SCR_WELCOME_NEW_EXISITNG:
                     if(this.isButtonInCoordinates(SCR_WELCOME_NEW_EXISITNG,"btnNewPlayer"))
                     {
                        _loc2_ = this.screenWelcomeNewExisting.newPlayerClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_WELCOME_NEW_EXISITNG,"btnExistingPlayer"))
                     {
                        _loc2_ = this.screenWelcomeNewExisting.existingPlayerClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_WELCOME_NEW_EXISITNG,"btnAlreadyHasAccount"))
                     {
                        _loc2_ = this.screenWelcomeNewExisting.alreadyHasAccountClicked;
                     }
                     break;
                  case SCR_WELCOME_LOGIN:
                     if(this.isButtonInCoordinates(SCR_WELCOME_LOGIN,"btnLogin"))
                     {
                        _loc2_ = this.screenWelcomeLogin.loginClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_WELCOME_LOGIN,"btnBack"))
                     {
                        _loc2_ = this.screenWelcomeLogin.backClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_WELCOME_LOGIN,"btnRegister"))
                     {
                        _loc2_ = this.screenWelcomeLogin.registerClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_WELCOME_LOGIN,"btnFacebookLogin"))
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
                  case SCR_CHANGE_NAME:
                     if(this.isButtonInCoordinates(SCR_CHANGE_NAME,"btnBack"))
                     {
                        _loc2_ = this.screenChangeName.backClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_CHANGE_NAME,"btnCancel"))
                     {
                        _loc2_ = this.screenChangeName.backClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_CHANGE_NAME,"btnChange"))
                     {
                        _loc2_ = this.screenChangeName.changeClicked;
                     }
                     break;
                  case SCR_ADMIN_TOOLS:
                     if(this.isButtonInCoordinates(SCR_ADMIN_TOOLS,"btnBack"))
                     {
                        _loc2_ = this.screenAdminTools.backClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_ADMIN_TOOLS,"btnActivateReset"))
                     {
                        _loc2_ = this.screenAdminTools.activateResetClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_ADMIN_TOOLS,"btnUpdateBoost"))
                     {
                        _loc2_ = this.screenAdminTools.updateBoostClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_ADMIN_TOOLS,"btnResetRateBox"))
                     {
                        _loc2_ = this.screenAdminTools.resetRateBoxClicked;
                     }
                     break;
                  case SCR_SPECIAL_OFFERS:
                     if(this.isSpriteInCoordinates(this.screenSpecialOffers.mcSpecialSalesHitArea,this.screenSpecialOffers.x,this.screenSpecialOffers.y) && Boolean(tutorialM.isAllowedToClickOnMovieClip(this.screenSpecialOffers.mcSpecialSalesHitArea)))
                     {
                        _loc2_ = this.screenSpecialOffers.specialSaleHitAreaClickedSub;
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords(SCR_SPECIAL_OFFERS,"btnBuy"))
                     {
                        _loc2_ = this.screenSpecialOffers.buyClicked;
                     }
                     break;
                  case SCR_MISSION_WORLD_MAP:
                     if(this.isButtonInCoordinates(SCR_MISSION_WORLD_MAP,"btnGoToHighestMission"))
                     {
                        _loc2_ = this.screenMissionWorldMap.goToHighestMission;
                     }
                     else if(this.isButtonInCoordinates(SCR_MISSION_WORLD_MAP,"btnBack"))
                     {
                        _loc2_ = this.screenMissionWorldMap.backClicked;
                     }
                     break;
                  case SCR_MISSION_BASE_MAP:
                     if(this.isSpriteInCoordinates(this.screenMissionBaseMap.mcMapHitArea))
                     {
                        _loc2_ = this.screenMissionBaseMap.mapHitAreaClicked;
                        _loc3_.push(-1,-1,true);
                     }
                     else if(this.isSpriteInCoordinates(this.screenMissionBaseMap.mcPickupsMouseHitArea))
                     {
                        _loc2_ = this.screenMissionBaseMap.upgradesClicked;
                     }
                     break;
                  case SCR_DISPLAY_REWARD:
                     if(this.isButtonInCoordinates(SCR_DISPLAY_REWARD,"btnClose"))
                     {
                        _loc2_ = this.screenDisplayReward.closeClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenDisplayReward.mcMouseHitArea))
                     {
                        _loc2_ = this.screenDisplayReward.hitAreaClickedSub;
                     }
                     break;
                  case SCR_REGISTER_OFFER:
                     if(this.isButtonInCoordinates_screenNotOnZeroCoords(SCR_REGISTER_OFFER,"btnRegister"))
                     {
                        _loc2_ = this.screenRegisterOffer.registerClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_REGISTER_OFFER,"btnFacebookLogin"))
                     {
                        _loc2_ = this.screenRegisterOffer.facebookLoginClicked;
                     }
                     break;
                  case SCR_CHANGE_MECHS_ORDER:
                     if(this.isButtonInCoordinates(SCR_CHANGE_MECHS_ORDER,"btnBack"))
                     {
                        _loc2_ = this.screenChangeMechsOrder.backClicked;
                     }
                     break;
                  case SCR_BATTLE_INTERFACE_TOP:
                     if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnZoomIn"))
                     {
                        _loc2_ = this.screenBattle.zoomClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnZoomOut"))
                     {
                        _loc2_ = this.screenBattle.zoomClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnQuit"))
                     {
                        _loc2_ = this.screenBattle.quitClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnOptions"))
                     {
                        _loc2_ = this.screenBattle.optionsClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnEmotesOpen"))
                     {
                        _loc2_ = this.screenBattleInterfaceTop.openEmotesClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnEmotesClose"))
                     {
                        _loc2_ = this.screenBattleInterfaceTop.closeEmotesClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnPauseReplay"))
                     {
                        _loc2_ = this.screenBattleInterfaceTop.pauseReplayClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnPlayReplay"))
                     {
                        _loc2_ = this.screenBattleInterfaceTop.playReplayClicked;
                     }
                     break;
                  case SCR_BATTLE_INTERFACE_EMOTES:
                     if(this.screenBattleInterfaceEmotes.parent != null)
                     {
                        if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_EMOTES,"btnSendMessage"))
                        {
                           _loc2_ = this.screenBattleInterfaceEmotes.sendChatMessageClicked;
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_EMOTES,"btnChatEnable"))
                        {
                           _loc2_ = this.screenBattleInterfaceEmotes.chatEnableClicked;
                        }
                        else if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_EMOTES,"btnChatDisable"))
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
                  case SCR_BATTLE_INTERFACE_BOTTOM:
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
                     if(mouseY > 111 && mouseY < 370)
                     {
                        _loc11_ = true;
                        if(this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnZoomIn") || this.isButtonInCoordinates(SCR_BATTLE_INTERFACE_TOP,"btnZoomOut"))
                        {
                           _loc11_ = false;
                        }
                        else if(this.isScreenOpened(SCR_BATTLE_INTERFACE_EMOTES))
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
                  case SCR_LADDER_STATUS:
                     if(this.isButtonInCoordinates(SCR_LADDER_STATUS,"btnClose"))
                     {
                        _loc2_ = this.screenLadderStatus.closeClicked;
                     }
                     break;
                  case SCR_BATTLE_RESULT:
                     break;
                  case SCR_LOST_CONNECTION:
                     if(this.isButtonInCoordinates(SCR_LOST_CONNECTION,"btnBack"))
                     {
                        _loc2_ = this.screenLostConnection.backClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_LOST_CONNECTION,"btnRefresh"))
                     {
                        _loc2_ = this.screenLostConnection.backClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenLostConnection.mcContactSupportHitArea))
                     {
                        _loc2_ = this.screenLostConnection.contactSupportClickedSub;
                     }
                     break;
                  case SCR_SELECT_BATTLE_MECHS_PER_PLAYER:
                     if(this.isButtonInCoordinates_screenNotOnZeroCoords(SCR_SELECT_BATTLE_MECHS_PER_PLAYER,"btn1V1"))
                     {
                        _loc2_ = this.screenSelectBattleMechsPerPlayer.battleClicked;
                        _loc3_.push(1);
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords(SCR_SELECT_BATTLE_MECHS_PER_PLAYER,"btn2V2"))
                     {
                        _loc2_ = this.screenSelectBattleMechsPerPlayer.battleClicked;
                        _loc3_.push(2);
                     }
                     else if(this.isButtonInCoordinates_screenNotOnZeroCoords(SCR_SELECT_BATTLE_MECHS_PER_PLAYER,"btn3V3"))
                     {
                        _loc2_ = this.screenSelectBattleMechsPerPlayer.battleClicked;
                        _loc3_.push(3);
                     }
                     if(_loc2_ != null)
                     {
                        _loc6_ = new Array();
                     }
                     break;
                  case SCR_MENU_MULTIPLAYER_INSPECT:
                     if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnSendBattleInvitation"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.sendBattleInvitationClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnAcceptBattleInvitation"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.acceptBattleInvitationClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnDeclineBattleInvitation"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.declineBattleInvitationClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnBlock"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.blockClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnUnBlock"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.unBlockClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnChat"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.chatClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnInspect"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.inspectClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnClose"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.closeClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnSendClanInvitation"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.sendClanInvitationClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnAcceptClanInvitation"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.acceptClanInvitationClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_MENU_MULTIPLAYER_INSPECT,"btnDeclineClanInvitation"))
                     {
                        _loc2_ = this.screenMenuMultiPlayerInspect.declineClanInvitationClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenMenuMultiPlayerInspect.mcBackground) == false)
                     {
                        if(this.isScreenOpened(SCR_MULTIPLAYER_CHAT))
                        {
                           if(this.isSpriteInCoordinates(this.screenMultiPlayerChat.chatInterface.mcChatMouseHitArea))
                           {
                              this.screenMultiPlayerChat.chatInterface.chatHistoryMouseOverHandler();
                              _loc2_ = this.screenMultiPlayerChat.tryToInspectPlayerForMobile;
                           }
                        }
                     }
                     break;
                  case SCR_MULTIPLAYER_LADDER:
                     if(this.screenMultiPlayerLadder.chatAlerts.length > 0)
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
                  case SCR_VS:
                     if(this.isButtonInCoordinates(SCR_VS,"btnCancel"))
                     {
                        _loc2_ = this.screenVS.cancelClicked;
                     }
                     break;
                  case SCR_MULTIPLAYER_CHAT:
                     if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnBackToLadder"))
                     {
                        _loc2_ = this.screenMultiPlayerChat.backToLadderClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnChannelsList"))
                     {
                        _loc2_ = this.screenMultiPlayerChat.channelsListClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnSearchForPlayer"))
                     {
                        _loc2_ = this.screenMultiPlayerChat.searchForPlayerClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnBattleInvitationsEnabled"))
                     {
                        _loc2_ = this.screenMultiPlayerChat.battleInvitationsEnabledClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_MULTIPLAYER_CHAT,"btnBattleInvitationsDisabled"))
                     {
                        _loc2_ = this.screenMultiPlayerChat.battleInvitationsDisabledClicked;
                     }
                     else if(this.isScreenOpened(SCR_MENU_MULTIPLAYER_INSPECT) == false)
                     {
                        if(!(this.screenMultiPlayerChat.channelsVisibleOnLastFrame && this.isSpriteInCoordinates(this.screenMultiPlayerChat.channelsList.mcFingerWheeling_channels)))
                        {
                           if(this.isSpriteInCoordinates(this.screenMultiPlayerChat.chatInterface.mcChatMouseHitArea))
                           {
                              this.screenMultiPlayerChat.chatInterface.chatHistoryMouseOverHandler();
                              _loc2_ = this.screenMultiPlayerChat.tryToInspectPlayerForMobile;
                           }
                        }
                     }
                     break;
                  case SCR_CAMPAIGN_CHAT:
                     if(this.isSpriteInCoordinates(this.screenCampaignChat.chatInterface.mcChatMouseHitArea))
                     {
                        this.screenCampaignChat.chatInterface.chatHistoryMouseOverHandler();
                        _loc2_ = this.screenCampaignChat.tryToInspectPlayerForMobile;
                     }
                     break;
                  case SCR_SEARCH_FOR_PLAYER:
                     if(this.isButtonInCoordinates(SCR_SEARCH_FOR_PLAYER,"btnBack"))
                     {
                        _loc2_ = this.screenSearchForPlayer.backClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_SEARCH_FOR_PLAYER,"btnSearch"))
                     {
                        _loc2_ = this.screenSearchForPlayer.searchClicked;
                     }
                     break;
                  case SCR_SMTV:
                     _loc8_ = this.screenSMTV.x + this.screenSMTV.mcSMTV.mcHitAreaGeneral.x;
                     _loc9_ = this.screenSMTV.y + this.screenSMTV.mcSMTV.mcHitAreaGeneral.y;
                     if(this.isSpriteInCoordinates(this.screenSMTV.mcSMTV.mcHitAreaGeneral,_loc8_,_loc9_))
                     {
                        _loc2_ = this.screenSMTV.SMTVClickedSub;
                     }
                     break;
                  case SCR_ITEM_CARDS:
                     if(this.isButtonInCoordinates(SCR_ITEM_CARDS,"btnOK"))
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
                  case SCR_HELP:
                     if(this.isButtonInCoordinates(SCR_HELP,"btnReplay"))
                     {
                        _loc2_ = this.screenHelp.replayClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_HELP,"btnWiki"))
                     {
                        _loc2_ = this.screenHelp.wikiClicked;
                     }
                     break;
                  case SCR_PROFILE_INFO:
                     if(this.isButtonInCoordinates(SCR_PROFILE_INFO,"btnChangeName"))
                     {
                        _loc2_ = this.screenProfileInfo.changeNameClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_INFO,"btnAdminTools"))
                     {
                        _loc2_ = this.screenProfileInfo.adminToolsClicked;
                     }
                     break;
                  case SCR_PROFILE_OPTIONS:
                     if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnBreathingOff"))
                     {
                        _loc2_ = this.screenProfileOptions.breathingOffClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnBreathingOn"))
                     {
                        _loc2_ = this.screenProfileOptions.breathingOnClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnLanguages"))
                     {
                        _loc2_ = this.screenProfileOptions.languagesClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnMusicOff"))
                     {
                        _loc2_ = this.screenProfileOptions.musicOffClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnMusicOn"))
                     {
                        _loc2_ = this.screenProfileOptions.musicOnClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnParticlesMinus"))
                     {
                        _loc2_ = this.screenProfileOptions.particlesMinusClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnParticlesPlus"))
                     {
                        _loc2_ = this.screenProfileOptions.particlesPlusClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnSoundOff"))
                     {
                        _loc2_ = this.screenProfileOptions.soundOffClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnSoundOn"))
                     {
                        _loc2_ = this.screenProfileOptions.soundOnClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnPushNotificationsOff"))
                     {
                        _loc2_ = this.screenProfileOptions.pushNotificationsOffClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnPushNotificationsOn"))
                     {
                        _loc2_ = this.screenProfileOptions.pushNotificationsOnClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnSeePerksOn"))
                     {
                        _loc2_ = this.screenProfileOptions.seePerksOnClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_OPTIONS,"btnSeePerksOff"))
                     {
                        _loc2_ = this.screenProfileOptions.seePerksOffClicked;
                     }
                     break;
                  case SCR_PROFILE_ACCOUNTS:
                     if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnSuperMechsConnect"))
                     {
                        _loc2_ = this.screenProfileAccounts.superMechsClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnGooglePlayConnect"))
                     {
                        _loc2_ = this.screenProfileAccounts.googlePlayClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnItunesConnect"))
                     {
                        _loc2_ = this.screenProfileAccounts.itunesClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnFacebookConnect"))
                     {
                        _loc2_ = this.screenProfileAccounts.facebookClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnSuperMechsDisconnect"))
                     {
                        _loc2_ = this.screenProfileAccounts.superMechsClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnGooglePlayDisconnect"))
                     {
                        _loc2_ = this.screenProfileAccounts.googlePlayClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnItunesDisconnect"))
                     {
                        _loc2_ = this.screenProfileAccounts.itunesClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnFacebookDisconnect"))
                     {
                        _loc2_ = this.screenProfileAccounts.facebookClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_PROFILE_ACCOUNTS,"btnLogout"))
                     {
                        _loc2_ = this.screenProfileAccounts.logoutClicked;
                     }
                     break;
                  case SCR_INSPECT_PLAYER:
                     if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnBack"))
                     {
                        _loc2_ = this.screenInspectPlayer.backClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnPreviousMech"))
                     {
                        _loc2_ = this.screenInspectPlayer.previousMechClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnNextMech"))
                     {
                        _loc2_ = this.screenInspectPlayer.nextMechClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnUp"))
                     {
                        _loc2_ = this.screenInspectPlayer.upClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnDown"))
                     {
                        _loc2_ = this.screenInspectPlayer.downClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnMechs"))
                     {
                        _loc2_ = this.screenInspectPlayer.mechsClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnReplays"))
                     {
                        _loc2_ = this.screenInspectPlayer.replaysClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnAchievements"))
                     {
                        _loc2_ = this.screenInspectPlayer.achievementsClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_INSPECT_PLAYER,"btnClan"))
                     {
                        _loc2_ = this.screenInspectPlayer.clanClicked;
                     }
                     break;
                  case SCR_RANKING_LIST:
                     if(this.isButtonInCoordinates(SCR_RANKING_LIST,"btnPlayers"))
                     {
                        _loc2_ = this.screenRankingList.playersClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_RANKING_LIST,"btnClans"))
                     {
                        _loc2_ = this.screenRankingList.clansClicked;
                     }
                     else if(this.isMovieClipInCoordinates(this.screenRankingList.mcShowOnline,0,0))
                     {
                        _loc2_ = this.screenRankingList.showOnlineClickedSub;
                     }
                     break;
                  case SCR_SEACH_FOR_CLAN:
                     if(this.isButtonInCoordinates(SCR_SEACH_FOR_CLAN,"btnClanCreate"))
                     {
                        _loc2_ = this.screenSearchForClan.clanCreateClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_SEACH_FOR_CLAN,"btnClanSearch"))
                     {
                        _loc2_ = this.screenSearchForClan.clanSearchClicked;
                     }
                     break;
                  case SCR_WATCH_REWARDED_VIDEO:
                     if(this.isButtonInCoordinates(SCR_WATCH_REWARDED_VIDEO,"btnBack"))
                     {
                        _loc2_ = this.screenWatchRewardedVideo.backClicked;
                     }
                     else if(this.isSpriteInCoordinates(this.screenWatchRewardedVideo.mcSizer_btnWatch))
                     {
                        _loc2_ = this.screenWatchRewardedVideo.watchVideoClickedSub;
                     }
                     break;
                  case SCR_RECONNECTING:
                     break;
                  case SCR_FILL_BATTLE_CREDITS:
                     break;
                  case SCR_BATTLE_CREDITS_FULL:
                     break;
                  case SCR_YOUTUBE_VIDS_GUID:
                     if(this.isButtonInCoordinates(SCR_YOUTUBE_VIDS_GUID,"btnBack"))
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
                  case SCR_SELECT_ACCOUNT:
                     break;
                  case SCR_DAILY_LOGIN_STREAK_BONUS:
                     this.screenDailyLoginStreakBonus.mouseHitAreaClickedSub();
                     break;
                  case SCR_CLAN_CREATE:
                     if(this.isButtonInCoordinates(SCR_CLAN_CREATE,"btnBack"))
                     {
                        _loc2_ = this.screenClanCreate.backClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_CLAN_CREATE,"btnCreate"))
                     {
                        _loc2_ = this.screenClanCreate.createClicked;
                     }
                     else if(this.isButtonInCoordinates(SCR_CLAN_CREATE,"btnCancel"))
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
         var _loc3_:Boolean = false;
         var _loc1_:Array = new Array();
         if(this.isScreenOpened(SCR_DEBUGGER))
         {
            _loc1_.push(SCR_DEBUGGER);
         }
         else if(this.isScreenOpened(SCR_RECONNECTING))
         {
            _loc1_.push(SCR_RECONNECTING);
         }
         else if(this.isScreenOpened(SCR_SUPPORT_TICKET))
         {
            _loc1_.push(SCR_SUPPORT_TICKET);
         }
         else if(this.isScreenOpened(SCR_LOST_CONNECTION))
         {
            _loc1_.push(SCR_LOST_CONNECTION);
         }
         else if(this.isScreenOpened(SCR_LOAD_EXTERNAL_LIBRARY))
         {
            _loc1_.push(SCR_LOAD_EXTERNAL_LIBRARY);
         }
         else if(this.isScreenOpened(SCR_CONFIRMATION))
         {
            _loc1_.push(SCR_CONFIRMATION);
         }
         else if(this.isScreenOpened(SCR_SELECT_ACCOUNT))
         {
            _loc1_.push(SCR_SELECT_ACCOUNT);
         }
         else if(this.isScreenOpened(SCR_YES_NO_POPUP))
         {
            _loc1_.push(SCR_YES_NO_POPUP);
         }
         else if(this.isScreenOpened(SCR_EQUIP_BETTER_ITEM_RECOMMENDATION))
         {
            _loc1_.push(SCR_EQUIP_BETTER_ITEM_RECOMMENDATION);
         }
         else if(this.isScreenOpened(SCR_BOOST_ITEM_RECOMMENDATION))
         {
            _loc1_.push(SCR_BOOST_ITEM_RECOMMENDATION);
         }
         else if(this.isScreenOpened(SCR_1V1_TO_2V2_TRANSITION_WARNING))
         {
            _loc1_.push(SCR_1V1_TO_2V2_TRANSITION_WARNING);
         }
         else if(this.isScreenOpened(SCR_ECONOMY_GOLD_CONVERSION))
         {
            _loc1_.push(SCR_ECONOMY_GOLD_CONVERSION);
         }
         else if(this.isScreenOpened(SCR_CONVERT_LEGACY_ITEMS))
         {
            _loc1_.push(SCR_CONVERT_LEGACY_ITEMS);
         }
         else if(this.isScreenOpened(SCR_WEB_VIEW))
         {
            _loc1_.push(SCR_WEB_VIEW);
         }
         else if(this.isScreenOpened(SCR_WATCH_REWARDED_VIDEO))
         {
            _loc1_.push(SCR_WATCH_REWARDED_VIDEO);
         }
         else if(this.isScreenOpened(SCR_ONE_TIME_SPECIAL_OFFERS))
         {
            _loc1_.push(SCR_ONE_TIME_SPECIAL_OFFERS);
         }
         else if(this.isScreenOpened(SCR_ITEM_SPECIAL_OFFERS))
         {
            _loc1_.push(SCR_ITEM_SPECIAL_OFFERS);
         }
         else if(this.isScreenOpened(SCR_GLOBAL_SHOP))
         {
            if(this.isScreenOpened(SCR_ITEM_CARDS))
            {
               if(this.isScreenOpened(SCR_EQUIP_BETTER_ITEM_RECOMMENDATION))
               {
                  _loc1_.push(SCR_EQUIP_BETTER_ITEM_RECOMMENDATION);
               }
               else
               {
                  _loc1_.push(SCR_ITEM_CARDS);
               }
            }
            else if(this.isScreenOpened(SCR_DISPLAY_REWARD))
            {
               _loc1_.push(SCR_DISPLAY_REWARD);
            }
            else if(this.isScreenOpened(SCR_SHOP_ITEM_INFO))
            {
               _loc1_.push(SCR_SHOP_ITEM_INFO);
            }
            else
            {
               _loc1_.push(SCR_GLOBAL_SHOP);
            }
         }
         else if(this.isScreenOpened(SCR_BUY_CONFIRMATION))
         {
            _loc1_.push(SCR_BUY_CONFIRMATION);
         }
         else if(this.isScreenOpened(SCR_BATTLE_OPTIONS))
         {
            _loc1_.push(SCR_BATTLE_OPTIONS);
         }
         else if(this.isScreenOpened(SCR_REGISTER))
         {
            _loc1_.push(SCR_REGISTER);
         }
         else if(this.isScreenOpened(SCR_POPUP))
         {
            _loc1_.push(SCR_POPUP);
         }
         else if(this.isScreenOpened(SCR_BETA_OPT_IN))
         {
            _loc1_.push(SCR_BETA_OPT_IN);
         }
         else if(this.isScreenOpened(SCR_INVENTORY_EXPAND))
         {
            _loc1_.push(SCR_INVENTORY_EXPAND);
         }
         else if(this.isScreenOpened(SCR_INVENTORY_FULL))
         {
            _loc1_.push(SCR_INVENTORY_FULL);
         }
         else if(this.isScreenOpened(SCR_GET_ITEMS_NO_SPACE))
         {
            _loc1_.push(SCR_GET_ITEMS_NO_SPACE);
         }
         else if(this.isScreenOpened(SCR_UNCLAIMED_BOXES))
         {
            _loc1_.push(SCR_UNCLAIMED_BOXES);
         }
         else if(this.isScreenOpened(SCR_LEVEL_UP_NEW))
         {
            if(this.isScreenOpened(SCR_ITEM_CARDS))
            {
               _loc1_.push(SCR_ITEM_CARDS);
            }
            else
            {
               _loc1_.push(SCR_LEVEL_UP_NEW);
            }
         }
         else if(this.getBuyStarterPackScreenName() != "")
         {
            if(this.isScreenOpened(SCR_ITEM_CARDS))
            {
               _loc1_.push(SCR_ITEM_CARDS);
            }
            else
            {
               _loc1_.push(this.getBuyStarterPackScreenName());
               _loc1_.push(SCR_TOP_BAR);
            }
         }
         else if(this.isScreenOpened(SCR_ITEM_CARDS))
         {
            _loc1_.push(SCR_ITEM_CARDS);
         }
         else if(this.isScreenOpened(SCR_DISPLAY_REWARD))
         {
            _loc1_.push(SCR_DISPLAY_REWARD);
         }
         else if(this.isScreenOpened(SCR_DAILY_LOGIN_STREAK_BONUS))
         {
            _loc1_.push(SCR_DAILY_LOGIN_STREAK_BONUS);
         }
         else if(this.isScreenOpened(SCR_OPENING_SEQUENCE))
         {
            _loc1_.push(SCR_OPENING_SEQUENCE);
         }
         else if(this.isScreenOpened(SCR_CAMPAIGN_OPENING_SEQUENCE))
         {
            _loc1_.push(SCR_CAMPAIGN_OPENING_SEQUENCE);
         }
         else if(this.isScreenOpened(SCR_CAMPAIGN_ENDING_SEQUENCE))
         {
            _loc1_.push(SCR_CAMPAIGN_ENDING_SEQUENCE);
         }
         else if(this.isScreenOpened(SCR_WELCOME_NEW_EXISITNG))
         {
            _loc1_.push(SCR_WELCOME_NEW_EXISITNG);
            _loc1_.push(SCR_WELCOME_BACKGROUND);
            if(this.isScreenOpened(SCR_LANGUAGE_SELECTION))
            {
               _loc1_.push(SCR_LANGUAGE_SELECTION);
            }
         }
         else if(this.isScreenOpened(SCR_WELCOME_LOGIN))
         {
            _loc1_.push(SCR_WELCOME_LOGIN);
            _loc1_.push(SCR_WELCOME_BACKGROUND);
            if(this.isScreenOpened(SCR_LANGUAGE_SELECTION))
            {
               _loc1_.push(SCR_LANGUAGE_SELECTION);
            }
         }
         else if(this.isScreenOpened(SCR_WELCOME_LOGIN_WARNING))
         {
            _loc1_.push(SCR_WELCOME_LOGIN_WARNING);
         }
         else if(this.isScreenOpened(SCR_WELCOME_LOGIN_AS))
         {
            _loc1_.push(SCR_WELCOME_LOGIN_AS);
            _loc1_.push(SCR_WELCOME_BACKGROUND);
         }
         else if(this.isScreenOpened(SCR_CLAN_SETTINGS))
         {
            _loc1_.push(SCR_CLAN_SETTINGS);
         }
         else if(this.isScreenOpened(SCR_BATTLE))
         {
            _loc2_ = false;
            if(this.isScreenOpened(SCR_VS))
            {
               _loc2_ = true;
            }
            if(_loc2_ == false)
            {
               if(this.isScreenOpened(SCR_LADDER_STATUS))
               {
                  _loc1_.push(SCR_LADDER_STATUS);
               }
               else if(this.isScreenOpened(SCR_BATTLE_RESULT))
               {
                  _loc1_.push(SCR_BATTLE_RESULT);
               }
               else if(!this.isCampaignChatBlockingTargetScreens(_loc1_))
               {
                  _loc1_.push(SCR_BATTLE);
                  if(this.isScreenOpened(SCR_BATTLE_INTERFACE_TOP))
                  {
                     _loc1_.push(SCR_BATTLE_INTERFACE_TOP);
                  }
                  if(this.isScreenOpened(SCR_BATTLE_INTERFACE_EMOTES))
                  {
                     _loc1_.push(SCR_BATTLE_INTERFACE_EMOTES);
                  }
                  if(this.isScreenOpened(SCR_BATTLE_INTERFACE_BOTTOM))
                  {
                     _loc1_.push(SCR_BATTLE_INTERFACE_BOTTOM);
                  }
               }
            }
         }
         else if(this.isScreenOpened(SCR_MISSION_BASE_MAP))
         {
            if(!this.isScreenOpened(SCR_VS))
            {
               if(this.isScreenOpened(SCR_ITEM_CARDS))
               {
                  _loc1_.push(SCR_ITEM_CARDS);
               }
               else if(this.isScreenOpened(SCR_DISPLAY_REWARD))
               {
                  _loc1_.push(SCR_DISPLAY_REWARD);
               }
               else if(this.isScreenOpened(SCR_DIFFICULTY_UNLOCKED))
               {
                  _loc1_.push(SCR_DIFFICULTY_UNLOCKED);
               }
               else if(!this.isCampaignChatBlockingTargetScreens(_loc1_))
               {
                  _loc1_.push(SCR_MISSION_BASE_MAP);
                  _loc1_.push(SCR_TOP_BAR);
               }
            }
         }
         else if(this.isScreenOpened(SCR_NEWS))
         {
            _loc1_.push(SCR_NEWS);
         }
         else if(this.isScreenOpened(SCR_REPLAYS))
         {
            _loc1_.push(SCR_REPLAYS);
         }
         else if(this.isScreenOpened(SCR_CLAN_MENU))
         {
            if(this.isScreenOpened(SCR_INSPECT_PLAYER))
            {
               _loc1_.push(SCR_INSPECT_PLAYER);
            }
            else
            {
               _loc1_.push(SCR_CLAN_MENU);
               if(this.isScreenOpened(SCR_CLAN_BOSS_CLAIM_REWARD))
               {
                  _loc1_.push(SCR_CLAN_BOSS_CLAIM_REWARD);
               }
               else if(this.isScreenOpened(SCR_CLAN_CHAT))
               {
                  _loc1_.push(SCR_CLAN_CHAT);
               }
               else if(this.isScreenOpened(SCR_CLAN_MEMBERS))
               {
                  _loc1_.push(SCR_CLAN_MEMBERS);
               }
               else if(this.isScreenOpened(SCR_CLAN_BOSS))
               {
                  _loc1_.push(SCR_CLAN_BOSS);
               }
               else if(this.isScreenOpened(SCR_CLAN_SHOP))
               {
                  _loc1_.push(SCR_CLAN_SHOP);
                  _loc1_.push(SCR_GLOBAL_SHOP);
               }
               else if(this.isScreenOpened(SCR_CLAN_WAR_JOIN))
               {
                  _loc1_.push(SCR_CLAN_WAR_JOIN);
               }
               else if(this.isScreenOpened(SCR_CLAN_WAR_PREPARATION))
               {
                  _loc1_.push(SCR_CLAN_WAR_PREPARATION);
               }
               else if(this.isScreenOpened(SCR_CLAN_WAR_BATTLE))
               {
                  _loc1_.push(SCR_CLAN_WAR_BATTLE);
               }
               else if(this.isScreenOpened(SCR_CLAN_WAR_LAST_WAR))
               {
                  _loc1_.push(SCR_CLAN_WAR_LAST_WAR);
               }
            }
         }
         else
         {
            if(this.isScreenOpened(SCR_TOP_BAR))
            {
               _loc1_.push(SCR_TOP_BAR);
            }
            if(this.isScreenOpened(SCR_ADMIN_TOOLS))
            {
               _loc1_.push(SCR_ADMIN_TOOLS);
            }
            else if(this.isScreenOpened(SCR_MISSION_WORLD_MAP))
            {
               if(this.isScreenOpened(SCR_LAUNCH_NUKES))
               {
                  _loc1_.push(SCR_LAUNCH_NUKES);
               }
               else if(this.isScreenOpened(SCR_ITEM_CARDS))
               {
                  _loc1_.push(SCR_ITEM_CARDS);
               }
               else if(!this.isCampaignChatBlockingTargetScreens(_loc1_))
               {
                  if(this.isScreenOpened(SCR_BATTLE_CREDITS_FULL))
                  {
                     _loc1_.push(SCR_BATTLE_CREDITS_FULL);
                  }
                  else if(this.isScreenOpened(SCR_FILL_BATTLE_CREDITS))
                  {
                     _loc1_.push(SCR_FILL_BATTLE_CREDITS);
                  }
                  else
                  {
                     _loc1_.push(SCR_MISSION_WORLD_MAP);
                     if(this.isScreenOpened(SCR_REGISTER_OFFER))
                     {
                        _loc1_.push(SCR_REGISTER_OFFER);
                     }
                  }
               }
            }
            else if(this.isScreenOpened(SCR_WORKSHOP))
            {
               if(this.isScreenOpened(SCR_INVENTORY_GRACE_PERIOD))
               {
                  _loc1_.push(SCR_INVENTORY_GRACE_PERIOD);
               }
               else
               {
                  _loc1_.push(SCR_WORKSHOP);
               }
            }
            else if(this.isScreenOpened(SCR_HANGER_UPGRADE))
            {
               if(this.isScreenOpened(SCR_HANGER_TRANSFORM_PREVIEW))
               {
                  _loc1_.push(SCR_HANGER_TRANSFORM_PREVIEW);
               }
               else
               {
                  _loc1_.push(SCR_HANGER_UPGRADE);
               }
            }
            else if(this.isScreenOpened(SCR_RAID_MENU))
            {
               if(this.isScreenOpened(SCR_DISPLAY_REWARD))
               {
                  _loc1_.push(SCR_DISPLAY_REWARD);
               }
               else if(this.isScreenOpened(SCR_INSPECT_PLAYER))
               {
                  _loc1_.push(SCR_INSPECT_PLAYER);
               }
               else if(this.isScreenOpened(SCR_RAID_CLAIM_REWARD))
               {
                  _loc1_.push(SCR_RAID_CLAIM_REWARD);
               }
               else
               {
                  _loc1_.push(SCR_RAID_MENU);
                  if(this.isScreenOpened(SCR_RAID_BATTLE))
                  {
                     _loc1_.push(SCR_RAID_BATTLE);
                  }
                  else if(this.isScreenOpened(SCR_RAID_LEADERBOARD))
                  {
                     _loc1_.push(SCR_RAID_LEADERBOARD);
                  }
                  else if(this.isScreenOpened(SCR_RAID_RULES))
                  {
                     _loc1_.push(SCR_RAID_RULES);
                  }
               }
            }
            else if(this.isScreenOpened(SCR_MAIN_MENU))
            {
               if(this.isScreenOpened(SCR_CAMPAIGNS_MENU))
               {
                  _loc1_.push(SCR_CAMPAIGNS_MENU);
                  if(_loc1_.indexOf(SCR_TOP_BAR) > -1)
                  {
                     _loc1_.splice(_loc1_.indexOf(SCR_TOP_BAR),1);
                  }
               }
               else if(this.isScreenOpened(SCR_POPUP))
               {
                  _loc1_.push(SCR_POPUP);
               }
               else
               {
                  _loc1_.push(SCR_MAIN_MENU);
                  if(this.isScreenOpened(SCR_TOP_BAR))
                  {
                     _loc1_.push(SCR_TOP_BAR);
                  }
                  if(!this.isScreenOpened(SCR_QUESTS))
                  {
                     if(this.isScreenOpened(SCR_SPECIAL_OFFERS))
                     {
                        _loc1_.push(SCR_SPECIAL_OFFERS);
                     }
                  }
               }
            }
            else if(this.isScreenOpened(SCR_MULTIPLAYER_LADDER))
            {
               _loc3_ = false;
               if(this.isScreenOpened(SCR_VS))
               {
                  if(this.screenVS.visible)
                  {
                     _loc3_ = true;
                  }
               }
               if(_loc3_)
               {
                  _loc1_.push(SCR_VS);
               }
               else if(this.isScreenOpened(SCR_LADDER_SEASON_END_NEW_LADDER_PROGRESS))
               {
                  _loc1_.push(SCR_LADDER_SEASON_END_NEW_LADDER_PROGRESS);
               }
               else if(this.isScreenOpened(SCR_LADDER_SEASON_END_REWARD))
               {
                  _loc1_.push(SCR_LADDER_SEASON_END_REWARD);
               }
               else if(this.isScreenOpened(SCR_LADDER_SEASON_HIGHEST_LADDER_PROGRESS))
               {
                  _loc1_.push(SCR_LADDER_SEASON_HIGHEST_LADDER_PROGRESS);
               }
               else if(this.isScreenOpened(SCR_CHANGE_MECHS_ORDER))
               {
                  _loc1_.push(SCR_CHANGE_MECHS_ORDER);
               }
               else if(this.isScreenOpened(SCR_YOUTUBE_VIDS_GUID))
               {
                  _loc1_.push(SCR_YOUTUBE_VIDS_GUID);
               }
               else if(this.isScreenOpened(SCR_INSPECT_PLAYER))
               {
                  _loc1_.push(SCR_INSPECT_PLAYER);
               }
               else
               {
                  if(this.isScreenOpened(SCR_SELECT_BATTLE_MECHS_PER_PLAYER))
                  {
                     _loc1_.push(SCR_SELECT_BATTLE_MECHS_PER_PLAYER);
                  }
                  if(this.isScreenOpened(SCR_MENU_MULTIPLAYER_INSPECT))
                  {
                     _loc1_.push(SCR_MENU_MULTIPLAYER_INSPECT);
                  }
                  if(this.isScreenOpened(SCR_SPECIAL_OFFERS))
                  {
                     _loc1_.push(SCR_SPECIAL_OFFERS);
                  }
                  if(this.isScreenOpened(SCR_MULTIPLAYER_LADDER))
                  {
                     _loc1_.push(SCR_MULTIPLAYER_LADDER);
                  }
                  if(this.isScreenOpened(SCR_SMTV))
                  {
                     _loc1_.push(SCR_SMTV);
                  }
               }
            }
            else if(this.isScreenOpened(SCR_MULTIPLAYER_CHAT))
            {
               if(this.isScreenOpened(SCR_VS))
               {
                  _loc1_.push(SCR_VS);
               }
               else if(this.isScreenOpened(SCR_INSPECT_PLAYER))
               {
                  _loc1_.push(SCR_INSPECT_PLAYER);
               }
               else if(this.isScreenOpened(SCR_SEARCH_FOR_PLAYER))
               {
                  if(this.isScreenOpened(SCR_MENU_MULTIPLAYER_INSPECT))
                  {
                     _loc1_.push(SCR_MENU_MULTIPLAYER_INSPECT);
                  }
                  if(this.isScreenOpened(SCR_SELECT_BATTLE_MECHS_PER_PLAYER))
                  {
                     _loc1_.push(SCR_SELECT_BATTLE_MECHS_PER_PLAYER);
                  }
                  _loc1_.push(SCR_SEARCH_FOR_PLAYER);
               }
               else
               {
                  if(this.isScreenOpened(SCR_SELECT_BATTLE_MECHS_PER_PLAYER))
                  {
                     _loc1_.push(SCR_SELECT_BATTLE_MECHS_PER_PLAYER);
                  }
                  if(this.isScreenOpened(SCR_MENU_MULTIPLAYER_INSPECT))
                  {
                     _loc1_.push(SCR_MENU_MULTIPLAYER_INSPECT);
                  }
                  if(this.isScreenOpened(SCR_SPECIAL_OFFERS))
                  {
                     _loc1_.push(SCR_SPECIAL_OFFERS);
                  }
                  _loc1_.push(SCR_MULTIPLAYER_CHAT);
               }
            }
            else if(this.isScreenOpened(SCR_ITEM_CARDS) && this.screenItemCards.closingScreen == false)
            {
               _loc1_.push(SCR_ITEM_CARDS);
            }
            else if(this.isScreenOpened(SCR_HELP))
            {
               _loc1_.push(SCR_HELP);
            }
            else if(this.isScreenOpened(SCR_PROFILE_INFO))
            {
               if(this.isScreenOpened(SCR_LEGAL_AND_TERMS))
               {
                  _loc1_.push(SCR_LEGAL_AND_TERMS);
               }
               else if(this.isScreenOpened(SCR_CHANGE_NAME))
               {
                  _loc1_.push(SCR_CHANGE_NAME);
               }
               else
               {
                  _loc1_.push(SCR_PROFILE_INFO);
               }
            }
            else if(this.isScreenOpened(SCR_PROFILE_ACCOUNTS))
            {
               _loc1_.push(SCR_PROFILE_ACCOUNTS);
            }
            else if(this.isScreenOpened(SCR_PROFILE_OPTIONS))
            {
               _loc1_.push(SCR_PROFILE_OPTIONS);
               if(this.isScreenOpened(SCR_LANGUAGE_SELECTION))
               {
                  _loc1_.push(SCR_LANGUAGE_SELECTION);
               }
            }
            else if(this.isScreenOpened(SCR_RANKING_LIST))
            {
               if(this.isScreenOpened(SCR_INSPECT_PLAYER))
               {
                  _loc1_.push(SCR_INSPECT_PLAYER);
               }
               else
               {
                  _loc1_.push(SCR_RANKING_LIST);
               }
            }
            else if(this.isScreenOpened(SCR_SEACH_FOR_CLAN))
            {
               if(this.isScreenOpened(SCR_CLAN_CREATE))
               {
                  _loc1_.push(SCR_CLAN_CREATE);
               }
               else
               {
                  _loc1_.push(SCR_SEACH_FOR_CLAN);
               }
            }
         }
         return _loc1_;
      }
      
      private function isCampaignChatBlockingTargetScreens(param1:Array) : Boolean
      {
         if(this.isScreenOpened(SCR_CAMPAIGN_CHAT))
         {
            if(this.isScreenOpened(SCR_INSPECT_PLAYER))
            {
               param1.push(SCR_INSPECT_PLAYER);
            }
            else if(this.isScreenOpened(SCR_MENU_MULTIPLAYER_INSPECT))
            {
               param1.push(SCR_MENU_MULTIPLAYER_INSPECT);
            }
            else
            {
               param1.push(SCR_CAMPAIGN_CHAT);
            }
            return true;
         }
         return false;
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
            if(Boolean(_loc5_ != null) && Boolean(_loc5_.buttonCore.isButtonEnabled()) && Boolean(_loc5_.buttonCore.isButtonClickable()) && Boolean(_loc5_.visible))
            {
               if(_loc5_.x <= mouseX && _loc5_.x + _loc5_.width >= mouseX)
               {
                  if(_loc5_.y <= mouseY && _loc5_.y + _loc5_.height >= mouseY)
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
         var _loc6_:* = undefined;
         var _loc5_:Boolean = false;
         if(this.isScreenOpened(param1))
         {
            _loc6_ = this[param1][param2];
            if(Boolean(_loc6_.buttonCore.isButtonEnabled()) && Boolean(_loc6_.buttonCore.isButtonClickable()) && Boolean(_loc6_.visible))
            {
               if(_loc6_.x + param3 <= mouseX && _loc6_.x + param3 + _loc6_.width >= mouseX)
               {
                  if(_loc6_.y + param4 <= mouseY && _loc6_.y + param4 + _loc6_.height >= mouseY)
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
               if(_loc5_.buttonCore.isButtonEnabled() && _loc5_.buttonCore.isButtonClickable() && _loc5_.visible)
               {
                  if(_loc4_.x + _loc5_.x * _loc4_.scaleX <= mouseX && _loc4_.x + (_loc5_.x + _loc5_.width) * _loc4_.scaleX >= mouseX)
                  {
                     if(_loc4_.y + _loc5_.y * _loc4_.scaleY <= mouseY && _loc4_.y + (_loc5_.y + _loc5_.height) * _loc4_.scaleY >= mouseY)
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
               if(param1.buttonCore.isButtonEnabled() && param1.buttonCore.isButtonClickable())
               {
                  if(param1.x + param2 <= mouseX && param1.x + param2 + param1.width >= mouseX)
                  {
                     if(param1.y + param3 <= mouseY && param1.y + param3 + param1.height >= mouseY)
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
            if(param1.buttonCore.isButtonEnabled() && param1.buttonCore.isButtonClickable())
            {
               if(param1.x + param2 <= mouseX && param1.x + param2 + param1.width >= mouseX)
               {
                  if(param1.y + param3 <= mouseY && param1.y + param3 + param1.height >= mouseY)
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
               if(param1.y + param3 <= mouseY && param1.y + param3 + param1.height >= mouseY)
               {
                  _loc4_ = true;
               }
            }
         }
         return _loc4_;
      }
      
      public function isSpriteInCoordinates(param1:Sprite, param2:Number = 0, param3:Number = 0) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc4_:Boolean = false;
         if(param1.visible && param1.parent != null)
         {
            if(param1.x + param2 <= mouseX && param1.x + param2 + param1.width >= mouseX)
            {
               if(param1.y + param3 <= mouseY && param1.y + param3 + param1.height >= mouseY)
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
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc2_:Number = this.screenItemCards.mcCardsHolder.x + param1.x - param1.fixedWidth / 2;
         var _loc3_:Number = _loc2_ + param1.fixedWidth;
         if(_loc2_ <= mouseX && _loc3_ >= mouseX)
         {
            _loc4_ = this.screenItemCards.mcCardsHolder.y + param1.y - param1.fixedHeight / 2;
            _loc5_ = _loc4_ + param1.fixedHeight;
            if(_loc4_ <= mouseY && _loc5_ >= mouseY)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isChatAlertInCoordinates(param1:BMMultiplayerLadderChatAlert) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1.x - param1.width / 2 <= mouseX && param1.x + param1.width / 2 >= mouseX)
         {
            if(param1.y - param1.height / 2 <= mouseY && param1.y + param1.height / 2 >= mouseY)
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
            if(param1.y + param3 <= mouseY && param1.y + param3 + param1.height >= mouseY)
            {
               _loc4_ = true;
            }
         }
         return _loc4_;
      }
      
      public function addBattleScreens() : void
      {
         System.gc();
         System.gc();
         dataM.loadNextAdvertisement();
         var _loc1_:Boolean = false;
         if(this.isScreenOpened(SCR_RAID_MENU))
         {
            _loc1_ = true;
         }
         else if(this.isScreenOpened(SCR_MISSION_WORLD_MAP))
         {
            _loc1_ = true;
         }
         else if(this.isScreenOpened(SCR_MISSION_BASE_MAP))
         {
            _loc1_ = true;
         }
         else if(this.isScreenOpened(SCR_WELCOME_BACKGROUND))
         {
            _loc1_ = true;
         }
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_REPLAY:
               this.addScreen(SCR_BATTLE);
               this.addScreen(SCR_BATTLE_INTERFACE_TOP);
               this.screenBattleInterfaceTop.refreshScreen();
               this.screenBattle.activateNextBattlePhase("initiate_startNewBattle");
               break;
            default:
               this.addScreen(SCR_BATTLE);
               this.addScreen(SCR_BATTLE_INTERFACE_TOP);
               this.addScreen(SCR_BATTLE_INTERFACE_BOTTOM);
               this.screenBattleInterfaceTop.refreshScreen();
               if(_loc1_ && dataM.useHiddenBaseMap)
               {
                  this.screenBattle.startNewBattleSuccess(false);
               }
               else
               {
                  this.screenBattle.activateNextBattlePhase("initiate_startNewBattle");
                  this.screenBattle.screenVSStartedClosing();
               }
               this.stagePointer.focus = this.screenBattle;
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
      
      public function setAtSizer(param1:MovieClip, param2:Sprite) : *
      {
         param1.x = param2.x;
         param1.y = param2.y;
         param1.width = param2.width;
         param1.height = param2.height;
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
      
      public function removePopupScreens() : void
      {
      }
      
      public function exitMissionBaseMapIfOpened() : void
      {
         if(this.isScreenOpened(SCR_MISSION_BASE_MAP))
         {
            this.screenMissionBaseMap.removeMe();
         }
      }
      
      public function isBattleOpened() : Boolean
      {
         return this.isScreenOpened(SCR_BATTLE);
      }
      
      public function isDailyLoginStreakBonus() : Boolean
      {
         return this.isScreenOpened(SCR_DAILY_LOGIN_STREAK_BONUS);
      }
      
      public function goToMainMenu() : void
      {
         if(this.screenBlack.isActive())
         {
            this._returnToMainMenuWhenBlackScreenIsInactive = true;
            return;
         }
         if(this.isScreenOpened(SCR_MISSION_WORLD_MAP))
         {
            this.screenMissionWorldMap.backClicked();
            return;
         }
         if(this.isScreenOpened(SCR_HANGER_UPGRADE))
         {
            this.screenHangerUpgrade.backClicked(true);
            return;
         }
         if(this.isScreenOpened(SCR_WORKSHOP))
         {
            this.screenWorkshop.backClicked();
            return;
         }
         if(this.isScreenOpened(SCR_MULTIPLAYER_LADDER))
         {
            this.screenMultiPlayerLadder.backClickedSub();
            return;
         }
         if(this.isScreenOpened(SCR_MULTIPLAYER_CHAT))
         {
            this.screenMultiPlayerChat.backClicked(true);
            return;
         }
         if(this.isScreenOpened(SCR_RAID_MENU))
         {
            this.screenRaidMenu.closeClickedSub();
            return;
         }
         if(this.isScreenOpened(SCR_MISSION_BASE_MAP))
         {
            throw new Error("screensM goToMainMenu >> cannot return to menu from base map");
         }
         if(this.isScreenOpened(SCR_BATTLE))
         {
            throw new Error("screensM goToMainMenu >> cannot return to menu from battle");
         }
         if(this.isScreenOpened(SCR_NEWS))
         {
            this.screenNews.backClicked(true);
            return;
         }
         if(this.isScreenOpened(SCR_CLAN_MENU))
         {
            this.screenClanMenu.closeClickedSub();
            return;
         }
         throw new Error("screensM goToMainMenu >> no code for request in goToMainMenu");
      }
      
      private function screnBlackInactive(param1:String, param2:Object) : void
      {
         if(this._returnToMainMenuWhenBlackScreenIsInactive)
         {
            this.goToMainMenu();
            this._returnToMainMenuWhenBlackScreenIsInactive = false;
         }
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
      
      public function addScreen(param1:String, param2:Boolean = true, param3:Class = null, param4:Array = null) : void
      {
         if(this[param1] == null)
         {
            switch(param1)
            {
               case SCR_WELCOME_BACKGROUND:
                  this.screenWelcomeBackground = new BMScreenWelcomeBackground();
                  break;
               case SCR_ECONOMY_GOLD_CONVERSION:
                  this.screenNewEconomyGoldConvertion = new BMScreenNewEconomyGoldConvertion();
                  break;
               case SCR_CONVERT_LEGACY_ITEMS:
                  this.screenConvertLegacyItems = new BMScreenConvertLegacyItems();
                  break;
               case SCR_CAMPAIGNS_MENU:
                  this.screenCampaignsMenu = new BMScreenCampaignsMenu();
                  break;
               case SCR_SELECT_BATTLE_MECHS_PER_PLAYER:
                  this.screenSelectBattleMechsPerPlayer = new BMScreenSelectBattleMechsPerPlayer();
                  break;
               case SCR_WELCOME_LOGIN:
                  this.screenWelcomeLogin = new BMScreenWelcomeLogin();
                  break;
               case SCR_SUPPORT_TICKET:
                  this.screenSupportTicket = new BMScreenSupportTicket();
                  break;
               case SCR_WELCOME_LOGIN_AS:
                  this.screenWelcomeLoginAs = new BMScreenWelcomeLoginAs();
                  break;
               case SCR_WELCOME_LOGIN_WARNING:
                  this.screenWelcomeLoginWarning = new BMScreenWelcomeLoginWarning();
                  break;
               case SCR_WELCOME_NEW_EXISITNG:
                  this.screenWelcomeNewExisting = new BMScreenWelcomeNewExisting();
                  break;
               case SCR_SMTV:
                  this.screenSMTV = new BMScreenSMTV();
                  break;
               case SCR_GLOBAL_SHOP:
                  if(param3 == null)
                  {
                     this.screenGlobalShop = new BMScreenGlobalShop();
                  }
                  else
                  {
                     this.screenGlobalShop = new param3();
                  }
                  break;
               case SCR_CLAIM_MINED_TOKENS:
                  this.screenClaimMinedTokens = new BMScreenClaimMinedTokens();
                  break;
               case SCR_MORE_PAYMENT_OPTIONS:
                  this.screenMorePaymentOptions = new BMScreenMorePaymentOptions();
                  break;
               case SCR_ONE_TIME_SPECIAL_OFFERS:
                  this.screenOneTimeSpecialOffers = new BMScreenOneTimeSpecialOffers();
                  break;
               case SCR_ITEM_SPECIAL_OFFERS:
                  this.screenItemSpecialOffers = new BMScreenItemSpecialOffers();
                  break;
               case SCR_LOST_CONNECTION:
                  this.screenLostConnection = new BMScreenLostConnection();
                  break;
               case SCR_BUY_STARTER_PACK:
                  this.screenBuyStarterPack = new BMScreenBuyStarterPack();
                  break;
               case SCR_BUY_STARTER_PACK_MECH_AND_CURRENCY:
                  this.screenBuyStarterPackMechAndCurrency = new BMScreenBuyStarterPackMechAndCurrency();
                  break;
               case SCR_BUY_STARTER_PACK_MECH_ONLY:
                  this.screenBuyStarterPackMechOnly = new BMScreenBuyStarterPackMechOnly();
                  break;
               case SCR_BUY_STARTER_PACK_BOXES_AND_CURRENCY:
                  this.screenBuyStarterPackBoxesAndCurrency = new BMScreenBuyStarterPackBoxesAndCurrency();
                  break;
               case SCR_BUY_STARTER_PACK_BOXES_ONLY:
                  this.screenBuyStarterPackBoxesOnly = new BMScreenBuyStarterPackBoxesOnly();
                  break;
               case SCR_BUY_STARTER_PACK_GUARANTEED_LEGENDARY_BOX:
                  this.screenBuyStarterPackGuaranteedLegendaryBox = new BMScreenBuyStarterPackGuaranteedLegendaryBox();
                  break;
               case SCR_BUY_STARTER_PACK_IMPROVE_YOUR_MECH:
                  this.screenBuyStarterPackImproveYourMech = new BMScreenBuyStarterPackImproveYourMech();
                  break;
               case SCR_BUY_STARTER_PACK_TOKENS:
                  this.screenBuyStarterPackTokens = new BMScreenBuyStarterPackTokens();
                  break;
               case SCR_BUY_STARTER_PACK_GOLD:
                  this.screenBuyStarterPackGold = new BMScreenBuyStarterPackGold();
                  break;
               case SCR_BUY_STARTER_PACK_BUNDLE:
                  this.screenBuyStarterPackBundle = new BMScreenBuyStarterPackBundle();
                  break;
               case SCR_BUY_STARTER_PACK_GOLD_WITH_BADGE:
                  this.screenBuyStarterPackGold_withBadge = new BMScreenBuyStarterPackGold_withBadge();
                  break;
               case SCR_BUY_STARTER_PACK_TOKENS_WITH_BADGE:
                  this.screenBuyStarterPackTokens_withBadge = new BMScreenBuyStarterPackTokens_withBadge();
                  break;
               case SCR_BUY_STARTER_PACK_GOLD_AND_TOKENS:
                  this.screenBuyStarterPackGoldAndTokens = new BMScreenBuyStarterPackGoldAndTokens();
                  break;
               case SCR_BUY_STARTER_PACK_ITEM_AND_TOKENS:
                  this.screenBuyStarterPackItemAndTokens = new BMScreenBuyStarterPackItemAndTokens();
                  break;
               case SCR_REGISTER:
                  this.screenRegister = new BMScreenRegister();
                  break;
               case SCR_REGISTER_OFFER:
                  this.screenRegisterOffer = new BMScreenRegisterOffer();
                  break;
               case SCR_MULTIPLAYER_CHAT:
                  this.screenMultiPlayerChat = new BMScreenMultiPlayerChat();
                  break;
               case SCR_MULTIPLAYER_LADDER:
                  this.screenMultiPlayerLadder = new BMScreenMultiPlayerLadder();
                  break;
               case SCR_BATTLE:
                  this.screenBattle = new BMScreenBattle();
                  break;
               case SCR_BATTLE_RESULT:
                  if(param3 == null)
                  {
                     this.screenBattleResult = new BMScreenBattleResult();
                  }
                  else
                  {
                     this.screenBattleResult = new param3();
                  }
                  break;
               case SCR_SHOP_ITEM_INFO:
                  if(param3 == null)
                  {
                     this.screenShopItemInfo = new BMScreenShopItemInfo();
                  }
                  else
                  {
                     this.screenShopItemInfo = new param3();
                  }
                  break;
               case SCR_CONFIRMATION:
                  this.screenConfirmation = new BMScreenConfirmation();
                  break;
               case SCR_BUY_CONFIRMATION:
                  this.screenBuyConfirmation = new BMScreenBuyConfirmation();
                  break;
               case SCR_EXTRA_OPTIONS:
                  this.screenExtraOptions = new BMScreenExtraOptions();
                  break;
               case SCR_INVENTORY_GRACE_PERIOD:
                  this.screenInventoryGracePeriodInfo = new BMScreenInventoryGracePeriodInfo();
                  break;
               case SCR_YES_NO_POPUP:
                  if(param3 == null)
                  {
                     this.screenYesNoPopup = new BMScreenYesNoPopup();
                  }
                  else
                  {
                     this.screenYesNoPopup = new param3();
                  }
                  break;
               case SCR_EQUIP_BETTER_ITEM_RECOMMENDATION:
                  this.screenEquipBetterItemRecommendation = new BMScreenEquipBetterItemRecommendation();
                  break;
               case SCR_BOOST_ITEM_RECOMMENDATION:
                  this.screenBoostItemRecommendation = new BMScreenBoostItemRecommendation();
                  break;
               case SCR_1V1_TO_2V2_TRANSITION_WARNING:
                  this.screen1V1To2V2TransitionWarning = new BMScreen1V1To2V2TransitionWarning();
                  break;
               case SCR_QUESTS:
                  this.screenQuests = new BMScreenQuests();
                  break;
               case SCR_VIP_SUBSCRIPTION_STATUS:
                  this.screenVIPSubscriptionStatus = new BMScreenVIPSubscriptionStatus();
                  break;
               case SCR_BATTLE_INTERFACE_BOTTOM:
                  this.screenBattleInterfaceBottom = new BMScreenBattleInterfaceBottom();
                  break;
               case SCR_BATTLE_INTERFACE_EMOTES:
                  this.screenBattleInterfaceEmotes = new BMScreenBattleInterfaceEmotes();
                  break;
               case SCR_BATTLE_INTERFACE_TOP:
                  this.screenBattleInterfaceTop = new BMScreenBattleInterfaceTop();
                  break;
               case SCR_RANKING_LIST:
                  this.screenRankingList = new BMScreenRankingList();
                  break;
               case SCR_SEACH_FOR_CLAN:
                  this.screenSearchForClan = new BMScreenSearchForClan();
                  break;
               case SCR_SERVER_RESTART_COUNTDOWN:
                  this.screenServerRestartCountdown = new BMScreenServerRestartCountdown();
                  break;
               case SCR_TOP_BAR:
                  if(param3 == null)
                  {
                     this.screenTopBar = new BMScreenTopBar();
                  }
                  else
                  {
                     this.screenTopBar = new param3();
                  }
                  break;
               case SCR_VS:
                  this.screenVS = new BMScreenVS();
                  break;
               case SCR_FPS_TRACKER:
                  this.screenFPSTracker = new BMScreenFPSTracker();
                  break;
               case SCR_BLACK:
                  this.screenBlack = new BMScreenBlack();
                  break;
               case SCR_REPLAYS:
                  this.screenReplays = new BMScreenReplays();
                  break;
               case SCR_SKIP_TUTORIAL:
                  this.screenSkipTutorial = new BMScreenSkipTutorial();
                  break;
               case SCR_HELP:
                  this.screenHelp = new BMScreenHelp();
                  break;
               case SCR_ADMIN_TOOLS:
                  this.screenAdminTools = new BMScreenAdminTools();
                  break;
               case SCR_ADMIN_ITEM_TIER_LIST:
                  this.screenAdminItemTierList = new BMScreenAdminItemTierList();
                  break;
               case SCR_LADDER_SEASON_INFO:
                  this.screenLadderSeasonInfo = new BMScreenLadderSeasonInfo();
                  break;
               case SCR_LADDER_SEASON_END_NEW_LADDER_PROGRESS:
                  this.screenLadderSeasonEndNewLadderProgress = new BMScreenLadderSeasonEndNewLadderProgress();
                  break;
               case SCR_LADDER_SEASON_HIGHEST_LADDER_PROGRESS:
                  this.screenLadderSeasonHighestLadderProgress = new BMScreenLadderSeasonHighestLadderProgress();
                  break;
               case SCR_LADDER_SEASON_END_REWARD:
                  this.screenLadderSeasonEndReward = new BMScreenLadderSeasonEndReward();
                  break;
               case SCR_CAMPAIGN_CHAT:
                  this.screenCampaignChat = new BMScreenCampaignChat();
                  break;
               case SCR_SPECIAL_OFFERS:
                  this.screenSpecialOffers = new param3();
                  break;
               case SCR_NEWS:
                  this.screenNews = new BMScreenNews();
                  break;
               case SCREEN_TRANSITIONS_MANAGER:
                  this.screenTransitionsManager = new BMScreenTransitionsManager();
                  break;
               case SCR_MAIN_MENU:
                  this.screenMainMenu = new BMScreenMainMenu();
                  break;
               case SCR_LEGAL_AND_TERMS:
                  this.screenLegalAndTerms = new BMScreenLegalAndTerms();
                  break;
               case SCR_BATTLE_OPTIONS:
                  this.screenBattleOptions = new BMScreenBattleOptions();
                  break;
               case SCR_PROFILE_OPTIONS:
                  this.screenProfileOptions = new BMScreenProfileOptions();
                  break;
               case SCR_PROFILE_ACCOUNTS:
                  this.screenProfileAccounts = new BMScreenProfileAccounts();
                  break;
               case SCR_INSPECT_PLAYER:
                  this.screenInspectPlayer = new BMScreenInspectPlayer();
                  break;
               case SCR_POPUP:
                  this.screenPopUp = new BMScreenPopUp();
                  break;
               case SCR_PROFILE_INFO:
                  this.screenProfileInfo = new BMScreenProfileInfo();
                  break;
               case SCR_QUEST_STATUS_UPDATE:
                  this.screenQuestStatusUpdate = new BMScreenQuestStatusUpdate();
                  break;
               case SCR_ITEM_CARDS:
                  this.screenItemCards = new BMScreenItemCards();
                  break;
               case SCR_ITEM_INFO:
                  this.screenItemInfo = new BMScreenItemInfo();
                  break;
               case SCR_HANGER_UPGRADE:
                  this.screenHangerUpgrade = new BMScreenHangerUpgrade();
                  break;
               case SCR_WORKSHOP:
                  this.screenWorkshop = new BMScreenWorkshop();
                  break;
               case SCR_HANGER_TRANSFORM_COMPLETE:
                  this.screenHangerTransformComplete = new BMScreenHangerTransformComplete();
                  break;
               case SCR_HANGER_BOOST_COMPLETE:
                  this.screenHangerBoostComplete = new BMScreenHangerBoostComplete();
                  break;
               case SCR_HANGER_UPGRADE_MASS_SELECTION:
                  this.screenHangerUpgradeMassSelection = new BMScreenHangerUpgradeMassSelection();
                  break;
               case SCR_HANGER_TRANSFORM_PREVIEW:
                  this.screenHangerTransformPreview = new BMScreenHangerTransformPreview();
                  break;
               case SCR_MENU_MULTIPLAYER_INSPECT:
                  this.screenMenuMultiPlayerInspect = new BMScreenMenuMultiPlayerInspect();
                  break;
               case SCR_LADDER_STATUS:
                  this.screenLadderStatus = new BMScreenLadderStatus();
                  break;
               case SCR_LEVEL_UP_NEW:
                  this.screenLevelUpNew = new BMScreenLevelUpNew();
                  break;
               case SCR_WEB_VIEW:
                  this.screenWebView = new BMScreenWebView();
                  break;
               case SCR_INVENTORY_EXPAND:
                  this.screenInventoryExpand = new BMScreenInventoryExpand();
                  break;
               case SCR_INVENTORY_FULL:
                  this.screenInventoryFull = new BMScreenInventoryFull();
                  break;
               case SCR_GET_ITEMS_NO_SPACE:
                  this.screenGetItemsNoSpace = new BMScreenGetItemsNoSpace();
                  break;
               case SCR_UNCLAIMED_BOXES:
                  this.screenUnclaimedBoxes = new BMScreenUnclaimedBoxes();
                  break;
               case SCR_BETA_OPT_IN:
                  this.screenBetaOptIn = new BMScreenBetaOptIn();
                  break;
               case SCR_CLAN_CREATE:
                  this.screenClanCreate = new BMScreenClanCreate();
                  break;
               case SCR_CLAN_MENU:
                  this.screenClanMenu = new BMScreenClanMenu();
                  break;
               case SCR_CLAN_CHAT:
                  this.screenClanChat = new BMScreenClanChat();
                  break;
               case SCR_CLAN_MEMBERS:
                  this.screenClanMembers = new BMScreenClanMembers();
                  break;
               case SCR_CLAN_BOSS:
                  this.screenClanBoss = new BMScreenClanBoss();
                  break;
               case SCR_CLAN_BOSS_CLAIM_REWARD:
                  this.screenClanBossClaimReward = new BMScreenClanBossClaimReward();
                  break;
               case SCR_CLAN_SHOP:
                  this.screenClanShop = new BMScreenClanShop();
                  break;
               case SCR_CLAN_BOSS_MISSION_DETAILS:
                  this.screenClanBossMissionDetails = new BMScreenClanBossMissionDetails();
                  break;
               case SCR_CLAN_WAR_JOIN:
                  this.screenClanWarJoin = new BMScreenClanWarJoin();
                  break;
               case SCR_CLAN_WAR_PREPARATION:
                  this.screenClanWarPreparation = new BMScreenClanWarPreparation();
                  break;
               case SCR_CLAN_WAR_BATTLE:
                  this.screenClanWarBattle = new BMScreenClanWarBattle();
                  break;
               case SCR_CLAN_WAR_BASE:
                  this.screenClanWarBase = new BMScreenClanWarBase();
                  break;
               case SCR_CLAN_WAR_LAST_WAR:
                  this.screenClanWarLastWar = new BMScreenClanWarLastWar();
                  break;
               case SCR_CLAN_WAR_INSPECT_PLAYER:
                  if(param3 == null)
                  {
                     this.screenClanWarInspectPlayer = new BMScreenClanWarInspectPlayer();
                  }
                  else
                  {
                     this.screenClanWarInspectPlayer = new param3();
                  }
                  break;
               case SCR_CLAN_SETTINGS:
                  this.screenClanSettings = new BMScreenClanSettings();
                  break;
               case SCR_CHANGE_NAME:
                  this.screenChangeName = new BMScreenChangeName();
                  break;
               case SCR_OPENING_SEQUENCE:
                  this.screenOpeningSequence = new BMScreenOpeningSequence();
                  break;
               case SCR_CAMPAIGN_OPENING_SEQUENCE:
                  this.screenCampaignOpeningSequence = new BMScreenCampaignOpeningSequence();
                  break;
               case SCR_CAMPAIGN_ENDING_SEQUENCE:
                  this.screenCampaignEndingSequence = new BMScreenCampaignEndingSequence();
                  break;
               case SCR_CHANGE_MECHS_ORDER:
                  this.screenChangeMechsOrder = new BMScreenChangeMechsOrder();
                  break;
               case SCR_DAILY_LOGIN_STREAK_BONUS:
                  this.screenDailyLoginStreakBonus = new BMScreenDailyLoginStreakBonus();
                  break;
               case SCR_MISSION_BASE_MAP:
                  this.screenMissionBaseMap = new BMScreenMissionBaseMap();
                  break;
               case SCR_MISSION_WORLD_MAP:
                  this.screenMissionWorldMap = new BMScreenMissionWorldMap();
                  break;
               case SCR_DISPLAY_REWARD:
                  this.screenDisplayReward = new BMScreenDisplayReward();
                  break;
               case SCR_DIFFICULTY_UNLOCKED:
                  this.screenDifficultyUnlocked = new BMScreenDifficultyUnlocked();
                  break;
               case SCR_SEARCH_FOR_PLAYER:
                  this.screenSearchForPlayer = new BMScreenSearchForPlayer();
                  break;
               case SCR_YOUTUBE_VIDS_GUID:
                  this.screenYouTubeVidsGuide = new BMScreenYouTubeVidsGuide();
                  break;
               case SCR_SELECT_ACCOUNT:
                  this.screenSelectAccount = new BMScreenSelectAccount();
                  break;
               case SCR_WATCH_REWARDED_VIDEO:
                  this.screenWatchRewardedVideo = new BMScreenWatchRewardedVideo();
                  break;
               case SCR_RAID_BATTLE:
                  this.screenRaidBattle = new BMScreenRaidBattle();
                  break;
               case SCR_RAID_LEADERBOARD:
                  this.screenRaidLeaderboard = new BMScreenRaidLeaderboard();
                  break;
               case SCR_RAID_MENU:
                  this.screenRaidMenu = new BMScreenRaidMenu();
                  break;
               case SCR_RAID_CLAIM_REWARD:
                  this.screenRaidClaimReward = new BMScreenRaidClaimReward();
                  break;
               case SCR_RAID_RULES:
                  this.screenRaidRules = new BMScreenRaidRules();
                  break;
               case SCR_LAUNCH_NUKES:
                  this.screenLaunchNukes = new BMScreenLaunchNukes();
                  break;
               case SCR_CONTENT_PACK_LIBRARY:
                  this.screenContentPackLibrary = new BMScreenContentPackLibrary();
                  break;
               case SCR_CONTENT_PACK_ITEM_INFO:
                  this.screenContentPackItemInfo = new BMScreenContentPackItemInfo();
                  break;
               case SCR_ARENA_SHOP:
                  this.screenArenaShop = new BMScreenArenaShop();
                  break;
               case SCR_BASE_BUILDING_MAIN:
                  this.screenBaseBuildingMain = new BMScreenBaseBuildingMain();
                  break;
               case SCR_BASE_BUILDING_STRUCTURES_MENU:
                  this.screenBaseBuildingStructuresMenu = new BMScreenBaseBuildingStructuresMenu();
                  break;
               case SCR_BASE_BUILDING_ITEM_FACTORY:
                  this.screenBaseBuildingItemFactory = new BMScreenBaseBuildingItemFactory();
                  break;
               case SCR_BASE_BUILDING_STRUCTURE_INFO:
                  this.screenBaseBuildingStructureInfo = new BMScreenBaseBuildingStructureInfo();
                  break;
               case SCR_LOAD_EXTERNAL_LIBRARY:
                  this.screenLoadExternalLibrary = new BMScreenLoadExternalLibrary();
                  break;
               case SCR_MECH_BUILDS:
                  this.screenMechBuilds = new BMScreenMechBuilds();
                  break;
               case SCR_LANGUAGE_SELECTION:
                  this.screenLanguageSelection = new BMScreenLanguageSelection();
                  break;
               case SCR_RECONNECTING:
                  this.screenReconnecting = new BMScreenReconnecting();
                  break;
               case SCR_FILL_BATTLE_CREDITS:
                  this.screenFillBattleCredits = new BMScreenFillBattleCredits();
                  break;
               case SCR_BATTLE_CREDITS_FULL:
                  this.screenBattleCreditsFull = new BMScreenBattleCreditsFull();
                  break;
               case SCR_KIN_SHOP:
                  this.screenKinShop = new BMScreenKinShop();
                  break;
               case SCR_DEBUGGER:
                  this.screenDebugger = new BMScreenDebugger();
                  break;
               case SCR_MECH_GENERATOR:
                  this.screenMechGenerator = new BMScreenMechGenerator();
            }
            this[param1].name = param1;
            if(param4 != null)
            {
               if(param4.length == 1)
               {
                  this[param1].initialize(param4[0]);
               }
            }
            else
            {
               this[param1].initialize();
            }
            BMPubSub.pub(BMPubSub.MESSAGE_SCREEN_OPENED,{"screen":param1});
         }
         if(param2 && this[param1].parent == null)
         {
            this.addScreenIntoLayer(param1);
            this.openedScrenes[param1] = param1;
            this.refreshSecondaryBattleScreensCheck();
            this.traceOpenedScreens("addScreen");
         }
      }
      
      public function readdScreenIntoTopLayer(param1:String) : void
      {
         if(this[param1] == null)
         {
            return;
         }
         if(this[param1].parent == null)
         {
            return;
         }
         this[param1].parent.removeChild(this[param1]);
         this.topLayer.addChild(this[param1]);
      }
      
      private function addScreenIntoLayer(param1:String) : void
      {
         TsLogger.log("BMScreensManager - addScreenIntoLayer( " + param1 + " )");
         switch(param1)
         {
            case SCR_CONFIRMATION:
            case SCR_DEBUGGER:
            case SCR_QUEST_STATUS_UPDATE:
            case SCR_BLACK:
            case SCR_LOST_CONNECTION:
            case SCR_SERVER_RESTART_COUNTDOWN:
            case SCR_RECONNECTING:
            case SCR_ECONOMY_GOLD_CONVERSION:
            case SCR_LANGUAGE_SELECTION:
            case SCR_YES_NO_POPUP:
            case SCR_EQUIP_BETTER_ITEM_RECOMMENDATION:
            case SCR_BOOST_ITEM_RECOMMENDATION:
            case SCR_1V1_TO_2V2_TRANSITION_WARNING:
            case SCR_SELECT_ACCOUNT:
            case SCR_GET_ITEMS_NO_SPACE:
            case SCR_CAMPAIGN_CHAT:
            case SCR_MENU_MULTIPLAYER_INSPECT:
            case SCR_INSPECT_PLAYER:
            case SCR_SELECT_BATTLE_MECHS_PER_PLAYER:
               this.superTopLayer.addChild(this[param1]);
               break;
            case SCR_LOAD_EXTERNAL_LIBRARY:
               addChild(this[param1]);
               break;
            case SCR_SUPPORT_TICKET:
            case SCR_BUY_CONFIRMATION:
            case SCR_DISPLAY_REWARD:
            case SCR_DIFFICULTY_UNLOCKED:
            case SCR_LEVEL_UP_NEW:
            case SCR_WEB_VIEW:
            case SCR_BETA_OPT_IN:
            case SCR_INVENTORY_EXPAND:
            case SCR_INVENTORY_FULL:
            case SCR_UNCLAIMED_BOXES:
            case SCR_BATTLE_OPTIONS:
            case SCR_ITEM_CARDS:
            case SCR_ITEM_INFO:
            case SCR_POPUP:
            case SCR_GLOBAL_SHOP:
            case SCR_CLAIM_MINED_TOKENS:
            case SCR_MORE_PAYMENT_OPTIONS:
            case SCR_ONE_TIME_SPECIAL_OFFERS:
            case SCR_ITEM_SPECIAL_OFFERS:
            case SCR_CLAN_CREATE:
            case SCR_CHANGE_NAME:
            case SCR_OPENING_SEQUENCE:
            case SCR_CAMPAIGN_OPENING_SEQUENCE:
            case SCR_CAMPAIGN_ENDING_SEQUENCE:
            case SCR_EXTRA_OPTIONS:
            case SCR_INVENTORY_GRACE_PERIOD:
            case SCR_CHANGE_MECHS_ORDER:
            case SCR_YOUTUBE_VIDS_GUID:
            case SCR_SHOP_ITEM_INFO:
            case SCR_WATCH_REWARDED_VIDEO:
            case SCR_MECH_GENERATOR:
            case SCR_WELCOME_LOGIN_AS:
            case SCR_WELCOME_LOGIN_WARNING:
            case SCR_HANGER_TRANSFORM_PREVIEW:
            case SCR_ADMIN_ITEM_TIER_LIST:
            case SCR_LADDER_SEASON_INFO:
            case SCR_LADDER_SEASON_END_NEW_LADDER_PROGRESS:
            case SCR_LADDER_SEASON_HIGHEST_LADDER_PROGRESS:
            case SCR_LADDER_SEASON_END_REWARD:
            case SCR_REGISTER:
            case SCR_VS:
            case SCR_BATTLE_RESULT:
            case SCR_LADDER_STATUS:
            case SCR_FILL_BATTLE_CREDITS:
            case SCR_BATTLE_CREDITS_FULL:
            case SCR_LEGAL_AND_TERMS:
            case SCR_CONVERT_LEGACY_ITEMS:
            case SCR_CAMPAIGNS_MENU:
            case SCR_RAID_CLAIM_REWARD:
            case SCR_CONTENT_PACK_LIBRARY:
            case SCR_CONTENT_PACK_ITEM_INFO:
            case SCR_HANGER_UPGRADE_MASS_SELECTION:
            case SCR_VIP_SUBSCRIPTION_STATUS:
            case SCR_CLAN_BOSS_CLAIM_REWARD:
            case SCR_CLAN_BOSS_MISSION_DETAILS:
            case SCR_LAUNCH_NUKES:
            case SCR_MECH_BUILDS:
            case SCR_CLAN_WAR_LAST_WAR:
            case SCR_CLAN_WAR_INSPECT_PLAYER:
               this.topLayer.addChild(this[param1]);
               break;
            case SCR_QUESTS:
            case SCR_TOP_BAR:
            case SCR_SKIP_TUTORIAL:
            case SCR_SEARCH_FOR_PLAYER:
            case SCR_MENU_MULTIPLAYER_INSPECT:
            case SCR_MAIN_MENU:
            case SCR_HANGER_UPGRADE:
            case SCR_WORKSHOP:
            case SCR_SPECIAL_OFFERS:
            case SCR_HANGER_TRANSFORM_COMPLETE:
            case SCR_HANGER_BOOST_COMPLETE:
            case SCR_RAID_BATTLE:
            case SCR_RAID_LEADERBOARD:
            case SCR_RAID_MENU:
            case SCR_RAID_RULES:
            case SCR_CLAN_MENU:
            case SCR_CLAN_CHAT:
            case SCR_CLAN_MEMBERS:
            case SCR_CLAN_BOSS:
            case SCR_CLAN_SHOP:
            case SCR_KIN_SHOP:
            case SCR_CLAN_WAR_JOIN:
            case SCR_CLAN_WAR_PREPARATION:
            case SCR_CLAN_WAR_BATTLE:
            case SCR_CLAN_WAR_BASE:
            case SCR_CLAN_SETTINGS:
            case SCR_ARENA_SHOP:
            case SCR_BASE_BUILDING_MAIN:
            case SCR_BASE_BUILDING_STRUCTURES_MENU:
            case SCR_BASE_BUILDING_ITEM_FACTORY:
            case SCR_BASE_BUILDING_STRUCTURE_INFO:
               this.middleLayer.addChild(this[param1]);
               break;
            default:
               this.bottomLayer.addChild(this[param1]);
         }
      }
      
      public function removeScreen(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:BMBaseScreen = null;
         if(this[param1] != null)
         {
            _loc3_ = this[param1];
            _loc3_.notifyRemoved();
            if(_loc3_.parent != null)
            {
               _loc3_.parent.removeChild(this[param1]);
            }
            this.openedScrenes[_loc3_.name] = "";
            this.refreshSecondaryBattleScreensCheck();
            this.traceOpenedScreens("removeScreen");
            switch(_loc3_.name)
            {
               case SCR_CONFIRMATION:
               case SCR_DEBUGGER:
                  this.screenConfirmation.removeMe();
                  break;
               default:
                  this[param1] = null;
            }
            BMPubSub.pub(BMPubSub.MESSAGE_SCREEN_CLOSED,{"screen":param1});
            if(param2 == true)
            {
               this.disableNextClickForMobile = true;
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
         this.removeScreen(SCR_WELCOME_BACKGROUND);
         this.addScreen(SCR_WELCOME_BACKGROUND);
         this.screenWelcomeBackground.refreshScreen(true);
         this.screenWelcomeBackground.resetWelcomeBack();
      }
      
      private function resetScreens() : void
      {
         if(this.screenTransitionsManager != null)
         {
            this.screenTransitionsManager.removeCurrentScreen();
            this.screenTransitionsManager.reset();
            this.screenTransitionsManager.removeMe();
         }
         if(this.isScreenOpened(SCR_BATTLE))
         {
            if(this.isScreenOpened(SCR_LADDER_STATUS))
            {
               this.removeScreen(SCR_LADDER_STATUS);
            }
            if(this.isScreenOpened(SCR_BATTLE_RESULT))
            {
               this.screenBattleResult.removeMe();
            }
            this.screenBattle.cleanBattle(true);
            this.removeScreen(SCR_BATTLE_OPTIONS);
            if(this.isScreenOpened(SCR_MISSION_BASE_MAP))
            {
               this.screenMissionBaseMap.removeMe();
               if(this.isScreenOpened(SCR_DISPLAY_REWARD))
               {
                  this.screenDisplayReward.removeMe();
               }
            }
         }
         else if(this.isScreenOpened(SCR_WELCOME_BACKGROUND))
         {
            if(this.isScreenOpened(SCR_DAILY_LOGIN_STREAK_BONUS))
            {
               this.screenDailyLoginStreakBonus.removeMe();
            }
            if(this.isScreenOpened(SCR_DISPLAY_REWARD))
            {
               this.screenDisplayReward.removeMe();
            }
            if(this.isScreenOpened(SCR_CHANGE_NAME))
            {
               this.screenChangeName.removeMe();
            }
         }
         else if(this.isScreenOpened(SCR_MISSION_BASE_MAP))
         {
            this.screenMissionBaseMap.removeMe();
            if(this.isScreenOpened(SCR_DISPLAY_REWARD))
            {
               this.screenDisplayReward.removeMe();
            }
            this.removeScreen(SCR_TOP_BAR);
         }
         else if(this.getBuyStarterPackScreenName() != "")
         {
            this.getBuyStarterPackScreen().closeScreen();
            this.removeScreen(this.getBuyStarterPackScreenName());
            this.removeScreen(SCR_TOP_BAR);
         }
         else if(this.isScreenOpened(SCR_MULTIPLAYER_LADDER))
         {
            if(screensM.isScreenOpened(BMScreensManager.SCR_LADDER_SEASON_END_NEW_LADDER_PROGRESS))
            {
               screensM.screenLadderSeasonEndNewLadderProgress.removeMe();
            }
            if(screensM.isScreenOpened(BMScreensManager.SCR_LADDER_SEASON_END_REWARD))
            {
               screensM.screenLadderSeasonEndReward.removeMe();
            }
            if(screensM.isScreenOpened(BMScreensManager.SCR_LADDER_SEASON_HIGHEST_LADDER_PROGRESS))
            {
               screensM.screenLadderSeasonHighestLadderProgress.removeMe();
            }
            this.removeScreen(SCR_MULTIPLAYER_LADDER);
         }
         if(this.isScreenOpened(SCR_RAID_MENU))
         {
            this.screenRaidMenu.removeMe();
         }
         if(this.isScreenOpened(SCR_SERVER_RESTART_COUNTDOWN))
         {
            this.removeScreen(SCR_SERVER_RESTART_COUNTDOWN);
         }
         if(this.isScreenOpened(SCR_GLOBAL_SHOP))
         {
            this.screenGlobalShop.closeClicked();
         }
         if(this.isScreenOpened(SCR_INSPECT_PLAYER))
         {
            this.screenInspectPlayer.backClicked();
         }
         if(this.isScreenOpened(SCR_CONTENT_PACK_LIBRARY))
         {
            this.screenContentPackLibrary.removeMe();
         }
         if(this.isScreenOpened(SCR_KIN_SHOP))
         {
            this.screenKinShop.removeMe();
         }
         this.removeScreen(SCR_MECH_BUILDS);
         this.removeScreen(SCR_LAUNCH_NUKES);
         this.removeScreen(SCR_LOST_CONNECTION);
         this.removeScreen(SCR_ADMIN_TOOLS);
         this.removeScreen(SCR_ADMIN_ITEM_TIER_LIST);
         this.removeScreen(SCR_LADDER_SEASON_INFO);
         this.removeScreen(SCR_LADDER_SEASON_END_NEW_LADDER_PROGRESS);
         this.removeScreen(SCR_LADDER_SEASON_HIGHEST_LADDER_PROGRESS);
         this.removeScreen(SCR_LADDER_SEASON_END_REWARD);
         this.removeScreen(SCR_CONFIRMATION);
         this.removeScreen(SCR_WELCOME_NEW_EXISITNG);
         this.removeScreen(SCR_POPUP);
         this.removeScreen(SCR_LEVEL_UP_NEW);
         this.removeScreen(SCR_WEB_VIEW);
         this.removeScreen(SCR_INVENTORY_EXPAND);
         this.removeScreen(SCR_BETA_OPT_IN);
         this.removeScreen(SCR_INVENTORY_FULL);
         this.removeScreen(SCR_GET_ITEMS_NO_SPACE);
         this.removeScreen(SCR_UNCLAIMED_BOXES);
         this.removeScreen(SCR_MAIN_MENU);
         this.removeScreen(SCR_LEGAL_AND_TERMS);
         this.removeScreen(SCR_PROFILE_ACCOUNTS);
         tooltip.hideToolTip();
         if(this.isScreenOpened(SCR_WELCOME_LOGIN))
         {
            this.removeScreen(SCR_WELCOME_LOGIN);
         }
         this.removeScreen(SCR_SUPPORT_TICKET);
         BMSpecialOffersManager.gi().removeSpecialOffer();
         this.removeScreen(SCR_GLOBAL_SHOP);
         this.removeScreen(SCR_QUESTS);
         this.removeScreen(SCR_VIP_SUBSCRIPTION_STATUS);
         this.removeScreen(SCR_WELCOME_LOGIN_WARNING);
         this.removeScreen(SCR_DIFFICULTY_UNLOCKED);
         this.removeScreen(SCR_ONE_TIME_SPECIAL_OFFERS);
         this.removeScreen(SCR_ITEM_SPECIAL_OFFERS);
      }
      
      public function resetClient() : void
      {
         BMLoginManager.gi().disconnect();
         this.resetScreens();
         externalAssetsM.resetExternalLibraryParams();
         dataM.battle_gamePaused = false;
         dataM.battle_syncData = new Object();
         dataM.premiumAccountTime = 0;
         dataM.register_termsOfUseChecked = false;
         dataM.mission_battleEnded = false;
         dataM.mechEquipment_playerItemIDsUpgraded = new Object();
         dataM.onlinePlayersInspect_playerID = 0;
         dataM.mechBuildsM.resetOnLogout();
         if(dataM.chatData.initialized)
         {
            dataM.chatData.initialized = false;
            dataM.chatData.initialize();
         }
         dataM.missionWorldMap_lastBossDialogShown = -1;
         dataM.replays_loaded = false;
         dataM.topBar_levelUpInProgress = false;
         dataM.nextWeeklyReset = "";
         dataM.chatData.amIBannedFromChat = false;
         dataM.clanWarsM.didQuitAClanThisSession = false;
         dataM.userAutopilot = false;
         dataM.lastUserAutopilotInCampaign = false;
         dataM.generalSpeedRatio = BMDataManager.GENERAL_SPEED_RATIO_NORMAL;
         dataM.lastGeneralSpeedRatioInCampaign = BMDataManager.GENERAL_SPEED_RATIO_NORMAL;
         dataM.battleCreditsManager.deactivateMe();
         dataM.rankingList_allTime = null;
         dataM.rankingList_weekly = null;
         dataM.rankingList_online = null;
         dataM.getTokens_displayAfterOnlineBattleCounter = 0;
         dataM.getTokens_displayAfterSinglePlayerMissionCounter = 0;
         dataM.starterPack_displayAfterOnlineBattleCounter = 3;
         dataM.starterPack_displayAfterSinglePlayerMissionCounter = 3;
         dataM.callingRankingListEnabled = true;
         dataM.chatData.battleInvitations = new Object();
         dataM.chatData.blockedBattleInvitations = new Object();
         dataM.chatData.clanInvitations = new Object();
         dataM.tutorialSkipped = false;
         dataM.chatData.battleInvitationsEnabled = true;
         dataM.battle_goToChatAfterBattle = false;
         dataM.battle_inviteToClanAfterBattle = false;
         dataM.userID = 0;
         dataM.advertisingCampaignID = 0;
         dataM.avatarLink = "";
         dataM.newItemsCreated = new Array();
         dataM.clansAroundMyLadderProgress = new Object();
         dataM.newsHandler.resetNewsDisplayedThisSession();
         dataM.minedTokens_mainMenuAvailabilityChecks = 0;
         dataM.minedTokens_showIndicatorInShopTab = false;
         dataM.mainMenuLastMechID = -1;
         dataM.mainMenuLastMechDisplayPowerRating = -1;
         this._returnToMainMenuWhenBlackScreenIsInactive = false;
         if(dataM.battleCreditsManager != null)
         {
            dataM.battleCreditsManager.clearBattleCreditsChangeCallbacks();
         }
         this.screenConfirmation.resetUrgentMessage();
         dataM.cancelTokenPolling();
         BMLoginManager.gi().reset();
         tutorialM.onlyClickableMovieClip = null;
      }
      
      private function refreshSecondaryBattleScreensCheck() : void
      {
         this.secondaryBattleScreensOpened = false;
         if(this.isScreenOpened(SCR_VS) || this.isScreenOpened(SCR_BATTLE_OPTIONS) || this.isScreenOpened(SCR_CONFIRMATION) || this.isScreenOpened(SCR_BATTLE_RESULT) || this.isScreenOpened(SCR_POPUP))
         {
            this.secondaryBattleScreensOpened = true;
         }
         this.secondaryBattleScreensOpenedIgnoringBattleBonus = false;
         if(this.isScreenOpened(SCR_VS) || this.isScreenOpened(SCR_BATTLE_OPTIONS) || this.isScreenOpened(SCR_CONFIRMATION) || this.isScreenOpened(SCR_BATTLE_RESULT) || this.isScreenOpened(SCR_POPUP))
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
      
      public function isBuyStarterPackOpened() : Boolean
      {
         var _loc2_:String = null;
         var _loc1_:uint = 0;
         while(_loc1_ < allStarterPackScreenNames.length)
         {
            _loc2_ = allStarterPackScreenNames[_loc1_];
            if(this.isScreenOpened(_loc2_))
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function getBuyStarterPackScreenName() : String
      {
         var _loc2_:String = null;
         var _loc1_:uint = 0;
         while(_loc1_ < allStarterPackScreenNames.length)
         {
            _loc2_ = allStarterPackScreenNames[_loc1_];
            if(this.isScreenOpened(_loc2_))
            {
               return _loc2_;
            }
            _loc1_++;
         }
         return "";
      }
      
      public function getBuyStarterPackScreen() : BMScreenBuyStarterPack
      {
         var _loc1_:String = this.getBuyStarterPackScreenName();
         if(_loc1_ == "")
         {
            return null;
         }
         return this[_loc1_];
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
      
      public function getOpenedScreens(param1:Array = null) : Array
      {
         var _loc3_:String = null;
         var _loc2_:Array = [];
         if(param1 == null)
         {
            param1 = [];
         }
         for each(_loc3_ in this.openedScrenes)
         {
            if(_loc3_ != "" && param1.indexOf(_loc3_) == -1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function openWebView(param1:String) : void
      {
         var _loc2_:URLRequest = null;
         if(BMScreenWebView.isSupported())
         {
            this.addScreen(SCR_WEB_VIEW);
            this.screenWebView.show(param1);
         }
         else
         {
            _loc2_ = new URLRequest(param1);
            navigateToURL(_loc2_,"_blank");
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
      
      public function getTopMostScreen() : BMBaseScreen
      {
         var _loc1_:String = this.getTopMostScreenName();
         if(_loc1_ != null)
         {
            return this[_loc1_];
         }
         return null;
      }
      
      public function getTopMostScreenName() : String
      {
         var _loc2_:String = null;
         var _loc1_:Array = this.getTargetScreens();
         if(_loc1_.length > 0)
         {
            return _loc1_[_loc1_.length - 1];
         }
         return null;
      }
      
      public function activateFullScreenMode() : void
      {
      }
      
      public function activateWindowMode() : void
      {
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
         this.removeScreen(SCR_DEBUGGER);
         this.addScreen(SCR_DEBUGGER);
         this.screenDebugger.refreshScreen();
      }
      
      public function displayMessageWhenScreenIsOpened(param1:String, param2:String) : *
      {
         var tokenHolder:Object = null;
         var handlerFunction:Function = null;
         var pubsubToken:int = 0;
         var $screenName:String = param1;
         var $message:String = param2;
         if(this.isScreenOpened($screenName))
         {
            this.screenConfirmation.displayCustomMessage($message);
         }
         else
         {
            tokenHolder = new Object();
            handlerFunction = function(param1:*, param2:*):void
            {
               if(param2.screen == $screenName)
               {
                  screenConfirmation.displayCustomMessage($message);
                  BMPubSub.remove(tokenHolder.token);
               }
            };
            pubsubToken = BMPubSub.sub(BMPubSub.MESSAGE_SCREEN_OPENED,handlerFunction);
            tokenHolder.token = pubsubToken;
         }
      }
   }
}

