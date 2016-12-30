/**
 * Created by Ronaldinho on 15/8/27.
 * 过滤器
 */
'use strict';
//引用模块
angular.module('MyApp')
.filter('error',function (Errors){
  //将Errors和customMessages合并到一起 作为查阅源 customMessages中的同名属性会覆盖Errros中的
   return function(name,customMessages){
     var errors = angular.extend({},Errors,customMessages);
     return errors[name] || name;
   };
 });
 angular.module('MyApp')
 .filter('success',function (){
    return function(name){
      return "nice";
    };
  });
