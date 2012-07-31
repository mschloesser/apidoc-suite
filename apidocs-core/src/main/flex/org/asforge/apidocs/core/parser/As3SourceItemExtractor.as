/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/31/12
 * Time: 7:29 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser {

    import org.asforge.apidocs.core.exception.ItemExtractorException;
    import org.asforge.apidocs.core.model.ApiDocItem;
    import org.asforge.apidocs.core.model.enumeration.ApiDocItemType;

    public class As3SourceItemExtractor {
        public function As3SourceItemExtractor() {
        }

        public function extractItem(definition:String):ApiDocItem {
            var apiDocItem:ApiDocItem = new ApiDocItem();

            var search:String = "title=\"";
            var titlePos:int = definition.indexOf(search);
            var title:String = definition.substring(titlePos + search.length);
            search = "\"";
            titlePos = title.indexOf(search);
            title = title.substring(0, titlePos);

            var splitTitle:Array = title.split(".");
            apiDocItem.name = splitTitle[splitTitle.length - 1];
            apiDocItem.packageName = title.substring(0, title.lastIndexOf("."));
            apiDocItem.type = ApiDocItemType.byOrdinal(definition.indexOf("<i>") > -1 ? 1 : 0);

            if (!apiDocItem.isValid()) {
                throw new ItemExtractorException("Error while extracting ApiDocItem from source", definition);
            }

            return apiDocItem;
        }
    }
}
