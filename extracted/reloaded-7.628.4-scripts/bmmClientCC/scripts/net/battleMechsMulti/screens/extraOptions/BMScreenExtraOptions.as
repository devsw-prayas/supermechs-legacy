package net.battleMechsMulti.screens.extraOptions
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3041")]
   public class BMScreenExtraOptions extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var mcSizer_btnBack:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnSettings:BMBasicButton;
      
      public var btnGuide:BMBasicButton;
      
      public var btnAccounts:BMBasicButton;
      
      public var btnInfo:BMBasicButton;
      
      public var btnSupport:BMBasicButton;
      
      public var btnFaceBook:BMBasicButton;
      
      public var btnNews:BMBasicButton;
      
      public var btnForum:BMBasicButton;
      
      public var mcEnableBaseBuildingIndicator:Sprite;
      
      public function BMScreenExtraOptions()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("options");
         screensM.createButtonFromSizer(BMScreensManager.SCR_EXTRA_OPTIONS,"btnBack","pictureE");
         this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
         this.btnSettings.addEventListener(BMIntractable.HIT,this.settingsClicked);
         this.btnGuide.addEventListener(BMIntractable.HIT,this.helpClicked);
         this.btnAccounts.addEventListener(BMIntractable.HIT,this.accountsClicked);
         this.btnInfo.addEventListener(BMIntractable.HIT,this.profileInfoClicked);
         this.btnSupport.addEventListener(BMIntractable.HIT,this.supportClicked);
         this.btnFaceBook.addEventListener(BMIntractable.HIT,this.faceBookClicked);
         this.btnNews.addEventListener(BMIntractable.HIT,this.newsClicked);
         this.btnForum.addEventListener(BMIntractable.HIT,this.forumClicked);
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         this.btnSettings.text = getScreenText("settings");
         this.btnGuide.text = getScreenText("guide");
         this.btnAccounts.text = getScreenText("accounts");
         this.btnInfo.text = getScreenText("info");
         this.btnSupport.text = getScreenText("support");
         this.btnFaceBook.text = getScreenText("facebook");
         this.btnNews.text = getScreenText("news");
         this.btnForum.text = getScreenText("forum");
         this.refreshEnableBaseBuildingIndicator();
         if(dataM.runAsMobile)
         {
            ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
         }
      }
      
      private function refreshEnableBaseBuildingIndicator() : void
      {
         this.mcEnableBaseBuildingIndicator.mouseEnabled = false;
         this.mcEnableBaseBuildingIndicator.mouseChildren = false;
         this.mcEnableBaseBuildingIndicator.visible = false;
         if(this.mcEnableBaseBuildingIndicator == null)
         {
            return;
         }
         if(dataM.baseBuildingManager.isEnabled == false && dataM.baseBuildingManager.isOptInAllowed)
         {
            this.mcEnableBaseBuildingIndicator.visible = true;
         }
      }
      
      public function backClicked() : void
      {
         screensM.screenTransitionsManager.mainMenu();
      }
      
      public function settingsClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.profileOptionsClicked();
      }
      
      public function helpClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.profileHelpClicked();
      }
      
      public function faceBookClicked(param1:Event) : void
      {
         dataM.openURL("https://www.facebook.com/SuperMechsCommunity","_blank");
      }
      
      public function forumClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.communityForumClicked();
      }
      
      public function accountsClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.profileAccountsClicked();
      }
      
      public function profileInfoClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.profileInfoClicked();
      }
      
      private function supportClicked(param1:Event) : void
      {
         dataM.openSupportForm("In Game Super Mechs Support");
      }
      
      public function newsClicked(param1:Event) : void
      {
         screensM.screenTransitionsManager.communityNewsClicked();
      }
   }
}

