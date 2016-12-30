/**
 * Created by Ronaldinho on 15/8/27.
 */
'use strict';

angular.module('MyApp.DashboardView', ['ui.router'])

    .config(
    [          '$stateProvider', '$urlRouterProvider',
        function ($stateProvider, $urlRouterProvider) {

            $stateProvider
                .state("DashboardView",{
                    url:'/DashboardView',
                    //angularUI的路由写�? views分别对应index 中的ui-view="name"
                    views:{
                        'main':{
                            templateUrl:'src/View/DashboardView/DashboardView.html',
                            controller: ['$scope','$rootScope','$http','$timeout','DomainConfig',
                                function ($scope,$rootScope,$http,$timeout,DomainConfig) {
                                  $scope.page_container = {
                                    "min-height":window.innerHeight
                                  };
                                  $scope.showCotent = {
                                    "opacity":"0"

                                  };
                                  setTimeout(function () {
                                    $scope.showCotent = {
                                      "opacity":"1"

                                    };

                                  }, 500);
                                  console.log("DashboardView show");
                                    $scope.user = $rootScope.user;
                                    $scope.getFormData = function () {
                                        console.log($scope.userinfo);
                                    }
                                    $scope.setFormData = function () {
                                        $scope.userinfo.email = "123456@qq.com";

                                    }
                                }]

                        }
                    }
                })
                .state("DashboardView.intro",{
                    url:'/intro',
                    //angularUI的路由写�? views分别对应index 中的ui-view="name"
                    views:{
                        'segmentContainer':{
                            templateUrl:'src/View/IntroView/IntroView.html',
                            controller:'IntroViewCtl as vm'
                        }
                    }
                })
                .state("DashboardView.catalog",{
                    url:'/catalog',
                    //angularUI的路由写�? views分别对应index 中的ui-view="name"
                    views:{
                        'segmentContainer':{
                            templateUrl:'src/View/CatalogView/CatalogView.html',
                            controller:'CatalogViewCtl as vm'
                        }
                    }
                })
                .state("DashboardView.newcatalog",{
                    url:'/newcatalog',
                    views:{
                        'segmentContainer':{
                            templateUrl:'src/View/CatalogView/NewCatalogView.html',
                            controller:'NewCatalogViewCtl as vm'
                        }
                    }
                })
                .state("DashboardView.edit_catalog",{
                    url:'/edit_catalog',
                    views:{
                        'segmentContainer':{
                            templateUrl:'src/View/CatalogView/EditCatalogView.html',
                            controller:'EditCatalogViewCtl as vm'
                        }
                    }
                })
                .state("DashboardView.article",{
                    url:'/article',
                    views:{
                        'segmentContainer':{
                            templateUrl:'src/View/ArticleView/ArticleView.html',
                            controller:'ArticleViewCtl as vm'
                        }
                    }
                })
                .state("DashboardView.newarticle",{
                    url:'/newarticle',
                    views:{
                        'segmentContainer':{
                            templateUrl:'src/View/ArticleView/NewArticleView.html',
                            controller:'NewArticleViewCtl as vm'
                        }
                    }
                })
                .state("DashboardView.edit_article",{
                    url:'/edit_article',
                    views:{
                        'segmentContainer':{
                            templateUrl:'src/View/ArticleView/EditArticleView.html',
                            controller:'EditArticleViewCtl as vm'
                        }
                    }
                })

                //edit_article

        }
    ]
)
