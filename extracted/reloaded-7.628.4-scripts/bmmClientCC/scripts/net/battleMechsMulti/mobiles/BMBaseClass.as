package net.battleMechsMulti.mobiles
{
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMDraggingManager;
   import net.battleMechsMulti.managers.BMEffecstManager;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.managers.BMKeyboardManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.managers.BMRemoteManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMSoundManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   
   public class BMBaseClass extends BMMovieClip
   {
      
      protected var remoteM:BMRemoteManager;
      
      protected var loginM:BMLoginManager;
      
      protected var dataM:BMDataManager;
      
      protected var screensM:BMScreensManager;
      
      protected var externalAssetsM:BMExternalAssetsManager;
      
      protected var draggingM:BMDraggingManager;
      
      protected var effectsM:BMEffecstManager;
      
      protected var tooltip:BMToolTip;
      
      protected var keyboardM:BMKeyboardManager;
      
      protected var soundM:BMSoundManager;
      
      protected var languageM:BMLanguageManager;
      
      protected var tutorialM:BMTutorialManager;
      
      private var _screenName:String;
      
      protected var lastLanguageID:uint = 0;
      
      public function BMBaseClass()
      {
         super();
      }
      
      protected function generateSingletonClassesPointers(param1:String = "") : void
      {
         if(param1 != "tutorialManager")
         {
            this.tutorialM = BMTutorialManager.gi();
         }
         if(param1 != "remoteManager")
         {
            this.remoteM = BMRemoteManager.getInstance();
         }
         if(param1 != "loginManager")
         {
            this.loginM = BMLoginManager.gi();
         }
         if(param1 != "dataManager")
         {
            this.dataM = BMDataManager.getInstance();
         }
         if(param1 != "screensManager")
         {
            this.screensM = BMScreensManager.getInstance();
         }
         if(param1 != "externalAssetsManager")
         {
            this.externalAssetsM = BMExternalAssetsManager.getInstance();
         }
         if(param1 != "draggingManager")
         {
            this.draggingM = BMDraggingManager.getInstance();
         }
         if(param1 != "effectsManager")
         {
            this.effectsM = BMEffecstManager.getInstance();
         }
         if(param1 != "soundManager")
         {
            this.soundM = BMSoundManager.getInstance();
         }
         if(param1 != "tooltip")
         {
            this.tooltip = BMToolTip.getInstance();
         }
         if(param1 != "languageManager")
         {
            this.languageM = BMLanguageManager.getInstance();
         }
         this.keyboardM = BMKeyboardManager.getInstance();
         this.soundM = BMSoundManager.getInstance();
      }
      
      protected function setLanguageManagerScreenName(param1:String) : void
      {
         this._screenName = param1;
      }
      
      protected function getScreenText(param1:String) : String
      {
         return this.languageM.getText(this._screenName + "_" + param1);
      }
      
      protected function getGeneralText(param1:String) : String
      {
         return this.languageM.getText("general_" + param1);
      }
      
      protected function getSpecificText(param1:String) : String
      {
         return this.languageM.getText(param1);
      }
   }
}

