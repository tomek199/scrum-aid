scrumAid.factory 'CookiesFactory', [
  '$cookies'
  ($cookies) ->

    getUser = () ->
      user = $cookies.currentUser
      if user != undefined && user.length > 0
        return JSON.parse($cookies.currentUser)
      else
        return null

    putUser = (user) ->
      $cookies.currentUser = JSON.stringify(user)

    deleteUser = () ->
      $cookies.currentUser = ""

    {
      getUser: getUser
      putUser: putUser
      deleteUser: deleteUser
    }
]