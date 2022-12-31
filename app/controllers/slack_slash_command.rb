# frozen_string_literal: true

require "net/http"
require_relative "../model/slack_dialog"

module SlackSlashCommand
  def run(request)
    # get slack trigger id from request
    req = URI.decode_www_form(request.body.read)
    trigger_id = req.assoc("trigger_id").last

    # dialog form
    slack_dialog = SlackDialog.new

    # https://github.com/slack-ruby/slack-ruby-client/blob/master/lib/slack/web/api/endpoints/dialog.rb
    client = Slack::Web::Client.new(token: ENV.fetch("SLACK_TOKEN"))
    client.dialog_open(trigger_id: trigger_id,
                       dialog: slack_dialog.post_body)
  end

  module_function :run
end
