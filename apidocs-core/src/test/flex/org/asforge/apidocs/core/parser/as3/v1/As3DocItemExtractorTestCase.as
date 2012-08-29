/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 8/3/12
 * Time: 7:58 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.parser.as3.v1 {

    import org.asforge.apidocs.core.model.ApiDocItem;
    import org.asforge.apidocs.core.model.enumeration.ApiDocItemType;
    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;

    public class As3DocItemExtractorTestCase {

        [Test]
        public function extractInterfaceType():void {
            var input:String = '<a href="mockolate/ingredients/answers/Answer.html" title="mockolate.ingredients.answers.Answer"><i>Answer</i></a>';
            var extractor:As3DocItemExtractor = new As3DocItemExtractor();
            var result:ApiDocItem = extractor.extract(XML(input));
            assertThat(result.name, equalTo("Answer"));
            assertThat(result.packageName, equalTo("mockolate.ingredients.answers"));
            assertThat(result.type, equalTo(ApiDocItemType.INTERFACE));
        }

        [Test]
        public function extractClassType():void
        {
            var input:String = '<a href="mockolate/ingredients/ArgumentsMatcher.html" title="mockolate.ingredients.ArgumentsMatcher">ArgumentsMatcher</a>';
            var extractor:As3DocItemExtractor = new As3DocItemExtractor();
            var result:ApiDocItem = extractor.extract(XML(input));
            assertThat(result.name, equalTo("ArgumentsMatcher"));
            assertThat(result.packageName, equalTo("mockolate.ingredients"));
            assertThat(result.type, equalTo(ApiDocItemType.CLASS));
        }
    }
}
