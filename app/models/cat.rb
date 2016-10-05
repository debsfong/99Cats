class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: %w(black white brown calico gray tan orange rainbow),
    message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: %w(M F),
    message: "%{value} is not a valid sex" }

  has_many :cat_rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest,
    dependent: :destroy

  def age
    now = Time.now.utc.to_date
    now.year - self.birth_date.year
  end


end

# Cat.create(birth_date: "2010/02/10", color: "black", name: 'HAHAHAH', sex: 'M', description: 'Alright cat!')
