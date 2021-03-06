module "Core Fauxjax Functionality Tests",
  beforeEach: ->
    @defaultSettings = _.clone($.fauxjax.settings)
  afterEach: ->
    $.fauxjax.clear()
    $.fauxjax.settings = @defaultSettings

test "Fauxjax default settings", (assert) ->
  assert.ok(_.isEqual(@defaultSettings, $.fauxjax.settings))
  assert.equal($.fauxjax.settings.status, 200)
  assert.equal($.fauxjax.settings.statusText, "OK")
  assert.equal($.fauxjax.settings.responseTime, 0)
  assert.equal($.fauxjax.settings.isTimeout, false)
  assert.equal($.fauxjax.settings.content, '')
  assert.ok(_.isEqual($.fauxjax.settings.headers, {}))

test "Success callback should have access to xhr object", (assert) ->
  done = assert.async()

  $.fauxjax.new
    request:
      method: "GET"
      url: "/faux-request"
    response:
      status: 200

  $.ajax
    method: "GET"
    url: "/faux-request"
    success: (data, textStatus, xhr) ->
      assert.ok(xhr, "No xhr object passed to success")
      assert.ok(xhr.status is 200, "xhr does not have the proper status code")
      done()
    error: (xhr, textStatus) ->
      assert.ok(false, "Request should have been successfully faked")
      done()

  return true
