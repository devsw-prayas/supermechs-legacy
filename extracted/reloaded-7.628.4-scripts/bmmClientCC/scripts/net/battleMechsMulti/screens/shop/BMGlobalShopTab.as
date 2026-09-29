package net.battleMechsMulti.screens.shop
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.battleMechsMulti.mobiles.BMMovieClip;
   import net.battleMechsMulti.screens.mainMenu.TextHolder;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1502")]
   public class BMGlobalShopTab extends BMMovieClip
   {
      
      public var mcSelected:MovieClip;
      
      public var mcUnselected:MovieClip;
      
      public var mcCounter:TextHolder;
      
      public var mcCounterWide:TextHolder;
      
      public var mcMinedTokensIndicator:Sprite;
      
      public var mcHitArea:Sprite;
      
      public var id:int;
      
      private var _hitAreaOriginWidth:Number;
      
      private var _counterOriginXPos:Number;
      
      private var _counterWideOriginXPos:Number;
      
      private var _selected:Boolean = false;
      
      public function BMGlobalShopTab()
      {
         super();
         this.mcCounter.visible = false;
         if(this.mcCounterWide != null)
         {
            this.mcCounterWide.visible = false;
         }
         if(this.mcHitArea != null)
         {
            this._hitAreaOriginWidth = this.mcHitArea.width;
            this._counterOriginXPos = this.mcCounter.x;
            if(this.mcCounterWide != null)
            {
               this._counterWideOriginXPos = this.mcCounterWide.x;
            }
         }
      }
      
      public function set title(param1:String) : void
      {
         updateTextAndFormat(this.mcSelected.txtTitle,param1);
         if(this.mcUnselected.txtTitle != null)
         {
            updateTextAndFormat(this.mcUnselected.txtTitle,param1);
         }
         if(this.mcSelected.txtTitle.numLines > 1)
         {
            this.mcSelected.txtTitle.y -= 12;
            if(this.mcUnselected.txtTitle != null)
            {
               this.mcUnselected.txtTitle.y -= 12;
            }
         }
         ImageUtils.swapTextFieldWithBitMap(this.mcSelected.txtTitle,this.mcSelected);
         if(this.mcUnselected.txtTitle != null)
         {
            ImageUtils.swapTextFieldWithBitMap(this.mcUnselected.txtTitle,this.mcUnselected);
         }
      }
      
      public function setIcon(param1:Sprite) : void
      {
         param1.width = this.mcSelected.mcIconSizer.width;
         param1.height = this.mcSelected.mcIconSizer.height;
         param1.x = this.mcSelected.mcIconSizer.x + this.mcSelected.x;
         param1.y = this.mcSelected.mcIconSizer.y + this.mcSelected.y;
         addChild(param1);
         this.reAddHitArea();
      }
      
      private function reAddHitArea() : void
      {
         if(this.mcHitArea != null)
         {
            this.mcHitArea.parent.removeChild(this.mcHitArea);
            addChild(this.mcHitArea);
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
         if(this._selected)
         {
            this.mcSelected.visible = true;
            if(this.mcHitArea != null)
            {
               this.mcHitArea.width = this._hitAreaOriginWidth;
               this.mcCounter.x = this._counterOriginXPos;
               if(this.mcCounterWide != null)
               {
                  this.mcCounterWide.x = this._counterWideOriginXPos;
               }
            }
         }
         else
         {
            this.mcSelected.visible = false;
            if(this.mcHitArea != null)
            {
               this.mcHitArea.width = 85;
               this.mcCounter.x = 65;
               if(this.mcCounterWide != null)
               {
                  this.mcCounterWide.x = 56;
               }
            }
         }
         this.reAddHitArea();
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set counter(param1:int) : void
      {
         this.mcCounter.visible = false;
         if(this.mcCounterWide != null)
         {
            this.mcCounterWide.visible = false;
         }
         if(param1 <= 0)
         {
            return;
         }
         if(param1 > 99 && this.mcCounterWide != null)
         {
            this.mcCounterWide.visible = true;
            this.mcCounterWide.text = param1.toString();
         }
         else
         {
            this.mcCounter.visible = true;
            this.mcCounter.text = param1.toString();
         }
      }
      
      public function set minedTokensIndicator(param1:Boolean) : void
      {
         this.mcMinedTokensIndicator.visible = param1;
      }
   }
}

