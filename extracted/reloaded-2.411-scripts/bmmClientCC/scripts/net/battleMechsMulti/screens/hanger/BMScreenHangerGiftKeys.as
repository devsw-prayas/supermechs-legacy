package net.battleMechsMulti.screens.hanger
{
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMBar;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   import net.battleMechsMulti.screens.BMBaseScreen;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1472")]
   public class BMScreenHangerGiftKeys extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcIconsHolder:Sprite;
      
      public var mcSizer_btnCopy1:Sprite;
      
      public var mcSizer_btnCopy2:Sprite;
      
      public var mcSizer_btnCopy3:Sprite;
      
      public var mcSizer_btnClaim1:Sprite;
      
      public var mcSizer_btnClaim2:Sprite;
      
      public var mcSizer_btnClaim3:Sprite;
      
      public var txtGuide:TextField;
      
      public var txtGiftTitle1:TextField;
      
      public var txtGiftTitle2:TextField;
      
      public var txtGiftTitle3:TextField;
      
      public var txtGiftKey1:TextField;
      
      public var txtGiftKey2:TextField;
      
      public var txtGiftKey3:TextField;
      
      public var txtPlayerProgress1:TextField;
      
      public var txtPlayerProgress2:TextField;
      
      public var txtPlayerProgress3:TextField;
      
      public var txtGoldClaim1:TextField;
      
      public var txtGoldClaim2:TextField;
      
      public var txtGoldClaim3:TextField;
      
      public var txtCompleted1:TextField;
      
      public var txtCompleted2:TextField;
      
      public var txtCompleted3:TextField;
      
      public var txtGoldProgress1_1:TextField;
      
      public var txtGoldProgress1_2:TextField;
      
      public var txtGoldProgress2_1:TextField;
      
      public var txtGoldProgress2_2:TextField;
      
      public var txtGoldProgress3_1:TextField;
      
      public var txtGoldProgress3_2:TextField;
      
      public var mcProgressBar1:BMBar;
      
      public var mcProgressBar2:BMBar;
      
      public var mcProgressBar3:BMBar;
      
      public var mcGoldBoxClaim1:Sprite;
      
      public var mcGoldBoxClaim2:Sprite;
      
      public var mcGoldBoxClaim3:Sprite;
      
      public var mcSilverBoxClaim1:Sprite;
      
      public var mcSilverBoxClaim2:Sprite;
      
      public var mcSilverBoxClaim3:Sprite;
      
      public var mcGoldBoxProgress1:Sprite;
      
      public var mcGoldBoxProgress2:Sprite;
      
      public var mcGoldBoxProgress3:Sprite;
      
      public var mcSilverBoxProgress1:Sprite;
      
      public var mcSilverBoxProgress2:Sprite;
      
      public var mcSilverBoxProgress3:Sprite;
      
      public var mcGoldClaim1:Sprite;
      
      public var mcGoldClaim2:Sprite;
      
      public var mcGoldClaim3:Sprite;
      
      public var mcGoldProgress1_1:Sprite;
      
      public var mcGoldProgress1_2:Sprite;
      
      public var mcGoldProgress2_1:Sprite;
      
      public var mcGoldProgress2_2:Sprite;
      
      public var mcGoldProgress3_1:Sprite;
      
      public var mcGoldProgress3_2:Sprite;
      
      public var mcProgressSteps1:MovieClip;
      
      public var mcProgressSteps2:MovieClip;
      
      public var mcProgressSteps3:MovieClip;
      
      public var btnCopy1:BMButton;
      
      public var btnCopy2:BMButton;
      
      public var btnCopy3:BMButton;
      
      public var btnClaim1:BMButton;
      
      public var btnClaim2:BMButton;
      
      public var btnClaim3:BMButton;
      
      private var _giftKeyByNumber:Array;
      
      private var _giftTtitle1OriginYPos:Number;
      
      private var _giftTtitle2OriginYPos:Number;
      
      private var _giftTtitle3OriginYPos:Number;
      
      private var _barPinsPositioned:Boolean = false;
      
      private var _firstRefresh:Boolean = true;
      
      private const DISPLAY_BASE_LEVEL:uint = 2;
      
      public function BMScreenHangerGiftKeys()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("gifts");
      }
      
      public function refreshScreen(param1:Boolean) : void
      {
         var _loc5_:Object = null;
         var _loc6_:Function = null;
         var _loc7_:Function = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:TextField = null;
         var _loc13_:TextField = null;
         var _loc14_:TextField = null;
         var _loc15_:TextField = null;
         var _loc16_:TextField = null;
         var _loc17_:TextField = null;
         var _loc18_:TextField = null;
         var _loc19_:BMBar = null;
         var _loc20_:Sprite = null;
         var _loc21_:MovieClip = null;
         var _loc22_:Sprite = null;
         var _loc23_:BMButton = null;
         var _loc24_:BMButton = null;
         var _loc25_:Sprite = null;
         var _loc26_:Sprite = null;
         var _loc27_:Sprite = null;
         var _loc28_:Boolean = false;
         var _loc29_:Number = NaN;
         var _loc30_:String = null;
         var _loc31_:String = null;
         var _loc32_:uint = 0;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenHangerGiftKeys","btnCopy1","regular");
            screensM.createButtonFromSizer("screenHangerGiftKeys","btnCopy2","regular");
            screensM.createButtonFromSizer("screenHangerGiftKeys","btnCopy3","regular");
            screensM.createButtonFromSizer("screenHangerGiftKeys","btnClaim1","regular");
            screensM.createButtonFromSizer("screenHangerGiftKeys","btnClaim2","regular");
            screensM.createButtonFromSizer("screenHangerGiftKeys","btnClaim3","regular");
            _loc6_ = this.copyGiftKeyClicked;
            _loc7_ = this.claimBonusClicked;
            if(dataM.runAsMobile)
            {
               _loc6_ = null;
               _loc7_ = null;
            }
            this.btnCopy1.initialize(getScreenText("copy"),"blue",null,[1],_loc6_,dataM.runAsMobile);
            this.btnCopy2.initialize(getScreenText("copy"),"blue",null,[2],_loc6_,dataM.runAsMobile);
            this.btnCopy3.initialize(getScreenText("copy"),"blue",null,[3],_loc6_,dataM.runAsMobile);
            this.btnClaim1.initialize(getScreenText("claim"),"orange",null,[1],_loc7_,dataM.runAsMobile);
            this.btnClaim2.initialize(getScreenText("claim"),"orange",null,[2],_loc7_,dataM.runAsMobile);
            this.btnClaim3.initialize(getScreenText("claim"),"orange",null,[3],_loc7_,dataM.runAsMobile);
            if(dataM.runAsMobile == false)
            {
               this.btnCopy1.buttonCore.addMouseOverListerner(this.copyGiftKeyButtonMouseOver);
               this.btnCopy1.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnCopy2.buttonCore.addMouseOverListerner(this.copyGiftKeyButtonMouseOver);
               this.btnCopy2.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnCopy3.buttonCore.addMouseOverListerner(this.copyGiftKeyButtonMouseOver);
               this.btnCopy3.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnClaim1.buttonCore.addMouseOverListerner(this.claimBonusButtonMouseOver);
               this.btnClaim1.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnClaim2.buttonCore.addMouseOverListerner(this.claimBonusButtonMouseOver);
               this.btnClaim2.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
               this.btnClaim3.buttonCore.addMouseOverListerner(this.claimBonusButtonMouseOver);
               this.btnClaim3.buttonCore.addMouseOutListerner(this.generalButtonMouseOut);
            }
            this.btnCopy1.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnCopy2.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnCopy3.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnClaim1.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnClaim2.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btnClaim3.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this._giftTtitle1OriginYPos = this.txtGiftTitle1.y;
            this._giftTtitle2OriginYPos = this.txtGiftTitle2.y;
            this._giftTtitle3OriginYPos = this.txtGiftTitle3.y;
            this.languageUpdate();
            this.mcProgressBar1.initialize("green","right");
            this.mcProgressBar1.addSeparateorLines(5);
            this.mcProgressBar2.initialize("green","right");
            this.mcProgressBar2.addSeparateorLines(5);
            this.mcProgressBar3.initialize("green","right");
            this.mcProgressBar3.addSeparateorLines(5);
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            this.languageUpdate(true);
         }
         var _loc2_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc3_:uint = 1;
         if(param1)
         {
            this.mcProgressBar1.setFill(0,false);
            this.mcProgressBar2.setFill(0,false);
            this.mcProgressBar3.setFill(0,false);
         }
         if(this._barPinsPositioned == false)
         {
            _loc8_ = dataM.giftKeysBonus3Level - this.DISPLAY_BASE_LEVEL;
            _loc9_ = (dataM.giftKeysBonus1Level - this.DISPLAY_BASE_LEVEL) / _loc8_;
            _loc10_ = (dataM.giftKeysBonus2Level - this.DISPLAY_BASE_LEVEL) / _loc8_;
            _loc11_ = (dataM.giftKeysBonus3Level - this.DISPLAY_BASE_LEVEL) / _loc8_;
            this.mcProgressSteps1.mcPin1.x = this.mcProgressSteps1.mcBarSizer.x + _loc9_ * this.mcProgressSteps1.mcBarSizer.width;
            this.mcProgressSteps1.mcPin2.x = this.mcProgressSteps1.mcBarSizer.x + _loc10_ * this.mcProgressSteps1.mcBarSizer.width;
            this.mcProgressSteps1.mcPin3.x = this.mcProgressSteps1.mcBarSizer.x + _loc11_ * this.mcProgressSteps1.mcBarSizer.width;
            this.mcProgressSteps2.mcPin1.x = this.mcProgressSteps2.mcBarSizer.x + _loc9_ * this.mcProgressSteps2.mcBarSizer.width;
            this.mcProgressSteps2.mcPin2.x = this.mcProgressSteps2.mcBarSizer.x + _loc10_ * this.mcProgressSteps2.mcBarSizer.width;
            this.mcProgressSteps2.mcPin3.x = this.mcProgressSteps2.mcBarSizer.x + _loc11_ * this.mcProgressSteps2.mcBarSizer.width;
            this.mcProgressSteps3.mcPin1.x = this.mcProgressSteps3.mcBarSizer.x + _loc9_ * this.mcProgressSteps3.mcBarSizer.width;
            this.mcProgressSteps3.mcPin2.x = this.mcProgressSteps3.mcBarSizer.x + _loc10_ * this.mcProgressSteps3.mcBarSizer.width;
            this.mcProgressSteps3.mcPin3.x = this.mcProgressSteps3.mcBarSizer.x + _loc11_ * this.mcProgressSteps3.mcBarSizer.width;
            this._barPinsPositioned = true;
            this.txtGoldProgress1_1.text = dataM.getNumberWithComma(dataM.giftKeysBonus1Gold);
            this.txtGoldProgress1_2.text = dataM.getNumberWithComma(dataM.giftKeysBonus2Gold);
            this.txtGoldProgress2_1.text = dataM.getNumberWithComma(dataM.giftKeysBonus1Gold);
            this.txtGoldProgress2_2.text = dataM.getNumberWithComma(dataM.giftKeysBonus2Gold);
            this.txtGoldProgress3_1.text = dataM.getNumberWithComma(dataM.giftKeysBonus1Gold);
            this.txtGoldProgress3_2.text = dataM.getNumberWithComma(dataM.giftKeysBonus2Gold);
            this.txtGoldProgress1_1.x = this.mcProgressSteps1.x + this.mcProgressSteps1.mcPin1.x - this.txtGoldProgress1_1.width;
            this.txtGoldProgress2_1.x = this.txtGoldProgress1_1.x;
            this.txtGoldProgress3_1.x = this.txtGoldProgress1_1.x;
            this.mcGoldProgress1_1.x = this.mcProgressSteps1.x + this.mcProgressSteps1.mcPin1.x + 13;
            this.mcGoldProgress2_1.x = this.mcGoldProgress1_1.x;
            this.mcGoldProgress3_1.x = this.mcGoldProgress1_1.x;
            this.txtGoldProgress1_2.x = this.mcProgressSteps1.x + this.mcProgressSteps1.mcPin2.x - this.txtGoldProgress1_2.width;
            this.txtGoldProgress2_2.x = this.txtGoldProgress1_2.x;
            this.txtGoldProgress3_2.x = this.txtGoldProgress1_2.x;
            this.mcGoldProgress1_2.x = this.mcProgressSteps1.x + this.mcProgressSteps1.mcPin2.x + 13;
            this.mcGoldProgress2_2.x = this.mcGoldProgress1_2.x;
            this.mcGoldProgress3_2.x = this.mcGoldProgress1_2.x;
         }
         this._giftKeyByNumber = new Array();
         var _loc4_:* = 0;
         if(dataM.useSilverBoxesForGifts)
         {
            this.mcGoldBoxClaim1.visible = false;
            this.mcGoldBoxClaim2.visible = false;
            this.mcGoldBoxClaim3.visible = false;
            this.mcGoldBoxProgress1.visible = false;
            this.mcGoldBoxProgress2.visible = false;
            this.mcGoldBoxProgress3.visible = false;
         }
         else
         {
            this.mcSilverBoxClaim1.visible = false;
            this.mcSilverBoxClaim2.visible = false;
            this.mcSilverBoxClaim3.visible = false;
            this.mcSilverBoxProgress1.visible = false;
            this.mcSilverBoxProgress2.visible = false;
            this.mcSilverBoxProgress3.visible = false;
         }
         for each(_loc5_ in _loc2_.gifts)
         {
            if(++_loc4_ <= 3)
            {
               this._giftKeyByNumber[_loc3_] = _loc5_.giftKey;
               _loc12_ = this["txtGiftTitle" + _loc3_];
               _loc13_ = this["txtGiftKey" + _loc3_];
               _loc14_ = this["txtPlayerProgress" + _loc3_];
               _loc15_ = this["txtGoldClaim" + _loc3_];
               _loc16_ = this["txtCompleted" + _loc3_];
               _loc17_ = this["txtGoldProgress" + _loc3_ + "_1"];
               _loc18_ = this["txtGoldProgress" + _loc3_ + "_2"];
               _loc19_ = this["mcProgressBar" + _loc3_];
               if(dataM.useSilverBoxesForGifts)
               {
                  _loc20_ = this["mcSilverBoxClaim" + _loc3_];
               }
               else
               {
                  _loc20_ = this["mcGoldBoxClaim" + _loc3_];
               }
               _loc21_ = this["mcProgressSteps" + _loc3_];
               _loc22_ = this["mcGoldClaim" + _loc3_];
               _loc23_ = this["btnCopy" + _loc3_];
               _loc24_ = this["btnClaim" + _loc3_];
               _loc25_ = this["mcGoldProgress" + _loc3_ + "_1"];
               _loc26_ = this["mcGoldProgress" + _loc3_ + "_2"];
               if(dataM.useSilverBoxesForGifts)
               {
                  _loc27_ = this["mcSilverBoxProgress" + _loc3_];
               }
               else
               {
                  _loc27_ = this["mcGoldBoxProgress" + _loc3_];
               }
               _loc17_.visible = false;
               _loc18_.visible = false;
               _loc25_.visible = false;
               _loc26_.visible = false;
               _loc22_.visible = false;
               _loc20_.visible = false;
               _loc15_.visible = false;
               _loc27_.visible = false;
               if(_loc5_.receiverID == 0)
               {
                  _loc12_.text = getScreenText("giftKey");
                  _loc13_.text = String(_loc5_.giftKey);
                  _loc13_.visible = true;
                  _loc14_.visible = false;
                  _loc19_.visible = false;
                  _loc21_.visible = false;
                  _loc24_.visible = false;
                  _loc23_.visible = true;
                  _loc16_.visible = false;
               }
               else
               {
                  _loc12_.text = "";
                  _loc13_.visible = false;
                  _loc23_.visible = false;
                  _loc28_ = false;
                  _loc29_ = 0;
                  _loc21_.mcPin1.visible = true;
                  _loc21_.mcPin2.visible = true;
                  _loc21_.mcPin3.visible = true;
                  if(_loc5_.ownerBonusClaimed >= 1)
                  {
                     _loc21_.mcPin1.visible = false;
                     if(_loc5_.ownerBonusClaimed >= 2)
                     {
                        _loc21_.mcPin2.visible = false;
                        if(_loc5_.ownerBonusClaimed >= 3)
                        {
                           _loc21_.mcPin3.visible = false;
                        }
                     }
                  }
                  if(_loc2_.giftReceiversLevelProgress[_loc5_.receiverID] != null)
                  {
                     _loc32_ = uint(_loc2_.giftReceiversLevelProgress[_loc5_.receiverID].level);
                     TsLogger.log(_loc5_.receiverName + " receiverLevel:" + _loc32_);
                     _loc29_ = (_loc32_ - this.DISPLAY_BASE_LEVEL) / (dataM.giftKeysBonus3Level - this.DISPLAY_BASE_LEVEL);
                     _loc19_.setFill(_loc29_,true);
                     if(_loc5_.ownerBonusClaimed == 0)
                     {
                        _loc15_.text = String(dataM.getNumberWithComma(dataM.giftKeysBonus1Gold));
                        _loc15_.visible = true;
                        _loc22_.visible = true;
                        if(_loc32_ >= dataM.giftKeysBonus1Level)
                        {
                           _loc28_ = true;
                        }
                        _loc17_.visible = true;
                        _loc18_.visible = true;
                        _loc25_.visible = true;
                        _loc26_.visible = true;
                        _loc27_.visible = true;
                     }
                     else if(_loc5_.ownerBonusClaimed == 1)
                     {
                        _loc15_.text = String(dataM.getNumberWithComma(dataM.giftKeysBonus2Gold));
                        _loc15_.visible = true;
                        _loc22_.visible = true;
                        if(_loc32_ >= dataM.giftKeysBonus2Level)
                        {
                           _loc28_ = true;
                        }
                        _loc18_.visible = true;
                        _loc26_.visible = true;
                        _loc27_.visible = true;
                     }
                     else if(_loc5_.ownerBonusClaimed == 2)
                     {
                        _loc20_.visible = true;
                        if(_loc32_ >= dataM.giftKeysBonus3Level)
                        {
                           _loc28_ = true;
                        }
                        _loc27_.visible = true;
                     }
                  }
                  _loc14_.visible = true;
                  _loc30_ = _loc5_.receiverName;
                  _loc31_ = getScreenText("receiverProgress");
                  _loc31_ = dataM.replaceStringInText(_loc31_,"%NAME%",_loc30_);
                  _loc14_.text = _loc31_;
                  _loc19_.visible = true;
                  _loc21_.visible = true;
                  if(_loc28_)
                  {
                     _loc24_.visible = true;
                     _loc24_.enableMe();
                     _loc16_.visible = false;
                  }
                  else if(_loc5_.ownerBonusClaimed < 3)
                  {
                     _loc24_.visible = true;
                     _loc24_.disableMe();
                     _loc16_.visible = false;
                  }
                  else
                  {
                     _loc24_.visible = false;
                     _loc16_.visible = true;
                  }
               }
               _loc3_++;
            }
         }
         if(_loc4_ < 3)
         {
            _loc3_ = _loc4_ + 1;
            while(_loc3_ <= 3)
            {
               this["txtGiftTitle" + _loc3_].visible = false;
               this["txtGiftKey" + _loc3_].visible = false;
               this["txtPlayerProgress" + _loc3_].visible = false;
               this["txtGoldClaim" + _loc3_].visible = false;
               this["txtCompleted" + _loc3_].visible = false;
               this["txtGoldProgress" + _loc3_ + "_1"].visible = false;
               this["txtGoldProgress" + _loc3_ + "_2"].visible = false;
               this["mcProgressBar" + _loc3_].visible = false;
               if(dataM.useSilverBoxesForGifts)
               {
                  this["mcSilverBoxClaim" + _loc3_].visible = false;
               }
               else
               {
                  this["mcGoldBoxClaim" + _loc3_].visible = false;
               }
               this["mcProgressSteps" + _loc3_].visible = false;
               this["mcGoldClaim" + _loc3_].visible = false;
               this["btnCopy" + _loc3_].visible = false;
               this["btnClaim" + _loc3_].visible = false;
               this["mcGoldProgress" + _loc3_ + "_1"].visible = false;
               this["mcGoldProgress" + _loc3_ + "_2"].visible = false;
               if(dataM.useSilverBoxesForGifts)
               {
                  this["mcSilverBoxProgress" + _loc3_].visible = false;
               }
               else
               {
                  this["mcGoldBoxProgress" + _loc3_].visible = false;
               }
               _loc3_++;
            }
         }
         this.createTextBitmapsForMobile();
      }
      
      private function createTextBitmapsForMobile() : void
      {
         var _loc1_:Array = null;
         if(dataM.runAsMobile)
         {
            _loc1_ = [this.txtGiftTitle1,this.txtGiftTitle2,this.txtGiftTitle3,this.txtGoldClaim1,this.txtGoldClaim2,this.txtGoldClaim3];
            _loc1_.push(this.txtGoldProgress1_1,this.txtGoldProgress1_2,this.txtGoldProgress2_1,this.txtGoldProgress2_2,this.txtGoldProgress3_1,this.txtGoldProgress3_2);
            _loc1_.push(this.txtPlayerProgress1,this.txtPlayerProgress2,this.txtPlayerProgress3,this.txtCompleted1,this.txtCompleted2,this.txtCompleted3);
            screensM.createMultipleTextsBitmap("gifts_texts",_loc1_,"",this.mcIconsHolder);
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         var _loc2_:uint = 18;
         var _loc3_:uint = 18;
         var _loc4_:uint = 18;
         var _loc5_:uint = 16;
         var _loc6_:uint = 20;
         var _loc7_:uint = 25;
         var _loc8_:uint = 33;
         switch(dataM.languageID)
         {
            case 3:
               this.txtGiftTitle1.y = this._giftTtitle1OriginYPos - 15;
               this.txtGiftTitle2.y = this._giftTtitle2OriginYPos - 15;
               this.txtGiftTitle3.y = this._giftTtitle3OriginYPos - 15;
               _loc7_ = 25;
               break;
            case 5:
               this.txtGiftTitle1.y = this._giftTtitle1OriginYPos - 15;
               this.txtGiftTitle2.y = this._giftTtitle2OriginYPos - 15;
               this.txtGiftTitle3.y = this._giftTtitle3OriginYPos - 15;
               _loc2_ = 14;
               _loc7_ = 23;
               break;
            case 7:
            case 9:
               this.txtGiftTitle1.y = this._giftTtitle1OriginYPos - 15;
               this.txtGiftTitle2.y = this._giftTtitle2OriginYPos - 15;
               this.txtGiftTitle3.y = this._giftTtitle3OriginYPos - 15;
               break;
            default:
               this.txtGiftTitle1.y = this._giftTtitle1OriginYPos;
               this.txtGiftTitle2.y = this._giftTtitle2OriginYPos;
               this.txtGiftTitle3.y = this._giftTtitle3OriginYPos;
         }
         if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            TextUtils.updateTextFormat(this.txtCompleted1,_loc4_);
            TextUtils.updateTextFormat(this.txtCompleted2,_loc4_);
            TextUtils.updateTextFormat(this.txtCompleted3,_loc4_);
            TextUtils.updateTextFormat(this.txtGiftTitle1,_loc7_);
            TextUtils.updateTextFormat(this.txtGiftTitle2,_loc7_);
            TextUtils.updateTextFormat(this.txtGiftTitle3,_loc7_);
            TextUtils.updateTextFormat(this.txtGoldClaim1,_loc6_);
            TextUtils.updateTextFormat(this.txtGoldClaim2,_loc6_);
            TextUtils.updateTextFormat(this.txtGoldClaim3,_loc6_);
            TextUtils.updateTextFormat(this.txtGoldProgress1_1,_loc5_);
            TextUtils.updateTextFormat(this.txtGoldProgress1_2,_loc5_);
            TextUtils.updateTextFormat(this.txtGoldProgress2_1,_loc5_);
            TextUtils.updateTextFormat(this.txtGoldProgress2_2,_loc5_);
            TextUtils.updateTextFormat(this.txtGoldProgress3_1,_loc5_);
            TextUtils.updateTextFormat(this.txtGoldProgress3_2,_loc5_);
            TextUtils.updateTextFormat(this.txtGuide,_loc2_);
            TextUtils.updateTextFormat(this.txtPlayerProgress1,_loc3_);
            TextUtils.updateTextFormat(this.txtPlayerProgress2,_loc3_);
            TextUtils.updateTextFormat(this.txtPlayerProgress3,_loc3_);
            TextUtils.updateTextFormat(this.btnClaim1.txtButtonName,_loc8_);
            TextUtils.updateTextFormat(this.btnClaim2.txtButtonName,_loc8_);
            TextUtils.updateTextFormat(this.btnClaim3.txtButtonName,_loc8_);
            TextUtils.updateTextFormat(this.btnCopy1.txtButtonName,_loc8_);
            TextUtils.updateTextFormat(this.btnCopy2.txtButtonName,_loc8_);
            TextUtils.updateTextFormat(this.btnCopy3.txtButtonName,_loc8_);
            param1 = true;
         }
         if(param1)
         {
            this.btnClaim1.setButtonName(getScreenText("claim"));
            this.btnClaim2.setButtonName(getScreenText("claim"));
            this.btnClaim3.setButtonName(getScreenText("claim"));
            this.btnCopy1.setButtonName(getScreenText("copy"));
            this.btnCopy2.setButtonName(getScreenText("copy"));
            this.btnCopy3.setButtonName(getScreenText("copy"));
         }
         this.txtCompleted1.text = getScreenText("completed");
         this.txtCompleted2.text = getScreenText("completed");
         this.txtCompleted3.text = getScreenText("completed");
         var _loc9_:String = getScreenText("keysGuide");
         _loc9_ = dataM.replaceStringInText(_loc9_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_GOLD + "\'>");
         _loc9_ = dataM.replaceStringInText(_loc9_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_GIFT_KEY + "\'>");
         this.txtGuide.htmlText = TextUtils.getTextFont(_loc2_) + _loc9_;
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("gifts_guide",[this.txtGuide],"",this);
         }
      }
      
      public function claimBonusClicked(param1:uint) : void
      {
         var _loc2_:BMButton = this["btnClaim" + param1];
         _loc2_.disableMe();
         remoteM.socketM.lobby_claimGiftBonus(this._giftKeyByNumber[param1]);
         screensM.screenConfirmation.displayQuestionOrNotification("pleaseWait",-1,-1);
         tooltip.hideToolTip();
      }
      
      private function claimBonusButtonMouseOver(param1:uint) : void
      {
         tooltip.showToolTip("regularText",getScreenText("claimBonus"),-1,-1);
      }
      
      private function generalButtonMouseOut(param1:uint) : void
      {
         tooltip.hideToolTip();
      }
      
      public function copyGiftKeyClicked(param1:uint) : void
      {
         var _loc2_:TextField = this["txtGiftKey" + param1];
         Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,_loc2_.text,true);
      }
      
      private function copyGiftKeyButtonMouseOver(param1:uint) : void
      {
      }
      
      public function removeMe() : void
      {
         if(screensM.isScreenOpened("screenHangerGiftKeys"))
         {
            screensM.removeScreen("screenHangerGiftKeys");
         }
      }
   }
}

