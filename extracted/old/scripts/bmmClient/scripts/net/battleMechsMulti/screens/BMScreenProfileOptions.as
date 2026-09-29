package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.display.StageQuality;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol622")]
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
         var _loc16_:Function = null;
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
            _loc2_ = this.breathingOnClicked;
            _loc3_ = this.breathingOffClicked;
            _loc4_ = this.pushNotificationsOnClicked;
            _loc5_ = this.pushNotificationsOffClicked;
            _loc6_ = this.particlesMinusClicked;
            _loc7_ = this.particlesPlusClicked;
            _loc8_ = this.qualityMinusClicked;
            _loc9_ = this.qualityPlusClicked;
            _loc10_ = this.musicOnClicked;
            _loc11_ = this.musicOffClicked;
            _loc12_ = this.soundOnClicked;
            _loc13_ = this.soundOffClicked;
            _loc14_ = this.seePerksOnClicked;
            _loc15_ = this.seePerksOffClicked;
            _loc16_ = this.languagesClicked;
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
               _loc3_ = null;
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
               _loc16_ = null;
            }
            if(dataM.runAsMobile == false)
            {
               this.btnQualityMinus.initialize("","",externalAssetsM.getAsset("general","interface_minus"),[],_loc8_,dataM.runAsMobile);
               this.btnQualityPlus.initialize("","",externalAssetsM.getAsset("general","interface_plus"),[],_loc9_,dataM.runAsMobile);
               this.btnQualityMinus.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
               this.btnQualityPlus.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            }
            this.btnBreathingOn.initialize(getScreenText("on"),"blue",null,[],_loc2_,dataM.runAsMobile);
            this.btnBreathingOff.initialize(getScreenText("off"),"blue",null,[],_loc3_,dataM.runAsMobile);
            this.btnParticlesMinus.initialize("","",externalAssetsM.getAsset("general","interface_minus"),[],_loc6_,dataM.runAsMobile);
            this.btnParticlesPlus.initialize("","",externalAssetsM.getAsset("general","interface_plus"),[],_loc7_,dataM.runAsMobile);
            this.btnSeePerksOff.initialize(getScreenText("on"),"blue",null,[],_loc15_,dataM.runAsMobile);
            this.btnSeePerksOn.initialize(getScreenText("off"),"blue",null,[],_loc14_,dataM.runAsMobile);
            this.btnPushNotificationsOn.initialize(getScreenText("on"),"blue",null,[],_loc4_,dataM.runAsMobile);
            this.btnPushNotificationsOff.initialize(getScreenText("off"),"blue",null,[],_loc5_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,this.backClicked,false);
            this.btnBreathingOn.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBreathingOff.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnParticlesMinus.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnParticlesPlus.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnPushNotificationsOn.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnPushNotificationsOff.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSeePerksOff.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSeePerksOn.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnMusicOn.initialize(getScreenText("on"),"blue",null,[],_loc10_,dataM.runAsMobile);
            this.btnMusicOff.initialize(getScreenText("off"),"blue",null,[],_loc11_,dataM.runAsMobile);
            this.btnSoundOn.initialize(getScreenText("on"),"blue",null,[],_loc12_,dataM.runAsMobile);
            this.btnSoundOff.initialize(getScreenText("off"),"blue",null,[],_loc13_,dataM.runAsMobile);
            this.btnLanguages.initialize("","",dataM.getLanguageIcon(dataM.languageID),[],_loc16_,dataM.runAsMobile);
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
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         this._initialGameSettings = _loc1_.gameSettings;
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
         if(soundM.music)
         {
            this.positionMarkerOnButton(this.mcButtonMarker_music,this.btnMusicOn);
         }
         else
         {
            this.positionMarkerOnButton(this.mcButtonMarker_music,this.btnMusicOff);
         }
         if(soundM.sound)
         {
            this.positionMarkerOnButton(this.mcButtonMarker_sound,this.btnSoundOn);
         }
         else
         {
            this.positionMarkerOnButton(this.mcButtonMarker_sound,this.btnSoundOff);
         }
         this.mcButtonMarker_pushNotifications.visible = false;
         this.btnPushNotificationsOn.disableMe();
         this.btnPushNotificationsOff.disableMe();
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
      
      public function refreshGameSettings(param1:String, param2:Number) : void
      {
         var _loc4_:BMPlayerProfile = null;
         var _loc3_:Boolean = false;
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_ONLINE:
               _loc3_ = true;
               break;
            case BMDataManager.GAME_TYPE_REPLAY:
               _loc3_ = true;
         }
         if(_loc3_)
         {
            _loc4_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc4_.setSetting(param1,param2);
         }
      }
      
      public function breathingOnClicked() : void
      {
         dataM.breathingEffect = true;
         this.refreshButtons();
         this.refreshGameSettings("breathing",1);
      }
      
      public function breathingOffClicked() : void
      {
         dataM.breathingEffect = false;
         this.refreshButtons();
         this.refreshGameSettings("breathing",0);
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
         if(soundM.music == false)
         {
            soundM.setMusic(true,screensM.isScreenOpened("screenBattle"));
            this.refreshButtons();
            this.refreshGameSettings("music",1);
         }
      }
      
      public function musicOffClicked() : void
      {
         if(soundM.music)
         {
            soundM.setMusic(false,screensM.isScreenOpened("screenBattle"));
            this.refreshButtons();
            this.refreshGameSettings("music",0);
         }
      }
      
      public function pushNotificationsOnClicked() : void
      {
      }
      
      public function pushNotificationsOffClicked() : void
      {
      }
      
      public function seePerksOnClicked() : void
      {
         dataM.seeOpponentPerks = true;
         this.refreshButtons();
         this.refreshGameSettings("seePerks",1);
      }
      
      public function seePerksOffClicked() : void
      {
         dataM.seeOpponentPerks = false;
         this.refreshButtons();
         this.refreshGameSettings("seePerks",0);
      }
      
      public function soundOnClicked() : void
      {
         if(soundM.sound == false)
         {
            soundM.setSound(true);
            this.refreshButtons();
            this.refreshGameSettings("sound",1);
         }
      }
      
      public function soundOffClicked() : void
      {
         if(soundM.sound)
         {
            soundM.setSound(false);
            this.refreshButtons();
            this.refreshGameSettings("sound",0);
         }
      }
      
      public function backClicked() : void
      {
         screensM.screenNewMenu.mainMenu();
      }
      
      public function removeMe() : void
      {
         var _loc1_:BMPlayerProfile = null;
         if(dataM.gameType == BMDataManager.GAME_TYPE_ONLINE)
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(this._initialGameSettings != _loc1_.gameSettings)
            {
               remoteM.lobby_setSettings(_loc1_.gameSettings);
            }
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

