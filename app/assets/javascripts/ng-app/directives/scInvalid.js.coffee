scrumAid.directive 'scInvalid', [
  () ->
    restrict: 'E'
    replace: true
    template: '<h5 class="text-danger" ng-show="show">{{message}}</h5>'
    scope:
      value: '@'
    link: (scope, elem, attr) ->
      scope.$watch (() ->
        attr.value
      ), (value) ->
        value = JSON.parse(value)
        scope.message = value
        if value.$touched
          if value.$error.required
            scope.message = 'Can\'t be blank'
            scope.show = true
          else if value.$error.email
            scope.message = 'Invalid email'
            scope.show = true
          else
            scope.show = false
]