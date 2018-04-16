class Student < ActiveRecord::Base
  validates :term, presence: true
  validates :family_name, presence: true
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_kana, presence: true
  validates :first_name_kana, presence: true
  has_many :schedules, dependent: :destroy
  
  def name
    "#{family_name} #{first_name}"
  end

  def name_kana
    "#{family_name_kana} #{first_name_kana}"
  end

  def get_student_term(student)
    s_term = student.term
    term = Term.find_by(term_i: s_term)
    term.term_t
  end

end
