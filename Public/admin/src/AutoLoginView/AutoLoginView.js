/**
 * Created by Ronaldinho on 15/8/27.
 */
'use strict';

angular.module('MyApp.AutoLoginView', ['ui.router'])


    .config(
    [          '$stateProvider', '$urlRouterProvider',
        function ($stateProvider, $urlRouterProvider) {

            $stateProvider
                .state("AutoLoginView",{
                    url:'/autologin',
                    //angularUI的路由写�? views分别对应index 中的ui-view="name"
                    views:{
                        'main':{
                            templateUrl:'src/AutoLoginView/AutoLoginView.html',
                            controller: ['$scope','$state','$rootScope','LmUser','cfpLoadingBar','$timeout',
                                function ($scope,$state,$rootScope,lmuser,cfpLoadingBar,$timeout) {
                                  console.log('autologin access');
                                  cfpLoadingBar.start();
                                  $timeout(function(){
                                  console.log('执行$timeout回调');
                                  cfpLoadingBar.complete();
                                  lmuser.isLogin = true;
                                  $state.go('DashboardView.catalog');
                                  },3000);
                                }]
                        }
                        ,
                        'bottomTitle':{
                            template:'BottomTitle:{{userinfo.email}}',
                            controller:['$scope',function($scope){
                                $scope.userinfo={
                                    email: "454763196@qq.com",
                                    password: "123456",
                                    autoLogin: true
                                }
                            }]
                        }
                    }
                })
        }
    ]
)

    .directive('supplement',function(){
        return {
            restrict:'E',
            transclude:true,
            templateUrl:'FirstView/supplement.html',
            link:function(scope,element,attrs){
                //alert('执行了link function');
                //var bg = document.body||document.documentElement;
                //bg.style.background = "url('')";
            }
        };
    });
