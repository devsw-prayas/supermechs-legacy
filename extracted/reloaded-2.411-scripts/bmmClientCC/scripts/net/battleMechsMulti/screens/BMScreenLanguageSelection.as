package net.battleMechsMulti.screens
{
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.buttons.BMButton_pictureE;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol802")]
   public class BMScreenLanguageSelection extends BMBaseScreen
   {
      
      public var mcButtonsHolder:Sprite;
      
      public var mcButtonMarker:Sprite;
      
      public var mcSizer_btnLang1:Sprite;
      
      public var mcSizer_btnLang3:Sprite;
      
      public var mcSizer_btnLang4:Sprite;
      
      public var mcSizer_btnLang5:Sprite;
      
      public var mcSizer_btnLang7:Sprite;
      
      public var mcSizer_btnLang9:Sprite;
      
      public var mcSizer_btnLang10:Sprite;
      
      public var mcSizer_btnLang20:Sprite;
      
      public var btnLang1:BMButton_pictureE;
      
      public var btnLang3:BMButton_pictureE;
      
      public var btnLang4:BMButton_pictureE;
      
      public var btnLang5:BMButton_pictureE;
      
      public var btnLang7:BMButton_pictureE;
      
      public var btnLang9:BMButton_pictureE;
      
      public var btnLang10:BMButton_pictureE;
      
      public var btnLang20:BMButton_pictureE;
      
      private var _returnFunction:Function;
      
      public function BMScreenLanguageSelection()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen(param1:Function = null) : void
      {
         this._returnFunction = param1;
         screensM.createButtonFromSizer("screenLanguageSelection","btnLang1","pictureE");
         screensM.createButtonFromSizer("screenLanguageSelection","btnLang3","pictureE");
         screensM.createButtonFromSizer("screenLanguageSelection","btnLang4","pictureE");
         screensM.createButtonFromSizer("screenLanguageSelection","btnLang5","pictureE");
         screensM.createButtonFromSizer("screenLanguageSelection","btnLang7","pictureE");
         screensM.createButtonFromSizer("screenLanguageSelection","btnLang9","pictureE");
         screensM.createButtonFromSizer("screenLanguageSelection","btnLang10","pictureE");
         screensM.createButtonFromSizer("screenLanguageSelection","btnLang20","pictureE");
         var _loc2_:Function = this.languageClicked;
         if(dataM.runAsMobile)
         {
            _loc2_ = null;
         }
         this.btnLang1.initialize("","",dataM.getLanguageIcon(1),[1],_loc2_,dataM.runAsMobile);
         this.btnLang3.initialize("","",dataM.getLanguageIcon(3),[3],_loc2_,dataM.runAsMobile);
         this.btnLang4.initialize("","",dataM.getLanguageIcon(4),[4],_loc2_,dataM.runAsMobile);
         this.btnLang5.initialize("","",dataM.getLanguageIcon(5),[5],_loc2_,dataM.runAsMobile);
         this.btnLang7.initialize("","",dataM.getLanguageIcon(7),[7],_loc2_,dataM.runAsMobile);
         this.btnLang9.initialize("","",dataM.getLanguageIcon(9),[9],_loc2_,dataM.runAsMobile);
         this.btnLang10.initialize("","",dataM.getLanguageIcon(10),[10],_loc2_,dataM.runAsMobile);
         this.btnLang20.initialize("","",dataM.getLanguageIcon(20),[20],_loc2_,dataM.runAsMobile);
         this.btnLang1.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnLang3.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnLang4.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnLang5.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnLang7.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnLang9.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnLang10.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.btnLang20.activateSoundFunctions(screensM.sound_buttonClicked,screensM.sound_buttonRollover);
         this.mcButtonMarker.x = this["btnLang" + dataM.languageID].x;
         this.mcButtonMarker.y = this["btnLang" + dataM.languageID].y;
         this.btnLang20.visible = false;
         if(dataM.clientRunningLocally)
         {
            this.btnLang20.visible = true;
         }
      }
      
      public function languageClicked(param1:uint) : void
      {
         dataM.setLanguageID(param1);
         if(this._returnFunction != null)
         {
            this._returnFunction();
         }
         screensM.removeScreen("screenLanguageSelection");
      }
   }
}

