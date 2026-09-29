package net.battleMechsMulti.screens
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol251")]
   public class BMScreenWelcomeLoginWarning extends BMBaseScreen
   {
      
      public var txtTitle:TextField;
      
      public var btnYes:BMBasicButton;
      
      public var btnNo:BMBasicButton;
      
      public function BMScreenWelcomeLoginWarning()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("loginWarning");
         ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
         this.txtTitle.text = getScreenText("title");
         this.btnYes.text = getScreenText("register");
         this.btnNo.text = getScreenText("willTakeMyChance");
         this.btnYes.addEventListener(BMIntractable.HIT,this.onYesClicked);
         this.btnNo.addEventListener(BMIntractable.HIT,this.onNoClicked);
      }
      
      private function onNoClicked(param1:Event) : void
      {
         loginM.endLoginAsFlow();
         screensM.removeScreen(BMScreensManager.SCR_WELCOME_LOGIN_WARNING);
      }
      
      private function onYesClicked(param1:Event) : void
      {
         this.backClicked();
      }
      
      public function backClicked() : void
      {
         screensM.removeScreen(BMScreensManager.SCR_WELCOME_LOGIN_WARNING);
         screensM.addScreen(BMScreensManager.SCR_WELCOME_LOGIN_AS);
         screensM.screenWelcomeLoginAs.refreshScreen();
      }
   }
}

