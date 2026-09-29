package net.battleMechsMulti.screens.ladderSeasonInfo
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.battleMechsMulti.mobiles.BMBaseClass;
   
   public class BMLadderRankDisplayer extends BMBaseClass
   {
      
      public function BMLadderRankDisplayer()
      {
         super();
         generateSingletonClassesPointers();
      }
      
      public function setLadderRank(param1:uint, param2:Sprite, param3:Sprite, param4:Sprite, param5:TextField, param6:MovieClip) : void
      {
         var _loc17_:MovieClip = null;
         var _loc7_:uint = uint(dataM.rankPerLadderProgressList[param1]);
         var _loc8_:uint = uint(dataM.ladderProgressBasePerRank[_loc7_]);
         var _loc9_:uint = uint(dataM.ladderProgressMaxByRank[_loc7_]);
         var _loc10_:uint = _loc9_ - _loc8_;
         var _loc11_:uint = param1 - _loc8_;
         var _loc12_:Array = [0,100,100,150,180,250,275,300,325,350];
         var _loc13_:uint = 1;
         while(_loc13_ <= _loc10_)
         {
            if(_loc13_ <= _loc11_)
            {
               _loc17_ = new mcStarFull();
            }
            else
            {
               _loc17_ = new mcStarEmpty();
            }
            _loc17_.scaleX = 0.8;
            _loc17_.scaleY = 0.8;
            _loc17_.x = (_loc13_ - 1) * _loc12_[_loc10_] / (_loc10_ - 1) - _loc12_[_loc10_] / 2;
            param2.addChild(_loc17_);
            _loc13_++;
         }
         param6.gotoAndStop("stars_" + _loc10_);
         updateTextAndFormat(param5,String(_loc7_));
         var _loc14_:uint = dataM.getLadderRankIconNumber(_loc7_);
         var _loc15_:Number = param4.width;
         var _loc16_:Sprite = externalAssetsM.getAsset("general","Grp_rank" + _loc14_,_loc15_,_loc15_);
         _loc16_.x = param4.x;
         _loc16_.y = param4.y;
         param3.addChild(_loc16_);
      }
   }
}

