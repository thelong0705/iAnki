namespace :update_default_locale_for_user do
  desc "Update default locale for user"
  task :update_user => :environment do
    User.where(locale: nil).update_all(locale: 'en')
  end
end
