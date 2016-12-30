angular.module('MyApp.AlertPresent',[]).directive('alertPresent',['$compile','$http','DomainConfig',
    function($compile,$http,DomainConfig){
        return {
            restrict: 'A',
            link: function(scope, element, attrs, fn) {
              var templateScope;
              if (!templateScope) {
                  templateScope = scope.$new();
              }
              templateScope.$message = "初始化";
              var currentTemplate =   'src/AlertPresent/alertModel.html';
              scope.$watchCollection(attrs.alertPresent,function(options){//监听标签上的值
                  if (!options) {
                      options = {message:null};
                  }
                  templateScope.$message = options.message;
                  $http.get(currentTemplate).success(function(indicatorTemplate){
                      var template = indicatorTemplate;
                      templateElement = $compile(template)(templateScope);
                      element.append(templateElement);
                  }).error(function(data){
                      throw new Error('Template specified for AlertPresent ('+currentTemplate+') could not be loaded. ' + data);
                  });
              },true);
            }
        };
    }
]);
angular.module('MyApp.AlertPresent').service('alertPresentService',['$rootScope',function($rootScope){
      this.prompt = function(message,defaultValue,title,secret){
          $rootScope.alertPresentValue.message = message;
          $rootScope.alertPresentValue.title = title;
          $('#alertPresentModal').modal('show');
      };
    }
]
);
