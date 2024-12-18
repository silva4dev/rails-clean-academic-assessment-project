require_relative "../app/layers/infrastructure/models/discipline_model"
require_relative "../app/layers/infrastructure/models/grade_model"
require_relative "../app/layers/infrastructure/models/student_model"
require_relative "../app/layers/infrastructure/models/history_model"

Infrastructure::Models::StudentModel.insert_all([
  { name: "John Doe" },
  { name: "Jane Smith" }
])

Infrastructure::Models::DisciplineModel.insert_all!([
  { name: "Discipline 1", days_interval: 90 },
  { name: "Discipline 2", days_interval: 180 },
  { name: "Discipline 3", days_interval: nil },
  { name: "Discipline 4", days_interval: nil }
])

students = Infrastructure::Models::StudentModel.all
disciplines = Infrastructure::Models::DisciplineModel.all

Infrastructure::Models::GradeModel.insert_all([
  {
    student_id: students.first.id,
    discipline_id: disciplines[0].id,
    value: 75.4,
    created_at: Date.new(rand(2024..Date.today.year), rand(10..12), rand(1..28))
  },
  {
    student_id: students.first.id,
    discipline_id: disciplines[0].id,
    value: 40.4,
    created_at: Date.new(rand(2024..Date.today.year), rand(11..12), rand(1..28))
  },
  {
    student_id: students.first.id,
    discipline_id: disciplines[1].id,
    value: 70.6,
    created_at: Date.new(rand(2024..Date.today.year), rand(10..12), rand(1..28))
  },
  {
    student_id: students.first.id,
    discipline_id: disciplines[1].id,
    value: 43.45,
    created_at: Date.new(rand(2024..Date.today.year), rand(10..12), rand(1..28))
  },
  {
    student_id: students.first.id,
    discipline_id: disciplines[2].id,
    value: 90.0,
    created_at: Date.new(rand(2024..Date.today.year), rand(11..12), rand(1..28))
  },
  {
    student_id: students.first.id,
    discipline_id: disciplines[3].id,
    value: 65.8,
    created_at: Date.new(rand(2024..Date.today.year), rand(10..12), rand(1..28))
  },
  {
    student_id: students.last.id,
    discipline_id: disciplines[0].id,
    value: 60.2,
    created_at: Date.new(rand(2024..Date.today.year), rand(11..12), rand(1..28))
  },
  {
    student_id: students.last.id,
    discipline_id: disciplines[1].id,
    value: 80.2,
    created_at: Date.new(rand(2024..Date.today.year), rand(10..12), rand(1..28))
  },
  {
    student_id: students.last.id,
    discipline_id: disciplines[2].id,
    value: 88.4,
    created_at: Date.new(rand(2024..Date.today.year), rand(11..12), rand(1..28))
  },
  {
    student_id: students.last.id,
    discipline_id: disciplines[3].id,
    value: 88.1,
    created_at: Date.new(rand(2024..Date.today.year), rand(10..12), rand(1..28))
  }
])

Proc.new {
  students.each do |student|
    final_grades = []
    reference_date = Date.today
    disciplines.each do |discipline|
      if discipline.days_interval
        grades_in_interval = Infrastructure::Models::GradeModel
                                   .where(student_id: student.id, discipline_id: discipline.id)
                                   .where("created_at >= ?", reference_date - discipline.days_interval.days)
        if grades_in_interval.any?
          final_grades << grades_in_interval.average(:value).to_f
        else
          final_grades << 0.0
        end
      else
        last_grade = Infrastructure::Models::GradeModel
          .where(student_id: student.id, discipline_id: discipline.id)
          .order(created_at: :desc)
          .first
        final_grades << (last_grade ? last_grade.value : 0.0)
      end
    end
    Infrastructure::Models::HistoryModel.create!(
      student_id: student.id,
      reference_date: Date.new(2024, 11, 10),
      final_grade: (final_grades.sum / final_grades.size.to_f).to_f
    )
  end
}.call
