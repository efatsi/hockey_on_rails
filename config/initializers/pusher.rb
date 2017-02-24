require 'pusher'

Pusher.app_id    = '306384'
Pusher.key       = 'd76fc30734232469f535'
Pusher.secret    = 'e3d9aa7f9d367129d0d1'
Pusher.logger    = Rails.logger
Pusher.encrypted = true

# Example
# Pusher.trigger('my-channel', 'my-event', {
#   message: 'hello world'
# })
