/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/31/12
 * Time: 7:33 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.exception {

    public class ItemExtractorException extends Error {
        private var _definition:String;
        
        public function ItemExtractorException(message:String, definition:String) {
            super(message);
            _definition = definition;
        }

        public function get definition():String {
            return _definition;
        }
    }
}
