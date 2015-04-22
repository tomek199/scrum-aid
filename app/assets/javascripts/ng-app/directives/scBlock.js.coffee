scrumAid.directive "scBlock", [
  '$http'
  ($http) ->
    restrict: "E"
    templateUrl: "directives/scBlock.html"
    link: (scope) ->
      scope.$watch (->
        $http.pendingRequests.length
      ), (pendingRequests) ->
        if pendingRequests > 0
          scope.isPending = true
        else
          scope.isPending = false
]
