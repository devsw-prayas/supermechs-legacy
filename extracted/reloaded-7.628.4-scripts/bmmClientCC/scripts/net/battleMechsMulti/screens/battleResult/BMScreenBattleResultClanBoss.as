package net.battleMechsMulti.screens.battleResult
{
   import com.greensock.TimelineMax;
   import com.greensock.TweenMax;
   import com.greensock.easing.Back;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.data.BMClanMemberData;
   import net.battleMechsMulti.data.ItemRarityResolver;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.managers.BMTipsManager;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.clan.listRow.ClanBossDamageLeaderboardListRow;
   import net.battleMechsMulti.screens.clan.listRow.ClanListRow;
   import net.battleMechsMulti.screens.clan.listRow.ClanListRowDataForBossDamageLeaderboard;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3692")]
   public class BMScreenBattleResultClanBoss extends BMScreenBattleResultBase
   {
      
      public var mcTileListHolder:Sprite;
      
      public var mcTitle:TextHolder;
      
      public var mcDamage:TextHolder;
      
      public var mcTotalDamage:TextHolder;
      
      public var txtTopDamageDealers:TextField;
      
      public var mcBg:Sprite;
      
      public var mcBannerLeft:Sprite;
      
      public var mcBannerRight:Sprite;
      
      public var mcSwordLeft:Sprite;
      
      public var mcSwordRight:Sprite;
      
      public var mcRays:Sprite;
      
      public var mcSparksHolder:Sprite;
      
      public var mcGlowWin:Sprite;
      
      public var mcCover:Sprite;
      
      public var mcSkipHitArea:MovieClip;
      
      public var continueBtn:BMBasicButton;
      
      public var mcTip:MovieClip;
      
      private var bossLeaderboardTileList:BMTileList;
      
      private var _timeLine:TimelineMax;
      
      private var _isAnimComplete:Boolean = false;
      
      public function BMScreenBattleResultClanBoss()
      {
         super();
      }
      
      override public function initialize() : void
      {
         super.initialize();
         this.initBtns();
         this.initTexts();
         this.initLeaderboardTileList();
      }
      
      private function initLeaderboardTileList() : void
      {
         var _loc5_:uint = 0;
         var _loc7_:Object = null;
         var _loc8_:BMClanMemberData = null;
         var _loc9_:Object = null;
         var _loc10_:uint = 0;
         var _loc11_:ClanListRowDataForBossDamageLeaderboard = null;
         var _loc12_:ClanBossDamageLeaderboardListRow = null;
         var _loc13_:String = null;
         var _loc14_:BMItem = null;
         var _loc15_:BMTileListItem = null;
         this.bossLeaderboardTileList = new BMTileList();
         var _loc1_:Array = new Array();
         var _loc2_:uint = 3;
         var _loc3_:uint = 340;
         var _loc4_:uint = 30;
         var _loc6_:Array = new Array();
         _loc5_ = 0;
         while(_loc5_ < dataM.myProfile.clanMembers)
         {
            _loc8_ = dataM.myProfile.clanData.members[_loc5_];
            _loc7_ = {
               "type":"member",
               "playerID":_loc8_.playerID,
               "name":_loc8_.name,
               "ladderProgress":_loc8_.ladderProgress,
               "damage":_loc8_.bossDamage
            };
            _loc6_.push(_loc7_);
            _loc5_++;
         }
         _loc6_.sortOn("damage",Array.NUMERIC | Array.DESCENDING);
         _loc5_ = 0;
         while(_loc5_ < Math.min(3,_loc6_.length))
         {
            _loc9_ = _loc6_[_loc5_];
            _loc10_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc9_.ladderProgress));
            _loc11_ = new ClanListRowDataForBossDamageLeaderboard(_loc9_.name,_loc10_,_loc9_.damage);
            _loc12_ = new mcClanBossDamageLeaderboardRow();
            _loc12_.initialize(_loc11_);
            _loc13_ = ClanListRow.BACKGROUND_REGULAR1;
            if(_loc9_.playerID == dataM.userID)
            {
               _loc13_ = ClanListRow.BACKGROUND_SELF;
            }
            else if(_loc5_ % 2 == 0)
            {
               _loc13_ = ClanListRow.BACKGROUND_REGULAR2;
            }
            _loc12_.setBackground(_loc13_);
            _loc14_ = new BMItem();
            _loc14_.initialize(_loc9_.playerID,_loc3_,_loc4_,_loc12_,0,0,false,null,dataM.runAsMobile);
            _loc15_ = new BMTileListItem();
            _loc15_.initialize(_loc3_,_loc4_,_loc14_,"","","",0,null,null,null,null,null,dataM.runAsMobile);
            _loc1_.push(_loc15_);
            _loc5_++;
         }
         this.bossLeaderboardTileList.initialize(screensM.clientPointer.stage,_loc1_,_loc2_,1,_loc3_,_loc4_,null,false,null,null,null,false,-1,1,true,false,dataM.runAsMobile);
         this.mcTileListHolder.addChild(this.bossLeaderboardTileList);
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
         var _loc1_:uint = dataM.myProfile.clan_bossDamageDealtInLastBattle;
         var _loc2_:String = getSpecificText("clanBoss_damageDealt");
         var _loc3_:String = "<FONT COLOR=\'#" + ItemRarityResolver.COLOR_LEGENDARY_ITEM + "\'>";
         _loc2_ = _loc2_ + " " + _loc3_ + TextUtils.getNumberWithComma(_loc1_);
         this.mcDamage.text = _loc2_;
         var _loc4_:Object = dataM.myProfile.getClanMemberByPlayerID(dataM.userID);
         var _loc5_:uint = 0;
         if(_loc4_ != null)
         {
            _loc5_ = uint(_loc4_.bossDamage);
         }
         var _loc6_:String = getSpecificText("clanBoss_totalDamageDealt");
         _loc6_ = _loc6_ + " " + _loc3_ + TextUtils.getNumberWithComma(_loc5_);
         this.mcTotalDamage.text = _loc6_;
         updateTextAndFormat(this.txtTopDamageDealers,getSpecificText("clanBoss_topDamageDealers"));
         var _loc7_:uint = BMTipsManager.TIP_TYPE_DEFAULT;
         if(dataM.gameType == BMDataManager.GAME_TYPE_PVE && dataM.myProfile.lastBattleResult == BMDataManager.BATTLE_RESULT_LOSS)
         {
            _loc7_ = BMTipsManager.TIP_TYPE_PVE_LOSS;
         }
         this.mcTip.text = dataM.tipsManager.getTip(true,_loc7_);
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
         this._timeLine.fromTo(this.mcDamage,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         },"-=0.1");
         this._timeLine.fromTo(this.mcTotalDamage,0.3,{
            "scaleX":0,
            "scaleY":0
         },{
            "scaleX":1,
            "scaleY":1,
            "ease":Back.easeOut
         },"-=0.2");
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
         this._timeLine.addLabel("leaderboardCover");
         this._timeLine.to(this.mcCover,0.2,{"alpha":0});
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

