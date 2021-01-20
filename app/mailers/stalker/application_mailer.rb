# frozen_string_literal: true

class Stalker::ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
