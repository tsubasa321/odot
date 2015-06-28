class User < ActiveRecord::Base
	has_secure_password

	validates :email, presence: true, 
					  uniqueness: true,
					  format: 
					  {
					  	with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
					  }

	before_validation :downcase_email

	#attr_accessor :password, :password_confirmation

	private
	def downcase_email
		self.email = email.downcase if self.email.present?
	end
end
