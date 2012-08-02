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
        public static const ENUM:ApiDocItemType = new ApiDocItemType(2, "ENUM");
        public static const ANNOTATION:ApiDocItemType = new ApiDocItemType(3, "ANNOTATION");

        private var _ordinal:int;
        private var _descriptor:String;

        public function ApiDocItemType(ordinal:int, descriptor:String) {
            _ordinal = ordinal;
            _descriptor = descriptor;
        }

        public function get ordinal():int {
            return _ordinal;
        }

        public static function byOrdinal(aOrdinal:int):ApiDocItemType {
            if (aOrdinal == CLASS._ordinal) return CLASS;
            else if (aOrdinal == INTERFACE._ordinal) return INTERFACE;
            else if (aOrdinal == ANNOTATION._ordinal) return ANNOTATION;
            else return ENUM;
        }

        public function toString():String {
            return "ApiDocItemType." + _descriptor + "{_ordinal=" + String(_ordinal) + "}";
        }

        public static function byName(aDescriptor:String):ApiDocItemType {
            if (aDescriptor == CLASS._descriptor) return CLASS;
            else if (aDescriptor == INTERFACE._descriptor) return INTERFACE;
            else if (aDescriptor == ANNOTATION._descriptor) return ANNOTATION;
            else return ENUM;
        }
    }
}