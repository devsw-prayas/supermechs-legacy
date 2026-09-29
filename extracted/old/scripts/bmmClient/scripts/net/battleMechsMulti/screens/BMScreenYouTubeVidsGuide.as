package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol723")]
   public class BMScreenYouTubeVidsGuide extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcSizer_email:Sprite;
      
      public var mcSizer_channel:Sprite;
      
      public var mcSizer_channel2:Sprite;
      
      public var mcSizer_btnBack:Sprite;
      
      public var btnBack:BMButton_pictureE;
      
      public var txtDescription:TextField;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenYouTubeVidsGuide()
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
         if(this._firstRefresh)
         {
            screensM.createButtonFromSizer("screenYouTubeVidsGuide","btnBack","pictureE");
            _loc1_ = this.backClicked;
            if(dataM.runAsMobile)
            {
               _loc1_ = null;
            }
            this.btnBack.initialize("","",externalAssetsM.getAsset("general","interface_cancel"),null,_loc1_,dataM.runAsMobile);
            this.btnBack.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
            setLanguageManagerScreenName("youTubeVidsGuide");
            this.txtDescription.htmlText = getScreenText("description");
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("youTubeVidsGuide_desc",[this.txtDescription],"",this);
            }
            else
            {
               this.mcSizer_email.buttonMode = true;
               this.mcSizer_email.useHandCursor = true;
               this.mcSizer_channel.buttonMode = true;
               this.mcSizer_channel.useHandCursor = true;
               this.mcSizer_channel2.buttonMode = true;
               this.mcSizer_channel2.useHandCursor = true;
            }
            this._firstRefresh = false;
         }
         else if(lastLanguageID != dataM.languageID)
         {
            lastLanguageID = dataM.languageID;
            this.languageUpdate();
         }
         if(dataM.runAsMobile == false)
         {
            this.mcSizer_email.addEventListener(MouseEvent.CLICK,this.emailClicked);
            this.mcSizer_channel.addEventListener(MouseEvent.CLICK,this.channelClicked);
            this.mcSizer_channel2.addEventListener(MouseEvent.CLICK,this.channelClicked);
         }
      }
      
      private function languageUpdate(param1:Boolean = false) : void
      {
         this.txtDescription.htmlText = getScreenText("description");
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("youTubeVidsGuide_desc",[this.txtDescription],"",this);
         }
      }
      
      private function emailClicked(param1:MouseEvent) : void
      {
         this.emailClickedSub();
      }
      
      public function emailClickedSub() : void
      {
         dataM.emailSuperMechs();
      }
      
      private function channelClicked(param1:MouseEvent) : void
      {
         this.channelClickedSub();
      }
      
      public function channelClickedSub() : void
      {
         dataM.openURL("https://www.youtube.com/channel/UCpB4nxzR8cEUQSGFG_lLIKA","_blank");
         dataM.trackScreenView("communityYouTube");
      }
      
      public function backClicked() : void
      {
         this.removeMe();
      }
      
      public function removeMe() : void
      {
         screensM.removeScreen("screenYouTubeVidsGuide");
         if(dataM.runAsMobile)
         {
            this.mcSizer_email.removeEventListener(MouseEvent.CLICK,this.emailClicked);
            this.mcSizer_channel.removeEventListener(MouseEvent.CLICK,this.channelClicked);
            this.mcSizer_channel2.removeEventListener(MouseEvent.CLICK,this.channelClicked);
         }
      }
   }
}

