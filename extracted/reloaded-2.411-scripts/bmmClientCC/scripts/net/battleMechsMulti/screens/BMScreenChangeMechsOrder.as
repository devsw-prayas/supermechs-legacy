package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMItem;
   import net.battleMechsMulti.mobiles.BMMechStructure;
   import net.battleMechsMulti.mobiles.BMPlayerData;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1532")]
   public class BMScreenChangeMechsOrder extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcMechsHolder:Sprite;
      
      public var mcTextsHolder:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var mcSizer_mech1:Sprite;
      
      public var mcSizer_mech2:Sprite;
      
      public var mcSizer_mech3:Sprite;
      
      public var mcSizer_mech4:Sprite;
      
      public var mcSizer_mech5:Sprite;
      
      public var mcSizer_mech6:Sprite;
      
      public var mcLocked4:Sprite;
      
      public var mcLocked5:Sprite;
      
      public var mcLocked6:Sprite;
      
      public var mcMouseHitArea:Sprite;
      
      public var txtTitle:TextField;
      
      public var txtDescription:TextField;
      
      public var btnBack:BMButton_pictureE;
      
      public var mcLoadingCover:MovieClip;
      
      private var mech1Icon:BMItem;
      
      private var mech2Icon:BMItem;
      
      private var mech3Icon:BMItem;
      
      private var mech4Icon:BMItem;
      
      private var mech5Icon:BMItem;
      
      private var mech6Icon:BMItem;
      
      private var _firstRefresh:Boolean = true;
      
      private var _draggingActive:Boolean = false;
      
      private var _draggingMechID:uint = 0;
      
      private var _mechsOldLocations:Array;
      
      private var _mechsNewLocations:Array;
      
      private var _mechsMoving:Array;
      
      private var _loadingFramesRemain:uint;
      
      private var _maxMechs:uint;
      
      public function BMScreenChangeMechsOrder()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen() : void
      {
         var _loc2_:Function = null;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("changeMechsOrder");
            screensM.createButtonFromSizer("screenChangeMechsOrder","btnBack","pictureE");
            _loc2_ = this.backClicked;
            if(dataM.runAsMobile)
            {
               _loc2_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc2_,dataM.runAsMobile);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this._firstRefresh = false;
            this.mcLoadingCover.mouseEnabled = false;
            this.mcLoadingCover.mouseChildren = false;
            this.languageUpdate();
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate();
         }
         this.mcLoadingCover.visible = true;
         this.btnBack.disableMe();
         this._draggingActive = false;
         this._mechsOldLocations = [0,1,2,3,4,5,6];
         this._mechsNewLocations = [0,1,2,3,4,5,6];
         this._mechsMoving = [0,false,false,false,false,false,false];
         this._maxMechs = dataM.battleMaxMechs;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_.level >= dataM.LEVEL_MAX)
         {
            this._maxMechs = dataM.inventoryMaxMechs;
         }
         if(this._maxMechs == 6)
         {
            this.mcLocked4.visible = false;
            this.mcLocked5.visible = false;
            this.mcLocked6.visible = false;
         }
         else
         {
            this.mcLocked4.visible = true;
            this.mcLocked5.visible = true;
            this.mcLocked6.visible = true;
         }
         if(dataM.runAsMobile)
         {
            this._loadingFramesRemain = 2;
         }
         else
         {
            this._loadingFramesRemain = 0;
            this.loadingComplete();
         }
      }
      
      private function languageUpdate() : void
      {
         var _loc1_:uint = 0;
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtTitle,20);
            _loc1_ = 16;
            switch(dataM.languageID)
            {
               case 3:
                  _loc1_ = 14;
                  break;
               case 5:
                  _loc1_ = 13;
                  break;
               case 7:
                  _loc1_ = 14;
            }
            TextUtils.updateTextFormat(this.txtDescription,_loc1_);
            TextUtils.updateTextFormat(this.mcLoadingCover.txtLoading,16);
         }
         this.txtTitle.text = getScreenText("title");
         this.txtDescription.text = getScreenText("description");
         this.mcLoadingCover.txtLoading.text = getScreenText("pleaseWait");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("changeMechsOreder_loading",[this.mcLoadingCover.txtLoading],"",this.mcLoadingCover);
         }
      }
      
      private function loadingComplete() : void
      {
         this.mcLoadingCover.visible = false;
         this.btnBack.enableMe();
         this.createMechIcons();
         if(dataM.runAsMobile == false)
         {
            this.mcMouseHitArea.addEventListener(MouseEvent.MOUSE_DOWN,this.mechsMouseDown);
            this.mcMouseHitArea.addEventListener(MouseEvent.MOUSE_UP,this.mechsMouseUp);
            this.mcMouseHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.mechsMouseUp);
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            if(this._loadingFramesRemain > 0)
            {
               --this._loadingFramesRemain;
               if(this._loadingFramesRemain == 0)
               {
                  this.loadingComplete();
               }
            }
            else
            {
               this.draggingHandler();
            }
         }
      }
      
      private function mechsMouseDown(param1:MouseEvent) : void
      {
         this.mechsMouseDownSub();
      }
      
      private function mechsMouseUp(param1:MouseEvent) : void
      {
         this.mechsMouseUpSub();
      }
      
      public function mechsMouseDownSub() : void
      {
         var _loc3_:BMItem = null;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         this._draggingMechID = 0;
         var _loc1_:Number = 999;
         var _loc2_:uint = 1;
         while(_loc2_ <= this._maxMechs)
         {
            _loc3_ = this["mech" + _loc2_ + "Icon"];
            _loc4_ = mouseX - (_loc3_.x + _loc3_.width / 2);
            _loc5_ = mouseY - (_loc3_.y + _loc3_.height / 2);
            _loc6_ = dataM.getVectorSize(_loc4_,_loc5_);
            if(_loc1_ > _loc6_)
            {
               _loc1_ = _loc6_;
               this._draggingMechID = _loc2_;
            }
            _loc2_++;
         }
         this["mech" + this._draggingMechID + "Icon"].parent.removeChild(this["mech" + this._draggingMechID + "Icon"]);
         this.mcMechsHolder.addChild(this["mech" + this._draggingMechID + "Icon"]);
         this._draggingActive = true;
      }
      
      public function mechsMouseUpSub() : void
      {
         if(this._draggingMechID > 0)
         {
            this._mechsMoving[this._draggingMechID] = true;
         }
         this._draggingMechID = 0;
         this._draggingActive = false;
      }
      
      private function draggingHandler() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Sprite = null;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:BMItem = null;
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:Number = NaN;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:BMItem = null;
         if(this._draggingActive)
         {
            _loc5_ = this["mech" + this._draggingMechID + "Icon"];
            _loc5_.x = mouseX - _loc5_.width / 2;
            _loc5_.y = mouseY - _loc5_.height / 2;
            _loc6_ = 999;
            _loc7_ = 0;
            _loc1_ = 1;
            while(_loc1_ <= this._maxMechs)
            {
               _loc2_ = this["mcSizer_mech" + _loc1_];
               _loc3_ = _loc5_.x - _loc2_.x;
               _loc4_ = _loc5_.y - _loc2_.y;
               _loc8_ = dataM.getVectorSize(_loc3_,_loc4_);
               if(_loc6_ > _loc8_)
               {
                  _loc6_ = _loc8_;
                  _loc7_ = _loc1_;
               }
               _loc1_++;
            }
            if(_loc7_ != this._mechsNewLocations[this._draggingMechID])
            {
               _loc9_ = 0;
               _loc1_ = 1;
               while(_loc1_ <= this._maxMechs)
               {
                  if(this._mechsNewLocations[_loc1_] == _loc7_)
                  {
                     _loc9_ = _loc1_;
                     _loc1_ = this._maxMechs;
                  }
                  _loc1_++;
               }
               _loc10_ = uint(this._mechsNewLocations[_loc9_]);
               this._mechsNewLocations[_loc9_] = this._mechsNewLocations[this._draggingMechID];
               this._mechsNewLocations[this._draggingMechID] = _loc10_;
            }
         }
         if(Boolean(this._draggingActive) || Boolean(this._mechsMoving[1]) || Boolean(this._mechsMoving[2]) || Boolean(this._mechsMoving[3]) || Boolean(this._mechsMoving[4]) || Boolean(this._mechsMoving[5]) || Boolean(this._mechsMoving[6]))
         {
            _loc1_ = 1;
            while(_loc1_ <= this._maxMechs)
            {
               if(_loc1_ != this._draggingMechID)
               {
                  _loc11_ = this["mech" + _loc1_ + "Icon"];
                  _loc2_ = this["mcSizer_mech" + this._mechsNewLocations[_loc1_]];
                  _loc3_ = _loc11_.x - _loc2_.x;
                  _loc4_ = _loc11_.y - _loc2_.y;
                  if(Math.abs(_loc3_) > 1 || Math.abs(_loc4_) > 1)
                  {
                     if(Math.abs(_loc3_) > 1)
                     {
                        this._mechsMoving[_loc1_] = true;
                        _loc11_.x -= _loc3_ * 0.3;
                     }
                     else
                     {
                        _loc11_.x = _loc2_.x;
                     }
                     if(Math.abs(_loc4_) > 1)
                     {
                        this._mechsMoving[_loc1_] = true;
                        _loc11_.y -= _loc4_ * 0.3;
                     }
                     else
                     {
                        _loc11_.y = _loc2_.y;
                     }
                  }
                  else
                  {
                     this._mechsMoving[_loc1_] = false;
                  }
               }
               _loc1_++;
            }
         }
         if(dataM.runAsMobile)
         {
            if(this._draggingActive)
            {
               if(mouseX < this.mcMouseHitArea.x || mouseX > this.mcMouseHitArea.x + this.mcMouseHitArea.width || mouseY < this.mcMouseHitArea.y || mouseY > this.mcMouseHitArea.y + this.mcMouseHitArea.height)
               {
                  this.mechsMouseUpSub();
               }
            }
         }
      }
      
      private function removeMechIcons() : void
      {
         var _loc1_:uint = 1;
         while(_loc1_ <= this._maxMechs)
         {
            if(this["mech" + _loc1_ + "Icon"] != null)
            {
               this["mech" + _loc1_ + "Icon"].removeMe();
               this["mech" + _loc1_ + "Icon"] = null;
            }
            _loc1_++;
         }
      }
      
      private function createMechIcons() : void
      {
         var _loc3_:BMMechStructure = null;
         this.removeMechIcons();
         var _loc1_:BMPlayerData = dataM.playersData[dataM.player1PlayerID];
         var _loc2_:uint = 1;
         while(_loc2_ <= this._maxMechs)
         {
            _loc3_ = _loc1_.mechStructures[_loc2_];
            if(_loc3_.mechID > 0)
            {
               this["mech" + _loc2_ + "Icon"] = dataM.createMechIcon(dataM.player1PlayerID,_loc2_,_loc3_,"",this.mcSizer_mech1.width,0,false,true,true,false);
               this["mech" + _loc2_ + "Icon"].x = this["mcSizer_mech" + _loc2_].x;
               this["mech" + _loc2_ + "Icon"].y = this["mcSizer_mech" + _loc2_].y;
               this.mcMechsHolder.addChild(this["mech" + _loc2_ + "Icon"]);
            }
            _loc2_++;
         }
      }
      
      public function backClicked() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:uint = 1;
         while(_loc2_ <= this._maxMechs)
         {
            if(this._mechsOldLocations[_loc2_] != this._mechsNewLocations[_loc2_])
            {
               _loc1_ = true;
               _loc2_ = this._maxMechs;
            }
            _loc2_++;
         }
         if(_loc1_)
         {
            screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait");
            remoteM.socketM.inventory_changeMechsOrder(this._mechsNewLocations);
         }
         else
         {
            if(screensM.isScreenOpened("screenHangerInventory"))
            {
               screensM.screenHangerInventory.changeMechsOrderScreenClosed();
            }
            this.removeMe();
         }
      }
      
      public function mechsOrderChangeSuccess() : void
      {
         screensM.removeScreen("screenConfirmation");
         this.removeMe();
      }
      
      public function mechsOrderChangeFailed() : void
      {
         this.removeMe();
         screensM.screenConfirmation.displayQuestionOrNotification("changeMechsOrderFailed");
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen("screenChangeMechsOrder");
         this.removeMechIcons();
         if(dataM.runAsMobile == false)
         {
            this.mcMouseHitArea.removeEventListener(MouseEvent.MOUSE_DOWN,this.mechsMouseDown);
            this.mcMouseHitArea.removeEventListener(MouseEvent.MOUSE_UP,this.mechsMouseUp);
            this.mcMouseHitArea.removeEventListener(MouseEvent.MOUSE_OUT,this.mechsMouseUp);
         }
      }
   }
}

