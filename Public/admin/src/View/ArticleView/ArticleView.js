'use strict';
//文章展示
angular.module('MyApp.ArticleView',[]).controller('ArticleViewCtl',['$http','DomainConfig','$state','PassCatalogParamFactory',function CatalogViewCtl($http,DomainConfig,$state,pasParam){
   var vm = this;
   vm.articles = [];
   var req = {
      method: 'GET',
      url: DomainConfig.domain+'admin/api/article'
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
        url: DomainConfig.domain+'admin/api/article'
      };
     vm.promise = $http(req).then(function(response){
       vm.articles = response.data
     }, function(){

     });
   };
   vm.toEditarticle = function (editModel) {
     editModel.catagory_id = parseInt(editModel.catagory_id);
     pasParam.setter(editModel);
     $state.go('DashboardView.edit_article');
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

   vm.loadData();

}]);
//传参
angular.module('MyApp.ArticleView').factory('PassArticleParamFactory', function () {
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

angular.module('MyApp.ArticleView').controller('NewArticleViewCtl',['$http','DomainConfig','$state','PassCatalogParamFactory','FileUploader','alertPresentService',function CatalogViewCtl($http,DomainConfig,$state,pasParam,FileUploader,alertPresentService){
   var vm = this;
  vm.catalogs = [];
  vm.selected = "0";
  vm.delay = 0;
	vm.minDuration = 0;
	vm.message = '处理中';
	vm.backdrop = true;
	vm.promise = null;
  var uploadImagePath = "";
  // create a input param object
  vm.input_param = {
     art_title:"",
     art_content:"",
     art_description:"",
     art_keywords:"",
     art_tag:"",
     art_thumb:"",
     art_time:"",
     art_editor:"",
     art_view:"",
     catagory_id:""

  }
  //submit action
  vm.submit = function () {
    var ue = UE.getEditor('editor');
    if (!ue.getContentTxt()) {
      // alert('无编辑内容');
      // $('#myModal').modal('show');
      alertPresentService.prompt('编辑内容不能为空','','提示');
      return;
    }
    vm.input_param.art_content = ue.getContent();
    vm.input_param.catagory_id = vm.selected;
    vm.input_param.catagory_id = parseInt(vm.input_param.catagory_id);
    var req = {
       method: 'POST',
       url: DomainConfig.domain+'admin/api/article',
       data:JSON.stringify(vm.input_param),
     };
    $http(req).then(function(response){
      $state.go('DashboardView.article');
    }, function(){
    });

  }
	// vm.promise = $http.get('http://httpbin.org/delay/3');
   vm.loadData = function () {
     var req = {
        method: 'GET',
        url: DomainConfig.domain+'admin/api/catagory'
      };
     vm.promise = $http(req).then(function(response){
       vm.catalogs = response.data
       var fristModel = vm.catalogs[0];
       vm.selected = fristModel.id.toString();
     }, function(){

     });
   };
   vm.loadData();



var uploader = vm.uploader = new FileUploader({
url: 'https://www.codercq.com/wlblogUpload.php'
});

// FILTERS

uploader.filters.push({
    name: 'imageFilter',
    fn: function(item /*{File|FileLikeObject}*/, options) {
        var type = '|' + item.type.slice(item.type.lastIndexOf('/') + 1) + '|';
        return '|jpg|png|jpeg|bmp|gif|'.indexOf(type) !== -1;
    }
});

// CALLBACKS

uploader.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/, filter, options) {
    console.info('onWhenAddingFileFailed', item, filter, options);
};
uploader.onAfterAddingFile = function(fileItem) {
  if(uploader.queue.length > 1){
        uploader.queue.splice(0, uploader.queue.splice.length -1);
    }
    console.info('onAfterAddingFile', fileItem);
};
uploader.onAfterAddingAll = function(addedFileItems) {
    console.info('onAfterAddingAll', addedFileItems);
};
uploader.onBeforeUploadItem = function(item) {
    console.info('onBeforeUploadItem', item);
};
uploader.onProgressItem = function(fileItem, progress) {
    console.info('onProgressItem', fileItem, progress);
};
uploader.onProgressAll = function(progress) {
    console.info('onProgressAll', progress);
};
uploader.onSuccessItem = function(fileItem, response, status, headers) {
    console.info('onSuccessItem', fileItem, response, status, headers);
};
uploader.onErrorItem = function(fileItem, response, status, headers) {
    console.info('onErrorItem', fileItem, response, status, headers);
};
uploader.onCancelItem = function(fileItem, response, status, headers) {
    console.info('onCancelItem', fileItem, response, status, headers);
};
uploader.onCompleteItem = function(fileItem, response, status, headers) {
    if (response) {
      if (response["status"]) {
        vm.input_param.art_thumb = DomainConfig.wlblog_upload_domain+response["path"];
      }
    }
    console.info('onCompleteItem', fileItem, response, status, headers);
};
uploader.onCompleteAll = function() {
    console.info('onCompleteAll');
};

console.info('uploader', uploader);
}]);
angular.module('MyApp.ArticleView').controller('EditArticleViewCtl',['$http','DomainConfig','$state','PassCatalogParamFactory','FileUploader','alertPresentService',function CatalogViewCtl($http,DomainConfig,$state,pasParam,FileUploader,alertPresentService){
   var vm = this;
  vm.catalogs = [];
  vm.selected = "0";
  vm.editModel =  pasParam.getter();
  vm.delay = 0;
	vm.minDuration = 0;
	vm.message = '处理中';
	vm.backdrop = true;
	vm.promise = null;
  var uploadImagePath = "";
  // create a input param object
  vm.input_param = {
     art_title:"",
     art_content:"",
     art_description:"",
     art_keywords:"",
     art_tag:"",
     art_thumb:"",
     art_time:"",
     art_editor:"",
     art_view:"",
     catagory_id:""

  }
  //submit action
  vm.submit = function () {
    var ue = UE.getEditor('editor');
    if (!ue.getContentTxt()) {
      // alert('无编辑内容');
      // $('#myModal').modal('show');
      alertPresentService.prompt('编辑内容不能为空','','提示');
      return;
    }
    vm.input_param.art_content = ue.getContent();
    vm.input_param.catagory_id = vm.selected;
    vm.input_param.catagory_id = parseInt(vm.input_param.catagory_id);
    var req = {
       method: 'POST',
       url: DomainConfig.domain+'admin/api/article',
       data:JSON.stringify(vm.input_param),
     };
    $http(req).then(function(response){
      $state.go('DashboardView.article');
    }, function(){
    });

  }
	// vm.promise = $http.get('http://httpbin.org/delay/3');
   vm.loadData = function () {
     var req = {
        method: 'GET',
        url: DomainConfig.domain+'admin/api/catagory'
      };
     vm.promise = $http(req).then(function(response){
       vm.catalogs = response.data
       var fristModel = vm.catalogs[0];
       vm.selected = fristModel.id.toString();
     }, function(){

     });
   };
   vm.loadData();



var uploader = vm.uploader = new FileUploader({
url: 'https://www.codercq.com/wlblogUpload.php'
});

// FILTERS

uploader.filters.push({
    name: 'imageFilter',
    fn: function(item /*{File|FileLikeObject}*/, options) {
        var type = '|' + item.type.slice(item.type.lastIndexOf('/') + 1) + '|';
        return '|jpg|png|jpeg|bmp|gif|'.indexOf(type) !== -1;
    }
});

// CALLBACKS

uploader.onWhenAddingFileFailed = function(item /*{File|FileLikeObject}*/, filter, options) {
    console.info('onWhenAddingFileFailed', item, filter, options);
};
uploader.onAfterAddingFile = function(fileItem) {
  if(uploader.queue.length > 1){
        uploader.queue.splice(0, uploader.queue.splice.length -1);
    }
    console.info('onAfterAddingFile', fileItem);
};
uploader.onAfterAddingAll = function(addedFileItems) {
    console.info('onAfterAddingAll', addedFileItems);
};
uploader.onBeforeUploadItem = function(item) {
    console.info('onBeforeUploadItem', item);
};
uploader.onProgressItem = function(fileItem, progress) {
    console.info('onProgressItem', fileItem, progress);
};
uploader.onProgressAll = function(progress) {
    console.info('onProgressAll', progress);
};
uploader.onSuccessItem = function(fileItem, response, status, headers) {
    console.info('onSuccessItem', fileItem, response, status, headers);
};
uploader.onErrorItem = function(fileItem, response, status, headers) {
    console.info('onErrorItem', fileItem, response, status, headers);
};
uploader.onCancelItem = function(fileItem, response, status, headers) {
    console.info('onCancelItem', fileItem, response, status, headers);
};
uploader.onCompleteItem = function(fileItem, response, status, headers) {
    if (response) {
      if (response["status"]) {
        vm.input_param.art_thumb = DomainConfig.wlblog_upload_domain+response["path"];
      }
    }
    console.info('onCompleteItem', fileItem, response, status, headers);
};
uploader.onCompleteAll = function() {
    console.info('onCompleteAll');
};

console.info('uploader', uploader);
}]);
