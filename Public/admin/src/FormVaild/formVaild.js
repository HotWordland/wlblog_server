/**
 * Created by Ronaldinho on 15/8/27.
 * 验证表单字段的一些功能
 */
'use strict';

angular.module('MyApp.formVaild', [])
   .directive('bgFieldError',function bgFieldError($compile){
        return {
            restrict:'A',
            require:'ngModel',
            link:function(scope,element,attrs,ngModel){
                //alert('执行了link function');
                //var bg = document.body||document.documentElement;
                //bg.style.background = "url('')";
                var subScope = scope.$new(true);
                subScope.hasError = function(){
                  return ngModel.$invalid && ngModel.$dirty;
                };
                subScope.errors = function(){
                  return ngModel.$error;
                };
                //计算表达式加入到subScope作用域里 $compile才可以引用其属性
                subScope.customMessages = subScope.$eval(attrs.bgFieldError);
                var hint = $compile('<span  ng-repeat="(name,wrong) in errors()" ng-if="hasError()&&wrong" style="color:red" ><%name|error:customMessages%></span>')(subScope);
                element.after(hint);
            }
        };
    })
    .directive('bfAssertSameAs',function bfAssertSameAs($compile){
         return {
             restrict:'A',
             require:'ngModel',
             link:function(scope,element,attrs,ngModel){
               var isSame = function (value) {
                 var anotherValue = scope.$eval(attrs.bfAssertSameAs);
                 return value === anotherValue;
               };
               ngModel.$parsers.push(function (value) {
                    return value;
                });
              //  ngModel.$parsers.push(function (value) {
              //    ngModel.$setValidity('same',isSame(value));
              //    return isSame(value) ? value : undefined;
              //  });
               ngModel.$validators.same = function (value) {
                    return isSame(value);
                };
               scope.$watch(
                 function () {
                   return scope.$eval(attrs.bfAssertSameAs);
                 },
                 function () {
                    ngModel.$setValidity('same',isSame(ngModel.$modelValue));
                 }
               );
             }
         };
     })
    ;
