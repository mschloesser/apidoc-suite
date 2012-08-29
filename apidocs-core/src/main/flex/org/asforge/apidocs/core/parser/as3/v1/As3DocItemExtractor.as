/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 8/3/12
 * Time: 4:58 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser.as3.v1 {

    import org.asforge.apidocs.core.model.ApiDocItem;
    import org.asforge.apidocs.core.model.enumeration.ApiDocItemType;

    public class As3DocItemExtractor {
        public function As3DocItemExtractor() {
        }

        public function extract(node:XML):ApiDocItem {
            var item:ApiDocItem = new ApiDocItem();
            var title:String = String(node.@title);
            item.name = title.substr(title.lastIndexOf('.') + 1);
            item.packageName = title.substr(0, title.lastIndexOf('.'));

            var italicTagPos:int = node.children()[0].toXMLString().toLowerCase().indexOf('<i>');
            item.type = italicTagPos != -1 ? ApiDocItemType.INTERFACE : ApiDocItemType.CLASS;

            return item;
        }
    }
}
