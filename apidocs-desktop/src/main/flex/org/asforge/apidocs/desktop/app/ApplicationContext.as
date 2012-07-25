/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/11/12
 * Time: 5:51 PM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.desktop.app {

    import org.asforge.apidocs.core.dao.IApiDocDao;
    import org.asforge.apidocs.core.service.ApiDocServiceImpl;
    import org.asforge.apidocs.core.service.IApiDocService;
    import org.asforge.apidocs.desktop.controller.AddApiDocToListCommand;
    import org.asforge.apidocs.desktop.model.ApiDocModel;
    import org.asforge.apidocs.desktop.model.OptionsModel;
    import org.asforge.apidocs.desktop.signal.AddApiDocSignal;
    import org.asforge.apidocs.desktop.view.ApiDocSelectionViewMediator;
    import org.asforge.apidocs.desktop.view.IApiDocSelectionView;
    import org.asforge.apidocs.desktop.view.OptionsViewMediator;
    import org.asforge.apidocs.desktop.view.component.DropDownListApiDocSelectionView;
    import org.asforge.apidocs.desktop.view.component.OptionsView;
    import org.robotlegs.mvcs.SignalContext;

    public class ApplicationContext extends SignalContext {

        override public function startup():void {
            
//            var dbFile:File = File.applicationStorageDirectory.resolvePath("foo.sqlite");
//            injector.mapValue(File, dbFile);
//            injector.mapSingletonOf(IApiDocDao, SqlLiteApiDaoImpl);
            injector.mapSingletonOf(IApiDocDao, InMemoryApiDaoImpl);
            injector.mapSingletonOf(IApiDocService, ApiDocServiceImpl);

            injector.mapSingleton(ApiDocModel);
            injector.mapSingleton(OptionsModel);
            
            mediatorMap.mapView(DropDownListApiDocSelectionView,
                    ApiDocSelectionViewMediator, IApiDocSelectionView);
            mediatorMap.mapView(OptionsView, OptionsViewMediator);

            signalCommandMap.mapSignalClass(AddApiDocSignal, AddApiDocToListCommand);

            super.startup();
        }
    }
}
