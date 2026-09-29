package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMLoginManager;
   import net.battleMechsMulti.mobiles.BMScroller;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1828")]
   public class BMScreenDebugger extends BMBaseScreen
   {
      
      public var txtDebugger:TextField;
      
      public var mcSizer_btnClose:Sprite;
      
      public var mcSizer_scroller:Sprite;
      
      public var mcSizer_btnClear:Sprite;
      
      public var mcSizer_btnLogout:Sprite;
      
      public var mcSizer_btnRemoveDebugger:Sprite;
      
      public var mcButtonsHolder:Sprite;
      
      public var btnClose:BMButton_pictureE;
      
      public var btnClear:BMButton_pictureE;
      
      public var btnLogout:BMButton_pictureE;
      
      public var btnRemoveDebugger:BMButton_pictureE;
      
      private var scroller:BMScroller;
      
      private var chatLog:Array = new Array();
      
      private var _debuggerText:String;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenDebugger()
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
         var _loc3_:Function = null;
         var _loc4_:Function = null;
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenDebugger","btnClose","pictureE");
            screensM.createButtonFromSizer("screenDebugger","btnClear","pictureE");
            screensM.createButtonFromSizer("screenDebugger","btnLogout","pictureE");
            screensM.createButtonFromSizer("screenDebugger","btnRemoveDebugger","pictureE");
            _loc1_ = this.closeClicked;
            _loc2_ = this.clearClicked;
            _loc3_ = this.logoutClicked;
            _loc4_ = this.removeDebuggerClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
               _loc2_ = null;
               _loc3_ = null;
               _loc4_ = null;
            }
            this.btnClose.initialize("","",externalAssetsM.getAsset("general","interface_back2"),null,_loc1_,dataM.runAsMobile);
            this.btnClear.initialize("","",externalAssetsM.getAsset("general","icon_heat"),null,_loc2_,dataM.runAsMobile);
            this.btnLogout.initialize("","",externalAssetsM.getAsset("general","interface_quit"),null,_loc3_,dataM.runAsMobile);
            this.btnRemoveDebugger.initialize("","",externalAssetsM.getAsset("general","interface_quit"),null,_loc4_,dataM.runAsMobile);
            this._debuggerText = "";
            this.addTrace("DEBUGGER ONLINE : <BR>");
            this._firstRefresh = false;
         }
         this.refreshDebuggerText();
      }
      
      private function scrollerScrolled(param1:Number) : void
      {
         this.txtDebugger.scrollV = Math.ceil(param1 * this.txtDebugger.maxScrollV);
         this.createTextBitmapForMobile();
      }
      
      private function scrollingEnded() : void
      {
      }
      
      private function scrollerButtonUp() : void
      {
         if(this.txtDebugger.scrollV > 1)
         {
            --this.txtDebugger.scrollV;
            this.scroller.setScrollPosition((this.txtDebugger.scrollV - 1) / (this.txtDebugger.maxScrollV - 1));
            this.createTextBitmapForMobile();
         }
      }
      
      private function scrollerButtonDown() : void
      {
         if(this.txtDebugger.scrollV < this.txtDebugger.maxScrollV)
         {
            ++this.txtDebugger.scrollV;
            this.scroller.setScrollPosition((this.txtDebugger.scrollV - 1) / (this.txtDebugger.maxScrollV - 1));
            this.createTextBitmapForMobile();
         }
      }
      
      private function createTextBitmapForMobile() : void
      {
         if(dataM.runAsMobile)
         {
            screensM.createTextBitmap("debugger_text",this.txtDebugger,"",this);
         }
      }
      
      public function closeClicked() : void
      {
         screensM.removeScreen("screenDebugger");
         this.txtDebugger.htmlText = "";
         this.createTextBitmapForMobile();
      }
      
      public function clearClicked() : void
      {
         this._debuggerText = "";
         this.chatLog = new Array();
         this.addTrace("cleared");
      }
      
      public function logoutClicked() : void
      {
         BMLoginManager.gi().generateLogout();
         this.closeClicked();
      }
      
      public function removeDebuggerClicked() : void
      {
         TsLogger.log("!!!!!!!");
         this.closeClicked();
         screensM.btnDebugger.visible = false;
      }
      
      public function addTrace(param1:String) : void
      {
         if(param1.substr(0,9) == "player1HP")
         {
            param1 = "<FONT COLOR=\'#CC0000\'>" + param1 + "</FONT>";
         }
         else if(param1.substr(0,33) == " ! ! ! GETTING : BMM_BATTLE_ERROR")
         {
            param1 = "<FONT COLOR=\'#CC0000\'>" + param1 + "</FONT>";
         }
         else if(param1.substr(0,39) == " ! ! ! GETTING : BMM_BATTLE_TIMER_ENDED")
         {
            param1 = "<FONT COLOR=\'#FF6600\'>" + remoteM.socketM.currentBattleCall + " : " + param1 + "</FONT>";
         }
         else if(param1.substr(0,40) == " ! ! ! GETTING : BMM_BATTLE_TIMER_NOTICE")
         {
            param1 = "<FONT COLOR=\'#FF6600\'>" + param1 + "</FONT>";
         }
         else
         {
            switch(param1.substr(0,14))
            {
               case " > > > CALLING":
                  param1 = "<FONT COLOR=\'#006600\'>" + param1 + "</FONT>";
                  break;
               case " ! ! ! GETTING":
                  if(param1.substr(0,27) == " ! ! ! GETTING : BMM_BATTLE" && param1 != " ! ! ! GETTING : BMM_BATTLE_STARTING_BATTLE")
                  {
                     if(screensM.isScreenOpened("screenBattle"))
                     {
                        if(screensM.screenBattle.currentPlayerID == dataM.player1PlayerID)
                        {
                           param1 = "<FONT COLOR=\'#009900\'>" + remoteM.socketM.currentBattleCall + " :  SLF : " + param1 + "</FONT>";
                        }
                        else
                        {
                           param1 = "<FONT COLOR=\'#0066CC\'>" + remoteM.socketM.currentBattleCall + " :  OPP : " + param1 + "</FONT>";
                        }
                     }
                  }
                  else
                  {
                     param1 = "<FONT COLOR=\'#009900\'>" + param1 + "</FONT>";
                  }
            }
         }
         this.chatLog.push(param1);
         this.refreshDebuggerText();
      }
      
      private function refreshDebuggerText() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:Number = NaN;
         if(parent != null)
         {
            _loc1_ = 0;
            if(dataM.clientRunningLocally)
            {
               if(this.chatLog.length > 150)
               {
                  _loc1_ = this.chatLog.length - 150 - 1;
               }
            }
            else if(this.chatLog.length > 50)
            {
               _loc1_ = this.chatLog.length - 50 - 1;
            }
            this._debuggerText = "";
            _loc2_ = _loc1_;
            while(_loc2_ < this.chatLog.length)
            {
               this._debuggerText = this._debuggerText + "<BR>" + this.chatLog[_loc2_];
               _loc2_++;
            }
            this.txtDebugger.htmlText = this._debuggerText;
            this.txtDebugger.scrollV = this.txtDebugger.maxScrollV;
            if(this.scroller != null)
            {
               this.scroller.removeMe();
               this.scroller = null;
            }
            _loc3_ = new Grp_scrollerContent();
            this.scroller = new BMScroller();
            _loc4_ = 1;
            if(this.txtDebugger.textHeight > this.txtDebugger.height)
            {
               _loc4_ = this.txtDebugger.height / this.txtDebugger.textHeight;
            }
            this.scroller.initialize(GlobalAccess.stage,this.mcSizer_scroller.height,_loc4_,_loc3_,this.scrollerScrolled,this.scrollingEnded,this.scrollerButtonUp,this.scrollerButtonDown,false,dataM.runAsMobile);
            this.scroller.x = this.mcSizer_scroller.x;
            this.scroller.y = this.mcSizer_scroller.y;
            addChild(this.scroller);
            if(_loc4_ == 1)
            {
               this.scroller.disableMe();
            }
            this.createTextBitmapForMobile();
         }
      }
   }
}

