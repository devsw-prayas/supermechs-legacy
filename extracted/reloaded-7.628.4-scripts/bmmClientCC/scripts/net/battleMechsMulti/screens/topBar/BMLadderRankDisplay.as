package net.battleMechsMulti.screens.topBar
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import net.battleMechsMulti.managers.BMDataManager;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   import net.battleMechsMulti.mobiles.BMPlayerProfile;
   import net.battleMechsMulti.utils.TextUtils;
   
   public class BMLadderRankDisplay extends BMBaseClass
   {
      
      public var mcStarsStripe:MovieClip;
      
      public var mcSizer_rank:Sprite;
      
      public var mcTooltip_rank:Sprite;
      
      public var mcRankIconHolder:Sprite;
      
      public var mcRankingListPositionAddon:Sprite;
      
      public var txtRank:TextField;
      
      private var _showRankStars:Boolean = false;
      
      private var _showRankStarsCounter:Number = 0;
      
      private var _starsStripeTargetYPos:Number;
      
      private var _rankStars:Array = new Array();
      
      private var mcRankIcon:Sprite;
      
      private const STARS_STRIPE_ORIGIN_Y_POS:Number = -20;
      
      public function BMLadderRankDisplay()
      {
         super();
         generateSingletonClassesPointers();
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         this.mcTooltip_rank.addEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
         this.mcTooltip_rank.addEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
         this.mcTooltip_rank.addEventListener(MouseEvent.RELEASE_OUTSIDE,this.tooltipMouseOut);
         this.mcTooltip_rank.addEventListener(MouseEvent.MOUSE_UP,this.tooltipMouseOut);
         this.mcStarsStripe.y = this.STARS_STRIPE_ORIGIN_Y_POS;
      }
      
      public function onEnterFrameTrigger() : void
      {
         this.starsStripeAnimationHandler();
      }
      
      private function starsStripeAnimationHandler() : void
      {
         var _loc1_:Number = NaN;
         if(this.mcStarsStripe == null)
         {
            return;
         }
         if(this._showRankStars || this._showRankStarsCounter > 0)
         {
            if(this.mcStarsStripe.y < this._starsStripeTargetYPos - 1)
            {
               _loc1_ = this._starsStripeTargetYPos - this.mcStarsStripe.y;
               this.mcStarsStripe.y += _loc1_ * 0.3;
               if(this.mcStarsStripe.y > this._starsStripeTargetYPos - 1)
               {
                  this.mcStarsStripe.y = this._starsStripeTargetYPos;
               }
            }
            if(this._showRankStarsCounter > 0)
            {
               --this._showRankStarsCounter;
            }
         }
         else if(this.mcStarsStripe.y > this.STARS_STRIPE_ORIGIN_Y_POS + 1)
         {
            this.mcStarsStripe.y -= (this.mcStarsStripe.y + Math.abs(this.STARS_STRIPE_ORIGIN_Y_POS)) * 0.3;
            if(this.mcStarsStripe.y < this.STARS_STRIPE_ORIGIN_Y_POS + 1)
            {
               this.mcStarsStripe.y = this.STARS_STRIPE_ORIGIN_Y_POS;
               this.removeRankStars();
            }
         }
      }
      
      public function showRankStars(param1:Boolean = false) : void
      {
         if(this.mcStarsStripe == null)
         {
            return;
         }
         if(dataM.gameType != BMDataManager.GAME_TYPE_TUTORIAL)
         {
            this.createRankStars();
            if(param1)
            {
               this._showRankStarsCounter = 70;
               this.mcStarsStripe.y = this._starsStripeTargetYPos;
            }
            else
            {
               this._showRankStars = true;
               if(this._showRankStarsCounter > 0)
               {
                  this._showRankStarsCounter = 0;
               }
               else
               {
                  this.mcStarsStripe.y = this.STARS_STRIPE_ORIGIN_Y_POS;
               }
            }
         }
      }
      
      private function createRankStars() : void
      {
         var _loc8_:uint = 0;
         var _loc9_:Sprite = null;
         var _loc10_:Sprite = null;
         if(this.mcStarsStripe == null)
         {
            return;
         }
         this.removeRankStars();
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         var _loc2_:uint = dataM.getLadderRankByProgress(_loc1_.ladderProgress);
         var _loc3_:uint = dataM.getLadderProgressBaseByRank(_loc2_);
         var _loc4_:uint = dataM.getLadderProgressMaxByRank(_loc2_);
         var _loc5_:Number = _loc1_.ladderProgress - _loc3_;
         var _loc6_:Number = _loc4_ - _loc1_.ladderProgress;
         var _loc7_:uint = 0;
         if(_loc5_ > 0)
         {
            _loc8_ = 1;
            while(_loc8_ <= _loc5_)
            {
               _loc9_ = new mcStarFull();
               _loc9_.scaleX = 0.66;
               _loc9_.scaleY = 0.66;
               _loc9_.y = -_loc7_ * 43;
               this.mcStarsStripe.addChild(_loc9_);
               this._rankStars.push(_loc9_);
               _loc7_++;
               _loc8_++;
            }
         }
         if(_loc6_ > 0)
         {
            _loc8_ = 1;
            while(_loc8_ <= _loc6_)
            {
               _loc10_ = new mcStarEmpty();
               _loc10_.scaleX = 0.58;
               _loc10_.scaleY = 0.58;
               _loc10_.y = -_loc7_ * 43;
               this.mcStarsStripe.addChild(_loc10_);
               this._rankStars.push(_loc10_);
               _loc7_++;
               _loc8_++;
            }
         }
         this._starsStripeTargetYPos = _loc7_ * 43 + 25;
      }
      
      private function removeRankStars() : void
      {
         var _loc1_:uint = 0;
         if(this.mcStarsStripe == null)
         {
            return;
         }
         if(this._rankStars != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this._rankStars.length)
            {
               this._rankStars[_loc1_].parent.removeChild(this._rankStars[_loc1_]);
               this._rankStars[_loc1_] = null;
               _loc1_++;
            }
         }
         this._rankStars = new Array();
      }
      
      public function addRank() : void
      {
         var _loc3_:String = null;
         var _loc1_:BMPlayerProfile = dataM["player" + dataM.player1PlayerID + "Profile"];
         if(this.mcRankIcon != null)
         {
            this.mcRankIcon.parent.removeChild(this.mcRankIcon);
         }
         var _loc2_:uint = dataM.getLadderRankByProgress(_loc1_.ladderProgress);
         _loc2_ = Math.max(_loc2_,1);
         if(dataM.showRankingListPosition() && _loc1_.rankingListPosition > 0)
         {
            _loc3_ = "#" + TextUtils.getNumberWithComma(_loc1_.rankingListPosition);
            if(this.txtRank != null)
            {
               this.txtRank.y += 13;
               this.txtRank.x -= 2;
            }
         }
         else
         {
            _loc3_ = String(_loc2_);
            if(this.mcRankingListPositionAddon != null)
            {
               this.mcRankingListPositionAddon.visible = false;
            }
         }
         if(this.txtRank != null)
         {
            updateTextAndFormat(this.txtRank,_loc3_);
         }
         var _loc4_:uint = dataM.getLadderRankIconNumber(_loc2_);
         this.mcRankIcon = externalAssetsM.getAsset("general","Grp_rank" + _loc4_,0,0,false,false);
         this.mcRankIcon.filters = [new GlowFilter(0,1,2,2,3),new DropShadowFilter(3,45,0,1,0,0,0.8)];
         this.mcRankIcon.width = this.mcSizer_rank.width;
         this.mcRankIcon.height = this.mcSizer_rank.height;
         this.mcRankIcon.x = this.mcSizer_rank.x;
         this.mcRankIcon.y = this.mcSizer_rank.y;
         this.mcRankIconHolder.addChild(this.mcRankIcon);
      }
      
      public function showRankInfo() : void
      {
         this.showRankStars();
      }
      
      public function hideRankInfo() : void
      {
         this._showRankStars = false;
      }
      
      private function tooltipMouseOver(param1:MouseEvent) : void
      {
         this.showRankInfo();
         tooltip.showToolTip("regularText",getSpecificText("topBar_rankTooltip"));
      }
      
      private function tooltipMouseOut(param1:MouseEvent) : void
      {
         this._showRankStars = false;
         tooltip.hideToolTip();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.mcTooltip_rank.removeEventListener(MouseEvent.MOUSE_OVER,this.tooltipMouseOver);
         this.mcTooltip_rank.removeEventListener(MouseEvent.MOUSE_OUT,this.tooltipMouseOut);
         this.mcTooltip_rank.removeEventListener(MouseEvent.RELEASE_OUTSIDE,this.tooltipMouseOut);
         this.mcTooltip_rank.removeEventListener(MouseEvent.MOUSE_UP,this.tooltipMouseOut);
         this.removeRankStars();
      }
   }
}

