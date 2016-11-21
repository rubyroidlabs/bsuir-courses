var gameApp = angular.module('routerApp.mainController',['ngAnimate', 'ui.bootstrap','pusher-angular']);



gameApp.controller('mainController', ['$scope','$pusher', '$http','$rootScope', '$window', '$filter', '$state',
    function ($scope,$pusher, $http, $rootScope, $window, $filter, $state) {

    console.log($window.localStorage['user'])


    if (typeof $rootScope.subscribed == 'undefined'){
        $rootScope.client = new Pusher('1404da432444b8f9e7aa', {
                cluster: 'eu',
                encrypted: true
            });
        $rootScope.pusher = $pusher($rootScope.client);

            console.log('im here')
            var channel = $rootScope.pusher.subscribe('messages');
        $rootScope.subscribed = true

        channel.bind('my_event',
            function(data) {
                $http.get('/phrases')
                    .success(function(data) {
                        data.forEach(function(item){
                            if(item.last_user != $window.localStorage['user']){
                                item['editable'] = true
                            }else{
                                item['editable'] = false
                            }
                        })
                        $scope.phrases = data;
                        console.log($scope.phrases)
                        console.log("recieved updated array!")
                    })
            }
        );

        }

       $http.get('/phrases')
            .success(function(data) {
               data.forEach(function(item){
                   if(item.last_user != $window.localStorage['user']){
                        item['editable'] = true
                   }else{
                       item['editable'] = false
                   }
               })
                $scope.phrases = data;

            })

        $scope.addWord = function(id) {
            console.log($scope.word)
            var postData = {'word': $scope.word, 'user': $window.localStorage['user']};
            $http.post('api/phrases/' + id + '/words', postData)

        };

        $scope.getHistory = function (id) {
            $rootScope.hitories = [];
            var text = '';
            var phrase = $filter('filter')($scope.phrases, { _id: { $oid: id}})[0];
            phrase.words.forEach(function (word) {
                var time = word.time.slice(0, -6)
                text += word.text + ' ';
                var line = word.username + ' (' + time + ') "' + text + '"';
                $rootScope.hitories.push(line)
            })
            $rootScope.hitories.reverse()
            $state.go('history')

        }
    }]);

    gameApp.factory('httpRequestInterceptor', ['$window', function ($window) {
        return {
            request: function (config) {

                config.headers['AUTHORIZATION'] = $window.localStorage['token'];

                return config;
            }
        };
    }]);

gameApp.config(["$httpProvider", function ($httpProvider) {
     $httpProvider.interceptors.push('httpRequestInterceptor');



}]);

gameApp.component('myContent', {
    template: '<button type="button" class="btn btn-default" ng-click="$ctrl.open()">Add Phrase</button>',
    controller: function($uibModal, $scope) {
        $ctrl = this;
        $ctrl.dataForModal = {
            name: 'NameToEdit',
            value: 'ValueToEdit'
        };
        $ctrl.open = function() {
            $uibModal.open({
                component: "myModal",
                resolve: {
                    modalData: function() {
                        return $ctrl.dataForModal;
                    }
                }
            }).result.then(function(result) {

                console.info("I was closed.  Result was->");
                console.info(result);
            }, function(reason) {
                console.info("I was dimissed. Reason was->" + reason);
            });
        };
    }
});

gameApp.component('myModal', {
    template: `<div class="modal-body"><div>{{$ctrl.greeting}}</div>     
    <label>First Word</label> <input ng-model="phrase.first"><br>    
    <button class="btn btn-warning" type="button" ng-click="$ctrl.handleClose()">Close</button>
    <button class="btn btn-warning" type="button" ng-click="addPhrase();$ctrl.handleDismiss();">Add</button>
    </div>`,
    bindings: {
        modalInstance: "<",
        resolve: "<"
    },
    controller: ['$scope', '$http', '$window', function($scope, $http, $window) {
        var $ctrl = this;
        $ctrl.modalData = $ctrl.resolve.modalData;
        $ctrl.handleClose = function() {
            console.info("in handle close");
            $ctrl.modalInstance.close($ctrl.modalData);
        };
        $scope.addPhrase = function() {
            var postData = {'phrase': $scope.phrase, 'user': $window.localStorage['user']};
            $http.post('api/phrases', postData)
        };
        $ctrl.handleDismiss = function() {
            console.info("in handle dismiss");
            $ctrl.modalInstance.dismiss("cancel");
        };
    }]
});

