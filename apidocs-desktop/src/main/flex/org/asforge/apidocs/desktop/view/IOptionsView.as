/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/26/12
 * Time: 7:55 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.view {

    import mx.collections.ListCollectionView;

    import org.osflash.signals.ISignal;

    public interface IOptionsView {
        function get apiDocList():ListCollectionView;
        function set apiDocList(value:ListCollectionView):void;

        function get saveApiDocSignal():ISignal;
        function get deleteButtonSignal():ISignal;
    }
}
