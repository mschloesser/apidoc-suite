/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/10/12
 * Time: 7:42 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.model.enumeration {

    public class ApiDocType {
        public static const AS3:ApiDocType = new ApiDocType("AS3");
        public static const JAVA:ApiDocType = new ApiDocType("JAVA");
        public static const HAXE:ApiDocType = new ApiDocType("HAXE");

        private static var ordinalCounter:uint = 0;

        private var _ordinal:uint;
        private var _name:String;

        public function ApiDocType(name:String) {
            _name = name;
            _ordinal = ordinalCounter++;
        }

        public function get ordinal():int {
            return _ordinal;
        }

        public function get name():String {
            return _name;
        }

        public static function byOrdinal(type:int):ApiDocType {
            switch (type) {
                case 0:
                    return ApiDocType.AS3;
                break;
                case 1:
                    return ApiDocType.JAVA;
                break;
                case 2:
                    return ApiDocType.HAXE;
                break;
            }

            return null;
        }

        public static function values():Array {
            return [ AS3, JAVA, HAXE ];
        }
    }
}
