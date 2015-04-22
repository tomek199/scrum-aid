scrumAid.factory 'DeviseFactory', [
  '$resource', '$cookies'
  ($resource, $cookies) ->

    # Sign up resource
    signUpResource = $resource '/users.json', {},
      post:
        method: 'POST'
        isArray: false

    # Sign in resource
    signInResource = $resource '/users/sign_in.json', {},
      post:
        method: 'POST'
        isArray: false

    # Sign out resource
    signOutResource = $resource '/users/sign_out.json', {},
      delete:
        method: 'DELETE'
        isArray: false

    # Save signed in user data to cookie
    saveUser = (user) ->
      $cookies.currentUser = JSON.stringify(user)

    # Delete signed out user from cookie
    deleteUser = () ->
      $cookies.currentUser = ""

    # Sign up API
    signUp = (user, success, error) ->
      signUpResource.post(user: user).$promise.then(
        (response) ->
          if !response.errors?
            saveUser(response)
            success(currentUser())
          else
            error(response.errors)
        (response) ->
          error(response)
      )

    # Sign in API
    signIn = (user, success, error) ->
      signInResource.post(user:user).$promise.then(
        (response) ->
          if !response.error?
            saveUser(response)
            success(currentUser())
          else
            error(response.error)
        (reponse) ->
          error(response)
      )

    # Sign out API
    signOut = (success, error) ->
      signOutResource.delete().$promise.then(
        (response) ->
          deleteUser()
          success()
        (response) ->
          error(response)
      )
    # Current user API
    currentUser = () ->
      user = $cookies.currentUser
      if user != undefined && user.length > 0
        return JSON.parse($cookies.currentUser)
      else
        return null

    # Is authenticated API
    isAuthenticated = () ->
      !!$cookies.currentUser


    # API return
    {
      signUp: signUp
      signIn: signIn
      signOut: signOut
      currentUser: currentUser
      isAuthenticated: isAuthenticated
    }
]
