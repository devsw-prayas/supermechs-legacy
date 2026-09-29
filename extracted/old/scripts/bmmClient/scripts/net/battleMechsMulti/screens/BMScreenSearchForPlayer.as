package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMAvatarImage;
   import net.battleMechsMulti.mobiles.BMFingerWheeling;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMTileList;
   import net.battleMechsMulti.mobiles.BMTileListItem;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol606")]
   public class BMScreenSearchForPlayer extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcTextHolder:Sprite;
      
      public var mcTileListHolder:Sprite;
      
      public var mcSizer_tileList:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_btnSearch:Sprite;
      
      public var mcFingerWheeling:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtDescName:TextField;
      
      public var txtInputName:TextField;
      
      public var txtDescPlayerID:TextField;
      
      public var txtInputPlayerID:TextField;
      
      public var txtDescOr:TextField;
      
      public var btnSearch:BMButton_pictureE;
      
      public var btnBack:BMButton_pictureE;
      
      private var playersTileList:BMTileList;
      
      private var playersData:Array = new Array();
      
      private var clanNames:Object = new Object();
      
      private var _firstRefresh:Boolean = true;
      
      private var _fingerWheeling:BMFingerWheeling;
      
      private const ITEM_WIDTH:uint = 449;
      
      private const ITEM_WIDTH_MOBILE:uint = 475;
      
      private const ITEM_HEIGHT:uint = 31;
      
      private const ITEM_HEIGHT_MOBILE:uint = 34;
      
      private const TILE_LIST_ROWS:uint = 8;
      
      private const TILE_LIST_ROWS_MOBILE:uint = 7;
      
      private const TILE_LIST_COLUMNS:uint = 1;
      
      public function BMScreenSearchForPlayer()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen() : void
      {
         var _loc1_:Function = null;
         var _loc2_:Function = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("searchForPlayer");
            screensM.createButtonFromSizer("screenSearchForPlayer","btnBack","pictureE");
            screensM.createButtonFromSizer("screenSearchForPlayer","btnSearch","pictureE");
            _loc1_ = this.backClicked;
            _loc2_ = this.searchClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
               _loc2_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc1_,dataM.runAsMobile);
            this.btnSearch.initialize("","",externalAssetsM.getAsset("general","interface_inspect"),null,_loc2_,dataM.runAsMobile);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSearch.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.txtInputName.maxChars = 30;
            this.txtInputName.restrict = "^<>&";
            this.txtInputPlayerID.maxChars = 9;
            this.txtInputPlayerID.restrict = "0123456789";
            if(dataM.runAsMobile)
            {
               this._fingerWheeling = new BMFingerWheeling();
               this._fingerWheeling.initialize("searchForPlayer",this.playersTileList,this.mcFingerWheeling,this.tileListItemClicked,null,false);
               addChild(this._fingerWheeling);
            }
            else
            {
               this.mcFingerWheeling.parent.removeChild(this.mcFingerWheeling);
               this.mcFingerWheeling = null;
            }
            this.languageUpdate();
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this.txtInputName.text = "";
         this.txtInputPlayerID.text = "";
         this.txtInputName.visible = true;
         this.txtInputPlayerID.visible = true;
         this.btnSearch.visible = true;
         this.txtDescName.visible = true;
         this.txtDescOr.visible = true;
         this.txtDescPlayerID.visible = true;
         this.refreshTextsForMobile();
         this.refreshSearchButton();
         this.txtInputName.addEventListener(Event.CHANGE,this.inputNameChanged);
         this.txtInputPlayerID.addEventListener(Event.CHANGE,this.inputPlayerIDChanged);
         if(dataM.runAsMobile)
         {
            this.mcFingerWheeling.visible = false;
         }
      }
      
      private function languageUpdate() : void
      {
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtDescName,20);
            TextUtils.updateTextFormat(this.txtDescOr,20);
            TextUtils.updateTextFormat(this.txtDescPlayerID,20);
            TextUtils.updateTextFormat(this.txtTitle,20);
            TextUtils.updateTextFormat(this.txtInputName,20);
            TextUtils.updateTextFormat(this.txtInputPlayerID,20);
         }
         this.txtTitle.text = getScreenText("title");
         this.txtDescName.text = getScreenText("enterName");
         this.txtDescPlayerID.text = getScreenText("enterPlayerID");
         this.txtDescOr.text = getScreenText("or");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("searchForPlayer_title",[this.txtTitle],"",this);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            if(dataM.runAsMobile)
            {
               this._fingerWheeling.onEnterFrameTrigger();
            }
         }
      }
      
      private function refreshTextsForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("searchForPlayer_texts",[this.txtDescName,this.txtDescPlayerID,this.txtDescOr],"",this.mcTextHolder);
         }
      }
      
      private function inputNameChanged(param1:Event) : void
      {
         if(this.txtInputName.text != "")
         {
            this.txtInputPlayerID.text = "";
         }
         this.refreshSearchButton();
      }
      
      private function inputPlayerIDChanged(param1:Event) : void
      {
         if(this.txtInputPlayerID.text != "")
         {
            this.txtInputName.text = "";
         }
         this.refreshSearchButton();
      }
      
      private function refreshSearchButton() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         if(this.txtInputName.text.length >= 3)
         {
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < this.txtInputName.text.length)
            {
               if(this.txtInputName.text.substr(0,_loc4_) == " ")
               {
                  _loc3_++;
               }
               _loc4_++;
            }
            if(this.txtInputName.text.length - _loc3_ >= 3)
            {
               _loc1_ = true;
            }
         }
         if(this.txtInputPlayerID.text.length > 3)
         {
            _loc2_ = true;
         }
         if(_loc2_ || _loc1_)
         {
            this.btnSearch.enableMe();
         }
         else
         {
            this.btnSearch.disableMe();
         }
      }
      
      public function playersFound(param1:Object, param2:Object, param3:Array) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc15_:MovieClip = null;
         var _loc16_:MovieClip = null;
         var _loc17_:Boolean = false;
         var _loc18_:Number = NaN;
         var _loc19_:MovieClip = null;
         var _loc20_:BMItem = null;
         var _loc21_:BMTileListItem = null;
         var _loc22_:Function = null;
         var _loc23_:BMAvatarImage = null;
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.addMouseListeners();
            this.mcFingerWheeling.visible = true;
         }
         screensM.removeScreen("screenConfirmation");
         this.playersData = new Array();
         this.clanNames = new Object();
         var _loc4_:Object = new Object();
         for each(_loc6_ in param1)
         {
            if(_loc6_.playerID != dataM.userID)
            {
               if(_loc4_[_loc6_.playerID] != null)
               {
                  this.playersData.push(_loc6_);
               }
            }
         }
         for each(_loc6_ in param1)
         {
            if(_loc6_.playerID != dataM.userID)
            {
               if(_loc4_[_loc6_.playerID] == null)
               {
                  this.playersData.push(_loc6_);
               }
            }
         }
         for each(_loc7_ in param2)
         {
            this.clanNames[_loc7_.clanID] = _loc7_.name;
         }
         if(this.playersTileList != null)
         {
            this.playersTileList.removeMe();
            this.playersTileList = null;
         }
         this.playersTileList = new BMTileList();
         var _loc8_:Boolean = false;
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.resetTileList(this.playersTileList);
            _loc8_ = true;
            this.playersTileList.activateExtendedMode(0.35,true);
         }
         var _loc9_:Number = this.ITEM_WIDTH;
         var _loc10_:Number = this.ITEM_HEIGHT;
         var _loc11_:Number = this.TILE_LIST_ROWS;
         var _loc12_:Number = this.TILE_LIST_COLUMNS;
         if(dataM.runAsMobile)
         {
            _loc9_ = this.ITEM_WIDTH_MOBILE;
            _loc10_ = this.ITEM_HEIGHT_MOBILE;
            _loc11_ = this.TILE_LIST_ROWS_MOBILE;
         }
         var _loc13_:Array = new Array();
         _loc5_ = 0;
         while(_loc5_ < this.playersData.length)
         {
            _loc6_ = this.playersData[_loc5_];
            if(dataM.runAsMobile)
            {
               _loc16_ = new mcSearchForPlayerListRow_mobile();
            }
            else
            {
               _loc16_ = new mcSearchForPlayerListRow();
            }
            _loc17_ = false;
            if(_loc6_.geo != "" && _loc6_.geo != null)
            {
               _loc17_ = true;
            }
            if(_loc17_)
            {
               _loc23_ = dataM.getAvatarImage(_loc6_.geo);
               _loc23_.x = _loc16_.mcSizer_flag.x;
               _loc23_.y = _loc16_.mcSizer_flag.y;
               _loc16_.addChild(_loc23_);
            }
            _loc18_ = dataM.getLadderRankIconNumber(dataM.getLadderRankByProgress(_loc6_.ladderProgress));
            _loc19_ = externalAssetsM.getAsset("general","Grp_rank" + _loc18_);
            _loc19_.width = _loc16_.mcSizer_rank.width;
            _loc19_.height = _loc16_.mcSizer_rank.height;
            _loc19_.x = _loc16_.mcSizer_rank.x;
            _loc19_.y = _loc16_.mcSizer_rank.y;
            _loc16_.addChild(_loc19_);
            if(_loc4_[_loc6_.playerID] != null)
            {
               _loc16_.mcBackground.gotoAndStop("green");
            }
            else if(_loc5_ % 2 == 0)
            {
               _loc16_.mcBackground.gotoAndStop("regular2");
            }
            TextUtils.updateTextFormat(_loc16_.txtName,15);
            TextUtils.updateTextFormat(_loc16_.txtClan,15);
            _loc16_.txtName.text = dataM.getCensoredString(_loc6_.name);
            if(this.clanNames[_loc6_.clanID] != null)
            {
               _loc16_.txtClan.text = dataM.getCensoredString(this.clanNames[_loc6_.clanID]);
            }
            else
            {
               _loc16_.txtClan.htmlText = TextUtils.getTextFont(16) + "<FONT COLOR = \'#7F7F7F\'>" + getScreenText("notInClan") + "</FONT>";
            }
            _loc20_ = new BMItem();
            _loc20_.initialize(_loc5_,_loc9_,_loc10_,_loc16_,0,0,false,null,dataM.runAsMobile);
            if(dataM.runAsMobile)
            {
               _loc20_.createAssetsBitmap([_loc16_.txtName,_loc16_.txtClan],[_loc19_],_loc16_,false);
            }
            _loc21_ = new BMTileListItem();
            _loc22_ = this.tileListItemClicked;
            if(dataM.runAsMobile)
            {
               _loc22_ = null;
            }
            _loc21_.initialize(_loc9_,_loc10_,_loc20_,"","","",0,_loc22_,null,null,null,null,dataM.runAsMobile);
            if(_loc17_)
            {
               _loc21_.itemsThatNeedsAddingAndRemoving.push(_loc23_);
            }
            _loc13_.push(_loc21_);
            _loc5_++;
         }
         var _loc14_:MovieClip = new Grp_scrollerContent();
         if(dataM.runAsMobile)
         {
            _loc15_ = new mcSearchForPlayerHeader_mobile();
         }
         else
         {
            _loc15_ = new mcSearchForPlayerHeader();
         }
         TextUtils.updateTextFormat(_loc15_.txtName,13);
         TextUtils.updateTextFormat(_loc15_.txtClan,13);
         _loc15_.txtName.text = getGeneralText("nameCaps");
         _loc15_.txtClan.text = getGeneralText("clanCaps");
         this.playersTileList.initialize(screensM.stagePointer,_loc13_,_loc11_,_loc12_,_loc9_,_loc10_,null,true,_loc14_,null,_loc15_,true,0,0.6,true,_loc8_,dataM.runAsMobile);
         this.playersTileList.x = this.mcSizer_tileList.x;
         this.playersTileList.y = this.mcSizer_tileList.y;
         this.mcTileListHolder.addChild(this.playersTileList);
         this.txtInputName.visible = false;
         this.txtInputPlayerID.visible = false;
         this.btnSearch.visible = false;
         this.txtDescName.visible = false;
         this.txtDescOr.visible = false;
         this.txtDescPlayerID.visible = false;
         this.refreshTextsForMobile();
      }
      
      public function cancelFingerWheeling() : void
      {
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.cancelFingerWheeling();
         }
      }
      
      private function tileListItemClicked(param1:uint, param2:Number) : void
      {
         var _loc3_:Object = null;
         if(param2 > -1)
         {
            _loc3_ = this.playersData[param2];
            screensM.screenMultiPlayerChat.addPlayerToChatPlayersData(_loc3_.playerID,_loc3_.name,_loc3_.level,_loc3_.clanID,_loc3_.ladderProgress,_loc3_.geo,"");
            screensM.addScreen("screenMenuMultiPlayerInspect");
            screensM.screenMenuMultiPlayerInspect.refreshScreen(_loc3_.playerID,false,false,false);
         }
      }
      
      public function searchFailed() : void
      {
         screensM.screenConfirmation.displayQuestionOrNotification("searchForPlayerFailed");
      }
      
      public function searchClicked() : void
      {
         remoteM.socketM.lobby_searchForPlayer(int(this.txtInputPlayerID.text),this.txtInputName.text);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
      }
      
      public function backClicked() : void
      {
         screensM.removeScreen("screenSearchForPlayer");
         this.txtInputName.removeEventListener(Event.CHANGE,this.inputNameChanged);
         this.txtInputPlayerID.removeEventListener(Event.CHANGE,this.inputPlayerIDChanged);
         if(this.playersTileList != null)
         {
            this.playersTileList.removeMe();
            this.playersTileList = null;
         }
         if(dataM.runAsMobile)
         {
            this._fingerWheeling.removeMouseListeners();
         }
      }
   }
}

