package net.battleMechsMulti.screens.campaignsMenu
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.managers.BMExternalAssetsManager;
   import net.battleMechsMulti.managers.BMLanguageManager;
   import net.battleMechsMulti.managers.singlePlayer.BMSinglePlayerManager;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMMechView;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.itemList.BMInterfaceItemView;
   
   public class BMCampaignMenuButton extends BMMovieClip implements BMInterfaceItemView
   {
      
      public var txtProgress:TextField;
      
      public var txtTitle:TextField;
      
      public var txtBattleType:TextField;
      
      public var txtLocked:TextField;
      
      public var btnEnter:BMBasicButton;
      
      public var mcLocked:Sprite;
      
      public var progressBar:BMBar;
      
      public var mcWorldMapSizer:Sprite;
      
      public var mcWorldMapHolder:Sprite;
      
      public var mcBossHolder:Sprite;
      
      public var mcMouseHitArea:Sprite;
      
      public var mcBackground:MovieClip;
      
      private var bossMechView:BMMechView;
      
      private var _chapterTiles:Array;
      
      private var _storyID:uint;
      
      private var _clicked:Function;
      
      private var _disabled:Boolean = false;
      
      public function BMCampaignMenuButton()
      {
         super();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function setData(param1:Object) : void
      {
         this._storyID = param1.storyID;
         this._clicked = param1.clicked;
         this.btnEnter.text = BMLanguageManager.getInstance().getText("campaignsMenu_play");
         updateTextAndFormat(this.txtProgress,param1.completionRatio + "%");
         this.progressBar.setFill(0);
         this.progressBar.setFill(param1.completionRatio / 100,true);
         this.addTiles(param1.chapters);
         this.addMissions(param1.missionsData,param1.chapters[0]);
         this.addBossMech(param1.bossMechStructure);
         var _loc2_:String = "campaignsMenu_campaign" + (this._storyID + 1) + "Name";
         updateTextAndFormat(this.txtTitle,BMLanguageManager.getInstance().getText(_loc2_));
         var _loc3_:uint = uint(BMSinglePlayerManager.MECHS_PER_STORY_ID[this._storyID]);
         updateTextAndFormat(this.txtBattleType,_loc3_ + " VS " + _loc3_);
         if(param1.locked)
         {
            updateTextAndFormat(this.txtLocked,param1.unlockMessage);
            this.mcBackground.gotoAndStop("locked");
         }
         else
         {
            this.mcLocked.visible = false;
            this.txtLocked.visible = false;
            if(this._clicked != null)
            {
               this.mcMouseHitArea.addEventListener(MouseEvent.CLICK,this.onHitAreaClicked);
            }
         }
      }
      
      private function getSizeRatio() : Number
      {
         return this.mcWorldMapSizer.height / BMDataManager.getInstance().STAGE_HEIGHT;
      }
      
      private function addMissions(param1:Array, param2:uint) : void
      {
         var _loc6_:Object = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:String = null;
         var _loc10_:Sprite = null;
         var _loc3_:Number = this.getSizeRatio();
         var _loc4_:uint = (param2 - 1) * 800;
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = param1[_loc5_];
            _loc7_ = (_loc6_.xPos - _loc4_) * _loc3_;
            _loc8_ = _loc6_.yPos * _loc3_;
            _loc9_ = "worldMapStarsPreview" + _loc6_.stars;
            _loc10_ = BMDataManager.getInstance().getLocalGraphicIcon(_loc9_);
            _loc10_.x = _loc7_;
            _loc10_.y = _loc8_;
            this.mcWorldMapHolder.addChild(_loc10_);
            _loc5_++;
         }
      }
      
      private function addTiles(param1:Array) : void
      {
         var _loc2_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:Sprite = null;
         this._chapterTiles = new Array();
         _loc2_ = this.getSizeRatio();
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = uint(param1[_loc3_]);
            _loc5_ = "worldMapPart" + _loc4_;
            if(this._storyID == BMSinglePlayerManager.STORY_ID_CAMPAIGN_2V2)
            {
               _loc5_ = "worldMap2Part" + _loc4_;
            }
            else if(this._storyID == BMSinglePlayerManager.STORY_ID_CAMPAIGN_3V3)
            {
               _loc5_ = "worldMap3Part" + _loc4_;
            }
            _loc6_ = BMExternalAssetsManager.getInstance().getAsset("general",_loc5_);
            _loc6_.x = _loc3_ * BMDataManager.getInstance().STAGE_WIDTH * _loc2_ - _loc3_ * 2;
            _loc6_.width *= _loc2_;
            _loc6_.height *= _loc2_;
            this.mcWorldMapHolder.addChild(_loc6_);
            _loc3_++;
         }
      }
      
      private function removeAllChapterTiles() : void
      {
         var _loc2_:Sprite = null;
         var _loc1_:uint = 0;
         while(_loc1_ < this._chapterTiles.length)
         {
            _loc2_ = this._chapterTiles[_loc1_];
            _loc2_.parent.removeChild(_loc2_);
            _loc2_ = null;
            _loc1_++;
         }
      }
      
      public function addBossMech(param1:BMMechStructure) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.bossMechView = new BMMechView();
         this.bossMechView.initialize(BMDataManager.getInstance().LOCAL_OPPONENT_ID,"battle",BMMechStructure.ITEM_TYPE_ITEM_ID,0.6,false);
         this.bossMechView.buildMech(param1,this.onBossMechItemsLoaded);
      }
      
      private function onBossMechItemsLoaded() : void
      {
         var _loc1_:Number = 0.7;
         this.bossMechView.scaleX *= -_loc1_;
         this.bossMechView.scaleY *= _loc1_;
         this.bossMechView.y += this.mcWorldMapSizer.height * (1 - _loc1_);
         if(this.bossMechView.height > this.mcWorldMapSizer.height + 20)
         {
            this.bossMechView.y += this.bossMechView.height - (this.mcWorldMapSizer.height + 20);
         }
         this.mcBossHolder.addChild(this.bossMechView);
      }
      
      private function onHitAreaClicked(param1:MouseEvent) : void
      {
         this._clicked(this._storyID);
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
      }
      
      public function isEnabled() : Boolean
      {
         return this._disabled == false;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         this._disabled = param1;
      }
      
      public function get ID() : uint
      {
         return this._storyID;
      }
      
      public function getItemWidth() : Number
      {
         return this.mcMouseHitArea.width;
      }
      
      public function getItemHeight() : Number
      {
         return this.mcMouseHitArea.height;
      }
      
      public function removeMe() : void
      {
         if(this.bossMechView != null)
         {
            this.bossMechView.removeMe();
            this.bossMechView = null;
         }
         this.mcMouseHitArea.removeEventListener(MouseEvent.CLICK,this.onHitAreaClicked);
         this.removeAllChapterTiles();
      }
   }
}

