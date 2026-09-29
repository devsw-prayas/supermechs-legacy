package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageQuality;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3717")]
   public class BMScreenBattleOptions extends BMBaseScreen
   {
      
      public var mcIconsHolder:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var mcLines:MovieClip;
      
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
      
      public var mcSizer_btnPerformanceFrame:Sprite;
      
      public var mcSizer_btnPerformanceTimer1:Sprite;
      
      public var mcSizer_btnPerformanceTimer2:Sprite;
      
      public var mcSizer_btnPerformanceTimer3:Sprite;
      
      public var mcSizer_btnPerformanceTimer10:Sprite;
      
      public var mcSizer_btnSlowCPUOff:Sprite;
      
      public var mcSizer_btnSlowCPUOn:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcButtonMarker_music:Sprite;
      
      public var mcButtonMarker_sound:Sprite;
      
      public var mcButtonMarker_breathing:Sprite;
      
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
      
      public var btnPerformanceFrame:BMButton;
      
      public var btnPerformanceTimer1:BMButton;
      
      public var btnPerformanceTimer2:BMButton;
      
      public var btnPerformanceTimer3:BMButton;
      
      public var btnPerformanceTimer10:BMButton;
      
      public var btnSlowCPUOff:BMButton;
      
      public var btnSlowCPUOn:BMButton;
      
      public var btnBack:BMButton_pictureE;
      
      public var txtTitle:TextField;
      
      public var txtMusic:TextField;
      
      public var txtSound:TextField;
      
      public var txtMechsBreathingTitle:TextField;
      
      public var txtParticleEffectsTitle:TextField;
      
      public var txtParticleEffectsLevel:TextField;
      
      public var txtQualityTitle:TextField;
      
      public var txtQualityLevel:TextField;
      
      private var _initialGameSettings:String;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenBattleOptions()
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
         if(this._firstRefresh)
         {
            if(dataM.runAsMobile == false)
            {
               screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnQualityMinus","pictureE");
               screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnQualityPlus","pictureE");
            }
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnBreathingOn","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnBreathingOff","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnParticlesMinus","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnParticlesPlus","pictureE");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnMusicOn","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnMusicOff","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnSoundOn","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnSoundOff","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnPerformanceFrame","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnPerformanceTimer1","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnPerformanceTimer2","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnPerformanceTimer3","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnPerformanceTimer10","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnSlowCPUOff","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnSlowCPUOn","regular");
            screensM.createButtonFromSizer(BMScreensManager.SCR_BATTLE_OPTIONS,"btnBack","pictureE");
            _loc2_ = this.breathingOnClicked;
            _loc3_ = this.breathingOffClicked;
            _loc4_ = this.particlesMinusClicked;
            _loc5_ = this.particlesPlusClicked;
            _loc6_ = this.qualityMinusClicked;
            _loc7_ = this.qualityPlusClicked;
            _loc8_ = this.musicOnClicked;
            _loc9_ = this.musicOffClicked;
            _loc10_ = this.soundOnClicked;
            _loc11_ = this.soundOffClicked;
            _loc12_ = this.performanceClicked;
            _loc13_ = this.backClicked;
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
               _loc3_ = null;
               _loc4_ = null;
               _loc5_ = null;
               _loc6_ = null;
               _loc7_ = null;
               _loc8_ = null;
               _loc9_ = null;
               _loc10_ = null;
               _loc11_ = null;
               _loc12_ = null;
               _loc13_ = null;
            }
            if(!dataM.runAsMobile)
            {
               this.btnQualityMinus.initialize("","",externalAssetsM.getAsset("general","interface_minus"),[],_loc6_,dataM.runAsMobile);
               this.btnQualityPlus.initialize("","",externalAssetsM.getAsset("general","interface_plus"),[],_loc7_,dataM.runAsMobile);
               this.btnQualityMinus.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
               this.btnQualityPlus.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            }
            this.btnBreathingOn.initialize(getScreenText("on"),"blue",null,[],_loc2_,dataM.runAsMobile);
            this.btnBreathingOff.initialize(getScreenText("off"),"blue",null,[],_loc3_,dataM.runAsMobile);
            this.btnParticlesMinus.initialize("","",externalAssetsM.getAsset("general","interface_minus"),[],_loc4_,dataM.runAsMobile);
            this.btnParticlesPlus.initialize("","",externalAssetsM.getAsset("general","interface_plus"),[],_loc5_,dataM.runAsMobile);
            this.btnMusicOn.initialize(getScreenText("on"),"blue",null,[],_loc8_,dataM.runAsMobile);
            this.btnMusicOff.initialize(getScreenText("off"),"blue",null,[],_loc9_,dataM.runAsMobile);
            this.btnSoundOn.initialize(getScreenText("on"),"blue",null,[],_loc10_,dataM.runAsMobile);
            this.btnSoundOff.initialize(getScreenText("off"),"blue",null,[],_loc11_,dataM.runAsMobile);
            this.btnPerformanceFrame.initialize("FRAME","",null,["frame"],_loc12_,dataM.runAsMobile);
            this.btnPerformanceTimer1.initialize("T1 : 15","",null,["timer1"],_loc12_,dataM.runAsMobile);
            this.btnPerformanceTimer2.initialize("T2 : 35","",null,["timer2"],_loc12_,dataM.runAsMobile);
            this.btnPerformanceTimer3.initialize("T3 : 45","",null,["timer3"],_loc12_,dataM.runAsMobile);
            this.btnPerformanceTimer10.initialize("T10 : 100","",null,["timer10"],_loc12_,dataM.runAsMobile);
            this.btnSlowCPUOff.initialize("SLOW OFF","",null,["slowOff"],_loc12_,dataM.runAsMobile);
            this.btnSlowCPUOn.initialize("SLOW ON","",null,["slowOn"],_loc12_,dataM.runAsMobile);
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc13_,dataM.runAsMobile);
            this.btnBreathingOn.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnBreathingOff.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnParticlesMinus.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnParticlesPlus.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnMusicOn.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnMusicOff.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSoundOn.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSoundOff.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
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
         this.btnPerformanceFrame.visible = false;
         this.btnPerformanceTimer1.visible = false;
         this.btnPerformanceTimer2.visible = false;
         this.btnPerformanceTimer3.visible = false;
         this.btnPerformanceTimer10.visible = false;
         this.btnSlowCPUOff.visible = false;
         this.btnSlowCPUOn.visible = false;
         if(dataM.specialUser || dataM.clientRunningLocally)
         {
            this.btnPerformanceFrame.visible = true;
            this.btnPerformanceTimer1.visible = true;
            this.btnPerformanceTimer2.visible = true;
            this.btnPerformanceTimer3.visible = true;
            this.btnPerformanceTimer10.visible = true;
            this.btnSlowCPUOff.visible = true;
            this.btnSlowCPUOn.visible = true;
         }
      }
      
      private function languageUpdate() : void
      {
         updateTextAndFormat(this.txtTitle,getScreenText("title"));
         updateTextAndFormat(this.txtMusic,getScreenText("music"));
         updateTextAndFormat(this.txtSound,getScreenText("sound"));
         updateTextAndFormat(this.txtParticleEffectsTitle,getScreenText("particleEffects"));
         updateTextAndFormat(this.txtMechsBreathingTitle,getScreenText("mechsBreathing"));
         updateTextAndFormat(this.txtQualityTitle,getScreenText("quality"));
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("battleOption_titles",[this.txtTitle,this.txtMusic,this.txtSound,this.txtParticleEffectsTitle,this.txtMechsBreathingTitle,this.txtQualityTitle],"",this);
         }
         this.btnBreathingOn.setButtonName(getScreenText("on"));
         this.btnBreathingOff.setButtonName(getScreenText("off"));
         this.btnMusicOn.setButtonName(getScreenText("on"));
         this.btnMusicOff.setButtonName(getScreenText("off"));
         this.btnSoundOn.setButtonName(getScreenText("on"));
         this.btnSoundOff.setButtonName(getScreenText("off"));
      }
      
      public function performanceClicked(param1:String) : void
      {
         switch(param1)
         {
            case "slowOff":
               dataM.generalSpeedRatio = 1;
               break;
            case "slowOn":
               dataM.generalSpeedRatio = 2;
               break;
            default:
               screensM.setOnEnterFrameType(param1);
         }
      }
      
      private function refreshButtons() : void
      {
         if(dataM.runAsMobile == false)
         {
            this.refreshQualityButtons();
         }
         this.refreshParticleEffectsButtons();
         this.refreshParticleEffectsText();
         this.refreshQualityText();
         if(dataM.myProfile.getSetting("music") == 1)
         {
            this.mcButtonMarker_music.x = this.btnMusicOn.x;
            this.mcButtonMarker_music.y = this.btnMusicOn.y;
         }
         else
         {
            this.mcButtonMarker_music.x = this.btnMusicOff.x;
            this.mcButtonMarker_music.y = this.btnMusicOff.y;
         }
         if(dataM.myProfile.getSetting("sound") == 1)
         {
            this.mcButtonMarker_sound.x = this.btnSoundOn.x;
            this.mcButtonMarker_sound.y = this.btnSoundOn.y;
         }
         else
         {
            this.mcButtonMarker_sound.x = this.btnSoundOff.x;
            this.mcButtonMarker_sound.y = this.btnSoundOff.y;
         }
      }
      
      public function refreshGameSettings(param1:String, param2:Number) : void
      {
         var _loc3_:BMPlayerProfile = null;
         if(dataM.gameType != BMDataManager.GAME_TYPE_TUTORIAL)
         {
            _loc3_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
            _loc3_.setSetting(param1,param2);
         }
      }
      
      public function breathingOnClicked() : void
      {
         dataM.breathingEffect = true;
         this.refreshGameSettings("breathing",1);
         this.refreshButtons();
         this.mcButtonMarker_breathing.x = this.btnBreathingOn.x;
      }
      
      public function breathingOffClicked() : void
      {
         dataM.breathingEffect = false;
         this.refreshGameSettings("breathing",0);
         this.refreshButtons();
         this.mcButtonMarker_breathing.x = this.btnBreathingOff.x;
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
         var _loc1_:String = "";
         switch(dataM.movieClipParticleEffectsLevel)
         {
            case 0:
               _loc1_ = getScreenText("off");
               break;
            case 1:
               _loc1_ = getScreenText("low");
               break;
            case 2:
               _loc1_ = getScreenText("medium");
               break;
            case 3:
               _loc1_ = getScreenText("high");
         }
         updateTextAndFormat(this.txtParticleEffectsLevel,_loc1_);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("battleOptions_txtParticleEffectsLevel",[this.txtParticleEffectsLevel],"",this);
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
         var _loc1_:String = "";
         if(dataM.runAsMobile)
         {
            _loc1_ = getScreenText("high");
         }
         else
         {
            switch(screensM.stagePointer.quality)
            {
               case "BEST":
               case "best":
               case "HIGH":
               case "high":
                  _loc1_ = getScreenText("high");
                  break;
               case "MEDIUM":
               case "medium":
                  _loc1_ = getScreenText("medium");
                  break;
               case "LOW":
               case "low":
                  _loc1_ = getScreenText("low");
            }
         }
         updateTextAndFormat(this.txtQualityLevel,_loc1_);
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("battleOptions_txtQualityLevel",[this.txtQualityLevel],"",this);
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
            soundM.setMusic(true,screensM.isScreenOpened(BMScreensManager.SCR_BATTLE));
            this.refreshGameSettings("music",1);
            this.refreshButtons();
         }
      }
      
      public function musicOffClicked() : void
      {
         if(dataM.myProfile.getSetting("music") == 1)
         {
            soundM.setMusic(false,screensM.isScreenOpened(BMScreensManager.SCR_BATTLE));
            this.refreshGameSettings("music",0);
            this.refreshButtons();
         }
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
         var _loc1_:BMPlayerProfile = null;
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE))
         {
            screensM.stagePointer.focus = screensM.screenBattle;
         }
         if(dataM.gameType != BMDataManager.GAME_TYPE_TUTORIAL)
         {
            _loc1_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
            if(this._initialGameSettings != _loc1_.gameSettings)
            {
               remoteM.lobby_setSettings(_loc1_.gameSettings);
            }
         }
         screensM.removeScreen(BMScreensManager.SCR_BATTLE_OPTIONS);
      }
   }
}

