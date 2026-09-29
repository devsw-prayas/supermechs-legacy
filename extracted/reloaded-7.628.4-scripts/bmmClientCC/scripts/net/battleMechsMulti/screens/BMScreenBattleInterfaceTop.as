package net.battleMechsMulti.screens
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   import net.battleMechsMulti.data.BattleTypeResolver;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMAvatarImage;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMBattleTurnData;
   import net.battleMechsMulti.mobiles.BMChatBubble;
   import net.battleMechsMulti.mobiles.BMClanFlag;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMItemData;
   import net.battleMechsMulti.mobiles.BMMechBattleData;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerItemData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureC;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureI;
   import net.battleMechsMulti.screens.battle.BMBattleTimerDisplay;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3799")]
   public class BMScreenBattleInterfaceTop extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcAvatarsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var mcInterfaceBitmapsHolder:Sprite;
      
      public var mcViewScaleIndicator:Sprite;
      
      public var mcBattleTooltipHolder:Sprite;
      
      public var mcEmotesAnimationHolder:Sprite;
      
      public var mcSizer_btnZoomOut:Sprite;
      
      public var mcSizer_btnZoomIn:Sprite;
      
      public var mcSizer_btnQuit:Sprite;
      
      public var mcSizer_btnOptions:Sprite;
      
      public var mcSizer_btnChatEnable:Sprite;
      
      public var mcSizer_btnChatDisable:Sprite;
      
      public var mcSizer_btnEmotesOpen:Sprite;
      
      public var mcSizer_btnEmotesClose:Sprite;
      
      public var mcSizer_btnPauseReplay:Sprite;
      
      public var mcSizer_btnPlayReplay:Sprite;
      
      public var mcP1BulletsBarPosition:Sprite;
      
      public var mcP1RocketsBarPosition:Sprite;
      
      public var mcP2BulletsBarPosition:Sprite;
      
      public var mcP2RocketsBarPosition:Sprite;
      
      public var player1AvatarSizer:Sprite;
      
      public var player1IconHeatSizer:Sprite;
      
      public var player1IconEnergySizer:Sprite;
      
      public var player1IconBulletsSizer:Sprite;
      
      public var player1IconRocketsSizer:Sprite;
      
      public var player1IconRankSizer:Sprite;
      
      public var player1ClanFlagSizer:Sprite;
      
      public var player2AvatarSizer:Sprite;
      
      public var player2IconHeatSizer:Sprite;
      
      public var player2IconEnergySizer:Sprite;
      
      public var player2IconBulletsSizer:Sprite;
      
      public var player2IconRocketsSizer:Sprite;
      
      public var player2IconRankSizer:Sprite;
      
      public var player2ClanFlagSizer:Sprite;
      
      public var player2ModuleSizer:Sprite;
      
      public var player1IconHeat:MovieClip;
      
      public var player1IconEnergy:MovieClip;
      
      public var player1IconBullets:MovieClip;
      
      public var player1IconRockets:MovieClip;
      
      public var player2IconHeat:MovieClip;
      
      public var player2IconEnergy:MovieClip;
      
      public var player2IconBullets:MovieClip;
      
      public var player2IconRockets:MovieClip;
      
      public var player1Overheat:MovieClip;
      
      public var player2Overheat:MovieClip;
      
      public var player1HPBar:BMBar;
      
      public var player1EnergyBar:BMBar;
      
      public var player1HeatBar:BMBar;
      
      public var player2HPBar:BMBar;
      
      public var player2EnergyBar:BMBar;
      
      public var player2HeatBar:BMBar;
      
      public var player1BulletsRoundBar:BMRoundBar;
      
      public var player1RocketsRoundBar:BMRoundBar;
      
      public var player2BulletsRoundBar:BMRoundBar;
      
      public var player2RocketsRoundBar:BMRoundBar;
      
      public var replayBar:BMBar;
      
      public var mcReplayProgressFrame:Sprite;
      
      public var txtReplayProgress:TextField;
      
      public var player1AP1:MovieClip;
      
      public var player1AP2:MovieClip;
      
      public var player1AP3:MovieClip;
      
      public var player2AP1:MovieClip;
      
      public var player2AP2:MovieClip;
      
      public var player2AP3:MovieClip;
      
      public var mcPlayer1InterfaceBackroundFront:MovieClip;
      
      public var mcPlayer2InterfaceBackroundFront:MovieClip;
      
      public var mcPlayer2InterfaceBackroundBack:Sprite;
      
      private var player1Rank:Sprite;
      
      private var player2Rank:Sprite;
      
      public var mcActionErrorMessage:MovieClip;
      
      public var mcTurnOwnerMessage:MovieClip;
      
      public var mcClock:BMBattleTimerDisplay;
      
      public var mcChat:MovieClip;
      
      public var mcChatAlert:MovieClip;
      
      public var btnZoomIn:BMButton_pictureI;
      
      public var btnZoomOut:BMButton_pictureI;
      
      public var btnQuit:BMButton_pictureC;
      
      public var btnOptions:BMButton_pictureI;
      
      public var btnChatEnable:BMButton_pictureI;
      
      public var btnChatDisable:BMButton_pictureI;
      
      public var btnEmotesOpen:BMButton_pictureI;
      
      public var btnEmotesClose:BMButton_pictureI;
      
      public var btnPauseReplay:BMButton_pictureI;
      
      public var btnPlayReplay:BMButton_pictureI;
      
      public var chatCloseButton:BMButton_pictureI;
      
      public var txtPlayer1Name:TextField;
      
      public var txtPlayer1HP:TextField;
      
      public var txtPlayer1Energy:TextField;
      
      public var txtPlayer1Heat:TextField;
      
      public var txtPlayer1Bullets:TextField;
      
      public var txtPlayer1Rockets:TextField;
      
      public var txtPlayer1Level:TextField;
      
      public var txtPlayer2Name:TextField;
      
      public var txtPlayer2HP:TextField;
      
      public var txtPlayer2Energy:TextField;
      
      public var txtPlayer2Heat:TextField;
      
      public var txtPlayer2Bullets:TextField;
      
      public var txtPlayer2Rockets:TextField;
      
      public var txtPlayer2Level:TextField;
      
      public var mcToolTip_player1_HP:Sprite;
      
      public var mcToolTip_player1_energy:Sprite;
      
      public var mcToolTip_player1_heat:Sprite;
      
      public var mcToolTip_player1_bullets:Sprite;
      
      public var mcToolTip_player1_rockets:Sprite;
      
      public var mcToolTip_player1_resist1:Sprite;
      
      public var mcToolTip_player1_resist2:Sprite;
      
      public var mcToolTip_player1_resist3:Sprite;
      
      public var mcToolTip_player1_AP:Sprite;
      
      public var mcToolTip_player1_level:Sprite;
      
      public var mcToolTip_player2_HP:Sprite;
      
      public var mcToolTip_player2_energy:Sprite;
      
      public var mcToolTip_player2_heat:Sprite;
      
      public var mcToolTip_player2_bullets:Sprite;
      
      public var mcToolTip_player2_rockets:Sprite;
      
      public var mcToolTip_player2_resist1:Sprite;
      
      public var mcToolTip_player2_resist2:Sprite;
      
      public var mcToolTip_player2_resist3:Sprite;
      
      public var mcToolTip_player2_AP:Sprite;
      
      public var mcToolTip_player2_level:Sprite;
      
      public var mcPlayer1DestroyMechBadge1:MovieClip;
      
      public var mcPlayer1DestroyMechBadge2:MovieClip;
      
      public var mcPlayer2DestroyMechBadge1:MovieClip;
      
      public var mcPlayer2DestroyMechBadge2:MovieClip;
      
      public var mcFinishMove:MovieClip;
      
      public var mcBattleAnnouncer:MovieClip;
      
      public var mcPlayer1ChatBubble:BMChatBubble;
      
      public var mcPlayer2ChatBubble:BMChatBubble;
      
      private var player1AvatarImage:BMAvatarImage;
      
      private var player2AvatarImage:BMAvatarImage;
      
      private var player1ClanFlag:BMClanFlag;
      
      private var player2ClanFlag:BMClanFlag;
      
      private var player1AvatarItem:BMItem;
      
      private var player2AvatarItem:BMItem;
      
      private var _clockTimer:Timer;
      
      private var _clockSecondsCounter:Number;
      
      private var _clockDelayTimer:Timer;
      
      private var _clockDelaySecondsCounter:Number;
      
      private var _player2InterfaceVisible:Boolean = true;
      
      private var _chatEnabled:Boolean = true;
      
      private var _player2Modules:Array = new Array();
      
      private var _turnOwnerOriginYPos:Number;
      
      private var _iconsBMD_1A:BitmapData;
      
      private var _iconsBMD_1B:BitmapData;
      
      private var _iconsBMD_2A:BitmapData;
      
      private var _iconsBMD_2B:BitmapData;
      
      private var _iconsBM_1A:Bitmap;
      
      private var _iconsBM_1B:Bitmap;
      
      private var _iconsBM_2A:Bitmap;
      
      private var _iconsBM_2B:Bitmap;
      
      private var _waitingForBattleResultActive:Boolean = false;
      
      private var _waitingForBattleResultFrameCounter:uint = 0;
      
      private var _moveScreenUp:Boolean = false;
      
      private var _firstRefresh:Boolean = true;
      
      private var _player1DestroyMechBadge1Active:Boolean;
      
      private var _player1DestroyMechBadge2Active:Boolean;
      
      private var _player2DestroyMechBadge1Active:Boolean;
      
      private var _player2DestroyMechBadge2Active:Boolean;
      
      private var _destroyMechBadges1OriginYPos:Number;
      
      private var _destroyMechBadges1TargetYPos:Number;
      
      private var _destroyMechBadges2OriginYPos:Number;
      
      private var _destroyMechBadges2TargetYPos:Number;
      
      private var _destroyMechBadgesHandlerActive:Boolean;
      
      private var _replayProgressOriginYPos:Number;
      
      private var _errorMessageOriginYPos:Number;
      
      private const TOTAL_DAMAGE_ANIMATION_FRAMES:Number = 14;
      
      private const OVERHEAT_WARNING_RATIO_SLOW:Number = 0.75;
      
      private const OVERHEAT_WARNING_RATIO_FAST:Number = 1;
      
      private const MECH_ICON_SIZE:Number = 40;
      
      private const ROWS_IN_CHAT:Number = 3;
      
      private var _announcerTween:TweenMax = null;
      
      public function BMScreenBattleInterfaceTop()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("battleInterfaceTop");
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         var _loc2_:Function = null;
         var _loc3_:Function = null;
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:Function = null;
         var _loc7_:Function = null;
         var _loc8_:Function = null;
         var _loc9_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_INTERFACE_TOP,"btnZoomIn","pictureI");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_INTERFACE_TOP,"btnZoomOut","pictureI");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_INTERFACE_TOP,"btnQuit","pictureC");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_INTERFACE_TOP,"btnOptions","pictureI");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_INTERFACE_TOP,"btnEmotesOpen","pictureI");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_INTERFACE_TOP,"btnEmotesClose","pictureI");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_INTERFACE_TOP,"btnPauseReplay","pictureI");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_INTERFACE_TOP,"btnPlayReplay","pictureI");
            _loc1_ = screensM.screenBattle.zoomClicked;
            _loc2_ = screensM.screenBattle.quitClicked;
            _loc3_ = screensM.screenBattle.optionsClicked;
            _loc4_ = this.chatEnableClicked;
            _loc5_ = this.chatDisableClicked;
            _loc6_ = this.openEmotesClicked;
            _loc7_ = this.closeEmotesClicked;
            _loc8_ = this.pauseReplayClicked;
            _loc9_ = this.playReplayClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
               _loc2_ = null;
               _loc3_ = null;
               _loc4_ = null;
               _loc5_ = null;
               _loc6_ = null;
               _loc7_ = null;
               _loc8_ = null;
               _loc9_ = null;
            }
            this.btnZoomIn.initialize("","",externalAssetsM.getAsset("general","interface_zoomIn"),null,_loc1_,dataM.runAsMobile);
            this.btnZoomOut.initialize("","",externalAssetsM.getAsset("general","interface_zoomOut"),null,_loc1_,dataM.runAsMobile);
            this.btnQuit.initialize("","",externalAssetsM.getAsset("general","interface_quit"),null,_loc2_,dataM.runAsMobile);
            this.btnOptions.initialize("","",externalAssetsM.getAsset("general","interface_options"),null,_loc3_,dataM.runAsMobile);
            this.btnEmotesOpen.initialize("","",externalAssetsM.getAsset("general","interface_emotesOpen"),null,_loc6_,dataM.runAsMobile);
            this.btnEmotesClose.initialize("","",externalAssetsM.getAsset("general","interface_emotesClose"),null,_loc7_,dataM.runAsMobile);
            this.btnPauseReplay.initialize("","",externalAssetsM.getAsset("general","interface_pause"),null,_loc8_,dataM.runAsMobile);
            this.btnPlayReplay.initialize("","",externalAssetsM.getAsset("general","interface_play"),null,_loc9_,dataM.runAsMobile);
            if(dataM.runAsMobile == false)
            {
               this.btnZoomIn.buttonCore.addMouseOverListerner(this.zoomInMouseOver);
               this.btnZoomIn.buttonCore.addMouseOutListerner(this.interfaceButtonMouseOut);
               this.btnZoomOut.buttonCore.addMouseOverListerner(this.zoomOutMouseOver);
               this.btnZoomOut.buttonCore.addMouseOutListerner(this.interfaceButtonMouseOut);
               this.btnQuit.buttonCore.addMouseOverListerner(this.quitMouseOver);
               this.btnQuit.buttonCore.addMouseOutListerner(this.interfaceButtonMouseOut);
               this.btnOptions.buttonCore.addMouseOverListerner(this.optionsMouseOver);
               this.btnOptions.buttonCore.addMouseOutListerner(this.interfaceButtonMouseOut);
               this.btnEmotesOpen.buttonCore.addMouseOverListerner(this.emotesOpenMouseOver);
               this.btnEmotesOpen.buttonCore.addMouseOutListerner(this.interfaceButtonMouseOut);
               this.btnEmotesClose.buttonCore.addMouseOverListerner(this.emotesCloseMouseOver);
               this.btnEmotesClose.buttonCore.addMouseOutListerner(this.interfaceButtonMouseOut);
               this.btnPauseReplay.buttonCore.addMouseOverListerner(this.pauseReplayMouseOver);
               this.btnPauseReplay.buttonCore.addMouseOutListerner(this.interfaceButtonMouseOut);
               this.btnPlayReplay.buttonCore.addMouseOverListerner(this.playReplayMouseOver);
               this.btnPlayReplay.buttonCore.addMouseOutListerner(this.interfaceButtonMouseOut);
            }
            this.btnZoomIn.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnZoomOut.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnQuit.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnOptions.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnEmotesOpen.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnEmotesClose.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnPauseReplay.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnPlayReplay.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.player1HPBar.initialize("yellow","right");
            this.player1EnergyBar.initialize("blue","right");
            this.player1HeatBar.initialize("orange","right");
            this.player1BulletsRoundBar.initialize();
            this.player1BulletsRoundBar.x = this.mcP1BulletsBarPosition.x;
            this.player1BulletsRoundBar.y = this.mcP1BulletsBarPosition.y;
            this.player1BulletsRoundBar.fillBar(1);
            this.player1RocketsRoundBar.initialize();
            this.player1RocketsRoundBar.x = this.mcP1RocketsBarPosition.x;
            this.player1RocketsRoundBar.y = this.mcP1RocketsBarPosition.y;
            this.player1RocketsRoundBar.fillBar(1);
            this.mcIconsHolder.addChild(this.player1BulletsRoundBar);
            this.mcIconsHolder.addChild(this.player1RocketsRoundBar);
            this.player1HPBar.addSeparateorLines(4);
            this.player1EnergyBar.addSeparateorLines(3);
            this.player1HeatBar.addSeparateorLines(3);
            this.player2HPBar.initialize("yellow","left");
            this.player2EnergyBar.initialize("blue","left");
            this.player2HeatBar.initialize("orange","left");
            this.player2BulletsRoundBar.initialize();
            this.player2BulletsRoundBar.x = this.mcP2BulletsBarPosition.x;
            this.player2BulletsRoundBar.y = this.mcP2BulletsBarPosition.y;
            this.player2BulletsRoundBar.fillBar(1);
            this.player2BulletsRoundBar.scaleX *= -1;
            this.player2RocketsRoundBar.initialize();
            this.player2RocketsRoundBar.x = this.mcP2RocketsBarPosition.x;
            this.player2RocketsRoundBar.y = this.mcP2RocketsBarPosition.y;
            this.player2RocketsRoundBar.fillBar(1);
            this.player2RocketsRoundBar.scaleX *= -1;
            this.mcIconsHolder.addChild(this.player2BulletsRoundBar);
            this.mcIconsHolder.addChild(this.player2RocketsRoundBar);
            this.player2HPBar.addSeparateorLines(4);
            this.player2EnergyBar.addSeparateorLines(3);
            this.player2HeatBar.addSeparateorLines(3);
            this.replayBar.initialize("orange","right");
            this.addIcon("player1IconHeat","icon_heat");
            this.addIcon("player1IconEnergy","icon_energy");
            this.addIcon("player1IconBullets","icon_bulletsRound",true);
            this.addIcon("player1IconRockets","icon_rocketsRound",true);
            this.addIcon("player2IconHeat","icon_heat");
            this.addIcon("player2IconEnergy","icon_energy");
            this.addIcon("player2IconBullets","icon_bulletsRound",true);
            this.addIcon("player2IconRockets","icon_rocketsRound",true);
            if(dataM.runAsMobile == false)
            {
               this.mcToolTip_player1_HP.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player1_HP.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player1_energy.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player1_energy.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player1_heat.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player1_heat.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player1_bullets.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player1_bullets.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player1_rockets.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player1_rockets.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player1_resist1.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player1_resist1.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player1_resist2.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player1_resist2.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player1_resist3.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player1_resist3.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player1_AP.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player1_AP.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player1_level.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player1_level.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player2_HP.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player2_HP.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player2_energy.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player2_energy.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player2_heat.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player2_heat.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player2_bullets.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player2_bullets.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player2_rockets.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player2_rockets.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player2_resist1.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player2_resist1.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player2_resist2.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player2_resist2.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player2_resist3.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player2_resist3.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player2_AP.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player2_AP.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
               this.mcToolTip_player2_level.addEventListener(MouseEvent.MOUSE_OVER,this.toolTipAreaMouseOver);
               this.mcToolTip_player2_level.addEventListener(MouseEvent.MOUSE_OUT,this.toolTipAreaMouseOut);
            }
            this.mcChatAlert.mouseEnabled = false;
            this.mcChatAlert.mouseChildren = false;
            this.mcFinishMove.mouseEnabled = false;
            this.mcFinishMove.mouseChildren = false;
            this.player2ModuleSizer.mouseEnabled = false;
            this.player2ModuleSizer.mouseChildren = false;
            this.mcPlayer1ChatBubble.initialize();
            this.mcPlayer2ChatBubble.initialize();
            this.mcPlayer1ChatBubble.mouseEnabled = false;
            this.mcPlayer1ChatBubble.mouseChildren = false;
            this.mcPlayer2ChatBubble.mouseEnabled = false;
            this.mcPlayer2ChatBubble.mouseChildren = false;
            this.initializeChat(true);
            this.mcViewScaleIndicator.visible = false;
            this.mcPlayer1DestroyMechBadge1.playerNumber = 1;
            this.mcPlayer1DestroyMechBadge1.badgeNumber = 1;
            this.mcPlayer1DestroyMechBadge2.playerNumber = 1;
            this.mcPlayer1DestroyMechBadge2.badgeNumber = 2;
            this.mcPlayer2DestroyMechBadge1.playerNumber = 2;
            this.mcPlayer2DestroyMechBadge1.badgeNumber = 1;
            this.mcPlayer2DestroyMechBadge2.playerNumber = 2;
            this.mcPlayer2DestroyMechBadge2.badgeNumber = 2;
            this._destroyMechBadges1OriginYPos = this.mcPlayer1DestroyMechBadge1.y - 65;
            this._destroyMechBadges1TargetYPos = this.mcPlayer1DestroyMechBadge1.y;
            this._destroyMechBadges2OriginYPos = this.mcPlayer2DestroyMechBadge2.y - 65;
            this._destroyMechBadges2TargetYPos = this.mcPlayer2DestroyMechBadge2.y;
            this._turnOwnerOriginYPos = this.mcTurnOwnerMessage.txtOwner.y;
            this._replayProgressOriginYPos = this.txtReplayProgress.y;
            this._errorMessageOriginYPos = this.mcActionErrorMessage.txtError.y;
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this._destroyMechBadgesHandlerActive = false;
         this.resetDestroyMechBadges();
      }
      
      private function languageUpdate() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("battleInterfaceTop_finishMove",[this.mcFinishMove.mcText.txtFinishMove],"",this.mcFinishMove.mcText);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent == null)
         {
            return;
         }
         this.waitingForBattleResultHandler();
         this.destroyMechBadgesHandler();
         if(this._moveScreenUp)
         {
            if(y > -180)
            {
               y -= (250 + y) * 0.05;
            }
         }
      }
      
      public function cleanTexts() : void
      {
         this.txtPlayer1Name.text = "";
         this.txtPlayer1HP.text = "";
         this.txtPlayer1Energy.text = "";
         this.txtPlayer1Heat.text = "";
         this.txtPlayer1Bullets.text = "";
         this.txtPlayer1Rockets.text = "";
         this.txtPlayer1Level.text = "";
         this.txtPlayer2Name.text = "";
         this.txtPlayer2HP.text = "";
         this.txtPlayer2Energy.text = "";
         this.txtPlayer2Heat.text = "";
         this.txtPlayer2Bullets.text = "";
         this.txtPlayer2Rockets.text = "";
         this.txtPlayer2Level.text = "";
         this.createTextsBitmapForMobile(1);
         this.createTextsBitmapForMobile(2);
      }
      
      public function createTextsBitmapForMobile(param1:Number) : void
      {
         var _loc2_:Array = null;
         if(dataM.runAsMobile)
         {
            switch(param1)
            {
               case 1:
                  _loc2_ = [this.txtPlayer1Name,this.txtPlayer1HP,this.txtPlayer1Energy,this.txtPlayer1Heat,this.txtPlayer1Bullets,this.txtPlayer1Rockets,this.txtPlayer1Level];
                  break;
               case 2:
                  _loc2_ = [this.txtPlayer2Name,this.txtPlayer2HP,this.txtPlayer2Energy,this.txtPlayer2Heat,this.txtPlayer2Bullets,this.txtPlayer2Rockets,this.txtPlayer2Level];
            }
            screensM.createMultipleTextsBitmap("battleInterfaceTop_player" + param1 + "Attributes",_loc2_,"",this.mcIconsHolder);
         }
      }
      
      public function showAvatarImage(param1:Boolean, param2:Number) : void
      {
         var _loc3_:Sprite = null;
         var _loc7_:String = null;
         var _loc14_:MovieClip = null;
         var _loc19_:BMAvatarImage = null;
         var _loc20_:String = null;
         var _loc21_:BMClanFlag = null;
         var _loc22_:Array = null;
         var _loc23_:MovieClip = null;
         var _loc24_:BMPlayerProfile = null;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:uint = 0;
         this.removeAvatarImage(param2);
         this.removeAvatarItem(param2);
         this.removeClanFlag(param2);
         if(param1)
         {
            _loc3_ = this["player" + param2 + "AvatarSizer"];
            this["player" + param2 + "AvatarImage"] = new BMAvatarImage();
            _loc19_ = this["player" + param2 + "AvatarImage"];
            _loc20_ = dataM.avatarLink;
            _loc19_.initialize(param2,_loc20_,_loc3_.width,_loc3_.height);
            _loc19_.x = _loc3_.x;
            _loc19_.y = _loc3_.y;
            return;
         }
         var _loc4_:Number = Number(dataM["player" + param2 + "PlayerID"]);
         var _loc5_:BMPlayerData = dataM.playersData[_loc4_];
         var _loc6_:Boolean = false;
         var _loc8_:BMPlayerProfile = dataM["player" + _loc4_ + "Profile"];
         var _loc9_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(BattleTypeResolver.isClanWar && param2 == 2)
         {
            _loc7_ = dataM.clanWarsM.enemyClanData.flag;
            _loc6_ = true;
         }
         else if(_loc8_.clanID > 0)
         {
            if(_loc8_.clanFlag != "")
            {
               _loc7_ = _loc8_.clanFlag;
               if(_loc7_ != null)
               {
                  _loc6_ = true;
               }
            }
         }
         if(_loc6_ == false)
         {
            if(param2 == 2)
            {
               if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION)
               {
                  if(_loc9_.mission_flag != "")
                  {
                     _loc7_ = _loc9_.mission_flag;
                     _loc6_ = true;
                  }
               }
            }
         }
         if(_loc6_)
         {
            _loc3_ = this["player" + param2 + "ClanFlagSizer"];
            this["player" + param2 + "ClanFlag"] = new BMClanFlag();
            _loc21_ = this["player" + param2 + "ClanFlag"];
            _loc22_ = dataM.getClanFlagData(_loc7_);
            _loc23_ = externalAssetsM.getAsset("general","clanFlag");
            this.mcIconsHolder.addChild(_loc23_);
            _loc21_.initialize(_loc23_,dataM.runAsMobile);
            _loc21_.updateFlag(_loc22_);
            _loc23_.width = _loc3_.width;
            _loc23_.height = _loc3_.height;
            _loc23_.x = _loc3_.x;
            _loc23_.y = _loc3_.y;
            return;
         }
         var _loc10_:Number = 0;
         var _loc11_:BMMechStructure = screensM.screenBattle.getMechStructure(_loc4_,_loc5_.selectedMechID);
         var _loc12_:BMPlayerItemData = dataM.getPlayerItemData(_loc4_,_loc11_.torso);
         if(param2 == 2 && dataM.playingVSComputer && dataM.gameType != BMDataManager.GAME_TYPE_PVP)
         {
            if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION)
            {
               _loc10_ = _loc12_.colorID;
            }
            else if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_CLAN_BOSS)
            {
               _loc10_ = dataM.myProfile.clanBossData.colorID;
            }
            else if(_loc9_.level == 1)
            {
               _loc10_ = BMSinglePlayerManager.MISSION_COLOR_NORMAL;
            }
            else
            {
               _loc24_ = dataM["player" + dataM.player2PlayerID + "Profile"];
               _loc25_ = _loc24_.level - _loc9_.levelByItems;
               _loc10_ = dataM.getComputerColorID(_loc25_);
            }
         }
         else if(_loc12_.colorID > 0)
         {
            _loc10_ = _loc12_.colorID;
         }
         else
         {
            _loc10_ = _loc26_ = dataM.getItemPowerColorID(_loc4_,_loc11_.torso);
         }
         var _loc13_:BMItemData = dataM.itemsDB[_loc12_.itemID];
         var _loc15_:Number = 100;
         var _loc16_:Boolean = false;
         var _loc17_:String = "";
         if(param2 == 2)
         {
            if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_MISSION)
            {
               switch(dataM.battleSubType)
               {
                  case BMSinglePlayerManager.ENEMY_TYPE_JEEP:
                  case BMSinglePlayerManager.ENEMY_TYPE_TANK:
                     _loc16_ = true;
                     _loc27_ = 1;
                     if(_loc13_.damageType > 0)
                     {
                        _loc27_ = uint(_loc13_.damageType);
                     }
                     _loc17_ = "missionAvatar_" + dataM.battleSubType + _loc27_;
               }
            }
            else if(dataM.battleType == BMSinglePlayerManager.BATTLE_TYPE_CLAN_BOSS)
            {
               _loc16_ = true;
               _loc17_ = dataM.myProfile.clanBossData.battleAvatar;
            }
         }
         if(_loc16_)
         {
            _loc14_ = externalAssetsM.getAsset("items1",_loc17_,0,0,false,true);
         }
         else
         {
            _loc14_ = externalAssetsM.getAsset("items1",_loc13_.grp,0,0,false,true);
         }
         var _loc18_:Array = [param2,_loc15_,_loc10_];
         if(_loc14_.loading)
         {
            externalAssetsM.modifyExternalAssetDuplicationContainer(_loc14_,true,0,this.showAvatarImageSub,_loc18_);
         }
         else
         {
            this.showAvatarImageSub(_loc14_,_loc18_);
         }
      }
      
      private function showAvatarImageSub(param1:MovieClip, param2:Array) : void
      {
         var _loc3_:uint = uint(param2[0]);
         var _loc4_:Number = Number(param2[1]);
         var _loc5_:uint = uint(param2[2]);
         this["player" + _loc3_ + "AvatarItem"] = new BMItem();
         var _loc6_:BMItem = this["player" + _loc3_ + "AvatarItem"];
         _loc6_.initialize(0,_loc4_,_loc4_,param1,0,0,false,null,dataM.runAsMobile);
         dataM.colorItem(_loc6_,_loc5_);
         var _loc7_:Sprite = this["player" + _loc3_ + "AvatarSizer"];
         if(_loc3_ == 1)
         {
            _loc6_.x = _loc7_.x - (_loc4_ - _loc7_.width);
         }
         else
         {
            _loc6_.x = _loc7_.x + _loc4_;
            _loc6_.scaleX = -1;
         }
         _loc6_.y = _loc7_.y - _loc4_ * 0.1;
         this.mcAvatarsHolder.addChild(_loc6_);
      }
      
      public function removeAvatarImage(param1:Number) : void
      {
         var _loc2_:BMAvatarImage = this["player" + param1 + "AvatarImage"];
         if(_loc2_ != null)
         {
            _loc2_.removeMe();
            if(_loc2_.parent != null)
            {
               _loc2_.parent.removeChild(_loc2_);
               this["player" + param1 + "AvatarImage"] = null;
            }
         }
      }
      
      public function removeAvatarItem(param1:Number) : void
      {
         var _loc2_:BMItem = this["player" + param1 + "AvatarItem"];
         if(_loc2_ != null)
         {
            _loc2_.removeMe();
            this["player" + param1 + "AvatarItem"] = null;
         }
      }
      
      public function removeClanFlag(param1:Number) : void
      {
         var _loc2_:BMClanFlag = this["player" + param1 + "ClanFlag"];
         if(_loc2_ != null)
         {
            _loc2_.removeMe();
            this["player" + param1 + "ClanFlag"] = null;
         }
      }
      
      public function openEmotesClicked() : void
      {
         if(screensM.screenBattleInterfaceEmotes.getStatus() == "closed")
         {
            screensM.screenBattleInterfaceEmotes.openMe();
            this.btnEmotesOpen.visible = false;
            this.btnEmotesClose.visible = true;
         }
      }
      
      public function closeEmotesClicked() : void
      {
         if(screensM.screenBattleInterfaceEmotes.getStatus() == "opened")
         {
            screensM.screenBattleInterfaceEmotes.closeMe();
            this.btnEmotesOpen.visible = true;
            this.btnEmotesClose.visible = false;
         }
      }
      
      public function chatEnableClicked() : void
      {
         this.enableChat();
         this.btnChatEnable.visible = false;
         this.btnChatDisable.visible = true;
      }
      
      public function chatDisableClicked() : void
      {
         this.disableChat();
         this.btnChatEnable.visible = true;
         this.btnChatDisable.visible = false;
      }
      
      public function enableChat() : void
      {
         this._chatEnabled = true;
         this.mcChat.visible = true;
      }
      
      public function disableChat() : void
      {
         this._chatEnabled = false;
         this.mcChat.visible = false;
      }
      
      public function refreshChat() : void
      {
         if(this._chatEnabled)
         {
            this.chatEnableClicked();
         }
         else
         {
            this.chatDisableClicked();
         }
      }
      
      public function initializeChat(param1:Boolean) : void
      {
         if(param1)
         {
            this.mcChat.txtChatInput.text = getScreenText("typeToChat");
            this.mcChat.txtChatInput.addEventListener(FocusEvent.FOCUS_IN,this.chatTextGotFocus);
         }
         else if(this.mcChat.txtChatInput.text != getScreenText("typeToChat"))
         {
            this.mcChat.txtChatInput.text = "";
         }
         this.closeChatClicked();
      }
      
      private function chatTextGotFocus(param1:Event) : void
      {
         if(this.mcChat.txtChatInput.text == getScreenText("typeToChat"))
         {
            this.mcChat.txtChatInput.text = "";
         }
         this.mcChat.txtChatInput.removeEventListener(FocusEvent.FOCUS_IN,this.chatTextGotFocus);
      }
      
      public function sendMessageSuccess(param1:String, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:BMPlayerData = null;
         var _loc5_:BMChatBubble = null;
         if(this._chatEnabled)
         {
            _loc3_ = 1;
            _loc4_ = dataM.playersData[dataM.player1PlayerID];
            if(_loc4_.battlePlayerID != param2)
            {
               _loc3_ = 2;
               param1 = dataM.getCensoredString(param1);
            }
            _loc5_ = this["mcPlayer" + _loc3_ + "ChatBubble"];
            _loc5_.showNewMessage(param1);
            if(_loc3_ == 1)
            {
               this.mcChat.txtChatInput.text = "";
            }
            else
            {
               soundM.createSound("messagePop",1);
            }
         }
      }
      
      private function closeChatClicked() : void
      {
         this.mcChat.visible = false;
      }
      
      private function waitingForBattleResultHandler() : void
      {
         if(screensM.screenBlack.isActive())
         {
            return;
         }
         if(this._waitingForBattleResultActive == false)
         {
            return;
         }
         if(screensM.screenBattle.allowWaitingForBattleResultPopup() == false)
         {
            return;
         }
         ++this._waitingForBattleResultFrameCounter;
         if(this._waitingForBattleResultFrameCounter == 150 && screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_RESULT) == false && screensM.isScreenOpened(BMScreensManager.SCR_LADDER_STATUS) == false)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
         }
      }
      
      public function resetWaitingForBattleResult() : void
      {
         this._waitingForBattleResultActive = false;
      }
      
      public function refreshOpponentBars(param1:Boolean) : void
      {
         var _loc2_:uint = screensM.screenBattle.opponentPlayerID;
         var _loc3_:BMPlayerData = dataM.playersData[_loc2_];
         var _loc4_:String = screensM.screenBattle.getMechSlot(_loc2_);
         this.refreshEnergy(_loc2_,param1);
         this.refreshHP(_loc2_,param1);
         this.refreshHeat(_loc2_,param1);
         this.refreshBullets(_loc2_,param1);
         this.refreshRockets(_loc2_,param1);
         this.refreshResistance(_loc2_,1,true);
         this.refreshResistance(_loc2_,2,true);
         this.refreshResistance(_loc2_,3,true);
      }
      
      public function refreshLevelAndRank(param1:Number) : void
      {
         var _loc5_:BMPlayerProfile = null;
         var _loc6_:Boolean = false;
         var _loc7_:Sprite = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc2_:Number = dataM.getInterfacePlayerID(param1);
         var _loc3_:Sprite = this["player" + _loc2_ + "Rank"];
         if(_loc3_ != null)
         {
            _loc3_.parent.removeChild(_loc3_);
            this["player" + _loc2_ + "Rank"] = null;
         }
         var _loc4_:TextField = this["txtPlayer" + _loc2_ + "Level"];
         _loc4_.text = "";
         if(_loc2_ == 1 || _loc2_ == 2 && this._player2InterfaceVisible)
         {
            _loc5_ = dataM["player" + param1 + "Profile"];
            _loc6_ = true;
            switch(dataM.gameType)
            {
               case BMDataManager.GAME_TYPE_PVE:
                  if(_loc2_ == 2)
                  {
                     _loc6_ = false;
                  }
                  break;
               case BMDataManager.GAME_TYPE_PVP:
               case BMDataManager.GAME_TYPE_REPLAY:
                  break;
               default:
                  _loc6_ = false;
            }
            if(_loc6_)
            {
               if(dataM.showRankingListPosition())
               {
                  if(dataM.gameType == BMDataManager.GAME_TYPE_PVP)
                  {
                     _loc9_ = _loc5_.pvpInitialRankingListPosition;
                  }
                  else
                  {
                     _loc9_ = _loc5_.rankingListPosition;
                  }
                  _loc4_.text = String("#" + TextUtils.getNumberWithComma(_loc9_));
               }
               else
               {
                  _loc4_.text = String(dataM.getLadderRankByProgress(_loc5_.ladderProgress));
               }
            }
            else
            {
               _loc4_.text = "";
            }
            _loc7_ = this["player" + _loc2_ + "IconRankSizer"];
            if(_loc6_)
            {
               _loc8_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc5_.ladderProgress));
            }
            else
            {
               _loc8_ = 0;
            }
            if(_loc8_ > 0)
            {
               this["player" + _loc2_ + "Rank"] = externalAssetsM.getAsset("general","Grp_rank" + _loc8_,_loc7_.width,_loc7_.height,false,false);
               _loc3_ = this["player" + _loc2_ + "Rank"];
               _loc3_.x = _loc7_.x;
               _loc3_.y = _loc7_.y;
               this.mcIconsHolder.addChild(_loc3_);
            }
            else
            {
               _loc3_ = this["player" + _loc2_ + "Rank"];
               if(_loc3_ != null)
               {
                  if(_loc3_.parent != null)
                  {
                     _loc3_.parent.removeChild(_loc3_);
                     this["player" + _loc2_ + "Rank"] = null;
                  }
               }
            }
         }
      }
      
      public function setNameAndFlag(param1:Number, param2:String) : void
      {
         var _loc4_:BMMechBattleData = null;
         var _loc5_:BMPlayerProfile = null;
         var _loc6_:String = null;
         var _loc3_:Number = dataM.getInterfacePlayerID(param1);
         if(_loc3_ == 1 || _loc3_ == 2 && this._player2InterfaceVisible)
         {
            _loc4_ = screensM.screenBattle.mechBattleDatas[screensM.screenBattle.getMechSlot(param1)];
            _loc5_ = dataM["player" + _loc4_.playerID + "Profile"];
            _loc6_ = "";
            if(_loc5_.playerName != null && _loc5_.playerName != "")
            {
               _loc6_ = _loc5_.playerName;
            }
            if(_loc3_ == 2)
            {
               if(dataM.isPlayerIDAdmin(_loc5_.userID))
               {
                  _loc6_ = "<FONT COLOR=\'#" + dataM.chatData.COLOR_ADMIN + "\'>" + _loc6_ + "</FONT>";
               }
               else if(dataM.isMyFriend(_loc5_.userID))
               {
                  _loc6_ = "<FONT COLOR=\'#" + dataM.chatData.COLOR_FRIEND + "\'>" + _loc6_ + "</FONT>";
               }
            }
            updateTextAndFormat(this["txtPlayer" + _loc3_ + "Name"],_loc6_);
         }
      }
      
      public function refreshHP(param1:Number, param2:Boolean) : void
      {
         var _loc4_:String = null;
         var _loc5_:BMMechBattleData = null;
         var _loc6_:BMBar = null;
         var _loc7_:TextField = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:String = null;
         var _loc3_:Number = dataM.getInterfacePlayerID(param1);
         if(_loc3_ == 1 || _loc3_ == 2 && this._player2InterfaceVisible)
         {
            _loc4_ = screensM.screenBattle.getMechSlot(param1);
            _loc5_ = screensM.screenBattle.mechBattleDatas[_loc4_];
            _loc6_ = this["player" + _loc3_ + "HPBar"];
            _loc7_ = this["txtPlayer" + _loc3_ + "HP"];
            _loc8_ = _loc5_.HP;
            if(_loc8_ < 0)
            {
               _loc8_ = 0;
            }
            _loc9_ = _loc8_ / _loc5_.HPMax;
            _loc6_.setFill(_loc9_,param2);
            _loc10_ = "";
            if(_loc5_.HP < 0)
            {
               _loc10_ = "<FONT COLOR=\'#FF0000\'>" + TextUtils.getNumberWithComma(_loc5_.HP) + "</FONT> / " + TextUtils.getNumberWithComma(_loc5_.HPMax);
            }
            else
            {
               _loc10_ = TextUtils.getNumberWithComma(_loc5_.HP) + " / " + TextUtils.getNumberWithComma(_loc5_.HPMax);
            }
            _loc7_.htmlText = _loc10_;
            if(_loc5_.HPBar != null)
            {
               _loc5_.HPBar.setFill(_loc9_,param2);
            }
            if(_loc5_.HP <= 0 && screensM.screenBattle.getPlayerLostID() == param1)
            {
               switch(dataM.gameType)
               {
                  case BMDataManager.GAME_TYPE_PVE:
                  case BMDataManager.GAME_TYPE_PVP:
                     this._waitingForBattleResultActive = true;
                     this._waitingForBattleResultFrameCounter = 0;
               }
            }
         }
      }
      
      public function refreshEnergy(param1:Number, param2:Boolean) : void
      {
         var _loc4_:BMMechBattleData = null;
         var _loc5_:BMBar = null;
         var _loc6_:TextField = null;
         var _loc3_:Number = dataM.getInterfacePlayerID(param1);
         if(_loc3_ == 1 || _loc3_ == 2 && this._player2InterfaceVisible)
         {
            _loc4_ = screensM.screenBattle.mechBattleDatas[screensM.screenBattle.getMechSlot(param1)];
            _loc5_ = this["player" + _loc3_ + "EnergyBar"];
            _loc6_ = this["txtPlayer" + _loc3_ + "Energy"];
            if(_loc4_.energyMax > 0)
            {
               _loc5_.setFill(_loc4_.energy / _loc4_.energyMax,param2);
               _loc6_.text = _loc4_.energy + " / " + _loc4_.energyMax;
               _loc5_.visible = true;
            }
            else
            {
               _loc6_.text = "";
               _loc5_.visible = false;
            }
         }
      }
      
      public function refreshHeat(param1:Number, param2:Boolean) : void
      {
         var _loc4_:BMPlayerData = null;
         var _loc5_:BMMechBattleData = null;
         var _loc6_:BMBar = null;
         var _loc7_:TextField = null;
         var _loc8_:MovieClip = null;
         var _loc9_:Number = NaN;
         var _loc10_:Boolean = false;
         var _loc11_:Number = NaN;
         var _loc12_:BMBattleTurnData = null;
         var _loc3_:Number = dataM.getInterfacePlayerID(param1);
         if(_loc3_ == 1 || _loc3_ == 2 && this._player2InterfaceVisible)
         {
            _loc4_ = dataM.playersData[param1];
            _loc5_ = screensM.screenBattle.mechBattleDatas[screensM.screenBattle.getMechSlot(param1)];
            _loc6_ = this["player" + _loc3_ + "HeatBar"];
            _loc7_ = this["txtPlayer" + _loc3_ + "Heat"];
            _loc8_ = this["player" + _loc3_ + "Overheat"];
            if(_loc5_.heat / _loc5_.heatMax > this.OVERHEAT_WARNING_RATIO_SLOW)
            {
               if(_loc5_.heat / _loc5_.heatMax > this.OVERHEAT_WARNING_RATIO_FAST)
               {
                  _loc8_.gotoAndStop("animOn_fast");
               }
               else
               {
                  _loc8_.gotoAndStop("animOn_slow");
               }
            }
            else
            {
               _loc8_.gotoAndStop("animOff");
            }
            if(_loc5_.heatMax > 0)
            {
               _loc9_ = _loc5_.heat / _loc5_.heatMax;
               if(_loc9_ > 1)
               {
                  _loc9_ = 1;
               }
               _loc6_.setFill(_loc9_,param2);
               _loc7_.text = _loc5_.heat + " / " + _loc5_.heatMax;
               _loc6_.visible = true;
            }
            else
            {
               _loc7_.text = "";
               _loc6_.visible = false;
            }
            switch(dataM.gameType)
            {
               case BMDataManager.GAME_TYPE_PVE:
               case BMDataManager.GAME_TYPE_PVP:
                  if(_loc5_.playerID == dataM.player1PlayerID)
                  {
                     if(_loc5_.heat / _loc5_.heatMax > this.OVERHEAT_WARNING_RATIO_SLOW)
                     {
                        _loc10_ = false;
                        _loc11_ = 1;
                        if(_loc3_ == 1)
                        {
                           _loc11_ = 2;
                        }
                        _loc12_ = screensM.screenBattle.getBattleTurnData();
                        if(_loc12_ != null)
                        {
                           if(_loc12_.get_HP(_loc3_,_loc4_.selectedMechID) == 0 || _loc12_.get_HP(_loc11_,_loc4_.selectedMechID) == 0)
                           {
                              _loc10_ = true;
                           }
                        }
                        if(_loc10_ == false)
                        {
                           screensM.screenBattleInterfaceBottom.setHeatCriticalAlertCountdownToMax();
                           screensM.screenBattleInterfaceBottom.activateActionErrorMessage("heatCritical");
                        }
                     }
                  }
            }
         }
      }
      
      public function refreshBullets(param1:Number, param2:Boolean) : void
      {
         var _loc4_:BMMechBattleData = null;
         var _loc5_:BMRoundBar = null;
         var _loc6_:TextField = null;
         var _loc7_:MovieClip = null;
         var _loc8_:Boolean = false;
         var _loc3_:Number = dataM.getInterfacePlayerID(param1);
         if(_loc3_ == 1 || _loc3_ == 2 && this._player2InterfaceVisible)
         {
            _loc4_ = screensM.screenBattle.mechBattleDatas[screensM.screenBattle.getMechSlot(param1)];
            _loc5_ = this["player" + _loc3_ + "BulletsRoundBar"];
            _loc6_ = this["txtPlayer" + _loc3_ + "Bullets"];
            _loc7_ = this["player" + _loc3_ + "IconBullets"];
            _loc5_.hideEmptyCover();
            if(_loc4_.bulletsMax > 0)
            {
               _loc5_.fillBar(_loc4_.bullets / _loc4_.bulletsMax);
               _loc6_.text = String(_loc4_.bullets);
               _loc5_.visible = true;
               _loc7_.visible = true;
            }
            else
            {
               _loc8_ = false;
               if(_loc4_.bulletsMax > 0 || _loc4_.rocketsMax > 0)
               {
                  _loc8_ = true;
               }
               _loc6_.text = "";
               if(_loc8_)
               {
                  _loc5_.visible = true;
                  _loc5_.fillBar(0);
                  _loc5_.showEmptyCover();
               }
               else
               {
                  _loc5_.visible = false;
               }
               _loc7_.visible = false;
            }
         }
      }
      
      public function refreshRockets(param1:Number, param2:Boolean) : void
      {
         var _loc4_:BMMechBattleData = null;
         var _loc5_:BMRoundBar = null;
         var _loc6_:TextField = null;
         var _loc7_:MovieClip = null;
         var _loc8_:Boolean = false;
         var _loc3_:Number = dataM.getInterfacePlayerID(param1);
         if(_loc3_ == 1 || _loc3_ == 2 && this._player2InterfaceVisible)
         {
            _loc4_ = screensM.screenBattle.mechBattleDatas[screensM.screenBattle.getMechSlot(param1)];
            _loc5_ = this["player" + _loc3_ + "RocketsRoundBar"];
            _loc6_ = this["txtPlayer" + _loc3_ + "Rockets"];
            _loc7_ = this["player" + _loc3_ + "IconRockets"];
            _loc5_.hideEmptyCover();
            if(_loc4_.rocketsMax > 0)
            {
               _loc5_.fillBar(_loc4_.rockets / _loc4_.rocketsMax);
               _loc6_.text = String(_loc4_.rockets);
               _loc5_.visible = true;
               _loc7_.visible = true;
            }
            else
            {
               _loc8_ = false;
               if(_loc4_.bulletsMax > 0 || _loc4_.rocketsMax > 0)
               {
                  _loc8_ = true;
               }
               _loc6_.text = "";
               if(_loc8_)
               {
                  _loc5_.visible = true;
                  _loc5_.fillBar(0);
                  _loc5_.showEmptyCover();
               }
               else
               {
                  _loc5_.visible = false;
               }
               _loc7_.visible = false;
            }
         }
      }
      
      private function hideAnnouncerText() : *
      {
         this.mcBattleAnnouncer.gotoAndStop(1);
         this._announcerTween = null;
      }
      
      public function showAnnouncerText(param1:String, param2:uint, param3:Number = 2, param4:Number = 1, param5:Boolean = true) : *
      {
         if(this._announcerTween != null)
         {
            this._announcerTween.kill();
            this.hideAnnouncerText();
         }
         var _loc6_:TextField = this.mcBattleAnnouncer.mcText.txtFinishMove;
         _loc6_.textColor = param2;
         _loc6_.text = param1;
         this.mcBattleAnnouncer.scaleX = param4;
         this.mcBattleAnnouncer.scaleY = param4;
         var _loc7_:MovieClip = this.mcBattleAnnouncer.mcBannerImage.mcBannerImageSub;
         _loc7_.width = _loc6_.textWidth + 10;
         if(param5)
         {
            this._announcerTween = TweenMax.to(this.mcBattleAnnouncer,param3,{
               "frame":88,
               "ease":Linear.easeNone,
               "onComplete":this.hideAnnouncerText
            });
         }
         else
         {
            this._announcerTween = TweenMax.to(this.mcBattleAnnouncer,param3 * (11 / 88),{
               "frame":11,
               "ease":Linear.easeNone,
               "onComplete":this.wiggleLessAnnouncerTweenPartTwo
            });
            this._announcerTween.data = param3;
         }
      }
      
      private function wiggleLessAnnouncerTweenPartTwo() : *
      {
         var _loc1_:Number = this._announcerTween.data;
         this.mcBattleAnnouncer.gotoAndStop(30);
         this._announcerTween = TweenMax.delayedCall(_loc1_ * (30 - 11) / 88,this.wiggleLessAnnouncerTweenPartThree);
         this._announcerTween.data = _loc1_;
      }
      
      private function wiggleLessAnnouncerTweenPartThree() : *
      {
         var _loc1_:Number = this._announcerTween.data;
         this._announcerTween = TweenMax.to(this.mcBattleAnnouncer,_loc1_ * (88 - 30) / 88,{
            "frame":88,
            "ease":Linear.easeNone,
            "onComplete":this.hideAnnouncerText
         });
      }
      
      public function blinkResistance(param1:Number, param2:Number) : void
      {
         var _loc4_:BMMechBattleData = null;
         var _loc5_:Boolean = false;
         var _loc6_:MovieClip = null;
         var _loc3_:Number = dataM.getInterfacePlayerID(param1);
         if(_loc3_ == 1 || _loc3_ == 2 && this._player2InterfaceVisible)
         {
            _loc4_ = screensM.screenBattle.mechBattleDatas[screensM.screenBattle.getMechSlot(param1)];
            _loc5_ = false;
            switch(param2)
            {
               case 1:
                  _loc5_ = _loc4_.resist1 != 0;
                  break;
               case 2:
                  _loc5_ = _loc4_.resist2 != 0;
                  break;
               case 3:
                  _loc5_ = _loc4_.resist3 != 0;
            }
            if(!_loc5_)
            {
               return;
            }
            _loc6_ = null;
            if(_loc3_ == 1)
            {
               _loc6_ = this.mcPlayer1InterfaceBackroundFront["mcResist" + param2];
            }
            else
            {
               _loc6_ = this.mcPlayer2InterfaceBackroundFront["mcResist" + param2];
            }
            TweenMax.to(_loc6_,0.05,{
               "scaleX":1.2,
               "scaleY":1.2,
               "delay":0,
               "colorTransform":{
                  "tint":16777215,
                  "tintAmount":0
               }
            });
            TweenMax.to(_loc6_,0.2,{
               "scaleX":1.2,
               "scaleY":1.2,
               "delay":0.1,
               "colorTransform":{
                  "tint":16777215,
                  "tintAmount":0.4
               }
            });
            TweenMax.to(_loc6_,0.3,{
               "scaleX":1,
               "scaleY":1,
               "delay":0.4,
               "colorTransform":{
                  "tint":16777215,
                  "tintAmount":0
               }
            });
         }
      }
      
      private function getResistTextHolder(param1:Number, param2:Number) : TextHolder
      {
         if(param1 == 1)
         {
            return this.mcPlayer1InterfaceBackroundFront["mcResist" + param2];
         }
         return this.mcPlayer2InterfaceBackroundFront["mcResist" + param2];
      }
      
      public function refreshResistance(param1:Number, param2:Number, param3:Boolean) : void
      {
         var _loc5_:TextHolder = null;
         var _loc6_:BMMechBattleData = null;
         var _loc7_:Boolean = false;
         var _loc8_:Boolean = false;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:Object = null;
         var _loc14_:Number = NaN;
         var _loc4_:Number = dataM.getInterfacePlayerID(param1);
         if(_loc4_ == 1 || _loc4_ == 2 && this._player2InterfaceVisible)
         {
            _loc5_ = this.getResistTextHolder(_loc4_,param2);
            _loc6_ = screensM.screenBattle.mechBattleDatas[screensM.screenBattle.getMechSlot(param1)];
            _loc7_ = false;
            if(_loc6_.resist1 != 0 || _loc6_.resist2 != 0 || _loc6_.resist3 != 0)
            {
               _loc7_ = true;
            }
            _loc8_ = false;
            _loc9_ = 0;
            if(dataM.battle_floorBuffsData != null)
            {
               _loc13_ = dataM.battle_floorBuffsData[_loc6_.currentStepCode];
               if(_loc13_ != null)
               {
                  if(_loc13_.type == "ignoreResistance")
                  {
                     _loc8_ = true;
                  }
                  if(_loc13_.type == "resistanceIncrease")
                  {
                     _loc9_ = dataM.floorBuff_resistanceDelta;
                  }
                  if(_loc13_.type == "resistanceDecrease")
                  {
                     _loc9_ = -dataM.floorBuff_resistanceDelta;
                  }
               }
            }
            _loc10_ = 0;
            _loc11_ = "";
            if(_loc8_)
            {
               _loc11_ = "<FONT COLOR=\'#666666\'>" + String(_loc10_) + "</FONT>";
            }
            else
            {
               _loc10_ = Number(_loc6_["resist" + param2]);
               if(_loc9_ != 0)
               {
                  _loc10_ += _loc9_;
               }
               _loc14_ = int(_loc5_.text);
               if(_loc10_ != 0)
               {
                  _loc11_ = String(_loc10_);
               }
            }
            _loc5_.text = _loc11_;
            _loc12_ = "hidden";
            if(_loc7_)
            {
               if(_loc10_ == 0)
               {
                  _loc12_ = "empty";
               }
               else
               {
                  _loc12_ = "resist" + param2;
               }
            }
            if(_loc4_ == 1)
            {
               this.mcPlayer1InterfaceBackroundFront["mcResist" + param2].gotoAndStop(_loc12_);
            }
            else
            {
               this.mcPlayer2InterfaceBackroundFront["mcResist" + param2].gotoAndStop(_loc12_);
            }
         }
      }
      
      public function refreshAP(param1:Number, param2:String = "") : void
      {
         var _loc4_:BMPlayerData = null;
         var _loc5_:uint = 0;
         var _loc6_:MovieClip = null;
         var _loc3_:Number = dataM.getInterfacePlayerID(param1);
         if(_loc3_ == 1 || _loc3_ == 2 && this._player2InterfaceVisible)
         {
            _loc4_ = dataM.playersData[param1];
            _loc5_ = 1;
            while(_loc5_ <= 3)
            {
               _loc6_ = this["player" + _loc3_ + "AP" + _loc5_];
               if(_loc4_.APMax >= _loc5_)
               {
                  _loc6_.visible = true;
                  if(_loc4_.AP >= _loc5_)
                  {
                     _loc6_.gotoAndStop("available");
                  }
                  else
                  {
                     _loc6_.gotoAndStop("used");
                  }
               }
               else if(_loc4_.AP == _loc5_)
               {
                  _loc6_.visible = true;
               }
               else
               {
                  _loc6_.visible = false;
               }
               _loc5_++;
            }
         }
      }
      
      public function showReplayProgressBar() : void
      {
         this.replayBar.visible = true;
         this.mcReplayProgressFrame.visible = true;
         updateTextAndFormat(this.txtReplayProgress,getScreenText("replayProgress"));
      }
      
      public function hideReplayProgressBar() : void
      {
         this.replayBar.visible = false;
         this.mcReplayProgressFrame.visible = false;
         this.txtReplayProgress.text = "";
      }
      
      public function pauseReplayClicked() : void
      {
         if(dataM.gameType != BMDataManager.GAME_TYPE_REPLAY)
         {
            return;
         }
         this.showReplayProgressBar();
         dataM.battle_gamePaused = true;
         this.btnPlayReplay.visible = true;
         this.btnPauseReplay.visible = false;
      }
      
      public function playReplayClicked() : void
      {
         if(dataM.gameType != BMDataManager.GAME_TYPE_REPLAY)
         {
            return;
         }
         this.hideReplayProgressBar();
         dataM.battle_gamePaused = false;
         this.btnPlayReplay.visible = false;
         this.btnPauseReplay.visible = true;
      }
      
      public function zoomInMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("zoomIn"),-1,-1);
      }
      
      public function zoomOutMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("zoomOut"),-1,-1);
      }
      
      public function quitMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("quit"),-1,-1);
      }
      
      public function optionsMouseOver() : void
      {
         tooltip.showToolTip("regularText",getGeneralText("options"),-1,-1);
      }
      
      private function chatEnableMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("enableChat"),-1,-1);
      }
      
      private function chatDisableMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("disableChat"),-1,-1);
      }
      
      public function emotesOpenMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("emotesOpen"),-1,-1);
      }
      
      public function emotesCloseMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("emotesClose"),-1,-1);
      }
      
      public function pauseReplayMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("pauseReplay"),-1,-1);
      }
      
      public function playReplayMouseOver() : void
      {
         tooltip.showToolTip("regularText",getScreenText("playReplay"),-1,-1);
      }
      
      private function interfaceButtonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      private function addIcon(param1:String, param2:String, param3:Boolean = false) : void
      {
         var _loc4_:Sprite = this[param1 + "Sizer"];
         this[param1] = externalAssetsM.getAsset("general",param2,_loc4_.width,_loc4_.height,false,false);
         if(param3)
         {
            this[param1].x = _loc4_.x + _loc4_.width / 2;
            this[param1].y = _loc4_.y + _loc4_.height / 2;
         }
         else
         {
            this[param1].x = _loc4_.x;
            this[param1].y = _loc4_.y;
         }
         this.mcIconsHolder.addChild(this[param1]);
      }
      
      private function toolTipAreaMouseOver(param1:MouseEvent) : void
      {
         this.toolTipAreaMouseOverSub(param1.target.name);
      }
      
      public function toolTipAreaMouseOverSub(param1:String) : void
      {
         if(screensM.screenBattle.opponentAvailable == false)
         {
            return;
         }
         var _loc2_:Number = int(param1.substr(16,1));
         var _loc3_:String = param1.substr(18,param1.length - 18);
         var _loc4_:Boolean = true;
         var _loc5_:Number = Number(dataM["player" + _loc2_ + "PlayerID"]);
         var _loc6_:BMPlayerData = dataM.playersData[_loc5_];
         var _loc7_:BMPlayerProfile = dataM["player" + _loc5_ + "Profile"];
         var _loc8_:String = screensM.screenBattle.getMechSlot(_loc5_);
         var _loc9_:BMMechBattleData = screensM.screenBattle.mechBattleDatas[_loc8_];
         switch(_loc3_)
         {
            case "bullets":
               if(_loc9_.bulletsMax == 0)
               {
                  _loc4_ = false;
               }
               break;
            case "rockets":
               if(_loc9_.rocketsMax == 0)
               {
                  _loc4_ = false;
               }
               break;
            case "resist1":
               if(_loc9_.resist1 == 0)
               {
                  _loc4_ = false;
               }
               break;
            case "resist2":
               if(_loc9_.resist2 == 0)
               {
                  _loc4_ = false;
               }
               break;
            case "resist3":
               if(_loc9_.resist3 == 0)
               {
                  _loc4_ = false;
               }
         }
         if(_loc4_)
         {
            tooltip.showToolTip("battleInterface",_loc3_,_loc2_,-1);
         }
      }
      
      private function toolTipAreaMouseOut(param1:MouseEvent) : void
      {
         tooltip.hideToolTip();
      }
      
      public function activateClock(param1:Number) : void
      {
         this.stopClockTimer();
         if(this._clockDelaySecondsCounter > 1)
         {
            --this._clockDelaySecondsCounter;
         }
         else
         {
            this._clockDelaySecondsCounter = 0;
         }
         var _loc2_:Number = dataM.battleData.general.secondsInTurn - this._clockDelaySecondsCounter;
         this.stopAndResetDelayTimer();
         if(param1 == 1)
         {
            _loc2_ += dataM.battleData.general.firstTurnSecondsAddon;
         }
         this._clockTimer = new Timer(1000,_loc2_);
         this._clockTimer.addEventListener(TimerEvent.TIMER,this.clockTimerEvent);
         this._clockTimer.start();
         this._clockSecondsCounter = _loc2_;
         this.updateClock();
         this.mcClock.showDigits();
         this.mcClock.setSecondsTotal(dataM.battleData.general.secondsInTurn);
      }
      
      public function clockTimerNotice() : void
      {
         this.stopClockTimer();
         this.mcClock.showTimeEnded();
      }
      
      public function disableTimer() : void
      {
         this.stopClockTimer();
         this.mcClock.showDisabled();
      }
      
      private function clockTimerEvent(param1:TimerEvent) : void
      {
         --this._clockSecondsCounter;
         this.updateClock();
         if(this._clockSecondsCounter == 0)
         {
            this.stopClockTimer();
            if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE))
            {
               screensM.screenBattle.clientSideTimerEnded();
            }
         }
      }
      
      private function updateClock() : void
      {
         this.mcClock.updateTimerDisplay(this._clockSecondsCounter);
      }
      
      private function stopClockTimer() : void
      {
         if(this._clockTimer != null)
         {
            this._clockTimer.stop();
            this._clockTimer.removeEventListener(TimerEvent.TIMER,this.clockTimerEvent);
         }
      }
      
      public function stopAndResetDelayTimer() : void
      {
         if(this._clockDelayTimer != null)
         {
            this._clockDelayTimer.stop();
         }
         this._clockDelaySecondsCounter = 0;
      }
      
      public function startClockDelay() : void
      {
         this.stopAndResetDelayTimer();
         this._clockDelayTimer = new Timer(1000,0);
         this._clockDelayTimer.addEventListener(TimerEvent.TIMER,this.clockDelayTimerEvent);
         this._clockDelayTimer.start();
      }
      
      private function clockDelayTimerEvent(param1:TimerEvent) : void
      {
         ++this._clockDelaySecondsCounter;
      }
      
      private function logoutMouseOver() : void
      {
         tooltip.showToolTip("regularText","Logout",-1,-1);
      }
      
      private function clearGuestSharedObjectClicked() : void
      {
         dataM.resetGuestSharedObject("battleInterfaceTop clearGuestSharedObjectClicked");
      }
      
      private function clearGuestSharedObjectMouseOver() : void
      {
         tooltip.showToolTip("regularText","Clear guest shared object",-1,-1);
      }
      
      private function generalButtonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      public function moveScreenUp() : void
      {
         this._moveScreenUp = true;
      }
      
      public function showOpponentInterface() : void
      {
         this._player2InterfaceVisible = true;
         this.mcPlayer2InterfaceBackroundFront.visible = true;
         this.mcPlayer2InterfaceBackroundBack.visible = true;
         this.txtPlayer2HP.visible = true;
         this.txtPlayer2Energy.visible = true;
         this.txtPlayer2Heat.visible = true;
         this.txtPlayer2Bullets.visible = true;
         this.txtPlayer2Rockets.visible = true;
         this.mcToolTip_player2_HP.visible = true;
         this.mcToolTip_player2_energy.visible = true;
         this.mcToolTip_player2_heat.visible = true;
         this.mcToolTip_player2_bullets.visible = true;
         this.mcToolTip_player2_rockets.visible = true;
         this.mcToolTip_player2_resist1.visible = true;
         this.mcToolTip_player2_resist2.visible = true;
         this.mcToolTip_player2_resist3.visible = true;
         this.mcToolTip_player2_AP.visible = true;
         this.mcToolTip_player2_level.visible = true;
         this.player2BulletsRoundBar.visible = true;
         this.player2RocketsRoundBar.visible = true;
         this.player2IconHeat.visible = true;
         this.player2IconEnergy.visible = true;
         this.player2IconBullets.visible = true;
         this.player2IconRockets.visible = true;
         this.player2AP1.visible = true;
         this.player2AP2.visible = true;
         this.player2AP3.visible = true;
         this.player2HPBar.visible = true;
         this.player2EnergyBar.visible = true;
         this.player2HeatBar.visible = true;
         this.player2Overheat.visible = true;
      }
      
      public function hideOpponentInterface() : void
      {
         this._player2InterfaceVisible = false;
         this.mcPlayer2InterfaceBackroundFront.visible = false;
         this.mcPlayer2InterfaceBackroundBack.visible = false;
         this.txtPlayer2HP.visible = false;
         this.txtPlayer2Energy.visible = false;
         this.txtPlayer2Heat.visible = false;
         this.txtPlayer2Bullets.visible = false;
         this.txtPlayer2Rockets.visible = false;
         this.mcToolTip_player2_HP.visible = false;
         this.mcToolTip_player2_energy.visible = false;
         this.mcToolTip_player2_heat.visible = false;
         this.mcToolTip_player2_bullets.visible = false;
         this.mcToolTip_player2_rockets.visible = false;
         this.mcToolTip_player2_resist1.visible = false;
         this.mcToolTip_player2_resist2.visible = false;
         this.mcToolTip_player2_resist3.visible = false;
         this.mcToolTip_player2_AP.visible = false;
         this.mcToolTip_player2_level.visible = false;
         this.player2BulletsRoundBar.visible = false;
         this.player2RocketsRoundBar.visible = false;
         this.player2IconHeat.visible = false;
         this.player2IconEnergy.visible = false;
         this.player2IconBullets.visible = false;
         this.player2IconRockets.visible = false;
         this.player2AP1.visible = false;
         this.player2AP2.visible = false;
         this.player2AP3.visible = false;
         this.player2HPBar.visible = false;
         this.player2EnergyBar.visible = false;
         this.player2HeatBar.visible = false;
         this.player2Overheat.visible = false;
      }
      
      public function displayOpponentModules() : void
      {
         var _loc1_:BMPlayerData = null;
         var _loc2_:BMMechStructure = null;
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:BMPlayerItemData = null;
         var _loc7_:BMItemData = null;
         var _loc8_:MovieClip = null;
         var _loc9_:Number = NaN;
         var _loc10_:BMPlayerItemData = null;
         var _loc11_:BMItemData = null;
         var _loc12_:MovieClip = null;
         if(dataM.isPlayerIDAdmin(dataM.userID))
         {
            _loc1_ = dataM.playersData[dataM.player2PlayerID];
            _loc2_ = screensM.screenBattle.getMechStructure(dataM.player2PlayerID,_loc1_.selectedMechID);
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["module"])
            {
               _loc5_ = Number(_loc2_["module" + _loc3_]);
               if(_loc5_ > 0)
               {
                  _loc6_ = dataM.getPlayerItemData(dataM.player2PlayerID,_loc5_);
                  _loc7_ = dataM.itemsDB[_loc6_.itemID];
                  _loc8_ = externalAssetsM.getAsset(dataM.itemTypeSourceDB["module"],_loc7_.grp,this.player2ModuleSizer.width,this.player2ModuleSizer.height,false,true);
                  _loc8_.x = this.player2ModuleSizer.x;
                  _loc8_.y = this.player2ModuleSizer.y + this._player2Modules.length * (this.player2ModuleSizer.height + 3);
                  this.mcIconsHolder.addChild(_loc8_);
                  this._player2Modules.push(_loc8_);
               }
               _loc3_++;
            }
            _loc4_ = this._player2Modules.length;
            _loc3_ = 1;
            while(_loc3_ <= dataM.maxEquipment["kit"])
            {
               _loc9_ = Number(_loc2_["kit" + _loc3_]);
               if(_loc9_ > 0)
               {
                  _loc10_ = dataM.getPlayerItemData(dataM.player2PlayerID,_loc9_);
                  _loc11_ = dataM.itemsDB[_loc10_.itemID];
                  _loc12_ = externalAssetsM.getAsset(dataM.itemTypeSourceDB["kit"],_loc11_.grp,this.player2ModuleSizer.width,this.player2ModuleSizer.height,false,true);
                  _loc12_.x = this.player2ModuleSizer.x - (this.player2ModuleSizer.width + 3);
                  _loc12_.y = this.player2ModuleSizer.y + (this._player2Modules.length - _loc4_) * (this.player2ModuleSizer.height + 3);
                  this.mcIconsHolder.addChild(_loc12_);
                  this._player2Modules.push(_loc12_);
               }
               _loc3_++;
            }
         }
      }
      
      public function clearOpponentModules() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         if(dataM.isPlayerIDAdmin(dataM.userID))
         {
            _loc1_ = 0;
            while(_loc1_ < this._player2Modules.length)
            {
               _loc2_ = this._player2Modules[_loc1_];
               if(_loc2_.parent != null)
               {
                  _loc2_.parent.removeChild(_loc2_);
               }
               _loc2_ = null;
               this._player2Modules[_loc1_] = null;
               _loc1_++;
            }
            this._player2Modules = new Array();
         }
      }
      
      public function activateTurnOwnerMessage(param1:String) : void
      {
         var _loc3_:String = null;
         if(this.mcTurnOwnerMessage.parent == null)
         {
            addChild(this.mcTurnOwnerMessage);
         }
         var _loc2_:uint = 20;
         switch(dataM.languageID)
         {
            case 5:
               _loc2_ = 18;
               break;
            case 7:
               _loc2_ = 16;
               break;
            case 9:
               _loc2_ = 18;
         }
         if(this.mcTurnOwnerMessage.mcBackground.currentLabel != param1)
         {
            _loc3_ = "";
            switch(param1)
            {
               case "opponentTurn":
                  _loc3_ = getScreenText("enemyTurn");
                  break;
               case "myTurn":
                  _loc3_ = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_RARE_ITEM + "\'>" + getScreenText("yourTurn") + "</FONT>";
            }
            updateTextAndFormat(this.mcTurnOwnerMessage.txtOwner,_loc3_);
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("battleInterfaceTop_turnOwner",[this.mcTurnOwnerMessage.txtOwner],"",this.mcTurnOwnerMessage);
            }
            this.mcTurnOwnerMessage.mcBackground.gotoAndStop(param1);
         }
      }
      
      public function deactivateTurnOwnerMessage() : void
      {
         if(this.mcTurnOwnerMessage.parent != null)
         {
            this.mcTurnOwnerMessage.parent.removeChild(this.mcTurnOwnerMessage);
         }
      }
      
      public function resetDestroyMechBadges() : void
      {
         this._player1DestroyMechBadge1Active = false;
         this._player1DestroyMechBadge2Active = false;
         this._player2DestroyMechBadge1Active = false;
         this._player2DestroyMechBadge2Active = false;
         this.mcPlayer1DestroyMechBadge1.visible = false;
         this.mcPlayer1DestroyMechBadge2.visible = false;
         this.mcPlayer2DestroyMechBadge1.visible = false;
         this.mcPlayer2DestroyMechBadge2.visible = false;
         this.mcPlayer1DestroyMechBadge1.y = this._destroyMechBadges1OriginYPos;
         this.mcPlayer1DestroyMechBadge2.y = this._destroyMechBadges2OriginYPos;
         this.mcPlayer2DestroyMechBadge1.y = this._destroyMechBadges1OriginYPos;
         this.mcPlayer2DestroyMechBadge2.y = this._destroyMechBadges2OriginYPos;
         this._destroyMechBadgesHandlerActive = false;
      }
      
      private function destroyMechBadgesHandler() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:Sprite = null;
         var _loc5_:Number = NaN;
         if(this._destroyMechBadgesHandlerActive == false)
         {
            return;
         }
         var _loc1_:Boolean = false;
         var _loc2_:uint = 1;
         while(_loc2_ <= 2)
         {
            _loc3_ = 1;
            while(_loc3_ <= 2)
            {
               if(this["_player" + _loc2_ + "DestroyMechBadge" + _loc3_ + "Active"] != false)
               {
                  _loc4_ = this["mcPlayer" + _loc2_ + "DestroyMechBadge" + _loc3_];
                  _loc5_ = Number(this["_destroyMechBadges" + _loc3_ + "TargetYPos"]);
                  if(_loc4_.y < _loc5_)
                  {
                     _loc4_.y += (_loc5_ - _loc4_.y) * 0.3;
                     if(_loc4_.y > _loc5_ - 1)
                     {
                        _loc4_.y = _loc5_;
                     }
                     else
                     {
                        _loc1_ = true;
                     }
                  }
               }
               _loc3_++;
            }
            _loc2_++;
         }
         if(_loc1_ == false)
         {
            this._destroyMechBadgesHandlerActive = false;
         }
      }
      
      public function activateDestroyMechBadge(param1:uint) : void
      {
         var _loc2_:uint = 1;
         if(this["_player" + param1 + "DestroyMechBadge" + _loc2_ + "Active"])
         {
            _loc2_ = 2;
         }
         this["_player" + param1 + "DestroyMechBadge" + _loc2_ + "Active"] = true;
         this["mcPlayer" + param1 + "DestroyMechBadge" + _loc2_].visible = true;
         this._destroyMechBadgesHandlerActive = true;
      }
      
      public function finishMoveTextAnimationDone() : void
      {
         screensM.screenBattle.showFinishMovesInterface();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_BATTLE_INTERFACE_TOP);
      }
   }
}

