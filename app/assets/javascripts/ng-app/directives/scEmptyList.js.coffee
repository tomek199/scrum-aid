scrumAid.directive 'scEmptyList', [
  () ->
    restrict: 'E'
    template: '<div class="alert alert-warning" ng-hide="hide"><span class="glyphicon glyphicon-warning-sign"></span> The list is empty</div>'
    link: (scope, elem, attr) ->
      scope.$watch (->
        attr.list
      ), (list) ->
        scope.hide = (list? and list.length > 2)
]