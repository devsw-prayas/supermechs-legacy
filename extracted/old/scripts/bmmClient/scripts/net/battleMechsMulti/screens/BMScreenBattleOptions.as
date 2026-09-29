package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.StageQuality;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1410")]
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
               screensM.createButtonFromSizer("screenBattleOptions","btnQualityMinus","pictureE");
               screensM.createButtonFromSizer("screenBattleOptions","btnQualityPlus","pictureE");
            }
            screensM.createButtonFromSizer("screenBattleOptions","btnBreathingOn","regular");
            screensM.createButtonFromSizer("screenBattleOptions","btnBreathingOff","regular");
            screensM.createButtonFromSizer("screenBattleOptions","btnParticlesMinus","pictureE");
            screensM.createButtonFromSizer("screenBattleOptions","btnParticlesPlus","pictureE");
            screensM.createButtonFromSizer("screenBattleOptions","btnMusicOn","regular");
            screensM.createButtonFromSizer("screenBattleOptions","btnMusicOff","regular");
            screensM.createButtonFromSizer("screenBattleOptions","btnSoundOn","regular");
            screensM.createButtonFromSizer("screenBattleOptions","btnSoundOff","regular");
            screensM.createButtonFromSizer("screenBattleOptions","btnPerformanceFrame","regular");
            screensM.createButtonFromSizer("screenBattleOptions","btnPerformanceTimer1","regular");
            screensM.createButtonFromSizer("screenBattleOptions","btnPerformanceTimer2","regular");
            screensM.createButtonFromSizer("screenBattleOptions","btnPerformanceTimer3","regular");
            screensM.createButtonFromSizer("screenBattleOptions","btnPerformanceTimer10","regular");
            screensM.createButtonFromSizer("screenBattleOptions","btnSlowCPUOff","regular");
            screensM.createButtonFromSizer("screenBattleOptions","btnSlowCPUOn","regular");
            screensM.createButtonFromSizer("screenBattleOptions","btnBack","pictureE");
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
            if(dataM.runAsMobile)
            {
               this.btnMusicOn.changeFontSize(34);
               this.btnMusicOff.changeFontSize(34);
               this.btnSoundOn.changeFontSize(34);
               this.btnSoundOff.changeFontSize(34);
            }
            else
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
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            _loc2_ = 17;
            switch(dataM.languageID)
            {
               case 3:
                  _loc2_ = 14;
            }
            TextUtils.updateTextFormat(this.txtMechsBreathingTitle,_loc2_);
            TextUtils.updateTextFormat(this.txtMusic,17);
            TextUtils.updateTextFormat(this.txtParticleEffectsLevel,17);
            TextUtils.updateTextFormat(this.txtParticleEffectsTitle,17);
            TextUtils.updateTextFormat(this.txtQualityLevel,17);
            TextUtils.updateTextFormat(this.txtQualityTitle,17);
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
         this.txtParticleEffectsTitle.text = getScreenText("particleEffects");
         this.txtMechsBreathingTitle.text = getScreenText("mechsBreathing");
         this.txtQualityTitle.text = getScreenText("quality");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("battleOption_titles",[this.txtTitle,this.txtMusic,this.txtSound,this.txtParticleEffectsTitle,this.txtMechsBreathingTitle,this.txtQualityTitle],"",this);
         }
         if(param1)
         {
            this.btnBreathingOn.setButtonName(getScreenText("on"));
            this.btnBreathingOff.setButtonName(getScreenText("off"));
            this.btnMusicOn.setButtonName(getScreenText("on"));
            this.btnMusicOff.setButtonName(getScreenText("off"));
            this.btnSoundOn.setButtonName(getScreenText("on"));
            this.btnSoundOff.setButtonName(getScreenText("off"));
         }
      }
      
      public function performanceClicked(param1:String) : void
      {
         switch(param1)
         {
            case "slowOff":
               dataM.slowCPUMode = false;
               dataM.generalSpeedRatio = 1;
               break;
            case "slowOn":
               dataM.slowCPUMode = true;
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
         if(soundM.music)
         {
            this.mcButtonMarker_music.x = this.btnMusicOn.x;
            this.mcButtonMarker_music.y = this.btnMusicOn.y;
         }
         else
         {
            this.mcButtonMarker_music.x = this.btnMusicOff.x;
            this.mcButtonMarker_music.y = this.btnMusicOff.y;
         }
         if(soundM.sound)
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
            _loc4_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
            _loc4_.setSetting(param1,param2);
         }
      }
      
      public function breathingOnClicked() : void
      {
         dataM.breathingEffect = true;
         this.refreshButtons();
         this.refreshGameSettings("breathing",1);
         this.mcButtonMarker_breathing.x = this.btnBreathingOn.x;
      }
      
      public function breathingOffClicked() : void
      {
         dataM.breathingEffect = false;
         this.refreshButtons();
         this.refreshGameSettings("breathing",0);
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
         if(dataM.runAsMobile)
         {
            this.txtQualityLevel.text = getScreenText("high");
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("battleOptions_txtQualityLevel",[this.txtQualityLevel],"",this);
            }
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
         var _loc2_:BMPlayerProfile = null;
         if(screensM.isScreenOpened("screenBattle"))
         {
            screensM.stagePointer.focus = screensM.screenBattle;
         }
         var _loc1_:Boolean = false;
         switch(dataM.gameType)
         {
            case BMDataManager.GAME_TYPE_ONLINE:
               _loc1_ = true;
               break;
            case BMDataManager.GAME_TYPE_REPLAY:
               _loc1_ = true;
         }
         if(_loc1_)
         {
            _loc2_ = dataM["player" + dataM.ONLINE_PLAYER_ID + "Profile"];
            if(this._initialGameSettings != _loc2_.gameSettings)
            {
               remoteM.lobby_setSettings(_loc2_.gameSettings);
            }
         }
         screensM.removeScreen("screenBattleOptions");
      }
   }
}

