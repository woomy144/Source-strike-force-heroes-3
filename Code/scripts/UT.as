package
{
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.net.LocalConnection;
   import flash.text.TextField;
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class UT
   {
      
      public static var curDate:Date;
      
      private static var colTrans1:ColorTransform;
      
      private static var colTrans2:ColorTransform;
      
      private static var colTrans3:ColorTransform;
       
      
      public function UT()
      {
         super();
      }
      
      public static function Init() : void
      {
         colTrans1 = new ColorTransform();
         colTrans2 = new ColorTransform();
         colTrans3 = new ColorTransform();
      }
      
      public static function rotateDirection(_curRotate:Number, _newRotate:Number) : int
      {
         return fixRotation(_newRotate - _curRotate) > 0 ? 1 : -1;
      }
      
      public static function fixRotation(_rotate:Number) : Number
      {
         if(_rotate > 180)
         {
            _rotate -= 360;
         }
         if(_rotate < -180)
         {
            _rotate += 360;
         }
         return _rotate;
      }
      
      public static function fixRotation360(_rotate:Number) : Number
      {
         if(_rotate > 360)
         {
            _rotate -= 360;
         }
         if(_rotate < 0)
         {
            _rotate += 360;
         }
         return _rotate;
      }
      
      public static function rotateDistance(_curRotate:Number, _newRotate:Number) : Number
      {
         return fixRotation(_newRotate - _curRotate);
      }
      
      public static function getDist(x1:Number, y1:Number, x2:Number, y2:Number) : Number
      {
         var x3:Number = x1 - x2;
         var y3:Number = y1 - y2;
         return Math.sqrt(x3 * x3 + y3 * y3);
      }
      
      public static function getRotation(x1:Number, y1:Number, x2:Number, y2:Number) : Number
      {
         var angle:Number = NaN;
         var x3:Number = x1 - x2;
         var y3:Number = y1 - y2;
         var dist:Number = Math.sqrt(x3 * x3 + y3 * y3);
         if(y3 < 0)
         {
            angle = Math.PI * 2 - Math.acos(x3 / dist);
         }
         else
         {
            angle = Math.acos(x3 / dist);
         }
         return UT.fixRotation(angle * 180 / Math.PI - 90);
      }
      
      public static function randLinePoint(x1:Number, y1:Number, x2:Number, y2:Number) : Point
      {
         var pt:Point = new Point();
         pt.x = UT.rand(x1,x2);
         pt.y = y1 + (pt.x - x1) / (x2 - x1) * (y2 - y1);
         return pt;
      }
      
      public static function rand(min:Number, max:Number) : Number
      {
         return Math.random() * (max - min) + min;
      }
      
      public static function irand(min:int, max:int) : int
      {
         return uint(Math.random() * (max - min + 1)) + min;
      }
      
      public static function getOrdinal(num:uint) : String
      {
         var suffix:String = null;
         if(num % 100 > 10 && num % 100 < 14)
         {
            suffix = "th";
         }
         else
         {
            switch(num % 10)
            {
               case 0:
                  suffix = "th";
                  break;
               case 1:
                  suffix = "st";
                  break;
               case 2:
                  suffix = "nd";
                  break;
               case 3:
                  suffix = "rd";
                  break;
               default:
                  suffix = "th";
            }
         }
         return num + suffix;
      }
      
      public static function fixFloat(num:Number) : Number
      {
         return int(Math.round(num * 10)) / 10;
      }
      
      public static function getRatio(num1:int, num2:int) : String
      {
         var res:* = "UT Error";
         if(!num1 && !num2 || num1 == num2)
         {
            res = "1 : 1";
         }
         else if(num1 && !num2)
         {
            res = num1 + " : 0";
         }
         else if(!num1 && num2)
         {
            res = "0 : " + num2;
         }
         else if(num1 > num2)
         {
            res = Math.round(num1 / num2 * 100) / 100 + " : 1";
         }
         else if(num2 > num1)
         {
            res = "1 : " + Math.round(num2 / num1 * 100) / 100;
         }
         return res;
      }
      
      public static function inBox(findX:Number, findY:Number, startX:Number, startY:Number, width:Number, height:Number) : Boolean
      {
         return findX > Math.min(startX,startX + width) && findX < Math.max(startX,startX + width) && findY > Math.min(startY,startY + height) && findY < Math.max(startY,startY + height);
      }
      
      public static function xMoveToRot(rot:Number, spd:Number) : Number
      {
         return rot == 0 || rot == 180 || rot == -180 ? Number(0) : Number(Math.sin(rot * (Math.PI / 180)) * spd);
      }
      
      public static function yMoveToRot(rot:Number, spd:Number) : Number
      {
         return rot == 90 || rot == -90 ? Number(0) : Number(Math.cos(rot * (Math.PI / 180)) * -spd);
      }
      
      public static function randEl(ar:Array) : *
      {
         return ar[uint(Math.random() * ar.length)];
      }
      
      public static function getPosNegSign(num:*) : int
      {
         return num >= 0 ? 1 : -1;
      }
      
      public static function wordWrap(_msg:String, _txt:TextField) : String
      {
         _txt.text = _msg;
         var lineAmt:uint = 0;
         for(var i:uint = 0; i < _txt.numLines - 1; i++)
         {
            lineAmt += _txt.getLineLength(i);
            _msg = _msg.substring(0,lineAmt + i) + "\n" + _msg.substring(lineAmt + i);
         }
         _txt.text = "";
         return _msg;
      }
      
      public static function rotBounceOff(_rotation:Number, _x:Number, _y:Number, _impactX:Number, _impactY:Number) : Number
      {
         var _rot:Number = UT.getRotation(_x,_y,_impactX,_impactY);
         var _diff:Number = UT.fixRotation(_rotation - _rot);
         return UT.fixRotation(_rotation - _diff + 180);
      }
      
      public static function getSideFacing(rot:Number) : String
      {
         rot = UT.fixRotation(rot);
         var dir:String = "";
         if(rot >= -45 && rot <= 45)
         {
            dir = "up";
         }
         else if(rot >= -135 && rot <= -45)
         {
            dir = "left";
         }
         else if(rot <= 135 && rot >= 45)
         {
            dir = "right";
         }
         else
         {
            dir = "down";
         }
         return dir;
      }
      
      public static function getTimeString(frames:uint, startZero:Boolean) : String
      {
         var sec:uint = frames / 30 % 60;
         var min:uint = frames / 30 / 60;
         return (startZero && min < 10 ? "0" + min : min) + ":" + (sec < 10 ? "0" + sec : sec);
      }
      
      public static function replaceString(str:String, find:String, repl:String = "") : String
      {
         while(str.indexOf(find) != -1)
         {
            str = str.replace(find,repl);
         }
         return str;
      }
      
      public static function mergeObject(source:*, combine:*) : void
      {
         var i:* = null;
         for(i in combine)
         {
            source[i] = combine[i];
         }
      }
      
      public static function traceObject(source:*) : void
      {
         var i:* = null;
         trace("---- Tracing Object ---");
         for(i in source)
         {
            trace("-",i,"=",source[i]);
         }
      }
      
      public static function cloneObject(clone:Object) : Object
      {
         var i:* = null;
         var ob:Object = {};
         for(i in clone)
         {
            ob[i] = clone[i];
         }
         return ob;
      }
      
      public static function addNumCommas(num:uint) : String
      {
         var str:String = "" + num;
         var counter:uint = str.length;
         for(var i:uint = 0; i < str.length; i += 3)
         {
            if(counter < str.length && counter > 0)
            {
               str = str.substring(0,counter) + "," + str.substring(counter);
            }
            counter -= 3;
         }
         return str;
      }
      
      public static function getEl(num:uint, ar:Array) : *
      {
         return ar[num];
      }
      
      public static function getNextEl(curEl:*, next:Boolean, ar:Array) : *
      {
         var num:int = ar.indexOf(curEl);
         num += !!next ? 1 : -1;
         if(num == ar.length)
         {
            num = 0;
         }
         if(num < 0)
         {
            num = ar.length - 1;
         }
         return ar[num];
      }
      
      public static function roundToDecimal(_num:Number, _dec:uint) : Number
      {
         var pow:uint = Math.pow(10,_dec);
         return Math.round(_num * pow) / pow;
      }
      
      public static function getPythagorean(_a:Number, _b:Number) : Number
      {
         return Math.sqrt(_a * _a + _b * _b);
      }
      
      public static function coinFlip(_a:*, _b:*, aChance:Number = 0.5) : *
      {
         return Math.random() < aChance ? _a : _b;
      }
      
      public static function stringToClass(_str:String) : Class
      {
         return getDefinitionByName(_str) as Class;
      }
      
      public static function loopAround(src:Number, min:Number, max:Number) : Number
      {
         if(src > max)
         {
            src = min;
         }
         if(src < min)
         {
            src = max;
         }
         return src;
      }
      
      public static function clone(source:Object) : Object
      {
         var clone:Object = null;
         if(source)
         {
            clone = newSibling(source);
            if(clone)
            {
               copyData(source,clone);
            }
         }
         return clone;
      }
      
      public static function newSibling(sourceObj:Object) : *
      {
         var objSibling:* = undefined;
         var classOfSourceObj:Class = null;
         if(sourceObj)
         {
            try
            {
               classOfSourceObj = getDefinitionByName(getQualifiedClassName(sourceObj)) as Class;
               objSibling = new classOfSourceObj();
            }
            catch(e:Object)
            {
            }
            return objSibling;
         }
         return null;
      }
      
      public static function copyData(source:Object, destination:Object) : void
      {
         var sourceInfo:XML = null;
         var prop:XML = null;
         if(source && destination)
         {
            try
            {
               sourceInfo = describeType(source);
               for each(prop in sourceInfo.variable)
               {
                  if(destination.hasOwnProperty(prop.@name))
                  {
                     destination[prop.@name] = source[prop.@name];
                  }
               }
               for each(prop in sourceInfo.accessor)
               {
                  if(prop.@access == "readwrite")
                  {
                     if(destination.hasOwnProperty(prop.@name))
                     {
                        destination[prop.@name] = source[prop.@name];
                     }
                  }
               }
            }
            catch(err:Object)
            {
            }
         }
      }
      
      public static function shuffle(ar:Array) : void
      {
         var val:Array = null;
         for(var i:uint = 0; i < ar.length; i++)
         {
            val = ar.splice(i,1);
            ar.splice(UT.irand(0,ar.length - 1),0,val[0]);
         }
      }
      
      public static function getLinearRange(val:Number, valMax:Number, rangeMin:Number, rangeMax:Number) : Number
      {
         return rangeMin + (rangeMax - rangeMin) / (valMax - 1) * (val - 1);
      }
      
      public static function getCurvedRange(val:Number, valMax:Number, rangeMin:Number, rangeMax:Number) : Number
      {
         var rangeMid:Number = rangeMax - rangeMin;
         var valMid:Number = valMax - 1;
         var useVal:Number = val - 1;
         var rangeFinal:Number = rangeMid / (valMid * valMid) * (useVal * useVal);
         return rangeMin + rangeFinal;
      }
      
      public static function forceGarbageCollection() : void
      {
         try
         {
            new LocalConnection().connect("foo");
            new LocalConnection().connect("foo");
         }
         catch(e:*)
         {
         }
      }
      
      public static function setMcColor(mc:*, col:uint) : void
      {
         colTrans1.color = col;
         mc.transform.colorTransform = colTrans1;
      }
      
      public static function resetMcColor(mc:*) : void
      {
         mc.transform.colorTransform = colTrans3;
      }
      
      public static function setMcTransform(mc:*, r:Number, g:Number, b:Number, a:Number = 1) : void
      {
         colTrans2.redMultiplier = r;
         colTrans2.greenMultiplier = g;
         colTrans2.blueMultiplier = b;
         colTrans2.alphaMultiplier = a;
         mc.transform.colorTransform = colTrans2;
      }
      
      public static function rgbToHex(r:uint, g:uint, b:uint) : uint
      {
         return r << 16 | g << 8 | b;
      }
      
      public static function setDate() : void
      {
         curDate = new Date();
      }
      
      public static function getOscillation(speed:Number, size:Number, offset:Number = 0) : Number
      {
         return Math.cos((curDate.getTime() + offset) * (speed * 0.001)) * size;
      }
      
      public static function hextToInt(hex:String) : uint
      {
         return parseInt(hex.substr(1),16);
      }
      
      public static function intToHex(num:int) : String
      {
         return num.toString(16);
      }
      
      public static function clamp(val:Number, min:Number, max:Number) : Number
      {
         if(val < min)
         {
            val = min;
         }
         if(val > max)
         {
            val = max;
         }
         return val;
      }
      
      public static function between(val:Number, min:Number, max:Number) : Boolean
      {
         if(val < min)
         {
            return false;
         }
         if(val > max)
         {
            return false;
         }
         return true;
      }
      
      public static function toUpperFirst(str:String) : String
      {
         return str.charAt(0).toUpperCase() + str.substr(1).toLowerCase();
      }
      
      public static function intToBit(num:int) : int
      {
         var res:int = 1;
         for(var i:int = 0; i < num - 1; i++)
         {
            res *= 2;
         }
         return res;
      }
      
      public static function bitToInt(num:int) : int
      {
         var res:int = 1;
         while(num > 1)
         {
            num *= 0.5;
            res++;
         }
         return res;
      }
   }
}
