#to fix possible error in testing that I have not had yet

if Rails.env.test?
	CarrierWave.configure do |config|
		config.enable_processing = false
	end
end