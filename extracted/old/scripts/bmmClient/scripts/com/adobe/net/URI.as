package com.adobe.net
{
   public class URI
   {
      
      public static const URImustEscape:String = " %";
      
      public static const URIbaselineEscape:String = URImustEscape + ":?#/@";
      
      public static const URIpathEscape:String = URImustEscape + "?#";
      
      public static const URIqueryEscape:String = URImustEscape + "#";
      
      public static const URIqueryPartEscape:String = URImustEscape + "#&=";
      
      public static const URInonHierEscape:String = URImustEscape + "?#/";
      
      public static const UNKNOWN_SCHEME:String = "unknown";
      
      protected static const URIbaselineExcludedBitmap:URIEncodingBitmap = new URIEncodingBitmap(URIbaselineEscape);
      
      protected static const URIschemeExcludedBitmap:URIEncodingBitmap = URIbaselineExcludedBitmap;
      
      protected static const URIuserpassExcludedBitmap:URIEncodingBitmap = URIbaselineExcludedBitmap;
      
      protected static const URIauthorityExcludedBitmap:URIEncodingBitmap = URIbaselineExcludedBitmap;
      
      protected static const URIportExludedBitmap:URIEncodingBitmap = URIbaselineExcludedBitmap;
      
      protected static const URIpathExcludedBitmap:URIEncodingBitmap = new URIEncodingBitmap(URIpathEscape);
      
      protected static const URIqueryExcludedBitmap:URIEncodingBitmap = new URIEncodingBitmap(URIqueryEscape);
      
      protected static const URIqueryPartExcludedBitmap:URIEncodingBitmap = new URIEncodingBitmap(URIqueryPartEscape);
      
      protected static const URIfragmentExcludedBitmap:URIEncodingBitmap = URIqueryExcludedBitmap;
      
      protected static const URInonHierexcludedBitmap:URIEncodingBitmap = new URIEncodingBitmap(URInonHierEscape);
      
      public static const NOT_RELATED:int = 0;
      
      public static const CHILD:int = 1;
      
      public static const EQUAL:int = 2;
      
      public static const PARENT:int = 3;
      
      protected static var _resolver:IURIResolver = null;
      
      protected var _path:String = "";
      
      protected var _relative:Boolean = false;
      
      protected var _fragment:String = "";
      
      protected var _username:String = "";
      
      protected var _nonHierarchical:String = "";
      
      protected var _authority:String = "";
      
      protected var _query:String = "";
      
      protected var _scheme:String = "";
      
      protected var _port:String = "";
      
      protected var _password:String = "";
      
      protected var _valid:Boolean = false;
      
      public function URI(param1:String = null)
      {
         super();
         if(param1 == null)
         {
            initialize();
         }
         else
         {
            constructURI(param1);
         }
      }
      
      public static function get resolver() : IURIResolver
      {
         return _resolver;
      }
      
      protected static function compareStr(param1:String, param2:String, param3:Boolean = true) : Boolean
      {
         if(param3 == false)
         {
            param1 = param1.toLowerCase();
            param2 = param2.toLowerCase();
         }
         return param1 == param2;
      }
      
      public static function set resolver(param1:IURIResolver) : void
      {
         _resolver = param1;
      }
      
      public static function unescapeChars(param1:String) : String
      {
         var _loc2_:String = null;
         return decodeURIComponent(param1);
      }
      
      public static function queryPartEscape(param1:String) : String
      {
         var _loc2_:String = param1;
         return URI.fastEscapeChars(param1,URI.URIqueryPartExcludedBitmap);
      }
      
      public static function escapeChars(param1:String) : String
      {
         return fastEscapeChars(param1,URI.URIbaselineExcludedBitmap);
      }
      
      public static function fastEscapeChars(param1:String, param2:URIEncodingBitmap) : String
      {
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:String = "";
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc4_ = param1.charAt(_loc6_);
            _loc5_ = param2.ShouldEscape(_loc4_);
            if(_loc5_)
            {
               _loc4_ = _loc5_.toString(16);
               if(_loc4_.length == 1)
               {
                  _loc4_ = "0" + _loc4_;
               }
               _loc4_ = "%" + _loc4_;
               _loc4_ = _loc4_.toUpperCase();
            }
            _loc3_ += _loc4_;
            _loc6_++;
         }
         return _loc3_;
      }
      
      public static function queryPartUnescape(param1:String) : String
      {
         var _loc2_:String = param1;
         return unescapeChars(_loc2_);
      }
      
      protected static function resolve(param1:URI) : URI
      {
         var _loc2_:URI = new URI();
         _loc2_.copyURI(param1);
         if(_resolver != null)
         {
            return _resolver.resolve(_loc2_);
         }
         return _loc2_;
      }
      
      public function set queryRaw(param1:String) : void
      {
         _query = param1;
      }
      
      public function get port() : String
      {
         return URI.unescapeChars(_port);
      }
      
      public function set port(param1:String) : void
      {
         _port = URI.escapeChars(param1);
         this.hierState = true;
      }
      
      public function getCommonParent(param1:URI, param2:Boolean = true) : URI
      {
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc3_:URI = URI.resolve(this);
         var _loc4_:URI = URI.resolve(param1);
         if(!_loc3_.isAbsolute() || !_loc4_.isAbsolute() || _loc3_.isHierarchical() == false || _loc4_.isHierarchical() == false)
         {
            return null;
         }
         var _loc5_:int = _loc3_.getRelation(_loc4_);
         if(_loc5_ == URI.NOT_RELATED)
         {
            return null;
         }
         _loc3_.chdir(".");
         _loc4_.chdir(".");
         while(true)
         {
            _loc5_ = _loc3_.getRelation(_loc4_,param2);
            if(_loc5_ == URI.EQUAL || _loc5_ == URI.PARENT)
            {
               break;
            }
            _loc6_ = _loc3_.toString();
            _loc3_.chdir("..");
            _loc7_ = _loc3_.toString();
            if(_loc6_ == _loc7_)
            {
               break;
            }
         }
         return _loc3_;
      }
      
      public function get nonHierarchical() : String
      {
         return URI.unescapeChars(_nonHierarchical);
      }
      
      protected function set hierState(param1:Boolean) : void
      {
         if(param1)
         {
            _nonHierarchical = "";
            if(_scheme == "" || _scheme == UNKNOWN_SCHEME)
            {
               _relative = true;
            }
            else
            {
               _relative = false;
            }
            if(_authority.length == 0 && _path.length == 0)
            {
               _valid = false;
            }
            else
            {
               _valid = true;
            }
         }
         else
         {
            _authority = "";
            _username = "";
            _password = "";
            _port = "";
            _path = "";
            _relative = false;
            if(_scheme == "" || _scheme == UNKNOWN_SCHEME)
            {
               _valid = false;
            }
            else
            {
               _valid = true;
            }
         }
      }
      
      public function setQueryValue(param1:String, param2:String) : void
      {
         var _loc3_:Object = null;
         _loc3_ = getQueryByMap();
         _loc3_[param1] = param2;
         setQueryByMap(_loc3_);
      }
      
      public function getFilename(param1:Boolean = false) : String
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         if(isDirectory())
         {
            return String("");
         }
         var _loc2_:String = this.path;
         _loc4_ = _loc2_.lastIndexOf("/");
         if(_loc4_ != -1)
         {
            _loc3_ = _loc2_.substr(_loc4_ + 1);
         }
         else
         {
            _loc3_ = _loc2_;
         }
         if(param1)
         {
            _loc4_ = _loc3_.lastIndexOf(".");
            if(_loc4_ != -1)
            {
               _loc3_ = _loc3_.substr(0,_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function set authority(param1:String) : void
      {
         param1 = param1.toLowerCase();
         _authority = URI.fastEscapeChars(param1,URI.URIauthorityExcludedBitmap);
         this.hierState = true;
      }
      
      protected function initialize() : void
      {
         _valid = false;
         _relative = false;
         _scheme = UNKNOWN_SCHEME;
         _authority = "";
         _username = "";
         _password = "";
         _port = "";
         _path = "";
         _query = "";
         _fragment = "";
         _nonHierarchical = "";
      }
      
      public function getQueryByMap() : Object
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         var _loc8_:Object = new Object();
         _loc1_ = this._query;
         _loc3_ = _loc1_.split("&");
         for each(_loc2_ in _loc3_)
         {
            if(_loc2_.length != 0)
            {
               _loc4_ = _loc2_.split("=");
               if(_loc4_.length > 0)
               {
                  _loc5_ = _loc4_[0];
                  if(_loc4_.length > 1)
                  {
                     _loc6_ = _loc4_[1];
                  }
                  else
                  {
                     _loc6_ = "";
                  }
                  _loc5_ = queryPartUnescape(_loc5_);
                  _loc6_ = queryPartUnescape(_loc6_);
                  _loc8_[_loc5_] = _loc6_;
               }
            }
         }
         return _loc8_;
      }
      
      protected function constructURI(param1:String) : Boolean
      {
         if(!parseURI(param1))
         {
            _valid = false;
         }
         return isValid();
      }
      
      public function isRelative() : Boolean
      {
         return this._relative;
      }
      
      public function getExtension(param1:Boolean = false) : String
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:String = getFilename();
         if(_loc2_ == "")
         {
            return String("");
         }
         _loc4_ = _loc2_.lastIndexOf(".");
         if(_loc4_ == -1 || _loc4_ == 0)
         {
            return String("");
         }
         _loc3_ = _loc2_.substr(_loc4_);
         if(param1 && _loc3_.charAt(0) == ".")
         {
            _loc3_ = _loc3_.substr(1);
         }
         return _loc3_;
      }
      
      public function get password() : String
      {
         return URI.unescapeChars(_password);
      }
      
      public function setParts(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void
      {
         this.scheme = param1;
         this.authority = param2;
         this.port = param3;
         this.path = param4;
         this.query = param5;
         this.fragment = param6;
         hierState = true;
      }
      
      public function set query(param1:String) : void
      {
         _query = URI.fastEscapeChars(param1,URI.URIqueryExcludedBitmap);
      }
      
      public function set fragment(param1:String) : void
      {
         _fragment = URI.fastEscapeChars(param1,URIfragmentExcludedBitmap);
      }
      
      public function get path() : String
      {
         return URI.unescapeChars(_path);
      }
      
      public function setQueryByMap(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc5_:String = "";
         for(_loc2_ in param1)
         {
            _loc3_ = _loc2_;
            _loc4_ = param1[_loc2_];
            if(_loc4_ == null)
            {
               _loc4_ = "";
            }
            _loc3_ = encodeURIComponent(_loc3_);
            _loc4_ = encodeURIComponent(_loc4_);
            _loc6_ = _loc3_;
            if(_loc4_.length > 0)
            {
               _loc6_ += "=";
               _loc6_ = _loc6_ + _loc4_;
            }
            if(_loc5_.length != 0)
            {
               _loc5_ += "&";
            }
            _loc5_ += _loc6_;
         }
         _query = _loc5_;
      }
      
      public function makeAbsoluteURI(param1:URI) : Boolean
      {
         if(isAbsolute() || param1.isRelative())
         {
            return false;
         }
         var _loc2_:URI = new URI();
         _loc2_.copyURI(param1);
         if(_loc2_.chdir(toString()) == false)
         {
            return false;
         }
         copyURI(_loc2_);
         return true;
      }
      
      public function chdir(param1:String, param2:Boolean = false) : Boolean
      {
         var _loc3_:URI = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc14_:String = null;
         var _loc15_:int = 0;
         var _loc17_:String = null;
         var _loc4_:String = param1;
         if(param2)
         {
            _loc4_ = URI.escapeChars(param1);
         }
         if(_loc4_ == "")
         {
            return true;
         }
         if(_loc4_.substr(0,2) == "//")
         {
            _loc17_ = this.scheme + ":" + _loc4_;
            return constructURI(_loc17_);
         }
         if(_loc4_.charAt(0) == "?")
         {
            _loc4_ = "./" + _loc4_;
         }
         _loc3_ = new URI(_loc4_);
         if(_loc3_.isAbsolute() || _loc3_.isHierarchical() == false)
         {
            copyURI(_loc3_);
            return true;
         }
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         _loc5_ = this.path;
         _loc6_ = _loc3_.path;
         if(_loc5_.length > 0)
         {
            _loc7_ = _loc5_.split("/");
         }
         else
         {
            _loc7_ = new Array();
         }
         if(_loc6_.length > 0)
         {
            _loc8_ = _loc6_.split("/");
         }
         else
         {
            _loc8_ = new Array();
         }
         if(_loc7_.length > 0 && _loc7_[0] == "")
         {
            _loc11_ = true;
            _loc7_.shift();
         }
         if(_loc7_.length > 0 && _loc7_[_loc7_.length - 1] == "")
         {
            _loc9_ = true;
            _loc7_.pop();
         }
         if(_loc8_.length > 0 && _loc8_[0] == "")
         {
            _loc12_ = true;
            _loc8_.shift();
         }
         if(_loc8_.length > 0 && _loc8_[_loc8_.length - 1] == "")
         {
            _loc10_ = true;
            _loc8_.pop();
         }
         if(_loc12_)
         {
            this.path = _loc3_.path;
            this.queryRaw = _loc3_.queryRaw;
            this.fragment = _loc3_.fragment;
            return true;
         }
         if(_loc8_.length == 0 && _loc3_.query == "")
         {
            this.fragment = _loc3_.fragment;
            return true;
         }
         if(_loc9_ == false && _loc7_.length > 0)
         {
            _loc7_.pop();
         }
         this.queryRaw = _loc3_.queryRaw;
         this.fragment = _loc3_.fragment;
         _loc7_ = _loc7_.concat(_loc8_);
         _loc15_ = 0;
         while(_loc15_ < _loc7_.length)
         {
            _loc14_ = _loc7_[_loc15_];
            _loc13_ = false;
            if(_loc14_ == ".")
            {
               _loc7_.splice(_loc15_,1);
               _loc15_--;
               _loc13_ = true;
            }
            else if(_loc14_ == "..")
            {
               if(_loc15_ >= 1)
               {
                  if(_loc7_[_loc15_ - 1] != "..")
                  {
                     _loc7_.splice(_loc15_ - 1,2);
                     _loc15_ -= 2;
                  }
               }
               else if(!isRelative())
               {
                  _loc7_.splice(_loc15_,1);
                  _loc15_--;
               }
               _loc13_ = true;
            }
            _loc15_++;
         }
         var _loc16_:String = "";
         _loc10_ ||= _loc13_;
         _loc16_ = joinPath(_loc7_,_loc11_,_loc10_);
         this.path = _loc16_;
         return true;
      }
      
      public function get scheme() : String
      {
         return URI.unescapeChars(_scheme);
      }
      
      public function makeRelativeURI(param1:URI, param2:Boolean = true) : Boolean
      {
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc13_:int = 0;
         var _loc3_:URI = new URI();
         _loc3_.copyURI(param1);
         var _loc6_:Array = new Array();
         var _loc10_:String = this.path;
         var _loc11_:String = this.queryRaw;
         var _loc12_:String = this.fragment;
         var _loc14_:Boolean = false;
         var _loc15_:Boolean = false;
         if(isRelative())
         {
            return true;
         }
         if(_loc3_.isRelative())
         {
            return false;
         }
         if(isOfType(param1.scheme) == false || this.authority != param1.authority)
         {
            return false;
         }
         _loc15_ = isDirectory();
         _loc3_.chdir(".");
         _loc4_ = _loc10_.split("/");
         _loc5_ = _loc3_.path.split("/");
         if(_loc4_.length > 0 && _loc4_[0] == "")
         {
            _loc4_.shift();
         }
         if(_loc4_.length > 0 && _loc4_[_loc4_.length - 1] == "")
         {
            _loc15_ = true;
            _loc4_.pop();
         }
         if(_loc5_.length > 0 && _loc5_[0] == "")
         {
            _loc5_.shift();
         }
         if(_loc5_.length > 0 && _loc5_[_loc5_.length - 1] == "")
         {
            _loc5_.pop();
         }
         while(_loc5_.length > 0)
         {
            if(_loc4_.length == 0)
            {
               break;
            }
            _loc7_ = _loc4_[0];
            _loc8_ = _loc5_[0];
            if(!compareStr(_loc7_,_loc8_,param2))
            {
               break;
            }
            _loc4_.shift();
            _loc5_.shift();
         }
         var _loc16_:String = "..";
         _loc13_ = 0;
         while(_loc13_ < _loc5_.length)
         {
            _loc6_.push(_loc16_);
            _loc13_++;
         }
         _loc6_ = _loc6_.concat(_loc4_);
         _loc9_ = joinPath(_loc6_,false,_loc15_);
         if(_loc9_.length == 0)
         {
            _loc9_ = "./";
         }
         setParts("","","",_loc9_,_loc11_,_loc12_);
         return true;
      }
      
      public function set password(param1:String) : void
      {
         _password = URI.fastEscapeChars(param1,URI.URIuserpassExcludedBitmap);
         this.hierState = true;
      }
      
      public function toDisplayString() : String
      {
         return toStringInternal(true);
      }
      
      protected function parseURI(param1:String) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:String = param1;
         initialize();
         _loc3_ = _loc2_.indexOf("#");
         if(_loc3_ != -1)
         {
            if(_loc2_.length > _loc3_ + 1)
            {
               _fragment = _loc2_.substr(_loc3_ + 1,_loc2_.length - (_loc3_ + 1));
            }
            _loc2_ = _loc2_.substr(0,_loc3_);
         }
         _loc3_ = _loc2_.indexOf("?");
         if(_loc3_ != -1)
         {
            if(_loc2_.length > _loc3_ + 1)
            {
               _query = _loc2_.substr(_loc3_ + 1,_loc2_.length - (_loc3_ + 1));
            }
            _loc2_ = _loc2_.substr(0,_loc3_);
         }
         _loc3_ = _loc2_.search(":");
         _loc4_ = _loc2_.search("/");
         var _loc5_:Boolean = _loc3_ != -1;
         var _loc6_:Boolean = _loc4_ != -1;
         var _loc7_:Boolean = !_loc6_ || _loc3_ < _loc4_;
         if(_loc5_ && _loc7_)
         {
            _scheme = _loc2_.substr(0,_loc3_);
            _scheme = _scheme.toLowerCase();
            _loc2_ = _loc2_.substr(_loc3_ + 1);
            if(_loc2_.substr(0,2) != "//")
            {
               _nonHierarchical = _loc2_;
               if((_valid = validateURI()) == false)
               {
                  initialize();
               }
               return isValid();
            }
            _nonHierarchical = "";
            _loc2_ = _loc2_.substr(2,_loc2_.length - 2);
         }
         else
         {
            _scheme = "";
            _relative = true;
            _nonHierarchical = "";
         }
         if(isRelative())
         {
            _authority = "";
            _port = "";
            _path = _loc2_;
         }
         else
         {
            if(_loc2_.substr(0,2) == "//")
            {
               while(_loc2_.charAt(0) == "/")
               {
                  _loc2_ = _loc2_.substr(1,_loc2_.length - 1);
               }
            }
            _loc3_ = _loc2_.search("/");
            if(_loc3_ == -1)
            {
               _authority = _loc2_;
               _path = "";
            }
            else
            {
               _authority = _loc2_.substr(0,_loc3_);
               _path = _loc2_.substr(_loc3_,_loc2_.length - _loc3_);
            }
            _loc3_ = _authority.search("@");
            if(_loc3_ != -1)
            {
               _username = _authority.substr(0,_loc3_);
               _authority = _authority.substr(_loc3_ + 1);
               _loc3_ = _username.search(":");
               if(_loc3_ != -1)
               {
                  _password = _username.substring(_loc3_ + 1,_username.length);
                  _username = _username.substr(0,_loc3_);
               }
               else
               {
                  _password = "";
               }
            }
            else
            {
               _username = "";
               _password = "";
            }
            _loc3_ = _authority.search(":");
            if(_loc3_ != -1)
            {
               _port = _authority.substring(_loc3_ + 1,_authority.length);
               _authority = _authority.substr(0,_loc3_);
            }
            else
            {
               _port = "";
            }
            _authority = _authority.toLowerCase();
         }
         if((_valid = validateURI()) == false)
         {
            initialize();
         }
         return isValid();
      }
      
      public function set username(param1:String) : void
      {
         _username = URI.fastEscapeChars(param1,URI.URIuserpassExcludedBitmap);
         this.hierState = true;
      }
      
      public function copyURI(param1:URI) : void
      {
         this._scheme = param1._scheme;
         this._authority = param1._authority;
         this._username = param1._username;
         this._password = param1._password;
         this._port = param1._port;
         this._path = param1._path;
         this._query = param1._query;
         this._fragment = param1._fragment;
         this._nonHierarchical = param1._nonHierarchical;
         this._valid = param1._valid;
         this._relative = param1._relative;
      }
      
      public function isAbsolute() : Boolean
      {
         return !this._relative;
      }
      
      protected function get hierState() : Boolean
      {
         return _nonHierarchical.length == 0;
      }
      
      public function get queryRaw() : String
      {
         return _query;
      }
      
      public function get query() : String
      {
         return URI.unescapeChars(_query);
      }
      
      public function set scheme(param1:String) : void
      {
         var _loc2_:String = param1.toLowerCase();
         _scheme = URI.fastEscapeChars(_loc2_,URI.URIschemeExcludedBitmap);
      }
      
      public function forceEscape() : void
      {
         this.scheme = this.scheme;
         this.setQueryByMap(this.getQueryByMap());
         this.fragment = this.fragment;
         if(isHierarchical())
         {
            this.authority = this.authority;
            this.path = this.path;
            this.port = this.port;
            this.username = this.username;
            this.password = this.password;
         }
         else
         {
            this.nonHierarchical = this.nonHierarchical;
         }
      }
      
      public function getDefaultPort() : String
      {
         if(_scheme == "http")
         {
            return String("80");
         }
         if(_scheme == "ftp")
         {
            return String("21");
         }
         if(_scheme == "file")
         {
            return String("");
         }
         if(_scheme == "sftp")
         {
            return String("22");
         }
         return String("");
      }
      
      public function get fragment() : String
      {
         return URI.unescapeChars(_fragment);
      }
      
      public function set path(param1:String) : void
      {
         this._path = URI.fastEscapeChars(param1,URI.URIpathExcludedBitmap);
         if(this._scheme == UNKNOWN_SCHEME)
         {
            this._scheme = "";
         }
         hierState = true;
      }
      
      public function get authority() : String
      {
         return URI.unescapeChars(_authority);
      }
      
      public function isHierarchical() : Boolean
      {
         return hierState;
      }
      
      protected function toStringInternal(param1:Boolean) : String
      {
         var _loc2_:String = "";
         var _loc3_:String = "";
         if(isHierarchical() == false)
         {
            _loc2_ += param1 ? this.scheme : _scheme;
            _loc2_ += ":";
            _loc2_ += param1 ? this.nonHierarchical : _nonHierarchical;
         }
         else
         {
            if(isRelative() == false)
            {
               if(_scheme.length != 0)
               {
                  _loc3_ = param1 ? this.scheme : _scheme;
                  _loc2_ += _loc3_ + ":";
               }
               if(_authority.length != 0 || isOfType("file"))
               {
                  _loc2_ += "//";
                  if(_username.length != 0)
                  {
                     _loc3_ = param1 ? this.username : _username;
                     _loc2_ += _loc3_;
                     if(_password.length != 0)
                     {
                        _loc3_ = param1 ? this.password : _password;
                        _loc2_ += ":" + _loc3_;
                     }
                     _loc2_ += "@";
                  }
                  _loc3_ = param1 ? this.authority : _authority;
                  _loc2_ += _loc3_;
                  if(port.length != 0)
                  {
                     _loc2_ += ":" + port;
                  }
               }
            }
            _loc3_ = param1 ? this.path : _path;
            _loc2_ += _loc3_;
         }
         if(_query.length != 0)
         {
            _loc3_ = param1 ? this.query : _query;
            _loc2_ += "?" + _loc3_;
         }
         if(fragment.length != 0)
         {
            _loc3_ = param1 ? this.fragment : _fragment;
            _loc2_ += "#" + _loc3_;
         }
         return _loc2_;
      }
      
      public function get username() : String
      {
         return URI.unescapeChars(_username);
      }
      
      public function unknownToURI(param1:String, param2:String = "http") : Boolean
      {
         var _loc3_:String = null;
         var _loc5_:String = null;
         if(param1.length == 0)
         {
            this.initialize();
            return false;
         }
         param1 = param1.replace(/\\/g,"/");
         if(param1.length >= 2)
         {
            _loc3_ = param1.substr(0,2);
            if(_loc3_ == "//")
            {
               param1 = param2 + ":" + param1;
            }
         }
         if(param1.length >= 3)
         {
            _loc3_ = param1.substr(0,3);
            if(_loc3_ == "://")
            {
               param1 = param2 + param1;
            }
         }
         var _loc4_:URI = new URI(param1);
         if(_loc4_.isHierarchical() == false)
         {
            if(_loc4_.scheme == UNKNOWN_SCHEME)
            {
               this.initialize();
               return false;
            }
            copyURI(_loc4_);
            forceEscape();
            return true;
         }
         if(_loc4_.scheme != UNKNOWN_SCHEME && _loc4_.scheme.length > 0)
         {
            if(_loc4_.authority.length > 0 || _loc4_.scheme == "file")
            {
               copyURI(_loc4_);
               forceEscape();
               return true;
            }
            if(_loc4_.authority.length == 0 && _loc4_.path.length == 0)
            {
               setParts(_loc4_.scheme,"","","","","");
               return false;
            }
         }
         else
         {
            _loc5_ = _loc4_.path;
            if(_loc5_ == ".." || _loc5_ == "." || _loc5_.length >= 3 && _loc5_.substr(0,3) == "../" || _loc5_.length >= 2 && _loc5_.substr(0,2) == "./")
            {
               copyURI(_loc4_);
               forceEscape();
               return true;
            }
         }
         _loc4_ = new URI(param2 + "://" + param1);
         if(_loc4_.scheme.length > 0 && _loc4_.authority.length > 0)
         {
            copyURI(_loc4_);
            forceEscape();
            return true;
         }
         this.initialize();
         return false;
      }
      
      public function isDirectory() : Boolean
      {
         if(_path.length == 0)
         {
            return false;
         }
         return _path.charAt(path.length - 1) == "/";
      }
      
      protected function verifyAlpha(param1:String) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:RegExp = /[^a-z]/;
         param1 = param1.toLowerCase();
         _loc3_ = param1.search(_loc2_);
         if(_loc3_ == -1)
         {
            return true;
         }
         return false;
      }
      
      public function isOfFileType(param1:String) : Boolean
      {
         var _loc2_:String = null;
         var _loc3_:int = 0;
         _loc3_ = param1.lastIndexOf(".");
         if(_loc3_ != -1)
         {
            param1 = param1.substr(_loc3_ + 1);
         }
         _loc2_ = getExtension(true);
         if(_loc2_ == "")
         {
            return false;
         }
         if(compareStr(_loc2_,param1,false) == 0)
         {
            return true;
         }
         return false;
      }
      
      public function set nonHierarchical(param1:String) : void
      {
         _nonHierarchical = URI.fastEscapeChars(param1,URInonHierexcludedBitmap);
         this.hierState = false;
      }
      
      protected function joinPath(param1:Array, param2:Boolean, param3:Boolean) : String
      {
         var _loc5_:int = 0;
         var _loc4_:String = "";
         _loc5_ = 0;
         while(_loc5_ < param1.length)
         {
            if(_loc4_.length > 0)
            {
               _loc4_ += "/";
            }
            _loc4_ += param1[_loc5_];
            _loc5_++;
         }
         if(param3 && _loc4_.length > 0)
         {
            _loc4_ += "/";
         }
         if(param2)
         {
            _loc4_ = "/" + _loc4_;
         }
         return _loc4_;
      }
      
      public function isValid() : Boolean
      {
         return this._valid;
      }
      
      public function toString() : String
      {
         if(this == null)
         {
            return "";
         }
         return toStringInternal(false);
      }
      
      protected function validateURI() : Boolean
      {
         if(isAbsolute())
         {
            if(_scheme.length <= 1 || _scheme == UNKNOWN_SCHEME)
            {
               return false;
            }
            if(verifyAlpha(_scheme) == false)
            {
               return false;
            }
         }
         if(hierState)
         {
            if(_path.search("\\") != -1)
            {
               return false;
            }
            if(isRelative() == false && _scheme == UNKNOWN_SCHEME)
            {
               return false;
            }
         }
         else if(_nonHierarchical.search("\\") != -1)
         {
            return false;
         }
         return true;
      }
      
      public function getRelation(param1:URI, param2:Boolean = true) : int
      {
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:int = 0;
         var _loc3_:URI = URI.resolve(this);
         var _loc4_:URI = URI.resolve(param1);
         if(_loc3_.isRelative() || _loc4_.isRelative())
         {
            return URI.NOT_RELATED;
         }
         if(_loc3_.isHierarchical() == false || _loc4_.isHierarchical() == false)
         {
            if(_loc3_.isHierarchical() == false && _loc4_.isHierarchical() == true || _loc3_.isHierarchical() == true && _loc4_.isHierarchical() == false)
            {
               return URI.NOT_RELATED;
            }
            if(_loc3_.scheme != _loc4_.scheme)
            {
               return URI.NOT_RELATED;
            }
            if(_loc3_.nonHierarchical != _loc4_.nonHierarchical)
            {
               return URI.NOT_RELATED;
            }
            return URI.EQUAL;
         }
         if(_loc3_.scheme != _loc4_.scheme)
         {
            return URI.NOT_RELATED;
         }
         if(_loc3_.authority != _loc4_.authority)
         {
            return URI.NOT_RELATED;
         }
         var _loc5_:String = _loc3_.port;
         var _loc6_:String = _loc4_.port;
         if(_loc5_ == "")
         {
            _loc5_ = _loc3_.getDefaultPort();
         }
         if(_loc6_ == "")
         {
            _loc6_ = _loc4_.getDefaultPort();
         }
         if(_loc5_ != _loc6_)
         {
            return URI.NOT_RELATED;
         }
         if(compareStr(_loc3_.path,_loc4_.path,param2))
         {
            return URI.EQUAL;
         }
         var _loc7_:String = _loc3_.path;
         var _loc8_:String = _loc4_.path;
         if((_loc7_ == "/" || _loc8_ == "/") && (_loc7_ == "" || _loc8_ == ""))
         {
            return URI.EQUAL;
         }
         _loc9_ = _loc7_.split("/");
         _loc10_ = _loc8_.split("/");
         if(_loc9_.length > _loc10_.length)
         {
            _loc12_ = _loc10_[_loc10_.length - 1];
            if(_loc12_.length > 0)
            {
               return URI.NOT_RELATED;
            }
            _loc10_.pop();
            _loc13_ = 0;
            while(_loc13_ < _loc10_.length)
            {
               _loc11_ = _loc9_[_loc13_];
               _loc12_ = _loc10_[_loc13_];
               if(compareStr(_loc11_,_loc12_,param2) == false)
               {
                  return URI.NOT_RELATED;
               }
               _loc13_++;
            }
            return URI.CHILD;
         }
         if(_loc9_.length < _loc10_.length)
         {
            _loc11_ = _loc9_[_loc9_.length - 1];
            if(_loc11_.length > 0)
            {
               return URI.NOT_RELATED;
            }
            _loc9_.pop();
            _loc13_ = 0;
            while(_loc13_ < _loc9_.length)
            {
               _loc11_ = _loc9_[_loc13_];
               _loc12_ = _loc10_[_loc13_];
               if(compareStr(_loc11_,_loc12_,param2) == false)
               {
                  return URI.NOT_RELATED;
               }
               _loc13_++;
            }
            return URI.PARENT;
         }
         return URI.NOT_RELATED;
      }
      
      public function isOfType(param1:String) : Boolean
      {
         param1 = param1.toLowerCase();
         return this._scheme == param1;
      }
      
      public function getQueryValue(param1:String) : String
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         _loc2_ = getQueryByMap();
         for(_loc3_ in _loc2_)
         {
            if(_loc3_ == param1)
            {
               return _loc2_[_loc3_];
            }
         }
         return new String("");
      }
   }
}

