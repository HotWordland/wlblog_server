/**
 * Created by Ronaldinho on 15/8/27.
 */
'use strict';
//分类展示
angular.module('MyApp.CatalogView',[]).controller('CatalogViewCtl',['$http','DomainConfig','$state','PassCatalogParamFactory',function CatalogViewCtl($http,DomainConfig,$state,pasParam){
   var vm = this;
   vm.catagorys = [];
   var req = {
      method: 'GET',
      url: DomainConfig.domain+'admin/api/catagory'
    };
  vm.delay = 0;
	vm.minDuration = 0;
	vm.message = '处理中';
	vm.backdrop = true;
	vm.promise = null;
	// vm.promise = $http.get('http://httpbin.org/delay/3');
   vm.loadData = function () {
     var req = {
        method: 'GET',
        url: DomainConfig.domain+'admin/api/catagory'
      };
     vm.promise = $http(req).then(function(response){
       vm.catagorys = response.data
     }, function(){

     });
   }
   vm.loadData();
   vm.toEditCatalog = function (editModel) {
     editModel.cate_pid = parseInt(editModel.cate_pid);
     editModel.cate_order = parseInt(editModel.cate_order);
     pasParam.setter(editModel);
     $state.go('DashboardView.edit_catalog');
   };
   vm.toDeleteCatalog = function (deleteModel) {
     var req = {
        method: 'DELETE',
        url: DomainConfig.domain+'admin/api/catagory/'+deleteModel.id
      };
     $http(req).then(function(response){
       console.log(response);
       vm.loadData();
     }, function(){

     });

   }
}]);
//传参
angular.module('MyApp.CatalogView').factory('PassCatalogParamFactory', function () {
    //定义参数对象
    var myObject = {};

    /**
     * 定义传递数据的setter函数
     * @param {type} xxx
     * @returns {*}
     * @private
     */
    var _setter = function (data) {
       myObject = data;
    };

    /**
     * 定义获取数据的getter函数
     * @param {type} xxx
     * @returns {*}
     * @private
     */
    var _getter = function () {
        return myObject;
    };

    // Public APIs
    // 在controller中通过调setter()和getter()方法可实现提交或获取参数的功能
    return {
        setter: _setter,
        getter: _getter
    };
});
//新建分类
angular.module('MyApp.CatalogView').controller('NewCatalogViewCtl',['$http','$state','DomainConfig',function CatalogViewCtl($http,$state,DomainConfig){
   var vm = this;
   //getParentCatalog
   vm.parent_catalog = [
     {
       id:0,
       cate_name:"顶级分类",
       cate_pid:0
     }
   ];
   //在执行 repeat 的时候 ng-model 尚未有值 ,你可以发现空白的那个option中会有一个 value="?"
   // 给一个初始化话的值就好了
   vm.selected = "0";
   vm.input_param = {
     cate_pid:"0",
     cate_name:"",
     cate_title:"",
     cate_keywords:"",
     cate_description:"",
     cate_order:"",
     cate_view:"0",

   };
   vm.submit = function () {
     vm.input_param.cate_pid = vm.selected;
     var req = {
        method: 'POST',
        url: DomainConfig.domain+'admin/api/catagory',
        data:JSON.stringify(vm.input_param),
      };
     $http(req).then(function(response){
       $state.go('DashboardView.catalog');
     }, function(){
     });
   }
   var req = {
      method: 'GET',
      url: DomainConfig.domain+'admin/api/getParentCatalog'
    };
   $http(req).then(function(response){
    vm.parent_catalog = vm.parent_catalog.concat(response.data);
   }, function(){

   });

}]);
//修改分类
angular.module('MyApp.CatalogView').controller('EditCatalogViewCtl',['$http','$state','DomainConfig','$stateParams','PassCatalogParamFactory',function CatalogViewCtl($http,$state,DomainConfig,$stateParams,pasParam){
   var vm = this;
   vm.selected = "0";
   vm.editModel =  pasParam.getter();
   var req = {
      method: 'GET',
      url: DomainConfig.domain+'admin/api/getParentCatalog'
    };
   $http(req).then(function(response){
    vm.parent_catalog = vm.parent_catalog.concat(response.data);
    for (var i = 0; i < vm.parent_catalog.length; i++) {
      var parentModel = vm.parent_catalog[i];
      if (parentModel.id == vm.editModel.cate_pid) {
        console.log("select paraent id is"+parentModel.id);
          //  vm.selected = parentModel.id;
          vm.selected = parentModel.id;

           break;
      }
    }
   }, function(){

   });
   vm.parent_catalog = [
     {
       id:0,
       cate_name:"顶级分类",
       cate_pid:0
     }
   ];
  vm.submit = function () {
    var result =  $("#parent_catalog_selector").val();
    // alert("选中父级pid为"+result+"功能正在开发中 ^_^");
    vm.editModel.cate_pid = result;
    var req = {
       method: 'PATCH',
       url: DomainConfig.domain+'admin/api/catagory/'+vm.editModel.id,
       data:JSON.stringify(vm.editModel)
     };
    $http(req).then(function(response){
      // console.log(response);
      $state.go('DashboardView.catalog');
    }, function(){

    });

  }
}]);
