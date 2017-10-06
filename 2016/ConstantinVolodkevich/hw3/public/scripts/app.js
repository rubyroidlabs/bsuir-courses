var routerApp = angular.module('routerApp', ['ui.router', 'routerApp.mainController', 'routerApp.loginController', 'routerApp.historyController']);


routerApp.config(function($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/');

    $stateProvider

        .state('phrases', {
            url: '/phrases',
            templateUrl: 'partial-home.html',
            controller: 'mainController'

        })

        .state('login', {
            url: '/login',
            templateUrl: 'login.html',
            controller: 'loginController'
        })

        .state('history', {
            url: '/phrase/history',
            templateUrl: 'history.html',
            controller: 'historyController'
        });


});

