FactoryBot.define do
  factory :host_user do
    email "jdoe@exapmle.com"
    password "password"
    password_confirmation "password"
    factory :invalid_host_user do
			email nil
		end
  end
end