/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/25/12
 * Time: 7:48 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.model {

    import mx.collections.ArrayCollection;
    import mx.collections.ListCollectionView;

    import org.asforge.apidocs.core.model.entity.ApiDoc;
    import org.asforge.apidocs.core.service.IApiDocService;
    import org.robotlegs.mvcs.Actor;

    public class OptionsModel extends Actor {

        [Inject]
        public var apiDocService:IApiDocService;

        private var list:ListCollectionView;

        [Bindable]
        public function findAll():ListCollectionView {
            list = new ArrayCollection();
            list.addAll(apiDocService.findAll());

            return list;
        }
        
        public function saveApiDoc(apiDoc:ApiDoc):void {
            if (!apiDoc.isIdValid()) {
                apiDocService.addApiDoc(apiDoc);
            } else {
                apiDocService.updateApiDoc(apiDoc);
            }
        }

        public function deleteApiDoc(apiDoc:ApiDoc):void {
            var itemIndex:int = list.getItemIndex(apiDoc);
            list.removeItemAt(itemIndex);
            if (apiDoc.id > 0) {
                apiDocService.deleteApiDoc(apiDoc);
            }
        }

    }
}
