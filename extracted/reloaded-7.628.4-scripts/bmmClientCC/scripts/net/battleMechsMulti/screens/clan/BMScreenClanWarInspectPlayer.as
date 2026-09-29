package net.battleMechsMulti.screens.clan
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.data.BattleTypeResolver;
   import net.battleMechsMulti.data.ClanWarAttackData;
   import net.battleMechsMulti.data.ClanWarPlayerData;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.clanWars.BMClanWarsManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.mechView.BMMechViewManualColors;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMScreenClanWarInspectPlayer extends BMBaseScreen
   {
      
      public var txtName:TextField;
      
      public var txtInfo:TextField;
      
      public var txtScore:TextField;
      
      public var txtMyBestAttack:TextField;
      
      public var mcMechThumb0:RaidEnemyThumb;
      
      public var mcMechThumb1:RaidEnemyThumb;
      
      public var mcMechThumb2:RaidEnemyThumb;
      
      public var btnClose:BMBasicButton;
      
      public var btnBattle:BMBasicButton;
      
      public var btnMechBuilds:BMBasicButton;
      
      public var mcScoreBar:BMBar;
      
      private var _defenderPlayerData:ClanWarPlayerData;
      
      private var _alignment:String;
      
      public function BMScreenClanWarInspectPlayer()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("clanWar");
      }
      
      public function showPlayerInfo(param1:ClanWarPlayerData, param2:String = "myClan") : void
      {
         this._defenderPlayerData = param1;
         this._alignment = param2;
         this.initTexts();
         this.initMechThumbs();
         this.initButtons();
         this.initInfo();
         this.initBattleInterface();
      }
      
      private function initInfo() : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         var _loc7_:ClanWarPlayerData = null;
         var _loc8_:ClanWarAttackData = null;
         var _loc9_:String = null;
         if(this.txtInfo == null || this.mcScoreBar == null)
         {
            return;
         }
         var _loc1_:ClanWarAttackData = dataM.clanWarsM.getBestAttackInfoAgainstPlayer(this._defenderPlayerData.playerID);
         var _loc2_:Number = 0;
         var _loc5_:Boolean = false;
         if(_loc1_ == null)
         {
            _loc3_ = getScreenText("teamWasNotAttacked");
            _loc4_ = "0 / " + TextUtils.getNumberWithComma(this._defenderPlayerData.teamMaxScore);
         }
         else
         {
            _loc6_ = BMClanWarsManager.ALIGNMENT_MY_CLAN;
            if(this._alignment == BMClanWarsManager.ALIGNMENT_MY_CLAN)
            {
               _loc6_ = BMClanWarsManager.ALIGNMENT_ENEMY_CLAN;
            }
            _loc7_ = dataM.clanWarsM.getPlayerData(_loc1_.attackerPlayerID,_loc6_);
            _loc3_ = getScreenText("clanBestAttack");
            _loc3_ = dataM.replaceStringInText(_loc3_,"%SCORE%",_loc7_.playerName);
            _loc2_ = _loc1_.score / this._defenderPlayerData.teamMaxScore;
            _loc4_ = TextUtils.getNumberWithComma(_loc1_.score) + " / " + TextUtils.getNumberWithComma(this._defenderPlayerData.teamMaxScore);
            _loc5_ = true;
         }
         updateTextAndFormat(this.txtInfo,_loc3_);
         updateTextAndFormat(this.txtScore,_loc4_);
         if(this.txtMyBestAttack != null)
         {
            this.txtMyBestAttack.text = "";
            _loc8_ = dataM.clanWarsM.getBestAttackInfoAgainstPlayer(this._defenderPlayerData.playerID,dataM.userID);
            if(_loc8_ != null)
            {
               _loc9_ = getScreenText("myBestAttack");
               _loc9_ = dataM.replaceStringInText(_loc9_,"%SCORE%",TextUtils.getNumberWithComma(_loc8_.score));
               updateTextAndFormat(this.txtMyBestAttack,_loc9_);
            }
         }
         this.mcScoreBar.initialize(BMBar.COLOR_BLUE);
         this.mcScoreBar.addSeparateorLines(4);
         this.mcScoreBar.setFill(0);
         this.mcScoreBar.setFill(_loc2_,_loc5_);
      }
      
      private function initTexts() : void
      {
         updateTextAndFormat(this.txtName,this._defenderPlayerData.playerName);
      }
      
      private function initBattleInterface() : void
      {
         if(this._alignment == BMClanWarsManager.ALIGNMENT_MY_CLAN)
         {
            return;
         }
         if(dataM.clanWarsM.didIFightPlayer(this._defenderPlayerData.playerID))
         {
            this.btnBattle.visible = false;
            this.btnMechBuilds.visible = false;
         }
         else
         {
            this.btnBattle.visible = true;
            this.btnMechBuilds.visible = true;
         }
      }
      
      private function initButtons() : void
      {
         this.btnClose.addEventListener(BMIntractable.HIT,this.onCloseClicked);
         if(this._alignment == BMClanWarsManager.ALIGNMENT_MY_CLAN)
         {
            return;
         }
         this.btnBattle.text = getSpecificText("raid_battle");
         this.btnBattle.addEventListener(BMIntractable.HIT,this.onBattleClicked);
         this.btnMechBuilds.addEventListener(BMIntractable.HIT,this.onMechBuildsClicked);
      }
      
      private function onBattleClicked(param1:Event) : void
      {
         if(dataM.clanWarsM.didIJoin == false)
         {
            this.showSpectateMessage();
            return;
         }
         var _loc2_:Boolean = dataM.clanWarsM.attacksLeft <= 0;
         if(_loc2_)
         {
            this.showNoAttacksLeftMessage();
            return;
         }
         var _loc3_:String = dataM.myPlayerData.isBlockedFromPlayingInCompetitveBattles(3);
         if(_loc3_ != null)
         {
            screensM.screenConfirmation.displayQuestionOrNotification(_loc3_);
            return;
         }
         if(dataM.areMechsReadyForBattle(3) == false)
         {
            screensM.screenConfirmation.displayCustomMessage(getScreenText("cantStartBattleWithBuild"));
            return;
         }
         var _loc4_:String = BMSinglePlayerManager.BATTLE_TYPE_CLAN_WAR;
         var _loc5_:String = BattleTypeResolver.ENV_CLAN_WAR;
         var _loc6_:Boolean = BattleTypeResolver.shouldPvEBattleBeOnServer(_loc5_);
         var _loc7_:Boolean = true;
         var _loc8_:Boolean = false;
         var _loc9_:String = BMSinglePlayerManager.ENEMY_TYPE_MECH;
         dataM.battleMechsPerPlayer = 3;
         dataM.clanWarsM.userStartedBattle(this._defenderPlayerData.playerID);
         dataM.singlePlayerM.startBattle_phase1(_loc4_,_loc9_,_loc7_,_loc8_,_loc6_,this._defenderPlayerData.playerID);
      }
      
      private function showSpectateMessage() : void
      {
         var _loc1_:String = getScreenText("spectatorCannotFight");
         screensM.screenConfirmation.displayCustomMessage(_loc1_);
      }
      
      private function showNoAttacksLeftMessage() : void
      {
         var _loc1_:String = getScreenText("alreadyUsedAllAttacksThisRound");
         screensM.screenConfirmation.displayCustomMessage(_loc1_);
      }
      
      private function onMechBuildsClicked(param1:Event) : void
      {
         if(dataM.clanWarsM.didIJoin == false)
         {
            this.showSpectateMessage();
            return;
         }
         screensM.screenTransitionsManager.cameFromClanWarInspectEnemy = true;
         screensM.screenTransitionsManager.clanWarInspectEnemy_playerID = this._defenderPlayerData.playerID;
         screensM.screenTransitionsManager.mechBuildsClicked();
      }
      
      private function initMechThumbs() : void
      {
         var _loc3_:RaidEnemyThumb = null;
         var _loc4_:Vector.<BMMechStructure> = null;
         var _loc5_:BMMechViewManualColors = null;
         var _loc6_:BMMechStructure = null;
         var _loc1_:Vector.<BMMechStructure> = dataM.clanWarsM.getTeam(this._defenderPlayerData.playerID,this._alignment);
         var _loc2_:uint = 1;
         while(_loc2_ <= 3)
         {
            _loc3_ = this["mcMechThumb" + (_loc2_ - 1)];
            _loc4_ = new Vector.<BMMechStructure>();
            _loc5_ = new BMMechViewManualColors();
            if(_loc1_.length >= _loc2_)
            {
               _loc5_.setByMechStructure(_loc1_[_loc2_ - 1]);
               _loc4_.push(_loc1_[_loc2_ - 1]);
            }
            else
            {
               _loc6_ = new BMMechStructure(BMMechStructure.ITEM_TYPE_ITEM_ID);
               _loc6_.initialize(0,_loc2_);
               _loc4_.push(_loc6_);
            }
            _loc3_.initialize_mechView(_loc4_,_loc5_,1,dataM.clanWarsM.themeID,false,true);
            _loc2_++;
         }
      }
      
      private function onCloseClicked(param1:Event) : void
      {
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_CLAN_WAR_INSPECT_PLAYER);
      }
   }
}

