package net.battleMechsMulti.mobiles.worldMap
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMMechView;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1116")]
   public class BMWorldMapBossDialog extends MovieClip
   {
      
      public var txtDialog:TextField;
      
      public var mcMechHolder:Sprite;
      
      public var mcBackground:MovieClip;
      
      public var mcLili:Sprite;
      
      private var mechView:BMMechView;
      
      private var _textOriginYPos:Number;
      
      private var _updateTextAndFormat:Function;
      
      public function BMWorldMapBossDialog()
      {
         super();
         this._textOriginYPos = this.txtDialog.y;
      }
      
      public function showMech(param1:BMMechView, param2:Function, param3:Number = 0, param4:Number = 0) : void
      {
         this._updateTextAndFormat = param2;
         if(param1 == null)
         {
            this.mcLili.visible = true;
            return;
         }
         this.mcLili.visible = false;
         this.mechView = param1;
         this.mechView.activateBreathing();
         if(this.mechView.scaleX > 0)
         {
            this.mechView.scaleX *= -1;
         }
         this.mechView.x = param3;
         this.mcMechHolder.addChild(this.mechView);
      }
      
      public function onEnterFrameTrigger() : void
      {
         if(this.mechView != null)
         {
            this.mechView.onEnterFrameTrigger();
         }
      }
      
      public function showDialog(param1:String) : void
      {
         this._updateTextAndFormat(this.txtDialog,param1);
         var _loc2_:String = "red";
         if(this.mcLili.visible)
         {
            _loc2_ = "blue";
         }
         var _loc3_:uint = 1;
         if(this.txtDialog.numLines == 1)
         {
            this.txtDialog.y = this._textOriginYPos + 18;
         }
         else if(this.txtDialog.numLines == 2)
         {
            this.txtDialog.y = this._textOriginYPos;
         }
         else if(this.txtDialog.numLines == 3)
         {
            _loc3_ = 2;
            this.txtDialog.y = this._textOriginYPos - 30;
         }
         else if(this.txtDialog.numLines == 4)
         {
            _loc3_ = 3;
            this.txtDialog.y = this._textOriginYPos - 60;
         }
         else if(this.txtDialog.numLines == 5)
         {
            _loc3_ = 4;
            this.txtDialog.y = this._textOriginYPos - 90;
         }
         else
         {
            _loc3_ = 4;
            this.txtDialog.y = this._textOriginYPos - 90;
         }
         this.mcBackground.gotoAndStop(_loc2_ + _loc3_);
      }
      
      public function removeMe() : void
      {
         if(this.mechView != null)
         {
            this.mechView.removeMe();
            this.mechView = null;
         }
      }
   }
}

