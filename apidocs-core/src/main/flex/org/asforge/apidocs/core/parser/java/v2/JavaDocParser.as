/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 8/1/12
 * Time: 6:12 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser.java.v2 {

    import mx.collections.ArrayList;
    import mx.collections.IList;

    import org.asforge.apidocs.core.model.ApiDocItem;
    import org.asforge.apidocs.core.model.enumeration.ApiDocItemType;
    import org.asforge.apidocs.core.parser.*;

    public class JavaDocParser implements IApiDocParser {

        public function JavaDocParser() {
        }

        public function parseApiDoc(source:String):IList
        {
            var items:Array = [];
            var detectedItems:Vector.<String> = detectItems(source);
            for each (var tag:String in detectedItems)
            {
                var titleAttrib:String = "title=\"";
                var titleAttribPos:int = tag.toLowerCase().indexOf(titleAttrib);
                if (titleAttribPos == -1) {
                    continue;
                }

                var title:String = tag.toLowerCase().substring(titleAttribPos + titleAttrib.length);
                title = title.substring(0, title.indexOf("\""));
                var titleSplit:Array = title.split(" ");

                var pos1:int = tag.toLowerCase().indexOf(">");
                var pos2:int = tag.toLowerCase().indexOf("</a");
                var aValue:String = tag.substring(pos1 + 1, pos2);

                var apiDocItem:ApiDocItem = new ApiDocItem();
                apiDocItem.name = extractTypeName(aValue);
                apiDocItem.packageName = titleSplit[2];
                apiDocItem.type = ApiDocItemType.byName(titleSplit[0].toUpperCase());

                items.push(apiDocItem);
            }

            return new ArrayList(items);
        }

        private function extractTypeName(aValue:String):String {
            var pos:Array = [];
            pos[0] = aValue.toLowerCase().indexOf("<i>");
            if (pos[0] != -1) {
                pos[1] = aValue.toLowerCase().indexOf("</i>");
                return aValue.substring(pos[0] + 3, pos[1]);
            }

            return aValue;
        }

        internal function detectItems(source:String):Vector.<String> {
            var pos:Vector.<int> = new <int>[];
            pos[0] = source.indexOf('<ul>');

            var result:Vector.<String> = new <String>[];
            
            var body:String = source.substring(pos[0]);
            var lines:Array = body.split('\n');
            for each (var line:String in lines) {
                pos[1] = line.indexOf('<li>');
                if (pos[1] != -1)
                {
                    pos[2] = line.indexOf('</a>');
                    result.push(line.substring(pos[1] + 4, pos[2] + 4));
                }
            }

            return result;
        }
    }
}
