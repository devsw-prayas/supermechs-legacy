package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMClanFlag;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1301")]
   public class BMScreenClanFlag extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var mcSizer_btnTypeNext:Sprite;
      
      public var mcSizer_btnTypePrevious:Sprite;
      
      public var mcSizer_btnShapeNext:Sprite;
      
      public var mcSizer_btnShapePrevious:Sprite;
      
      public var mcSizer_btnColorNext:Sprite;
      
      public var mcSizer_btnColorPrevious:Sprite;
      
      public var mcSizer_btnRandom:Sprite;
      
      public var mcSizer_btnSave:Sprite;
      
      public var mcSizer_flag:Sprite;
      
      public var btnTypeNext:BMButton_pictureE;
      
      public var btnTypePrevious:BMButton_pictureE;
      
      public var btnShapeNext:BMButton_pictureE;
      
      public var btnShapePrevious:BMButton_pictureE;
      
      public var btnColorNext:BMButton_pictureE;
      
      public var btnColorPrevious:BMButton_pictureE;
      
      public var btnRandom:BMButton;
      
      public var btnSave:BMButton;
      
      public var txtTitle:TextField;
      
      public var txtType:TextField;
      
      public var txtShape:TextField;
      
      public var txtColor:TextField;
      
      private var _assetsCreated:Boolean = false;
      
      private var _type:String;
      
      private var _flagCenterShape:uint;
      
      private var _flagCenterColor:uint;
      
      private var _flagSidesShape:uint;
      
      private var _flagSidesColor:uint;
      
      private var _flagBackgroundColor:uint;
      
      private var mcClanFlag:BMClanFlag;
      
      public function BMScreenClanFlag()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen() : void
      {
         var _loc3_:Function = null;
         var _loc4_:Function = null;
         var _loc5_:Function = null;
         var _loc6_:Function = null;
         var _loc7_:Function = null;
         var _loc8_:Function = null;
         var _loc9_:Function = null;
         var _loc10_:Function = null;
         var _loc11_:Function = null;
         if(this._assetsCreated == false)
         {
            setLanguageManagerScreenName("clanFlag");
            _loc3_ = this.typePreviousClicked;
            _loc4_ = this.typeNextClicked;
            _loc5_ = this.shapePreviousClicked;
            _loc6_ = this.shapeNextClicked;
            _loc7_ = this.colorPreviousClicked;
            _loc8_ = this.colorNextClicked;
            _loc9_ = this.backClicked;
            _loc10_ = this.randomClicked;
            _loc11_ = this.saveClicked;
            if(dataM.runAsMobile)
            {
               _loc3_ = null;
               _loc4_ = null;
               _loc5_ = null;
               _loc6_ = null;
               _loc7_ = null;
               _loc8_ = null;
               _loc9_ = null;
               _loc10_ = null;
               _loc11_ = null;
            }
            screensM.createButtonFromSizer("screenClanFlag","btnTypeNext","pictureE");
            screensM.createButtonFromSizer("screenClanFlag","btnTypePrevious","pictureE");
            screensM.createButtonFromSizer("screenClanFlag","btnShapeNext","pictureE");
            screensM.createButtonFromSizer("screenClanFlag","btnShapePrevious","pictureE");
            screensM.createButtonFromSizer("screenClanFlag","btnColorNext","pictureE");
            screensM.createButtonFromSizer("screenClanFlag","btnColorPrevious","pictureE");
            screensM.createButtonFromSizer("screenClanFlag","btnRandom","regular");
            screensM.createButtonFromSizer("screenClanFlag","btnSave","regular");
            this.btnTypeNext.initialize("","",externalAssetsM.getAsset("general","interface_arrowRight"),null,_loc4_,dataM.runAsMobile);
            this.btnTypePrevious.initialize("","",externalAssetsM.getAsset("general","interface_arrowLeft"),null,_loc3_,dataM.runAsMobile);
            this.btnShapeNext.initialize("","",externalAssetsM.getAsset("general","interface_arrowRight"),null,_loc6_,dataM.runAsMobile);
            this.btnShapePrevious.initialize("","",externalAssetsM.getAsset("general","interface_arrowLeft"),null,_loc5_,dataM.runAsMobile);
            this.btnColorNext.initialize("","",externalAssetsM.getAsset("general","interface_arrowRight"),null,_loc8_,dataM.runAsMobile);
            this.btnColorPrevious.initialize("","",externalAssetsM.getAsset("general","interface_arrowLeft"),null,_loc7_,dataM.runAsMobile);
            this.btnRandom.initialize(getScreenText("random"),"blue",null,null,this.randomClicked,dataM.runAsMobile);
            this.btnSave.initialize(getScreenText("save"),"orange",null,null,this.saveClicked,dataM.runAsMobile);
            this.btnTypeNext.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnTypePrevious.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnShapeNext.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnShapePrevious.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnColorNext.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnColorPrevious.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnRandom.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnSave.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.txtTitle.text = getScreenText("title");
            this.txtColor.text = getScreenText("color");
            this.txtShape.text = getScreenText("shape");
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("clanFlag_texts1",[this.txtTitle,this.txtColor],"",this);
            }
            this._assetsCreated = true;
         }
         this._type = "center";
         this.txtType.text = getScreenText("center");
         this.txtShape.text = getScreenText("shape");
         this.btnShapeNext.visible = true;
         this.btnShapePrevious.visible = true;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:Array = dataM.getClanFlagData(_loc1_.clan_flag);
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
      
      public function typeNextClicked() : void
      {
         if(this._type == "sides")
         {
            this.btnShapeNext.visible = false;
            this.btnShapePrevious.visible = false;
            this.txtShape.text = "";
            this._type = "background";
            this.txtType.text = getScreenText("background");
         }
         else
         {
            this.btnShapeNext.visible = true;
            this.btnShapePrevious.visible = true;
            this.txtShape.text = getScreenText("shape");
            if(this._type == "center")
            {
               this._type = "sides";
               this.txtType.text = getScreenText("sides");
            }
            else
            {
               this._type = "center";
               this.txtType.text = getScreenText("center");
            }
         }
         this.createBitmapTextsForMobile();
      }
      
      public function typePreviousClicked() : void
      {
         if(this._type == "center")
         {
            this.btnShapeNext.visible = false;
            this.btnShapePrevious.visible = false;
            this.txtShape.text = "";
            this._type = "background";
            this.txtType.text = getScreenText("background");
         }
         else
         {
            this.btnShapeNext.visible = true;
            this.btnShapePrevious.visible = true;
            this.txtShape.text = getScreenText("shape");
            if(this._type == "background")
            {
               this._type = "sides";
               this.txtType.text = getScreenText("sides");
            }
            else
            {
               this._type = "center";
               this.txtType.text = getScreenText("center");
            }
         }
         this.createBitmapTextsForMobile();
      }
      
      public function shapeNextClicked() : void
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
      
      public function shapePreviousClicked() : void
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
      
      public function colorNextClicked() : void
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
      
      public function colorPreviousClicked() : void
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
      
      public function randomClicked() : void
      {
         this._flagCenterShape = Math.ceil(Math.random() * dataM.CLAN_FLAG_CENTER_FRAMES);
         this._flagSidesShape = Math.ceil(Math.random() * dataM.CLAN_FLAG_SIDES_FRAMES);
         this._flagCenterColor = Math.ceil(Math.random() * dataM.CLAN_FLAG_COLORS);
         this._flagSidesColor = Math.ceil(Math.random() * dataM.CLAN_FLAG_COLORS);
         this._flagBackgroundColor = Math.ceil(Math.random() * dataM.CLAN_FLAG_COLORS);
         this.createFlag();
      }
      
      public function saveClicked() : void
      {
         var _loc1_:String = this._flagCenterShape + "_" + this._flagSidesShape + "_" + this._flagCenterColor + "_" + this._flagSidesColor + "_" + this._flagBackgroundColor;
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(_loc1_ != _loc2_.clan_flag)
         {
            remoteM.socketM.clan_updateFlag(_loc1_);
            _loc2_.clan_flag = _loc1_;
         }
         this.backClicked();
      }
      
      public function backClicked() : void
      {
         if(this.mcClanFlag != null)
         {
            this.mcClanFlag.removeMe();
            this.mcClanFlag = null;
         }
         screensM.removeScreen("screenClanFlag");
         screensM.screenNewMenu.communityClanClicked(true);
      }
   }
}

