var gameApp = angular.module('routerApp.loginController', []);

gameApp.controller('loginController', ['$scope', '$http','$window','$rootScope',
    function ($scope,$http,$window, $rootScope) {

    $scope.addUser = function() {
        $http.post('/users', $scope.user);
    };

    $scope.login = function() {
        $http.post('/login', $scope.user)
            .success(function(data){
                $window.localStorage.token = JSON.stringify(data);
                $window.localStorage.user = $scope.user.name;
                $window.localStorage.logged = true;
                $rootScope.userName = $window.localStorage.user;
                $rootScope.logged = $window.localStorage.logged;
            });
    };
}]);
