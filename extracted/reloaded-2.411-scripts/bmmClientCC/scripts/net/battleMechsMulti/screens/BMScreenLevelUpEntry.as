package net.battleMechsMulti.screens
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.battleMechsMulti.helpers.BMGameShortcutsHelper;
   import net.battleMechsMulti.utils.TextUtils;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol985")]
   public class BMScreenLevelUpEntry extends BMBaseScreen
   {
      
      public var mcFrame1:MovieClip;
      
      public var mcFrame2:MovieClip;
      
      public var txtLevelUp:TextField;
      
      private var _animationPhase:String;
      
      private var _frameCounter:uint;
      
      private var _levelUpOriginYPos:Number;
      
      private var _levelUpFrameOriginYPos:Number;
      
      private var _firstRefresh:Boolean = true;
      
      public function BMScreenLevelUpEntry()
      {
         super();
      }
      
      public function initialize() : void
      {
         generateSingletonClassesPointers("");
      }
      
      public function refreshScreen(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         if(this._firstRefresh)
         {
            setLanguageManagerScreenName("levelUpEntry");
            this._levelUpOriginYPos = this.txtLevelUp.y;
            this._levelUpFrameOriginYPos = this.mcFrame1.txtLevelUp.y;
            this._firstRefresh = false;
         }
         if(param1)
         {
            this._animationPhase = "frame1_in";
            this.mcFrame1.y = -100;
            _loc2_ = 30;
            _loc3_ = 0;
            switch(dataM.languageID)
            {
               case 7:
                  _loc2_ = 23;
                  _loc3_ = 3;
            }
            this.mcFrame1.txtLevelUp.y = this._levelUpFrameOriginYPos + _loc3_;
            TextUtils.updateTextFormat(this.mcFrame1.txtLevelUp,_loc2_);
            this.txtLevelUp.y = this._levelUpOriginYPos + _loc3_;
            TextUtils.updateTextFormat(this.txtLevelUp,_loc2_);
            this.mcFrame1.txtLevelUp.text = getScreenText("levelUp");
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("levelUpEntry_frame1",[this.mcFrame1.txtLevelUp],"",this.mcFrame1);
            }
            this.mcFrame2.mcFrame1.visible = true;
            this.mcFrame2.mcFrame2.visible = false;
            this.mcFrame2.mcFrame3.visible = false;
            this.mcFrame2.mcFrame4.visible = false;
            this.mcFrame2.mcFrame5.visible = false;
            this.mcFrame2.mcFrame6.visible = false;
            this.mcFrame2.mcFrame7.visible = false;
            this.mcFrame2.mcFrame8.visible = false;
            this.mcFrame2.mcFrame9.visible = false;
            this.mcFrame2.mcFrame10.visible = false;
            this.mcFrame2.visible = false;
            this.mcFrame1.visible = true;
         }
         else
         {
            this._animationPhase = "frame2_out";
            this.mcFrame2.mcFrame1.visible = false;
            this.mcFrame2.mcFrame2.visible = false;
            this.mcFrame2.mcFrame3.visible = false;
            this.mcFrame2.mcFrame4.visible = false;
            this.mcFrame2.mcFrame5.visible = false;
            this.mcFrame2.mcFrame6.visible = false;
            this.mcFrame2.mcFrame7.visible = false;
            this.mcFrame2.mcFrame8.visible = false;
            this.mcFrame2.mcFrame9.visible = false;
            this.mcFrame2.mcFrame10.visible = true;
            this.mcFrame2.visible = true;
            this.mcFrame1.visible = false;
            this.mcFrame1.y = 240;
            this.mcFrame1.txtLevelUp.text = "";
            if(dataM.runAsMobile)
            {
               screensM.createMultipleTextsBitmap("levelUpEntry_frame1",[this.mcFrame1.txtLevelUp],"",this.mcFrame1);
            }
            this._frameCounter = 0;
         }
         this.txtLevelUp.text = "";
         if(dataM.runAsMobile)
         {
            screensM.createMultipleTextsBitmap("levelUpEntry_texts",[this.txtLevelUp],"",this);
         }
         if(BMGameShortcutsHelper.levelUpShortcut())
         {
            if(param1)
            {
               screensM.removeScreen("screenLevelUpEntry");
               screensM.addScreen("screenLevelUp");
               screensM.screenLevelUp.refreshScreen();
            }
            else
            {
               screensM.removeScreen("screenLevelUpEntry");
            }
         }
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(parent != null)
         {
            switch(this._animationPhase)
            {
               case "frame1_in":
                  if(this.mcFrame1.y < 240)
                  {
                     this.mcFrame1.y += (240 - this.mcFrame1.y) * 0.3;
                     if(this.mcFrame1.y > 238)
                     {
                        this.mcFrame1.y = 240;
                        this.txtLevelUp.text = getScreenText("levelUp");
                        if(dataM.runAsMobile)
                        {
                           screensM.createMultipleTextsBitmap("levelUpEntry_texts",[this.txtLevelUp],"",this);
                        }
                        this._animationPhase = "frame2_in";
                        this.mcFrame1.visible = false;
                        this.mcFrame2.visible = true;
                        this._frameCounter = 0;
                     }
                  }
                  break;
               case "frame2_in":
                  ++this._frameCounter;
                  switch(this._frameCounter)
                  {
                     case 2:
                        this.mcFrame2.mcFrame1.visible = false;
                        this.mcFrame2.mcFrame2.visible = true;
                        break;
                     case 3:
                        this.mcFrame2.mcFrame2.visible = false;
                        this.mcFrame2.mcFrame3.visible = true;
                        break;
                     case 4:
                        this.mcFrame2.mcFrame3.visible = false;
                        this.mcFrame2.mcFrame4.visible = true;
                        break;
                     case 5:
                        this.mcFrame2.mcFrame4.visible = false;
                        this.mcFrame2.mcFrame5.visible = true;
                        break;
                     case 6:
                        this.mcFrame2.mcFrame5.visible = false;
                        this.mcFrame2.mcFrame6.visible = true;
                        break;
                     case 7:
                        this.mcFrame2.mcFrame6.visible = false;
                        this.mcFrame2.mcFrame7.visible = true;
                        break;
                     case 8:
                        this.mcFrame2.mcFrame7.visible = false;
                        this.mcFrame2.mcFrame8.visible = true;
                        break;
                     case 9:
                        this.mcFrame2.mcFrame8.visible = false;
                        this.mcFrame2.mcFrame9.visible = true;
                        break;
                     case 10:
                        this.mcFrame2.mcFrame9.visible = false;
                        this.mcFrame2.mcFrame10.visible = true;
                  }
                  if(this._frameCounter == 22)
                  {
                     screensM.removeScreen("screenLevelUpEntry");
                     screensM.addScreen("screenLevelUp");
                     screensM.screenLevelUp.refreshScreen();
                  }
                  break;
               case "frame2_out":
                  ++this._frameCounter;
                  switch(this._frameCounter)
                  {
                     case 1:
                        this.mcFrame2.mcFrame10.visible = false;
                        this.mcFrame2.mcFrame9.visible = true;
                        break;
                     case 2:
                        this.mcFrame2.mcFrame9.visible = false;
                        this.mcFrame2.mcFrame8.visible = true;
                        break;
                     case 3:
                        this.mcFrame2.mcFrame8.visible = false;
                        this.mcFrame2.mcFrame7.visible = true;
                        break;
                     case 4:
                        this.mcFrame2.mcFrame7.visible = false;
                        this.mcFrame2.mcFrame6.visible = true;
                        break;
                     case 5:
                        this.mcFrame2.mcFrame6.visible = false;
                        this.mcFrame2.mcFrame5.visible = true;
                        break;
                     case 6:
                        this.mcFrame2.mcFrame5.visible = false;
                        this.mcFrame2.mcFrame4.visible = true;
                        break;
                     case 7:
                        this.mcFrame2.mcFrame4.visible = false;
                        this.mcFrame2.mcFrame3.visible = true;
                        break;
                     case 8:
                        this.mcFrame2.mcFrame3.visible = false;
                        this.mcFrame2.mcFrame2.visible = true;
                        break;
                     case 9:
                        this.mcFrame2.mcFrame2.visible = false;
                        this.mcFrame2.mcFrame1.visible = true;
                        break;
                     case 10:
                        this.mcFrame1.visible = true;
                        this.mcFrame2.visible = false;
                        break;
                     case 12:
                        this._animationPhase = "frame1_out";
                  }
                  break;
               case "frame1_out":
                  if(this.mcFrame1.y > -100)
                  {
                     this.mcFrame1.y -= (this.mcFrame1.y - -110) * 0.3;
                  }
                  else
                  {
                     screensM.removeScreen("screenLevelUpEntry");
                  }
            }
         }
      }
   }
}

