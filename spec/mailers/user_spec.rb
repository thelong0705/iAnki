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

  it 'send password mail job is created' do
    ActiveJob::Base.queue_adapter = :test
    user.create_reset_digest
    expect {
      UserMailer.password_reset(user, user.reset_token).deliver_later
    }.to have_enqueued_job.on_queue('mailers')
  end

  it 'account activation email is sent' do
    expect {
      perform_enqueued_jobs do
        UserMailer.account_activation(user, user.activation_token).deliver_later
      end
    }.to change { ActionMailer::Base.deliveries.size }.by(1)
  end

  it 'password reset email is sent' do
    user.create_reset_digest
    expect {
      perform_enqueued_jobs do
        UserMailer.password_reset(user, user.reset_token).deliver_later
      end
    }.to change { ActionMailer::Base.deliveries.size }.by(1)
  end

  [:en, :jp].each do |locale|
    context "after sending email" do
      let(:mail) {
        user.locale = locale
        perform_enqueued_jobs do
          UserMailer.account_activation(user, user.activation_token).deliver_later
        end
        ActionMailer::Base.deliveries.last
      }

      before do
        I18n.locale = user.locale
      end

      it 'account activation email is sent to the send right user' do
        expect(mail.to[0]).to eq user.email
      end

      it 'renders the subject' do
        expect(mail.subject).to eq(I18n.t(:account_activation))
      end

      it 'renders the name correctly' do
        expect(mail.body.encoded).to match(user.name)
      end

      it 'renders activation token correctly' do
        expect(mail.body.encoded).to match(user.activation_token)
      end

      it 'renders body correctly' do
        expect(mail.body.encoded).to match(I18n.t(:email_welcome))
      end
    end
  end

end
