package net.battleMechsMulti.screens.clan
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.timer.BMTimer;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   public class BMScreenClanWarJoin extends BMBaseScreen
   {
      
      public var btnJoin:BMBasicButton;
      
      public var btnLastWar:BMBasicButton;
      
      public var txtTitle:TextField;
      
      public var txtTimeLeft:TextField;
      
      public var txtRules:TextField;
      
      public var mcMechsHolder1:Sprite;
      
      public var mcMechsHolder2:Sprite;
      
      public var mcMechsHolder3:Sprite;
      
      public var mcTimer:BMTimer;
      
      private var mechsCreator:BMClanWarEyeCandyMechs;
      
      public function BMScreenClanWarJoin()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers();
         setLanguageManagerScreenName("clanWar");
         this.setTexts();
         this.setButtons();
         this.createMechs();
         this.initTimer();
      }
      
      private function setButtons() : void
      {
         this.btnJoin.text = getScreenText("join");
         this.btnLastWar.text = getScreenText("lastWar");
         this.btnJoin.addEventListener(BMIntractable.HIT,this.onJoinClicked);
         this.btnLastWar.addEventListener(BMIntractable.HIT,this.onLastWarClicked);
         if(dataM.clanWarsM.hasLastWarInfo == false)
         {
            this.btnLastWar.visible = false;
         }
      }
      
      private function setTexts() : void
      {
         updateTextAndFormat(this.txtTitle,getScreenText("preparationPhase"));
         updateTextAndFormat(this.txtTimeLeft,getScreenText("joinTimeLeft"));
         var _loc1_:String = getScreenText("rulesTitle");
         var _loc2_:int = 1;
         while(_loc2_ <= 5)
         {
            _loc1_ = _loc1_ + "<BR>" + getScreenText("rule" + _loc2_);
            _loc2_++;
         }
         updateTextAndFormat(this.txtRules,_loc1_);
      }
      
      private function initTimer() : void
      {
         this.mcTimer.initialize(dataM.clanWarsM.getPhaseSecLeft,this.onTimeEnd);
      }
      
      private function onTimeEnd() : void
      {
         screensM.screenClanMenu.refreshClanData();
      }
      
      private function createMechs() : void
      {
         this.mechsCreator = new BMClanWarEyeCandyMechs();
         this.mechsCreator.createMechs(this.mcMechsHolder1,this.mcMechsHolder2,this.mcMechsHolder3);
      }
      
      private function onJoinClicked(param1:Event) : void
      {
         var _loc4_:String = null;
         if(dataM.clanWarsM.canJoinWar)
         {
            _loc4_ = dataM.myPlayerData.isBlockedFromPlayingInCompetitveBattles(3);
            if(_loc4_ != null)
            {
               screensM.screenConfirmation.displayQuestionOrNotification(_loc4_);
               return;
            }
            remoteM.socketM.clanWar_join();
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            return;
         }
         if(dataM.areMechsReadyForBattle(3) == false)
         {
            screensM.screenConfirmation.displayCustomMessage(getScreenText("cantJoinWar_notEnoughMechs"));
            return;
         }
         var _loc2_:String = getScreenText("cantJoinWar_minXPLevel");
         var _loc3_:String = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>";
         _loc2_ = dataM.replaceStringInText(_loc2_,"%LEVEL%",_loc3_ + String(dataM.getGeneralSetting("mechBuildsMinXPLevel","999")) + "</FONT>");
         screensM.screenConfirmation.displayCustomMessage(_loc2_);
      }
      
      private function onLastWarClicked(param1:Event) : void
      {
         screensM.screenClanMenu.showLastWar();
      }
      
      public function removeMe() : void
      {
         this.mechsCreator.removeMechs();
         screensM.removeScreen(BMScreensManager.SCR_CLAN_WAR_JOIN);
      }
   }
}

