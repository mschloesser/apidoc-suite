/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 8/3/12
 * Time: 7:53 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser.as3.v1 {

    import mx.collections.ArrayList;
    import mx.collections.IList;

    import org.asforge.apidocs.core.parser.IApiDocParser;

    public class As3DocParser implements IApiDocParser {

        public var itemExtractor:As3DocItemExtractor;

        public function parseApiDoc(source:String):IList {

            var detectedItems:Array = detectItems(source);
            var extractedItems:Array = [];
            var length:uint = detectedItems.length;
            for (var i:int = 0; i < length; i++) {
                var item:String = detectedItems[i];
                extractedItems.push(itemExtractor.extract(XML(item)));
            }

            return new ArrayList(extractedItems);
        }

        internal function detectItems(source:String):Array
        {
            var result:Array = [];

            var pos:Vector.<int> = new <int>[];
            pos[0] = source.indexOf('<table');

            var body:String = source.substring(pos[0] + source.substring(pos[0]).indexOf('>') + 1);
            var lines:Array = body.split('\n');
            for (var i:int = 0; i < lines.length; i++) {
                var line:String = lines[i];

                if (line.indexOf('</table>') > -1) break;

                pos[1] = line.indexOf('<a');
                if (pos[1] > -1)
                {
                    pos[2] = line.indexOf('</a>');
                    result.push(line.substring(pos[1], pos[2] + 4));
                }
            }

            return result;
        }
    }
}
