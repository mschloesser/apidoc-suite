/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 6/3/12
 * Time: 11:35 AM
 * To change this template use File | Settings | File Templates.
 */
package {

    import flash.utils.ByteArray;

    public class StaticResources {

        [Embed(source="/as3-doc.html", mimeType="application/octet-stream")]
        private static const staticAs3DocSource:Class;

        [Embed(source="/simple.html", mimeType="application/octet-stream")]
        private static const staticSimpleHtmlSource:Class;

        public static function getAs3DocSource():String {
            return getStringFromByteArray(staticAs3DocSource);
        }

        public static function getSimpleHtmlSource():String {
            return getStringFromByteArray(staticSimpleHtmlSource);
        }

        private static function getStringFromByteArray(classRef:Class):String {
            var byteArray:ByteArray = new classRef();
            return byteArray.readUTFBytes(byteArray.bytesAvailable);
        }
    }
}
