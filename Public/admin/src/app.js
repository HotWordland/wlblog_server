/**
 * Created by Ronaldinho on 15/8/27.
 */
'use strict';

// Declare app level module which depends on views, and components
angular.module('MyApp', ['ngAnimate',
    'ui.router','anim-in-out','angular-loading-bar','cgBusy','MyApp.formVaild','MyApp.ngthumb','ngSanitize','angularFileUpload','MyApp.AlertPresent','MyApp.LoginView','MyApp.User',
    'MyApp.AutoLoginView','MyApp.IntroView','MyApp.CatalogView','MyApp.ArticleView','MyApp.DashboardView'
])
    .run(['$rootScope', '$state', '$stateParams','LmUser',function($rootScope,   $state,   $stateParams,lmuser){
      //alertPresentService 内容
      $rootScope.alertPresentValue = {
        message:null,
        title:null,        
      };
        //窗口情况
        //ui-route过渡 动画配置 详情 https://github.com/homerjam/angular-ui-router-anim-in-out
        $rootScope.ctrl = {};
        $rootScope.ctrl.initEnd = false;//控制内容 侧边栏 顶部bar 的显示(初始化的时候由于结构会在login的时候先显示出来)
        $rootScope.ctrl.speed = 500;
        $rootScope.ctrl.mainViewStyle = 'anim-fade';
        $rootScope.ctrl.page1Style = 'anim-zoom-out';
        $rootScope.ctrl.page2Style = 'anim-slide-below-fade';
        $rootScope.$on('animStart', function() {
              console.log('animStart');
          });
        $rootScope.$on('animEnd', function() {
              if (!$rootScope.ctrl.initEnd) {
                $rootScope.ctrl.initEnd = true;
              }
              console.log('animEnd');
          });

        $rootScope.$on("emitSignupLoginSuccess",
              function (event, model) {
                $rootScope.$broadcast("notiSignupLoginSuccess",model);
                });

        $rootScope.$state = $state;
        $rootScope.$stateParams = $stateParams;
        var userinfo_json = localStorage.getItem('lightRecord_user');//获取之前登录的值，localstorge储存
        var userinfo = angular.fromJson(userinfo_json);
        if (userinfo) {
          lmuser.username = userinfo.username;
          lmuser.isLogin = userinfo.isLogin;
          lmuser.token = userinfo.token;
          $rootScope.ctrl.initEnd = true;
        }
        $rootScope.$on('$stateChangeStart',function(event, toState, toParams, fromState, fromParams){
          // alert('run route listen');
        	if(toState.name=='LoginView'||toState.name=='SignupView'||toState.name=='AutoLoginView')return;// 如果是进入登录界面则允许
        	// 如果用户不存在
        	if(!lmuser.username){
        		event.preventDefault();// 取消默认跳转行为
        		$state.go("LoginView",{from:fromState.name,w:'notLogin'});//跳转到登录界面
        	}else{
            if (lmuser.isLogin) {
              return;
            }
            if (fromState.name=='AutoLoginView'||fromState.name=='LoginView') {
              return;
            }else {
              event.preventDefault();// 取消默认跳转行为
              // $state.go("AutoLoginView",{from:fromState.name,w:'autoLogin'});//跳转自动登录界面
              $state.go("DashboardView.intro",{from:fromState.name,w:'autoLogin'});//跳转自动登录界面
            }

          }
          });
          //监听屏幕的情况
          $(window).resize(function(){
              // alert(window.innerWidth);
              console.log(window.innerWidth);
              $(".MainContainer").css('width',window.innerWidth);
              $(".page-container").css('min-width',window.innerWidth);

          });
              }])
      .factory('authInterceptor', ['$q','LmUser',function ($q,lmuser) { //$http 拦截器
          return {
            request: function (config) {
              config.headers = config.headers || {};
              if (lmuser.token) {
                config.headers.Authorization = lmuser.token;
              }
              return config;
            }
          };
        }])
      .config(['$stateProvider', '$urlRouterProvider','$interpolateProvider','$httpProvider','cfpLoadingBarProvider',
        function ($stateProvider,   $urlRouterProvider,$interpolateProvider,$httpProvider,cfpLoadingBarProvider) {
            cfpLoadingBarProvider.latencyThreshold = 500;
            cfpLoadingBarProvider.includeSpinner = true;
            $httpProvider.interceptors.push('authInterceptor');
            $urlRouterProvider
                .otherwise('/');
                //修改变量解析 与laravel 不冲突
                $interpolateProvider.startSymbol('<%');
                $interpolateProvider.endSymbol('%>');
          }]);
