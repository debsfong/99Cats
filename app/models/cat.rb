class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: %w(black white brown calico gray tan orange rainbow),
    message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: %w(M F),
    message: "%{value} is not a valid sex" }

  def age
    now = Time.now.utc.to_date
    now.year - self.birth_date.year
    # -
    #   ((now.month > birth_date.month ||
    #   (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
  end


end

Cat.create(birth_date: "2010/02/10", color: "red", name: 'Browniw', sex: 'X', description: 'Alright cat!')
