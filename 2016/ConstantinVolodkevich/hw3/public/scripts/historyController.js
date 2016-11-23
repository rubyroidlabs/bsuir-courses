var gameApp = angular.module('routerApp.historyController', []);

gameApp.controller('historyController', ['$scope', '$state',
    function ($scope, $state) {

    $scope.back = function() {
        $state.go('phrases')
    };
}]);