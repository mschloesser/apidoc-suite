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

        [Embed(source="/apidocs.xml", mimeType="application/octet-stream")]
        private static const staticApiDocsSource:Class;

        [Embed(source="/javadoc-test.html", mimeType="application/octet-stream")]
        private static const staticJavadocSource:Class;

        public static function getAs3DocSource():String {
            return getStringFromByteArray(staticAs3DocSource);
        }

        public static function getApiDocsSource():String {
            return getStringFromByteArray(staticApiDocsSource);
        }

        public static function getJavaDocSource():String {
            return getStringFromByteArray(staticJavadocSource);
        }

        private static function getStringFromByteArray(classRef:Class):String {
            var byteArray:ByteArray = new classRef();
            return byteArray.readUTFBytes(byteArray.bytesAvailable);
        }
    }
}
