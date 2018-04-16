class Term < ActiveRecord::Base
  def student_count(term)
    student = Student.where(term: term.term_i)
    student.count
  end
end
