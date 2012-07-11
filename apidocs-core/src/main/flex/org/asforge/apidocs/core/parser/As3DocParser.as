/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/4/12
 * Time: 7:32 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser {

    import mx.collections.ArrayList;
    import mx.collections.IList;

    public class As3DocParser implements IApiDocParser {
        public function parseApiDoc(source:String):IList {

            var result:Array = [];

            // strip
            var body:String = extractTargetBody(source);
            var parts:Array = body.split("</a>");

            // throw away last part since it no valid apidocitem
            var length:int = parts.length - 1;
            for (var i:int = 0; i < length; i++) {
                var part:String = parts[i];
                var a:Object = extractApiDocItem(part);
                result.push(a);
            }

            return new ArrayList(result);
        }

        private function extractApiDocItem(part:String):Object {
            var search:String = "title=\"";
            var titlePos:int = part.indexOf(search);
            var title:String = part.substring(titlePos + search.length);
            search = "\"";
            titlePos = title.indexOf(search);
            title = title.substring(0, titlePos);

            var a:Object = {
                pakageName: title,
                name: title.split(".")[title.split(".").length - 1],
                typee: part.indexOf("<i>") > -1
            };
            return a;
        }

        private function extractTargetBody(source:String):String {
            var pos:int = source.indexOf("<body");
            var body:String = source.substring(pos);
            pos = body.indexOf("<div>");
            body = body.substring(pos + "<div>".length);
            pos = body.indexOf("</div>");
            body = body.substring(0, pos);
            return body;
        }
    }
}
