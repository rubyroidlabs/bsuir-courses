/*jshint esversion: 6 */
var gameApp = angular.module('routerApp.mainController',['ngAnimate', 'ui.bootstrap','pusher-angular']);



gameApp.controller('mainController', ['$scope','$pusher', '$http','$rootScope', '$window', '$filter', '$state',
    function ($scope,$pusher, $http, $rootScope, $window, $filter, $state) {

        $rootScope.user_name = $window.localStorage.user;
        $rootScope.logged = $window.localStorage.logged;

    if (typeof $rootScope.subscribed == 'undefined'){
        $rootScope.client = new Pusher('1404da432444b8f9e7aa', {
                cluster: 'eu',
                encrypted: true
            });
        $rootScope.pusher = $pusher($rootScope.client);

            var channel = $rootScope.pusher.subscribe('messages');
        $rootScope.subscribed = true;

        channel.bind('my_event',
            function(data) {
                $http.get('/phrases')
                    .success(function(data) {
                        data.forEach(function(item){
                            if(item.last_user != $window.localStorage.user){
                                item.editable = true
                            }else{
                                item.editable = false
                            }
                        });
                        $scope.phrases = data;
                    })
            }
        );

        }

       $http.get('/phrases')
            .success(function(data) {
               data.forEach(function(item){
                   if(item.last_user != $window.localStorage.user){
                        item.editable = true;
                   }else{
                       item.editable = false;
                   }
               });
                $scope.phrases = data;

            });

        $scope.addWord = function(id) {
            var postData = {'word': $scope.word, 'user': $window.localStorage.user};
            $http.post('api/phrases/' + id + '/words', postData);

        };

        $scope.getHistory = function (id) {
            $rootScope.hitories = [];
            var text = '';
            var phrase = $filter('filter')($scope.phrases, { _id: { $oid: id}})[0];
            phrase.words.forEach(function (word) {
                var time = '(' + word.time.slice(0, -6) + ')';
                var line = {'user_name': word.username, 'time': time, 'text': text, 'last_word': word.text};
                text += word.text + ' ';
                $rootScope.hitories.push(line);
            });
            $rootScope.hitories.reverse();
            $state.go('history');

        };
        $scope.back = function() {
            $state.go('phrases');
        };
    }]);

    gameApp.factory('httpRequestInterceptor', ['$window', function ($window) {
        return {
            request: function (config) {

                config.headers.AUTHORIZATION = $window.localStorage.token;

                return config;
            }
        };
    }]);

gameApp.config(['$httpProvider', function ($httpProvider) {
     $httpProvider.interceptors.push('httpRequestInterceptor');

}]);

gameApp.component('myContent', {
    template: '<button class="btn btn-warning" type="button" ' +
    '          class="btn btn-default" ng-click="$ctrl.open()">' +
    'Add Phrase' +
    '</button>',
    controller: function($uibModal) {
        $ctrl = this;
        $ctrl.dataForModal = {
            name: 'NameToEdit',
            value: 'ValueToEdit'
        };
        $ctrl.open = function() {
            $uibModal.open({
                component: 'myModal',
                resolve: {
                    modalData: function() {
                        return $ctrl.dataForModal;
                    }
                }
            })
        };
    }
});

gameApp.component('myModal', {

    template: `<div class="modal-body"><div>{{$ctrl.greeting}}</div> 
   
    <form name="form">
    <label>First Word</label>
    <input ng-model="phrase.first"  ng-pattern="/^[a-zA-Z,';:-]+$/" required><br> 
    </form>>
   
    <button class="btn btn-info" type="button" ng-click="$ctrl.handleClose()">
    Close
    </button>
    <button class="btn btn-info" type="button" ng-disabled="form.$invalid"
            ng-click="addPhrase();$ctrl.handleDismiss();">
    Add
    </button>
    </div>`,
    bindings: {
        modalInstance: '<',
        resolve: '<'
    },
    controller: ['$scope', '$http', '$window', '$rootScope',
        function($scope, $http, $window) {
        var $ctrl = this;
        $ctrl.modalData = $ctrl.resolve.modalData;
        $ctrl.handleClose = function() {
            $ctrl.modalInstance.close($ctrl.modalData);
        };
        $scope.addPhrase = function() {
            var postData = {'phrase': $scope.phrase,
                            'user': $window.localStorage.user};
            $http.post('api/phrases', postData)
        };
        $ctrl.handleDismiss = function() {
            $ctrl.modalInstance.dismiss('cancel');
        };
    }]
});

