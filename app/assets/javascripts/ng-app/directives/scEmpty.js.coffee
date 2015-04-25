scrumAid.directive 'scEmpty', [
  () ->
    restrict: 'E'
    replace: true
    template: '<em class="text-muted" ng-hide="hide">Empty</em>'
    scope:
      value: '@'
    link: (scope, elem, attr) ->
      scope.hide = !(attr.value? and attr.value.length == 0)
]
