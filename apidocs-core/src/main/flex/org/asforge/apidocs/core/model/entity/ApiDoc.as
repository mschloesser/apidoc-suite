/**
 * Created by IntelliJ IDEA.
 * User: micha
 * Date: 7/10/12
 * Time: 7:37 AM
 * To change this template use File | Settings | File Templates.
 */
package org.asforge.apidocs.core.model.entity {

    [Bindable]
    [Table(name="apidocs")]
    public class ApiDoc {

        private var _id:int;

        private var _title:String;

        private var _url:String;

        private var _type:int;

        public function ApiDoc() {
        }

        [Id]
        [Column(name="id")]
        public function get id():int {
            return _id;
        }

        public function set id(value:int):void {
            _id = value;
        }

        [Column(name="title")]
        public function get title():String {
            return _title;
        }

        public function set title(title:String):void {
            _title = title;
        }

        [Column(name="url")]
        public function get url():String {
            return _url;
        }

        public function set url(url:String):void {
            _url = url;
        }

        [Column(name="type")]
        public function get type():int {
            return _type;
        }

        public function set type(type:int):void {
            _type = type;
        }

        public function isIdValid():Boolean {
            return id > 0;
        }
    }
}
