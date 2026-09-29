package net.battleMechsMulti.screens.clan
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMScreensManager;
   import net.battleMechsMulti.mobiles.BMClanFlag;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMBasicButton;
   import net.battleMechsMulti.mobiles.buttons.BMIntractable;
   import net.battleMechsMulti.screens.BMBaseScreen;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol3273")]
   public class BMScreenClanSettings extends BMBaseScreen
   {
      
      public static const STATUS_INVITE_ONLY:uint = 0;
      
      public static const STATUS_OPENED:uint = 1;
      
      public var mcIconsHolder:Sprite;
      
      public var mcSizer_flag:Sprite;
      
      public var mcSizer_minRank:Sprite;
      
      public var mcJoiningStatusButtonMarker:Sprite;
      
      public var btnClose:BMBasicButton;
      
      public var btnStatusOpened:BMBasicButton;
      
      public var btnStatusInviteOnly:BMBasicButton;
      
      public var btnTypeNext:BMBasicButton;
      
      public var btnTypePrevious:BMBasicButton;
      
      public var btnShapeNext:BMBasicButton;
      
      public var btnShapePrevious:BMBasicButton;
      
      public var btnColorNext:BMBasicButton;
      
      public var btnColorPrevious:BMBasicButton;
      
      public var btnRandom:BMBasicButton;
      
      public var btnSave:BMBasicButton;
      
      public var btnMinRankPrevious:BMBasicButton;
      
      public var btnMinRankNext:BMBasicButton;
      
      public var txtTitle:TextField;
      
      public var txtMinRankTitle:TextField;
      
      public var txtMinRankValue:TextField;
      
      public var txtJoiningStatusTitle:TextField;
      
      public var txtFlagTitle:TextField;
      
      public var txtType:TextField;
      
      public var txtShape:TextField;
      
      public var txtColor:TextField;
      
      private var minRankIcon:Sprite;
      
      private var _assetsCreated:Boolean = false;
      
      private var _type:String;
      
      private var _flagCenterShape:uint;
      
      private var _flagCenterColor:uint;
      
      private var _flagSidesShape:uint;
      
      private var _flagSidesColor:uint;
      
      private var _flagBackgroundColor:uint;
      
      private var _currentMinRank:uint;
      
      private var mcClanFlag:BMClanFlag;
      
      private var _joiningStatus:uint;
      
      public function BMScreenClanSettings()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen() : void
      {
         if(this._assetsCreated == false)
         {
            setLanguageManagerScreenName("clanFlag");
            this.btnClose.addEventListener(BMIntractable.HIT,this.closeClicked);
            this.btnTypeNext.addEventListener(BMIntractable.HIT,this.typeNextClicked);
            this.btnTypePrevious.addEventListener(BMIntractable.HIT,this.typePreviousClicked);
            this.btnShapeNext.addEventListener(BMIntractable.HIT,this.shapeNextClicked);
            this.btnShapePrevious.addEventListener(BMIntractable.HIT,this.shapePreviousClicked);
            this.btnColorNext.addEventListener(BMIntractable.HIT,this.colorNextClicked);
            this.btnColorPrevious.addEventListener(BMIntractable.HIT,this.colorPreviousClicked);
            this.btnRandom.addEventListener(BMIntractable.HIT,this.randomClicked);
            this.btnSave.addEventListener(BMIntractable.HIT,this.saveClicked);
            this.btnSave.text = getScreenText("save");
            this.btnRandom.text = getScreenText("random");
            updateTextAndFormat(this.txtTitle,getSpecificText("clan_settingsTitle"));
            updateTextAndFormat(this.txtFlagTitle,getScreenText("title"));
            updateTextAndFormat(this.txtColor,getScreenText("color"));
            updateTextAndFormat(this.txtShape,getScreenText("shape"));
            this.initJoiningStatusInterface();
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("clanFlag_texts1",[this.txtTitle,this.txtColor],"",this);
            }
            this._assetsCreated = true;
         }
         this._type = "center";
         updateTextAndFormat(this.txtType,getScreenText("center"));
         updateTextAndFormat(this.txtShape,getScreenText("shape"));
         this.btnShapeNext.visible = true;
         this.btnShapePrevious.visible = true;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Array = dataM.getClanFlagData(_loc1_.clanFlag);
         if(_loc2_.length > 0)
         {
            this._flagCenterShape = _loc2_[0];
            this._flagSidesShape = _loc2_[1];
            this._flagCenterColor = _loc2_[2];
            this._flagSidesColor = _loc2_[3];
            this._flagBackgroundColor = _loc2_[4];
         }
         else
         {
            this._flagCenterShape = Math.ceil(Math.random() * dataM.CLAN_FLAG_CENTER_FRAMES);
            this._flagSidesShape = Math.ceil(Math.random() * dataM.CLAN_FLAG_SIDES_FRAMES);
            this._flagCenterColor = Math.ceil(Math.random() * dataM.CLAN_FLAG_COLORS);
            this._flagSidesColor = Math.ceil(Math.random() * dataM.CLAN_FLAG_COLORS);
            this._flagBackgroundColor = Math.ceil(Math.random() * dataM.CLAN_FLAG_COLORS);
         }
         if(dataM.myProfile.clanFlag == "")
         {
            this.btnClose.visible = false;
         }
         this.createFlag();
         this.createBitmapTextsForMobile();
      }
      
      private function createBitmapTextsForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("clanFlag_texts2",[this.txtType,this.txtShape],"",this);
            }
         }
      }
      
      public function getRandomFlagString() : String
      {
         var _loc1_:uint = Math.ceil(Math.random() * dataM.CLAN_FLAG_CENTER_FRAMES);
         var _loc2_:uint = Math.ceil(Math.random() * dataM.CLAN_FLAG_SIDES_FRAMES);
         var _loc3_:uint = Math.ceil(Math.random() * dataM.CLAN_FLAG_COLORS);
         var _loc4_:uint = Math.ceil(Math.random() * dataM.CLAN_FLAG_COLORS);
         var _loc5_:uint = Math.ceil(Math.random() * dataM.CLAN_FLAG_COLORS);
         return _loc1_ + "_" + _loc2_ + "_" + _loc3_ + "_" + _loc4_ + "_" + _loc5_;
      }
      
      private function createFlag() : void
      {
         if(this.mcClanFlag != null)
         {
            this.mcClanFlag.removeMe();
            this.mcClanFlag = null;
         }
         this.mcClanFlag = new BMClanFlag();
         var _loc1_:MovieClip = externalAssetsM.getAsset("general","clanFlag",this.mcSizer_flag.width,this.mcSizer_flag.height,false,false);
         _loc1_.x = this.mcSizer_flag.x;
         _loc1_.y = this.mcSizer_flag.y;
         this.mcClanFlag.initialize(_loc1_,dataM.runAsMobile);
         this.mcClanFlag.updateFlag([this._flagCenterShape,this._flagSidesShape,this._flagCenterColor,this._flagSidesColor,this._flagBackgroundColor]);
         this.mcIconsHolder.addChild(_loc1_);
      }
      
      private function initJoiningStatusInterface() : void
      {
         this._joiningStatus = dataM.myProfile.clan_joinType;
         this._currentMinRank = dataM.myProfile.clan_requiredRankToJoin;
         switch(this._joiningStatus)
         {
            case STATUS_INVITE_ONLY:
               this.selectStatusInviteOnly();
               break;
            case STATUS_OPENED:
               this.selectStatusOpened();
         }
         updateTextAndFormat(this.txtJoiningStatusTitle,getSpecificText("replays_type"));
         updateTextAndFormat(this.txtMinRankTitle,getSpecificText("clan_requiredRank"));
         this.btnStatusInviteOnly.addEventListener(BMIntractable.HIT,this.statusInviteOnlyClicked);
         this.btnStatusOpened.addEventListener(BMIntractable.HIT,this.statusOpenedClicked);
         this.btnStatusInviteOnly.text = getSpecificText("clan_inviteOnly");
         this.btnStatusOpened.text = getSpecificText("clan_open");
         this.btnMinRankNext.addEventListener(BMIntractable.HIT,this.minRankNextClicked);
         this.btnMinRankPrevious.addEventListener(BMIntractable.HIT,this.minRankPreviousClicked);
         this.refreshMinRankButtons();
         this.showRankIcon();
      }
      
      private function statusOpenedClicked(param1:Event) : void
      {
         this.selectStatusOpened();
      }
      
      private function statusInviteOnlyClicked(param1:Event) : void
      {
         this.selectStatusInviteOnly();
      }
      
      private function selectStatusOpened() : void
      {
         this._joiningStatus = STATUS_OPENED;
         this.setStatusButtonMarker(this.btnStatusOpened);
      }
      
      private function selectStatusInviteOnly() : void
      {
         this._joiningStatus = STATUS_INVITE_ONLY;
         this.setStatusButtonMarker(this.btnStatusInviteOnly);
      }
      
      private function setStatusButtonMarker(param1:BMBasicButton) : void
      {
         this.mcJoiningStatusButtonMarker.x = param1.x;
         this.mcJoiningStatusButtonMarker.y = param1.y;
      }
      
      private function minRankNextClicked(param1:Event) : void
      {
         --this._currentMinRank;
         if(this._currentMinRank <= 1)
         {
            this._currentMinRank = 1;
         }
         this.refreshMinRankButtons();
         this.showRankIcon();
      }
      
      private function minRankPreviousClicked(param1:Event) : void
      {
         ++this._currentMinRank;
         if(this._currentMinRank >= dataM.getLowestLadderRank())
         {
            this._currentMinRank = dataM.getLowestLadderRank();
         }
         this.refreshMinRankButtons();
         this.showRankIcon();
      }
      
      private function refreshMinRankButtons() : void
      {
         this.btnMinRankNext.enableMe();
         this.btnMinRankPrevious.enableMe();
         if(this._currentMinRank == 1)
         {
            this.btnMinRankNext.disableMe();
         }
         else if(this._currentMinRank == dataM.getLowestLadderRank())
         {
            this.btnMinRankPrevious.disableMe();
         }
      }
      
      private function showRankIcon() : void
      {
         updateTextAndFormat(this.txtMinRankValue,String(this._currentMinRank));
         this.removeRankIcon();
         var _loc1_:String = "Grp_rank" + dataM.getLadderRankIconNumber(this._currentMinRank);
         var _loc2_:Number = this.mcSizer_minRank.width;
         this.minRankIcon = externalAssetsM.getAsset("general",_loc1_,_loc2_,_loc2_);
         this.minRankIcon.x = this.mcSizer_minRank.x;
         this.minRankIcon.y = this.mcSizer_minRank.y;
         addChild(this.minRankIcon);
      }
      
      private function removeRankIcon() : void
      {
         if(this.minRankIcon != null)
         {
            this.minRankIcon.parent.removeChild(this.minRankIcon);
            this.minRankIcon = null;
         }
      }
      
      public function typeNextClicked(param1:Event) : void
      {
         var _loc2_:String = "";
         var _loc3_:String = "";
         if(this._type == "sides")
         {
            this.btnShapeNext.visible = false;
            this.btnShapePrevious.visible = false;
            this._type = "background";
            _loc3_ = getScreenText("background");
         }
         else
         {
            this.btnShapeNext.visible = true;
            this.btnShapePrevious.visible = true;
            _loc2_ = getScreenText("shape");
            if(this._type == "center")
            {
               this._type = "sides";
               _loc3_ = getScreenText("sides");
            }
            else
            {
               this._type = "center";
               _loc3_ = getScreenText("center");
            }
         }
         updateTextAndFormat(this.txtShape,_loc2_);
         updateTextAndFormat(this.txtType,_loc3_);
         this.createBitmapTextsForMobile();
      }
      
      public function typePreviousClicked(param1:Event) : void
      {
         var _loc2_:String = "";
         var _loc3_:String = "";
         if(this._type == "center")
         {
            this.btnShapeNext.visible = false;
            this.btnShapePrevious.visible = false;
            this._type = "background";
            _loc3_ = getScreenText("background");
         }
         else
         {
            this.btnShapeNext.visible = true;
            this.btnShapePrevious.visible = true;
            _loc2_ = getScreenText("shape");
            if(this._type == "background")
            {
               this._type = "sides";
               _loc3_ = getScreenText("sides");
            }
            else
            {
               this._type = "center";
               _loc3_ = getScreenText("center");
            }
         }
         updateTextAndFormat(this.txtShape,_loc2_);
         updateTextAndFormat(this.txtType,_loc3_);
         this.createBitmapTextsForMobile();
      }
      
      public function shapeNextClicked(param1:Event) : void
      {
         if(this._type == "center")
         {
            if(this._flagCenterShape == dataM.CLAN_FLAG_CENTER_FRAMES)
            {
               this._flagCenterShape = 1;
            }
            else
            {
               ++this._flagCenterShape;
            }
         }
         else if(this._flagSidesShape == dataM.CLAN_FLAG_SIDES_FRAMES)
         {
            this._flagSidesShape = 1;
         }
         else
         {
            ++this._flagSidesShape;
         }
         this.createFlag();
      }
      
      public function shapePreviousClicked(param1:Event) : void
      {
         if(this._type == "center")
         {
            if(this._flagCenterShape == 1)
            {
               this._flagCenterShape = dataM.CLAN_FLAG_CENTER_FRAMES;
            }
            else
            {
               --this._flagCenterShape;
            }
         }
         else if(this._flagSidesShape == 1)
         {
            this._flagSidesShape = dataM.CLAN_FLAG_SIDES_FRAMES;
         }
         else
         {
            --this._flagSidesShape;
         }
         this.createFlag();
      }
      
      public function colorNextClicked(param1:Event) : void
      {
         if(this._type == "center")
         {
            if(this._flagCenterColor == dataM.CLAN_FLAG_COLORS)
            {
               this._flagCenterColor = 1;
            }
            else
            {
               ++this._flagCenterColor;
            }
         }
         else if(this._type == "sides")
         {
            if(this._flagSidesColor == dataM.CLAN_FLAG_COLORS)
            {
               this._flagSidesColor = 1;
            }
            else
            {
               ++this._flagSidesColor;
            }
         }
         else if(this._flagBackgroundColor == dataM.CLAN_FLAG_COLORS)
         {
            this._flagBackgroundColor = 1;
         }
         else
         {
            ++this._flagBackgroundColor;
         }
         this.createFlag();
      }
      
      public function colorPreviousClicked(param1:Event) : void
      {
         if(this._type == "center")
         {
            if(this._flagCenterColor == 1)
            {
               this._flagCenterColor = dataM.CLAN_FLAG_COLORS;
            }
            else
            {
               --this._flagCenterColor;
            }
         }
         else if(this._type == "sides")
         {
            if(this._flagSidesColor == 1)
            {
               this._flagSidesColor = dataM.CLAN_FLAG_COLORS;
            }
            else
            {
               --this._flagSidesColor;
            }
         }
         else if(this._flagBackgroundColor == 1)
         {
            this._flagBackgroundColor = dataM.CLAN_FLAG_COLORS;
         }
         else
         {
            --this._flagBackgroundColor;
         }
         this.createFlag();
      }
      
      private function closeClicked(param1:Event) : void
      {
         this.removeMe(true);
      }
      
      public function randomClicked(param1:Event) : void
      {
         this._flagCenterShape = Math.ceil(Math.random() * dataM.CLAN_FLAG_CENTER_FRAMES);
         this._flagSidesShape = Math.ceil(Math.random() * dataM.CLAN_FLAG_SIDES_FRAMES);
         this._flagCenterColor = Math.ceil(Math.random() * dataM.CLAN_FLAG_COLORS);
         this._flagSidesColor = Math.ceil(Math.random() * dataM.CLAN_FLAG_COLORS);
         this._flagBackgroundColor = Math.ceil(Math.random() * dataM.CLAN_FLAG_COLORS);
         this.createFlag();
      }
      
      public function saveClicked(param1:Event) : void
      {
         var _loc2_:String = this._flagCenterShape + "_" + this._flagSidesShape + "_" + this._flagCenterColor + "_" + this._flagSidesColor + "_" + this._flagBackgroundColor;
         var _loc3_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         dataM.myProfile.clan_joinType = this._joiningStatus;
         dataM.myProfile.clan_requiredRankToJoin = this._currentMinRank;
         remoteM.socketM.clan_updateSettings(_loc2_,this._currentMinRank,this._joiningStatus);
         _loc3_.clanData.flag = _loc2_;
         this.removeMe(true);
      }
      
      public function removeMe(param1:Boolean = false) : void
      {
         if(this.mcClanFlag != null)
         {
            this.mcClanFlag.removeMe();
            this.mcClanFlag = null;
         }
         this.removeRankIcon();
         screensM.removeScreen(BMScreensManager.SCR_CLAN_SETTINGS);
         if(param1)
         {
            screensM.screenTransitionsManager.communityClanClicked(true);
         }
      }
   }
}

