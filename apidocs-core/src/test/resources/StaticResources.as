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

        [Embed(source="/as3v2-test.html", mimeType="application/octet-stream")]
        private static const staticAs3v2DocSource:Class;

        [Embed(source="/as3doc-test.html", mimeType="application/octet-stream")]
        private static const staticAs3DocSource:Class;

        [Embed(source="/javadoc-test.html", mimeType="application/octet-stream")]
        private static const staticJavadocSource:Class;

        [Embed(source="/javadoc-v2.html", mimeType="application/octet-stream")]
        private static const staticJavadocV2Source:Class;

        public static function getAs3v2DocSource():String {
            return getStringFromByteArray(staticAs3v2DocSource);
        }

        public static function getAs3DocSource():String {
            return getStringFromByteArray(staticAs3DocSource);
        }

        public static function getJavaDocV1Source():String {
            return getStringFromByteArray(staticJavadocSource);
        }

        public static function getJavaDocV2Source():String {
            return getStringFromByteArray(staticJavadocV2Source);
        }

        private static function getStringFromByteArray(classRef:Class):String {
            var byteArray:ByteArray = new classRef();
            return byteArray.readUTFBytes(byteArray.bytesAvailable);
        }
    }
}
