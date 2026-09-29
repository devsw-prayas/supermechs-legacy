package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.buttons.BMButton;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1096")]
   public class BMScreenSelectBattleMechsPerPlayer extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var mcSizer_btn1V1:Sprite;
      
      public var mcSizer_btn2V2:Sprite;
      
      public var mcSizer_btn3V3:Sprite;
      
      public var btn1V1:BMButton;
      
      public var btn2V2:BMButton;
      
      public var btn3V3:BMButton;
      
      private var _firstRefresh:Boolean = true;
      
      private var _buttonsEnabled:Boolean;
      
      private var _battleType:String;
      
      private var _mechsPerPlayer:uint;
      
      public function BMScreenSelectBattleMechsPerPlayer()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen(param1:uint, param2:String = "ladder") : void
      {
         var _loc3_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenSelectBattleMechsPerPlayer","btn1V1","regular");
            screensM.createButtonFromSizer("screenSelectBattleMechsPerPlayer","btn2V2","regular");
            screensM.createButtonFromSizer("screenSelectBattleMechsPerPlayer","btn3V3","regular");
            _loc3_ = this.battleClicked;
            if(dataM.runAsMobile)
            {
               _loc3_ = null;
            }
            this.btn1V1.initialize("1 VS 1","green",null,[1],_loc3_,dataM.runAsMobile);
            this.btn2V2.initialize("2 VS 2","green",null,[2],_loc3_,dataM.runAsMobile);
            this.btn3V3.initialize("3 VS 3","green",null,[3],_loc3_,dataM.runAsMobile);
            this.btn1V1.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btn2V2.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this.btn3V3.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            this._firstRefresh = false;
         }
         this._battleType = param2;
         this._mechsPerPlayer = param1;
         if(this._mechsPerPlayer == 3)
         {
            this.mcBackground.gotoAndPlay("open3V3");
         }
         else
         {
            this.mcBackground.gotoAndPlay("open2V2");
         }
         this.btn1V1.visible = false;
         this.btn2V2.visible = false;
         this.btn3V3.visible = false;
         this.btn1V1.enableMe();
         this.btn2V2.enableMe();
         this.btn3V3.enableMe();
         this._buttonsEnabled = false;
      }
      
      public function getBattleType() : String
      {
         return this._battleType;
      }
      
      public function battleClicked(param1:uint) : void
      {
         switch(this._battleType)
         {
            case "ladder":
               screensM.screenMultiPlayerLadder.battleMechsPerPlayerSelected(param1);
               break;
            case "battleInvitation":
               screensM.screenMenuMultiPlayerInspect.battleMechsPerPlayerSelected(param1);
         }
         if(this._mechsPerPlayer == 3)
         {
            this.mcBackground.gotoAndPlay("close3V3");
         }
         else
         {
            this.mcBackground.gotoAndPlay("close2V2");
         }
         this._buttonsEnabled = false;
         this.btn1V1.disableMe();
         this.btn2V2.disableMe();
         this.btn3V3.disableMe();
      }
      
      public function backgroundOpened2V2() : void
      {
         if(parent != null)
         {
            this.btn1V1.visible = true;
            this.btn2V2.visible = true;
            this._buttonsEnabled = true;
         }
      }
      
      public function backgroundOpened3V3() : void
      {
         if(parent != null)
         {
            this.btn1V1.visible = true;
            this.btn2V2.visible = true;
            this.btn3V3.visible = true;
            this._buttonsEnabled = true;
         }
      }
      
      public function closeScreen() : void
      {
         if(this._mechsPerPlayer == 3)
         {
            this.mcBackground.gotoAndPlay("close3V3");
         }
         else
         {
            this.mcBackground.gotoAndPlay("close2V2");
         }
         this._buttonsEnabled = false;
      }
      
      public function backgroundClosed() : void
      {
         if(parent != null)
         {
            this.removeMe();
         }
         this.mcBackground.gotoAndStop("animOff");
      }
      
      public function showButton1() : void
      {
         this.btn1V1.visible = true;
      }
      
      public function showButton2() : void
      {
         this.btn2V2.visible = true;
      }
      
      public function hideButton3() : void
      {
         this.btn3V3.visible = false;
      }
      
      public function hideButton2() : void
      {
         this.btn2V2.visible = false;
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen("screenSelectBattleMechsPerPlayer");
      }
   }
}

