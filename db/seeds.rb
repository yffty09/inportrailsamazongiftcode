
# 管理者アカウントの作成
administrator = Administrator.find_or_initialize_by(email: 'mt.fuji1009@gmail.com')
administrator.password = 'password'
administrator.password_confirmation = 'password'
administrator.save!

puts 'Administrator has been created successfully!'
