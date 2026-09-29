package net.battleMechsMulti.screens.mainMenu
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.BMShopManager;
   import net.battleMechsMulti.managers.BMSpecialOffersManager;
   import net.battleMechsMulti.managers.BMTutorialManager;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.mobiles.pointersAndMarkers.BMTutorialArrowController;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1228")]
   public class BMScreenMainMenu extends BMBaseScreen
   {
      
      public var mcBgDark:MovieClip;
      
      public var mcBgLight:MovieClip;
      
      public var mcSpecialOfferPos:Sprite;
      
      public var mcPlatformsCenter:MovieClip;
      
      public var mcArenaButton:BMBasicButton;
      
      public var mcWorkshopButton:BMBasicButton;
      
      public var mcShopButton:BMBasicButton;
      
      public var mcCampaignButton:BMBasicButton;
      
      public var mcUpgradeButton:BMBasicButton;
      
      public var mcQuestsButton:BMBasicButton;
      
      public var mcShopCounter:TextHolder;
      
      public var mcWorkshopCounter:TextHolder;
      
      public var mcQuestsCounter:TextHolder;
      
      public var mcTutorialArrow:Sprite;
      
      private var _carouselAnimator:CarouselAnimator;
      
      private var _mechViews:Vector.<BMMechView> = new Vector.<BMMechView>();
      
      private var _firstRefresh:Boolean = true;
      
      private var _initTimeLine:TimelineMax;
      
      private var _tutorialArrowController:BMTutorialArrowController;
      
      private var _mechsTeaseFrameCounter:Number = 0;
      
      private var _mechsTeaseCurrentMech:uint = 0;
      
      public function BMScreenMainMenu()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         this.mcArenaButton.addEventListener(BMIntractable.HIT,this.onArenaButtonHit);
         this.mcUpgradeButton.addEventListener(BMIntractable.HIT,this.onUpgradeButtonHit);
         this.mcWorkshopButton.addEventListener(BMIntractable.HIT,this.onWorkshopButtonHit);
         this.mcShopButton.addEventListener(BMIntractable.HIT,this.onShopButtonHit);
         this.mcCampaignButton.addEventListener(BMIntractable.HIT,this.onCampaignButtonHit);
         this.mcQuestsButton.addEventListener(BMIntractable.HIT,this.onQuestsClick);
         this.createLightAnimation();
         setLanguageManagerScreenName("mainMenu");
      }
      
      private function createLightAnimation() : *
      {
         var i:int;
         var dark:Function = function():*
         {
            return [new TweenMax(mcBgLight,0.01,{"visible":false}),new TweenMax(mcBgDark,0.01,{"visible":true})];
         };
         var light:Function = function():*
         {
            return [new TweenMax(mcBgLight,0.01,{"visible":true}),new TweenMax(mcBgDark,0.01,{"visible":false})];
         };
         this._initTimeLine = new TimelineMax();
         this._initTimeLine.add(dark());
         this._initTimeLine.add(light(),"+=" + (0.5 + Math.random() * 0.3));
         this._initTimeLine.add(dark(),"+=" + (0.03 + Math.random() * 0.04));
         this._initTimeLine.add(light(),"+=" + (0.15 + Math.random() * 0.3));
         i = 0;
         while(i < 1 + Math.random() * 2)
         {
            this._initTimeLine.add(dark(),"+=" + (0.03 + Math.random() * 0.03));
            this._initTimeLine.add(light(),"+=" + (0.03 + Math.random() * 0.1));
            i++;
         }
         this._initTimeLine.stop();
      }
      
      public function refreshScreen() : void
      {
         if(this._firstRefresh)
         {
            screensM.addScreen("screenTopBarNew");
            this.initMechs();
            this._initTimeLine.play();
            this._tutorialArrowController = new BMTutorialArrowController(this.mcTutorialArrow);
            BMShopManager.gi().processPendingPurchases();
            dataM.starterPack_goBackToScreen = "mainMenu";
            BMSpecialOffersManager.gi().showSmallBanner(this.mcSpecialOfferPos);
         }
         this._firstRefresh = false;
         screensM.screenTopBarNew.refreshScreen();
         this.refreshFreePackagesCounter();
         this.refreshStarterPackMechCounter();
         this.refreshQuestsCounter();
         this.refreshButtonsForTutorial();
         this.refreshLanguages();
      }
      
      private function refreshLanguages() : void
      {
         var _loc1_:Number = 1;
         if(dataM.languageID == BMLanguageManager.LANGUAGE_RUSSIAN)
         {
            _loc1_ = 0.8;
         }
         this.mcArenaButton.textScale = _loc1_;
         this.mcArenaButton.text = getScreenText("arena");
         this.mcCampaignButton.textScale = _loc1_;
         this.mcCampaignButton.text = getScreenText("campaign");
         this.mcUpgradeButton.textScale = _loc1_;
         this.mcWorkshopButton.textScale = _loc1_;
         this.mcWorkshopButton.text = getScreenText("workshop");
         this.mcShopButton.textScale = _loc1_;
         this.mcShopButton.text = getScreenText("shop");
      }
      
      public function refreshButtonsForTutorial() : void
      {
         var _loc1_:BMBasicButton = null;
         if(tutorialM.isTutorialActive())
         {
            this.mcArenaButton.disableMe();
            this.mcWorkshopButton.disableMe();
            this.mcShopButton.disableMe();
            this.mcCampaignButton.disableMe();
            this.mcUpgradeButton.disableMe();
            this.mcQuestsButton.visible = false;
            this.mcQuestsCounter.visible = false;
            switch(tutorialM.getTutorialDestination())
            {
               case BMTutorialManager.TUTORIAL_DESTINATION_MECH:
                  _loc1_ = this.mcWorkshopButton;
                  break;
               case BMTutorialManager.TUTORIAL_DESTINATION_FUSION:
                  _loc1_ = this.mcUpgradeButton;
                  break;
               case BMTutorialManager.TUTORIAL_DESTINATION_SHOP:
                  _loc1_ = this.mcShopButton;
                  break;
               case BMTutorialManager.TUTORIAL_DESTINATION_MISSION:
                  _loc1_ = this.mcCampaignButton;
            }
            _loc1_.enableMe();
            this._tutorialArrowController.activateTutorialArrow(this,_loc1_.x + _loc1_.width / 2,_loc1_.y,-90,0,0);
         }
         else
         {
            this._tutorialArrowController.deactivateTutorialArrow();
            this.mcArenaButton.enableMe();
            this.mcWorkshopButton.enableMe();
            this.mcShopButton.enableMe();
            this.mcCampaignButton.enableMe();
            this.mcUpgradeButton.enableMe();
         }
      }
      
      private function initMechs() : void
      {
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:BMMechStructure = null;
         var _loc6_:BMMechView = null;
         trace("dataM.player1PlayerID:" + dataM.player1PlayerID);
         var _loc1_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc2_:Vector.<MovieClip> = new Vector.<MovieClip>();
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc4_ = new ScreenMainMenuPlatform();
            _loc4_.gotoAndStop("lightOff");
            _loc4_.orgIndex = _loc3_ + 1;
            _loc5_ = _loc1_.mechStructures[_loc3_ + 1];
            if(_loc5_ != null && _loc5_.canBeDisplayed())
            {
               _loc6_ = new BMMechView();
               _loc6_.initialize(dataM.player1PlayerID,"battle","playerItemID",0.8,false);
               _loc6_.buildMech(_loc5_,"screenMainMenu");
               this._mechViews.push(_loc6_);
               _loc6_.y = -(_loc6_.mechSizer.height + _loc6_.mechSizer.y);
               _loc4_.mcMechPosition.addChild(_loc6_);
               _loc4_.mechID = _loc5_.mechID;
               _loc4_.mouseChildren = false;
               _loc4_.addEventListener(MouseEvent.CLICK,this.onPlatformClick);
            }
            _loc2_.push(_loc4_);
            _loc3_++;
         }
         this._carouselAnimator = new CarouselAnimator();
         addChildAt(this._carouselAnimator,getChildIndex(this.mcPlatformsCenter));
         this._carouselAnimator.x = this.mcPlatformsCenter.x;
         this._carouselAnimator.y = this.mcPlatformsCenter.y;
         this._carouselAnimator.radius = new Point(280,0);
         this._carouselAnimator.setItems(_loc2_);
         this._carouselAnimator.getSelectedItem().gotoAndStop("lightOn");
         this._carouselAnimator.addEventListener(CarouselAnimator.ON_MOVE_COMPLETE,this.onMoveComplete);
      }
      
      private function onPlatformClick(param1:MouseEvent) : void
      {
         if(tutorialM.isTutorialActive())
         {
            return;
         }
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(this._carouselAnimator.getSelectedItem() == _loc2_)
         {
            screensM.screenNewMenu.hangerMechClicked();
            return;
         }
         this.rotateCarousel(this._carouselAnimator.getItemByIndex(this._carouselAnimator.selectedIndex + 1) == _loc2_);
      }
      
      private function rotateCarousel(param1:Boolean) : void
      {
         var _loc2_:int = param1 ? 1 : -1;
         if(this._carouselAnimator.getItemByIndex(this._carouselAnimator.selectedIndex + _loc2_).hasOwnProperty("mechID"))
         {
            this._carouselAnimator.getSelectedItem().gotoAndStop("lightOff");
            this._carouselAnimator.moveBy(_loc2_,2);
            screensM.screenNewMenu.mechOrderToSave = this.getCurrentMechOrder();
         }
      }
      
      private function onMoveComplete(param1:Event) : void
      {
         this._carouselAnimator.getSelectedItem().gotoAndStop("lightOn");
      }
      
      public function onEnterFrameTrigger() : void
      {
         this.mechAnimationsHandler();
         var _loc1_:int = 0;
         while(_loc1_ < this._mechViews.length)
         {
            this._mechViews[_loc1_].onEnterFrameTrigger();
            _loc1_++;
         }
         this._tutorialArrowController.runFrame();
      }
      
      private function mechAnimationsHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BMMechView = null;
         if(this._mechViews.length == 0)
         {
            return;
         }
         ++this._mechsTeaseFrameCounter;
         if(this._mechsTeaseFrameCounter >= 150)
         {
            _loc1_ = Math.ceil(Math.random() * 9);
            _loc2_ = this._mechViews[this._mechsTeaseCurrentMech];
            switch(_loc1_)
            {
               case 1:
                  _loc2_.activateTease1(null);
                  break;
               case 2:
                  _loc2_.activateTease2(null);
                  break;
               case 3:
                  _loc2_.activateTease3(null);
                  break;
               case 4:
                  _loc2_.activateTease4(null);
                  break;
               case 5:
                  _loc2_.activateTease5(null);
                  break;
               case 6:
                  _loc2_.activateTease6(null);
                  break;
               case 7:
                  _loc2_.activateTease8(null);
                  break;
               case 8:
                  _loc2_.activateTease9(null,false);
                  break;
               case 9:
                  if(_loc2_.hasSideWeaponAt(1))
                  {
                     _loc2_.activateSword(1,null,true);
                  }
            }
            this._mechsTeaseFrameCounter = 50;
            ++this._mechsTeaseCurrentMech;
            if(this._mechsTeaseCurrentMech >= this._mechViews.length)
            {
               this._mechsTeaseCurrentMech = 0;
            }
         }
      }
      
      private function onWorkshopButtonHit(param1:Event) : void
      {
         screensM.screenNewMenu.hangerMechClicked();
      }
      
      private function onOptionsButtonHit(param1:Event) : void
      {
         screensM.screenNewMenu.extraOptions();
      }
      
      private function onArenaButtonHit(param1:Event) : void
      {
         screensM.screenNewMenu.multiplayerLadderClicked(false,true);
      }
      
      private function onShopButtonHit(param1:Event) : void
      {
         BMShopManager.gi().showCategoriesScreen("MainMenu");
      }
      
      private function onCampaignButtonHit(param1:Event) : void
      {
         screensM.screenNewMenu.singlePlayerClicked();
      }
      
      private function onUpgradeButtonHit(param1:Event) : void
      {
         screensM.screenNewMenu.upgrade();
      }
      
      private function onQuestsClick(param1:Event) : void
      {
         this.showQuestsScreen();
      }
      
      private function showQuestsScreen() : void
      {
         screensM.addScreen("screenQuests");
         screensM.screenQuests.doOpenAnim();
         TweenMax.to(this.mcQuestsButton,0.5,{"alpha":0});
         screensM.screenTopBarNew.hideLvlAndXp();
         if(screensM.isScreenOpened("screenSpecialOffers"))
         {
            screensM.screenSpecialOffers.visible;
            TweenMax.to(screensM.screenSpecialOffers,0.2,{
               "alpha":0,
               "visible":false
            });
         }
      }
      
      public function onHideQuestsScreen() : void
      {
         this.refreshQuestsCounter();
         TweenMax.to(this.mcQuestsButton,0.3,{"alpha":1});
         screensM.screenTopBarNew.showLvlAndXp();
         if(screensM.isScreenOpened("screenSpecialOffers"))
         {
            screensM.screenSpecialOffers.visible = true;
            TweenMax.to(screensM.screenSpecialOffers,0.2,{
               "alpha":1,
               "delay":0.1
            });
         }
      }
      
      public function refreshFreePackagesCounter() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:uint = 0;
         var _loc3_:String = null;
         this.mcShopCounter.visible = false;
         if(dataM.gameType != BMDataManager.GAME_TYPE_TUTORIAL)
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            _loc2_ = _loc1_.getAllFreePackagesAmount();
            if(_loc1_.level > 3 && _loc2_ > 0)
            {
               _loc3_ = "9+";
               if(_loc2_ < 9)
               {
                  _loc3_ = String(_loc2_);
               }
               this.mcShopCounter.visible = true;
               this.mcShopCounter.text = _loc3_;
            }
         }
      }
      
      public function refreshStarterPackMechCounter() : void
      {
         var _loc1_:BMPlayerProfile = null;
         var _loc2_:String = null;
         this.mcWorkshopCounter.visible = false;
         if(dataM.gameType != BMDataManager.GAME_TYPE_TUTORIAL)
         {
            _loc1_ = dataM["player" + dataM.player1PlayerID + "Profile"];
            if(_loc1_.pendingStarterPackMech > 0)
            {
               _loc2_ = "1";
               this.mcWorkshopCounter.visible = true;
               this.mcWorkshopCounter.text = _loc2_;
            }
         }
      }
      
      public function refreshQuestsCounter() : void
      {
         var _loc1_:int = dataM.questsManager.getNumOfCompletedAll();
         this.mcQuestsCounter.visible = _loc1_ > 0;
         this.mcQuestsCounter.text = _loc1_ + "";
      }
      
      override public function notifyClientDataReloaded() : *
      {
         this.refreshScreen();
      }
      
      private function onRemoved(param1:Event) : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoved);
         screensM.removeScreen("screenTopBarNew");
         this._initTimeLine.kill();
         screensM.removeScreen("screenQuests");
         BMSpecialOffersManager.gi().removeSpecialOffer();
      }
      
      private function getCurrentMechOrder() : Array
      {
         var _loc4_:MovieClip = null;
         if(this._carouselAnimator.selectedIndex == 0)
         {
            return null;
         }
         var _loc1_:Array = [0,1,2,3,4,5,6];
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < 3)
         {
            _loc4_ = this._carouselAnimator.getItemByIndex(this._carouselAnimator.selectedIndex + _loc3_);
            if(_loc4_.hasOwnProperty("mechID"))
            {
               _loc1_[_loc4_.orgIndex] = _loc2_ + 1;
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc1_;
      }
   }
}

