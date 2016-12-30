var usermodule = angular.module('MyApp.User',[]);

usermodule.service('LmUser', function(){
  this.username = "";
  this.phone = "";
  this.email = "";
  this.password = "";
  this.intro = "";
  this.token = "";
  this.isLogin = false;
});
