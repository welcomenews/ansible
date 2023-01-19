FactoryBot.define do 
	factory  :student do 

		name { "John Doe" }
		birthdate { Date.new(1992, 11, 02) }
		sequence(:email) { |n| "person#{n}@example.com"}

		trait :invalid do 
			name nil 
			email nil 
		end 

		trait :changed do 
			name { 'Sherlynn' }
			email { "hi@gmail.com" }
		end
		
		
	end
end
