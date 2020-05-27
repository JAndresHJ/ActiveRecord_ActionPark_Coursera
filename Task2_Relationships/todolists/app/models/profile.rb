class Profile < ActiveRecord::Base
  belongs_to :user
  
  validate :name_not_null
  validates :gender, inclusion: ['female', 'male']
  validate :custom_validation

  def name_not_null
  	if first_name.blank? && last_name.blank?
		  errors.add(:first_name, "first_name and last_name can not be both null")
  	end
  end

  def custom_validation
  	if gender == 'male' && first_name == 'Sue'
  		errors.add(:first_name, 'A male cannot be named Sue')
  	end
  end

  scope :get_all_profiles, -> (min_birth_year, max_birth_year){
  	Profile.where("birth_year BETWEEN :min_date AND :max_date", min_date: min_birth_year, max_date: max_birth_year).order(:birth_year)
  }
  
end
