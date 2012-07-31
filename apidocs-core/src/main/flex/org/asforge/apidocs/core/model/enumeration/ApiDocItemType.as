/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/31/12
 * Time: 7:53 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.model.enumeration {

    public class ApiDocItemType {

        public static const CLASS:ApiDocItemType = new ApiDocItemType(0, "CLASS");
        public static const INTERFACE:ApiDocItemType = new ApiDocItemType(1, "INTERFACE");

        private var _ordinal:int;
        private var _descriptor:String;

        public function ApiDocItemType(ordinal:int, descriptor:String) {
            _ordinal = ordinal;
            _descriptor = descriptor;
        }

        public function get ordinal():int {
            return _ordinal;
        }

        public static function byOrdinal(ordinal:int):ApiDocItemType {
            return ordinal == CLASS.ordinal ? CLASS : INTERFACE;
        }

        public function toString():String {
            return "ApiDocItemType." + _descriptor + "{_ordinal=" + String(_ordinal) + "}";
        }
    }
}
