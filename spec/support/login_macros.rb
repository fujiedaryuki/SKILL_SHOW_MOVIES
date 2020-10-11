module LoginMacros
  def login_as(user)
    visit new_user_path
    fill_in  '姓', with: 'てすと'
    fill_in  '名', with: 'てすと'
    fill_in  'メールアドレス', with: 'a@example.com'
    fill_in  'パスワード', with: 'password'
    fill_in  'パスワード確認', with: 'password'
    click_button '登録'
  end
end