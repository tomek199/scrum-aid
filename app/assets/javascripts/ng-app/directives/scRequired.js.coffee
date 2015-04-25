scrumAid.directive 'scValid', [
  () ->
    restrict: 'A'
    link: (scope, elem, attr) ->
      console.log elem
      scope.$watch (() ->
        attr.scValid
      ), (value) ->
        value = JSON.parse(value)
        if (value.$touched and value.$invalid)
          elem.addClass('has-error')
        else
          elem.removeClass('has-error')
]
