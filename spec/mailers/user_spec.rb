require "rails_helper"
include ActiveJob::TestHelper

RSpec.describe UserMailer, type: :mailer do
  let(:user){ create(:user) }

  it 'send account activation mail job is created' do
    ActiveJob::Base.queue_adapter = :test
    expect {
      UserMailer.account_activation(user, user.activation_token).deliver_later
    }.to have_enqueued_job.on_queue('mailers')
  end

  it 'account activation email is sent' do
    expect {
      perform_enqueued_jobs do
        UserMailer.account_activation(user, user.activation_token).deliver_later
      end
    }.to change { ActionMailer::Base.deliveries.size }.by(1)
  end

  it 'account activation email is sent to the right user' do
    perform_enqueued_jobs do
      UserMailer.account_activation(user, user.activation_token).deliver_later
    end

    mail = ActionMailer::Base.deliveries.last
    expect(mail.to[0]).to eq user.email
  end
end
