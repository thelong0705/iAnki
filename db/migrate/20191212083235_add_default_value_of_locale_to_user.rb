class AddDefaultValueOfLocaleToUser < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :locale, from: nil, to: 'en'
  end
end
