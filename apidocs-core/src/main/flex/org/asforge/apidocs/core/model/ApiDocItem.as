/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/31/12
 * Time: 7:30 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.model {

    import org.asforge.apidocs.core.model.enumeration.ApiDocItemType;

    public class ApiDocItem {
        public var name:String;
        public var packageName:String;
        public var type:ApiDocItemType;

        public function isValid():Boolean {
            return name != "" && type != null;
        }

        public function get url():String {
            return packageName.replace(/\./, '/') + ".html";
        }
    }
}
