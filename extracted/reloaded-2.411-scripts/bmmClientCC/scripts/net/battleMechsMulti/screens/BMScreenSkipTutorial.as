package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1888")]
   public class BMScreenSkipTutorial extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnSkip:Sprite;
      
      public var btnSkip:BMButton;
      
      public function BMScreenSkipTutorial()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         screensM.createButtonFromSizer("screenSkipTutorial","btnSkip","regular");
         this.btnSkip.setRunAsMobile(dataM.runAsMobile);
         this.btnSkip.changeFontSize(15);
         this.btnSkip.initialize("SKIP TUTORIAL","blue",null,null,this.skipClicked,dataM.runAsMobile);
      }
      
      public function refreshScreen(param1:String) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(tutorialM.isTutorialActive())
         {
            if(screensM.isScreenOpened("screenHangerInventory") || screensM.isScreenOpened("screenMissionWorldMap") || screensM.isScreenOpened("screenBattle"))
            {
               _loc2_ = true;
            }
         }
      }
      
      private function skipClicked() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("skipTutorial",-1,-1);
      }
      
      public function skipTutorialAccepted() : void
      {
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         tutorialM.setTutorialLevel(BMTutorialManager.TUTORIAL_LEVEL_COMPLETED,"skipTutorial");
         dataM.tutorialSkipped = true;
         this.refreshScreen("skipTutorialAccepted");
         var _loc2_:Boolean = false;
         if(screensM.isScreenOpened("screenHangerMenu"))
         {
            screensM.screenHangerMenu.refreshScreen("mech");
            _loc2_ = true;
         }
         else if(screensM.isScreenOpened("screenBattleInterfaceBottom"))
         {
            screensM.screenBattleInterfaceBottom.disableTutorialArrow();
         }
         else if(screensM.isScreenOpened("screenMissionWorldMap"))
         {
            screensM.screenMissionWorldMap.refreshScreen();
         }
         if(_loc2_)
         {
            if(screensM.isScreenOpened("screenTopBar") == false)
            {
               screensM.addScreen("screenTopBar");
               screensM.screenTopBar.refreshScreen(false);
            }
         }
      }
   }
}

