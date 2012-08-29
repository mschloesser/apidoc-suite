/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/11/12
 * Time: 5:51 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.app {

    import flash.filesystem.File;
    import flash.net.URLLoader;
    import flash.utils.Dictionary;

    import mx.collections.ListCollectionView;

    import org.asforge.apidocs.core.dao.IApiDocDao;
    import org.asforge.apidocs.core.dao.impl.SqlLiteApiDaoImpl;
    import org.asforge.apidocs.core.parser.DocParserProvider;
    import org.asforge.apidocs.core.service.ApiDocItemService;
    import org.asforge.apidocs.core.service.ApiDocServiceImpl;
    import org.asforge.apidocs.core.service.IApiDocItemService;
    import org.asforge.apidocs.core.service.IApiDocService;
    import org.asforge.apidocs.core.util.ItemCache;
    import org.asforge.apidocs.desktop.model.ApiDocItemModel;
    import org.asforge.apidocs.desktop.model.ApiDocModel;
    import org.asforge.apidocs.desktop.model.OptionsModel;
    import org.asforge.apidocs.desktop.signal.ApiDocListUpdatedSignal;
    import org.asforge.apidocs.desktop.signal.DocSelectedSignal;
    import org.asforge.apidocs.desktop.view.DocSelectionViewMediator;
    import org.asforge.apidocs.desktop.view.FilterViewMediator;
    import org.asforge.apidocs.desktop.view.IDocSelectionView;
    import org.asforge.apidocs.desktop.view.IItemListView;
    import org.asforge.apidocs.desktop.view.IOptionsView;
    import org.asforge.apidocs.desktop.view.ItemListViewMediator;
    import org.asforge.apidocs.desktop.view.OptionsViewMediator;
    import org.asforge.apidocs.desktop.view.component.DropDownListApiDocSelectionView;
    import org.asforge.apidocs.desktop.view.component.ItemListView;
    import org.asforge.apidocs.desktop.view.component.ListFilterView;
    import org.asforge.apidocs.desktop.view.component.OptionsView;
    import org.osflash.signals.ISignal;
    import org.osflash.signals.Signal;
    import org.robotlegs.mvcs.SignalContext;

    public class ApplicationContext extends SignalContext {

        override public function startup():void {
            
            var dbFile:File = File.applicationStorageDirectory.resolvePath("foo.sqlite");
            injector.mapValue(File, dbFile);

            injector.mapSingletonOf(IApiDocDao, SqlLiteApiDaoImpl);
            injector.mapSingletonOf(IApiDocService, ApiDocServiceImpl);
            
            // signals
            injector.mapSingleton(DocSelectedSignal);
            injector.mapSingleton(ApiDocListUpdatedSignal);

            // parser
            injector.mapSingleton(DocParserProvider);

            var successSignal:ISignal = new Signal(ListCollectionView);
            var errorSignal:ISignal = new Signal();

            var itemService:ApiDocItemService = new ApiDocItemService(successSignal, errorSignal);
            itemService.itemCache = new ItemCache();
            itemService.itemCache.storage = new Dictionary();
            itemService.loader = new URLLoader();

            injector.mapValue(IApiDocItemService, itemService);

            injector.mapSingleton(ApiDocModel);
            injector.mapSingleton(ApiDocItemModel);
            injector.mapSingleton(OptionsModel);

            mediatorMap.mapView(DropDownListApiDocSelectionView, DocSelectionViewMediator, IDocSelectionView);
            mediatorMap.mapView(ItemListView, ItemListViewMediator, IItemListView);
            mediatorMap.mapView(ListFilterView, FilterViewMediator);
            mediatorMap.mapView(OptionsView, OptionsViewMediator, IOptionsView);

            super.startup();
        }
    }
}
