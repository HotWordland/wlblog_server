/**
 * Created by Ronaldinho on 15/8/27.
 */
'use strict';

angular.module('MyApp.LoginView', ['ui.router'])


    .config(
    [          '$stateProvider', '$urlRouterProvider',
        function ($stateProvider, $urlRouterProvider) {

            $stateProvider
                .state("LoginView",{
                    url:'/login',
                    //angularUI的路由写�? views分别对应index 中的ui-view="name"
                    views:{
                        'main':{
                            templateUrl:'src/LoginView/LoginView.html',
                            controller: ['$scope','$state','$rootScope','$http','cfpLoadingBar','LmUser','DomainConfig',
                                function ($scope,$state,$rootScope,$http,cfpLoadingBar,lmuser,DomainConfig) {
                                  $scope.responseMsg = '';
                                  $scope.responseCode = 0;
                                  $scope.inputuser = {
                                    username: lmuser.username,
                                    password: lmuser.password,
                                  };
                                  $scope.login = function(){

                                    cfpLoadingBar.start();
                                    var req = {
                                       method: 'POST',
                                       url: DomainConfig.domain + 'admin/api/login',
                                       data:JSON.stringify({
                                         name:$scope.inputuser.username,
                                         pwd:$scope.inputuser.password
                                       }),
                                     };
                                      $http(req).then(function(response){
                                        cfpLoadingBar.complete();
                                        $scope.responseMsg = response.data.msg
                                        $scope.responseCode = response.data.status;
                                        if (response.data.status=="200") {
                                          //赋值给单例的user对象
                                          lmuser.username = $scope.inputuser.username;
                                          lmuser.token = response.data.data.token;
                                          lmuser.isLogin = true;
                                          localStorage.setItem('lightRecord_user',angular.toJson(lmuser));
                                          $state.go('DashboardView.intro');
                                        }
                                        console.log(response);

                                      }, function(){

                                      });
                                  }
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
);
