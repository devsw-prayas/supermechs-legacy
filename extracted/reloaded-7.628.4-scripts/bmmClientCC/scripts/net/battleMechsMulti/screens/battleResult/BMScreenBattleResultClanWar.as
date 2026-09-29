package net.battleMechsMulti.screens.battleResult
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.easing.Back;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTipsManager;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3687")]
   public class BMScreenBattleResultClanWar extends BMScreenBattleResultBase
   {
      
      public var mcTitle:TextHolder;
      
      public var mcScore:TextHolder;
      
      public var mcHighestScore:TextHolder;
      
      public var mcHighestScorePlayer:TextHolder;
      
      public var mcBg:Sprite;
      
      public var mcBannerLeft:Sprite;
      
      public var mcBannerRight:Sprite;
      
      public var mcSwordLeft:Sprite;
      
      public var mcSwordRight:Sprite;
      
      public var mcRays:Sprite;
      
      public var mcSparksHolder:Sprite;
      
      public var mcGlowWin:Sprite;
      
      public var mcSkipHitArea:MovieClip;
      
      public var continueBtn:BMBasicButton;
      
      public var mcTip:MovieClip;
      
      private var _timeLine:TimelineMax;
      
      private var _isAnimComplete:Boolean = false;
      
      public function BMScreenBattleResultClanWar()
      {
         super();
      }
      
      override public function initialize() : void
      {
         super.initialize();
         this.initBtns();
         this.initTexts();
      }
      
      private function initBtns() : void
      {
         this.mcSkipHitArea.addEventListener(MouseEvent.CLICK,this.onSkipAnimClick);
         this.continueBtn.addEventListener(BMIntractable.HIT,this.onContinueClick);
         this.continueBtn.text = getScreenText("continue");
      }
      
      private function initTexts() : void
      {
         this.mcTitle.text = getScreenText("victory2");
         var _loc1_:String = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>";
         var _loc2_:Array = dataM.clanWarsM.battleResultMessage;
         this.mcScore.text = _loc2_[0];
         this.mcHighestScore.text = _loc2_[1] == null ? "" : _loc2_[1];
         this.mcHighestScorePlayer.text = _loc2_[2] == null ? "" : _loc2_[2];
         var _loc3_:uint = BMTipsManager.TIP_TYPE_DEFAULT;
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVE && dataM.myProfile.lastBattleResult == BMDataManager.BATTLE_RESULT_LOSS)
         {
            _loc3_ = BMTipsManager.TIP_TYPE_PVE_LOSS;
         }
         this.mcTip.text = dataM.tipsManager.getTip(true,_loc3_);
      }
      
      override public function refreshScreen() : void
      {
         super.refreshScreen();
         screensM.removeScreen(BMScreensManager.SCR_CONFIRMATION);
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_OPTIONS))
         {
            screensM.removeScreen(BMScreensManager.SCR_BATTLE_OPTIONS);
         }
         if(screensM.isScreenOpened(BMScreensManager.SCR_BATTLE_INTERFACE_TOP))
         {
            screensM.screenBattleInterfaceTop.moveScreenUp();
         }
         this.doAnim();
      }
      
      private function doAnim() : void
      {
         this.continueBtn.disableMe();
         this._isAnimComplete = false;
         this._timeLine = new TimelineMax({"onComplete":this.onAnimComplete});
         this._timeLine.fromTo(this,0.5,{"y":-500},{
            "y":0,
            "ease":Back.easeOut
         });
         this._timeLine.fromTo(this.mcBg,0.5,{"alpha":0},{"alpha":1},0);
         this._timeLine.addLabel("banners");
         this._timeLine.fromTo(this.mcBannerLeft,0.3,{"x":this.mcBannerLeft.x + this.mcBannerLeft.width},{
            "x":this.mcBannerLeft.x,
            "ease":Back.easeOut
         },"banners");
         this._timeLine.fromTo(this.mcBannerRight,0.3,{"x":this.mcBannerRight.x - this.mcBannerRight.width},{
            "x":this.mcBannerRight.x,
            "ease":Back.easeOut
         },"banners");
         this._timeLine.addLabel("swords","-=0.2");
         this._timeLine.fromTo(this.mcSwordRight,0.3,{"rotation":this.mcSwordRight.rotation - 90},{
            "rotation":this.mcSwordRight.rotation,
            "ease":Back.easeOut
         },"swords");
         this._timeLine.fromTo(this.mcSwordLeft,0.3,{"rotation":this.mcSwordLeft.rotation + 90},{
            "rotation":this.mcSwordLeft.rotation,
            "ease":Back.easeOut
         },"swords");
         this._timeLine.fromTo(this.mcTitle,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         });
         this._timeLine.fromTo(this.mcScore,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         },"-=0.1");
         this._timeLine.fromTo(this.mcHighestScore,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         },"-=0.2");
         this._timeLine.fromTo(this.mcHighestScorePlayer,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         },"-=0.3");
         this._timeLine.addLabel("btns");
         this._timeLine.fromTo(this.continueBtn,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         },"btns");
         this._timeLine.fromTo(this.mcTip,0.3,{"alpha":0},{"alpha":1});
         this._timeLine.addLabel("end");
         TweenMax.fromTo(this.mcRays,50,{"rotation":0},{
            "rotation":360,
            "repeat":-1
         });
         TweenMax.fromTo(this.mcRays,2,{"alpha":0.5},{
            "alpha":1,
            "repeat":-1,
            "yoyo":true,
            "overwrite":0
         });
      }
      
      private function onAnimComplete() : *
      {
         if(this._isAnimComplete)
         {
            return;
         }
         this.continueBtn.enableMe();
         this.mcSkipHitArea.visible = false;
         this._isAnimComplete = true;
      }
      
      private function onSkipAnimClick(param1:MouseEvent) : void
      {
         this._timeLine.seek("end");
         this.onAnimComplete();
      }
      
      private function onContinueClick(param1:Event) : void
      {
         this.doContinue();
      }
      
      public function doContinue() : void
      {
         screensM.screenBattle.closeScreen();
      }
   }
}

