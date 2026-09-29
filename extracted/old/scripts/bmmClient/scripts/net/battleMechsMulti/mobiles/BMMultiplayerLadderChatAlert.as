package net.battleMechsMulti.mobiles
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1850")]
   public class BMMultiplayerLadderChatAlert extends BMBaseClass
   {
      
      public var type:String;
      
      public var playerID:Number;
      
      public var playerName:String;
      
      public var clanID:Number;
      
      public var clanName:String;
      
      public var mechsPerPlayer:uint;
      
      public var animationStatus:String;
      
      public var mcMouseOver:Sprite;
      
      public var mcMouseHitArea:Sprite;
      
      public var currentSlot:uint;
      
      public var targetSlot:uint;
      
      public function BMMultiplayerLadderChatAlert()
      {
         super();
      }
      
      public function initialize(param1:String, param2:Number, param3:String, param4:Number, param5:String, param6:uint, param7:uint) : void
      {
         generateSingletonClassesPointers("");
         setLanguageManagerScreenName("multiplayerChatAlert");
         this.type = param1;
         this.playerID = param2;
         this.playerName = param3;
         this.clanID = param4;
         this.clanName = param5;
         this.mechsPerPlayer = param6;
         this.currentSlot = param7;
         this.targetSlot = param7;
         this.animationStatus = "appear1";
         gotoAndStop(this.type);
         if(!dataM.runAsMobile)
         {
            this.mcMouseHitArea.addEventListener(MouseEvent.MOUSE_OVER,this.mouseHitAreaMouseOver);
            this.mcMouseHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.mouseHitAreaMouseOut);
            this.mcMouseHitArea.addEventListener(MouseEvent.CLICK,this.mouseHitAreaClicked);
         }
         this.mcMouseOver.visible = false;
      }
      
      private function mouseHitAreaClicked(param1:MouseEvent) : void
      {
         this.mouseHitAreaClickedSub();
      }
      
      public function mouseHitAreaClickedSub() : void
      {
         screensM.screenMultiPlayerLadder.chatAlertClicked(this.type,this.playerID,this.clanID,this.mechsPerPlayer);
      }
      
      private function mouseHitAreaMouseOver(param1:MouseEvent) : void
      {
         this.mouseHitAreaMouseOverSub();
      }
      
      public function mouseHitAreaMouseOverSub() : void
      {
         this.mcMouseOver.visible = true;
         var _loc1_:String = "";
         switch(this.type)
         {
            case "message_regular":
            case "message_clan":
               _loc1_ = getScreenText("message_regular");
               _loc1_ = dataM.replaceStringInText(_loc1_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
               _loc1_ = dataM.replaceStringInText(_loc1_,"%NAME%",this.playerName);
               break;
            case "battleInvitation":
               switch(this.mechsPerPlayer)
               {
                  case 1:
                     _loc1_ = getScreenText("battleInvitation1V1");
                     break;
                  case 2:
                     _loc1_ = getScreenText("battleInvitation2V2");
                     break;
                  case 3:
                     _loc1_ = getScreenText("battleInvitation3V3");
               }
               _loc1_ = dataM.replaceStringInText(_loc1_,"%COLOR%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
               _loc1_ = dataM.replaceStringInText(_loc1_,"%NAME%",this.playerName);
               break;
            case "clanInvitation":
               _loc1_ = getScreenText("clanInvitation");
               _loc1_ = dataM.replaceStringInText(_loc1_,"%COLOR1%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
               _loc1_ = dataM.replaceStringInText(_loc1_,"%NAME1%",this.playerName);
               _loc1_ = dataM.replaceStringInText(_loc1_,"%COLOR2%","<FONT COLOR=\'#" + dataM.COLOR_LEGENDARY_ITEM + "\'>");
               _loc1_ = dataM.replaceStringInText(_loc1_,"%NAME2%",this.clanName);
         }
         TsLogger.log("toolTipText:" + _loc1_);
         tooltip.showToolTip("regularText",_loc1_);
      }
      
      private function mouseHitAreaMouseOut(param1:MouseEvent) : void
      {
         this.mcMouseOver.visible = false;
         tooltip.hideToolTip();
      }
      
      public function removeMe() : void
      {
         if(dataM.runAsMobile == false)
         {
            this.mcMouseHitArea.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseHitAreaMouseOver);
            this.mcMouseHitArea.removeEventListener(MouseEvent.MOUSE_OUT,this.mouseHitAreaMouseOut);
            this.mcMouseHitArea.removeEventListener(MouseEvent.CLICK,this.mouseHitAreaClicked);
         }
         this.mcMouseOver.parent.removeChild(this.mcMouseOver);
         this.mcMouseOver = null;
         this.mcMouseHitArea.parent.removeChild(this.mcMouseHitArea);
         this.mcMouseHitArea = null;
      }
   }
}

