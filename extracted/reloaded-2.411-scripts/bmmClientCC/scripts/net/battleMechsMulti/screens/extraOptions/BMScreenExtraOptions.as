package net.battleMechsMulti.screens.extraOptions
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol852")]
   public class BMScreenExtraOptions extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var txtTitle:TextField;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnSettings:Sprite;
      
      public var mcSizer_btnHelp:Sprite;
      
      public var mcSizer_btnYouTube:Sprite;
      
      public var mcSizer_btnForum:Sprite;
      
      public var mcSizer_btnGifts:Sprite;
      
      public var mcSizer_btnAccounts:Sprite;
      
      public var mcSizer_btnProfileInfo:Sprite;
      
      public var mcSizer_btnNews:Sprite;
      
      public var mcSizer_btnShopMythical:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public var btnSettings:BMButton_pictureE;
      
      public var btnHelp:BMButton_pictureE;
      
      public var btnYouTube:BMButton_pictureE;
      
      public var btnForum:BMButton_pictureE;
      
      public var btnGifts:BMButton_pictureE;
      
      public var btnAccounts:BMButton_pictureE;
      
      public var btnProfileInfo:BMButton_pictureE;
      
      public var btnNews:BMButton_pictureE;
      
      public var btnShopMythical:BMButton_pictureE;
      
      public function BMScreenExtraOptions()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         screensM.createButtonFromSizer("screenExtraOptions","btnBack","pictureE");
         screensM.createButtonFromSizer("screenExtraOptions","btnSettings","pictureE");
         screensM.createButtonFromSizer("screenExtraOptions","btnHelp","pictureE");
         screensM.createButtonFromSizer("screenExtraOptions","btnYouTube","pictureE");
         screensM.createButtonFromSizer("screenExtraOptions","btnForum","pictureE");
         screensM.createButtonFromSizer("screenExtraOptions","btnGifts","pictureE");
         screensM.createButtonFromSizer("screenExtraOptions","btnAccounts","pictureE");
         screensM.createButtonFromSizer("screenExtraOptions","btnProfileInfo","pictureE");
         screensM.createButtonFromSizer("screenExtraOptions","btnNews","pictureE");
         screensM.createButtonFromSizer("screenExtraOptions","btnShopMythical","pictureE");
         this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,this.backClicked,false);
         this.btnSettings.initialize("","",externalAssetsM.getAsset("general","interface_options"),null,this.settingsClicked,false);
         this.btnHelp.initialize("","",externalAssetsM.getAsset("general","interface_help"),null,this.helpClicked,false);
         this.btnYouTube.initialize("","",externalAssetsM.getAsset("general","interface_youtube"),null,this.youTubeClicked,false);
         this.btnForum.initialize("","",externalAssetsM.getAsset("general","interface_forum"),null,this.forumClicked,false);
         this.btnGifts.initialize("","",externalAssetsM.getAsset("general","interface_gift"),null,this.giftsClicked,false);
         this.btnAccounts.initialize("","",externalAssetsM.getAsset("general","interface_accounts"),null,this.accountsClicked,false);
         this.btnProfileInfo.initialize("","",externalAssetsM.getAsset("general","interface_info"),null,this.profileInfoClicked,false);
         this.btnNews.initialize("","",externalAssetsM.getAsset("general","interface_news"),null,this.newsClicked,false);
         this.btnShopMythical.initialize("","",externalAssetsM.getAsset("general","interface_shopMythical"),null,this.shopMythicalClicked,false);
         if(dataM.runAsMobile)
         {
            ImageUtils.swapTextFieldWithBitMap(this.txtTitle,this);
         }
         this.btnForum.buttonCore.addMouseOverListerner(this.communityForumButtonMouseOver);
         this.btnForum.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
         this.btnYouTube.buttonCore.addMouseOverListerner(this.communityYouTubeButtonMouseOver);
         this.btnYouTube.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
         this.btnGifts.buttonCore.addMouseOverListerner(this.profileGiftsButtonMouseOver);
         this.btnGifts.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
         this.btnProfileInfo.buttonCore.addMouseOverListerner(this.profileInfoButtonMouseOver);
         this.btnProfileInfo.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
         this.btnHelp.buttonCore.addMouseOverListerner(this.profileHelpButtonMouseOver);
         this.btnHelp.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
         this.btnSettings.buttonCore.addMouseOverListerner(this.profileOptionsButtonMouseOver);
         this.btnSettings.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
         this.btnAccounts.buttonCore.addMouseOverListerner(this.profileAccountsButtonMouseOver);
         this.btnAccounts.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
         this.btnNews.buttonCore.addMouseOverListerner(this.communityNewsButtonMouseOver);
         this.btnNews.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
         this.btnShopMythical.buttonCore.addMouseOverListerner(this.shopMythicalButtonMouseOver);
         this.btnShopMythical.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
         this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnSettings.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnHelp.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnYouTube.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnForum.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnGifts.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnAccounts.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnProfileInfo.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnNews.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnShopMythical.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function backClicked() : void
      {
         screensM.removeScreen("screenExtraOptions");
      }
      
      public function settingsClicked() : void
      {
         this.backClicked();
         screensM.screenNewMenu.profileOptionsClicked();
      }
      
      public function helpClicked() : void
      {
         this.backClicked();
         screensM.screenNewMenu.profileHelpClicked();
      }
      
      public function youTubeClicked() : void
      {
         this.backClicked();
         screensM.screenNewMenu.communityYouTubeClicked();
      }
      
      public function forumClicked() : void
      {
         this.backClicked();
         screensM.screenNewMenu.communityForumClicked();
      }
      
      public function giftsClicked() : void
      {
         this.backClicked();
         screensM.screenNewMenu.profileGiftsClicked();
      }
      
      public function accountsClicked() : void
      {
         this.backClicked();
         screensM.screenNewMenu.profileAccountsClicked();
      }
      
      public function profileInfoClicked() : void
      {
         this.backClicked();
         screensM.screenNewMenu.profileInfoClicked();
      }
      
      public function newsClicked() : void
      {
         this.backClicked();
         screensM.screenNewMenu.communityNewsClicked();
      }
      
      public function shopMythicalClicked() : void
      {
         this.backClicked();
         screensM.screenNewMenu.shopMythicalClicked();
      }
      
      public function communityForumButtonMouseOver() : void
      {
         if(false == false)
         {
            tooltip.showToolTip("regularText",getSpecificText("newMenu_forum"));
         }
      }
      
      public function communityYouTubeButtonMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("newMenu_youtube"));
      }
      
      public function profileGiftsButtonMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("newMenu_gifts"));
      }
      
      public function profileInfoButtonMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("newMenu_info"));
      }
      
      public function profileHelpButtonMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("newMenu_help"));
      }
      
      public function profileOptionsButtonMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("newMenu_options"));
      }
      
      public function profileAccountsButtonMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("newMenu_accounts"));
      }
      
      public function communityNewsButtonMouseOver() : void
      {
         tooltip.showToolTip("regularText",getSpecificText("newMenu_news"));
      }
      
      public function shopMythicalButtonMouseOver() : void
      {
         var _loc1_:String = getSpecificText("newMenu_shopMythical");
         _loc1_ = dataM.replaceStringInText(_loc1_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_MYTHICAL_ITEM + "\'>");
         tooltip.showToolTip("regularText",_loc1_);
      }
      
      private function generalButtonMouseOut() : void
      {
         tooltip.hideToolTip();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
      }
   }
}

