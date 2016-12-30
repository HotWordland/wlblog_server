/**
 * Created by Ronaldinho on 15/8/27.
 * 常量
 */
'use strict';
//引用模块
angular.module('MyApp')
.constant('Errors',{
    email:'不是有效的邮箱类型',
    required:'此项不能为空',
    same:'此项必须与上一项相同',
    number:'此项必须为数字',
    min:'不能比最小值更小'
 });
