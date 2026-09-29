package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.display.StageQuality;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.notifications.BMNotificationsManager;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol766")]
   public class BMScreenProfileOptions extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_btnBreathingOn:Sprite;
      
      public var mcSizer_btnBreathingOff:Sprite;
      
      public var mcSizer_btnParticlesMinus:Sprite;
      
      public var mcSizer_btnParticlesPlus:Sprite;
      
      public var mcSizer_btnQualityMinus:Sprite;
      
      public var mcSizer_btnQualityPlus:Sprite;
      
      public var mcSizer_btnMusicOn:Sprite;
      
      public var mcSizer_btnMusicOff:Sprite;
      
      public var mcSizer_btnSoundOn:Sprite;
      
      public var mcSizer_btnSoundOff:Sprite;
      
      public var mcSizer_btnSeePerksOn:Sprite;
      
      public var mcSizer_btnSeePerksOff:Sprite;
      
      public var mcSizer_btnPushNotificationsOn:Sprite;
      
      public var mcSizer_btnPushNotificationsOff:Sprite;
      
      public var mcSizer_btnLanguages:Sprite;
      
      public var mcButtonMarker_music:Sprite;
      
      public var mcButtonMarker_sound:Sprite;
      
      public var mcButtonMarker_seePerks:Sprite;
      
      public var mcButtonMarker_breathing:Sprite;
      
      public var mcButtonMarker_pushNotifications:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var btnBreathingOn:BMButton;
      
      public var btnBreathingOff:BMButton;
      
      public var btnParticlesMinus:BMButton_pictureE;
      
      public var btnParticlesPlus:BMButton_pictureE;
      
      public var btnQualityMinus:BMButton_pictureE;
      
      public var btnQualityPlus:BMButton_pictureE;
      
      public var btnMusicOn:BMButton;
      
      public var btnMusicOff:BMButton;
      
      public var btnSoundOn:BMButton;
      
      public var btnSoundOff:BMButton;
      
      public var btnSeePerksOn:BMButton;
      
      public var btnSeePerksOff:BMButton;
      
      public var btnPushNotificationsOn:BMButton;
      
      public var btnPushNotificationsOff:BMButton;
      
      public var btnLanguages:BMButton_pictureE;
      
      public var btnBack:BMButton_pictureE;
      
      public var txtTitle:TextField;
      
      public var txtMusic:TextField;
      
      public var txtSound:TextField;
      
      public var txtSeePerks:TextField;
      
      public var txtMechsBreathingTitle:TextField;
      
      public var txtParticleEffectsTitle:TextField;
      
      public var txtParticleEffectsLevel:TextField;
      
      public var txtQualityTitle:TextField;
      
      public var txtQualityLevel:TextField;
      
      public var txtQualityPerks:TextField;
      
      public var txtSelectLanguage:TextField;
      
      public var txtUnderConstruction:TextField;
      
      public var txtPushNotifications:TextField;
      
      public var mcLanguageButtonMarker:Sprite;
      
      private var _initialGameSettings:String;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenProfileOptions()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("options");
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
         var _loc10_:Function = null;
         var _loc11_:Function = null;
         var _loc12_:Function = null;
         var _loc13_:Function = null;
         var _loc14_:Function = null;
         var _loc15_:Function = null;
         if(this._firstRefresh)
         {
            if(dataM.runAsMobile == false)
            {
               screensM.createButtonFromSizer("screenProfileOptions","btnQualityMinus","pictureE");
               screensM.createButtonFromSizer("screenProfileOptions","btnQualityPlus","pictureE");
            }
            screensM.createButtonFromSizer("screenProfileOptions","btnBreathingOn","regular");
            screensM.createButtonFromSizer("screenProfileOptions","btnBreathingOff","regular");
            screensM.createButtonFromSizer("screenProfileOptions","btnParticlesMinus","pictureE");
            screensM.createButtonFromSizer("screenProfileOptions","btnParticlesPlus","pictureE");
            screensM.createButtonFromSizer("screenProfileOptions","btnMusicOn","regular");
            screensM.createButtonFromSizer("screenProfileOptions","btnMusicOff","regular");
            screensM.createButtonFromSizer("screenProfileOptions","btnSoundOn","regular");
            screensM.createButtonFromSizer("screenProfileOptions","btnSoundOff","regular");
            screensM.createButtonFromSizer("screenProfileOptions","btnSeePerksOn","regular");
            screensM.createButtonFromSizer("screenProfileOptions","btnSeePerksOff","regular");
            screensM.createButtonFromSizer("screenProfileOptions","btnPushNotificationsOn","regular");
            screensM.createButtonFromSizer("screenProfileOptions","btnPushNotificationsOff","regular");
            screensM.createButtonFromSizer("screenProfileOptions","btnLanguages","pictureE");
            screensM.createButtonFromSizer("screenProfileOptions","btnBack","pictureE");
            _loc1_ = this.breathingOnClicked;
            _loc2_ = this.breathingOffClicked;
            _loc3_ = this.pushNotificationsOnClicked;
            _loc4_ = this.pushNotificationsOffClicked;
            _loc5_ = this.particlesMinusClicked;
            _loc6_ = this.particlesPlusClicked;
            _loc7_ = this.qualityMinusClicked;
            _loc8_ = this.qualityPlusClicked;
            _loc9_ = this.musicOnClicked;
            _loc10_ = this.musicOffClicked;
            _loc11_ = this.soundOnClicked;
            _loc12_ = this.soundOffClicked;
            _loc13_ = this.seePerksOnClicked;
            _loc14_ = this.seePerksOffClicked;
            _loc15_ = this.languagesClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
               _loc2_ = null;
               _loc5_ = null;
               _loc6_ = null;
               _loc7_ = null;
               _loc8_ = null;
               _loc9_ = null;
               _loc10_ = null;
               _loc11_ = null;
               _loc12_ = null;
               _loc13_ = null;
               _loc14_ = null;
               _loc15_ = null;
            }
            if(dataM.runAsMobile == false)
            {
               this.btnQualityMinus.initialize("","",externalAssetsM.getAsset("general","interface_minus"),[],_loc7_,dataM.runAsMobile);
               this.btnQualityPlus.initialize("","",externalAssetsM.getAsset("general","interface_plus"),[],_loc8_,dataM.runAsMobile);
               this.btnQualityMinus.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
               this.btnQualityPlus.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            }
            this.btnBreathingOn.initialize(getScreenText("on"),"blue",null,[],_loc1_,dataM.runAsMobile);
            this.btnBreathingOff.initialize(getScreenText("off"),"blue",null,[],_loc2_,dataM.runAsMobile);
            this.btnParticlesMinus.initialize("","",externalAssetsM.getAsset("general","interface_minus"),[],_loc5_,dataM.runAsMobile);
            this.btnParticlesPlus.initialize("","",externalAssetsM.getAsset("general","interface_plus"),[],_loc6_,dataM.runAsMobile);
            this.btnSeePerksOff.initialize(getScreenText("on"),"blue",null,[],_loc14_,dataM.runAsMobile);
            this.btnSeePerksOn.initialize(getScreenText("off"),"blue",null,[],_loc13_,dataM.runAsMobile);
            this.btnPushNotificationsOn.initialize(getScreenText("on"),"blue",null,[],_loc3_,dataM.runAsMobile);
            this.btnPushNotificationsOff.initialize(getScreenText("off"),"blue",null,[],_loc4_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
            this.btnBreathingOn.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBreathingOff.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnParticlesMinus.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnParticlesPlus.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnPushNotificationsOn.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnPushNotificationsOff.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSeePerksOff.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSeePerksOn.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnMusicOn.initialize(getScreenText("on"),"blue",null,[],_loc9_,dataM.runAsMobile);
            this.btnMusicOff.initialize(getScreenText("off"),"blue",null,[],_loc10_,dataM.runAsMobile);
            this.btnSoundOn.initialize(getScreenText("on"),"blue",null,[],_loc11_,dataM.runAsMobile);
            this.btnSoundOff.initialize(getScreenText("off"),"blue",null,[],_loc12_,dataM.runAsMobile);
            this.btnLanguages.initialize("","",dataM.getLanguageIcon(dataM.languageID),[],_loc15_,dataM.runAsMobile);
            this.btnMusicOn.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnMusicOff.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSoundOn.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSoundOff.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSeePerksOn.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSeePerksOff.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnLanguages.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this._initialGameSettings = dataM.myProfile.gameSettings;
         this.refreshButtons();
         if(dataM.useLanguages)
         {
            this.btnLanguages.visible = true;
         }
         else
         {
            this.btnLanguages.visible = false;
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtMechsBreathingTitle,17);
            TextUtils.updateTextFormat(this.txtMusic,17);
            TextUtils.updateTextFormat(this.txtParticleEffectsLevel,17);
            TextUtils.updateTextFormat(this.txtParticleEffectsTitle,17);
            TextUtils.updateTextFormat(this.txtQualityLevel,17);
            TextUtils.updateTextFormat(this.txtQualityTitle,17);
            TextUtils.updateTextFormat(this.txtSelectLanguage,17);
            TextUtils.updateTextFormat(this.txtUnderConstruction,17);
            TextUtils.updateTextFormat(this.txtSound,17);
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.btnBreathingOff.txtButtonName,33);
            TextUtils.updateTextFormat(this.btnBreathingOn.txtButtonName,33);
            TextUtils.updateTextFormat(this.btnMusicOff.txtButtonName,33);
            TextUtils.updateTextFormat(this.btnMusicOn.txtButtonName,33);
            TextUtils.updateTextFormat(this.btnSoundOff.txtButtonName,33);
            TextUtils.updateTextFormat(this.btnSoundOn.txtButtonName,33);
            param1 = true;
         }
         this.txtTitle.text = getScreenText("title");
         this.txtMusic.text = getScreenText("music");
         this.txtSound.text = getScreenText("sound");
         this.txtSeePerks.text = getScreenText("seePerks");
         this.txtPushNotifications.text = getScreenText("pushNotifications");
         this.txtSelectLanguage.text = getScreenText("selectLanguage");
         if(dataM.runAsMobile)
         {
            this.txtQualityTitle.text = "";
            this.txtQualityLevel.text = "";
         }
         this.txtParticleEffectsTitle.text = getScreenText("particleEffects");
         this.txtMechsBreathingTitle.text = getScreenText("mechsBreathing");
         this.txtQualityTitle.text = getScreenText("quality");
         if(dataM.useLanguages)
         {
            this.txtUnderConstruction.visible = false;
         }
         else
         {
            this.txtUnderConstruction.text = getScreenText("underConstruction");
            this.txtUnderConstruction.visible = true;
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("profileOption_titles",[this.txtTitle,this.txtSelectLanguage,this.txtMusic,this.txtSound,this.txtParticleEffectsTitle,this.txtMechsBreathingTitle,this.txtQualityTitle,this.txtUnderConstruction],"",this);
         }
         if(param1)
         {
            this.btnBreathingOn.setButtonName(getScreenText("on"));
            this.btnBreathingOff.setButtonName(getScreenText("off"));
            this.btnMusicOn.setButtonName(getScreenText("on"));
            this.btnMusicOff.setButtonName(getScreenText("off"));
            this.btnSoundOn.setButtonName(getScreenText("on"));
            this.btnSoundOff.setButtonName(getScreenText("off"));
            this.btnSeePerksOn.setButtonName(getScreenText("on"));
            this.btnSeePerksOff.setButtonName(getScreenText("off"));
            this.btnPushNotificationsOn.setButtonName(getScreenText("on"));
            this.btnPushNotificationsOff.setButtonName(getScreenText("off"));
         }
      }
      
      private function refreshButtons() : void
      {
         if(dataM.runAsMobile == false)
         {
            this.refreshQualityButtons();
         }
         this.refreshQualityText();
         if(dataM.breathingEffect)
         {
            this.positionMarkerOnButton(this.mcButtonMarker_breathing,this.btnBreathingOn);
         }
         else
         {
            this.positionMarkerOnButton(this.mcButtonMarker_breathing,this.btnBreathingOff);
         }
         if(dataM.seeOpponentPerks)
         {
            this.positionMarkerOnButton(this.mcButtonMarker_seePerks,this.btnSeePerksOn);
         }
         else
         {
            this.positionMarkerOnButton(this.mcButtonMarker_seePerks,this.btnSeePerksOff);
         }
         this.refreshParticleEffectsButtons();
         this.refreshParticleEffectsText();
         if(dataM.myProfile.getSetting("music") == 1)
         {
            this.positionMarkerOnButton(this.mcButtonMarker_music,this.btnMusicOn);
         }
         else
         {
            this.positionMarkerOnButton(this.mcButtonMarker_music,this.btnMusicOff);
         }
         if(dataM.myProfile.getSetting("sound") == 1)
         {
            this.positionMarkerOnButton(this.mcButtonMarker_sound,this.btnSoundOn);
         }
         else
         {
            this.positionMarkerOnButton(this.mcButtonMarker_sound,this.btnSoundOff);
         }
         this.mcButtonMarker_pushNotifications.visible = true;
         this.btnPushNotificationsOn.enableMe();
         this.btnPushNotificationsOff.enableMe();
         if(BMNotificationsManager.getInstance().allowNotifications)
         {
            this.positionMarkerOnButton(this.mcButtonMarker_pushNotifications,this.btnPushNotificationsOn);
         }
         else
         {
            this.positionMarkerOnButton(this.mcButtonMarker_pushNotifications,this.btnPushNotificationsOff);
         }
      }
      
      private function positionMarkerOnButton(param1:Sprite, param2:BMButton) : void
      {
         param1.x = param2.x;
         param1.y = param2.y;
      }
      
      private function newLanguageSelected() : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
            this.refreshButtons();
            this.btnLanguages.replacePicture(dataM.getLanguageIcon());
         }
      }
      
      public function languagesClicked() : void
      {
         if(screensM.isScreenOpened("screenLanguageSelection"))
         {
            screensM.removeScreen("screenLanguageSelection");
         }
         else
         {
            screensM.addScreen("screenLanguageSelection");
            screensM.screenLanguageSelection.x = this.btnLanguages.x + this.btnLanguages.width + 5;
            screensM.screenLanguageSelection.y = this.btnLanguages.y - 4;
            screensM.screenLanguageSelection.refreshScreen(this.newLanguageSelected);
         }
      }
      
      private function refreshGameSettings(param1:String, param2:Number) : void
      {
         dataM.myProfile.setSetting(param1,param2);
      }
      
      public function breathingOnClicked() : void
      {
         dataM.breathingEffect = true;
         this.refreshGameSettings("breathing",1);
         this.refreshButtons();
      }
      
      public function breathingOffClicked() : void
      {
         dataM.breathingEffect = false;
         this.refreshGameSettings("breathing",0);
         this.refreshButtons();
      }
      
      public function particlesMinusClicked() : void
      {
         if(dataM.movieClipParticleEffectsLevel > 0)
         {
            --dataM.movieClipParticleEffectsLevel;
            if(dataM.movieClipParticleEffectsLevel == 0)
            {
               dataM.movieClipParticleEffects = false;
               effectsM.setAllSparksAndDebriesForDeletion();
            }
            else
            {
               dataM.movieClipParticleEffects = true;
            }
         }
         dataM.refreshMovieClipParticlesRatio();
         this.refreshParticleEffectsButtons();
         this.refreshParticleEffectsText();
         this.refreshGameSettings("particles",dataM.movieClipParticleEffectsLevel);
      }
      
      public function particlesPlusClicked() : void
      {
         if(dataM.movieClipParticleEffectsLevel < 3)
         {
            ++dataM.movieClipParticleEffectsLevel;
         }
         dataM.movieClipParticleEffects = true;
         dataM.refreshMovieClipParticlesRatio();
         this.refreshParticleEffectsButtons();
         this.refreshParticleEffectsText();
         this.refreshGameSettings("particles",dataM.movieClipParticleEffectsLevel);
      }
      
      private function refreshParticleEffectsButtons() : void
      {
         this.btnParticlesMinus.enableMe();
         this.btnParticlesPlus.enableMe();
         if(dataM.movieClipParticleEffectsLevel == 0)
         {
            this.btnParticlesMinus.disableMe();
         }
         else if(dataM.movieClipParticleEffectsLevel == 3)
         {
            this.btnParticlesPlus.disableMe();
         }
      }
      
      private function refreshParticleEffectsText() : void
      {
         switch(dataM.movieClipParticleEffectsLevel)
         {
            case 0:
               this.txtParticleEffectsLevel.text = getScreenText("off");
               break;
            case 1:
               this.txtParticleEffectsLevel.text = getScreenText("low");
               break;
            case 2:
               this.txtParticleEffectsLevel.text = getScreenText("medium");
               break;
            case 3:
               this.txtParticleEffectsLevel.text = getScreenText("high");
         }
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("profileOptions_txtParticleEffectsLevel",[this.txtParticleEffectsLevel],"",this);
         }
      }
      
      public function qualityMinusClicked() : void
      {
         switch(screensM.stagePointer.quality)
         {
            case "BEST":
            case "best":
            case "HIGH":
            case "high":
               screensM.stagePointer.quality = StageQuality.MEDIUM;
               break;
            case "MEDIUM":
            case "medium":
               screensM.stagePointer.quality = StageQuality.LOW;
         }
         this.refreshQualityButtons();
         this.refreshQualityText();
         this.refreshGameSettings("quality",this.getQualityNumber());
      }
      
      public function qualityPlusClicked() : void
      {
         switch(screensM.stagePointer.quality)
         {
            case "MEDIUM":
            case "medium":
               screensM.stagePointer.quality = StageQuality.HIGH;
               break;
            case "LOW":
            case "low":
               screensM.stagePointer.quality = StageQuality.MEDIUM;
         }
         this.refreshQualityButtons();
         this.refreshQualityText();
         this.refreshGameSettings("quality",this.getQualityNumber());
      }
      
      private function refreshQualityButtons() : void
      {
         this.btnQualityMinus.enableMe();
         this.btnQualityPlus.enableMe();
         switch(screensM.stagePointer.quality)
         {
            case "BEST":
            case "best":
            case "HIGH":
            case "high":
               this.btnQualityPlus.disableMe();
               break;
            case "LOW":
            case "low":
               this.btnQualityMinus.disableMe();
         }
      }
      
      private function refreshQualityText() : void
      {
         if(dataM.runAsMobile)
         {
            this.txtQualityLevel.text = getScreenText("high");
            screensM.createMultipleTextsBitmap("profileOptions_txtQualityLevel",[this.txtQualityLevel],"",this);
         }
         else
         {
            switch(screensM.stagePointer.quality)
            {
               case "BEST":
               case "best":
               case "HIGH":
               case "high":
                  this.txtQualityLevel.text = getScreenText("high");
                  break;
               case "MEDIUM":
               case "medium":
                  this.txtQualityLevel.text = getScreenText("medium");
                  break;
               case "LOW":
               case "low":
                  this.txtQualityLevel.text = getScreenText("low");
            }
         }
      }
      
      private function getQualityNumber() : Number
      {
         var _loc1_:Number = 2;
         switch(screensM.stagePointer.quality)
         {
            case "MEDIUM":
            case "medium":
               _loc1_ = 1;
               break;
            case "LOW":
            case "low":
               _loc1_ = 0;
         }
         return _loc1_;
      }
      
      public function musicOnClicked() : void
      {
         if(dataM.myProfile.getSetting("music") == 0)
         {
            soundM.setMusic(true,screensM.isScreenOpened("screenBattle"));
            this.refreshGameSettings("music",1);
            this.refreshButtons();
         }
      }
      
      public function musicOffClicked() : void
      {
         if(dataM.myProfile.getSetting("music") == 1)
         {
            soundM.setMusic(false,screensM.isScreenOpened("screenBattle"));
            this.refreshGameSettings("music",0);
            this.refreshButtons();
         }
      }
      
      public function pushNotificationsOnClicked() : void
      {
         BMNotificationsManager.getInstance().allowNotifications = true;
         this.refreshButtons();
      }
      
      public function pushNotificationsOffClicked() : void
      {
         BMNotificationsManager.getInstance().allowNotifications = false;
         this.refreshButtons();
      }
      
      public function seePerksOnClicked() : void
      {
         dataM.seeOpponentPerks = true;
         this.refreshGameSettings("seePerks",1);
         this.refreshButtons();
      }
      
      public function seePerksOffClicked() : void
      {
         dataM.seeOpponentPerks = false;
         this.refreshGameSettings("seePerks",0);
         this.refreshButtons();
      }
      
      public function soundOnClicked() : void
      {
         if(dataM.myProfile.getSetting("sound") == 0)
         {
            soundM.setSound(true);
            this.refreshGameSettings("sound",1);
            this.refreshButtons();
         }
      }
      
      public function soundOffClicked() : void
      {
         if(dataM.myProfile.getSetting("sound") == 1)
         {
            soundM.setSound(false);
            this.refreshGameSettings("sound",0);
            this.refreshButtons();
         }
      }
      
      public function backClicked() : void
      {
         screensM.screenNewMenu.mainMenu();
      }
      
      public function removeMe() : void
      {
         trace("_initialGameSettings:" + this._initialGameSettings + " dataM.myProfile.gameSettings:" + dataM.myProfile.gameSettings);
         if(this._initialGameSettings != dataM.myProfile.gameSettings)
         {
            remoteM.lobby_setSettings(dataM.myProfile.gameSettings);
         }
         if(screensM.isScreenOpened("screenLanguageSelection"))
         {
            screensM.removeScreen("screenLanguageSelection");
         }
         screensM.removeScreen("screenProfileOptions");
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen();
      }
   }
}

